-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 20, 2009 at 03:29 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `own_items`
-- 

CREATE TABLE `own_items` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `item_id` int(11) default NULL,
  `qty` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;
