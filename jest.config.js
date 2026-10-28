module.exports = {
    testEnvironment: 'node',
    testMatch: ['<rootDir>/tests/**/*.test.js'],
    setupFiles: ['<rootDir>/tests/setup/loadTestEnv.js'],
    setupFilesAfterEnv: ['<rootDir>/tests/setup/closeDb.js'],
    globalSetup: '<rootDir>/tests/setup/globalSetup.js',
    maxWorkers: 1,
    testTimeout: 15000
};
