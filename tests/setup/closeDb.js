// Runs once per test file, after the test framework loads - registers a hook
// that closes that file's own DB pool when its tests finish, so Jest can exit
// cleanly instead of hanging on an open connection pool.
const db = require('../../database');

afterAll(async () => {
    await db.closePool();
});
