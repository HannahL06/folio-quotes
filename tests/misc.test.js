const request = require('supertest');
const { app, registerAndLogin } = require('./helpers/testClient');

describe('Accounts page', () => {
    test('prompts to log in when logged out', async () => {
        var res = await request(app).get('/accounts');
        expect(res.status).toBe(200);
        expect(res.text).toContain('must log in');
    });

    test('shows the username when logged in', async () => {
        var { agent, username } = await registerAndLogin('accountsview');
        var res = await agent.get('/accounts');
        expect(res.text).toContain('Hello, ' + username);
    });
});

describe('Contact page', () => {
    // Only the GET route is tested here - the POST route calls out to Gmail
    // via Nodemailer, and hitting a real external service in tests would be
    // slow and flaky regardless of outcome.
    test('renders the contact form', async () => {
        var res = await request(app).get('/contact');
        expect(res.status).toBe(200);
        expect(res.text).toContain('Message');
    });
});

describe('Confirmation page', () => {
    test('requires login', async () => {
        var res = await request(app).get('/confirmation?quote_id=1');
        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/login');
    });

    test('redirects to /folio for a quote id that does not belong to you, instead of leaking it', async () => {
        var { agent } = await registerAndLogin('confirmleak');
        var res = await agent.get('/confirmation?quote_id=99999999');
        expect(res.status).toBe(302);
        expect(res.headers.location).toBe('/folio');
    });
});

describe('Unknown routes', () => {
    test('return a 404 instead of being swallowed by the error handler', async () => {
        var res = await request(app).get('/this-route-does-not-exist');
        expect(res.status).toBe(404);
    });
});
