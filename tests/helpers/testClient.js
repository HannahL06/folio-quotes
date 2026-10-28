const request = require('supertest');
const app = require('../../server');

var counter = 0;

// Each test file gets its own module registry, so a per-process counter is
// enough to keep usernames unique within a file; combining with Date.now()
// keeps them unique across files too, since the DB is only reset once per run.
function uniqueUsername(prefix) {
    counter += 1;
    return prefix + '_' + Date.now() + '_' + counter;
}

async function registerAndLogin(prefix) {
    var agent = request.agent(app);
    var username = uniqueUsername(prefix);

    var res = await agent.post('/register').type('form').send({
        firstName: 'Test',
        lastName: 'User',
        email: username + '@example.com',
        username: username,
        password: 'testpass123'
    });

    return { agent: agent, username: username, registerRes: res };
}

module.exports = { app, uniqueUsername, registerAndLogin };
