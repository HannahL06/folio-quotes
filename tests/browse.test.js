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

describe('Browse', () => {
    test('is viewable without logging in', async () => {
        var res = await request(app).get('/browse');
        expect(res.status).toBe(200);
        expect(res.text).toContain('Browse Quotes');
    });

    test('only shows quotes that have actually been posted, not every quote in the DB', async () => {
        var { agent } = await registerAndLogin('browsescope');
        await createQuote(agent, 'This quote stays private forever');

        var res = await request(app).get('/browse?search=stays private forever');
        expect(res.text).not.toContain('This quote stays private forever');
    });

    test('a quote appears on Browse once it has been explicitly posted', async () => {
        var { agent } = await registerAndLogin('browsepost');
        var quoteId = await createQuote(agent, 'Now everyone can see this one');

        await agent.post('/post/' + quoteId);

        var res = await request(app).get('/browse?search=Now everyone can see this one');
        expect(res.text).toContain('Now everyone can see this one');
    });

    test('search filter narrows results', async () => {
        var { agent } = await registerAndLogin('browsesearch');
        var quoteId = await createQuote(agent, 'The findable browse quote');
        await agent.post('/post/' + quoteId);

        var hit = await request(app).get('/browse?search=findable browse');
        expect(hit.text).toContain('The findable browse quote');

        var miss = await request(app).get('/browse?search=nothing-matches-this-xyz');
        expect(miss.text).not.toContain('The findable browse quote');
    });
});
