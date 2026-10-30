-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2026 at 02:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `folio`
--

-- --------------------------------------------------------

--
-- Table structure for table `authorizedusers`
--

CREATE TABLE `authorizedusers` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `date_joined` date DEFAULT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authorizedusers`
--

-- Passwords below are bcrypt hashes. Plaintext values (for local demo/testing only):
--   MichalF / password1   ereitzes / er11172000   mn123 / quotesAppPassword
--   Rikkle / rlevy1        ALehm / purpleLemur6    HannahL / password2
INSERT INTO `authorizedusers` (`user_id`, `username`, `password`, `email`, `role`, `date_joined`, `firstName`, `lastName`) VALUES
(1, 'MichalF', '$2b$10$pOPmapyoPVgZ8ZlEig3DpOGyClrkTDaR6aMm2gSDHnhheh4uCZc32', '', '', NULL, '', ''),
(2, 'ereitzes', '$2b$10$d6id2JDkVKb4Jo6VCaqwF.m1kBjimJugyrawWX90FLqykkQRW9hJS', '', '', NULL, '', ''),
(3, 'mn123', '$2b$10$eiZLmHGa9wUm3k5msvFfSOROLDchSXEtvApkahIu7XmDyPW5L9Hq2', '', '', NULL, '', ''),
(4, 'Rikkle', '$2b$10$Vb/2U.xz8wg40ZDqGVDYtOfUw6/e4eGXdnZmVuduT1vc6qJYaSVPa', 'rlevy@example.com', 'user', '2026-08-03', 'Rikki', 'Levi'),
(8, 'ALehm', '$2b$10$2JumEQPrbFQ7DUN0U/uJT.PtHBfQZf2/sM2QSwMZorV5HbXoFzUEW', 'alehmen@example.com', 'user', '2026-08-03', 'Avi', 'Lehman'),
(9, 'HannahL', '$2b$10$tYXPvAuVsXG0saU.kcZAbuVhNm4snR3.Q.UDba.tI7pxtneTcltSu', 'hannah@example.com', 'admin', '2026-08-16', 'Hannah', 'Lichtman');

-- --------------------------------------------------------

--
-- Table structure for table `daily_quotes`
--

CREATE TABLE `daily_quotes` (
  `dq_id` int(11) NOT NULL,
  `dq_text` text NOT NULL,
  `source` text NOT NULL,
  `dq_type` varchar(100) NOT NULL,
  `dq_genre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_quotes`
--

INSERT INTO `daily_quotes` (`dq_id`, `dq_text`, `source`, `dq_type`, `dq_genre`) VALUES
(1, 'Not all those who wander are lost.', 'J.R.R. Tolkien, The Fellowship of the Ring (1954)', 'Book', 'Inspirational'),
(2, 'Hope is the thing with feathers that perches in the soul.', 'Emily Dickinson', 'Poem', 'Inspirational'),
(3, 'The only thing we have to fear is fear itself.', 'Franklin D. Roosevelt, Inaugural Address (1933)', 'Speech', 'Inspirational'),
(4, 'I have a dream.', 'Martin Luther King Jr., March on Washington (1963)', 'Speech', 'Inspirational'),
(5, 'Two roads diverged in a wood, and I— I took the one less traveled by.', 'Robert Frost, "The Road Not Taken" (1916)', 'Poem', 'Inspirational'),
(6, 'It was the best of times, it was the worst of times.', 'Charles Dickens, A Tale of Two Cities (1859)', 'Book', 'Famous Lines'),
(7, 'Call me Ishmael.', 'Herman Melville, Moby-Dick (1851)', 'Book', 'Famous Lines'),
(8, 'That''s one small step for man, one giant leap for mankind.', 'Neil Armstrong (1969)', 'Speech', 'Famous Lines'),
(9, 'The unexamined life is not worth living.', 'Socrates', 'Lines People Say', 'Wise'),
(10, 'The only way to do great work is to love what you do.', 'Steve Jobs, Stanford Commencement (2005)', 'Speech', 'Motivational'),
(11, 'I think, therefore I am.', 'René Descartes', 'Lines People Say', 'Wise'),
(12, 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.', 'Jane Austen, Pride and Prejudice (1813)', 'Book', 'Famous Lines'),
(13, 'Shall I compare thee to a summer''s day?', 'William Shakespeare, Sonnet 18', 'Poem', 'Heartwarming'),
(14, 'Tomorrow is always fresh, with no mistakes in it yet.', 'L.M. Montgomery, Anne of Green Gables (1908)', 'Book', 'Heartwarming'),
(15, 'I can resist everything except temptation.', 'Oscar Wilde, Lady Windermere''s Fan (1892)', 'Lines People Say', 'Funny');

-- --------------------------------------------------------

--
-- Table structure for table `quotes`
--

CREATE TABLE `quotes` (
  `quote_id` int(11) NOT NULL,
  `quote_text` text NOT NULL,
  `source` text NOT NULL,
  `quote_type` varchar(100) NOT NULL,
  `quote_genre` varchar(100) NOT NULL,
  `found_by` varchar(100) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `user` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `foliod_from_post` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quotes`
--

INSERT INTO `quotes` (`quote_id`, `quote_text`, `source`, `quote_type`, `quote_genre`, `found_by`, `tag`, `user`, `created_at`) VALUES
(9, 'I\'ve learned that people will forget what you said, people will forget what you did, but people will never forget the way you made them feel.', 'Maya Angelou', '9', '1', 'Myself', 'Famous Lines', 1, '2026-08-16 20:20:22'),
(10, 'I am the master of my fate: I am the captain of my soul.', 'William Ernest Henley, \"Invictus\" (1875)', '7', '1', 'Myself', 'poem lines', 2, '2026-08-16 20:29:49'),
(11, 'Imagination is more important than knowledge.', 'Albert Einstein, interview in 1929', '9', '8', 'Myself', 'Famous Lines', 3, '2026-08-16 20:29:49'),
(12, 'Never in the field of human conflict was so much owed by so many to so few.', 'Winston Churchill, Speech praising RAF fighters in WWII', '3', '8', 'Myself', 'Famous Lines', 4, '2026-08-16 20:35:38'),
(13, 'Four score and twenty years ago...', 'Abraham Lincoln, Gettysburg Address', '1', '1', 'Found on Folio', 'historical', 8, '2026-08-17 21:44:18'),
(14, 'Be the change you want to see the world', 'Gandhi', '9', '2', 'Found on Folio', 'favorite motivational quotes', 1, '2026-08-17 21:57:41'),
(15, 'Four score and twenty years ago...', 'Abraham Lincoln, Gettysburg Address', '3', '8', 'Found Myself', 'Favorite History Quotes', 2, '2026-08-23 08:45:42');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--
-- Publishing a quote to the public Browse feed. A quote can be posted by its
-- original owner or reposted by anyone else; the quote content itself is never
-- duplicated, only referenced.
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `posted_by` int(11) NOT NULL,
  `posted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `quote_id`, `posted_by`, `posted_at`) VALUES
(1, 9, 1, '2026-08-16 20:20:22'),
(2, 10, 2, '2026-08-16 20:29:49'),
(3, 11, 3, '2026-08-16 20:29:49'),
(4, 12, 4, '2026-08-16 20:35:38'),
(5, 13, 8, '2026-08-17 21:44:18'),
(6, 14, 1, '2026-08-17 21:57:41'),
(7, 15, 2, '2026-08-23 08:45:42');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `like_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `liked_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quote_genres`
--

CREATE TABLE `quote_genres` (
  `quote_genre_id` int(11) NOT NULL,
  `genre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quote_genres`
--

INSERT INTO `quote_genres` (`quote_genre_id`, `genre`) VALUES
(1, 'Inspirational'),
(2, 'Motivational'),
(3, 'Funny'),
(4, 'Wise'),
(5, 'Heartwarming'),
(6, 'Satirical'),
(7, 'Nostalgic'),
(8, 'Famous Lines');

-- --------------------------------------------------------

--
-- Table structure for table `quote_types`
--

CREATE TABLE `quote_types` (
  `quote_type_id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quote_types`
--

INSERT INTO `quote_types` (`quote_type_id`, `type`) VALUES
(1, 'Book'),
(2, 'Article'),
(3, 'Speech'),
(4, 'Podcast'),
(5, 'Video'),
(6, 'Song Lyrics'),
(7, 'Poem'),
(8, 'Street Signs'),
(9, 'Lines People Say'),
(10, 'Social Media Post'),
(11, 'Other');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authorizedusers`
--
ALTER TABLE `authorizedusers`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `daily_quotes`
--
ALTER TABLE `daily_quotes`
  ADD PRIMARY KEY (`dq_id`);

--
-- Indexes for table `quotes`
--
ALTER TABLE `quotes`
  ADD PRIMARY KEY (`quote_id`),
  ADD KEY `quotes_ibfk_1` (`user`),
  ADD UNIQUE KEY `user_foliod_post` (`user`, `foliod_from_post`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD UNIQUE KEY `quote_poster` (`quote_id`, `posted_by`),
  ADD KEY `posts_ibfk_2` (`posted_by`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`),
  ADD UNIQUE KEY `post_user` (`post_id`, `user_id`),
  ADD KEY `likes_ibfk_2` (`user_id`);

--
-- Indexes for table `quote_genres`
--
ALTER TABLE `quote_genres`
  ADD PRIMARY KEY (`quote_genre_id`);

--
-- Indexes for table `quote_types`
--
ALTER TABLE `quote_types`
  ADD PRIMARY KEY (`quote_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authorizedusers`
--
ALTER TABLE `authorizedusers`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `daily_quotes`
--
ALTER TABLE `daily_quotes`
  MODIFY `dq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `quotes`
--
ALTER TABLE `quotes`
  MODIFY `quote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quote_genres`
--
ALTER TABLE `quote_genres`
  MODIFY `quote_genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `quote_types`
--
ALTER TABLE `quote_types`
  MODIFY `quote_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quotes`
--
ALTER TABLE `quotes`
  ADD CONSTRAINT `quotes_ibfk_1` FOREIGN KEY (`user`) REFERENCES `authorizedusers` (`user_id`),
  ADD CONSTRAINT `quotes_ibfk_2` FOREIGN KEY (`foliod_from_post`) REFERENCES `posts` (`post_id`) ON DELETE SET NULL;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`quote_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`posted_by`) REFERENCES `authorizedusers` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `authorizedusers` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
