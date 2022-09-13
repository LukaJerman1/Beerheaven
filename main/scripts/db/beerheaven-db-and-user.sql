-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2021 at 05:17 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Ustvarimo uporabnika (geslo bh123)
-- 
DROP USER bh;
GRANT USAGE ON *.* TO `bh`@`%` IDENTIFIED BY PASSWORD '*7EB94673596AB77BFBF70981A7E64C416753D088';
GRANT ALL PRIVILEGES ON `beerheaven`.* TO `bh`@`%`;

--
-- Database: `beerheaven`
--
DROP DATABASE IF EXISTS `beerheaven`;
CREATE DATABASE IF NOT EXISTS `beerheaven` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beerheaven`;

CREATE DATABASE IF NOT EXISTS `beerheaven` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beerheaven`;

