-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 31, 2009 at 05:38 PM
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

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

-- 
-- Dumping data for table `users`
-- 

INSERT INTO `users` (`id`, `screen_name`, `total_friends`, `points`, `energy`, `style`, `image_url`, `location`, `token`, `secret`, `fb_uid`, `email`, `email_hash`, `remember_token`, `created_at`, `updated_at`) VALUES 
(1, 'Ankit B. Parekh', 18, 299997, 96, 'Neutral', 'http://profile.ak.fbcdn.net/v229/23/66/q1460294948_5051.jpg', 'en_US', NULL, NULL, 1460294948, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 07:43:02', '2009-08-31 12:05:29'),
(2, 'Dhaval Parikh', 165, 732919, 500, 'Aggressive', 'http://static.ak.fbcdn.net/pics/q_silhouette.gif', 'en_US', NULL, NULL, 609896814, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 07:43:11', '2009-08-31 12:05:30'),
(3, 'gaming_zone', 1, 355250, 196, 'Aggressive', 'http://s.twimg.com/a/1250809294/images/default_profile_normal.png', '', '69215910-54xeM5RkjVF7ydcsaTWIbuBuRkmqShOuWpPuBJLvV', 'xkPwpwzwLBtz2TyDuaDTHz3EBu3wlLG0fG5nFSTbFc', NULL, NULL, NULL, NULL, '2009-08-27 07:44:21', '2009-08-31 12:05:30'),
(4, 'ankitbp', 9, 850000, 96, 'Neutral', 'http://a1.twimg.com/profile_images/188172032/2007042904091701_normal.jpg', 'Ahmedabad', '19277952-dhsMCLuFTMWALgmyORcNqDMHcAhfA5MLEBT7hqCVQ', '3UmrBLTUBbHkCgi1woWFdG5TK22k56y3S64Ke8R8CE', NULL, NULL, NULL, NULL, '2009-08-27 07:50:12', '2009-08-31 12:05:30'),
(5, 'Abir Bhattacharyya', 334, 16772, 125, 'Nice', 'http://profile.ak.fbcdn.net/v225/1763/42/q506468754_3333.jpg', 'en_US', NULL, NULL, 506468754, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 07:50:23', '2009-08-31 12:05:32'),
(6, 'RoR_Rocks', 97, 398000, 500, 'Aggressive', 'http://a3.twimg.com/profile_images/63907759/Naresh1_normal.jpg', 'Ahmedabad', '17249013-0suDog53TdkGQS2cBHsjCIRDWzMgiP51pHCodBMfG', 'eJtPOiywTVCJOo1tL3yp0KsWFuHWgNznraCbm8O7s', NULL, NULL, NULL, NULL, '2009-08-27 08:00:37', '2009-08-31 12:05:32'),
(7, 'Naresh Rana', 70, 220000, 500, 'Aggressive', 'http://profile.ak.fbcdn.net/v225/692/44/q715682354_6999.jpg', 'en_US', NULL, NULL, 715682354, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 08:15:28', '2009-08-31 12:05:33'),
(8, 'dhavalp', 65, 6465, 125, 'Nice', 'http://s.twimg.com/a/1250809294/images/default_profile_normal.png', 'India', '18426777-eEd5P5dqM3p4zq6kZ7mq8nYlCC0QAt1gUQGBDUnq7', 'cvCWtjfIrN2WPEOQBU2yARf07kCA6we45SmAMBb4', NULL, NULL, NULL, NULL, '2009-08-27 08:34:37', '2009-08-31 12:05:33'),
(9, 'Brijesh Shah', 24, 166, 500, 'Aggressive', 'http://static.ak.fbcdn.net/pics/q_silhouette.gif', 'en_US', NULL, NULL, 783802952, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 09:52:00', '2009-08-31 12:05:34'),
(10, 'Priyanka Pathak', 0, 25025, 125, 'Nice', 'http://static.ak.fbcdn.net/pics/q_silhouette.gif', 'en_US', NULL, NULL, 1376281686, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-27 15:14:28', '2009-08-31 12:05:36'),
(11, 'dharmdip', 12, 25240, 53, 'Aggressive', 'http://a1.twimg.com/profile_images/270625032/b_normal.gif', '', '48609964-uaUFKkuFe6UbXxZymVB1WfW9iZtw60X42VkZQO917', 'SnjnDcB5DRCu5WuACtJyoDMj8HQ8sqtGSfUaW0Ke2Q', NULL, NULL, NULL, NULL, '2009-08-28 03:23:11', '2009-08-31 12:05:36'),
(12, 'ABIRB123', 0, 207, 500, 'Aggressive', 'http://s.twimg.com/a/1250809294/images/default_profile_normal.png', 'united states', '15323119-Oe7UWKFHlEzgeTcM8t72CBxWmIERYnICzLyAZlwRw', 'DkAyg8f2rLHgVGOnUWztUsRMYCvP7GYUWtbUfCvoQ', NULL, NULL, NULL, NULL, '2009-08-28 05:00:09', '2009-08-31 12:05:36'),
(13, 'Ralph Manuel', 0, 9087, 500, 'Aggressive', 'http://profile.ak.fbcdn.net/v227/1297/54/q562558876_7002.jpg', 'en_US', NULL, NULL, 562558876, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-28 06:22:11', '2009-08-31 12:05:37'),
(14, 'Brijesh Shah', 51, 6185, 500, 'Aggressive', 'http://profile.ak.fbcdn.net/profile6/940/77/q715592824_7646.jpg', 'en_US', NULL, NULL, 715592824, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-28 07:49:05', '2009-08-31 12:05:38'),
(15, 'Anand R Pandey ', 41, 11750, 53, 'Aggressive', 'http://profile.ak.fbcdn.net/v229/1303/73/q716491848_147.jpg', 'en_US', NULL, NULL, 716491848, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-28 11:13:31', '2009-08-31 12:05:40'),
(16, 'remo141 ', 5, 215, 17, 'Nice', 'http://s.twimg.com/a/1251397346/images/default_profile_normal.png', '', '56103992-9XMM3l2rWci9g8aqNH8k0RUEErCI84dUxIc0qhFM', 'KJLFm4TomngRbemZta8Mi3ta9yX8zOrGf3dcepD8w0', NULL, NULL, NULL, NULL, '2009-08-28 13:44:33', '2009-08-31 12:05:40'),
(17, 'Harshal Patel', 13, 10079, 125, 'Nice', 'http://static.ak.fbcdn.net/pics/q_silhouette.gif', 'en_US', NULL, NULL, 1198952058, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-28 16:56:44', '2009-08-31 12:05:41'),
(18, 'Ram Natarajan', 0, 1554701, 101, 'Neutral', 'http://static.ak.fbcdn.net/pics/q_silhouette.gif', 'en_US', NULL, NULL, 1488303720, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-28 22:25:04', '2009-08-31 12:05:42'),
(19, 'brijeshshah', 15, 122750, 500, 'Aggressive', 'http://s.twimg.com/a/1251493570/images/default_profile_normal.png', 'india', '19284462-hX8dtIBYfQeTlpM9UxtVn7exH5vGFI3Rg7wacwGgu', 'DR7FJK7vacZ9x7gqIgeGnuU8xY4kXKj7cVkNb4zBQ', NULL, NULL, NULL, NULL, '2009-08-29 06:38:57', '2009-08-31 12:05:42'),
(20, 'mithyavadini', 22, 316, 26, 'Nice', 'http://s.twimg.com/a/1251493570/images/default_profile_normal.png', 'india', '15014419-FjuwyKjh2m73qnVsv7rUORMWZqcIPwRyx0ByhYSKq', 'S4oTBmQn2uSKmAA5ypfFZwAU9swvsoN2jQkmkT81Mo', NULL, NULL, NULL, NULL, '2009-08-29 07:30:30', '2009-08-31 12:05:42'),
(21, 'Ankit Parekh', 17, 154807, 250, 'Neutral', 'http://profile.ak.fbcdn.net/profile6/1949/30/q1066634600_8789.jpg', 'en_US', NULL, NULL, 1066634600, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-29 10:12:08', '2009-08-31 12:05:43'),
(22, 'Shreyas Parikh', 49, 106799, 125, 'Nice', 'http://profile.ak.fbcdn.net/v225/260/105/q1146639164_1828.jpg', 'en_US', NULL, NULL, 1066634600, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-29 10:51:04', '2009-08-31 12:05:45'),
(23, 'Satish Patel', 43, 13121, 250, 'Neutral', 'http://profile.ak.fbcdn.net/profile5/905/66/q717032548_4321.jpg', 'en_US', NULL, NULL, 1066634600, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-29 11:18:51', '2009-08-31 12:05:46'),
(24, 'Peyush Kumar Dixit', 265, 31368, 500, 'Aggressive', 'http://profile.ak.fbcdn.net/profile5/905/66/q717032548_4321.jpg', 'en_US', NULL, NULL, 1066634600, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-29 13:49:52', '2009-08-31 12:05:47'),
(25, 'Jigarce', 0, 33, 500, 'Aggressive', 'http://s.twimg.com/a/1251493570/images/default_profile_normal.png', 'en_US', '35418272-AlWgP8xSa4Fo6qMwUecKirLKeyPdw0rnI4yn18o', '5mEyAnc3iBV0rYNQGRKbYZNFNXJ5x9VUtZ1ClXXzB2Y', NULL, NULL, NULL, NULL, '2009-08-29 15:31:03', '2009-08-31 12:05:47'),
(26, 'naresh', 0, 36, 200, 'Aggressive', 'http://a3.twimg.com/profile_images/329191385/naresh-tweedified_normal.jpg', 'Arvada, Colorado ', '3830561-vY6S5UUbrn6NZIGd3znZz4bwydVFsjqo97wMRXQ', 'bkNXI0bkPzIJpVsP0lHzvq5TiFhr7elj2cc6s3fU', NULL, NULL, NULL, NULL, '2009-08-29 15:31:03', '2009-08-31 12:05:47'),
(27, 'Shraddha Patel', 0, 75468, 250, 'Neutral', 'http://profile.ak.fbcdn.net/v229/873/54/q1121442048_4703.', 'en_US', NULL, NULL, 1121442048, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-29 16:58:23', '2009-08-31 12:05:49'),
(28, 'Amay Parikh', 0, 11, 250, 'Neutral', 'http://profile.ak.fbcdn.net/profile5/607/89/q1705416_4284.jpg', 'en_US', NULL, NULL, 1705416, '', '0_d41d8cd98f00b204e9800998ecf8427e', NULL, '2009-08-31 10:22:59', '2009-08-31 12:05:50');