# ************************************************************
# Sequel Ace SQL dump
# Version 20031
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 5.5.5-10.5.8-MariaDB-1:10.5.8+maria~focal)
# Database: cisgraderoom
# Generation Time: 2022-03-28 09:38:01 +0000
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
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` tinyint(4) DEFAULT NULL,
  `term` tinyint(4) DEFAULT NULL,
  `year` int(11) DEFAULT 2022,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`classcode`),
  KEY `classrooms_teacher_foreign` (`teacher`),
  CONSTRAINT `classrooms_teacher_foreign` FOREIGN KEY (`teacher`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comments_post_id_foreign` (`post_id`),
  KEY `comments_username_foreign` (`username`),
  KEY `comments_classcode_foreign` (`classcode`),
  CONSTRAINT `comments_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `comments_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table failed_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` enum('J','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(10,'2022_01_06_211157_create_files_table',1),
	(41,'2014_10_12_000000_create_users_table',2),
	(42,'2014_10_12_100000_create_password_resets_table',2),
	(43,'2019_08_19_000000_create_failed_jobs_table',2),
	(44,'2019_12_14_000001_create_personal_access_tokens_table',2),
	(45,'2021_10_12_165020_create_classrooms_table',2),
	(46,'2021_10_13_010815_create_user_access_table',2),
	(47,'2021_10_13_153739_create_problems_table',2),
	(48,'2021_10_13_174326_create_posts_table',2),
	(49,'2021_10_13_174830_create_comments_table',2),
	(50,'2022_02_22_221543_create_submission_table',2),
	(51,'2022_02_23_211924_create_score_table',2),
	(52,'2022_03_22_202840_create_jobs_table',2),
	(53,'2022_03_22_204332_create_plagiarism_table',2);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_username_index` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table personal_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table plagiarism
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plagiarism`;

CREATE TABLE `plagiarism` (
  `owner` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `compare` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_id` bigint(20) unsigned NOT NULL,
  `result` double(5,2) NOT NULL,
  PRIMARY KEY (`owner`,`compare`,`problem_id`),
  KEY `plagiarism_compare_foreign` (`compare`),
  KEY `plagiarism_problem_id_foreign` (`problem_id`),
  CONSTRAINT `plagiarism_compare_foreign` FOREIGN KEY (`compare`) REFERENCES `users` (`username`),
  CONSTRAINT `plagiarism_owner_foreign` FOREIGN KEY (`owner`) REFERENCES `users` (`username`),
  CONSTRAINT `plagiarism_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `post_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `posts_username_foreign` (`username`),
  KEY `posts_classcode_foreign` (`classcode`),
  CONSTRAINT `posts_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `posts_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table problems
# ------------------------------------------------------------

DROP TABLE IF EXISTS `problems`;

CREATE TABLE `problems` (
  `problem_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `problem_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `open_at` datetime NOT NULL DEFAULT '2022-03-28 16:35:16',
  `close_at` datetime NOT NULL DEFAULT '2022-03-28 16:35:16',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `testcase` int(11) NOT NULL,
  `max_score` double(5,2) NOT NULL,
  `asset` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_limit` int(11) NOT NULL DEFAULT 1,
  `mem_limit` int(11) NOT NULL DEFAULT 2,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`problem_id`),
  KEY `problems_username_foreign` (`username`),
  KEY `problems_classcode_foreign` (`classcode`),
  CONSTRAINT `problems_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `problems_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table score
# ------------------------------------------------------------

DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_id` bigint(20) unsigned NOT NULL,
  `score` double(5,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`username`,`classcode`,`problem_id`),
  KEY `score_classcode_foreign` (`classcode`),
  KEY `score_problem_id_foreign` (`problem_id`),
  CONSTRAINT `score_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `score_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `score_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table submission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `submission`;

CREATE TABLE `submission` (
  `submission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problem_id` bigint(20) unsigned NOT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `score` double(5,2) NOT NULL DEFAULT 0.00,
  `lang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`submission_id`),
  KEY `submission_username_foreign` (`username`),
  KEY `submission_classcode_foreign` (`classcode`),
  KEY `submission_problem_id_foreign` (`problem_id`),
  CONSTRAINT `submission_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
  CONSTRAINT `submission_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
  CONSTRAINT `submission_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table user_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_access`;

CREATE TABLE `user_access` (
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`username`,`classcode`),
  KEY `user_access_classcode_foreign` (`classcode`),
  CONSTRAINT `user_access_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
  CONSTRAINT `user_access_username_foreign` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('student','teacher','superteacher') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'student',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `password`, `role`, `status`, `name`, `created_at`, `updated_at`)
VALUES
	(1,'superteacher','$2y$10$BTeESeVH77zOHguZnynmMew8mF1qpSH03KcIeB9B6wFX3fU5.DhFC','superteacher',1,'SuperTeacher','2022-03-28 16:37:45','2022-03-28 16:37:45'),
	(2,'teacher','$2y$10$zwZAZKJ74tifQazihBt3ZO3AnXyXcqAWCZ2d8ebYyC/KLQloK2TQK','teacher',1,'อาจารย์ทดสอบ','2022-03-28 16:37:45','2022-03-28 16:37:45'),
	(3,'student01','$2y$10$a.r81OSNK7wCAtA6LhXDT.MtD1f8X7K5g4.HvYr4TkyOOI5.fG1qW','student',1,'นักเรียนทดสอบ','2022-03-28 16:37:45','2022-03-28 16:37:45');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
