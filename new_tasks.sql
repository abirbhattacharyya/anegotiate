-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Sep 08, 2009 at 10:58 AM
-- Server version: 5.0.27
-- PHP Version: 4.3.11RC1-dev

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `anegotiate`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `tasks`
-- 

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `item_id` int(11) default NULL,
  `description` text,
  `energy` int(11) default NULL,
  `risk` int(11) default NULL,
  `points` int(11) default NULL,
  `style` varchar(255) default NULL,
  `category` varchar(100) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

-- 
-- Dumping data for table `tasks`
-- 

INSERT INTO `tasks` (`id`, `item_id`, `description`, `energy`, `risk`, `points`, `style`, `category`, `created_at`, `updated_at`) VALUES 
(1, NULL, 'Say 10 times, now is a good time to shop, I can get a good deal for myself and help the economy.', 152, 74, 93, 'Aggressive', 'Shopping Skills', '2009-08-08 07:07:39', '2009-08-27 10:53:39'),
(2, 14, 'Do 10 hours of online research & haggle better when you walk into a store', 75, 64, 83, 'Neutral', 'Shopping Skills', '2009-08-08 07:07:39', '2009-08-27 10:53:39'),
(3, NULL, 'Practice asking for a 50% discount with your game face on', 44, 74, 73, 'Nice', 'Shopping Skills', '2009-08-08 07:07:39', '2009-08-27 10:53:39'),
(4, NULL, 'Turn your back and practice your "I am walking" walk. Keep your ears open in case they call you back to accept your offer', 84, 74, 93, 'Neutral', 'Shopping Skills', '2009-08-08 07:07:39', '2009-08-27 10:53:39'),
(5, NULL, 'Ask for the store manager. Say my friend just got this for 30% less, match that offer', 157, 84, 103, 'Aggressive', 'Shopping Skills', '2009-08-08 07:07:39', '2009-08-27 10:53:39'),
(6, 8, 'Don''t give up.  Keep trying new tactics and change your approach slightly. Repeat until you succeed.', 154, 74, 93, 'Aggressive', 'Perseverance', '2009-08-08 07:08:39', '2009-08-27 10:54:39'),
(7, 26, 'Thump the table with your fists.  Shout that''s it , I am walking.  If you drove, keep walking past your car in the parking lot.', 151, 87, 74, 'Aggressive', 'Bluffing', '2009-08-08 07:08:39', '2009-08-27 10:54:38'),
(8, 17, 'Playing tennis? argue over balls that lands within 6 inches of the line.', 148, 77, 94, 'Aggressive', 'Argument Skills', '2009-08-08 07:08:39', '2009-08-27 10:54:38'),
(9, 20, 'Call your opponent up and ask them, "What is the lowest offer you would accept"?', 152, 71, 76, 'Aggressive', 'Know Your Opponent', '2009-08-08 07:08:40', '2009-08-27 10:54:39'),
(10, 21, 'Take hard math classes like calculus. Do the problems by hand. Don''t use calculators or computers.', 150, 88, 94, 'Aggressive', 'Math Skills', '2009-08-08 07:08:40', '2009-08-27 10:54:39'),
(11, 28, 'Make sure you have strong alternatives available if you have to walk away from the negotiations.', 154, 87, 56, 'Aggressive', 'Alternatives', '2009-08-08 07:08:40', '2009-08-27 10:54:38'),
(12, NULL, 'Study statistics.', 150, 88, 52, 'Aggressive', 'Math Skills', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(13, 22, 'Park in downtown Palo Alto and pray that you don''t get a ticket.', 149, 74, 78, 'Aggressive', 'Guts', '2009-08-08 07:08:40', '2009-08-27 10:54:38'),
(14, NULL, 'Remember if it''s stormy, there is often a storm before a calm.', 146, 81, 94, 'Aggressive', 'Perseverance', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(15, 21, 'Share your interests, and objectives openly with your opponent.  This will help you guys put together a deal.', 154, 86, 69, 'Aggressive', 'Signaling', '2009-08-08 07:08:40', '2009-08-27 10:54:39'),
(16, NULL, 'Tell your opponent that you have alternatives.  Signal this but don''t actually discuss the specifics.', 151, 74, 86, 'Aggressive', 'Signaling', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(17, NULL, 'Pulled over by a cop for running a red light? Argue that red, orange, green, all the colors look the same to you after a few beers.', 153, 75, 95, 'Aggressive', 'Argument Skills', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(18, 27, 'Study micro-economic and macro-economic theory.  Watching Suzy Orman or CNN doesn''t count.', 153, 78, 90, 'Aggressive', 'Brains', '2009-08-08 07:08:40', '2009-08-27 10:54:38'),
(19, NULL, 'Study game theories.', 154, 79, 75, 'Aggressive', 'Math Skills', '2009-08-08 07:08:40', '2009-08-27 09:59:19'),
(20, NULL, 'Nourish and feed your BATNA. BATNA=Best Alternative to a Negotiated Arrangement.', 148, 75, 92, 'Aggressive', 'Alternatives', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(21, NULL, 'Say take it or leave it a lot.  Then chuckle like Dr.Evil from The Austin Powers movies.', 151, 84, 64, 'Aggressive', 'Bluffing', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(22, NULL, 'Ask your opponent about their interests so you can negotiate a deal.', 154, 77, 76, 'Aggressive', 'Signaling', '2009-08-08 07:08:40', '2009-08-26 06:51:44'),
(23, NULL, 'The more alternatives the better, because negotiations often break down and deals fall through.', 148, 82, 58, 'Aggressive', 'Alternatives', '2009-08-08 07:08:40', '2009-08-27 09:59:19'),
(24, NULL, 'Attend all the math parties in your neighborhood.', 150, 74, 54, 'Aggressive', 'Math Skills', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(25, 4, 'Say no way Jose to your significant other.', 154, 79, 86, 'Aggressive', 'Just Say No!', '2009-08-08 07:08:40', '2009-08-27 10:54:38'),
(26, NULL, 'Parachute out of an airplane, no tandem, no cheating now, go solo!', 154, 86, 91, 'Aggressive', 'Guts', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(27, NULL, 'Whether you are the employer or job-seeker, just say "This is not a good fit", 5 minutes in and leave the job interview.', 149, 74, 77, 'Aggressive', 'Guts', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(28, NULL, 'Talk to people that have negotiated with your opponent in the past and get the scoop.', 146, 88, 51, 'Aggressive', 'Know Your Opponent', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(29, NULL, 'Gather as much intelligence and information that you legally can about your opponent.', 149, 72, 51, 'Aggressive', 'Know Your Opponent', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(30, NULL, 'Bribe your opponent''s significant other with an expensive dinner and wine and get them to reveal deep, dark secrets.', 146, 83, 55, 'Aggressive', 'Know Your Opponent', '2009-08-08 07:08:40', '2009-08-26 06:51:45'),
(31, NULL, 'Say no to your boss. Change your Twitter status to, my boss sucks and I am looking for a new job.', 150, 70, 89, 'Aggressive', 'Just Say No!', '2009-08-08 07:08:40', '2009-08-26 06:46:03'),
(32, NULL, 'Just say no if the other kids offer you drugs. (Thanks Nancy Reagan).', 154, 85, 57, 'Aggressive', 'Just Say No!', '2009-08-08 07:08:41', '2009-08-26 06:51:45'),
(33, NULL, 'Get your opponent drunk and get them to reveal their strategy.  If they don''t drink, think of a Plan B.', 149, 82, 58, 'Aggressive', 'Know Your Opponent', '2009-08-08 07:08:41', '2009-08-26 06:51:45'),
(34, NULL, 'Learn from your mistakes and don''t make them twice.', 148, 72, 82, 'Aggressive', 'Perseverance', '2009-08-08 07:08:41', '2009-08-26 06:51:45'),
(35, NULL, 'Never reveal your alternatives to your opponent.  Write this 140 times. ', 150, 76, 58, 'Aggressive', 'Alternatives', '2009-08-08 07:08:41', '2009-08-26 06:51:45'),
(36, NULL, 'Learn the lyrics to that song that goes, No, No, No, you know the one.', 145, 79, 70, 'Aggressive', 'Just Say No!', '2009-08-08 07:08:41', '2009-08-26 06:51:45'),
(37, NULL, 'Go to the library or bookstore and get a bunch of books on negotiations theory.', 71, 56, 54, 'Neutral', 'Brains', '2009-08-08 07:10:38', '2009-08-26 06:51:45'),
(38, NULL, 'Make your alternatives stronger to increase your negotiating leverage.', 73, 42, 73, 'Neutral', 'Alternatives', '2009-08-08 07:10:38', '2009-08-27 09:59:20'),
(39, NULL, 'Learn the French for no, non.  Everything sounds better in French.', 78, 58, 75, 'Neutral', 'Just Say No!', '2009-08-08 07:10:38', '2009-08-26 06:51:45'),
(40, NULL, 'Look in the mirror.  Say, "I am good enough, I am smart enough, and my Facebook friends love me"!', 79, 49, 77, 'Neutral', 'Bluffing', '2009-08-08 07:10:38', '2009-08-26 06:51:45'),
(41, 19, 'Prepare 10 hours for every hour you have to negotiate. Pump up your confidence.', 78, 58, 92, 'Neutral', 'Confidence', '2009-08-08 07:10:38', '2009-08-27 10:54:38'),
(42, NULL, 'Say to your opponent, "Don''t make me call Donald Trump".', 73, 58, 72, 'Neutral', 'Bluffing', '2009-08-08 07:10:38', '2009-08-26 06:51:45'),
(43, NULL, 'Read good books on contracts and business law.  Go out with some lawyer that you find attractive.  Don''t let them bill you for the date.', 70, 42, 65, 'Neutral', 'Brains', '2009-08-08 07:10:38', '2009-08-27 09:59:19'),
(44, NULL, 'Read case studies of business transactions and analyze each party''s advantages and why they won or lost.', 79, 41, 68, 'Neutral', 'Brains', '2009-08-08 07:10:38', '2009-08-26 06:51:46'),
(45, NULL, 'Learn to use the Internet well. We heard it''s going to be big, really big.', 76, 45, 57, 'Neutral', 'Brains', '2009-08-08 07:10:39', '2009-08-26 06:51:46'),
(46, NULL, 'At a store and the sale ended? Argue that you deserve the discount because sales never end for good customers!', 78, 58, 65, 'Neutral', 'Argument Skills', '2009-08-08 07:10:39', '2009-08-26 06:51:46'),
(47, NULL, 'Wife wants you to do the dishes? Argue that would damage your nails and interrupt the simple pleasure of watching football.', 72, 57, 77, 'Neutral', 'Argument Skills', '2009-08-08 07:10:39', '2009-08-26 06:51:46'),
(48, NULL, 'Going out to eat with friends? Argue that junk food is actually better for you because more people do it, & wisdom of crowds never fails', 37, 31, 86, 'Nice', 'Argument Skills', '2009-08-08 07:11:49', '2009-08-27 09:59:19'),
(49, NULL, 'Walk away from an offer you don''t like and hold out for your ideal one.', 34, 24, 85, 'Nice', 'Guts', '2009-08-08 07:11:49', '2009-08-27 09:59:20'),
(50, NULL, 'Join a gym.  Actually go there once every 3 months.  But be more confident that you joined.', 31, 16, 68, 'Nice', 'Confidence', '2009-08-08 07:11:49', '2009-08-26 06:51:46'),
(51, NULL, 'Husband wants you to drive for the 3 hour trip? Argue that texting your friends is really hard when driving.', 35, 29, 81, 'Nice', 'Argument Skills', '2009-08-08 07:11:50', '2009-08-27 09:59:20'),
(52, NULL, 'Go to Atlantic City or Las Vegas.  Bet a lot of money even when you have a bad hand.  Be confident that you will lose. Don''t blame us.', 30, 31, 79, 'Nice', 'Confidence', '2009-08-08 07:11:50', '2009-08-26 06:51:46'),
(53, NULL, 'Sleep 8 hours a night. 10 if you are really tired.', 34, 33, 77, 'Nice', 'Confidence', '2009-08-08 07:11:50', '2009-08-26 06:51:46'),
(54, NULL, 'Bad grade on the test? Argue with your teacher.  Say you were distracted by a cute girl in front of the class.', 37, 24, 99, 'Nice', 'Argument Skills', '2009-08-08 07:11:50', '2009-08-27 09:59:19'),
(55, NULL, 'Bad grade on the test? Argue with your teacher.  Say you were distracted by a cute girl in front of the class.', 37, 24, 99, 'Nice', 'Argument Skills', '2009-08-08 07:11:50', '2009-08-27 09:59:19');