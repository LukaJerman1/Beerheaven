-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 16, 2021 at 01:53 PM
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
-- Dumping data for table `brewery`
--

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
(28, 8, 'how to make beer?\r\n', 'how to make beer?\r\n', 0, 0, 0, '2021-06-16 10:33:16'),
(30, 8, 'Where can I find equipment for making beer?', 'Where can I find equipment for making beer?', 0, 0, 0, '2021-06-16 11:03:19'),
(31, 8, 'Kako lahko izvedem postopek drozganja?', 'Kako lahko izvedem postopek drozganja?', 0, 0, 0, '2021-06-16 11:05:28'),
(32, NULL, 'Kaj bom dobil ko bom končal svoje vaje?', 'Kaj bom dobil ko bom končal svoje vaje?', 0, 0, 0, '2021-06-16 11:11:19'),
(33, NULL, 'Ali morem dokončat s prvo vajo, da bi delala s drugom?', 'Ali morem dokončat s prvo vajo, da bi delala s drugom?', 0, 0, 0, '2021-06-16 11:45:22'),
(34, NULL, 'Zakaj pivo ne fermentira?', 'Zakaj pivo ne fermentira?', 0, 0, 0, '2021-06-16 11:47:01'),
(35, 10, 'Kako naj shranim ostanke sestavin za kuhanje? ', 'Kako naj shranim ostanke sestavin za kuhanje? ', 0, 0, 0, '2021-06-16 11:48:25'),
(36, NULL, 'Koliko sladkorja naj uporabim pri sodu?', 'Koliko sladkorja naj uporabim pri sodu?', 0, 0, 0, '2021-06-16 11:50:41');

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `auth_id`, `email`, `password`, `roles`, `nick_name`, `avatar`, `first_name`, `last_name`, `id_brewery`) VALUES
(4, NULL, 'test@test.com', '$2b$10$S8QOO.OMP9TIhJqgqOOEJuDKpYhIIN145/V4Mz3s/zopkJWVprEMu', NULL, NULL, NULL, 'Tine', 'Zorko', 6),
(7, NULL, 't@t.com', '$2b$10$H9lqsDtYZgGAmsSBiP0AXeIhXauB5JutGYwYBtiHN0Lozc4ClONMC', NULL, NULL, NULL, 'Tine', 'Zorko', NULL),
(8, NULL, 'stevkovskam@yahoo.com', '$2b$10$hXsVec.1bPCARIOYYVuEfeOazC0TUxBM5UvbF5CMcLur52gbNKd0i', NULL, NULL, NULL, 'Megi', 'Stevkovska', NULL),
(9, NULL, 'emamitrovic@gmail.com', '$2b$10$V.h0.TdSfc31Jc3e6LYjDusLyxCTPA8zt8TkVSUVyCzWUyL3kf/Fm', NULL, NULL, NULL, 'Emilija', 'Mitrovic', NULL),
(10, NULL, 'tgolubova@hotmail.com', '$2b$10$0mlgSYYG7ZjSAPOjGteahumPgj/zTYw/ttdCRSdSEopFWB8Zko89q', NULL, NULL, NULL, 'Tanja', 'Golubova', NULL),
(11, NULL, 'dijanamit@gmail.com', '$2b$10$I2PdJxtM6zJw7Yc9K3U2IeW4q4gXyvvWRyiokIib1xUJy0Q/Pzkz.', NULL, NULL, NULL, 'Dijana', 'Mitrovic', NULL),
(12, NULL, 'miler@gmail.com', '$2b$10$adQcsyIdSDNUy66J5EA49OkR1tf8HEc9ORj3I.2MO7OIeXWtzVv0m', NULL, NULL, NULL, 'Miller', 'Millerson', NULL),
(13, NULL, 'davidson@gmail.com', '$2b$10$6ggFZ8G0cX7ihXe7c.E/w..hvyPH.9wW2PAuurDAOUIks2p4vxUcu', NULL, NULL, NULL, 'Davis', 'Davidson', NULL),
(14, NULL, 'rodrigson@gmail.com', '$2b$10$tTEiBPMuSAVw8t25U8NpWODF9SMyPIypwlX8qW6wbmwyb25a9yqtm', NULL, NULL, NULL, 'Rodriguez', 'Rodrigson', NULL),
(15, NULL, 'martinson@gmail.com', '$2b$10$cyW2luwKZZHpmfZFo8ym3.VMfx2dK2q1yVSpI7BTpxg90eSgnDOme', NULL, NULL, NULL, 'Martinez', 'Martinson', NULL),
(16, NULL, 'hernandson@gmali.com', '$2b$10$DFs7PDOBa8XmPNHQfTQcF.Ndu80rELCzsdyZ7RBfz4khh3mPxRW6K', NULL, NULL, NULL, 'Hernandez', 'Hernandson', NULL),
(17, NULL, 'lopez@yahoo.com', '$2b$10$4TVN5OqWu0zAYOMCySDwiet57NJFg3AQoBE05PbqugWYXUQ.qtHeW', NULL, NULL, NULL, 'Lopez', 'Lopeson', NULL),
(18, NULL, 'Gonzales@yahoo.com', '$2b$10$tdnm5nkERqoUHfWvn1rFouv0g2pzPd5SLHF0uJbhg8mb/RLIGLtw2', NULL, NULL, NULL, 'Gonzalez', 'Gonzalson', NULL),
(19, NULL, 'wilison@yahoo.com', '$2b$10$F6FETwr.rV7q6bzXM.jFOuxv8TJocIJoNtr3DQPYvypFC51dLwiru', NULL, NULL, NULL, 'Wilson', 'Wilison', NULL),
(20, NULL, 'andreson@yahoo.com', '$2b$10$p.npt93nWONtSqjlOYbsy.Az1S.gECg8d6dEkKxMXj4KMWzzeJsSa', NULL, NULL, NULL, 'Andre', 'Andreson', NULL),
(21, NULL, 'thomso@yahoo.com', '$2b$10$mwbFoawh3I.DxS.LwkZV2u2K23RUnDPHQcjUs4uoM4yOGE33.JTLG', NULL, NULL, NULL, 'Thomas', 'Thomson', NULL),
(22, NULL, 'taylson@yahoo.com', '$2b$10$MiiO6sAf8gVWAB8Lqz..2uDXUFEFLWZla0SU8bwBZlMVWZRwEKDtW', NULL, NULL, NULL, 'Taylor', 'Taylson', NULL),
(23, NULL, 'moorson@yahoo.com', '$2b$10$wUrgIHyaxlE1J.gYfALRL.WUgzWXsN2/AGFp/RxAzblIXa2IKDqf.', NULL, NULL, NULL, 'Moore', 'Moorson', NULL),
(24, NULL, 'jackson@yahoo.com', '$2b$10$QutDVvrNLpRUcvPVAGULGulzBSyGw6bfmv4Zu.0yVj.T4X6m6x8n6', NULL, NULL, NULL, 'Jack', 'Jackson', NULL),
(25, NULL, 'martinson@yahoo.com', '$2b$10$da1UxsphxbpEZs0O8NOZ4eJiIfK5RMjyPg7iYXWVBNGPVvqy6cxa.', NULL, NULL, NULL, 'Martin', 'Martinson', NULL),
(27, NULL, 'sussy.baka69420@triera.net', '$2b$10$CcdcNalPc5AZLKlLgb4eJO9enK4IZKnMBJJrLS1tFkZE0q8MiKYmC', NULL, NULL, NULL, 'Sussy', 'Baka', NULL),
(30, NULL, 'sergio@redbull.de', '$2b$10$JoGZgvSwW.nr0opLH9fUPemSDu.MUuFqN.Jb2BnCSDokzWD4nmgaG', NULL, NULL, NULL, 'Perez', 'Sergio', NULL),
(31, NULL, 'verstappen@gmail.com', '$2b$10$lzDVnPcF8l30X4LEyDALQOTSrmzqKA97Ncr6gJSMTGA7kxHKetAMC', NULL, NULL, NULL, 'Max', 'Verstappen', NULL),
(32, NULL, 'hamilton@gmail.com', '$2b$10$d3zrIdoasjmAITHUPtw1/uf7yd65Vd3Dvl0EcU205arZDOZvA5E7W', NULL, NULL, NULL, 'Lewis', 'Hamilton', NULL),
(33, NULL, 'norris@gmail.com', '$2b$10$B29IsWlqM6WvAK7llFpogudwtJXUVBr8dCVO/3hFXBvh3Bhy1mDLO', NULL, NULL, NULL, 'Lando', 'Norris', NULL),
(34, NULL, 'leclerc@gmail.com', '$2b$10$kxEALFqiD9Y8GFi1Xae2..M1t2fIAp8glqjMXZp58xMcdsJjSgXzW', NULL, NULL, NULL, 'Charles', 'Leclerc', NULL),
(35, NULL, 'bottas@yahoo.com', '$2b$10$Adrwi9.bTHbWyxcQXyr23O22tYgP9wNRew5DJ0eKoynJeV4T138Ka', NULL, NULL, NULL, 'Valtteri', 'Bottas', NULL),
(36, NULL, 'sainz@yahoo.com', '$2b$10$wfm9mlDo0k1CgXaPve2J3uPJ21gte9tsbHQRxkKZJbiRW2WFCEZaS', NULL, NULL, NULL, 'Carlos', 'Sainz', NULL),
(37, NULL, 'gasly@yahoo.com', '$2b$10$pqTGTS/LFm8VzFUQu5so1Okc/gIdZ7x4YNytVJSkxxLz27ySaxFWe', NULL, NULL, NULL, 'Pierre', 'Gasly', NULL),
(38, NULL, 'vettel@yahoo.com', '$2b$10$ddtYIaXxnhPk20vHn7u9NuwSU30Auy7Ym6QmG/mtzEZWO/oBZEoZi', NULL, NULL, NULL, 'Sebastian', 'Vettel', NULL),
(39, NULL, 'ricciardo@yahoo.com', '$2b$10$6to4EV9XAgHLQRSRcwd8CeaOLOjby1CJnYKcrfiwztFygT7HT8juS', NULL, NULL, NULL, 'Daniel', 'Ricciardo', NULL),
(40, NULL, 'alonso@yahoo.com', '$2b$10$6CDoeXBStWjWjTQEHQNsfu5YrSbPMaIGAMTyxae1ehC6HpVFhF0Hy', NULL, NULL, NULL, 'Fernando', 'Alonso', NULL),
(41, NULL, 'ocon@yahoo.com', '$2b$10$8ZZaQT.t7L03bKKYCbDeguedp/4ZAKg7dO26NCo0uE/uC2.8YRL4G', NULL, NULL, NULL, 'Esteban', 'Ocon', NULL),
(42, NULL, 'stroll@gmail.com', '$2b$10$IzxB4xTyPmsFyIz.KaaZPeakc/fioOXGKLNMSKvnoIp9lp8zrlzkS', NULL, NULL, NULL, 'Lance', 'Stroll', NULL),
(43, NULL, 'tsunoda@gmail.com', '$2b$10$pI5tfLGoQRTSz87y08s1I.3hvCIPLoo7Btsgtd4ZXrvjukH2oP6iq', NULL, NULL, NULL, 'Yuki', 'Tsunoda', NULL),
(44, NULL, 'raikkonen@gmail.com', '$2b$10$95C1vP09.ubQZoql6vl4XOG06E0mAlGfhfWF8x2ES4.e1Q1JlhHlG', NULL, NULL, NULL, 'Kimi', 'Raikkonen', NULL),
(45, NULL, 'giovinazzi@gmail.com', '$2b$10$J6XJOhaBVh1h1vbSHvaose.SjL/ZUXyqvxngWVHZsymFalRaiz64C', NULL, NULL, NULL, 'Antonio', 'Giovinazzi', NULL),
(46, NULL, 'schumacher@gmail.com', '$2b$10$dYh8jAFp5OiaJbtQaoWa2.fAvDTlKd85M7/DK4eijZyGJVLG969gm', NULL, NULL, NULL, 'Mick', 'Schumacher', NULL),
(47, NULL, 'russel@gmail.com', '$2b$10$dnY2EuSIwYvqs489U/RaF.J2xH3csB1k0Bzs4dQ.LwQd3hpPKTmyO', NULL, NULL, NULL, 'George', 'Russel', NULL),
(48, NULL, 'mazepin@yahoo.com', '$2b$10$i.oJcpPIqH62.rlZ40uiJuzYMzFinJHUncSK80gedj29mVnuiEJF.', NULL, NULL, NULL, 'Nikita', 'Mazepin', NULL),
(49, NULL, 'latifi@gmail.com', '$2b$10$UrQ/nGEej5AI6exkrOTgjOA54cDnRCwwrG9XlTrQ1SPhqRuft2gV6', NULL, NULL, NULL, 'Nicholas', 'Latifi', NULL),
(50, NULL, 'omerzu@gmail.com', '$2b$10$4XjpKScyeTi7WVf6t2ERJ.3EsewAiNm9t3C1TqxVrPpQ2xIdfOZrq', NULL, NULL, NULL, 'Zan', 'Omerzu', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
