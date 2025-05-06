-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.42 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for laravel
CREATE DATABASE IF NOT EXISTS `laravel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laravel`;

-- Dumping structure for procedure laravel.add_service_comment
DROP PROCEDURE IF EXISTS `add_service_comment`;
DELIMITER //
CREATE PROCEDURE `add_service_comment`(
            IN _service_id BIGINT,
            IN _user_id BIGINT,
            IN _comment TEXT
        )
BEGIN
            INSERT INTO service_comments (service_id, user_id, comment, created_at, updated_at)
            VALUES (_service_id, _user_id, _comment, NOW(), NOW());
        END//
DELIMITER ;

-- Dumping structure for table laravel.bookings
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `booking_date` date NOT NULL,
  `booking_details` text COLLATE utf8mb4_general_ci,
  `booking_location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_method` enum('cash','card','online') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cash',
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','ongoing','done','cancel') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `service_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `owner_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookings_tracking_number_unique` (`tracking_number`),
  KEY `bookings_service_id_foreign` (`service_id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_owner_id_foreign` (`owner_id`),
  CONSTRAINT `bookings_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.booking_details_v2
DROP VIEW IF EXISTS `booking_details_v2`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `booking_details_v2` (
	`booking_id` BIGINT UNSIGNED NOT NULL,
	`booking_date` DATETIME NULL,
	`booking_status` ENUM('pending','cancel','done','accept') NOT NULL COLLATE 'utf8mb4_general_ci',
	`payment_method` ENUM('cash','card','online') NOT NULL COLLATE 'utf8mb4_general_ci',
	`booking_address` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`booking_duration` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`booking_lat` DECIMAL(10,7) NULL,
	`booking_long` DECIMAL(10,7) NULL,
	`booking_created_at` TIMESTAMP NULL,
	`booking_updated_at` TIMESTAMP NULL,
	`customer_id` BIGINT UNSIGNED NULL,
	`fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`customer_image` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`customer_firstname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`customer_lastname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`customer_email` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`customer_phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_id` BIGINT UNSIGNED NULL,
	`service_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`service_price` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_description` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_status` ENUM('active','inactive') NULL COLLATE 'utf8mb4_general_ci',
	`category_id` BIGINT UNSIGNED NULL,
	`category_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`category_description` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`technician_id` BIGINT UNSIGNED NULL,
	`technician_firstname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`technician_lastname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`technician_email` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_id` BIGINT UNSIGNED NULL,
	`shop_user_id` BIGINT UNSIGNED NULL,
	`shop_user_fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_user_image_path` MEDIUMTEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_address` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_lat` DECIMAL(10,7) NULL,
	`shop_long` DECIMAL(10,7) NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.booking_v2_s
DROP TABLE IF EXISTS `booking_v2_s`;
CREATE TABLE IF NOT EXISTS `booking_v2_s` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `booking_date` datetime DEFAULT NULL,
  `booking_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `booking_duration` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `booking_lat` decimal(10,7) DEFAULT NULL,
  `booking_long` decimal(10,7) DEFAULT NULL,
  `booking_status` enum('pending','cancel','done','accept') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `payment_method` enum('cash','card','online') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cash',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_v2_s_service_id_foreign` (`service_id`),
  KEY `booking_v2_s_customer_id_foreign` (`customer_id`),
  CONSTRAINT `booking_v2_s_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_v2_s_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `service_v2_s` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.cancels
DROP TABLE IF EXISTS `cancels`;
CREATE TABLE IF NOT EXISTS `cancels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint unsigned NOT NULL,
  `reason` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cancels_booking_id_foreign` (`booking_id`),
  CONSTRAINT `cancels_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL,
  `service_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_service_id_foreign` (`service_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_parent_id_foreign` (`parent_id`),
  CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `connection` text COLLATE utf8mb4_general_ci NOT NULL,
  `queue` text COLLATE utf8mb4_general_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.full_service_view
DROP VIEW IF EXISTS `full_service_view`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `full_service_view` (
	`service_id` BIGINT UNSIGNED NULL,
	`service_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`price` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_description` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_status` ENUM('active','inactive') NULL COLLATE 'utf8mb4_general_ci',
	`service_image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`service_created_at` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`service_client` BIGINT NULL,
	`service_rate_id` BIGINT UNSIGNED NULL,
	`service_rate_user_id` BIGINT UNSIGNED NULL,
	`service_rate` TINYINT UNSIGNED NULL,
	`service_rate_created_at` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`average_rating` DECIMAL(6,2) NULL,
	`total_reviews` BIGINT NULL,
	`shop_id` BIGINT UNSIGNED NOT NULL,
	`shop_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_address` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_lat` DECIMAL(10,7) NULL,
	`shop_long` DECIMAL(10,7) NULL,
	`technician_id` BIGINT UNSIGNED NOT NULL,
	`technician_user_id` BIGINT UNSIGNED NOT NULL,
	`technician_fullname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`technician_firstname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`technician_lastname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`technician_email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`technician_phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_owner_id` BIGINT UNSIGNED NOT NULL,
	`shop_owner_fullname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_owner_firstname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_owner_lastname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_owner_email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_owner_user_status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`category_id` BIGINT UNSIGNED NOT NULL,
	`category_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`category_description` TEXT NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for procedure laravel.get_user_services_provider
DROP PROCEDURE IF EXISTS `get_user_services_provider`;
DELIMITER //
CREATE PROCEDURE `get_user_services_provider`(IN userId INT)
BEGIN
                SELECT 
                    user_id,
                    user_name,
                    email,
                    role,
                    status,
                    phone,
                    address_street,
                    address_city,
                    address_state,
                    address_zip_code,
                    image_path,
                    mobile_auth,
                    service_id,
                    service_name,
                    service_description,
                    service_fee,
                    service_photo,
                    is_public,
                    service_created_at,
                    service_updated_at
                FROM 
                    view_user_services_provider
                WHERE 
                    user_id = userId;
            END//
DELIMITER ;

-- Dumping structure for table laravel.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint unsigned NOT NULL,
  `receiver_id` bigint unsigned NOT NULL,
  `reply_to_id` bigint unsigned DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_edited` tinyint(1) NOT NULL DEFAULT '0',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_receiver_id_foreign` (`receiver_id`),
  KEY `messages_reply_to_id_foreign` (`reply_to_id`),
  CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_reply_to_id_foreign` FOREIGN KEY (`reply_to_id`) REFERENCES `messages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.notifications
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_general_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.personal_access_tokens
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_general_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for procedure laravel.rate_service
DROP PROCEDURE IF EXISTS `rate_service`;
DELIMITER //
CREATE PROCEDURE `rate_service`(
            IN _service_id BIGINT,
            IN _user_id BIGINT,
            IN _rating TINYINT
        )
BEGIN
            IF _rating >= 1 AND _rating <= 5 THEN
                INSERT INTO service_ratings (service_id, user_id, rating, created_at, updated_at)
                VALUES (_service_id, _user_id, _rating, NOW(), NOW());
            END IF;
        END//
DELIMITER ;

-- Dumping structure for procedure laravel.rate_shop
DROP PROCEDURE IF EXISTS `rate_shop`;
DELIMITER //
CREATE PROCEDURE `rate_shop`(
            IN _shop_id BIGINT,
            IN _user_id BIGINT,
            IN _rating TINYINT
        )
BEGIN
            IF _rating >= 1 AND _rating <= 5 THEN
                INSERT INTO shop_ratings (shop_id, user_id, rating, created_at, updated_at)
                VALUES (_shop_id, _user_id, _rating, NOW(), NOW());
            END IF;
        END//
DELIMITER ;

-- Dumping structure for procedure laravel.rate_technician
DROP PROCEDURE IF EXISTS `rate_technician`;
DELIMITER //
CREATE PROCEDURE `rate_technician`(
            IN _technician_id BIGINT,
            IN _user_id BIGINT,
            IN _rating TINYINT
        )
BEGIN
            IF _rating >= 1 AND _rating <= 5 THEN
                INSERT INTO technician_ratings (technician_id, user_id, rating, created_at, updated_at)
                VALUES (_technician_id, _user_id, _rating, NOW(), NOW());
            END IF;
        END//
DELIMITER ;

-- Dumping structure for table laravel.ratings
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ratings_service_id_foreign` (`service_id`),
  KEY `ratings_user_id_foreign` (`user_id`),
  CONSTRAINT `ratings_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for procedure laravel.reply_to_service_comment
DROP PROCEDURE IF EXISTS `reply_to_service_comment`;
DELIMITER //
CREATE PROCEDURE `reply_to_service_comment`(
            IN _comment_id BIGINT,
            IN _user_id BIGINT,
            IN _reply TEXT
        )
BEGIN
            INSERT INTO service_comment_replies (comment_id, user_id, reply, created_at, updated_at)
            VALUES (_comment_id, _user_id, _reply, NOW(), NOW());
        END//
DELIMITER ;

-- Dumping structure for table laravel.services
DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `service_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `photo_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '/images/no-image-1.png',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_user_id_foreign` (`user_id`),
  CONSTRAINT `services_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.service_average_ratings
DROP VIEW IF EXISTS `service_average_ratings`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `service_average_ratings` (
	`service_id` BIGINT UNSIGNED NOT NULL,
	`average_rating` DECIMAL(6,2) NULL,
	`total_reviews` BIGINT NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.service_comments
DROP TABLE IF EXISTS `service_comments`;
CREATE TABLE IF NOT EXISTS `service_comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_comments_service_id_foreign` (`service_id`),
  KEY `service_comments_user_id_foreign` (`user_id`),
  CONSTRAINT `service_comments_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `service_v2_s` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.service_comments_view
DROP VIEW IF EXISTS `service_comments_view`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `service_comments_view` (
	`fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`comment_id` BIGINT UNSIGNED NULL,
	`service_id` BIGINT UNSIGNED NULL,
	`average_rating` DECIMAL(6,2) NULL,
	`user_id` BIGINT UNSIGNED NULL,
	`comment` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NULL,
	`updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.service_comment_replies
DROP TABLE IF EXISTS `service_comment_replies`;
CREATE TABLE IF NOT EXISTS `service_comment_replies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `reply` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_comment_replies_comment_id_foreign` (`comment_id`),
  KEY `service_comment_replies_user_id_foreign` (`user_id`),
  CONSTRAINT `service_comment_replies_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `service_comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_comment_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.service_comment_replies_view
DROP VIEW IF EXISTS `service_comment_replies_view`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `service_comment_replies_view` (
	`fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`reply_id` BIGINT UNSIGNED NOT NULL,
	`comment_id` BIGINT UNSIGNED NOT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`reply` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NULL,
	`updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.service_ratings
DROP TABLE IF EXISTS `service_ratings`;
CREATE TABLE IF NOT EXISTS `service_ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_ratings_service_id_foreign` (`service_id`),
  KEY `service_ratings_user_id_foreign` (`user_id`),
  CONSTRAINT `service_ratings_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `service_v2_s` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.service_v2_s
DROP TABLE IF EXISTS `service_v2_s`;
CREATE TABLE IF NOT EXISTS `service_v2_s` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` bigint unsigned NOT NULL,
  `technician_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `service_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_path` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `service_v2_s_shop_id_foreign` (`shop_id`),
  KEY `service_v2_s_technician_id_foreign` (`technician_id`),
  KEY `service_v2_s_category_id_foreign` (`category_id`),
  CONSTRAINT `service_v2_s_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_v2_s_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_v2_s_technician_id_foreign` FOREIGN KEY (`technician_id`) REFERENCES `technicians` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.shops
DROP TABLE IF EXISTS `shops`;
CREATE TABLE IF NOT EXISTS `shops` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `shop_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shop_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shop_details` text COLLATE utf8mb4_general_ci,
  `shop_lat` decimal(10,7) DEFAULT NULL,
  `shop_long` decimal(10,7) DEFAULT NULL,
  `status` enum('pending','active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `shop_image` text COLLATE utf8mb4_general_ci,
  `shop_national_id` text COLLATE utf8mb4_general_ci,
  `cor` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shops_user_id_foreign` (`user_id`),
  CONSTRAINT `shops_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.shop_ratings
DROP TABLE IF EXISTS `shop_ratings`;
CREATE TABLE IF NOT EXISTS `shop_ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_ratings_shop_id_foreign` (`shop_id`),
  KEY `shop_ratings_user_id_foreign` (`user_id`),
  CONSTRAINT `shop_ratings_shop_id_foreign` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shop_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.shop_with_services_json
DROP VIEW IF EXISTS `shop_with_services_json`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `shop_with_services_json` (
	`shop_id` BIGINT UNSIGNED NOT NULL,
	`shop_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_address` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_details` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_lat` DECIMAL(10,7) NULL,
	`shop_long` DECIMAL(10,7) NULL,
	`services` JSON NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.technicians
DROP TABLE IF EXISTS `technicians`;
CREATE TABLE IF NOT EXISTS `technicians` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `shop_id` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `technicians_user_id_foreign` (`user_id`),
  CONSTRAINT `technicians_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table laravel.technician_ratings
DROP TABLE IF EXISTS `technician_ratings`;
CREATE TABLE IF NOT EXISTS `technician_ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `technician_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `technician_ratings_technician_id_foreign` (`technician_id`),
  KEY `technician_ratings_user_id_foreign` (`user_id`),
  CONSTRAINT `technician_ratings_technician_id_foreign` FOREIGN KEY (`technician_id`) REFERENCES `technicians` (`id`) ON DELETE CASCADE,
  CONSTRAINT `technician_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.unified_ratings_view
DROP VIEW IF EXISTS `unified_ratings_view`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `unified_ratings_view` (
	`type` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`rating_id` BIGINT UNSIGNED NULL,
	`average_rating` DECIMAL(6,2) NULL,
	`total_reviews` BIGINT NOT NULL,
	`reference_id` BIGINT UNSIGNED NOT NULL,
	`service_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`fullname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`user_id` BIGINT UNSIGNED NULL,
	`rating` TINYINT UNSIGNED NULL,
	`created_at` TIMESTAMP NULL,
	`shop_id` DECIMAL(20,0) NULL,
	`technician_id` BIGINT UNSIGNED NULL
) ENGINE=MyISAM;

-- Dumping structure for table laravel.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` enum('user','admin','provider','customer','technician') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `phone` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_street` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_city` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_state` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_zip_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image_path` text COLLATE utf8mb4_general_ci,
  `mobile_auth` enum('authenticated','unauthenticated') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'unauthenticated',
  `user_type` enum('provider','technician','customer') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for view laravel.user_conversations_view
DROP VIEW IF EXISTS `user_conversations_view`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `user_conversations_view` (
	`id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`image_path` MEDIUMTEXT NULL COLLATE 'utf8mb4_general_ci',
	`role` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`latest_message_time` TIMESTAMP NULL,
	`latest_message` MEDIUMTEXT NULL COLLATE 'utf8mb4_general_ci',
	`is_read` TINYINT NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_booking_user_id
DROP VIEW IF EXISTS `view_booking_user_id`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_booking_user_id` (
	`service_id` BIGINT UNSIGNED NOT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_service_feedback
DROP VIEW IF EXISTS `view_service_feedback`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_service_feedback` (
	`name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fullname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`comment_id` BIGINT UNSIGNED NOT NULL,
	`service_id` BIGINT UNSIGNED NOT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`comment` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`rating_id` BIGINT UNSIGNED NULL,
	`rating` TINYINT UNSIGNED NULL,
	`comment_created_at` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`rating_created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_technicians
DROP VIEW IF EXISTS `view_technicians`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_technicians` (
	`technician_id` BIGINT UNSIGNED NOT NULL,
	`user_id` BIGINT UNSIGNED NULL,
	`name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`firstname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`lastname` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_id` BIGINT UNSIGNED NULL,
	`shop_name` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_address` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`shop_lat` DECIMAL(10,7) NULL,
	`shop_long` DECIMAL(10,7) NULL,
	`technician_created_at` TIMESTAMP NULL,
	`technician_updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_users_without_shops
DROP VIEW IF EXISTS `view_users_without_shops`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_users_without_shops` (
	`id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`firstname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`lastname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_street` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_city` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_state` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_zip_code` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`role` ENUM('user','admin','provider','customer','technician') NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_users_with_shops
DROP VIEW IF EXISTS `view_users_with_shops`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_users_with_shops` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`firstname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`lastname` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`role` ENUM('user','admin','provider','customer','technician') NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_street` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_city` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_state` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_zip_code` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`mobile_auth` ENUM('authenticated','unauthenticated') NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_id` BIGINT UNSIGNED NOT NULL,
	`shop_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_address` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_details` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_status` ENUM('pending','active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`shop_lat` DECIMAL(10,7) NULL,
	`shop_long` DECIMAL(10,7) NULL,
	`shop_image` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_national_id` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`cor` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`shop_created_at` TIMESTAMP NULL,
	`shop_updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_user_services
DROP VIEW IF EXISTS `view_user_services`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_user_services` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`user_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`role` ENUM('user','admin','provider','customer','technician') NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_street` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_city` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_state` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_zip_code` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`mobile_auth` ENUM('authenticated','unauthenticated') NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_id` BIGINT UNSIGNED NOT NULL,
	`service_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_description` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`service_fee` DECIMAL(10,2) NOT NULL,
	`service_photo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`is_public` TINYINT(1) NOT NULL,
	`service_created_at` TIMESTAMP NULL,
	`service_updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_user_services_comments_ratings
DROP VIEW IF EXISTS `view_user_services_comments_ratings`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_user_services_comments_ratings` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`user_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`role` ENUM('user','admin','provider','customer','technician') NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_street` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_city` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_state` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_zip_code` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`mobile_auth` ENUM('authenticated','unauthenticated') NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_id` BIGINT UNSIGNED NOT NULL,
	`service_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_description` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`service_fee` DECIMAL(10,2) NOT NULL,
	`service_photo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`is_public` TINYINT(1) NOT NULL,
	`service_created_at` TIMESTAMP NULL,
	`service_updated_at` TIMESTAMP NULL,
	`comment_id` BIGINT UNSIGNED NULL,
	`comment_parent_id` BIGINT UNSIGNED NULL,
	`comment_text` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`comment_created_at` TIMESTAMP NULL,
	`comment_updated_at` TIMESTAMP NULL,
	`comment_user_id` BIGINT UNSIGNED NULL,
	`service_rating` TINYINT UNSIGNED NULL
) ENGINE=MyISAM;

-- Dumping structure for view laravel.view_user_services_provider
DROP VIEW IF EXISTS `view_user_services_provider`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `view_user_services_provider` (
	`user_id` BIGINT UNSIGNED NOT NULL,
	`user_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`role` ENUM('user','admin','provider','customer','technician') NOT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_street` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_city` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_state` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`address_zip_code` VARCHAR(1) NULL COLLATE 'utf8mb4_general_ci',
	`image_path` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`mobile_auth` ENUM('authenticated','unauthenticated') NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_id` BIGINT UNSIGNED NOT NULL,
	`service_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`service_description` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`service_fee` DECIMAL(10,2) NOT NULL,
	`service_photo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`is_public` TINYINT(1) NOT NULL,
	`service_created_at` TIMESTAMP NULL,
	`service_updated_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `booking_details_v2`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `booking_details_v2` AS select `b`.`id` AS `booking_id`,`b`.`booking_date` AS `booking_date`,`b`.`booking_status` AS `booking_status`,`b`.`payment_method` AS `payment_method`,`b`.`booking_address` AS `booking_address`,`b`.`booking_duration` AS `booking_duration`,`b`.`booking_lat` AS `booking_lat`,`b`.`booking_long` AS `booking_long`,`b`.`created_at` AS `booking_created_at`,`b`.`updated_at` AS `booking_updated_at`,`c`.`id` AS `customer_id`,`c`.`name` AS `fullname`,`c`.`image_path` AS `customer_image`,`c`.`firstname` AS `customer_firstname`,`c`.`lastname` AS `customer_lastname`,`c`.`email` AS `customer_email`,`c`.`phone` AS `customer_phone`,`s`.`id` AS `service_id`,`s`.`service_name` AS `service_name`,`s`.`image_path` AS `service_image_path`,`s`.`price` AS `service_price`,`s`.`description` AS `service_description`,`s`.`status` AS `service_status`,`cat`.`id` AS `category_id`,`cat`.`category_name` AS `category_name`,`cat`.`description` AS `category_description`,`t`.`id` AS `technician_id`,`utech`.`firstname` AS `technician_firstname`,`utech`.`lastname` AS `technician_lastname`,`utech`.`email` AS `technician_email`,`shop`.`id` AS `shop_id`,`shop`.`user_id` AS `shop_user_id`,(select concat(`users`.`firstname`,' ',`users`.`lastname`) from `users` where (`users`.`id` = `shop`.`user_id`)) AS `shop_user_fullname`,(select `users`.`image_path` from `users` where (`users`.`id` = `shop`.`user_id`)) AS `shop_user_image_path`,`shop`.`shop_name` AS `shop_name`,`shop`.`shop_address` AS `shop_address`,`shop`.`shop_lat` AS `shop_lat`,`shop`.`shop_long` AS `shop_long` from ((((((`booking_v2_s` `b` left join `users` `c` on((`b`.`customer_id` = `c`.`id`))) left join `service_v2_s` `s` on((`b`.`service_id` = `s`.`id`))) left join `categories` `cat` on((`s`.`category_id` = `cat`.`id`))) left join `technicians` `t` on((`s`.`technician_id` = `t`.`id`))) left join `users` `utech` on((`t`.`user_id` = `utech`.`id`))) left join `shops` `shop` on((`s`.`shop_id` = `shop`.`id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `full_service_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `full_service_view` AS select `s`.`id` AS `service_id`,`s`.`service_name` AS `service_name`,`s`.`price` AS `price`,`s`.`description` AS `service_description`,`s`.`status` AS `service_status`,`s`.`image_path` AS `service_image_path`,date_format(`s`.`created_at`,'%M %e, %Y %l:%i %p') AS `service_created_at`,(select count(0) from `booking_v2_s` `bs` where ((`bs`.`booking_status` = 'done') and (`bs`.`service_id` = `s`.`id`))) AS `service_client`,`srs`.`id` AS `service_rate_id`,`srs`.`user_id` AS `service_rate_user_id`,`srs`.`rating` AS `service_rate`,date_format(`srs`.`created_at`,'%M %e, %Y %l:%i %p') AS `service_rate_created_at`,`agg`.`average_rating` AS `average_rating`,`agg`.`total_reviews` AS `total_reviews`,`sh`.`id` AS `shop_id`,`sh`.`shop_name` AS `shop_name`,`sh`.`shop_address` AS `shop_address`,`sh`.`shop_lat` AS `shop_lat`,`sh`.`shop_long` AS `shop_long`,`t`.`id` AS `technician_id`,`tu`.`id` AS `technician_user_id`,`tu`.`name` AS `technician_fullname`,`tu`.`firstname` AS `technician_firstname`,`tu`.`lastname` AS `technician_lastname`,`tu`.`email` AS `technician_email`,`tu`.`phone` AS `technician_phone`,`su`.`id` AS `shop_owner_id`,`su`.`name` AS `shop_owner_fullname`,`su`.`firstname` AS `shop_owner_firstname`,`su`.`lastname` AS `shop_owner_lastname`,`su`.`email` AS `shop_owner_email`,`su`.`status` AS `shop_owner_user_status`,`c`.`id` AS `category_id`,`c`.`category_name` AS `category_name`,`c`.`description` AS `category_description` from (((((((`service_v2_s` `s` join `shops` `sh` on((`s`.`shop_id` = `sh`.`id`))) join `users` `su` on((`sh`.`user_id` = `su`.`id`))) join `technicians` `t` on((`s`.`technician_id` = `t`.`id`))) join `users` `tu` on((`t`.`user_id` = `tu`.`id`))) join `categories` `c` on((`s`.`category_id` = `c`.`id`))) left join (select `sr1`.`id` AS `id`,`sr1`.`service_id` AS `service_id`,`sr1`.`user_id` AS `user_id`,`sr1`.`rating` AS `rating`,`sr1`.`created_at` AS `created_at`,`sr1`.`updated_at` AS `updated_at` from (`service_ratings` `sr1` join (select `service_ratings`.`service_id` AS `service_id`,max(`service_ratings`.`created_at`) AS `max_created_at` from `service_ratings` group by `service_ratings`.`service_id`) `sr2` on(((`sr1`.`service_id` = `sr2`.`service_id`) and (`sr1`.`created_at` = `sr2`.`max_created_at`))))) `srs` on((`srs`.`service_id` = `s`.`id`))) left join (select `service_ratings`.`service_id` AS `service_id`,round(avg(`service_ratings`.`rating`),2) AS `average_rating`,count(`service_ratings`.`id`) AS `total_reviews` from `service_ratings` group by `service_ratings`.`service_id`) `agg` on((`agg`.`service_id` = `s`.`id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `service_average_ratings`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `service_average_ratings` AS select `service_ratings`.`service_id` AS `service_id`,round(avg(`service_ratings`.`rating`),2) AS `average_rating`,count(0) AS `total_reviews` from `service_ratings` group by `service_ratings`.`service_id`
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `service_comments_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `service_comments_view` AS select `uc`.`name` AS `fullname`,`sc`.`id` AS `comment_id`,`sc`.`service_id` AS `service_id`,(select round(avg(`service_ratings`.`rating`),2) from `service_ratings` where ((`service_ratings`.`user_id` = `sc`.`user_id`) and (`service_ratings`.`service_id` = `sc`.`service_id`))) AS `average_rating`,`sc`.`user_id` AS `user_id`,`sc`.`comment` AS `comment`,`sc`.`created_at` AS `created_at`,`sc`.`updated_at` AS `updated_at` from (`service_comments` `sc` left join `users` `uc` on((`uc`.`id` = `sc`.`user_id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `service_comment_replies_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `service_comment_replies_view` AS select `uc`.`name` AS `fullname`,`scr`.`id` AS `reply_id`,`scr`.`comment_id` AS `comment_id`,`scr`.`user_id` AS `user_id`,`scr`.`reply` AS `reply`,`scr`.`created_at` AS `created_at`,`scr`.`updated_at` AS `updated_at` from (`service_comment_replies` `scr` left join `users` `uc` on((`uc`.`id` = `scr`.`user_id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `shop_with_services_json`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `shop_with_services_json` AS select `s`.`id` AS `shop_id`,`s`.`shop_name` AS `shop_name`,`s`.`shop_address` AS `shop_address`,`s`.`shop_details` AS `shop_details`,`s`.`shop_lat` AS `shop_lat`,`s`.`shop_long` AS `shop_long`,json_arrayagg(json_object('id',`sv`.`id`,'service_name',if((char_length(`sv`.`service_name`) > 15),concat(left(`sv`.`service_name`,15),'...'),`sv`.`service_name`),'price',`sv`.`price`,'description',`sv`.`description`,'status',`sv`.`status`,'image_path',`sv`.`image_path`)) AS `services` from (`shops` `s` left join `service_v2_s` `sv` on((`sv`.`shop_id` = `s`.`id`))) group by `s`.`id`,`s`.`shop_name`,`s`.`shop_address`,`s`.`shop_details`,`s`.`shop_lat`,`s`.`shop_long`
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `unified_ratings_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `unified_ratings_view` AS select 'service' AS `type`,max(`sr`.`id`) AS `rating_id`,round(avg(`sr`.`rating`),2) AS `average_rating`,count(`sr`.`id`) AS `total_reviews`,`sr`.`service_id` AS `reference_id`,`sc`.`service_name` AS `service_name`,`sp`.`shop_name` AS `shop_name`,`ut`.`name` AS `fullname`,max(`sr`.`user_id`) AS `user_id`,max(`sr`.`rating`) AS `rating`,max(`sr`.`created_at`) AS `created_at`,`sp`.`id` AS `shop_id`,`tech`.`id` AS `technician_id` from ((((`service_ratings` `sr` left join `service_v2_s` `sc` on((`sr`.`service_id` = `sc`.`id`))) left join `shops` `sp` on((`sp`.`id` = `sc`.`shop_id`))) left join `technicians` `tech` on((`tech`.`id` = `sc`.`technician_id`))) left join `users` `ut` on((`ut`.`id` = `tech`.`user_id`))) group by `sr`.`service_id`,`sc`.`service_name`,`sp`.`shop_name`,`ut`.`name`,`sp`.`id`,`tech`.`id` union select 'shop' AS `type`,max(`shr`.`id`) AS `rating_id`,round(avg(`shr`.`rating`),2) AS `average_rating`,count(`shr`.`id`) AS `total_reviews`,`shr`.`shop_id` AS `reference_id`,`sp`.`shop_name` AS `service_name`,`sp`.`shop_name` AS `shop_name`,NULL AS `fullname`,max(`shr`.`user_id`) AS `user_id`,max(`shr`.`rating`) AS `rating`,max(`shr`.`created_at`) AS `created_at`,`shr`.`shop_id` AS `shop_id`,NULL AS `technician_id` from (`shop_ratings` `shr` left join `shops` `sp` on((`sp`.`id` = `shr`.`shop_id`))) group by `shr`.`shop_id`,`sp`.`shop_name` union select 'technician' AS `type`,max(`tr`.`id`) AS `rating_id`,round(avg(`tr`.`rating`),2) AS `average_rating`,count(`tr`.`id`) AS `total_reviews`,`tr`.`technician_id` AS `reference_id`,`ut`.`name` AS `service_name`,`sp`.`shop_name` AS `shop_name`,`ut`.`name` AS `fullname`,max(`tr`.`user_id`) AS `user_id`,max(`tr`.`rating`) AS `rating`,max(`tr`.`created_at`) AS `created_at`,`tech`.`shop_id` AS `shop_id`,`tr`.`technician_id` AS `technician_id` from (((`technician_ratings` `tr` left join `technicians` `tech` on((`tech`.`id` = `tr`.`technician_id`))) left join `shops` `sp` on((`sp`.`id` = `tech`.`shop_id`))) left join `users` `ut` on((`ut`.`id` = `tech`.`user_id`))) group by `tr`.`technician_id`,`ut`.`name`,`sp`.`shop_name`,`tech`.`shop_id`
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `user_conversations_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `user_conversations_view` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`image_path` AS `image_path`,`u`.`role` AS `role`,max(`m`.`created_at`) AS `latest_message_time`,max(`m`.`message`) AS `latest_message`,max(`m`.`is_read`) AS `is_read` from (`messages` `m` join `users` `u` on((`u`.`id` = `m`.`receiver_id`))) where (`m`.`sender_id` <> `m`.`receiver_id`) group by `u`.`id`,`u`.`name`,`u`.`image_path`,`u`.`role` union select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`image_path` AS `image_path`,`u`.`role` AS `role`,max(`m`.`created_at`) AS `latest_message_time`,max(`m`.`message`) AS `latest_message`,max(`m`.`is_read`) AS `is_read` from (`messages` `m` join `users` `u` on((`u`.`id` = `m`.`sender_id`))) where (`m`.`receiver_id` <> `m`.`sender_id`) group by `u`.`id`,`u`.`name`,`u`.`image_path`,`u`.`role`
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_booking_user_id`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_booking_user_id` AS select `sv`.`id` AS `service_id`,`s`.`user_id` AS `user_id` from (`service_v2_s` `sv` join `shops` `s` on((`sv`.`shop_id` = `s`.`id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_service_feedback`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_service_feedback` AS select `us`.`name` AS `name`,concat(`us`.`firstname`,' ',`us`.`lastname`) AS `fullname`,`us`.`image_path` AS `image_path`,`sc`.`id` AS `comment_id`,`sc`.`service_id` AS `service_id`,`sc`.`user_id` AS `user_id`,`sc`.`comment` AS `comment`,`sr`.`id` AS `rating_id`,`sr`.`rating` AS `rating`,date_format(`sc`.`created_at`,'%M %e, %Y %l:%i %p') AS `comment_created_at`,`sr`.`created_at` AS `rating_created_at` from ((`service_comments` `sc` join `users` `us` on((`us`.`id` = `sc`.`user_id`))) left join `service_ratings` `sr` on(((`sc`.`service_id` = `sr`.`service_id`) and (`sc`.`user_id` = `sr`.`user_id`))))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_technicians`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_technicians` AS select `t`.`id` AS `technician_id`,`u`.`id` AS `user_id`,`u`.`name` AS `name`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname`,`u`.`email` AS `email`,`u`.`status` AS `status`,`u`.`phone` AS `phone`,`u`.`image_path` AS `image_path`,`s`.`id` AS `shop_id`,`s`.`shop_name` AS `shop_name`,`s`.`shop_address` AS `shop_address`,`s`.`shop_lat` AS `shop_lat`,`s`.`shop_long` AS `shop_long`,`t`.`created_at` AS `technician_created_at`,`t`.`updated_at` AS `technician_updated_at` from ((`technicians` `t` left join `users` `u` on((`u`.`id` = `t`.`user_id`))) left join `shops` `s` on((`s`.`id` = `t`.`shop_id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_users_without_shops`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_users_without_shops` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`firstname` AS `firstname`,`u`.`lastname` AS `lastname`,`u`.`email` AS `email`,`u`.`phone` AS `phone`,`u`.`address_street` AS `address_street`,`u`.`address_city` AS `address_city`,`u`.`address_state` AS `address_state`,`u`.`address_zip_code` AS `address_zip_code`,`u`.`role` AS `role`,`u`.`status` AS `status`,`u`.`created_at` AS `created_at` from (`users` `u` left join `shops` `s` on((`u`.`id` = `s`.`user_id`))) where (`s`.`user_id` is null)
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_users_with_shops`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_users_with_shops` AS select `users`.`id` AS `user_id`,`users`.`name` AS `name`,`users`.`firstname` AS `firstname`,`users`.`lastname` AS `lastname`,`users`.`email` AS `email`,`users`.`role` AS `role`,`users`.`status` AS `status`,`users`.`phone` AS `phone`,`users`.`address_street` AS `address_street`,`users`.`address_city` AS `address_city`,`users`.`address_state` AS `address_state`,`users`.`address_zip_code` AS `address_zip_code`,`users`.`image_path` AS `image_path`,`users`.`mobile_auth` AS `mobile_auth`,`shops`.`id` AS `shop_id`,`shops`.`shop_name` AS `shop_name`,`shops`.`shop_address` AS `shop_address`,`shops`.`shop_details` AS `shop_details`,`shops`.`status` AS `shop_status`,`shops`.`shop_lat` AS `shop_lat`,`shops`.`shop_long` AS `shop_long`,`shops`.`shop_image` AS `shop_image`,`shops`.`shop_national_id` AS `shop_national_id`,`shops`.`cor` AS `cor`,`shops`.`created_at` AS `shop_created_at`,`shops`.`updated_at` AS `shop_updated_at` from (`users` join `shops` on((`users`.`id` = `shops`.`user_id`)))
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_user_services`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_user_services` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`u`.`email` AS `email`,`u`.`role` AS `role`,`u`.`status` AS `status`,`u`.`phone` AS `phone`,`u`.`address_street` AS `address_street`,`u`.`address_city` AS `address_city`,`u`.`address_state` AS `address_state`,`u`.`address_zip_code` AS `address_zip_code`,`u`.`image_path` AS `image_path`,`u`.`mobile_auth` AS `mobile_auth`,`s`.`id` AS `service_id`,`s`.`name` AS `service_name`,`s`.`description` AS `service_description`,`s`.`service_fee` AS `service_fee`,`s`.`photo_path` AS `service_photo`,`s`.`is_public` AS `is_public`,`s`.`created_at` AS `service_created_at`,`s`.`updated_at` AS `service_updated_at` from (`users` `u` join `services` `s` on((`u`.`id` = `s`.`user_id`))) where (`s`.`is_public` = 1)
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_user_services_comments_ratings`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_user_services_comments_ratings` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`u`.`email` AS `email`,`u`.`role` AS `role`,`u`.`status` AS `status`,`u`.`phone` AS `phone`,`u`.`address_street` AS `address_street`,`u`.`address_city` AS `address_city`,`u`.`address_state` AS `address_state`,`u`.`address_zip_code` AS `address_zip_code`,`u`.`image_path` AS `image_path`,`u`.`mobile_auth` AS `mobile_auth`,`s`.`id` AS `service_id`,`s`.`name` AS `service_name`,`s`.`description` AS `service_description`,`s`.`service_fee` AS `service_fee`,`s`.`photo_path` AS `service_photo`,`s`.`is_public` AS `is_public`,`s`.`created_at` AS `service_created_at`,`s`.`updated_at` AS `service_updated_at`,`c`.`id` AS `comment_id`,`c`.`parent_id` AS `comment_parent_id`,`c`.`comment` AS `comment_text`,`c`.`created_at` AS `comment_created_at`,`c`.`updated_at` AS `comment_updated_at`,`c`.`user_id` AS `comment_user_id`,`r`.`rating` AS `service_rating` from (((`users` `u` join `services` `s` on((`u`.`id` = `s`.`user_id`))) left join `comments` `c` on((`s`.`id` = `c`.`service_id`))) left join `ratings` `r` on((`s`.`id` = `r`.`service_id`))) where (`s`.`is_public` = 1)
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `view_user_services_provider`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_user_services_provider` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`u`.`email` AS `email`,`u`.`role` AS `role`,`u`.`status` AS `status`,`u`.`phone` AS `phone`,`u`.`address_street` AS `address_street`,`u`.`address_city` AS `address_city`,`u`.`address_state` AS `address_state`,`u`.`address_zip_code` AS `address_zip_code`,`u`.`image_path` AS `image_path`,`u`.`mobile_auth` AS `mobile_auth`,`s`.`id` AS `service_id`,`s`.`name` AS `service_name`,`s`.`description` AS `service_description`,`s`.`service_fee` AS `service_fee`,`s`.`photo_path` AS `service_photo`,`s`.`is_public` AS `is_public`,`s`.`created_at` AS `service_created_at`,`s`.`updated_at` AS `service_updated_at` from (`users` `u` join `services` `s` on((`u`.`id` = `s`.`user_id`)))
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
