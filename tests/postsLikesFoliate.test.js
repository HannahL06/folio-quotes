const request = require('supertest');
const { app, registerAndLogin } = require('./helpers/testClient');

function addQuoteBody(overrides) {
    return Object.assign({
        quoteText: 'A quote worth keeping',
        quoteSource: 'Someone Wise',
        quoteTypeOptions: '1',
        quoteGenreOptions: '1',
        foundBy: 'Found Myself',
        tag: 'testing'
    }, overrides || {});
}

async function createQuote(agent, text) {
    var addRes = await agent.post('/addQuote').type('form').send(addQuoteBody({ quoteText: text }));
    var match = addRes.headers.location.match(/quote_id=(\d+)/);
    return Number(match[1]);
}

describe('Posting', () => {
    test('posting your own quote makes it appear in /myPosts', async () => {
        var { agent } = await registerAndLogin('postmine');
        var quoteId = await createQuote(agent, 'My very own post');

        await agent.post('/post/' + quoteId);

        var res = await agent.get('/myPosts');
        expect(res.text).toContain('My very own post');
    });

    // Regression test: /post/:quoteId originally didn't verify the quote
    // belonged to the poster, letting anyone POST a stranger's quoteId and
    // get attributed as the poster. Fixed in database.js's postQuote().
    test('posting a quote you do not own is rejected, not silently attributed to you', async () => {
        var owner = await registerAndLogin('postvictim');
        var quoteId = await createQuote(owner.agent, 'Someone else owns this quote');

        var attacker = await registerAndLogin('postattacker');
        await attacker.agent.post('/post/' + quoteId);

        var attackerPosts = await attacker.agent.get('/myPosts');
        expect(attackerPosts.text).not.toContain('Someone else owns this quote');

        var browseRes = await request(app).get('/browse?search=Someone else owns this quote');
        expect(browseRes.text).not.toContain(attacker.username);
    });

    test('posting the same quote twice does not create duplicate posts', async () => {
        var { agent } = await registerAndLogin('postdup');
        var quoteId = await createQuote(agent, 'Posted exactly once');

        await agent.post('/post/' + quoteId);
        await agent.post('/post/' + quoteId);

        var res = await agent.get('/myPosts');
        var occurrences = res.text.split('Posted exactly once').length - 1;
        expect(occurrences).toBe(1);
    });

    test('unposting removes it from Browse/My Posts without deleting the quote from My Quotes', async () => {
        var { agent } = await registerAndLogin('unpost');
        var quoteId = await createQuote(agent, 'Here today gone from browse tomorrow');
        var postRes = await agent.post('/post/' + quoteId);
        expect(postRes.status).toBe(302);

        var myPostsBefore = await agent.get('/myPosts');
        var postIdMatch = myPostsBefore.text.match(/\/unpost\/(\d+)/);
        expect(postIdMatch).not.toBeNull();
        var postId = postIdMatch[1];

        await agent.post('/unpost/' + postId);

        var myPostsAfter = await agent.get('/myPosts');
        expect(myPostsAfter.text).not.toContain('Here today gone from browse tomorrow');

        var folioRes = await agent.get('/folio');
        expect(folioRes.text).toContain('Here today gone from browse tomorrow');
    });
});

describe('Likes', () => {
    test('liking a post increments the count, liking again un-likes it', async () => {
        var poster = await registerAndLogin('likeposter');
        var quoteId = await createQuote(poster.agent, 'A very likeable quote');
        await poster.agent.post('/post/' + quoteId);

        var liker = await registerAndLogin('liker');
        var browseBefore = await liker.agent.get('/browse?search=A very likeable quote');
        var postIdMatch = browseBefore.text.match(/\/like\/(\d+)/);
        expect(postIdMatch).not.toBeNull();
        var postId = postIdMatch[1];

        await liker.agent.post('/like/' + postId);
        var afterLike = await liker.agent.get('/browse?search=A very likeable quote');
        expect(afterLike.text).toMatch(/heart_count">1</);

        await liker.agent.post('/like/' + postId);
        var afterUnlike = await liker.agent.get('/browse?search=A very likeable quote');
        expect(afterUnlike.text).toMatch(/heart_count">0</);
    });
});

describe('Foliate (saving someone else\'s post into your own collection)', () => {
    async function findPostId(agent, searchText) {
        var res = await agent.get('/browse?search=' + encodeURIComponent(searchText));
        var match = res.text.match(/\/foliate\/(\d+)/);
        return match ? match[1] : null;
    }

    test('folio-ing a stranger\'s post copies it into your own My Quotes', async () => {
        var owner = await registerAndLogin('foliateowner');
        var quoteId = await createQuote(owner.agent, 'Worth saving to your own folio');
        await owner.agent.post('/post/' + quoteId);

        var saver = await registerAndLogin('foliatesaver');
        var postId = await findPostId(saver.agent, 'Worth saving to your own folio');
        expect(postId).not.toBeNull();

        await saver.agent.post('/foliate/' + postId);

        var saverFolio = await saver.agent.get('/folio');
        expect(saverFolio.text).toContain('Worth saving to your own folio');
    });

    test('folio-ing your own post is a no-op, not a duplicate', async () => {
        var owner = await registerAndLogin('foliateself');
        var quoteId = await createQuote(owner.agent, 'My own quote, posted by me');
        var postRes = await owner.agent.post('/post/' + quoteId);
        expect(postRes.status).toBe(302);

        var postId = await findPostId(owner.agent, 'My own quote, posted by me');
        await owner.agent.post('/foliate/' + postId);

        var folioRes = await owner.agent.get('/folio');
        var occurrences = folioRes.text.split('My own quote, posted by me').length - 1;
        expect(occurrences).toBe(1);
    });

    test('folio-ing the same post twice only creates one copy', async () => {
        var owner = await registerAndLogin('foliatetwiceowner');
        var quoteId = await createQuote(owner.agent, 'Only one copy should land here');
        await owner.agent.post('/post/' + quoteId);

        var saver = await registerAndLogin('foliatetwicesaver');
        var postId = await findPostId(saver.agent, 'Only one copy should land here');

        await saver.agent.post('/foliate/' + postId);
        await saver.agent.post('/foliate/' + postId);

        var saverFolio = await saver.agent.get('/folio');
        var occurrences = saverFolio.text.split('Only one copy should land here').length - 1;
        expect(occurrences).toBe(1);
    });
});
