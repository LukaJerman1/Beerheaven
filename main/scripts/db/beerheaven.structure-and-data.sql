-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2021 at 11:08 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `beerheaven`
--
DROP DATABASE IF EXISTS `beerheaven`;
CREATE DATABASE IF NOT EXISTS `beerheaven` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beerheaven`;

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `txt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `answer_elements`
--

CREATE TABLE `answer_elements` (
  `answer_id` int(11) NOT NULL,
  `element_id` int(11) NOT NULL,
  `context` varchar(45) NOT NULL COMMENT 'Npr. ATTACHMENTS'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `brewery`
--

CREATE TABLE `brewery` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dat_created` datetime NOT NULL DEFAULT current_timestamp(),
  `dat_opened` datetime DEFAULT NULL,
  `dat_closed` datetime DEFAULT NULL,
  `settings_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Nastavitve za' CHECK (json_valid(`settings_json`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `brewery`
--
DELIMITER $$
CREATE TRIGGER `TR1_AFTER_INSERT` AFTER INSERT ON `brewery` FOR EACH ROW INSERT INTO brewery_tutorials (brewery_id, tutorial_id)
SELECT 
  NEW.ID,
  id
FROM
  tutorials
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brewery_tutorials`
--

CREATE TABLE `brewery_tutorials` (
  `brewery_id` int(11) NOT NULL,
  `tutorial_id` int(11) NOT NULL,
  `dat_started` date DEFAULT NULL COMMENT 'Kdaj smo pričeli z vadnico',
  `dat_completed` date DEFAULT NULL COMMENT 'Kdaj smo končali'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `brewery_tutorial_elements`
--

CREATE TABLE `brewery_tutorial_elements` (
  `brewery_id` int(11) NOT NULL,
  `tutorial_id` int(11) NOT NULL,
  `element_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Povezuje vadnico določene pivovarne z njenimi elementi.';

-- --------------------------------------------------------

--
-- Table structure for table `elements`
--

CREATE TABLE `elements` (
  `id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL COMMENT 'Tip elementa (slika, html, txt, boolean)',
  `txt_val` text DEFAULT NULL COMMENT 'če je tekstovna vrednost',
  `blob_val` varchar(45) DEFAULT NULL COMMENT 'Če je binarna vrednost',
  `attributes` varchar(200) DEFAULT NULL COMMENT 'Atributi elementa (html atributi, atributi slike, ..). Npr., type: HTML, attributes: class="..." ali pa type: IMG, attributes: w="100", h="50", .. ',
  `order` int(3) UNSIGNED DEFAULT NULL,
  `context` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `txt` text NOT NULL,
  `likes` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `activity` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `user_id` int(11) DEFAULT NULL,
  `dat` datetime NOT NULL COMMENT 'datum ocene',
  `score` int(1) UNSIGNED NOT NULL COMMENT 'Ocena 1-5',
  `comment` text DEFAULT NULL COMMENT 'Komentar\n',
  `brewery_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tutorials`
--

CREATE TABLE `tutorials` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `desc` text DEFAULT NULL,
  `ord` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tutorial_elements`
--

CREATE TABLE `tutorial_elements` (
  `tutorial_id` int(11) NOT NULL,
  `element_id` int(11) NOT NULL,
  `context` varchar(15) NOT NULL COMMENT 'V kakšnem kontekstu se element uporablja. Npr: DISPLAY (za prikaz, je sestavni del prikaza tutoriala), UPLOAD (je bil upload-an k tutorialu kot dokaz), CHECKED (označuje, da je tutorial bil opravljen) .. '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `auth_id` varchar(45) DEFAULT NULL COMMENT 'V primeru uporabe obstoječe rešitve (Firebase Auth), uid uporabnika',
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL COMMENT 'Če je nastavljen, se lahko uporabnik registrira z email/password',
  `roles` varchar(100) DEFAULT NULL COMMENT 'Vloge uporabnika, ločene z vejico npr. Če je prazno, gre za navadnega uporabnika. Npr.: ADMIN,ANALYST, .. Vloge se interpretirajo v programski logiki.',
  `nick_name` varchar(35) DEFAULT NULL,
  `avatar` blob DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `id_brewery` int(11) DEFAULT NULL COMMENT 'ID aktualne pivovarne'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `brewery` (`id`, `user_id`, `name`, `dat_created`, `dat_opened`, `dat_closed`, `settings_json`) VALUES
(6, 4, 'Tine\'s Brewery', '2021-06-09 00:00:00', '2021-06-15 22:28:11', NULL, NULL),
(10, 7, 'Moja nova', '2021-06-15 10:42:10', NULL, NULL, NULL),
(11, 4, 'TEstna', '2021-06-15 13:10:05', NULL, NULL, NULL);

--
-- Dumping data for table `brewery_tutorials`
--

INSERT INTO `brewery_tutorials` (`brewery_id`, `tutorial_id`, `dat_started`, `dat_completed`) VALUES
(6, 1, '2021-06-16', '2021-06-15'),
(6, 2, NULL, '2021-06-15'),
(6, 3, NULL, '2021-06-15'),
(6, 4, NULL, '2021-06-15'),
(6, 5, NULL, '2021-06-15'),
(10, 1, NULL, NULL),
(10, 2, NULL, NULL),
(10, 3, NULL, NULL),
(10, 4, NULL, NULL),
(10, 5, NULL, NULL),
(11, 1, NULL, NULL),
(11, 2, NULL, NULL),
(11, 3, NULL, NULL),
(11, 4, NULL, NULL),
(11, 5, NULL, NULL);

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `user_id`, `title`, `txt`, `likes`, `views`, `comments`, `activity`) VALUES
(27, NULL, 'test', 'test', 0, 0, 0, '2021-06-15 11:37:00');

--
-- Dumping data for table `tutorials`
--

INSERT INTO `tutorials` (`id`, `title`, `desc`, `ord`) VALUES
(1, 'Nakup opreme in čiščenje', 'Spoznajte se z opremo za varjenje piva in postopki čiščenja opreme.', 1),
(2, 'Drozganje', 'Priprava ječmenovega slada je najpomembnejši postopek v pivovarstvu.', 2),
(3, 'Kuhanje', 'Vse sestavine je potrebno dati v kotel in pričeti s kuhanjem mešanice.', 3),
(4, 'Fermentacija', 'Postopek, ki bo odločal o končni vsebnosti alkohola v pivu.', 4),
(5, 'Stekleničenje', 'Čas je za stekleničenje piva. ', 5);

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `auth_id`, `email`, `password`, `roles`, `nick_name`, `avatar`, `first_name`, `last_name`, `id_brewery`) VALUES
(4, NULL, 'test@test.com', '$2b$10$S8QOO.OMP9TIhJqgqOOEJuDKpYhIIN145/V4Mz3s/zopkJWVprEMu', NULL, NULL, NULL, 'Tine', 'Zorko', 6),
(7, NULL, 't@t.com', '$2b$10$H9lqsDtYZgGAmsSBiP0AXeIhXauB5JutGYwYBtiHN0Lozc4ClONMC', NULL, NULL, NULL, 'Tine', 'Zorko', NULL);
COMMIT;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Answers_Questions1_idx` (`question_id`),
  ADD KEY `fk_answers_users` (`user_id`);

--
-- Indexes for table `answer_elements`
--
ALTER TABLE `answer_elements`
  ADD PRIMARY KEY (`answer_id`,`element_id`),
  ADD KEY `fk_Answers_has_Elements_Elements1_idx` (`element_id`),
  ADD KEY `fk_Answers_has_Elements_Answers1_idx` (`answer_id`);

--
-- Indexes for table `brewery`
--
ALTER TABLE `brewery`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`),
  ADD KEY `fk_Brewery_Users_idx` (`user_id`);

--
-- Indexes for table `brewery_tutorials`
--
ALTER TABLE `brewery_tutorials`
  ADD PRIMARY KEY (`brewery_id`,`tutorial_id`),
  ADD KEY `fk_Brewery_has_Tutorials_Tutorials1_idx` (`tutorial_id`),
  ADD KEY `fk_Brewery_has_Tutorials_Brewery1_idx` (`brewery_id`);

--
-- Indexes for table `brewery_tutorial_elements`
--
ALTER TABLE `brewery_tutorial_elements`
  ADD PRIMARY KEY (`brewery_id`,`tutorial_id`,`element_id`),
  ADD KEY `fk1_element_id` (`element_id`);

--
-- Indexes for table `elements`
--
ALTER TABLE `elements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_questions_users` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`dat`),
  ADD UNIQUE KEY `brewery_id_UNIQUE` (`brewery_id`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  ADD KEY `fk_Ratings_Brewery1_idx` (`brewery_id`),
  ADD KEY `fk_Ratings_Users1_idx` (`user_id`);

--
-- Indexes for table `tutorials`
--
ALTER TABLE `tutorials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tutorial_elements`
--
ALTER TABLE `tutorial_elements`
  ADD PRIMARY KEY (`tutorial_id`,`element_id`),
  ADD KEY `fk_Tutorials_has_Elements_Elements1_idx` (`element_id`),
  ADD KEY `fk_Tutorials_has_Elements_Tutorials1_idx` (`tutorial_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_id_UNIQUE` (`auth_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `nick_name_UNIQUE` (`nick_name`),
  ADD UNIQUE KEY `password_UNIQUE` (`password`),
  ADD KEY `id_brewery_FK` (`id_brewery`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brewery`
--
ALTER TABLE `brewery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elements`
--
ALTER TABLE `elements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tutorials`
--
ALTER TABLE `tutorials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `fk_Answers_Questions1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_answers_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `answer_elements`
--
ALTER TABLE `answer_elements`
  ADD CONSTRAINT `fk_Answers_has_Elements_Answers1` FOREIGN KEY (`answer_id`) REFERENCES `answers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Answers_has_Elements_Elements1` FOREIGN KEY (`element_id`) REFERENCES `elements` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `brewery`
--
ALTER TABLE `brewery`
  ADD CONSTRAINT `fk_Brewery_Users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `brewery_tutorials`
--
ALTER TABLE `brewery_tutorials`
  ADD CONSTRAINT `fk_Brewery_has_Tutorials_Brewery1` FOREIGN KEY (`brewery_id`) REFERENCES `brewery` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Brewery_has_Tutorials_Tutorials1` FOREIGN KEY (`tutorial_id`) REFERENCES `tutorials` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `brewery_tutorial_elements`
--
ALTER TABLE `brewery_tutorial_elements`
  ADD CONSTRAINT `fk1_element_id` FOREIGN KEY (`element_id`) REFERENCES `elements` (`id`),
  ADD CONSTRAINT `fk2_brewery_tutorial` FOREIGN KEY (`brewery_id`,`tutorial_id`) REFERENCES `brewery_tutorials` (`brewery_id`, `tutorial_id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_questions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_Ratings_Brewery1` FOREIGN KEY (`brewery_id`) REFERENCES `brewery` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Ratings_Users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tutorial_elements`
--
ALTER TABLE `tutorial_elements`
  ADD CONSTRAINT `fk_Tutorials_has_Elements_Elements1` FOREIGN KEY (`element_id`) REFERENCES `elements` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tutorials_has_Elements_Tutorials1` FOREIGN KEY (`tutorial_id`) REFERENCES `tutorials` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `id_brewery_FK` FOREIGN KEY (`id_brewery`) REFERENCES `brewery` (`id`) ON DELETE SET NULL;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
