-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 16, 2021 at 11:52 AM
-- Server version: 5.7.31
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
CREATE DATABASE IF NOT EXISTS `beerheaven` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beerheaven`;

--
-- Dumping data for table `brewery`
--

INSERT INTO `brewery` (`id`, `user_id`, `name`, `dat_created`, `dat_opened`, `dat_closed`, `settings_json`) VALUES
(7, 3, 'hejPivo', '2021-06-15 13:57:53', NULL, NULL, NULL),
(8, 3, 'TestPivo', '2021-06-15 14:28:19', NULL, NULL, NULL),
(9, 3, 'zdravo', '2021-06-15 14:41:25', NULL, NULL, NULL);

--
-- Dumping data for table `brewery_tutorials`
--

INSERT INTO `brewery_tutorials` (`brewery_id`, `tutorial_id`, `dat_started`, `dat_completed`, `slika`) VALUES
(7, 1, NULL, NULL, ''),
(7, 2, NULL, NULL, ''),
(7, 3, NULL, NULL, ''),
(7, 4, NULL, NULL, ''),
(7, 5, NULL, NULL, ''),
(8, 1, NULL, NULL, ''),
(8, 2, NULL, NULL, ''),
(8, 3, NULL, NULL, ''),
(8, 4, NULL, NULL, ''),
(8, 5, NULL, NULL, ''),
(9, 1, NULL, NULL, ''),
(9, 2, NULL, NULL, ''),
(9, 3, NULL, NULL, ''),
(9, 4, NULL, NULL, ''),
(9, 5, NULL, NULL, '');

--
-- Dumping data for table `tutorials`
--

INSERT INTO `tutorials` (`id`, `title`, `desc`, `parent_id`, `ord`) VALUES
(1, 'Nakup opreme in čiščenje', 'Spoznajte se z opremo za varjenje piva in postopki čiščenja opreme.', NULL, 1),
(2, 'Drozganje', 'Priprava ječmenovega slada je najpomembnejši postopek v pivovarstvu.', NULL, 2),
(3, 'Kuhanje', 'Vse sestavine je potrebno dati v kotel in pričeti s kuhanjem mešanice.', NULL, 3),
(4, 'Fermentacija', 'Postopek, ki bo odločal o končni vsebnosti alkohola v pivu.', NULL, 4),
(5, 'Stekleničenje', 'Čas je za stekleničenje piva. ', NULL, 5);

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `auth_id`, `email`, `password`, `roles`, `nick_name`, `avatar`, `first_name`, `last_name`, `id_brewery`) VALUES
(1, NULL, 'tine.zorko@gmail.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', NULL, 'Tine', NULL, 'Tine', 'Zorko', NULL),
(2, NULL, 'test@test.com', '$2b$10$GZKSBE3ybJC0Jo3IA7065OFJyq3mrr9fkUjYB3VFbQ0Kijs5KTchy', NULL, NULL, NULL, 'Tine', 'Zorko', NULL),
(3, NULL, 'hej@hej.com', '$2b$10$kh6Zv.fzcFCyUImJE/8gdO2u1ETJB0biLrpR9.mqTwXo/Bv2kWL7C', NULL, NULL, NULL, 'hej', 'hej', NULL),
(4, NULL, 'keks@gmail.com', '$2b$10$ZLnrrlrcHS2boNecANsMLur44qBvoM59e3V73Qb8TDCGCys0h.8sS', NULL, NULL, NULL, 'keks', 'keksovic', NULL),
(5, NULL, 'smith@gmail.com', '$2b$10$DJwlL0fPHVhyY7gcURH46u04/HvGKXed225jKvHvBrX9fcZvcQH7i', NULL, NULL, NULL, 'Smith', 'Smithson', NULL),
(6, NULL, 'john@gmail.com', '$2b$10$B68IP0wy8d0EeTYpkS5r4.TcE5r9Y/vdlQsENwaxYF/9Bo0DCOqNu', NULL, NULL, NULL, 'John', 'Johnson', NULL),
(7, NULL, 'wilson@gmail.com', '$2b$10$baBtNJK7v1VhmiUta6PvQuWgvgNpgQxiPJpx.qDn2k7tjC8EKtN9e', NULL, NULL, NULL, 'Wiliam', 'Wilson', NULL),
(8, NULL, 'jelka@gmail.com', '$2b$10$D949jagy5kaCjsaw0I/mMOZJwSKBHz2kFYUKXpgU..HrsoP20P1i6', NULL, NULL, NULL, 'jelka', 'jerman', NULL),
(9, NULL, 'brownson@gmail.com', '$2b$10$WA2gHjDUgEqUF55Io6OUD.pyEKKgVZnlf8MkmM2nwuHc8FtEIFLPa', NULL, NULL, NULL, 'Brown', 'Brownson', NULL),
(10, NULL, 'jonson@gmail.com', '$2b$10$sM/kLTRQMG9Phn2QPMN6zOZyCDF9TLvSCB4eLrrla2GKtSIIejSp6', NULL, NULL, NULL, 'Jones', 'Jonson', NULL),
(11, NULL, 'garciason@gmail.com', '$2b$10$OoKziVpX0FlSKDSQkbYMhegewmwFsODx3x6P3NB1/0xwDSw4zGVG.', NULL, NULL, NULL, 'Garcia', 'Garciason', NULL),
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
