-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 25, 2009 at 11:23 AM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `activities`
-- 

CREATE TABLE `activities` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `message` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `attempted_tasks`
-- 

CREATE TABLE `attempted_tasks` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `task_id` int(11) default NULL,
  `counter` int(11) default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `completed_tasks`
-- 

CREATE TABLE `completed_tasks` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `task_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `friends`
-- 

CREATE TABLE `friends` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `friend_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `items`
-- 

CREATE TABLE `items` (
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

-- --------------------------------------------------------

-- 
-- Table structure for table `lotteries`
-- 

CREATE TABLE `lotteries` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `points` int(11) default NULL,
  `won_points` int(11) default NULL,
  `lose_points` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `negotiations`
-- 

CREATE TABLE `negotiations` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `negotiate_with` int(11) default NULL,
  `won_points` int(11) default NULL,
  `lost_points` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `notifications`
-- 

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `task_done` tinyint(1) NOT NULL default '1',
  `task_fail` tinyint(1) NOT NULL default '1',
  `point_send` tinyint(1) NOT NULL default '1',
  `point_receive` tinyint(1) NOT NULL default '1',
  `lottery_win` tinyint(1) NOT NULL default '1',
  `lottery_lost` tinyint(1) NOT NULL default '1',
  `negotiation_win` tinyint(1) NOT NULL default '1',
  `negotiation_lost` tinyint(1) NOT NULL default '1',
  `negotiate` tinyint(1) NOT NULL default '1',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `points`
-- 

CREATE TABLE `points` (
  `id` int(11) NOT NULL auto_increment,
  `sender_user_id` int(11) default NULL,
  `recipient_user_id` int(11) default NULL,
  `point` mediumint(9) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `schema_migrations`
-- 

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `tasks`
-- 

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `energy` int(11) default NULL,
  `risk` int(11) default NULL,
  `points` int(11) default NULL,
  `category` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=121 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `screen_name` varchar(255) default NULL,
  `total_friends` int(11) NOT NULL default '0',
  `points` int(3) NOT NULL default '0',
  `energy` int(11) NOT NULL default '0',
  `style` varchar(255) default NULL,
  `image_url` varchar(255) default NULL,
  `location` varchar(255) default NULL,
  `token` varchar(255) default NULL,
  `secret` varchar(255) default NULL,
  `fb_uid` int(11) default NULL,
  `email` varchar(100) default NULL,
  `email_hash` varchar(255) default NULL,
  `remember_token` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;
