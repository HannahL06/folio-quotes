var mysql = require('mysql2/promise');
var bcrypt = require('bcrypt');

var SALT_ROUNDS = 10;

var pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10
});

function closePool() {
    return pool.end();
}

async function validateLogin(username, password) {
    var [rows] = await pool.query(
        'SELECT user_id, username, password FROM authorizedusers WHERE username = ?',
        [username]
    );

    if (rows.length === 0) {
        return null;
    }

    var user = rows[0];
    var matches = await bcrypt.compare(password, user.password);
    if (!matches) {
        return null;
    }

    return { userId: user.user_id, username: user.username };
}

async function registerUser(formData) {
    var hashedPassword = await bcrypt.hash(formData.password, SALT_ROUNDS);

    try {
        var [result] = await pool.query(
            'INSERT INTO authorizedusers (username, password, email, role, date_joined, firstName, lastName) ' +
            'VALUES (?, ?, ?, ?, CURDATE(), ?, ?)',
            [formData.username, hashedPassword, formData.email, 'user', formData.firstName, formData.lastName]
        );
        return { userId: result.insertId, username: formData.username };
    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') {
            var dupError = new Error('That username is already taken.');
            dupError.isUserError = true;
            throw dupError;
        }
        throw err;
    }
}

async function getQuotes(filters, userId) {
    var sql = 'SELECT quote_id, quote_text, source, quote_type AS quote_type_id, type, ' +
               'quote_genre AS quote_genre_id, genre, tag, created_at, ' +
               '(SELECT post_id FROM posts WHERE posts.quote_id = quotes.quote_id AND posts.posted_by = quotes.user) AS post_id ' +
               'FROM quotes ' +
               'JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id ' +
               'JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id ' +
               'WHERE quotes.user = ?';
    var values = [userId];

    if (filters.search) {
        sql += ' AND (quote_text LIKE ? OR source LIKE ? OR type LIKE ? OR genre LIKE ? OR tag LIKE ?)';
        var likeSearch = '%' + filters.search + '%';
        values.push(likeSearch, likeSearch, likeSearch, likeSearch, likeSearch);
    }

    if (filters.type) {
        sql += ' AND quotes.quote_type = ?';
        values.push(filters.type);
    }

    if (filters.genre) {
        sql += ' AND quotes.quote_genre = ?';
        values.push(filters.genre);
    }

    var sortOptions = {
        newest: 'quotes.created_at DESC',
        oldest: 'quotes.created_at ASC',
        type: 'type ASC',
        genre: 'genre ASC'
    };
    sql += ' ORDER BY ' + (sortOptions[filters.sort] || sortOptions.newest);

    var [rows] = await pool.query(sql, values);
    return rows;
}

var POST_SELECT =
    'SELECT posts.post_id, quotes.quote_id, quote_text, source, ' +
    'quote_type AS quote_type_id, type, quote_genre AS quote_genre_id, genre, tag, ' +
    'posts.posted_at, poster.username AS posted_by_username, ' +
    '(SELECT COUNT(*) FROM likes WHERE likes.post_id = posts.post_id) AS like_count, ' +
    '(SELECT COUNT(*) FROM quotes AS folio_copies WHERE folio_copies.foliod_from_post = posts.post_id) AS foliod_count, ' +
    'EXISTS(SELECT 1 FROM likes WHERE likes.post_id = posts.post_id AND likes.user_id = ?) AS liked_by_viewer, ' +
    'EXISTS(SELECT 1 FROM quotes AS viewer_copy WHERE viewer_copy.foliod_from_post = posts.post_id AND viewer_copy.user = ?) AS foliod_by_viewer, ' +
    '(quotes.user = ?) AS is_own_quote ' +
    'FROM posts ' +
    'JOIN quotes ON posts.quote_id = quotes.quote_id ' +
    'JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id ' +
    'JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id ' +
    'JOIN authorizedusers AS poster ON posts.posted_by = poster.user_id ';

async function getPosts(filters, viewerUserId) {
    var sql = POST_SELECT + 'WHERE 1 = 1';
    var values = [viewerUserId, viewerUserId, viewerUserId];

    if (filters.search) {
        sql += ' AND (quote_text LIKE ? OR source LIKE ? OR type LIKE ? OR genre LIKE ? OR tag LIKE ?)';
        var likeSearch = '%' + filters.search + '%';
        values.push(likeSearch, likeSearch, likeSearch, likeSearch, likeSearch);
    }

    if (filters.type) {
        sql += ' AND quotes.quote_type = ?';
        values.push(filters.type);
    }

    if (filters.genre) {
        sql += ' AND quotes.quote_genre = ?';
        values.push(filters.genre);
    }

    var sortOptions = {
        newest: 'posts.posted_at DESC',
        oldest: 'posts.posted_at ASC',
        type: 'type ASC',
        genre: 'genre ASC',
        likes: 'like_count DESC'
    };
    sql += ' ORDER BY ' + (sortOptions[filters.sort] || sortOptions.newest);

    var [rows] = await pool.query(sql, values);
    return rows;
}

async function getMyPosts(userId) {
    var sql = POST_SELECT + 'WHERE posts.posted_by = ? ORDER BY posts.posted_at DESC';
    var [rows] = await pool.query(sql, [userId, userId, userId, userId]);
    return rows;
}

async function postQuote(quoteId, userId) {
    var [owned] = await pool.query(
        'SELECT quote_id FROM quotes WHERE quote_id = ? AND user = ?',
        [quoteId, userId]
    );
    if (owned.length === 0) {
        var ownError = new Error('You can only post quotes from your own Folio.');
        ownError.isUserError = true;
        throw ownError;
    }

    try {
        var [result] = await pool.query(
            'INSERT INTO posts (quote_id, posted_by, posted_at) VALUES (?, ?, NOW())',
            [quoteId, userId]
        );
        return result.insertId;
    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') {
            var dupError = new Error("You've already posted this quote.");
            dupError.isUserError = true;
            throw dupError;
        }
        throw err;
    }
}

async function unpostQuote(postId, userId) {
    var [result] = await pool.query(
        'DELETE FROM posts WHERE post_id = ? AND posted_by = ?',
        [postId, userId]
    );
    return result.affectedRows > 0;
}

async function toggleLike(postId, userId) {
    var [existing] = await pool.query(
        'SELECT like_id FROM likes WHERE post_id = ? AND user_id = ?',
        [postId, userId]
    );

    if (existing.length > 0) {
        await pool.query('DELETE FROM likes WHERE like_id = ?', [existing[0].like_id]);
        return { liked: false };
    }

    await pool.query(
        'INSERT INTO likes (post_id, user_id, liked_at) VALUES (?, ?, NOW())',
        [postId, userId]
    );
    return { liked: true };
}

async function foliatePost(postId, userId) {
    var [rows] = await pool.query(
        'SELECT quotes.quote_text, quotes.source, quotes.quote_type, quotes.quote_genre, quotes.tag, quotes.user ' +
        'FROM posts JOIN quotes ON posts.quote_id = quotes.quote_id WHERE posts.post_id = ?',
        [postId]
    );
    var quote = rows[0];

    if (!quote) {
        return null;
    }

    if (quote.user === userId) {
        var ownError = new Error('This quote is already in your Folio.');
        ownError.isUserError = true;
        throw ownError;
    }

    try {
        var [result] = await pool.query(
            'INSERT INTO quotes (quote_text, source, quote_type, quote_genre, found_by, tag, user, created_at, foliod_from_post) ' +
            'VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?)',
            [quote.quote_text, quote.source, quote.quote_type, quote.quote_genre, 'Found on Folio', quote.tag, userId, postId]
        );
        return result.insertId;
    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') {
            var dupError = new Error("You've already added this quote to your Folio.");
            dupError.isUserError = true;
            throw dupError;
        }
        throw err;
    }
}

async function getQuoteTypesAndGenres() {
    var [types] = await pool.query('SELECT quote_type_id, type FROM quote_types ORDER BY type');
    var [genres] = await pool.query('SELECT quote_genre_id, genre FROM quote_genres ORDER BY genre');
    return { types: types, genres: genres };
}

async function addQuote(formData, userId) {
    var sql = 'INSERT INTO quotes (quote_text, source, quote_type, quote_genre, found_by, tag, user, created_at) ' +
               'VALUES (?, ?, ?, ?, ?, ?, ?, NOW())';
    var values = [
        formData.quoteText,
        formData.quoteSource,
        formData.quoteTypeOptions,
        formData.quoteGenreOptions,
        formData.foundBy,
        formData.tag,
        userId
    ];
    var [result] = await pool.query(sql, values);
    return result.insertId;
}

async function getQuoteForEdit(quoteId, userId) {
    var [rows] = await pool.query(
        'SELECT quote_id, quote_text, source, quote_type, quote_genre, found_by, tag ' +
        'FROM quotes WHERE quote_id = ? AND user = ?',
        [quoteId, userId]
    );
    return rows[0] || null;
}

async function editQuote(quoteId, formData, userId) {
    var sql = 'UPDATE quotes SET quote_text = ?, source = ?, quote_type = ?, quote_genre = ?, found_by = ?, tag = ? ' +
               'WHERE quote_id = ? AND user = ?';
    var values = [
        formData.quoteText,
        formData.quoteSource,
        formData.quoteTypeOptions,
        formData.quoteGenreOptions,
        formData.foundBy,
        formData.tag,
        quoteId,
        userId
    ];
    var [result] = await pool.query(sql, values);
    return result.affectedRows > 0;
}

async function deleteQuote(quoteId, userId) {
    var [result] = await pool.query(
        'DELETE FROM quotes WHERE quote_id = ? AND user = ?',
        [quoteId, userId]
    );
    return result.affectedRows > 0;
}

async function getQuoteById(quoteId, userId) {
    var sql = 'SELECT quote_id, quote_text, source, type, genre, tag, created_at ' +
               'FROM quotes ' +
               'JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id ' +
               'JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id ' +
               'WHERE quotes.quote_id = ? AND quotes.user = ?';
    var [rows] = await pool.query(sql, [quoteId, userId]);
    return rows[0] || null;
}

function getDayOfYear(date) {
    var startOfYear = new Date(date.getFullYear(), 0, 0);
    return Math.floor((date - startOfYear) / 86400000);
}

async function getDailyQuote() {
    var columns = 'SELECT dq_text, source, dq_type, dq_genre, dq_date FROM daily_quotes ';
    var [rows] = await pool.query(columns + 'WHERE dq_date = CURDATE()');
    if (rows.length > 0) {
        return rows;
    }

    // No row for today (e.g. past the seeded year): rotate through whatever exists.
    var [[{ total }]] = await pool.query('SELECT COUNT(*) AS total FROM daily_quotes');
    if (total === 0) {
        return [];
    }
    var offset = getDayOfYear(new Date()) % total;
    var [fallback] = await pool.query(columns + 'ORDER BY dq_id LIMIT 1 OFFSET ' + offset);
    return fallback;
}

async function getUserDailyQuote(userId) {
    var [[{ total }]] = await pool.query('SELECT COUNT(*) AS total FROM quotes WHERE user = ?', [userId]);
    if (total === 0) {
        return null;
    }

    var offset = getDayOfYear(new Date()) % total;
    var sql = 'SELECT quote_text, source, type, genre, tag, created_at ' +
               'FROM quotes ' +
               'JOIN quote_types ON quotes.quote_type = quote_types.quote_type_id ' +
               'JOIN quote_genres ON quotes.quote_genre = quote_genres.quote_genre_id ' +
               'WHERE quotes.user = ? ' +
               'ORDER BY quote_id ' +
               'LIMIT 1 OFFSET ' + offset;
    var [rows] = await pool.query(sql, [userId]);
    return rows[0] || null;
}

module.exports = {
    closePool,
    validateLogin,
    registerUser,
    getQuotes,
    getQuoteTypesAndGenres,
    addQuote,
    getQuoteForEdit,
    editQuote,
    deleteQuote,
    getQuoteById,
    getDailyQuote,
    getUserDailyQuote,
    getPosts,
    getMyPosts,
    postQuote,
    unpostQuote,
    toggleLike,
    foliatePost
};
