# Folio

A place to collect the lines worth remembering. Save quotes from books, songs, speeches and everyday life, then search, share and rediscover them.

## What you can do

- **Create an account** and keep your own private collection of quotes.
- **Add, edit and delete quotes**, each tagged with a type (book, poem, speech...), a genre and a source.
- **Search, filter and sort** your quotes by text, type, genre, or newest and oldest.
- **Post a quote** to the public Browse page so anyone can read it.
- **Like quotes** and **save other people's quotes** into your own collection.
- **See a daily quote** on the Featured page, plus one picked from your own collection when you're logged in.
- **Contact the site owner** through a simple form.

## Built with

- Node.js and Express for the server
- Pug templates for the pages
- MySQL for the database
- bcrypt for password hashing, with login sessions kept by express-session
- Jest and Supertest for tests
- Plain CSS, with Cormorant Garamond and EB Garamond for the type

## Run it on your computer

You'll need [Node.js](https://nodejs.org/) 18 or newer and a MySQL (or MariaDB) server. XAMPP works well on Windows.

1. **Install the project**
   ```bash
   git clone https://github.com/HannahL06/folio-quotes.git
   cd folio-quotes
   npm install
   ```

2. **Create the database** and load the starter data:
   ```bash
   mysql -u root -e "CREATE DATABASE folio;"
   mysql -u root folio < folio.sql
   ```

3. **Add your settings.** Copy `.env.example` to `.env` and fill it in. The defaults already work for a local MySQL with no password. You only need real values for `SESSION_SECRET` (any long random text) and, if you want the contact form to send email, the Gmail details.

4. **Start it**
   ```bash
   npm start
   ```
   Then open http://localhost:3000.

**Demo accounts** are included so you can look around right away. The usernames and passwords are listed in a comment near the top of `folio.sql`. You can also create your own account from the sign-up page.

## Run the tests

```bash
npm test
```

The tests use their own database called `folio_test`, which is rebuilt from `folio.sql` each run, so your real data is never touched. This needs the same MySQL server running.

## Put it online

Folio needs somewhere to run the app and somewhere to host a MySQL database. Two common setups:

- **Railway:** runs the app and the database together in one project. Simplest, but it's pay-as-you-go after a small trial credit.
- **Render (app) plus a separate free MySQL host** such as TiDB Cloud: free, but the app falls asleep when idle and takes a few seconds to wake up.

Steps for either one:

1. Create the MySQL database and import `folio.sql` into it.
2. Create the web service from this GitHub repo. The build command is `npm install` and the start command is `npm start`.
3. Add these settings in the service's environment variables:

   | Setting | What it's for |
   |---|---|
   | `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` | How to reach your database |
   | `DB_SSL` | Set to `true` if your database host requires an encrypted connection |
   | `SESSION_SECRET` | Any long random text. Keep it private. |
   | `NODE_ENV` | Set to `production` |
   | `EMAIL_USER`, `EMAIL_PASS`, `CONTACT_TO_EMAIL` | Optional. Only needed for the contact form. |

A few things to know:

- Some hosts only allow encrypted database connections. `DB_SSL=true` works with hosts that use a standard certificate (TiDB Cloud does). Hosts that give you their own certificate file, like Aiven, aren't supported yet.
- People get logged out whenever the app restarts, because sessions are kept in memory.
- Free hosts often block the email service the contact form uses, so that form may not send on a free plan.
- The demo accounts are public. Don't reuse their passwords anywhere else.

## How the code is laid out

```
server.js      The app: pages, routes and login handling
database.js    Every database query lives here
folio.sql      Database tables and starter data
views/         The page templates (Pug)
public/        Stylesheet and images
tests/         Automated tests
```
