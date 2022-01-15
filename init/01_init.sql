# ************************************************************
# Sequel Ace SQL dump
# Version 20016
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 5.5.5-10.5.8-MariaDB-1:10.5.8+maria~focal)
# Database: cisgraderoom
# Generation Time: 2021-12-04 08:46:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table classrooms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `classrooms`;

CREATE TABLE `classrooms` (
  `classcode` varchar(7) NOT NULL DEFAULT '',
  `classname` varchar(50) NOT NULL DEFAULT '',
  `teacher` varchar(20) NOT NULL DEFAULT '',
  `section` tinyint(1) DEFAULT NULL,
  `term` tinyint(1) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`classcode`),
  KEY `teacher_username` (`teacher`),
  CONSTRAINT `teacher_username` FOREIGN KEY (`teacher`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `text` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `is_delete` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`comment_id`),
  KEY `postid_post_postid` (`post_id`),
  CONSTRAINT `postid_post_postid` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `problem_id` int(10) unsigned NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '',
  `classcode` varchar(20) NOT NULL DEFAULT '',
  `filename` varchar(50) NOT NULL DEFAULT '',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `is_delete` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`file_id`),
  KEY `problemid_problem_problrmid_file` (`problem_id`),
  KEY `username_useraccess_username_file` (`username`),
  KEY `classcode_useraccess_classcode_file` (`classcode`),
  CONSTRAINT `classcode_useraccess_classcode_file` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `problemid_problem_problrmid_file` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `username_useraccess_username_file` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `classcode` varchar(7) NOT NULL DEFAULT '',
  `text` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `is_delete` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`post_id`),
  KEY `created_at` (`created_at`),
  KEY `username_useraccess_username` (`username`),
  KEY `classcode_useraccess_classcode` (`classcode`),
  CONSTRAINT `classcode_useraccess_classcode` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
  CONSTRAINT `username_useraccess_username` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table problems
# ------------------------------------------------------------

DROP TABLE IF EXISTS `problems`;

CREATE TABLE `problems` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '',
  `classcode` varchar(7) NOT NULL DEFAULT '',
  `problem_name` varchar(50) NOT NULL DEFAULT '',
  `problem_desc` text DEFAULT NULL,
  `open_at` datetime DEFAULT NULL,
  `close_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `testcase` tinyint(4) NOT NULL DEFAULT 0,
  `max_score` double(5,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`problem_id`),
  KEY `username_useraccess_username_problem` (`username`),
  KEY `classcode_useraccess_classcode_problem` (`classcode`),
  CONSTRAINT `classcode_useraccess_classcode_problem` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
  CONSTRAINT `username_useraccess_username_problem` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table scores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `scores`;

CREATE TABLE `scores` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `classcode` varchar(7) NOT NULL DEFAULT '',
  `problem_id` int(10) unsigned NOT NULL,
  `score` double(5,2) NOT NULL DEFAULT 0.00,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`,`classcode`,`problem_id`),
  KEY `problemid_problem_problemid_score` (`problem_id`),
  KEY `classcode_classroom_classcode_score` (`classcode`),
  CONSTRAINT `classcode_classroom_classcode_score` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `problemid_problem_problemid_score` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `username_useraccess_username_score` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table submissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `submissions`;

CREATE TABLE `submissions` (
  `submission_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '',
  `classcode` varchar(20) NOT NULL DEFAULT '',
  `problem_id` int(10) unsigned NOT NULL,
  `code` text DEFAULT NULL,
  `result` varchar(15) DEFAULT NULL,
  `error` text DEFAULT NULL,
  `score` double(5,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`submission_id`),
  KEY `username_useraccess_username_submission` (`username`),
  KEY `classcode_useraccess_classcode_submission` (`classcode`),
  KEY `problemid_problem_problemid` (`problem_id`),
  CONSTRAINT `classcode_useraccess_classcode_submission` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
  CONSTRAINT `problemid_problem_problemid` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `username_useraccess_username_submission` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_access`;

CREATE TABLE `user_access` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `classcode` varchar(7) NOT NULL DEFAULT '',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`,`classcode`),
  KEY `classcode_classroom_classcode` (`classcode`),
  CONSTRAINT `classcode_classroom_classcode` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
  CONSTRAINT `username_user_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `role` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = student, 1 = teacher, 2 = superteacher',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`username`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`username`, `password`, `name`, `role`, `status`, `created_at`)
VALUES
	('6104062630301','da4d906c823f34608a2d9d4a8b812930','Thanawat Gulati',0,1,'2021-12-04 15:33:00'),
	('superteacher','6cb976a5ca8189f77e3988aee29d78b6','Super Teacher',2,1,'2021-12-03 01:12:00');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
