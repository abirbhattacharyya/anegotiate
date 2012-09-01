-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 03, 2009 at 01:54 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `screen_name` varchar(255) default NULL,
  `points` int(3) NOT NULL default '0',
  `image_url` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `token` varchar(255) default NULL,
  `secret` varchar(255) default NULL,
  `fb_uid` int(11) default NULL,
  `email` varchar(100) default NULL,
  `email_hash` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;
