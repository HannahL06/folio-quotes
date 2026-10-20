var mysql = require('mysql');

function createConnection() {
    return mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    });
}

function validateLogin(username, password, req, res) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT user_id, username FROM authorizedusers WHERE username = ? AND password = ?";
        con.query(sql, [username, password], function(err, result, fields) {
            if (err) throw err;
            con.end();

            if (result.length > 0) {
                req.session.loggedIn = true;
                req.session.userId = result[0].user_id;
                req.session.username = result[0].username;
                res.render('login', {
                    title: 'Login',
                    message: 'Welcome, ' + req.session.username + '!',
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
        });
    });
}

function getQuotes(search, userId, res) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT quote_text, source, type, genre, tag, created_at " +
                   "FROM quotes " +
                   "JOIN authorizedusers ON quotes.user = authorizedusers.user_id " +
                   "JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id " +
                   "JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id " +
                   "WHERE quotes.user = ?";
        var values = [userId];

        if (search) {
            sql += " AND (quote_text LIKE ? OR source LIKE ? OR type LIKE ? OR genre LIKE ? OR tag LIKE ?)";
            var likeSearch = '%' + search + '%';
            values.push(likeSearch, likeSearch, likeSearch, likeSearch, likeSearch);
        }

        con.query(sql, values, function(err, result, fields) {
            if (err) throw err;
            con.end();
            res.render('folio', {
                title: 'Folio',
                quotes: result,
                search: search
            });
        });
    });
}

function getQuoteTypesAndGenres(res, renderExtra) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        con.query("SELECT quote_type_id, type FROM quote_types", function(err, types) {
            if (err) throw err;
            con.query("SELECT quote_genre_id, genre FROM quote_genres", function(err, genres) {
                if (err) throw err;
                con.end();
                res.render('quoteForm', Object.assign({
                    title: 'Add Quote',
                    quoteTypes: types,
                    quoteGenres: genres
                }, renderExtra));
            });
        });
    });
}

function addQuote(formData, userId, res) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        var sql = "INSERT INTO quotes (quote_id, quote_text, source, quote_type, quote_genre, found_by, tag, user, created_at) " +
                   "VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, NOW())";
        var values = [
            formData.quoteText,
            formData.quoteSource,
            formData.quoteTypeOptions,
            formData.quoteGenreOptions,
            formData.foundBy,
            formData.tag,
            userId
        ];
        con.query(sql, values, function(err, result, fields) {
            if (err) throw err;
            con.end();
            res.redirect('/confirmation?quote_id=' + result.insertId);
        });
    });
}

function getQuoteById(quoteId, res) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT quote_text, source, type, genre, tag, created_at " +
                   "FROM quotes " +
                   "JOIN authorizedusers ON quotes.user = authorizedusers.user_id " +
                   "JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id " +
                   "JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id " +
                   "WHERE quotes.quote_id = ?";
        con.query(sql, [quoteId], function(err, result, fields) {
            if (err) throw err;
            con.end();
            res.render('confirmation', {
                title: 'Confirmation',
                quote: result[0]
            });
        });
    });
}

function getDailyQuote(res) {
    var con = createConnection();
    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT dq_text, source, dq_type, dq_genre, dq_date " +
                   "FROM daily_quotes WHERE dq_date = CURDATE()";
        con.query(sql, function(err, result, fields) {
            if (err) throw err;
            con.end();
            res.render('featured', {
                title: 'Daily Feed',
                dailyQuotes: result
            });
        });
    });
}

module.exports = {
    validateLogin,
    getQuotes,
    getQuoteTypesAndGenres,
    addQuote,
    getQuoteById,
    getDailyQuote
};
