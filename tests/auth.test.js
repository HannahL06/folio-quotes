const request = require('supertest');
const { app, uniqueUsername, registerAndLogin } = require('./helpers/testClient');

describe('Registration', () => {
    test('GET /register renders the form', async () => {
        var res = await request(app).get('/register');
        expect(res.status).toBe(200);
        expect(res.text).toContain('Create Account');
    });

    test('POST /register with valid data creates an account, logs in, and redirects to /folio', async () => {
        var { registerRes, agent } = await registerAndLogin('reg');
        expect(registerRes.status).toBe(302);
        expect(registerRes.headers.location).toBe('/folio');

        var folioRes = await agent.get('/folio');
        expect(folioRes.status).toBe(200);
    });

    test('POST /register with a duplicate username is rejected', async () => {
        var username = uniqueUsername('dup');
        var agent = request.agent(app);

        await agent.post('/register').type('form').send({
            firstName: 'First',
            lastName: 'User',
            email: username + '@example.com',
            username: username,
            password: 'testpass123'
        });

        var secondAgent = request.agent(app);
        var res = await secondAgent.post('/register').type('form').send({
            firstName: 'Second',
            lastName: 'User',
            email: 'other_' + username + '@example.com',
            username: username,
            password: 'differentpassword'
        });

        expect(res.status).toBe(200);
        expect(res.text).toContain('already taken');
    });

    test('POST /register with no username/password shows a validation error', async () => {
        var res = await request(app).post('/register').type('form').send({
            firstName: 'No',
            lastName: 'Credentials',
            email: 'nocreds@example.com'
        });

        expect(res.status).toBe(200);
        expect(res.text).toContain('required');
    });
});

describe('Login / logout', () => {
    test('GET /login renders the form', async () => {
        var res = await request(app).get('/login');
        expect(res.status).toBe(200);
        expect(res.text).toContain('Login');
    });

    test('valid credentials log the user in', async () => {
        var username = uniqueUsername('loginok');
        var agent = request.agent(app);
        await agent.post('/register').type('form').send({
            firstName: 'Login',
            lastName: 'Test',
            email: username + '@example.com',
            username: username,
            password: 'correcthorse'
        });
        await agent.post('/logout');

        var res = await agent.post('/loginResponse').type('form').send({
            username: username,
            password: 'correcthorse'
        });

        expect(res.status).toBe(200);
        expect(res.text).toContain('Welcome, ' + username);
    });

    test('invalid credentials are rejected without crashing', async () => {
        var res = await request(app).post('/loginResponse').type('form').send({
            username: 'nobody-with-this-name',
            password: 'wrongpassword'
        });

        expect(res.status).toBe(200);
        expect(res.text).toContain('invalid username or password');
    });

    test('logout ends the session - protected pages redirect to login again', async () => {
        var { agent } = await registerAndLogin('logout');

        var beforeLogout = await agent.get('/folio');
        expect(beforeLogout.status).toBe(200);

        await agent.post('/logout');

        var afterLogout = await agent.get('/folio');
        expect(afterLogout.status).toBe(302);
        expect(afterLogout.headers.location).toBe('/login');
    });
});
