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
  `room_id` int(11) DEFAULT NULL COMMENT '真实房号',
  `room_layout_id` int(11) NOT NULL COMMENT '售卖房型ID',
  `book_price` double NOT NULL COMMENT '支付价格',
  `book_discount_id` int(11) NOT NULL COMMENT '折扣ID',
  `book_discount_describe` varchar(2000) NOT NULL DEFAULT '' COMMENT '折扣描述',
  `book_order_number` varchar(50) NOT NULL COMMENT '订单号',
  `book_check_int` datetime NOT NULL COMMENT '入住时间',
  `book_check_out` datetime NOT NULL COMMENT '退房时间',
  `book_user_name` varchar(50) DEFAULT NULL,
  `book_user_sex` enum('男','女') NOT NULL,
  `book_user_mobile` bigint(11) NOT NULL,
  `book_user_email` varchar(50) DEFAULT NULL,
  `book_user_address` varchar(200) DEFAULT NULL,
  `book_user_id_card_type` varchar(200) DEFAULT NULL COMMENT '证件类型',
  `book_user_id_card` varchar(200) DEFAULT NULL COMMENT '证件号',
  `book_add_date` date NOT NULL COMMENT '添加时间',
  `book_add_time` time NOT NULL COMMENT '添加时间',
  `book_user_comments` varchar(2000) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book` */

/*Table structure for table `book_change` */

DROP TABLE IF EXISTS `book_change`;

CREATE TABLE `book_change` (
  `book_change_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_id` bigint(19) NOT NULL,
  `book_change_type` enum('change_room') DEFAULT NULL COMMENT '改变类型',
  `book_change_reason` varchar(500) DEFAULT NULL COMMENT '改变原因',
  PRIMARY KEY (`book_change_id`,`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_change` */

/*Table structure for table `book_discount` */

DROP TABLE IF EXISTS `book_discount`;

CREATE TABLE `book_discount` (
  `book_discount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '折扣ID',
  `book_discount_name` varchar(50) NOT NULL COMMENT '折扣名称',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `book_discount` double NOT NULL DEFAULT '100' COMMENT '折扣',
  PRIMARY KEY (`book_discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_discount` */

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `company` */

insert  into `company`(`company_id`,`company_group`,`company_name`,`company_address`,`company_mobile`,`company_phone`,`company_fax`,`company_longitude`,`company_latitude`,`company_country`,`company_province`,`company_city`,`company_town`) values (1,0,'欣得酒店','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`department_id`,`company_id`,`hotel_id`,`department_sort_id`,`department_sort_depth`,`department_father_id`,`department_name`) values (1,1,1,1,1,1,'系统管理员');

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

insert  into `employee_department`(`company_id`,`hotel_id`,`employee_id`,`department_id`) values (1,1,1,1);

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
  `hotel_star` smallint(3) NOT NULL DEFAULT '0' COMMENT '酒店星级',
  `hotel_brand` varchar(100) DEFAULT NULL COMMENT '酒店品牌',
  `hotel_wifi` bit(1) NOT NULL DEFAULT b'1' COMMENT '酒店wifi',
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `hotel` */

insert  into `hotel`(`hotel_id`,`company_id`,`company_group`,`hotel_group`,`hotel_name`,`hotel_address`,`hotel_phone`,`hotel_mobile`,`hotel_fax`,`hotel_longitude`,`hotel_latitude`,`hotel_country`,`hotel_province`,`hotel_city`,`hotel_town`,`hotel_introduce_short`,`hotel_introduce`,`hotel_type`,`hotel_star`,`hotel_brand`,`hotel_wifi`) values (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'酒店',0,NULL,'');

/*Table structure for table `hotel_attribute` */

DROP TABLE IF EXISTS `hotel_attribute`;

CREATE TABLE `hotel_attribute` (
  `hotel_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_attribute_father_id` int(11) NOT NULL COMMENT '父ID 2级总共',
  `hotel_attribute_name` varchar(200) NOT NULL COMMENT '属性名称',
  PRIMARY KEY (`hotel_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute` */

/*Table structure for table `hotel_attribute_value` */

DROP TABLE IF EXISTS `hotel_attribute_value`;

CREATE TABLE `hotel_attribute_value` (
  `hotel_attribute_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `hotel_attribute_value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hotel_attribute_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute_value` */

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
  `hotel_images_recommend` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0' COMMENT '推荐图片，越高越排前',
  PRIMARY KEY (`hotel_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_images` */

/*Table structure for table `hotel_modules` */

DROP TABLE IF EXISTS `hotel_modules`;

CREATE TABLE `hotel_modules` (
  `hotel_id` int(11) NOT NULL,
  `modules_id` int(11) NOT NULL,
  `modules_father_id` int(11) DEFAULT NULL COMMENT '父类ID',
  `hotel_modules_name` varchar(100) NOT NULL DEFAULT '' COMMENT '酒店自定义名称',
  `hotel_modules_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`hotel_id`,`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_modules` */

insert  into `hotel_modules`(`hotel_id`,`modules_id`,`modules_father_id`,`hotel_modules_name`,`hotel_modules_order`) values (1,1,1,'',0),(1,2,2,'',0),(1,3,3,'',0),(1,4,4,'',0),(1,5,5,'',0),(1,6,6,'',0),(1,7,7,'',0),(1,8,8,'',0),(1,9,9,'',0),(1,10,10,'',0),(1,11,11,'',0),(1,12,12,'',0),(1,13,13,'',0),(1,14,14,'',0);

/*Table structure for table `hotel_service` */

DROP TABLE IF EXISTS `hotel_service`;

CREATE TABLE `hotel_service` (
  `hotel_service_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒店服务ID',
  `hotel_service_name` varchar(100) NOT NULL COMMENT '酒店服务名称',
  `hotel_service_describe` text,
  PRIMARY KEY (`hotel_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_service` */

/*Table structure for table `hotel_service_price` */

DROP TABLE IF EXISTS `hotel_service_price`;

CREATE TABLE `hotel_service_price` (
  `hotel_service_price_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_service_id` int(11) NOT NULL,
  `hotel_service_price` double NOT NULL COMMENT '价格',
  `hotel_servic_begin_datetime` datetime NOT NULL COMMENT '开始时间',
  `hotel_servic_end_datetime` datetime NOT NULL COMMENT '失效时间',
  `hotel_servic_ahead_datetime` smallint(6) NOT NULL DEFAULT '0' COMMENT '提前预定时间 0不需要预定',
  `hotel_service_add_time` time NOT NULL,
  `hotel_service_add_date` date NOT NULL,
  `employee_id` int(11) NOT NULL COMMENT '添加员工',
  PRIMARY KEY (`hotel_service_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_service_price` */

/*Table structure for table `hotels_attribute` */

DROP TABLE IF EXISTS `hotels_attribute`;

CREATE TABLE `hotels_attribute` (
  `hotel_layout_id` int(11) NOT NULL,
  `hotel_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`hotel_layout_id`,`hotel_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotels_attribute` */

/*Table structure for table `modules` */

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `modules_id` int(11) NOT NULL AUTO_INCREMENT,
  `modules_father_id` int(11) NOT NULL COMMENT '父ID',
  `modules_name` varchar(100) NOT NULL COMMENT '模块名称',
  `modules_module` varchar(100) NOT NULL COMMENT '模块',
  `modules_action` varchar(100) NOT NULL COMMENT '模块action',
  `modules_action_field` text COMMENT '模块action field权限',
  `modules_action_permissions` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '增 删 改 查权限',
  `modules_ico` varchar(50) NOT NULL COMMENT '图标',
  `modules_show` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否显示在菜单中',
  PRIMARY KEY (`modules_id`),
  UNIQUE KEY `modules_module` (`modules_module`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `modules` */

insert  into `modules`(`modules_id`,`modules_father_id`,`modules_name`,`modules_module`,`modules_action`,`modules_action_field`,`modules_action_permissions`,`modules_ico`,`modules_show`) values (1,1,'管理首页','Index','',NULL,'','','1'),(2,2,'前厅管理','FrontOffice','',NULL,'','','1'),(3,3,'客房管理','RoomsManagement','',NULL,'','','1'),(4,4,'餐饮管理','EntertainmentManagement','',NULL,'','','1'),(5,5,'娱乐管理','RestaurantManagement ','',NULL,'','','1'),(6,6,'保安管理','SecurityManagement','',NULL,'','','1'),(7,7,'销售管理','SalesManagement','',NULL,'','','1'),(8,8,'人事管理','PersonnelManagement','',NULL,'','','1'),(9,9,'财务管理','FinancialManagement','',NULL,'','','1'),(10,10,'后勤管理','LogisticsManagement','',NULL,'','','1'),(11,11,'行政管理','Administration','',NULL,'','','1'),(12,12,'工程管理','EngineeringManagement','',NULL,'','','1'),(13,13,'采购管理','PurchaseManagement','',NULL,'','','1'),(14,14,'酒店设置','HotelSettings','',NULL,'0','','1');

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
  `hotel_id` int(11) NOT NULL DEFAULT '0' COMMENT '0表示系统的初始权限',
  `department_id` int(11) NOT NULL COMMENT '部门ID 根据部门添加权限',
  `role_name` varchar(100) DEFAULT NULL COMMENT '权限名称',
  `role_describe` varchar(2000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`role_id`,`company_id`,`hotel_id`,`department_id`,`role_name`,`role_describe`) values (1,1,1,1,'超级管理员','超级管理员 ');

/*Table structure for table `role_modules` */

DROP TABLE IF EXISTS `role_modules`;

CREATE TABLE `role_modules` (
  `role_id` int(11) NOT NULL,
  `modules_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_modules` */

/*Table structure for table `role_modules_employee` */

DROP TABLE IF EXISTS `role_modules_employee`;

CREATE TABLE `role_modules_employee` (
  `role_id` int(11) NOT NULL,
  `modules_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`modules_id`,`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_modules_employee` */

insert  into `role_modules_employee`(`role_id`,`modules_id`,`employee_id`) values (1,1,1),(1,2,1),(1,3,1),(1,4,1),(1,5,1),(1,6,1),(1,7,1),(1,8,1),(1,9,1),(1,10,1),(1,11,1),(1,12,1),(1,13,1),(1,14,1),(1,15,1);

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房ID 酒店实际客房',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_type_id` int(11) NOT NULL COMMENT '房型ID',
  `room_is_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否做为展示售卖房型',
  `room_name` varchar(200) DEFAULT NULL COMMENT '原始房型名称 自定义',
  `room_describe` text NOT NULL COMMENT '原始房间描述',
  `room_number` mediumint(6) NOT NULL COMMENT '房号',
  `room_floor` int(11) NOT NULL COMMENT '房型楼层',
  `room_area` double NOT NULL COMMENT '面积 单位 平方米',
  `room_add_date` date DEFAULT NULL COMMENT '添加时间',
  `room_add_time` time DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room` */

/*Table structure for table `room_attribute` */

DROP TABLE IF EXISTS `room_attribute`;

CREATE TABLE `room_attribute` (
  `room_attribute_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客房属性',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_attribute_father_id` int(11) NOT NULL COMMENT '父类 2级总共',
  `room_attribute_name` varchar(100) NOT NULL COMMENT '客房属性名称',
  PRIMARY KEY (`room_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_attribute` */

/*Table structure for table `room_attribute_value` */

DROP TABLE IF EXISTS `room_attribute_value`;

CREATE TABLE `room_attribute_value` (
  `room_attribute_value_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_attribute_value` varchar(200) NOT NULL COMMENT '属性值',
  PRIMARY KEY (`room_attribute_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_attribute_value` */

/*Table structure for table `room_images` */

DROP TABLE IF EXISTS `room_images`;

CREATE TABLE `room_images` (
  `room_images_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_layout_id` int(11) NOT NULL COMMENT '房型ID',
  `room_images_path` varchar(200) NOT NULL DEFAULT '' COMMENT '路径',
  `room_images_is_main` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是主图',
  `room_images_recommend` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0' COMMENT '推荐图片，越高越排前',
  PRIMARY KEY (`room_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_images` */

/*Table structure for table `room_layout` */

DROP TABLE IF EXISTS `room_layout`;

CREATE TABLE `room_layout` (
  `room_layout_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) DEFAULT NULL COMMENT '自定义房型属于酒店ID',
  `room_layout_name` varchar(50) NOT NULL COMMENT '房型名称',
  `room_layout_price` double NOT NULL COMMENT '房型价格',
  `room_layout_define` enum('系统','自定义') NOT NULL DEFAULT '系统' COMMENT '房型定义',
  `room_layout_valid` bit(1) NOT NULL DEFAULT b'0' COMMENT '房型是否有效',
  `room_layout_add_date` date NOT NULL COMMENT '添加时间',
  `room_layout_add_time` time NOT NULL COMMENT '添加时间',
  `room_layout_area` double NOT NULL COMMENT '房型面积 平方米',
  PRIMARY KEY (`room_layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout` */

/*Table structure for table `room_layout_room` */

DROP TABLE IF EXISTS `room_layout_room`;

CREATE TABLE `room_layout_room` (
  `room_layout_id` int(11) NOT NULL COMMENT '房型',
  `room_id` int(11) NOT NULL COMMENT '对应真正的客房号',
  PRIMARY KEY (`room_layout_id`,`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_room` */

/*Table structure for table `room_price` */

DROP TABLE IF EXISTS `room_price`;

CREATE TABLE `room_price` (
  `room_price_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `room_layout_id` int(11) NOT NULL COMMENT '售卖房型ID',
  `hotel_id` int(11) NOT NULL,
  `room_price` double NOT NULL,
  `room_price_begin_datetime` datetime NOT NULL COMMENT '开售时间',
  `room_price_end_datetime` datetime NOT NULL COMMENT '结束时间',
  `room_price_ahead_datetime` smallint(6) NOT NULL DEFAULT '0' COMMENT '提前预定时间 0 不限制',
  `room_price_add_time` time NOT NULL COMMENT '房价添加时间',
  `room_price_add_date` date NOT NULL COMMENT '房价添加时间',
  `employee_id` int(11) NOT NULL COMMENT '操作员工',
  PRIMARY KEY (`room_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_price` */

/*Table structure for table `rooms_layout_attribute` */

DROP TABLE IF EXISTS `rooms_layout_attribute`;

CREATE TABLE `rooms_layout_attribute` (
  `room_layout_id` int(11) NOT NULL,
  `room_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`room_layout_id`,`room_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `rooms_layout_attribute` */

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
