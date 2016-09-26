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

/*Table structure for table `book_setting` */

DROP TABLE IF EXISTS `book_setting`;

CREATE TABLE `book_setting` (
  `book_setting_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '预定设置ID',
  `hotel_id` int(11) NOT NULL,
  `book_setting_name` varchar(50) NOT NULL,
  `book_setting_value` varchar(50) NOT NULL,
  PRIMARY KEY (`book_setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_setting` */

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_group` int(11) DEFAULT NULL COMMENT '公司群 company_id == company_group 为母公司',
  `company_name` varchar(200) NOT NULL COMMENT '公司名称',
  `company_address` varchar(200) NOT NULL COMMENT '公司地址',
  `company_mobile` int(11) NOT NULL COMMENT '移动电话',
  `company_phone` varchar(50) DEFAULT NULL COMMENT '公司电话',
  `company_fax` varchar(50) DEFAULT NULL COMMENT '公司传真',
  `company_email` varchar(100) DEFAULT NULL COMMENT '公司email',
  `company_longitude` float NOT NULL COMMENT '经度',
  `company_latitude` float NOT NULL COMMENT '纬度',
  `company_country` varchar(50) NOT NULL COMMENT '国家',
  `company_province` varchar(50) NOT NULL COMMENT '省',
  `company_city` varchar(50) NOT NULL COMMENT '市、县',
  `company_town` varchar(50) NOT NULL COMMENT '城镇',
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `company` */

insert  into `company`(`company_id`,`company_group`,`company_name`,`company_address`,`company_mobile`,`company_phone`,`company_fax`,`company_email`,`company_longitude`,`company_latitude`,`company_country`,`company_province`,`company_city`,`company_town`) values (1,0,'欣得酒店','',0,NULL,NULL,NULL,0,0,'','','','');

/*Table structure for table `company_multi_laguage` */

DROP TABLE IF EXISTS `company_multi_laguage`;

CREATE TABLE `company_multi_laguage` (
  `company_id` int(11) NOT NULL DEFAULT '0',
  `multi_laguage` enum('English') NOT NULL,
  `company_name` varchar(200) NOT NULL COMMENT '公司名称',
  `company_address` varchar(200) NOT NULL COMMENT '公司地址',
  `company_country` varchar(50) NOT NULL COMMENT '国家',
  `company_province` varchar(50) NOT NULL COMMENT '省',
  `company_city` varchar(50) NOT NULL COMMENT '市、县',
  `company_town` varchar(50) NOT NULL COMMENT '城镇',
  PRIMARY KEY (`company_id`,`multi_laguage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `company_multi_laguage` */

insert  into `company_multi_laguage`(`company_id`,`multi_laguage`,`company_name`,`company_address`,`company_country`,`company_province`,`company_city`,`company_town`) values (1,'English','欣得酒店','','','','','');

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
  `company_id` int(11) NOT NULL COMMENT '默认公司',
  `hotel_id` int(11) NOT NULL COMMENT '默认酒店',
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
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `modules_id` int(11) NOT NULL COMMENT '模块ID',
  `hotel_modules_father_id` int(11) DEFAULT NULL COMMENT '父类ID',
  `hotel_modules_name` varchar(100) NOT NULL DEFAULT '' COMMENT '酒店自定义名称',
  `hotel_modules_navigation` varchar(100) NOT NULL COMMENT '导航',
  `hotel_modules_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `hotel_modules_ico` varchar(50) DEFAULT NULL COMMENT '图标',
  `hotel_modules_show` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否显示在菜单中',
  PRIMARY KEY (`hotel_id`,`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_modules` */

insert  into `hotel_modules`(`hotel_id`,`modules_id`,`hotel_modules_father_id`,`hotel_modules_name`,`hotel_modules_navigation`,`hotel_modules_order`,`hotel_modules_ico`,`hotel_modules_show`) values (1,1,1,'','index',0,'','1'),(1,2,2,'','frontOffice',0,'','1'),(1,3,3,'','rooms',0,'','1'),(1,4,4,'','restaurant',0,'','1'),(1,5,5,'','entertainment',0,'','1'),(1,6,6,'','security',0,'','1'),(1,7,7,'','sales',0,'','1'),(1,8,8,'','administration',0,'','1'),(1,9,9,'','financial',0,'','1'),(1,10,8,'','administration',0,'','1'),(1,11,8,'','administration',0,'','1'),(1,12,12,'','engineering',0,'','1'),(1,13,13,'','purchase',0,'','1'),(1,14,14,'','hotelSetting',0,'','1'),(1,15,14,'','hotelSetting',0,NULL,'1');

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
  `modules_order` int(11) NOT NULL COMMENT '排序',
  `modules_module` varchar(100) NOT NULL COMMENT '模块',
  `modules_describe` varchar(200) NOT NULL DEFAULT '' COMMENT '模块描述',
  `modules_action` varchar(100) NOT NULL COMMENT '模块action',
  `modules_action_field` text COMMENT '模块action field权限',
  `modules_action_permissions` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '增 删 改 查权限',
  `modules_ico` varchar(50) NOT NULL COMMENT '图标',
  `modules_show` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否显示在菜单中',
  PRIMARY KEY (`modules_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `modules` */

insert  into `modules`(`modules_id`,`modules_father_id`,`modules_name`,`modules_order`,`modules_module`,`modules_describe`,`modules_action`,`modules_action_field`,`modules_action_permissions`,`modules_ico`,`modules_show`) values (1,1,'智能酒店管理',0,'index','index','',NULL,'','icon-home','1'),(2,2,'前厅',0,'frontOffice','frontOffice','',NULL,'','icon-reception','1'),(3,3,'客房',0,'rooms','rooms','',NULL,'','icon-rooms-management','1'),(4,4,'餐饮',0,'restaurant','restaurant','',NULL,'','icon-restaurant','1'),(5,5,'娱乐',0,'entertainment','entertainment','',NULL,'','icon-entertainment','1'),(6,6,'保安',0,'security','security','',NULL,'','icon-security','1'),(7,7,'销售',0,'sales','sales','',NULL,'','icon-sales','1'),(8,8,'行政',0,'administration','administration','',NULL,'','icon-administration','1'),(9,9,'财务',0,'financial','financial','',NULL,'','icon-financial','1'),(10,8,'后勤',0,'logistics','logistics','',NULL,'','icon-home','1'),(11,8,'人事',0,'personnel','personnel','',NULL,'','icon-personnel-management','1'),(12,12,'工程',0,'engineering','engineering','',NULL,'','icon-magnet','1'),(13,13,'采购',0,'purchase','purchase','',NULL,'','icon-inbox','1'),(14,14,'酒店设置',0,'hotelSetting','hotelSetting','',NULL,'0','icon-cog','1'),(15,14,'公司设置',0,'company','company','',NULL,'0','','1');

/*Table structure for table `multi_laguage_page` */

DROP TABLE IF EXISTS `multi_laguage_page`;

CREATE TABLE `multi_laguage_page` (
  `laguage` enum('简体中文','English') NOT NULL DEFAULT '简体中文' COMMENT '语言',
  `page_module` enum('common','company') NOT NULL COMMENT '页面模块，一个模块一个页面',
  `page_laguage_key` varchar(100) NOT NULL COMMENT '页面的多语言的key',
  `page_laguage_value` varchar(100) NOT NULL COMMENT '多语言的值',
  PRIMARY KEY (`laguage`,`page_module`,`page_laguage_key`),
  UNIQUE KEY `laguage` (`laguage`,`page_module`,`page_laguage_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `multi_laguage_page` */

insert  into `multi_laguage_page`(`laguage`,`page_module`,`page_laguage_key`,`page_laguage_value`) values ('简体中文','company','company_address','公司地址'),('简体中文','company','company_edit','点击编辑公司资料'),('简体中文','company','company_email','公司联系email'),('简体中文','company','company_fax','公司传真号码'),('简体中文','company','company_information','公司信息'),('简体中文','company','company_introduction','公司介绍'),('简体中文','company','company_location','所在位置'),('简体中文','company','company_mobile','公司移动电话'),('简体中文','company','company_name','公司名称'),('简体中文','company','company_phone','公司联系电话'),('简体中文','company','contact_information','联系方式');

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

insert  into `role_modules`(`role_id`,`modules_id`) values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14);

/*Table structure for table `role_modules_employee` */

DROP TABLE IF EXISTS `role_modules_employee`;

CREATE TABLE `role_modules_employee` (
  `role_id` int(11) NOT NULL,
  `modules_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `role_modules_action_permissions` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '0查 1增 2改 3删 权限',
  PRIMARY KEY (`modules_id`,`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_modules_employee` */

insert  into `role_modules_employee`(`role_id`,`modules_id`,`employee_id`,`role_modules_action_permissions`) values (1,1,1,'1'),(1,2,1,'1'),(1,3,1,'1'),(1,4,1,'1'),(1,5,1,'1'),(1,6,1,'1'),(1,7,1,'1'),(1,8,1,'1'),(1,9,1,'1'),(1,10,1,'1'),(1,11,1,'1'),(1,12,1,'1'),(1,13,1,'1'),(1,14,1,'1'),(1,15,1,'1');

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
