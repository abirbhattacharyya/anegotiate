-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 27, 2009 at 07:22 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `items`
-- 

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `image_url` varchar(255) NOT NULL,
  `desc` text,
  `points` int(11) default NULL,
  `cost` int(11) default NULL,
  `category` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

-- 
-- Dumping data for table `items`
-- 

INSERT INTO `items` (`id`, `name`, `image_url`, `desc`, `points`, `cost`, `category`, `created_at`, `updated_at`) VALUES 
(1, 'Lawyer', '/images/vector-images/1.gif', 'Item 1', 19601, 7, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(2, 'Negotiator', '/images/vector-images/2.gif', 'Item 2', 23114, 2, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(3, 'Cat', '/images/vector-images/3.gif', 'Item 3', 16813, 2, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(4, 'Beer', '/images/vector-images/4.gif', 'Item 4', 20661, 2, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(5, 'Martini', '/images/vector-images/5.gif', 'Item 5', 18068, 9, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(6, 'Wine', '/images/vector-images/6.gif', 'Item 6', 23577, 9, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(7, 'Table', '/images/vector-images/7.gif', 'Item 7', 14611, 4, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(8, 'Sofa', '/images/vector-images/8.gif', 'Item 8', 12340, 6, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(9, 'Exam Paper', '/images/vector-images/9.gif', 'Item 9', 13646, 4, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(10, 'Vacuum Cleaner ', '/images/vector-images/10.gif', 'Item 10', 22696, 4, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(11, 'Dishes', '/images/vector-images/11.gif', 'Item 11', 18474, 6, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(12, 'Dog', '/images/vector-images/12.gif', 'Item 12', 24103, 3, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(13, 'Hot Shoe & Bow', '/images/vector-images/13.gif', 'Item 13', 17910, 9, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(14, 'Television', '/images/vector-images/14.gif', 'Item 14', 11224, 5, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(15, 'Salad', '/images/vector-images/15.gif', 'Item 15', 12083, 3, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(16, 'Pizza', '/images/vector-images/16.gif', 'Item 16', 22028, 8, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(17, 'Chicken', '/images/vector-images/17.gif', 'Item 17', 17856, 5, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(18, 'Telephone', '/images/vector-images/18.gif', 'Item 18', 19918, 5, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(19, 'Aircraft', '/images/vector-images/19.gif', 'Item 19', 18588, 7, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(20, 'Chocolates', '/images/vector-images/20.gif', 'Item 20', 13316, 2, 'Energy', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(21, 'Bus', '/images/vector-images/21.gif', 'Item 21', 11332, 9, 'Tools', '2009-08-20 08:10:47', '2009-08-20 08:10:47'),
(22, 'Trolley', '/images/vector-images/22.gif', 'Item 22', 24643, 2, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(23, 'Ship', '/images/vector-images/23.gif', 'Item 23', 19873, 5, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(24, 'Judge', '/images/vector-images/24.gif', 'Item 24', 19292, 5, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(25, 'Negotiator', '/images/vector-images/25.gif', 'Item 25', 20330, 3, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(26, 'Skate', '/images/vector-images/26.gif', 'Item 26', 16806, 5, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(27, 'Taxi', '/images/vector-images/27.gif', 'Item 27', 20878, 6, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48'),
(28, 'Clock', '/images/vector-images/28.gif', 'Item 28', 16982, 6, 'Tools', '2009-08-20 08:10:48', '2009-08-20 08:10:48');