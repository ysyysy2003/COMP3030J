/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50636
 Source Host           : localhost:3306
 Source Schema         : 20240416

 Target Server Type    : MySQL
 Target Server Version : 50636
 File Encoding         : 65001

 Date: 10/05/2024 14:01:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add product', 7, 'add_product');
INSERT INTO `auth_permission` VALUES (26, 'Can change product', 7, 'change_product');
INSERT INTO `auth_permission` VALUES (27, 'Can delete product', 7, 'delete_product');
INSERT INTO `auth_permission` VALUES (28, 'Can view product', 7, 'view_product');
INSERT INTO `auth_permission` VALUES (29, 'Can add order', 8, 'add_order');
INSERT INTO `auth_permission` VALUES (30, 'Can change order', 8, 'change_order');
INSERT INTO `auth_permission` VALUES (31, 'Can delete order', 8, 'delete_order');
INSERT INTO `auth_permission` VALUES (32, 'Can view order', 8, 'view_order');
INSERT INTO `auth_permission` VALUES (33, 'Can add operation', 9, 'add_operation');
INSERT INTO `auth_permission` VALUES (34, 'Can change operation', 9, 'change_operation');
INSERT INTO `auth_permission` VALUES (35, 'Can delete operation', 9, 'delete_operation');
INSERT INTO `auth_permission` VALUES (36, 'Can view operation', 9, 'view_operation');
INSERT INTO `auth_permission` VALUES (37, 'Can add Token', 10, 'add_token');
INSERT INTO `auth_permission` VALUES (38, 'Can change Token', 10, 'change_token');
INSERT INTO `auth_permission` VALUES (39, 'Can delete Token', 10, 'delete_token');
INSERT INTO `auth_permission` VALUES (40, 'Can view Token', 10, 'view_token');
INSERT INTO `auth_permission` VALUES (41, 'Can add category', 11, 'add_category');
INSERT INTO `auth_permission` VALUES (42, 'Can change category', 11, 'change_category');
INSERT INTO `auth_permission` VALUES (43, 'Can delete category', 11, 'delete_category');
INSERT INTO `auth_permission` VALUES (44, 'Can view category', 11, 'view_category');
COMMIT;

-- ----------------------------
-- Table structure for authtoken_token
-- ----------------------------
DROP TABLE IF EXISTS `authtoken_token`;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of authtoken_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for course_category
-- ----------------------------
DROP TABLE IF EXISTS `course_category`;
CREATE TABLE `course_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `info` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_category
-- ----------------------------
BEGIN;
INSERT INTO `course_category` VALUES (1, 'Hotel', 'car.svg');
INSERT INTO `course_category` VALUES (2, 'Services', 'laptop.svg');
INSERT INTO `course_category` VALUES (3, 'Marketing', 'controller.svg');
INSERT INTO `course_category` VALUES (4, 'Real Estate', 'furniture.svg');
INSERT INTO `course_category` VALUES (5, 'Electronics', 'watch.svg');
INSERT INTO `course_category` VALUES (6, 'Clothing', 'travel.svg');
INSERT INTO `course_category` VALUES (7, 'Jewelry', 'matrimony.svg');
COMMIT;

-- ----------------------------
-- Table structure for course_operation
-- ----------------------------
DROP TABLE IF EXISTS `course_operation`;
CREATE TABLE `course_operation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_operation_product_id_c3a6b555_fk_course_product_id` (`product_id`),
  KEY `course_operation_user_id_fd125247_fk_course_user_id` (`user_id`),
  CONSTRAINT `course_operation_product_id_c3a6b555_fk_course_product_id` FOREIGN KEY (`product_id`) REFERENCES `course_product` (`id`),
  CONSTRAINT `course_operation_user_id_fd125247_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_operation
-- ----------------------------
BEGIN;
INSERT INTO `course_operation` VALUES (1, 2, 'asdasdsadasd', '2024-05-09 23:49:54.901824', '2024-05-09 23:49:54.901926', 12, 1);
INSERT INTO `course_operation` VALUES (2, 2, 'asdasdasdas', '2024-05-09 23:50:29.825837', '2024-05-09 23:50:29.825897', 12, 1);
INSERT INTO `course_operation` VALUES (3, 2, '123123123', '2024-05-09 23:50:49.009238', '2024-05-09 23:50:49.009284', 12, 1);
INSERT INTO `course_operation` VALUES (4, 2, '213123123123123', '2024-05-09 23:51:40.566327', '2024-05-09 23:51:40.566385', 12, 1);
INSERT INTO `course_operation` VALUES (5, 2, 'asdasdasdasd', '2024-05-09 23:52:17.558191', '2024-05-09 23:52:17.558241', 12, 1);
INSERT INTO `course_operation` VALUES (6, 2, 'asdsadad', '2024-05-09 23:54:41.634349', '2024-05-09 23:54:41.634399', 12, 1);
INSERT INTO `course_operation` VALUES (9, 1, '0', '2024-05-10 13:44:16.516139', '2024-05-10 13:44:16.516216', 12, 1);
INSERT INTO `course_operation` VALUES (10, 1, '0', '2024-05-10 13:44:27.622440', '2024-05-10 13:44:27.622493', 12, 1);
INSERT INTO `course_operation` VALUES (11, 1, '1', '2024-05-10 13:47:28.817385', '2024-05-10 13:47:28.817464', 12, 1);
COMMIT;

-- ----------------------------
-- Table structure for course_order
-- ----------------------------
DROP TABLE IF EXISTS `course_order`;
CREATE TABLE `course_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `note` longtext,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `product1_id` int(11) NOT NULL,
  `product2_id` int(11) NOT NULL,
  `user1_id` int(11) NOT NULL,
  `user2_id` int(11) NOT NULL,
  `address` varchar(255),
  `phone` varchar(255),
  `nums2` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_order_product1_id_785888e9_fk_course_product_id` (`product1_id`),
  KEY `course_order_product2_id_d8da9a7c_fk_course_product_id` (`product2_id`),
  KEY `course_order_user1_id_ccdf89d6_fk_course_user_id` (`user1_id`),
  KEY `course_order_user2_id_1f09b0bf_fk_course_user_id` (`user2_id`),
  CONSTRAINT `course_order_product1_id_785888e9_fk_course_product_id` FOREIGN KEY (`product1_id`) REFERENCES `course_product` (`id`),
  CONSTRAINT `course_order_product2_id_d8da9a7c_fk_course_product_id` FOREIGN KEY (`product2_id`) REFERENCES `course_product` (`id`),
  CONSTRAINT `course_order_user1_id_ccdf89d6_fk_course_user_id` FOREIGN KEY (`user1_id`) REFERENCES `course_user` (`id`),
  CONSTRAINT `course_order_user2_id_1f09b0bf_fk_course_user_id` FOREIGN KEY (`user2_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_order
-- ----------------------------
BEGIN;
INSERT INTO `course_order` VALUES (1, 1, '2', '2024-05-10 01:21:03.823155', '2024-05-10 01:41:57.339890', 12, 13, 2, 1, '4', '3', 1);
COMMIT;

-- ----------------------------
-- Table structure for course_product
-- ----------------------------
DROP TABLE IF EXISTS `course_product`;
CREATE TABLE `course_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `nums` double DEFAULT NULL,
  `description` longtext,
  `image` varchar(255) DEFAULT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(255),
  `status` int(11) NOT NULL DEFAULT '3',
  `status_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_product_category_id_654c1d18` (`category_id`),
  KEY `course_product_user_id_7f6b1460_fk_course_user_id` (`user_id`),
  CONSTRAINT `course_product_category_id_654c1d18_fk_course_category_id` FOREIGN KEY (`category_id`) REFERENCES `course_category` (`id`),
  CONSTRAINT `course_product_user_id_7f6b1460_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_product
-- ----------------------------
BEGIN;
INSERT INTO `course_product` VALUES (3, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (4, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (5, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (6, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (10, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (11, 'Apple Iphone X', 3, 5999, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 00:23:57.911334', 1, '(123) 1800-567-8990 ', 1, 'agree');
INSERT INTO `course_product` VALUES (12, 'Apple Iphone X', 3, 6000, 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.\n\nModel: Apple MacBook Pro 13.3-Inch MYDA2\nApple M1 chip with 8-core CPU and 8-core GPU\n8GB RAM\n256GB SSD\n13.3-inch 2560x1600 LED-backlit Retina Display\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', 'http://127.0.0.1:8000/media/1715185328.jpg', '8', 'Perfect, smooth, brand new, for personal use', 'Boston, New York, USA', 'Boston', 'Massachusetts', '2024-05-09 00:23:57.911312', '2024-05-09 23:20:03.364234', 1, '(123) 1800-567-8990 ', 3, '');
INSERT INTO `course_product` VALUES (13, 'Apple Macbook Pro 13', 5, 5, 'Last Updated: 5 hours ago', 'http://127.0.0.1:8000/media/1715272998.jpg', '9', 'vary fast', 'Louis, Missouri, US', 'Missouri', 'Louis', '2024-05-10 00:43:42.473877', '2024-05-10 13:38:46.647501', 2, '(123) 1800-567-8990 ', 1, 'agree');
COMMIT;

-- ----------------------------
-- Table structure for course_user
-- ----------------------------
DROP TABLE IF EXISTS `course_user`;
CREATE TABLE `course_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `about` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_user
-- ----------------------------
BEGIN;
INSERT INTO `course_user` VALUES (1, 'pbkdf2_sha256$150000$oaJqaZMaNYix$M7a0qmdALVobb/efB8tnjieyBq0LMT8N0S59Q0DJ3LQ=', NULL, 0, 'XiaoMing', '', '', 0, 1, '2024-05-08 22:08:11.970385', 1, 1, 'http://127.0.0.1:8000/media/1715189702.jpg', 'NewBoy Co., Ltd', '1123123', 'Member Since May 15,2023test');
INSERT INTO `course_user` VALUES (2, 'pbkdf2_sha256$150000$DnKPFlp01vdT$VObih0tPt+Gbr8j8EJvjIbsdrqO464MOvMgeiMc86+Y=', NULL, 0, 'xiaoming2', '', '', 0, 1, '2024-05-09 23:02:00.421438', 3, 1, 'http://127.0.0.1:8000/media/1715273056.jpg', 'xiaoming2', '', 'ddddddddd');
INSERT INTO `course_user` VALUES (3, 'pbkdf2_sha256$150000$pZ8ksWrsGfnM$AuofsKgNW8X8/kn4tBoUesw446zijn04BcEn3mAfzoQ=', NULL, 0, 'xiaoming3', '', '', 0, 1, '2024-05-10 02:43:13.090781', 1, 1, '', '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for course_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `course_user_groups`;
CREATE TABLE `course_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_user_groups_user_id_group_id_10ea1645_uniq` (`user_id`,`group_id`),
  KEY `course_user_groups_group_id_b6ac1380_fk_auth_group_id` (`group_id`),
  CONSTRAINT `course_user_groups_group_id_b6ac1380_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `course_user_groups_user_id_15a6d5ce_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_user_groups
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for course_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `course_user_user_permissions`;
CREATE TABLE `course_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_user_user_permissions_user_id_permission_id_1acf7e74_uniq` (`user_id`,`permission_id`),
  KEY `course_user_user_per_permission_id_4eb7662b_fk_auth_perm` (`permission_id`),
  CONSTRAINT `course_user_user_per_permission_id_4eb7662b_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `course_user_user_permissions_user_id_a0266d38_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of course_user_user_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_course_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_course_user_id` FOREIGN KEY (`user_id`) REFERENCES `course_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (10, 'authtoken', 'token');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (11, 'course', 'category');
INSERT INTO `django_content_type` VALUES (9, 'course', 'operation');
INSERT INTO `django_content_type` VALUES (8, 'course', 'order');
INSERT INTO `django_content_type` VALUES (7, 'course', 'product');
INSERT INTO `django_content_type` VALUES (6, 'course', 'user');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2024-05-08 00:23:37.094090');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2024-05-08 00:23:37.154802');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2024-05-08 00:23:37.277738');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2024-05-08 00:23:37.446455');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2024-05-08 00:23:37.455325');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2024-05-08 00:23:37.463077');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2024-05-08 00:23:37.470117');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2024-05-08 00:23:37.472017');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2024-05-08 00:23:37.479313');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2024-05-08 00:23:37.486093');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2024-05-08 00:23:37.492687');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2024-05-08 00:23:37.530173');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2024-05-08 00:23:37.536028');
INSERT INTO `django_migrations` VALUES (14, 'course', '0001_initial', '2024-05-08 00:23:37.780299');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2024-05-08 00:23:38.184977');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2024-05-08 00:23:38.259018');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2024-05-08 00:23:38.272345');
INSERT INTO `django_migrations` VALUES (18, 'authtoken', '0001_initial', '2024-05-08 00:23:38.332664');
INSERT INTO `django_migrations` VALUES (19, 'authtoken', '0002_auto_20160226_1747', '2024-05-08 00:23:38.452476');
INSERT INTO `django_migrations` VALUES (20, 'sessions', '0001_initial', '2024-05-08 00:23:38.500296');
INSERT INTO `django_migrations` VALUES (21, 'course', '0002_auto_20240508_2208', '2024-05-08 22:08:09.152204');
INSERT INTO `django_migrations` VALUES (22, 'course', '0003_auto_20240508_2329', '2024-05-08 23:29:20.171210');
INSERT INTO `django_migrations` VALUES (23, 'course', '0004_auto_20240509_0041', '2024-05-09 00:41:55.315012');
INSERT INTO `django_migrations` VALUES (24, 'course', '0005_auto_20240509_0108', '2024-05-09 01:08:38.188231');
INSERT INTO `django_migrations` VALUES (25, 'course', '0006_auto_20240509_2159', '2024-05-09 22:08:02.566470');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
