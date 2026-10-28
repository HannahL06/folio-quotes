// Runs inside each test file's own environment, before the test framework and
// test code load - this is what makes database.js (which reads process.env at
// require time) connect to the test database instead of the dev one.
require('dotenv').config({ path: require('path').join(__dirname, '../../.env.test') });
