# Folio

A place to collect the lines worth remembering. Folio is a full-stack Express app for saving, organizing, and searching quotes from books, songs, speeches, and everywhere else a good line turns up.

## Features

- **Accounts** — register, log in, and log out with bcrypt-hashed passwords and session-based auth.
- **My Quotes** — add, edit, and delete your own quotes, each tagged with a type, genre, source, and how you found it.
- **Browse** — a public feed of every quote posted to Folio. Like a post, or "Folio" it to save your own copy into your personal collection.
- **My Posts** — manage which of your quotes are published to the public Browse feed, independent of your private collection.
- **Search, filter, and sort** — search by text/source/tag, filter by type or genre, and sort newest/oldest/alphabetically/most-liked.
- **Featured quotes** — a daily-quote feed pulled from a separate curated table.
- **Contact form** — sends a message to the site owner via Nodemailer/Gmail.

## Tech stack

- [Express](https://expressjs.com/) 5
- [Pug](https://pugjs.org/) templates, server-rendered
- [MySQL](https://www.mysql.com/) via [mysql2](https://github.com/sidorares/node-mysql2) (promise/async-await API)
- [bcrypt](https://github.com/kelektiv/node.bcrypt.js) for password hashing
- [express-session](https://github.com/expressjs/session) for auth state
- Vanilla CSS (custom properties, no framework) with [Fraunces](https://fonts.google.com/specimen/Fraunces) + [Inter](https://fonts.google.com/specimen/Inter) from Google Fonts

## Getting started

### Prerequisites

- [Node.js](https://nodejs.org/) 18+
- A running MySQL (or MariaDB) server

### Setup

1. **Clone and install dependencies**

   ```bash
   git clone https://github.com/HannahL06/folio-quotes.git
   cd folio-quotes
   npm install
   ```

2. **Create the database**

   Create a database (default name `folio`) and import the schema + seed data:

   ```bash
   mysql -u root -e "CREATE DATABASE folio;"
   mysql -u root folio < folio.sql
   ```

3. **Configure environment variables**

   Copy `.env.example` to `.env` and fill in your own values:

   ```bash
   cp .env.example .env
   ```

   | Variable | Description |
   |---|---|
   | `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` | MySQL connection details |
   | `SESSION_SECRET` | Any long random string, used to sign session cookies |
   | `EMAIL_USER`, `EMAIL_PASS` | A Gmail address and [app password](https://support.google.com/accounts/answer/185833) for sending contact-form emails (optional — the contact form will just fail to send without it) |
   | `CONTACT_TO_EMAIL` | Where contact-form messages get delivered |
   | `PORT` | Port to run the server on (defaults to 3000) |

4. **Run it**

   ```bash
   npm start
   ```

   Visit `http://localhost:3000`.

> **Note:** if you have an older copy of this database (from before Browse/posts/likes existed), drop and recreate it from the current `folio.sql` — the schema has since gained `posts` and `likes` tables and a new column on `quotes`.

### Demo logins

`folio.sql` seeds a few demo accounts (see the comment above the `authorizedusers` insert for plaintext passwords) — or just register a new account from `/register`.

## Project structure

```
server.js       Express app, routes, middleware
database.js     Data access layer (mysql2 pool, all SQL lives here)
folio.sql       Database schema + seed data
views/          Pug templates
public/         Static assets (CSS, images)
```
