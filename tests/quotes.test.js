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

describe('My Quotes - access control', () => {
    test('GET /folio without login redirects to /login', async () => {
        var res = await request(app).get('/folio');
        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/login');
    });

    test('GET /quoteForm without login redirects to /login', async () => {
        var res = await request(app).get('/quoteForm');
        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/login');
    });
});

describe('My Quotes - add / view', () => {
    test('adding a quote redirects to confirmation and then shows up in /folio', async () => {
        var { agent } = await registerAndLogin('addq');

        var addRes = await agent.post('/addQuote').type('form').send(addQuoteBody());
        expect(addRes.status).toBe(302);
        expect(addRes.headers.location).toMatch(/^\/confirmation\?quote_id=\d+$/);

        var confirmRes = await agent.get(addRes.headers.location);
        expect(confirmRes.status).toBe(200);
        expect(confirmRes.text).toContain('A quote worth keeping');

        var folioRes = await agent.get('/folio');
        expect(folioRes.text).toContain('A quote worth keeping');
    });

    test('search filter only returns matching quotes', async () => {
        var { agent } = await registerAndLogin('searchq');
        await agent.post('/addQuote').type('form').send(addQuoteBody({ quoteText: 'The unmistakable needle' }));
        await agent.post('/addQuote').type('form').send(addQuoteBody({ quoteText: 'Something else entirely' }));

        var res = await agent.get('/folio?search=unmistakable');
        expect(res.text).toContain('The unmistakable needle');
        expect(res.text).not.toContain('Something else entirely');
    });
});

describe('My Quotes - edit / delete ownership', () => {
    async function createQuote(agent, text) {
        var addRes = await agent.post('/addQuote').type('form').send(addQuoteBody({ quoteText: text }));
        var match = addRes.headers.location.match(/quote_id=(\d+)/);
        return Number(match[1]);
    }

    test('the owner can edit their own quote', async () => {
        var { agent } = await registerAndLogin('editowner');
        var quoteId = await createQuote(agent, 'Original text');

        var editRes = await agent.post('/editQuote/' + quoteId).type('form').send(
            addQuoteBody({ quoteText: 'Edited text' })
        );
        expect(editRes.status).toBe(302);

        var folioRes = await agent.get('/folio');
        expect(folioRes.text).toContain('Edited text');
        expect(folioRes.text).not.toContain('Original text');
    });

    test('a different user cannot edit someone else\'s quote', async () => {
        var owner = await registerAndLogin('editvictim');
        var quoteId = await createQuote(owner.agent, 'Do not touch this');

        var attacker = await registerAndLogin('editattacker');
        await attacker.agent.post('/editQuote/' + quoteId).type('form').send(
            addQuoteBody({ quoteText: 'Hijacked text' })
        );

        var ownerFolio = await owner.agent.get('/folio');
        expect(ownerFolio.text).toContain('Do not touch this');
        expect(ownerFolio.text).not.toContain('Hijacked text');
    });

    test('the owner can delete their own quote', async () => {
        var { agent } = await registerAndLogin('deleteowner');
        var quoteId = await createQuote(agent, 'Delete me please');

        await agent.post('/deleteQuote/' + quoteId);

        var folioRes = await agent.get('/folio');
        expect(folioRes.text).not.toContain('Delete me please');
    });

    test('a different user cannot delete someone else\'s quote', async () => {
        var owner = await registerAndLogin('deletevictim');
        var quoteId = await createQuote(owner.agent, 'Protected quote');

        var attacker = await registerAndLogin('deleteattacker');
        await attacker.agent.post('/deleteQuote/' + quoteId);

        var ownerFolio = await owner.agent.get('/folio');
        expect(ownerFolio.text).toContain('Protected quote');
    });

    test('GET /quoteForm?edit= for a quote you do not own redirects to /folio instead of leaking it', async () => {
        var owner = await registerAndLogin('editformvictim');
        var quoteId = await createQuote(owner.agent, 'Not yours to edit');

        var attacker = await registerAndLogin('editformattacker');
        var res = await attacker.agent.get('/quoteForm?edit=' + quoteId);

        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/folio');
    });

    test('GET /quoteForm?edit= for a nonexistent quote redirects instead of crashing', async () => {
        var { agent } = await registerAndLogin('editformmissing');
        var res = await agent.get('/quoteForm?edit=99999999');
        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/folio');
    });
});
