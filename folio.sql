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
  `dq_genre` varchar(100) NOT NULL,
  `dq_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_quotes`
--

INSERT INTO `daily_quotes` (`dq_id`, `dq_text`, `source`, `dq_type`, `dq_genre`, `dq_date`) VALUES
(1, 'There is a place where the sidewalk ends and before the street begins.', 'Shel Silverstein, \"Where the Sidewalk Ends\", Where the Sidewalk Ends (1974)', 'Poem', 'Famous Lines', '2026-08-17'),
(2, 'The child is father of the man.', 'William Wordsworth, "My Heart Leaps Up" (1802)', 'Poem', 'Wise', '2026-10-28'),
(3, 'There is no frigate like a book to take us lands away.', 'Emily Dickinson', 'Poem', 'Inspirational', '2026-10-29'),
(4, 'Under the bludgeonings of chance my head is bloody, but unbowed.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Motivational', '2026-10-30'),
(5, 'The fog comes on little cat feet.', 'Carl Sandburg, "Fog" (1916)', 'Poem', 'Nostalgic', '2026-10-31'),
(6, 'Nature\'s first green is gold, her hardest hue to hold.', 'Robert Frost, "Nothing Gold Can Stay" (1923)', 'Poem', 'Nostalgic', '2026-11-01'),
(7, 'I must go down to the seas again, to the lonely sea and the sky.', 'John Masefield, "Sea Fever" (1902)', 'Poem', 'Wise', '2026-11-02'),
(8, 'O Captain! my Captain! our fearful trip is done.', 'Walt Whitman, "O Captain! My Captain!" (1865)', 'Poem', 'Inspirational', '2026-11-03'),
(9, 'Glory be to God for dappled things.', 'Gerard Manley Hopkins, "Pied Beauty" (1877)', 'Poem', 'Inspirational', '2026-11-04'),
(10, 'I think that I shall never see a poem lovely as a tree.', 'Joyce Kilmer, "Trees" (1913)', 'Poem', 'Nostalgic', '2026-11-05'),
(11, 'Stone walls do not a prison make, nor iron bars a cage.', 'Richard Lovelace, "To Althea, from Prison" (1642)', 'Poem', 'Wise', '2026-11-06'),
(12, 'Come live with me and be my Love.', 'Christopher Marlowe, "The Passionate Shepherd to His Love" (1599)', 'Poem', 'Heartwarming', '2026-11-07'),
(13, 'Good fences make good neighbors.', 'Robert Frost, "Mending Wall" (1914)', 'Poem', 'Wise', '2026-11-08'),
(14, 'Do not stand at my grave and weep, I am not there; I do not sleep.', 'Mary Elizabeth Frye, "Do Not Stand at My Grave and Weep" (1932)', 'Poem', 'Heartwarming', '2026-11-09'),
(15, 'When I have fears that I may cease to be.', 'John Keats, "When I Have Fears" (1818)', 'Poem', 'Nostalgic', '2026-11-10'),
(16, 'If I can stop one heart from breaking, I shall not live in vain.', 'Emily Dickinson', 'Poem', 'Heartwarming', '2026-11-11'),
(17, 'It was the best of times, it was the worst of times.', 'Charles Dickens, A Tale of Two Cities (1859)', 'Book', 'Famous Lines', '2026-11-12'),
(18, 'Call me Ishmael.', 'Herman Melville, Moby-Dick (1851)', 'Book', 'Famous Lines', '2026-11-13'),
(19, 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.', 'Jane Austen, Pride and Prejudice (1813)', 'Book', 'Famous Lines', '2026-11-14'),
(20, 'All happy families are alike; each unhappy family is unhappy in its own way.', 'Leo Tolstoy, Anna Karenina (1878)', 'Book', 'Wise', '2026-11-15'),
(21, 'In a hole in the ground there lived a hobbit.', 'J.R.R. Tolkien, The Hobbit (1937)', 'Book', 'Nostalgic', '2026-11-16'),
(22, 'Not all those who wander are lost.', 'J.R.R. Tolkien, The Fellowship of the Ring (1954)', 'Book', 'Inspirational', '2026-11-17'),
(23, 'It was a bright cold day in April, and the clocks were striking thirteen.', 'George Orwell, 1984 (1949)', 'Book', 'Famous Lines', '2026-11-18'),
(24, 'There is some good in this world, and it\'s worth fighting for.', 'J.R.R. Tolkien, The Two Towers (1954)', 'Book', 'Inspirational', '2026-11-19'),
(25, 'We accept the love we think we deserve.', 'Stephen Chbosky, The Perks of Being a Wallflower (1999)', 'Book', 'Wise', '2026-11-20'),
(26, 'So we beat on, boats against the current, borne back ceaselessly into the past.', 'F. Scott Fitzgerald, The Great Gatsby (1925)', 'Book', 'Famous Lines', '2026-11-21'),
(27, 'It does not do to dwell on dreams and forget to live.', 'J.K. Rowling, Harry Potter and the Sorcerer\'s Stone (1997)', 'Book', 'Wise', '2026-11-22'),
(28, 'Whatever our souls are made of, his and mine are the same.', 'Emily Bronte, Wuthering Heights (1847)', 'Book', 'Heartwarming', '2026-11-23'),
(29, 'The only way out of the labyrinth of suffering is to forgive.', 'John Green, Looking for Alaska (2005)', 'Book', 'Wise', '2026-11-24'),
(30, 'Tomorrow is always fresh, with no mistakes in it yet.', 'L.M. Montgomery, Anne of Green Gables (1908)', 'Book', 'Inspirational', '2026-11-25'),
(31, 'A room without books is like a body without a soul.', 'Marcus Tullius Cicero', 'Book', 'Wise', '2026-11-26'),
(32, 'I have a dream.', 'Martin Luther King Jr., Speech (1963)', 'Speech', 'Inspirational', '2026-11-27'),
(33, 'The only thing we have to fear is fear itself.', 'Franklin D. Roosevelt, Inaugural Address (1933)', 'Speech', 'Inspirational', '2026-11-28'),
(34, 'That\'s one small step for man, one giant leap for mankind.', 'Neil Armstrong (1969)', 'Speech', 'Famous Lines', '2026-11-29'),
(35, 'Ask not what your country can do for you - ask what you can do for your country.', 'John F. Kennedy, Inaugural Address (1961)', 'Speech', 'Inspirational', '2026-11-30'),
(36, 'I think, therefore I am.', 'Rene Descartes', 'Lines People Say', 'Wise', '2026-12-01'),
(37, 'The unexamined life is not worth living.', 'Socrates', 'Lines People Say', 'Wise', '2026-12-02'),
(38, 'In the middle of difficulty lies opportunity.', 'Albert Einstein', 'Lines People Say', 'Motivational', '2026-12-03'),
(39, 'Float like a butterfly, sting like a bee.', 'Muhammad Ali', 'Lines People Say', 'Motivational', '2026-12-04'),
(40, 'A house divided against itself cannot stand.', 'Abraham Lincoln', 'Speech', 'Wise', '2026-12-05'),
(41, 'An eye for an eye only ends up making the whole world blind.', 'Mahatma Gandhi', 'Lines People Say', 'Wise', '2026-12-06'),
(42, 'The best way to find yourself is to lose yourself in the service of others.', 'Mahatma Gandhi', 'Lines People Say', 'Inspirational', '2026-12-07'),
(43, 'Success is not final, failure is not fatal: it is the courage to continue that counts.', 'Winston Churchill', 'Speech', 'Motivational', '2026-12-08'),
(44, 'You miss 100% of the shots you don\'t take.', 'Wayne Gretzky', 'Lines People Say', 'Motivational', '2026-12-09'),
(45, 'The future belongs to those who believe in the beauty of their dreams.', 'Eleanor Roosevelt', 'Lines People Say', 'Inspirational', '2026-12-10'),
(46, 'Life is what happens when you\'re busy making other plans.', 'John Lennon', 'Lines People Say', 'Wise', '2026-12-11'),
(47, 'It always seems impossible until it\'s done.', 'Nelson Mandela', 'Lines People Say', 'Motivational', '2026-12-12'),
(48, 'Do one thing every day that scares you.', 'Eleanor Roosevelt', 'Lines People Say', 'Motivational', '2026-12-13'),
(49, 'Whether you think you can or you think you can\'t, you\'re right.', 'Henry Ford', 'Lines People Say', 'Wise', '2026-12-14'),
(50, 'The only way to do great work is to love what you do.', 'Steve Jobs', 'Lines People Say', 'Inspirational', '2026-12-15'),
(51, 'Science is a way of thinking much more than it is a body of knowledge.', 'Carl Sagan', 'Lines People Say', 'Wise', '2026-12-16'),
(52, 'I\'m not arguing, I\'m just explaining why I\'m right.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-17'),
(53, 'I used to think I was indecisive, but now I\'m not so sure.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-18'),
(54, 'I am so clever that sometimes I don\'t understand a single word of what I am saying.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2026-12-19'),
(55, 'The trouble with having an open mind is that people keep coming along and putting things in it.', 'Terry Pratchett', 'Lines People Say', 'Funny', '2026-12-20'),
(56, 'I can resist everything except temptation.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2026-12-21'),
(57, 'Light travels faster than sound. This is why some people appear bright until you hear them speak.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-22'),
(58, 'I\'m on a seafood diet. I see food and I eat it.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-23'),
(59, 'Procrastinate now, don\'t put it off.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-24'),
(60, 'My bed is a magical place where I suddenly remember everything I forgot to do.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-25'),
(61, 'I\'m reading a book about anti-gravity. It\'s impossible to put down.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-26'),
(62, 'I told my computer I needed a break, and now it won\'t stop sending me vacation ads.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-27'),
(63, 'A balanced diet is a cookie in each hand.', 'Anonymous', 'Street Signs', 'Funny', '2026-12-28'),
(64, 'I\'m not lazy, I\'m on energy-saving mode.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-29'),
(65, 'Common sense is like deodorant. The people who need it most never use it.', 'Anonymous', 'Social Media Post', 'Funny', '2026-12-30'),
(66, 'I always arrive late at the office, but I make up for it by leaving early.', 'Charles Lamb', 'Lines People Say', 'Funny', '2026-12-31'),
(67, 'Behind every great person is a surprised family.', 'Anonymous', 'Social Media Post', 'Funny', '2027-01-01'),
(68, 'The early bird gets the worm, but the second mouse gets the cheese.', 'Anonymous', 'Street Signs', 'Funny', '2027-01-02'),
(69, 'I\'m not saying I\'m Wonder Woman, I\'m just saying no one has ever seen me and Wonder Woman in the same room.', 'Anonymous', 'Social Media Post', 'Funny', '2027-01-03'),
(70, 'Life is short. Smile while you still have teeth.', 'Anonymous', 'Street Signs', 'Funny', '2027-01-04'),
(71, 'If at first you don\'t succeed, then skydiving definitely isn\'t for you.', 'Anonymous', 'Social Media Post', 'Funny', '2027-01-05'),
(72, 'Two roads diverged in a wood, and I— I took the one less traveled by.', 'Robert Frost, "The Road Not Taken" (1916)', 'Poem', 'Inspirational', '2027-01-06'),
(73, 'Hope is the thing with feathers that perches in the soul.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-01-07'),
(74, 'I celebrate myself, and sing myself.', 'Walt Whitman, "Song of Myself" (1855)', 'Poem', 'Wise', '2027-01-08'),
(75, 'Season of mists and mellow fruitfulness.', 'John Keats, "To Autumn" (1820)', 'Poem', 'Nostalgic', '2027-01-09'),
(76, 'The woods are lovely, dark and deep, but I have promises to keep.', 'Robert Frost, "Stopping by Woods on a Snowy Evening" (1923)', 'Poem', 'Nostalgic', '2027-01-10'),
(77, 'Shall I compare thee to a summer\'s day?', 'William Shakespeare, Sonnet 18', 'Poem', 'Heartwarming', '2027-01-11'),
(78, 'I wandered lonely as a cloud.', 'William Wordsworth, "I Wandered Lonely as a Cloud" (1807)', 'Poem', 'Nostalgic', '2027-01-12'),
(79, 'Tiger, Tiger, burning bright, in the forests of the night.', 'William Blake, "The Tyger" (1794)', 'Poem', 'Famous Lines', '2027-01-13'),
(80, 'If you can keep your head when all about you are losing theirs.', 'Rudyard Kipling, "If—" (1910)', 'Poem', 'Motivational', '2027-01-14'),
(81, 'Out of the night that covers me, black as the pit from pole to pole.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Wise', '2027-01-15'),
(82, 'Water, water, every where, nor any drop to drink.', 'Samuel Taylor Coleridge, "The Rime of the Ancient Mariner" (1798)', 'Poem', 'Famous Lines', '2027-01-16'),
(83, '\'Tis better to have loved and lost than never to have loved at all.', 'Alfred, Lord Tennyson, "In Memoriam A.H.H." (1850)', 'Poem', 'Heartwarming', '2027-01-17'),
(84, 'Listen, my children, and you shall hear of the midnight ride of Paul Revere.', 'Henry Wadsworth Longfellow, "Paul Revere\'s Ride" (1860)', 'Poem', 'Famous Lines', '2027-01-18'),
(85, 'By the shores of Gitche Gumee, by the shining Big-Sea-Water.', 'Henry Wadsworth Longfellow, "The Song of Hiawatha" (1855)', 'Poem', 'Nostalgic', '2027-01-19'),
(86, 'Once upon a midnight dreary, while I pondered, weak and weary.', 'Edgar Allan Poe, "The Raven" (1845)', 'Poem', 'Famous Lines', '2027-01-20'),
(87, 'What dreams may come.', 'William Shakespeare, Hamlet', 'Poem', 'Wise', '2027-01-21'),
(88, 'Turning and turning in the widening gyre, the falcon cannot hear the falconer.', 'William Butler Yeats, "The Second Coming" (1919)', 'Poem', 'Famous Lines', '2027-01-22'),
(89, 'My heart is like a singing bird.', 'Christina Rossetti, "A Birthday" (1861)', 'Poem', 'Heartwarming', '2027-01-23'),
(90, 'The world is too much with us; late and soon, getting and spending, we lay waste our powers.', 'William Wordsworth (1807)', 'Poem', 'Wise', '2027-01-24'),
(91, 'A thing of beauty is a joy for ever.', 'John Keats, "Endymion" (1818)', 'Poem', 'Inspirational', '2027-01-25'),
(92, 'The child is father of the man.', 'William Wordsworth, "My Heart Leaps Up" (1802)', 'Poem', 'Wise', '2027-01-26'),
(93, 'There is no frigate like a book to take us lands away.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-01-27'),
(94, 'Under the bludgeonings of chance my head is bloody, but unbowed.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Motivational', '2027-01-28'),
(95, 'The fog comes on little cat feet.', 'Carl Sandburg, "Fog" (1916)', 'Poem', 'Nostalgic', '2027-01-29'),
(96, 'Nature\'s first green is gold, her hardest hue to hold.', 'Robert Frost, "Nothing Gold Can Stay" (1923)', 'Poem', 'Nostalgic', '2027-01-30'),
(97, 'I must go down to the seas again, to the lonely sea and the sky.', 'John Masefield, "Sea Fever" (1902)', 'Poem', 'Wise', '2027-01-31'),
(98, 'O Captain! my Captain! our fearful trip is done.', 'Walt Whitman, "O Captain! My Captain!" (1865)', 'Poem', 'Inspirational', '2027-02-01'),
(99, 'Glory be to God for dappled things.', 'Gerard Manley Hopkins, "Pied Beauty" (1877)', 'Poem', 'Inspirational', '2027-02-02'),
(100, 'I think that I shall never see a poem lovely as a tree.', 'Joyce Kilmer, "Trees" (1913)', 'Poem', 'Nostalgic', '2027-02-03'),
(101, 'Stone walls do not a prison make, nor iron bars a cage.', 'Richard Lovelace, "To Althea, from Prison" (1642)', 'Poem', 'Wise', '2027-02-04'),
(102, 'Come live with me and be my Love.', 'Christopher Marlowe, "The Passionate Shepherd to His Love" (1599)', 'Poem', 'Heartwarming', '2027-02-05'),
(103, 'Good fences make good neighbors.', 'Robert Frost, "Mending Wall" (1914)', 'Poem', 'Wise', '2027-02-06'),
(104, 'Do not stand at my grave and weep, I am not there; I do not sleep.', 'Mary Elizabeth Frye, "Do Not Stand at My Grave and Weep" (1932)', 'Poem', 'Heartwarming', '2027-02-07'),
(105, 'When I have fears that I may cease to be.', 'John Keats, "When I Have Fears" (1818)', 'Poem', 'Nostalgic', '2027-02-08'),
(106, 'If I can stop one heart from breaking, I shall not live in vain.', 'Emily Dickinson', 'Poem', 'Heartwarming', '2027-02-09'),
(107, 'It was the best of times, it was the worst of times.', 'Charles Dickens, A Tale of Two Cities (1859)', 'Book', 'Famous Lines', '2027-02-10'),
(108, 'Call me Ishmael.', 'Herman Melville, Moby-Dick (1851)', 'Book', 'Famous Lines', '2027-02-11'),
(109, 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.', 'Jane Austen, Pride and Prejudice (1813)', 'Book', 'Famous Lines', '2027-02-12'),
(110, 'All happy families are alike; each unhappy family is unhappy in its own way.', 'Leo Tolstoy, Anna Karenina (1878)', 'Book', 'Wise', '2027-02-13'),
(111, 'In a hole in the ground there lived a hobbit.', 'J.R.R. Tolkien, The Hobbit (1937)', 'Book', 'Nostalgic', '2027-02-14'),
(112, 'Not all those who wander are lost.', 'J.R.R. Tolkien, The Fellowship of the Ring (1954)', 'Book', 'Inspirational', '2027-02-15'),
(113, 'It was a bright cold day in April, and the clocks were striking thirteen.', 'George Orwell, 1984 (1949)', 'Book', 'Famous Lines', '2027-02-16'),
(114, 'There is some good in this world, and it\'s worth fighting for.', 'J.R.R. Tolkien, The Two Towers (1954)', 'Book', 'Inspirational', '2027-02-17'),
(115, 'We accept the love we think we deserve.', 'Stephen Chbosky, The Perks of Being a Wallflower (1999)', 'Book', 'Wise', '2027-02-18'),
(116, 'So we beat on, boats against the current, borne back ceaselessly into the past.', 'F. Scott Fitzgerald, The Great Gatsby (1925)', 'Book', 'Famous Lines', '2027-02-19'),
(117, 'It does not do to dwell on dreams and forget to live.', 'J.K. Rowling, Harry Potter and the Sorcerer\'s Stone (1997)', 'Book', 'Wise', '2027-02-20'),
(118, 'Whatever our souls are made of, his and mine are the same.', 'Emily Bronte, Wuthering Heights (1847)', 'Book', 'Heartwarming', '2027-02-21'),
(119, 'The only way out of the labyrinth of suffering is to forgive.', 'John Green, Looking for Alaska (2005)', 'Book', 'Wise', '2027-02-22'),
(120, 'Tomorrow is always fresh, with no mistakes in it yet.', 'L.M. Montgomery, Anne of Green Gables (1908)', 'Book', 'Inspirational', '2027-02-23'),
(121, 'A room without books is like a body without a soul.', 'Marcus Tullius Cicero', 'Book', 'Wise', '2027-02-24'),
(122, 'I have a dream.', 'Martin Luther King Jr., Speech (1963)', 'Speech', 'Inspirational', '2027-02-25'),
(123, 'The only thing we have to fear is fear itself.', 'Franklin D. Roosevelt, Inaugural Address (1933)', 'Speech', 'Inspirational', '2027-02-26'),
(124, 'That\'s one small step for man, one giant leap for mankind.', 'Neil Armstrong (1969)', 'Speech', 'Famous Lines', '2027-02-27'),
(125, 'Ask not what your country can do for you - ask what you can do for your country.', 'John F. Kennedy, Inaugural Address (1961)', 'Speech', 'Inspirational', '2027-02-28'),
(126, 'I think, therefore I am.', 'Rene Descartes', 'Lines People Say', 'Wise', '2027-03-01'),
(127, 'The unexamined life is not worth living.', 'Socrates', 'Lines People Say', 'Wise', '2027-03-02'),
(128, 'In the middle of difficulty lies opportunity.', 'Albert Einstein', 'Lines People Say', 'Motivational', '2027-03-03'),
(129, 'Float like a butterfly, sting like a bee.', 'Muhammad Ali', 'Lines People Say', 'Motivational', '2027-03-04'),
(130, 'A house divided against itself cannot stand.', 'Abraham Lincoln', 'Speech', 'Wise', '2027-03-05'),
(131, 'An eye for an eye only ends up making the whole world blind.', 'Mahatma Gandhi', 'Lines People Say', 'Wise', '2027-03-06'),
(132, 'The best way to find yourself is to lose yourself in the service of others.', 'Mahatma Gandhi', 'Lines People Say', 'Inspirational', '2027-03-07'),
(133, 'Success is not final, failure is not fatal: it is the courage to continue that counts.', 'Winston Churchill', 'Speech', 'Motivational', '2027-03-08'),
(134, 'You miss 100% of the shots you don\'t take.', 'Wayne Gretzky', 'Lines People Say', 'Motivational', '2027-03-09'),
(135, 'The future belongs to those who believe in the beauty of their dreams.', 'Eleanor Roosevelt', 'Lines People Say', 'Inspirational', '2027-03-10'),
(136, 'Life is what happens when you\'re busy making other plans.', 'John Lennon', 'Lines People Say', 'Wise', '2027-03-11'),
(137, 'It always seems impossible until it\'s done.', 'Nelson Mandela', 'Lines People Say', 'Motivational', '2027-03-12'),
(138, 'Do one thing every day that scares you.', 'Eleanor Roosevelt', 'Lines People Say', 'Motivational', '2027-03-13'),
(139, 'Whether you think you can or you think you can\'t, you\'re right.', 'Henry Ford', 'Lines People Say', 'Wise', '2027-03-14'),
(140, 'The only way to do great work is to love what you do.', 'Steve Jobs', 'Lines People Say', 'Inspirational', '2027-03-15'),
(141, 'Science is a way of thinking much more than it is a body of knowledge.', 'Carl Sagan', 'Lines People Say', 'Wise', '2027-03-16'),
(142, 'I\'m not arguing, I\'m just explaining why I\'m right.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-17'),
(143, 'I used to think I was indecisive, but now I\'m not so sure.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-18'),
(144, 'I am so clever that sometimes I don\'t understand a single word of what I am saying.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-03-19'),
(145, 'The trouble with having an open mind is that people keep coming along and putting things in it.', 'Terry Pratchett', 'Lines People Say', 'Funny', '2027-03-20'),
(146, 'I can resist everything except temptation.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-03-21'),
(147, 'Light travels faster than sound. This is why some people appear bright until you hear them speak.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-22'),
(148, 'I\'m on a seafood diet. I see food and I eat it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-23'),
(149, 'Procrastinate now, don\'t put it off.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-24'),
(150, 'My bed is a magical place where I suddenly remember everything I forgot to do.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-25'),
(151, 'I\'m reading a book about anti-gravity. It\'s impossible to put down.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-26'),
(152, 'I told my computer I needed a break, and now it won\'t stop sending me vacation ads.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-27'),
(153, 'A balanced diet is a cookie in each hand.', 'Anonymous', 'Street Signs', 'Funny', '2027-03-28'),
(154, 'I\'m not lazy, I\'m on energy-saving mode.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-29'),
(155, 'Common sense is like deodorant. The people who need it most never use it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-03-30'),
(156, 'I always arrive late at the office, but I make up for it by leaving early.', 'Charles Lamb', 'Lines People Say', 'Funny', '2027-03-31'),
(157, 'Behind every great person is a surprised family.', 'Anonymous', 'Social Media Post', 'Funny', '2027-04-01'),
(158, 'The early bird gets the worm, but the second mouse gets the cheese.', 'Anonymous', 'Street Signs', 'Funny', '2027-04-02'),
(159, 'I\'m not saying I\'m Wonder Woman, I\'m just saying no one has ever seen me and Wonder Woman in the same room.', 'Anonymous', 'Social Media Post', 'Funny', '2027-04-03'),
(160, 'Life is short. Smile while you still have teeth.', 'Anonymous', 'Street Signs', 'Funny', '2027-04-04'),
(161, 'If at first you don\'t succeed, then skydiving definitely isn\'t for you.', 'Anonymous', 'Social Media Post', 'Funny', '2027-04-05'),
(162, 'Two roads diverged in a wood, and I— I took the one less traveled by.', 'Robert Frost, "The Road Not Taken" (1916)', 'Poem', 'Inspirational', '2027-04-06'),
(163, 'Hope is the thing with feathers that perches in the soul.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-04-07'),
(164, 'I celebrate myself, and sing myself.', 'Walt Whitman, "Song of Myself" (1855)', 'Poem', 'Wise', '2027-04-08'),
(165, 'Season of mists and mellow fruitfulness.', 'John Keats, "To Autumn" (1820)', 'Poem', 'Nostalgic', '2027-04-09'),
(166, 'The woods are lovely, dark and deep, but I have promises to keep.', 'Robert Frost, "Stopping by Woods on a Snowy Evening" (1923)', 'Poem', 'Nostalgic', '2027-04-10'),
(167, 'Shall I compare thee to a summer\'s day?', 'William Shakespeare, Sonnet 18', 'Poem', 'Heartwarming', '2027-04-11'),
(168, 'I wandered lonely as a cloud.', 'William Wordsworth, "I Wandered Lonely as a Cloud" (1807)', 'Poem', 'Nostalgic', '2027-04-12'),
(169, 'Tiger, Tiger, burning bright, in the forests of the night.', 'William Blake, "The Tyger" (1794)', 'Poem', 'Famous Lines', '2027-04-13'),
(170, 'If you can keep your head when all about you are losing theirs.', 'Rudyard Kipling, "If—" (1910)', 'Poem', 'Motivational', '2027-04-14'),
(171, 'Out of the night that covers me, black as the pit from pole to pole.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Wise', '2027-04-15'),
(172, 'Water, water, every where, nor any drop to drink.', 'Samuel Taylor Coleridge, "The Rime of the Ancient Mariner" (1798)', 'Poem', 'Famous Lines', '2027-04-16'),
(173, '\'Tis better to have loved and lost than never to have loved at all.', 'Alfred, Lord Tennyson, "In Memoriam A.H.H." (1850)', 'Poem', 'Heartwarming', '2027-04-17'),
(174, 'Listen, my children, and you shall hear of the midnight ride of Paul Revere.', 'Henry Wadsworth Longfellow, "Paul Revere\'s Ride" (1860)', 'Poem', 'Famous Lines', '2027-04-18'),
(175, 'By the shores of Gitche Gumee, by the shining Big-Sea-Water.', 'Henry Wadsworth Longfellow, "The Song of Hiawatha" (1855)', 'Poem', 'Nostalgic', '2027-04-19'),
(176, 'Once upon a midnight dreary, while I pondered, weak and weary.', 'Edgar Allan Poe, "The Raven" (1845)', 'Poem', 'Famous Lines', '2027-04-20'),
(177, 'What dreams may come.', 'William Shakespeare, Hamlet', 'Poem', 'Wise', '2027-04-21'),
(178, 'Turning and turning in the widening gyre, the falcon cannot hear the falconer.', 'William Butler Yeats, "The Second Coming" (1919)', 'Poem', 'Famous Lines', '2027-04-22'),
(179, 'My heart is like a singing bird.', 'Christina Rossetti, "A Birthday" (1861)', 'Poem', 'Heartwarming', '2027-04-23'),
(180, 'The world is too much with us; late and soon, getting and spending, we lay waste our powers.', 'William Wordsworth (1807)', 'Poem', 'Wise', '2027-04-24'),
(181, 'A thing of beauty is a joy for ever.', 'John Keats, "Endymion" (1818)', 'Poem', 'Inspirational', '2027-04-25'),
(182, 'The child is father of the man.', 'William Wordsworth, "My Heart Leaps Up" (1802)', 'Poem', 'Wise', '2027-04-26'),
(183, 'There is no frigate like a book to take us lands away.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-04-27'),
(184, 'Under the bludgeonings of chance my head is bloody, but unbowed.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Motivational', '2027-04-28'),
(185, 'The fog comes on little cat feet.', 'Carl Sandburg, "Fog" (1916)', 'Poem', 'Nostalgic', '2027-04-29'),
(186, 'Nature\'s first green is gold, her hardest hue to hold.', 'Robert Frost, "Nothing Gold Can Stay" (1923)', 'Poem', 'Nostalgic', '2027-04-30'),
(187, 'I must go down to the seas again, to the lonely sea and the sky.', 'John Masefield, "Sea Fever" (1902)', 'Poem', 'Wise', '2027-05-01'),
(188, 'O Captain! my Captain! our fearful trip is done.', 'Walt Whitman, "O Captain! My Captain!" (1865)', 'Poem', 'Inspirational', '2027-05-02'),
(189, 'Glory be to God for dappled things.', 'Gerard Manley Hopkins, "Pied Beauty" (1877)', 'Poem', 'Inspirational', '2027-05-03'),
(190, 'I think that I shall never see a poem lovely as a tree.', 'Joyce Kilmer, "Trees" (1913)', 'Poem', 'Nostalgic', '2027-05-04'),
(191, 'Stone walls do not a prison make, nor iron bars a cage.', 'Richard Lovelace, "To Althea, from Prison" (1642)', 'Poem', 'Wise', '2027-05-05'),
(192, 'Come live with me and be my Love.', 'Christopher Marlowe, "The Passionate Shepherd to His Love" (1599)', 'Poem', 'Heartwarming', '2027-05-06'),
(193, 'Good fences make good neighbors.', 'Robert Frost, "Mending Wall" (1914)', 'Poem', 'Wise', '2027-05-07'),
(194, 'Do not stand at my grave and weep, I am not there; I do not sleep.', 'Mary Elizabeth Frye, "Do Not Stand at My Grave and Weep" (1932)', 'Poem', 'Heartwarming', '2027-05-08'),
(195, 'When I have fears that I may cease to be.', 'John Keats, "When I Have Fears" (1818)', 'Poem', 'Nostalgic', '2027-05-09'),
(196, 'If I can stop one heart from breaking, I shall not live in vain.', 'Emily Dickinson', 'Poem', 'Heartwarming', '2027-05-10'),
(197, 'It was the best of times, it was the worst of times.', 'Charles Dickens, A Tale of Two Cities (1859)', 'Book', 'Famous Lines', '2027-05-11'),
(198, 'Call me Ishmael.', 'Herman Melville, Moby-Dick (1851)', 'Book', 'Famous Lines', '2027-05-12'),
(199, 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.', 'Jane Austen, Pride and Prejudice (1813)', 'Book', 'Famous Lines', '2027-05-13'),
(200, 'All happy families are alike; each unhappy family is unhappy in its own way.', 'Leo Tolstoy, Anna Karenina (1878)', 'Book', 'Wise', '2027-05-14'),
(201, 'In a hole in the ground there lived a hobbit.', 'J.R.R. Tolkien, The Hobbit (1937)', 'Book', 'Nostalgic', '2027-05-15'),
(202, 'Not all those who wander are lost.', 'J.R.R. Tolkien, The Fellowship of the Ring (1954)', 'Book', 'Inspirational', '2027-05-16'),
(203, 'It was a bright cold day in April, and the clocks were striking thirteen.', 'George Orwell, 1984 (1949)', 'Book', 'Famous Lines', '2027-05-17'),
(204, 'There is some good in this world, and it\'s worth fighting for.', 'J.R.R. Tolkien, The Two Towers (1954)', 'Book', 'Inspirational', '2027-05-18'),
(205, 'We accept the love we think we deserve.', 'Stephen Chbosky, The Perks of Being a Wallflower (1999)', 'Book', 'Wise', '2027-05-19'),
(206, 'So we beat on, boats against the current, borne back ceaselessly into the past.', 'F. Scott Fitzgerald, The Great Gatsby (1925)', 'Book', 'Famous Lines', '2027-05-20'),
(207, 'It does not do to dwell on dreams and forget to live.', 'J.K. Rowling, Harry Potter and the Sorcerer\'s Stone (1997)', 'Book', 'Wise', '2027-05-21'),
(208, 'Whatever our souls are made of, his and mine are the same.', 'Emily Bronte, Wuthering Heights (1847)', 'Book', 'Heartwarming', '2027-05-22'),
(209, 'The only way out of the labyrinth of suffering is to forgive.', 'John Green, Looking for Alaska (2005)', 'Book', 'Wise', '2027-05-23'),
(210, 'Tomorrow is always fresh, with no mistakes in it yet.', 'L.M. Montgomery, Anne of Green Gables (1908)', 'Book', 'Inspirational', '2027-05-24'),
(211, 'A room without books is like a body without a soul.', 'Marcus Tullius Cicero', 'Book', 'Wise', '2027-05-25'),
(212, 'I have a dream.', 'Martin Luther King Jr., Speech (1963)', 'Speech', 'Inspirational', '2027-05-26'),
(213, 'The only thing we have to fear is fear itself.', 'Franklin D. Roosevelt, Inaugural Address (1933)', 'Speech', 'Inspirational', '2027-05-27'),
(214, 'That\'s one small step for man, one giant leap for mankind.', 'Neil Armstrong (1969)', 'Speech', 'Famous Lines', '2027-05-28'),
(215, 'Ask not what your country can do for you - ask what you can do for your country.', 'John F. Kennedy, Inaugural Address (1961)', 'Speech', 'Inspirational', '2027-05-29'),
(216, 'I think, therefore I am.', 'Rene Descartes', 'Lines People Say', 'Wise', '2027-05-30'),
(217, 'The unexamined life is not worth living.', 'Socrates', 'Lines People Say', 'Wise', '2027-05-31'),
(218, 'In the middle of difficulty lies opportunity.', 'Albert Einstein', 'Lines People Say', 'Motivational', '2027-06-01'),
(219, 'Float like a butterfly, sting like a bee.', 'Muhammad Ali', 'Lines People Say', 'Motivational', '2027-06-02'),
(220, 'A house divided against itself cannot stand.', 'Abraham Lincoln', 'Speech', 'Wise', '2027-06-03'),
(221, 'An eye for an eye only ends up making the whole world blind.', 'Mahatma Gandhi', 'Lines People Say', 'Wise', '2027-06-04'),
(222, 'The best way to find yourself is to lose yourself in the service of others.', 'Mahatma Gandhi', 'Lines People Say', 'Inspirational', '2027-06-05'),
(223, 'Success is not final, failure is not fatal: it is the courage to continue that counts.', 'Winston Churchill', 'Speech', 'Motivational', '2027-06-06'),
(224, 'You miss 100% of the shots you don\'t take.', 'Wayne Gretzky', 'Lines People Say', 'Motivational', '2027-06-07'),
(225, 'The future belongs to those who believe in the beauty of their dreams.', 'Eleanor Roosevelt', 'Lines People Say', 'Inspirational', '2027-06-08'),
(226, 'Life is what happens when you\'re busy making other plans.', 'John Lennon', 'Lines People Say', 'Wise', '2027-06-09'),
(227, 'It always seems impossible until it\'s done.', 'Nelson Mandela', 'Lines People Say', 'Motivational', '2027-06-10'),
(228, 'Do one thing every day that scares you.', 'Eleanor Roosevelt', 'Lines People Say', 'Motivational', '2027-06-11'),
(229, 'Whether you think you can or you think you can\'t, you\'re right.', 'Henry Ford', 'Lines People Say', 'Wise', '2027-06-12'),
(230, 'The only way to do great work is to love what you do.', 'Steve Jobs', 'Lines People Say', 'Inspirational', '2027-06-13'),
(231, 'Science is a way of thinking much more than it is a body of knowledge.', 'Carl Sagan', 'Lines People Say', 'Wise', '2027-06-14'),
(232, 'I\'m not arguing, I\'m just explaining why I\'m right.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-15'),
(233, 'I used to think I was indecisive, but now I\'m not so sure.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-16'),
(234, 'I am so clever that sometimes I don\'t understand a single word of what I am saying.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-06-17'),
(235, 'The trouble with having an open mind is that people keep coming along and putting things in it.', 'Terry Pratchett', 'Lines People Say', 'Funny', '2027-06-18'),
(236, 'I can resist everything except temptation.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-06-19'),
(237, 'Light travels faster than sound. This is why some people appear bright until you hear them speak.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-20'),
(238, 'I\'m on a seafood diet. I see food and I eat it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-21'),
(239, 'Procrastinate now, don\'t put it off.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-22'),
(240, 'My bed is a magical place where I suddenly remember everything I forgot to do.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-23'),
(241, 'I\'m reading a book about anti-gravity. It\'s impossible to put down.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-24'),
(242, 'I told my computer I needed a break, and now it won\'t stop sending me vacation ads.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-25'),
(243, 'A balanced diet is a cookie in each hand.', 'Anonymous', 'Street Signs', 'Funny', '2027-06-26'),
(244, 'I\'m not lazy, I\'m on energy-saving mode.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-27'),
(245, 'Common sense is like deodorant. The people who need it most never use it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-28'),
(246, 'I always arrive late at the office, but I make up for it by leaving early.', 'Charles Lamb', 'Lines People Say', 'Funny', '2027-06-29'),
(247, 'Behind every great person is a surprised family.', 'Anonymous', 'Social Media Post', 'Funny', '2027-06-30'),
(248, 'The early bird gets the worm, but the second mouse gets the cheese.', 'Anonymous', 'Street Signs', 'Funny', '2027-07-01'),
(249, 'I\'m not saying I\'m Wonder Woman, I\'m just saying no one has ever seen me and Wonder Woman in the same room.', 'Anonymous', 'Social Media Post', 'Funny', '2027-07-02'),
(250, 'Life is short. Smile while you still have teeth.', 'Anonymous', 'Street Signs', 'Funny', '2027-07-03'),
(251, 'If at first you don\'t succeed, then skydiving definitely isn\'t for you.', 'Anonymous', 'Social Media Post', 'Funny', '2027-07-04'),
(252, 'Two roads diverged in a wood, and I— I took the one less traveled by.', 'Robert Frost, "The Road Not Taken" (1916)', 'Poem', 'Inspirational', '2027-07-05'),
(253, 'Hope is the thing with feathers that perches in the soul.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-07-06'),
(254, 'I celebrate myself, and sing myself.', 'Walt Whitman, "Song of Myself" (1855)', 'Poem', 'Wise', '2027-07-07'),
(255, 'Season of mists and mellow fruitfulness.', 'John Keats, "To Autumn" (1820)', 'Poem', 'Nostalgic', '2027-07-08'),
(256, 'The woods are lovely, dark and deep, but I have promises to keep.', 'Robert Frost, "Stopping by Woods on a Snowy Evening" (1923)', 'Poem', 'Nostalgic', '2027-07-09'),
(257, 'Shall I compare thee to a summer\'s day?', 'William Shakespeare, Sonnet 18', 'Poem', 'Heartwarming', '2027-07-10'),
(258, 'I wandered lonely as a cloud.', 'William Wordsworth, "I Wandered Lonely as a Cloud" (1807)', 'Poem', 'Nostalgic', '2027-07-11'),
(259, 'Tiger, Tiger, burning bright, in the forests of the night.', 'William Blake, "The Tyger" (1794)', 'Poem', 'Famous Lines', '2027-07-12'),
(260, 'If you can keep your head when all about you are losing theirs.', 'Rudyard Kipling, "If—" (1910)', 'Poem', 'Motivational', '2027-07-13'),
(261, 'Out of the night that covers me, black as the pit from pole to pole.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Wise', '2027-07-14'),
(262, 'Water, water, every where, nor any drop to drink.', 'Samuel Taylor Coleridge, "The Rime of the Ancient Mariner" (1798)', 'Poem', 'Famous Lines', '2027-07-15'),
(263, '\'Tis better to have loved and lost than never to have loved at all.', 'Alfred, Lord Tennyson, "In Memoriam A.H.H." (1850)', 'Poem', 'Heartwarming', '2027-07-16'),
(264, 'Listen, my children, and you shall hear of the midnight ride of Paul Revere.', 'Henry Wadsworth Longfellow, "Paul Revere\'s Ride" (1860)', 'Poem', 'Famous Lines', '2027-07-17'),
(265, 'By the shores of Gitche Gumee, by the shining Big-Sea-Water.', 'Henry Wadsworth Longfellow, "The Song of Hiawatha" (1855)', 'Poem', 'Nostalgic', '2027-07-18'),
(266, 'Once upon a midnight dreary, while I pondered, weak and weary.', 'Edgar Allan Poe, "The Raven" (1845)', 'Poem', 'Famous Lines', '2027-07-19'),
(267, 'What dreams may come.', 'William Shakespeare, Hamlet', 'Poem', 'Wise', '2027-07-20'),
(268, 'Turning and turning in the widening gyre, the falcon cannot hear the falconer.', 'William Butler Yeats, "The Second Coming" (1919)', 'Poem', 'Famous Lines', '2027-07-21'),
(269, 'My heart is like a singing bird.', 'Christina Rossetti, "A Birthday" (1861)', 'Poem', 'Heartwarming', '2027-07-22'),
(270, 'The world is too much with us; late and soon, getting and spending, we lay waste our powers.', 'William Wordsworth (1807)', 'Poem', 'Wise', '2027-07-23'),
(271, 'A thing of beauty is a joy for ever.', 'John Keats, "Endymion" (1818)', 'Poem', 'Inspirational', '2027-07-24'),
(272, 'The child is father of the man.', 'William Wordsworth, "My Heart Leaps Up" (1802)', 'Poem', 'Wise', '2027-07-25'),
(273, 'There is no frigate like a book to take us lands away.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-07-26'),
(274, 'Under the bludgeonings of chance my head is bloody, but unbowed.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Motivational', '2027-07-27'),
(275, 'The fog comes on little cat feet.', 'Carl Sandburg, "Fog" (1916)', 'Poem', 'Nostalgic', '2027-07-28'),
(276, 'Nature\'s first green is gold, her hardest hue to hold.', 'Robert Frost, "Nothing Gold Can Stay" (1923)', 'Poem', 'Nostalgic', '2027-07-29'),
(277, 'I must go down to the seas again, to the lonely sea and the sky.', 'John Masefield, "Sea Fever" (1902)', 'Poem', 'Wise', '2027-07-30'),
(278, 'O Captain! my Captain! our fearful trip is done.', 'Walt Whitman, "O Captain! My Captain!" (1865)', 'Poem', 'Inspirational', '2027-07-31'),
(279, 'Glory be to God for dappled things.', 'Gerard Manley Hopkins, "Pied Beauty" (1877)', 'Poem', 'Inspirational', '2027-08-01'),
(280, 'I think that I shall never see a poem lovely as a tree.', 'Joyce Kilmer, "Trees" (1913)', 'Poem', 'Nostalgic', '2027-08-02'),
(281, 'Stone walls do not a prison make, nor iron bars a cage.', 'Richard Lovelace, "To Althea, from Prison" (1642)', 'Poem', 'Wise', '2027-08-03'),
(282, 'Come live with me and be my Love.', 'Christopher Marlowe, "The Passionate Shepherd to His Love" (1599)', 'Poem', 'Heartwarming', '2027-08-04'),
(283, 'Good fences make good neighbors.', 'Robert Frost, "Mending Wall" (1914)', 'Poem', 'Wise', '2027-08-05'),
(284, 'Do not stand at my grave and weep, I am not there; I do not sleep.', 'Mary Elizabeth Frye, "Do Not Stand at My Grave and Weep" (1932)', 'Poem', 'Heartwarming', '2027-08-06'),
(285, 'When I have fears that I may cease to be.', 'John Keats, "When I Have Fears" (1818)', 'Poem', 'Nostalgic', '2027-08-07'),
(286, 'If I can stop one heart from breaking, I shall not live in vain.', 'Emily Dickinson', 'Poem', 'Heartwarming', '2027-08-08'),
(287, 'It was the best of times, it was the worst of times.', 'Charles Dickens, A Tale of Two Cities (1859)', 'Book', 'Famous Lines', '2027-08-09'),
(288, 'Call me Ishmael.', 'Herman Melville, Moby-Dick (1851)', 'Book', 'Famous Lines', '2027-08-10'),
(289, 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.', 'Jane Austen, Pride and Prejudice (1813)', 'Book', 'Famous Lines', '2027-08-11'),
(290, 'All happy families are alike; each unhappy family is unhappy in its own way.', 'Leo Tolstoy, Anna Karenina (1878)', 'Book', 'Wise', '2027-08-12'),
(291, 'In a hole in the ground there lived a hobbit.', 'J.R.R. Tolkien, The Hobbit (1937)', 'Book', 'Nostalgic', '2027-08-13'),
(292, 'Not all those who wander are lost.', 'J.R.R. Tolkien, The Fellowship of the Ring (1954)', 'Book', 'Inspirational', '2027-08-14'),
(293, 'It was a bright cold day in April, and the clocks were striking thirteen.', 'George Orwell, 1984 (1949)', 'Book', 'Famous Lines', '2027-08-15'),
(294, 'There is some good in this world, and it\'s worth fighting for.', 'J.R.R. Tolkien, The Two Towers (1954)', 'Book', 'Inspirational', '2027-08-16'),
(295, 'We accept the love we think we deserve.', 'Stephen Chbosky, The Perks of Being a Wallflower (1999)', 'Book', 'Wise', '2027-08-17'),
(296, 'So we beat on, boats against the current, borne back ceaselessly into the past.', 'F. Scott Fitzgerald, The Great Gatsby (1925)', 'Book', 'Famous Lines', '2027-08-18'),
(297, 'It does not do to dwell on dreams and forget to live.', 'J.K. Rowling, Harry Potter and the Sorcerer\'s Stone (1997)', 'Book', 'Wise', '2027-08-19'),
(298, 'Whatever our souls are made of, his and mine are the same.', 'Emily Bronte, Wuthering Heights (1847)', 'Book', 'Heartwarming', '2027-08-20'),
(299, 'The only way out of the labyrinth of suffering is to forgive.', 'John Green, Looking for Alaska (2005)', 'Book', 'Wise', '2027-08-21'),
(300, 'Tomorrow is always fresh, with no mistakes in it yet.', 'L.M. Montgomery, Anne of Green Gables (1908)', 'Book', 'Inspirational', '2027-08-22'),
(301, 'A room without books is like a body without a soul.', 'Marcus Tullius Cicero', 'Book', 'Wise', '2027-08-23'),
(302, 'I have a dream.', 'Martin Luther King Jr., Speech (1963)', 'Speech', 'Inspirational', '2027-08-24'),
(303, 'The only thing we have to fear is fear itself.', 'Franklin D. Roosevelt, Inaugural Address (1933)', 'Speech', 'Inspirational', '2027-08-25'),
(304, 'That\'s one small step for man, one giant leap for mankind.', 'Neil Armstrong (1969)', 'Speech', 'Famous Lines', '2027-08-26'),
(305, 'Ask not what your country can do for you - ask what you can do for your country.', 'John F. Kennedy, Inaugural Address (1961)', 'Speech', 'Inspirational', '2027-08-27'),
(306, 'I think, therefore I am.', 'Rene Descartes', 'Lines People Say', 'Wise', '2027-08-28'),
(307, 'The unexamined life is not worth living.', 'Socrates', 'Lines People Say', 'Wise', '2027-08-29'),
(308, 'In the middle of difficulty lies opportunity.', 'Albert Einstein', 'Lines People Say', 'Motivational', '2027-08-30'),
(309, 'Float like a butterfly, sting like a bee.', 'Muhammad Ali', 'Lines People Say', 'Motivational', '2027-08-31'),
(310, 'A house divided against itself cannot stand.', 'Abraham Lincoln', 'Speech', 'Wise', '2027-09-01'),
(311, 'An eye for an eye only ends up making the whole world blind.', 'Mahatma Gandhi', 'Lines People Say', 'Wise', '2027-09-02'),
(312, 'The best way to find yourself is to lose yourself in the service of others.', 'Mahatma Gandhi', 'Lines People Say', 'Inspirational', '2027-09-03'),
(313, 'Success is not final, failure is not fatal: it is the courage to continue that counts.', 'Winston Churchill', 'Speech', 'Motivational', '2027-09-04'),
(314, 'You miss 100% of the shots you don\'t take.', 'Wayne Gretzky', 'Lines People Say', 'Motivational', '2027-09-05'),
(315, 'The future belongs to those who believe in the beauty of their dreams.', 'Eleanor Roosevelt', 'Lines People Say', 'Inspirational', '2027-09-06'),
(316, 'Life is what happens when you\'re busy making other plans.', 'John Lennon', 'Lines People Say', 'Wise', '2027-09-07'),
(317, 'It always seems impossible until it\'s done.', 'Nelson Mandela', 'Lines People Say', 'Motivational', '2027-09-08'),
(318, 'Do one thing every day that scares you.', 'Eleanor Roosevelt', 'Lines People Say', 'Motivational', '2027-09-09'),
(319, 'Whether you think you can or you think you can\'t, you\'re right.', 'Henry Ford', 'Lines People Say', 'Wise', '2027-09-10'),
(320, 'The only way to do great work is to love what you do.', 'Steve Jobs', 'Lines People Say', 'Inspirational', '2027-09-11'),
(321, 'Science is a way of thinking much more than it is a body of knowledge.', 'Carl Sagan', 'Lines People Say', 'Wise', '2027-09-12'),
(322, 'I\'m not arguing, I\'m just explaining why I\'m right.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-13'),
(323, 'I used to think I was indecisive, but now I\'m not so sure.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-14'),
(324, 'I am so clever that sometimes I don\'t understand a single word of what I am saying.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-09-15'),
(325, 'The trouble with having an open mind is that people keep coming along and putting things in it.', 'Terry Pratchett', 'Lines People Say', 'Funny', '2027-09-16'),
(326, 'I can resist everything except temptation.', 'Oscar Wilde', 'Lines People Say', 'Funny', '2027-09-17'),
(327, 'Light travels faster than sound. This is why some people appear bright until you hear them speak.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-18'),
(328, 'I\'m on a seafood diet. I see food and I eat it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-19'),
(329, 'Procrastinate now, don\'t put it off.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-20'),
(330, 'My bed is a magical place where I suddenly remember everything I forgot to do.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-21'),
(331, 'I\'m reading a book about anti-gravity. It\'s impossible to put down.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-22'),
(332, 'I told my computer I needed a break, and now it won\'t stop sending me vacation ads.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-23'),
(333, 'A balanced diet is a cookie in each hand.', 'Anonymous', 'Street Signs', 'Funny', '2027-09-24'),
(334, 'I\'m not lazy, I\'m on energy-saving mode.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-25'),
(335, 'Common sense is like deodorant. The people who need it most never use it.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-26'),
(336, 'I always arrive late at the office, but I make up for it by leaving early.', 'Charles Lamb', 'Lines People Say', 'Funny', '2027-09-27'),
(337, 'Behind every great person is a surprised family.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-28'),
(338, 'The early bird gets the worm, but the second mouse gets the cheese.', 'Anonymous', 'Street Signs', 'Funny', '2027-09-29'),
(339, 'I\'m not saying I\'m Wonder Woman, I\'m just saying no one has ever seen me and Wonder Woman in the same room.', 'Anonymous', 'Social Media Post', 'Funny', '2027-09-30'),
(340, 'Life is short. Smile while you still have teeth.', 'Anonymous', 'Street Signs', 'Funny', '2027-10-01'),
(341, 'If at first you don\'t succeed, then skydiving definitely isn\'t for you.', 'Anonymous', 'Social Media Post', 'Funny', '2027-10-02'),
(342, 'Two roads diverged in a wood, and I— I took the one less traveled by.', 'Robert Frost, "The Road Not Taken" (1916)', 'Poem', 'Inspirational', '2027-10-03'),
(343, 'Hope is the thing with feathers that perches in the soul.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-10-04'),
(344, 'I celebrate myself, and sing myself.', 'Walt Whitman, "Song of Myself" (1855)', 'Poem', 'Wise', '2027-10-05'),
(345, 'Season of mists and mellow fruitfulness.', 'John Keats, "To Autumn" (1820)', 'Poem', 'Nostalgic', '2027-10-06'),
(346, 'The woods are lovely, dark and deep, but I have promises to keep.', 'Robert Frost, "Stopping by Woods on a Snowy Evening" (1923)', 'Poem', 'Nostalgic', '2027-10-07'),
(347, 'Shall I compare thee to a summer\'s day?', 'William Shakespeare, Sonnet 18', 'Poem', 'Heartwarming', '2027-10-08'),
(348, 'I wandered lonely as a cloud.', 'William Wordsworth, "I Wandered Lonely as a Cloud" (1807)', 'Poem', 'Nostalgic', '2027-10-09'),
(349, 'Tiger, Tiger, burning bright, in the forests of the night.', 'William Blake, "The Tyger" (1794)', 'Poem', 'Famous Lines', '2027-10-10'),
(350, 'If you can keep your head when all about you are losing theirs.', 'Rudyard Kipling, "If—" (1910)', 'Poem', 'Motivational', '2027-10-11'),
(351, 'Out of the night that covers me, black as the pit from pole to pole.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Wise', '2027-10-12'),
(352, 'Water, water, every where, nor any drop to drink.', 'Samuel Taylor Coleridge, "The Rime of the Ancient Mariner" (1798)', 'Poem', 'Famous Lines', '2027-10-13'),
(353, '\'Tis better to have loved and lost than never to have loved at all.', 'Alfred, Lord Tennyson, "In Memoriam A.H.H." (1850)', 'Poem', 'Heartwarming', '2027-10-14'),
(354, 'Listen, my children, and you shall hear of the midnight ride of Paul Revere.', 'Henry Wadsworth Longfellow, "Paul Revere\'s Ride" (1860)', 'Poem', 'Famous Lines', '2027-10-15'),
(355, 'By the shores of Gitche Gumee, by the shining Big-Sea-Water.', 'Henry Wadsworth Longfellow, "The Song of Hiawatha" (1855)', 'Poem', 'Nostalgic', '2027-10-16'),
(356, 'Once upon a midnight dreary, while I pondered, weak and weary.', 'Edgar Allan Poe, "The Raven" (1845)', 'Poem', 'Famous Lines', '2027-10-17'),
(357, 'What dreams may come.', 'William Shakespeare, Hamlet', 'Poem', 'Wise', '2027-10-18'),
(358, 'Turning and turning in the widening gyre, the falcon cannot hear the falconer.', 'William Butler Yeats, "The Second Coming" (1919)', 'Poem', 'Famous Lines', '2027-10-19'),
(359, 'My heart is like a singing bird.', 'Christina Rossetti, "A Birthday" (1861)', 'Poem', 'Heartwarming', '2027-10-20'),
(360, 'The world is too much with us; late and soon, getting and spending, we lay waste our powers.', 'William Wordsworth (1807)', 'Poem', 'Wise', '2027-10-21'),
(361, 'A thing of beauty is a joy for ever.', 'John Keats, "Endymion" (1818)', 'Poem', 'Inspirational', '2027-10-22'),
(362, 'The child is father of the man.', 'William Wordsworth, "My Heart Leaps Up" (1802)', 'Poem', 'Wise', '2027-10-23'),
(363, 'There is no frigate like a book to take us lands away.', 'Emily Dickinson', 'Poem', 'Inspirational', '2027-10-24'),
(364, 'Under the bludgeonings of chance my head is bloody, but unbowed.', 'William Ernest Henley, "Invictus" (1875)', 'Poem', 'Motivational', '2027-10-25'),
(365, 'The fog comes on little cat feet.', 'Carl Sandburg, "Fog" (1916)', 'Poem', 'Nostalgic', '2027-10-26'),
(366, 'Nature\'s first green is gold, her hardest hue to hold.', 'Robert Frost, "Nothing Gold Can Stay" (1923)', 'Poem', 'Nostalgic', '2027-10-27');

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
  MODIFY `dq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=367;

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
