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

INSERT INTO `authorizedusers` (`user_id`, `username`, `password`, `email`, `role`, `date_joined`, `firstName`, `lastName`) VALUES
(1, 'MichalF', 'password1', '', '', NULL, '', ''),
(2, 'ereitzes', 'er11172000', '', '', NULL, '', ''),
(3, 'mn123', 'quotesAppPassword', '', '', NULL, '', ''),
(4, 'Rikkle', 'rlevy1', 'rlevy@gmail.com', 'user', '2026-08-03', 'Rikki', 'Levi'),
(5, 'Rikkle', 'rlevy1', 'rlevy@gmail.com', 'user', '2026-08-03', 'Rikki', 'Levi'),
(6, 'Rikkle', 'rlevy1', 'rlevy@gmail.com', 'user', '2026-08-03', 'Rikki', 'Levi'),
(7, 'Rikkle', 'rlevy1', 'rlevy@gmail.com', 'user', '2026-08-03', 'Rikki', 'Levi'),
(8, 'ALehm', 'purpleLemur6', 'alehmen@gmail.com', 'user', '2026-08-03', 'Avi', 'Lehman');

-- --------------------------------------------------------

--
-- Table structure for table `daily_quotes`
--

CREATE TABLE `daily_quotes` (
  `dq_id` int(11) NOT NULL,
  `dq_text` text NOT NULL,
  `source` text NOT NULL,
  `dq_type` varchar(100) NOT NULL,
  `dq_genre` varchar(100) NOT NULL,
  `dq_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_quotes`
--

INSERT INTO `daily_quotes` (`dq_id`, `dq_text`, `source`, `dq_type`, `dq_genre`, `dq_date`) VALUES
(1, 'There is a place where the sidewalk ends and before the street begins.', 'Shel Silverstein, \"Where the Sidewalk Ends\", Where the Sidewalk Ends (1974)', 'Poem', 'Famous Lines', '2026-08-17');

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
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quotes`
--

INSERT INTO `quotes` (`quote_id`, `quote_text`, `source`, `quote_type`, `quote_genre`, `found_by`, `tag`, `user`, `created_at`) VALUES
(9, 'I\'ve learned that people will forget what you said, people will forget what you did, but people will never forget the way you made them feel.', 'Maya Angelou', '9', '1', 'Myself', 'Famous Lines', 9, '2026-08-16 20:20:22'),
(10, 'I am the master of my fate: I am the captain of my soul.', 'William Ernest Henley, \"Invictus\" (1875)', '7', '1', 'Myself', 'poem lines', 9, '2026-08-16 20:29:49'),
(11, 'Imagination is more important than knowledge.', 'Albert Einstein, interview in 1929', '9', '8', 'Myself', 'Famous Lines', 9, '2026-08-16 20:29:49'),
(12, 'Never in the field of human conflict was so much owed by so many to so few.', 'Winston Churchill, Speech praising RAF fighters in WWII', '3', '8', 'Myself', 'Famous Lines', 9, '2026-08-16 20:35:38'),
(13, 'Four score and twenty years ago...', 'Abraham Lincoln, Gettysburg Address', '1', '1', 'Found on Folio', 'historical', 9, '2026-08-17 21:44:18'),
(14, 'Be the change you want to see the world', 'Gandhi', '9', '2', 'Found on Folio', 'favorite motivational quotes', 9, '2026-08-17 21:57:41'),
(15, 'Four score and twenty years ago...', 'Abraham Lincoln, Gettysburg Address', '3', '8', 'Found Myself', 'Favorite History Quotes', 9, '2026-08-23 08:45:42');

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
  ADD PRIMARY KEY (`user_id`);

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
  ADD KEY `quotes_ibfk_1` (`user`);

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
  MODIFY `dq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quotes`
--
ALTER TABLE `quotes`
  MODIFY `quote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  ADD CONSTRAINT `quotes_ibfk_1` FOREIGN KEY (`user`) REFERENCES `authorizedusers` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
