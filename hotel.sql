/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 10.1.16-MariaDB : Database - hotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotel` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hotel`;

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `book_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(19) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `book_order_number` varchar(50) NOT NULL COMMENT '订单号',
  `book_check_out` datetime NOT NULL,
  `book_check_int` datetime NOT NULL,
  `book_add_date` datetime DEFAULT NULL,
  `book_user_name` varchar(50) DEFAULT NULL,
  `book_user_sex` enum('男','女') DEFAULT NULL,
  `book_user_mobile` int(11) DEFAULT NULL,
  `book_user_email` varchar(50) DEFAULT NULL,
  `book_user_address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book` */

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_group` int(11) DEFAULT NULL COMMENT '公司群 company_id == company_group 为母公司',
  `company_name` varchar(200) NOT NULL COMMENT '公司名称',
  `company_address` varchar(200) NOT NULL COMMENT '公司地址',
  `company_mobile` int(11) DEFAULT NULL COMMENT '移动电话',
  `company_phone` varchar(50) DEFAULT NULL COMMENT '公司电话',
  `company_fax` varchar(50) DEFAULT NULL COMMENT '公司传真',
  `company_longitude` float DEFAULT NULL COMMENT '经度',
  `company_latitude` float DEFAULT NULL COMMENT '纬度',
  `company_country` varchar(50) DEFAULT NULL COMMENT '国家',
  `company_province` varchar(50) DEFAULT NULL COMMENT '省',
  `company_city` varchar(50) NOT NULL COMMENT '市、县',
  `company_town` varchar(50) DEFAULT NULL COMMENT '城镇',
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `company` */

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `department_sort_id` int(11) NOT NULL COMMENT '最高级 department_id',
  `department_sort_depth` mediumint(6) NOT NULL DEFAULT '0' COMMENT '深度',
  `department_father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父类ID',
  `department_name` varchar(100) NOT NULL COMMENT '部门名称',
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `department` */

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `employee_name` varchar(50) NOT NULL,
  `employee_mobile` bigint(11) NOT NULL,
  `employee_email` varchar(200) DEFAULT NULL,
  `employee_password` varchar(50) NOT NULL,
  `employee_password_salt` varchar(50) NOT NULL,
  `employee_add_date` date NOT NULL,
  `employee_add_time` time NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `employee` */

insert  into `employee`(`employee_id`,`company_id`,`hotel_id`,`employee_name`,`employee_mobile`,`employee_email`,`employee_password`,`employee_password_salt`,`employee_add_date`,`employee_add_time`) values (1,1,1,'cooc',18500353881,'kefu@yelove.cn','74ac44b1aaec5037c424ccece16bdd14','585568','2016-09-20','18:00:22');

/*Table structure for table `employee_department` */

DROP TABLE IF EXISTS `employee_department`;

CREATE TABLE `employee_department` (
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employee_department` */

/*Table structure for table `hotel` */

DROP TABLE IF EXISTS `hotel`;

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL COMMENT '属于公司ID',
  `company_group` int(11) DEFAULT NULL COMMENT '属于公司集团',
  `hotel_group` varchar(50) DEFAULT NULL COMMENT '酒店群',
  `hotel_name` varchar(200) DEFAULT NULL COMMENT '酒店名称',
  `hotel_address` varchar(200) DEFAULT NULL COMMENT '酒店地址',
  `hotel_phone` varchar(50) DEFAULT NULL COMMENT '酒店电话',
  `hotel_mobile` varchar(50) DEFAULT NULL COMMENT '酒店手机',
  `hotel_fax` varchar(50) DEFAULT NULL COMMENT '酒店传真',
  `hotel_longitude` float DEFAULT NULL COMMENT '经度',
  `hotel_latitude` float DEFAULT NULL COMMENT '纬度',
  `hotel_country` varchar(50) DEFAULT NULL COMMENT '国家',
  `hotel_province` varchar(50) DEFAULT NULL COMMENT '省',
  `hotel_city` varchar(50) DEFAULT NULL COMMENT '市、县',
  `hotel_town` varchar(50) DEFAULT NULL COMMENT '城镇',
  `hotel_introduce_short` varchar(1000) DEFAULT NULL COMMENT '酒店简短介绍',
  `hotel_introduce` text COMMENT '酒店介绍',
  `hotel_type` enum('酒店','度假村','民宿','商务酒店') NOT NULL DEFAULT '酒店' COMMENT '酒店类型',
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel` */

/*Table structure for table `hotel_extend` */

DROP TABLE IF EXISTS `hotel_extend`;

CREATE TABLE `hotel_extend` (
  `hotel_extend_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_extend_type_group_id` int(11) DEFAULT NULL COMMENT '相同为同一类的最顶级ID',
  `hotel_extend_type_father_id` int(11) NOT NULL COMMENT '父类',
  `hotel_extend_type_id` int(11) DEFAULT NULL COMMENT '自己',
  `hotel_extend_custom _name` varchar(50) NOT NULL DEFAULT '' COMMENT '自定义名称',
  PRIMARY KEY (`hotel_extend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_extend` */

/*Table structure for table `hotel_extend_type` */

DROP TABLE IF EXISTS `hotel_extend_type`;

CREATE TABLE `hotel_extend_type` (
  `hotel_extend_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒店扩展类型ID',
  `hotel_extend_type_group_id` int(11) NOT NULL COMMENT '相同为同一类的最顶级ID',
  `hotel_extend_type_father_id` int(11) NOT NULL COMMENT '父类',
  `hotel_extend_type_name` varchar(50) NOT NULL COMMENT '酒店扩展类型名称',
  PRIMARY KEY (`hotel_extend_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_extend_type` */

/*Table structure for table `hotel_images` */

DROP TABLE IF EXISTS `hotel_images`;

CREATE TABLE `hotel_images` (
  `hotel_images_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_images_path` varchar(300) NOT NULL COMMENT '路径',
  `hotel_images_add_date` date NOT NULL COMMENT '添加时间',
  `hotel_images_add_time` time NOT NULL COMMENT '添加时间',
  `hotel_images_is_360` bit(1) NOT NULL COMMENT '是否是360°图',
  `hotel_images_is_main` bit(1) NOT NULL COMMENT '是否是主图',
  PRIMARY KEY (`hotel_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_images` */

/*Table structure for table `manage_function` */

DROP TABLE IF EXISTS `manage_function`;

CREATE TABLE `manage_function` (
  `manage_function_id` int(11) NOT NULL AUTO_INCREMENT,
  `manage_function_father_id` int(11) DEFAULT NULL,
  `manage_function_name` varchar(50) DEFAULT NULL,
  `manage_function_func` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`manage_function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `manage_function` */

/*Table structure for table `operate_log` */

DROP TABLE IF EXISTS `operate_log`;

CREATE TABLE `operate_log` (
  `operate_log_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '操作日志ID',
  `employee_id` bigint(19) NOT NULL COMMENT '操作人ID',
  `operate_user_id` bigint(19) NOT NULL DEFAULT '0' COMMENT '被操作人ID',
  `operate_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `operate_describe` varchar(1000) NOT NULL COMMENT '操作描述',
  `operate_remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `add_date` date NOT NULL COMMENT '添加日期',
  `add_time` time NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`operate_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `operate_log` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `role_name` varchar(100) DEFAULT NULL COMMENT '权限名称',
  `role_describe` varchar(2000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房ID 酒店实际房子',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_type_id` int(11) NOT NULL COMMENT '房型ID',
  `room_is_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否做为展示售卖房型',
  `room_name` varchar(200) DEFAULT NULL COMMENT '房型名称 自定义',
  `room_describe` text NOT NULL COMMENT '房间描述',
  `room_number` mediumint(6) NOT NULL COMMENT '房号',
  `room_floor` int(11) NOT NULL COMMENT '房型楼层',
  `room_area` double NOT NULL COMMENT '面积 单位 平方米',
  `room_bed_type` varchar(50) NOT NULL COMMENT '床型',
  `room_non_smoking` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否无烟房',
  `room_maximum_occupancy` tinyint(3) DEFAULT NULL COMMENT '最多入住人数',
  `room_facilities` text COMMENT '便利设施',
  `room_food_drinks` varchar(200) DEFAULT NULL COMMENT '食品和饮料',
  `room_bathroom` varchar(200) DEFAULT NULL COMMENT '浴室',
  `room_service` varchar(200) DEFAULT NULL COMMENT '酒店服务',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room` */

/*Table structure for table `room_facilities` */

DROP TABLE IF EXISTS `room_facilities`;

CREATE TABLE `room_facilities` (
  `room_facilities_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_facilities_type_id` int(11) NOT NULL DEFAULT '0',
  `hotel_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_facilities_name` varchar(200) NOT NULL DEFAULT '' COMMENT '自定义名称',
  `room_facilities_describe` varchar(2000) NOT NULL DEFAULT '' COMMENT '自定义描述',
  PRIMARY KEY (`room_facilities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_facilities` */

/*Table structure for table `room_facilities_type` */

DROP TABLE IF EXISTS `room_facilities_type`;

CREATE TABLE `room_facilities_type` (
  `room_facilities_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_facilities_type_name` varchar(200) NOT NULL,
  `room_facilities_type_describe` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`room_facilities_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_facilities_type` */

/*Table structure for table `room_images` */

DROP TABLE IF EXISTS `room_images`;

CREATE TABLE `room_images` (
  `room_images_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`room_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_images` */

/*Table structure for table `room_price` */

DROP TABLE IF EXISTS `room_price`;

CREATE TABLE `room_price` (
  `room_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `room_price` double NOT NULL,
  `room_price_add_date` date NOT NULL COMMENT '房价添加时间',
  `room_price_add_time` time NOT NULL COMMENT '房价添加时间',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_price` */

/*Table structure for table `room_type` */

DROP TABLE IF EXISTS `room_type`;

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_type_name` varchar(50) NOT NULL COMMENT '房型名称',
  `room_type_define` enum('系统','自定义') NOT NULL DEFAULT '系统' COMMENT '房型定义',
  `hotel_id` int(11) DEFAULT NULL COMMENT '自定义房型属于酒店ID',
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_type` */

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

/*Table structure for table `user_login` */

DROP TABLE IF EXISTS `user_login`;

CREATE TABLE `user_login` (
  `user_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '登录用户ID',
  `user_password` varchar(50) NOT NULL COMMENT '密码',
  `user_salt` varchar(50) NOT NULL COMMENT '盐',
  `user_name` varchar(50) NOT NULL DEFAULT '' COMMENT '登录名字',
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
