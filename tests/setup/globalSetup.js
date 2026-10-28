// Runs once, in its own process, before any test file loads. Rebuilds the
// test database from scratch so every test run starts from the same known
// seed data (folio.sql) - no dependency on the dev DB's current state.
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');

require('dotenv').config({ path: path.join(__dirname, '../../.env.test') });

module.exports = async function globalSetup() {
    var dbName = process.env.DB_NAME;

    var serverConn = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        multipleStatements: true
    });
    await serverConn.query('DROP DATABASE IF EXISTS `' + dbName + '`; CREATE DATABASE `' + dbName + '`;');
    await serverConn.end();

    var dbConn = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: dbName,
        multipleStatements: true
    });
    var schemaSql = fs.readFileSync(path.join(__dirname, '../../folio.sql'), 'utf8');
    await dbConn.query(schemaSql);
    await dbConn.end();
};
