require('dotenv').config();

var express = require('express');
var app = express();
var session = require('express-session');
var nodemailer = require('nodemailer');
var db = require('./database');

var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

app.set('view engine', 'pug');
app.use(express.static(__dirname + '/public'));
app.use(express.urlencoded({ extended: false }));
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}));

// Wraps an async route handler so rejected promises reach Express's error handler
// instead of crashing the process.
function asyncHandler(fn) {
    return function(req, res, next) {
        fn(req, res, next).catch(next);
    };
}

function requireLogin(req, res, next) {
    if (!req.session.loggedIn) {
        res.redirect('/login');
        return;
    }
    next();
}


// Page routes

// Home Page
app.get(['/', '/index'], asyncHandler(async (req, res) => {
    var dailyQuotes = await db.getDailyQuote();
    res.render('home', {
        title: 'About Us',
        loggedIn: !!req.session.loggedIn,
        featuredQuote: dailyQuotes[0] || null
    });
}));

// Folio Page
app.get('/folio', requireLogin, asyncHandler(async (req, res) => {
    var filters = {
        search: req.query.search,
        type: req.query.type,
        genre: req.query.genre,
        sort: req.query.sort
    };
    var quotes = await db.getQuotes(filters, req.session.userId);
    var typesAndGenres = await db.getQuoteTypesAndGenres();
    res.render('folio', {
        title: 'Folio',
        quotes: quotes,
        filters: filters,
        quoteTypes: typesAndGenres.types,
        quoteGenres: typesAndGenres.genres
    });
}));

// Browse Page - public feed of every user's posted quotes
app.get('/browse', asyncHandler(async (req, res) => {
    var filters = {
        search: req.query.search,
        type: req.query.type,
        genre: req.query.genre,
        sort: req.query.sort
    };
    var posts = await db.getPosts(filters, req.session.userId || null);
    var typesAndGenres = await db.getQuoteTypesAndGenres();
    res.render('browse', {
        title: 'Browse Quotes',
        loggedIn: !!req.session.loggedIn,
        posts: posts,
        filters: filters,
        quoteTypes: typesAndGenres.types,
        quoteGenres: typesAndGenres.genres
    });
}));

// My Posts Page - quotes the current user has published to Browse
app.get('/myPosts', requireLogin, asyncHandler(async (req, res) => {
    var posts = await db.getMyPosts(req.session.userId);
    res.render('myPosts', {
        title: 'My Posts',
        loggedIn: true,
        posts: posts
    });
}));

app.post('/post/:quoteId', requireLogin, asyncHandler(async (req, res) => {
    try {
        await db.postQuote(req.params.quoteId, req.session.userId);
    } catch (err) {
        if (!err.isUserError) {
            throw err;
        }
    }
    res.redirect('/folio');
}));

app.post('/unpost/:postId', requireLogin, asyncHandler(async (req, res) => {
    await db.unpostQuote(req.params.postId, req.session.userId);
    res.redirect('/myPosts');
}));

app.post('/like/:postId', requireLogin, asyncHandler(async (req, res) => {
    await db.toggleLike(req.params.postId, req.session.userId);
    res.redirect('/browse');
}));

app.post('/foliate/:postId', requireLogin, asyncHandler(async (req, res) => {
    try {
        await db.foliatePost(req.params.postId, req.session.userId);
    } catch (err) {
        if (!err.isUserError) {
            throw err;
        }
    }
    res.redirect('/browse');
}));

// Featured Quotes Page
app.get('/featured', asyncHandler(async (req, res) => {
    var dailyQuotes = await db.getDailyQuote();
    var myDailyQuote = req.session.loggedIn ? await db.getUserDailyQuote(req.session.userId) : null;
    res.render('featured', {
        title: 'Daily Feed',
        loggedIn: !!req.session.loggedIn,
        dailyQuotes: dailyQuotes,
        myDailyQuote: myDailyQuote
    });
}));

// Login Page
app.get('/login', (req, res) => {
    var loggedIn = !!req.session.loggedIn;
    res.render('login', {
        title: 'Login',
        message: loggedIn ? 'Welcome, ' + req.session.username + '!' : null,
        loggedIn: loggedIn
    });
});

app.post('/loginResponse', asyncHandler(async (req, res) => {
    var user = await db.validateLogin(req.body.username, req.body.password);

    if (user) {
        req.session.loggedIn = true;
        req.session.userId = user.userId;
        req.session.username = user.username;
        res.render('login', {
            title: 'Login',
            message: 'Welcome, ' + user.username + '!',
            loggedIn: true
        });
    } else {
        req.session.loggedIn = false;
        res.render('login', {
            title: 'Login',
            message: 'Error: invalid username or password.',
            loggedIn: false
        });
    }
}));

// Registration Page
app.get('/register', (req, res) => {
    res.render('register', {
        title: 'Create Account',
        error: null,
        formData: {}
    });
});

app.post('/register', asyncHandler(async (req, res) => {
    var formData = req.body;

    if (!formData.username || !formData.password) {
        res.render('register', {
            title: 'Create Account',
            error: 'Username and password are required.',
            formData: formData
        });
        return;
    }

    try {
        var user = await db.registerUser(formData);
        req.session.loggedIn = true;
        req.session.userId = user.userId;
        req.session.username = user.username;
        res.redirect('/folio');
    } catch (err) {
        if (err.isUserError) {
            res.render('register', {
                title: 'Create Account',
                error: err.message,
                formData: formData
            });
            return;
        }
        throw err;
    }
}));

// Logout
app.post('/logout', (req, res) => {
    req.session.destroy(function() {
        res.redirect('/accounts');
    });
});

// Add/Edit Quote Form
app.get('/quoteForm', requireLogin, asyncHandler(async (req, res) => {
    var typesAndGenres = await db.getQuoteTypesAndGenres();
    var editQuote = null;

    if (req.query.edit) {
        editQuote = await db.getQuoteForEdit(req.query.edit, req.session.userId);
        if (!editQuote) {
            res.redirect('/folio');
            return;
        }
    }

    res.render('quoteForm', {
        title: editQuote ? 'Edit Quote' : 'Add Quote',
        quoteTypes: typesAndGenres.types,
        quoteGenres: typesAndGenres.genres,
        editQuote: editQuote
    });
}));

app.post('/addQuote', requireLogin, asyncHandler(async (req, res) => {
    var quoteId = await db.addQuote(req.body, req.session.userId);
    res.redirect('/confirmation?quote_id=' + quoteId);
}));

app.post('/editQuote/:id', requireLogin, asyncHandler(async (req, res) => {
    var updated = await db.editQuote(req.params.id, req.body, req.session.userId);
    if (!updated) {
        res.redirect('/folio');
        return;
    }
    res.redirect('/confirmation?quote_id=' + req.params.id);
}));

app.post('/deleteQuote/:id', requireLogin, asyncHandler(async (req, res) => {
    await db.deleteQuote(req.params.id, req.session.userId);
    res.redirect('/folio');
}));

// Confirmation Page
app.get('/confirmation', requireLogin, asyncHandler(async (req, res) => {
    var quote = await db.getQuoteById(req.query.quote_id, req.session.userId);
    if (!quote) {
        res.redirect('/folio');
        return;
    }
    res.render('confirmation', {
        title: 'Confirmation',
        quote: quote
    });
}));

// Accounts page
app.get('/accounts', (req, res) => {
    res.render('accounts', {
        title: 'Accounts',
        loggedIn: !!req.session.loggedIn,
        username: req.session.username
    });
});

// Contact Page
app.get('/contact', (req, res) => {
    res.render('contact', {
        title: 'Contact',
        message: null
    });
});

// Contact email logic
app.post('/contact', (req, res) => {
    var firstName = req.body.firstName;
    var lastName = req.body.lastName;
    var email = req.body.email;
    var emailBody = req.body.emailBody;

    transporter.sendMail({
        from: process.env.EMAIL_USER,
        to: process.env.CONTACT_TO_EMAIL,
        subject: 'Contact Message From Folio User ' + firstName + ' ' + lastName,
        text: 'Email: ' + email +
              ' Name: ' + firstName + ' ' + lastName +
              ' Message: ' + emailBody
    }, function(err) {
        res.render('contact', {
            title: 'Contact',
            message: err ? 'Error: could not send message.' : 'Message sent!'
        });
    });
});

// Error handler - keeps unexpected failures (e.g. DB errors) from crashing the server
app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).render('error', {
        title: 'Something Went Wrong',
        message: 'Sorry, something went wrong on our end. Please try again.'
    });
});

// Only start listening when run directly (node server.js / npm start) - tests
// import `app` and drive it with supertest without binding a real port.
if (require.main === module) {
    var PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
        console.log('Express running on http://localhost:' + PORT);
    });
}

module.exports = app;
