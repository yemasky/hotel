/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 10.1.13-MariaDB : Database - hotel_web
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `hotel_web`;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` bigint(19) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名字',
  `user_sex` enum('男','女') NOT NULL COMMENT '性别',
  `user_birthday` date DEFAULT NULL COMMENT '用户生日',
  `user_address` varchar(200) DEFAULT NULL COMMENT '用户住址',
  `user_photo` varchar(200) DEFAULT NULL COMMENT '用户头像',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

/*Table structure for table `user_grade` */

DROP TABLE IF EXISTS `user_grade`;

CREATE TABLE `user_grade` (
  `user_id` bigint(19) NOT NULL,
  `user_grade_type_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_grade` */

/*Table structure for table `user_grade_type` */

DROP TABLE IF EXISTS `user_grade_type`;

CREATE TABLE `user_grade_type` (
  `user_grade_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_grade_type_name` varchar(50) DEFAULT NULL COMMENT '会员等级类别名称',
  PRIMARY KEY (`user_grade_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_grade_type` */

/*Table structure for table `user_login` */

DROP TABLE IF EXISTS `user_login`;

CREATE TABLE `user_login` (
  `user_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '登录用户ID',
  `user_password` varchar(50) NOT NULL COMMENT '密码',
  `user_salt` varchar(50) NOT NULL COMMENT '盐',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '登录名字',
  `user_id_card` varchar(50) DEFAULT NULL COMMENT '身份证',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录email',
  `user_email_confirm` bit(1) NOT NULL DEFAULT b'0' COMMENT 'email是否确认',
  `user_mobile` int(11) NOT NULL COMMENT '登录mobile',
  `user_mobile_confirm` bit(1) NOT NULL DEFAULT b'0' COMMENT 'mobile是否确认',
  `user_add_date` date NOT NULL COMMENT '添加日期',
  `user_add_time` time NOT NULL COMMENT '添加日期',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `login_email` (`user_email`),
  UNIQUE KEY `login_mobile` (`user_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_login` */

/*Table structure for table `user_login_log` */

DROP TABLE IF EXISTS `user_login_log`;

CREATE TABLE `user_login_log` (
  `user_login_log_id` bigint(19) NOT NULL COMMENT 'logID',
  `user_id` bigint(19) NOT NULL COMMENT '登录ID',
  `user_login_date` date NOT NULL COMMENT '登录时间',
  `user_login_time` time NOT NULL COMMENT '登录时间',
  `user_login_ip` varchar(64) NOT NULL COMMENT '登录IP',
  `user_login_status` bit(1) NOT NULL DEFAULT b'0' COMMENT '登录状态',
  PRIMARY KEY (`user_login_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_login_log` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
