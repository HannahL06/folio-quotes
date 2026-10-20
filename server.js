require('dotenv').config();

var express = require('express');
var app = express();
var session = require('express-session');
var nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});
var db = require('./database');

app.set('view engine', 'pug');
app.use(express.static(__dirname + '/public'));
app.use(express.urlencoded({ extended: false }));
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
}));


// Page routes

// Home Page
app.get(['/', '/index'], (req, res) => {
    res.render('home', {
        title: 'About Us'
    });
});

// Folio Page
app.get('/folio', (req, res) => {
    if (!req.session.loggedIn) {
        res.redirect('/login');
        return;
    }
    db.getQuotes(req.query.search, req.session.userId, res);
});

// Featured Quotes Page
app.get('/featured', (req, res) =>{
    db.getDailyQuote(res);
});

// Login Page
app.get('/login', (req, res) => {
    var loggedIn = !!req.session.loggedIn;
    res.render('login', {
        title: 'Login',
        message: loggedIn ? 'Welcome, ' + req.session.username + '!' : null,
        loggedIn: loggedIn
    });
});

app.post('/loginResponse', (req, res) => {
    db.validateLogin(req.body.username, req.body.password, req, res);
});

// Logout
app.post('/logout', (req, res) => {
    req.session.destroy(function() {
        res.redirect('/accounts');
    });
});

// Add Quote Form
app.get('/quoteForm', (req, res) => {
    db.getQuoteTypesAndGenres(res);
});

app.post('/addQuote', (req, res) => {
    db.addQuote(req.body, req.session.userId, res);
});

// Confirmation Page
app.get('/confirmation', (req, res) => {
    db.getQuoteById(req.query.quote_id, res);
});

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

const server = app.listen(3000, () => {
    console.log('Express running on http://localhost:3000');
});