-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Sep 08, 2009 at 11:15 AM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `neg_categories`
-- 

DROP TABLE IF EXISTS `neg_categories`;
CREATE TABLE `neg_categories` (
  `id` int(11) NOT NULL auto_increment,
  `category` varchar(255) default NULL,
  `message` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

-- 
-- Dumping data for table `neg_categories`
-- 

INSERT INTO `neg_categories` (`id`, `category`, `message`, `created_at`, `updated_at`) VALUES 
(1, 'Work', 'I want a raise', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(2, 'Work', 'I want more vacation time, paid.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(3, 'Work', 'I want an office with a view of the Taj Mahal.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(4, 'Work', 'I want an office with a view of the Thames.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(5, 'Work', 'I want an office with a view of Central Park.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(6, 'Work', 'Give me an office with a view of the Golden Gate Bridge.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(7, 'Work', 'Give me an office on the beach at Jamaica. (The island not Queens, New York)', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(8, 'Salary', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(9, 'Lunch', 'I want to eat healthy, fresh foods for lunch.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(10, 'Lunch', 'Give me greasy, high fat, high carb, high cholesterol foods for lunch.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(11, 'Lunch', 'I want to eat an early lunch at 11:30.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(12, 'Lunch', 'Let''s have a late lunch at 2PM.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(13, 'Kids', 'I refuse to do my homework, I want to watch TV instead.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(14, 'Teacher', 'I want to have my grades bumped up to an A-.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(15, 'Husband', 'Let''s go party with your cute friends honey.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(16, 'Wife', 'Let''s stay in and watch Netflix honey.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(17, 'Boyfriend', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(18, 'Girlfriend', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(19, 'Enemy', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(20, 'Frenemy', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(21, 'Customer', 'I want all the supplies and features for free.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(22, 'Vendor', 'I want to raise my prices 10%.', '2009-08-27 12:44:27', '2009-08-27 12:44:27'),
(23, 'Dog', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(24, 'Cat', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(25, 'Mother', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(26, 'Father', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(27, 'Grandmother', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(28, 'Grandfather', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(29, 'Uncle', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(30, 'Aunt', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(31, 'Brother', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(32, 'Sister', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(33, 'Cousin', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(34, 'Boss', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(35, 'Movers', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(36, 'Cable Company', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(37, 'Cell Phone Company', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(38, 'Restaurant', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(39, 'Customer Service', 'We will find something clever to write here, hahaha', '2009-08-27 12:44:28', '2009-08-27 12:44:28'),
(40, 'Buying stuff', 'Negotiate 30% off even though the sale ended yesterday', '2009-09-08 05:44:14', '2009-09-08 05:44:14'),
(41, 'Buying stuff', 'Show an Internet price and ask the store to match it.\r\n', '2009-09-08 05:44:14', '2009-09-08 05:44:14'),
(42, 'Buying stuff', 'Negotiate over free delivery', '2009-09-08 05:44:43', '2009-09-08 05:44:43'),
(43, 'Buying stuff', 'Negotiate over extra loyalty points with your purchase.', '2009-09-08 05:44:43', '2009-09-08 05:44:43');