-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 16, 2021 at 12:00 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.3.21

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

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`id`, `question_id`, `user_id`, `txt`) VALUES
(1, 28, 8, 'You should go through all the phases in our tutorials'),
(3, 30, 8, 'https://www.homebrewing.org/Brewing-Equipment_c_133.html#:~:text=Boiling%20Equipment%20Brew%20pots%2C%20burners,%2C%20barrels%2C%20conicals%20and%20unitanks. This one should help you.'),
(4, 31, 8, 'Naučite se lahko tako, da izvedete korake v vajah na tej spletni strani'),
(5, 32, NULL, 'Naučili se boste kako narediti pivo, in odprli boste svojo pivovarno'),
(6, 30, 11, 'Go to google and paste this link above, it will help you. Also, there are a lot of other websites below this one about equipment, making beer...'),
(7, 32, NULL, 'Ko zaključite s podtutorialima, boste naredili svojo pivovarno.'),
(8, 33, NULL, 'Ja. Morate končati prvo'),
(9, 34, NULL, 'Fermentacija lahko traja od 6-8 ur ali celo do 72 ur, da pokaže kakršne koli vidne znake.'),
(10, 35, NULL, 'https://homebrewanswers.com/home-brewing-questions/#Common_Off_Flavours. Here you can find the answer to your question.'),
(11, 36, NULL, 'Če sodite 40 pintov, dodajte v pivo 2 unči sladkorja in temeljito premešajte, da se raztopi.');

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `user_id`, `title`, `txt`, `likes`, `views`, `comments`, `activity`) VALUES
(28, 8, 'how to make beer?\r\n', 'how to make beer?\r\n', 0, 0, 0, '2021-06-16 10:33:16'),
(30, 8, 'Where can I find equipment for making beer?', 'Where can I find equipment for making beer?', 0, 0, 0, '2021-06-16 11:03:19'),
(31, 8, 'Kako lahko izvedem postopek drozganja?', 'Kako lahko izvedem postopek drozganja?', 0, 0, 0, '2021-06-16 11:05:28'),
(32, NULL, 'Kaj bom dobil ko bom končal svoje vaje?', 'Kaj bom dobil ko bom končal svoje vaje?', 0, 0, 0, '2021-06-16 11:11:19'),
(33, NULL, 'Ali morem dokončat s prvo vajo, da bi delala s drugom?', 'Ali morem dokončat s prvo vajo, da bi delala s drugom?', 0, 0, 0, '2021-06-16 11:45:22'),
(34, NULL, 'Zakaj pivo ne fermentira?', 'Zakaj pivo ne fermentira?', 0, 0, 0, '2021-06-16 11:47:01'),
(35, 10, 'Kako naj shranim ostanke sestavin za kuhanje? ', 'Kako naj shranim ostanke sestavin za kuhanje? ', 0, 0, 0, '2021-06-16 11:48:25'),
(36, NULL, 'Koliko sladkorja naj uporabim pri sodu?', 'Koliko sladkorja naj uporabim pri sodu?', 0, 0, 0, '2021-06-16 11:50:41');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
