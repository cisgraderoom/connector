# ************************************************************
# Sequel Ace SQL dump
# Version 20029
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 8.0.28)
# Database: cisgraderoom
# Generation Time: 2022-03-07 13:27:28 +0000
# ************************************************************
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET
  NAMES utf8mb4;
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
    `section` tinyint DEFAULT NULL,
    `term` tinyint DEFAULT NULL,
    `year` int DEFAULT '2022',
    `is_open` tinyint(1) NOT NULL DEFAULT '1',
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`classcode`),
    KEY `classrooms_teacher_foreign` (`teacher`),
    CONSTRAINT `classrooms_teacher_foreign` FOREIGN KEY (`teacher`) REFERENCES `users` (`username`) ON DELETE RESTRICT
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table comments
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
    `comment_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `post_id` bigint unsigned NOT NULL,
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`comment_id`),
    KEY `comments_post_id_foreign` (`post_id`),
    KEY `comments_username_foreign` (`username`),
    KEY `comments_classcode_foreign` (`classcode`),
    CONSTRAINT `comments_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
    CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
    CONSTRAINT `comments_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table failed_jobs
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table files
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table migrations
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `batch` int NOT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
LOCK TABLES `migrations` WRITE;
  /*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO
  `migrations` (`id`, `migration`, `batch`)
VALUES
  (37, '2014_10_12_000000_create_users_table', 1),
  (
    38,
    '2014_10_12_100000_create_password_resets_table',
    1
  ),
  (
    39,
    '2019_08_19_000000_create_failed_jobs_table',
    1
  ),
  (
    40,
    '2019_12_14_000001_create_personal_access_tokens_table',
    1
  ),
  (
    41,
    '2021_10_12_165020_create_classrooms_table',
    1
  ),
  (
    42,
    '2021_10_13_010815_create_user_access_table',
    1
  ),
  (43, '2021_10_13_153739_create_problems_table', 1),
  (44, '2021_10_13_174326_create_posts_table', 1),
  (45, '2021_10_13_174830_create_comments_table', 1),
  (46, '2022_01_06_211157_create_files_table', 1),
  (
    47,
    '2022_02_22_221543_create_submission_table',
    1
  ),
  (48, '2022_02_23_211924_create_score_table', 1);
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
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table personal_access_tokens
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `tokenable_id` bigint unsigned NOT NULL,
    `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    `abilities` text COLLATE utf8mb4_unicode_ci,
    `last_used_at` timestamp NULL DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
    KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`, `tokenable_id`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table posts
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
    `post_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`post_id`),
    KEY `posts_username_foreign` (`username`),
    KEY `posts_classcode_foreign` (`classcode`),
    CONSTRAINT `posts_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
    CONSTRAINT `posts_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table problems
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `problems`;
CREATE TABLE `problems` (
    `problem_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `problem_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `problem_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `open_at` datetime NOT NULL DEFAULT '2022-03-07 20:26:31',
    `close_at` datetime DEFAULT NULL,
    `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `testcase` int NOT NULL,
    `max_score` double(5, 2) NOT NULL,
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`problem_id`),
    KEY `problems_username_foreign` (`username`),
    KEY `problems_classcode_foreign` (`classcode`),
    CONSTRAINT `problems_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
    CONSTRAINT `problems_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table score
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `problem_id` bigint unsigned NOT NULL,
    `score` double(5, 2) NOT NULL DEFAULT '0.00',
    PRIMARY KEY (`username`, `classcode`, `problem_id`),
    KEY `score_classcode_foreign` (`classcode`),
    KEY `score_problem_id_foreign` (`problem_id`),
    CONSTRAINT `score_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
    CONSTRAINT `score_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
    CONSTRAINT `score_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table submission
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `submission`;
CREATE TABLE `submission` (
    `submission_id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `problem_id` bigint unsigned NOT NULL,
    `code` text COLLATE utf8mb4_unicode_ci,
    `result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `score` double(5, 2) NOT NULL DEFAULT '0.00',
    `lang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL,
    PRIMARY KEY (`submission_id`),
    KEY `submission_username_foreign` (`username`),
    KEY `submission_classcode_foreign` (`classcode`),
    KEY `submission_problem_id_foreign` (`problem_id`),
    CONSTRAINT `submission_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `user_access` (`classcode`),
    CONSTRAINT `submission_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problems` (`problem_id`),
    CONSTRAINT `submission_username_foreign` FOREIGN KEY (`username`) REFERENCES `user_access` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table user_access
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `user_access`;
CREATE TABLE `user_access` (
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `classcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
    `is_delete` tinyint(1) NOT NULL DEFAULT '0',
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`username`, `classcode`),
    KEY `user_access_classcode_foreign` (`classcode`),
    CONSTRAINT `user_access_classcode_foreign` FOREIGN KEY (`classcode`) REFERENCES `classrooms` (`classcode`),
    CONSTRAINT `user_access_username_foreign` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
# Dump of table users
  # ------------------------------------------------------------
  DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `role` enum('student', 'teacher', 'superteacher') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'student',
    `status` tinyint(1) NOT NULL DEFAULT '1',
    `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `users_username_unique` (`username`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
  /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
  /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
  /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;