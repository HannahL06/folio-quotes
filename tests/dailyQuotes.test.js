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

describe('Featured Quotes page', () => {
    test('shows a site-wide quote to logged-out visitors, with no personal section', async () => {
        var res = await request(app).get('/featured');
        expect(res.status).toBe(200);
        expect(res.text).toContain('Featured Quotes');
        expect(res.text).not.toContain('Your Quote of the Day');
    });

    test('a logged-in user with no quotes sees a prompt to add their first one', async () => {
        var { agent } = await registerAndLogin('featurednone');
        var res = await agent.get('/featured');

        expect(res.text).toContain('Your Quote of the Day');
        expect(res.text).toContain("don't have any quotes yet");
    });

    test('a logged-in user with quotes sees one of their own, with its added date', async () => {
        var { agent } = await registerAndLogin('featuredmine');
        await agent.post('/addQuote').type('form').send(addQuoteBody({ quoteText: 'My own featured line' }));

        var res = await agent.get('/featured');
        expect(res.text).toContain('Your Quote of the Day');
        expect(res.text).toContain('My own featured line');
        expect(res.text).toContain('Added on');
    });
});

describe('Home page', () => {
    test('renders for logged-out visitors', async () => {
        var res = await request(app).get('/');
        expect(res.status).toBe(200);
        expect(res.text).toContain('What lines will you keep today?');
    });

    test('swaps the hero CTA when logged in', async () => {
        var { agent } = await registerAndLogin('homecta');
        var res = await agent.get('/');
        expect(res.text).toContain('Go to Your Folio');
    });
});
