-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 03, 2009 at 05:03 PM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `points`
-- 

CREATE TABLE `points` (
  `id` int(11) NOT NULL auto_increment,
  `sender_user_id` int(11) default NULL,
  `recipient_user_id` int(11) default NULL,
  `point` int(3) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;
