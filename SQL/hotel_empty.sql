/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.1.16-MariaDB : Database - hotel_empty
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotel_empty` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hotel_empty`;

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `book_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_type_id` int(11) NOT NULL COMMENT '预定来源 类型',
  `user_id` bigint(19) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL COMMENT '真实房号',
  `room_sell_layout_id` bigint(19) NOT NULL COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL COMMENT '基础房型',
  `room_layout_price_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖房型价格ID',
  `room_layout_price_system_id` int(11) DEFAULT NULL COMMENT '价格体系ID',
  `book_room_extra_bed` tinyint(3) DEFAULT NULL COMMENT '加床 几张',
  `book_room_price` double DEFAULT '0' COMMENT '客房总房费',
  `book_extra_bed_price` double NOT NULL DEFAULT '0' COMMENT '加床总价',
  `book_cash_pledge` double NOT NULL COMMENT '押金',
  `book_cash_pledge_returns` enum('0','1') NOT NULL DEFAULT '0' COMMENT '1押金已退',
  `book_total_price` double DEFAULT NULL COMMENT 'A1 支付总价',
  `book_total_room_rate` double NOT NULL DEFAULT '0' COMMENT 'A1 总房价',
  `book_need_service_price` double NOT NULL DEFAULT '0' COMMENT 'A1 附加服务费',
  `book_service_charge` double NOT NULL DEFAULT '0' COMMENT 'A1 服务费',
  `book_total_cash_pledge` double DEFAULT NULL COMMENT 'A1 总押金',
  `book_total_cash_pledge_returns` enum('0','1','2') DEFAULT NULL COMMENT '总押金 1已退 2已退部分',
  `book_is_pay` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'A2 是否全额支付 ---（动词）',
  `book_is_payment` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'A2 全额是否到帐 --- 区分钱是否入账（名词）',
  `payment_type_id` tinyint(3) DEFAULT NULL COMMENT 'A-A2 支付类型 ---',
  `book_pay_date` datetime DEFAULT NULL COMMENT 'A2 全额支付时间',
  `book_prepayment_price` double NOT NULL DEFAULT '0' COMMENT 'A1 预付费',
  `book_is_prepayment` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'A2 是否已预付',
  `book_prepayment_date` datetime DEFAULT NULL COMMENT 'A2 预付费支付时间',
  `prepayment_type_id` tinyint(3) DEFAULT NULL COMMENT 'A2 预付支付类型',
  `book_prepayment_account` varchar(50) DEFAULT NULL COMMENT 'A2 预付支付帐号',
  `book_balance_payment_date` datetime DEFAULT NULL COMMENT 'A2 余款支付时间',
  `book_payment_voucher` varchar(300) DEFAULT NULL COMMENT 'A 付款凭证',
  `book_order_number_main` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'A 是否主订单号 1主订单号 2加房主订单.....',
  `book_order_number` bigint(19) NOT NULL COMMENT 'A3 订单号',
  `book_order_number_main_status` enum('0','1','-1') NOT NULL DEFAULT '0' COMMENT '主订单状态 0等待入住 1入住完成 已入住 -1退房完成 已退房',
  `book_order_number_status` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'A3 订单状态  -99失效 -1退房完成 已退房 0预定成功 未入住 1入住完成 已入住',
  `book_discount_id` int(11) NOT NULL DEFAULT '0' COMMENT 'A3 折扣ID',
  `book_discount_type` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0' COMMENT '折扣还是直减',
  `book_discount` double NOT NULL DEFAULT '0' COMMENT 'A3 实际折扣',
  `book_discount_describe` varchar(2000) NOT NULL DEFAULT '' COMMENT 'A3 折扣描述',
  `book_order_number_ourter` varchar(50) DEFAULT NULL COMMENT 'A3 外部订单号',
  `book_check_in` datetime NOT NULL COMMENT 'A3 入住时间',
  `book_check_out` datetime NOT NULL COMMENT 'A3 退房时间',
  `book_days_total` double DEFAULT NULL COMMENT 'A3 总共几天',
  `book_order_retention_time` varchar(50) NOT NULL DEFAULT '' COMMENT 'A3 订单保留时间',
  `book_half_price` varchar(50) DEFAULT NULL COMMENT 'A3 半天房费计算时间',
  `book_contact_name` varchar(50) DEFAULT NULL COMMENT 'A3 联系人',
  `book_contact_email` varchar(50) DEFAULT NULL COMMENT 'A3 email',
  `book_contact_mobile` bigint(11) DEFAULT NULL COMMENT 'A3 联系人移动电话',
  `book_contact_second_name` varchar(50) DEFAULT NULL COMMENT '预定第二联系人',
  `book_contact_second_mobile` varchar(50) DEFAULT NULL COMMENT '预定第二联系人电话',
  `book_add_date` date NOT NULL COMMENT 'A3 添加时间',
  `book_add_time` time NOT NULL COMMENT 'A3 添加时间',
  `book_comments` varchar(2000) NOT NULL DEFAULT '' COMMENT 'A3 备注',
  `book_add_datetime` datetime DEFAULT NULL,
  `book_change` enum('0','add_room','continued_room','change_room','have_change_room','have_continued_room') NOT NULL DEFAULT '0' COMMENT '0无变化  add_room新增 change_room换房 continued_room续房 have_change_room已换房 have_continued_room已续房',
  `book_change_free` enum('0','1') NOT NULL DEFAULT '0' COMMENT '1免费换房',
  `book_change_datetime` datetime DEFAULT NULL,
  `book_night_audit_date` date DEFAULT NULL COMMENT '最后夜审日期',
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book` */

/*Table structure for table `book_change` */

DROP TABLE IF EXISTS `book_change`;

CREATE TABLE `book_change` (
  `book_change_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `hotel_id` bigint(19) NOT NULL,
  `book_order_number` bigint(19) NOT NULL COMMENT '订单号',
  `book_change_type` enum('change_room') NOT NULL COMMENT '改变类型',
  `book_change_reason` varchar(500) NOT NULL COMMENT '改变原因',
  `book_change_date` date NOT NULL,
  `book_change_time` time NOT NULL,
  `book_change_add_date` datetime NOT NULL,
  PRIMARY KEY (`book_change_id`,`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_change` */

/*Table structure for table `book_discount` */

DROP TABLE IF EXISTS `book_discount`;

CREATE TABLE `book_discount` (
  `book_discount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '折扣体系ID',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `union_id` int(11) NOT NULL DEFAULT '0' COMMENT '联盟ID',
  `book_type_father_id` int(11) NOT NULL DEFAULT '0',
  `book_type_id` int(11) NOT NULL COMMENT '预订类型',
  `book_discount` double NOT NULL DEFAULT '100' COMMENT '折扣',
  `book_discount_type` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT '折扣类别 0折扣 1直减',
  `book_discount_name` varchar(100) NOT NULL DEFAULT '' COMMENT '折扣名称',
  `agreement_company_name` varchar(100) NOT NULL DEFAULT '' COMMENT '协议公司\\团体等名称',
  `agreement_company_contacts` varchar(50) DEFAULT NULL COMMENT '联系人',
  `agreement_company_address` varchar(255) DEFAULT NULL COMMENT '协议公司\\团体等地址',
  `agreement_company_mobile` varchar(50) DEFAULT NULL COMMENT '协议公司\\团体等移动电话',
  `agreement_company_phone` varchar(50) DEFAULT NULL COMMENT '联系电话',
  `agreement_company_fax` varchar(50) DEFAULT NULL COMMENT '传真',
  `agreement_company_email` varchar(50) DEFAULT NULL COMMENT 'email',
  `agreement_company_introduction` varchar(500) DEFAULT NULL COMMENT '协议公司\\团体等介绍',
  `agreement_content` text COMMENT '协议内容',
  `agreement_attachment` varchar(255) DEFAULT NULL COMMENT '协议附件',
  `agreement_active_time_begin` date DEFAULT NULL COMMENT '协议有效时间 开始时间',
  `agreement_active_time_end` date DEFAULT NULL COMMENT '协议有效时间 结束时间',
  `book_discount_add_date` date DEFAULT NULL COMMENT '添加时间',
  `book_discount_add_time` time DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`book_discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_discount` */

/*Table structure for table `book_expand` */

DROP TABLE IF EXISTS `book_expand`;

CREATE TABLE `book_expand` (
  `book_order_number` bigint(19) NOT NULL COMMENT '订单号',
  `book_credit_authorized_amount` double NOT NULL DEFAULT '0' COMMENT '预授权金额',
  `book_credit_authorized_number` varchar(50) DEFAULT NULL COMMENT '预授权单据号',
  `book_credit_authorized_days` varchar(50) DEFAULT NULL COMMENT '预授权有效天数',
  `book_credit_card_number` varchar(50) DEFAULT NULL COMMENT '信用卡号',
  `book_credit_deadline` date DEFAULT NULL COMMENT '信用卡过期时间',
  PRIMARY KEY (`book_order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_expand` */

/*Table structure for table `book_hotel_service` */

DROP TABLE IF EXISTS `book_hotel_service`;

CREATE TABLE `book_hotel_service` (
  `book_hotel_service_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_id` bigint(19) NOT NULL,
  `book_order_number` bigint(19) NOT NULL,
  `hotel_service_id` int(11) NOT NULL DEFAULT '0',
  `employee_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `hotel_service_price` double NOT NULL COMMENT '价格 -1 表示此类不含价格 0表示免费',
  `book_hotel_service_num` mediumint(6) NOT NULL DEFAULT '1' COMMENT '数量',
  `book_hotel_service_discount` mediumint(6) DEFAULT '100' COMMENT '折扣',
  `book_hotel_service_total_price` double DEFAULT NULL COMMENT '总价',
  PRIMARY KEY (`book_hotel_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_hotel_service` */

/*Table structure for table `book_night_audit` */

DROP TABLE IF EXISTS `book_night_audit`;

CREATE TABLE `book_night_audit` (
  `book_night_audit_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '夜审营收报表',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `book_order_number` bigint(19) NOT NULL COMMENT '订单号',
  `book_id` bigint(19) NOT NULL COMMENT '主订单订单ID',
  `employee_id` int(11) NOT NULL,
  `book_type_id` int(11) NOT NULL COMMENT '来源',
  `book_discount_id` int(11) NOT NULL COMMENT '折扣ID',
  `book_discount` double NOT NULL COMMENT '折扣',
  `room_sell_layout_id` int(11) NOT NULL COMMENT '销售房型',
  `room_layout_id` int(11) NOT NULL COMMENT '基础房型',
  `room_layout_price_system_id` int(11) NOT NULL DEFAULT '0' COMMENT '价格体系ID',
  `book_night_audit_fiscal_day` date NOT NULL COMMENT '财日',
  `book_fiscal_day_quantum_begin` varchar(50) DEFAULT NULL COMMENT '财日完整时间 1为1天',
  `book_fiscal_day_quantum_to` varchar(50) DEFAULT NULL,
  `hotel_service_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务ID',
  `hotel_service_num` int(11) DEFAULT '0' COMMENT '数量',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '入住的客房（当为服务时，此处为服务ID）',
  `price` double NOT NULL COMMENT '价格',
  `book_night_audit_income` double NOT NULL COMMENT '收入（折扣后）',
  `book_night_audit_income_type` enum('room','service_charge','extra_bed','extra_service') NOT NULL DEFAULT 'room' COMMENT '营收类型 room：客房 service：服务类型 service_charge  服务费 extra_bed 加床',
  `unique_key` bigint(19) NOT NULL DEFAULT '0',
  `book_is_check_employee_id` int(11) NOT NULL COMMENT '夜审核对员工',
  `book_is_night_audit` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否已经夜审',
  `book_night_audit_valid` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否有效',
  `book_night_audit_valid_reason` enum('0','1','-1','-2','-3') NOT NULL DEFAULT '0' COMMENT '0正常 -1提前退房 -2换房 -3续房',
  `book_is_check_add_datetime` datetime NOT NULL COMMENT '添加时间',
  `book_night_audit_date` date DEFAULT NULL COMMENT '夜审日期',
  `book_night_audit_datetime` datetime DEFAULT NULL COMMENT '夜审时间',
  PRIMARY KEY (`book_night_audit_id`),
  UNIQUE KEY `book_night_audit_fiscal_day` (`book_night_audit_fiscal_day`,`room_id`,`book_night_audit_income_type`,`unique_key`,`book_fiscal_day_quantum_begin`,`book_fiscal_day_quantum_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_night_audit` */

/*Table structure for table `book_returns` */

DROP TABLE IF EXISTS `book_returns`;

CREATE TABLE `book_returns` (
  `book_returns_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '退房退款ID',
  `employee_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `book_id` bigint(19) NOT NULL,
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间号',
  `book_order_number` bigint(19) NOT NULL COMMENT '订单号',
  `book_returns_date` date NOT NULL COMMENT '退款日期',
  `book_returns_price` double NOT NULL COMMENT '退款金额',
  `book_returns_cash_pledge` double NOT NULL DEFAULT '0' COMMENT '退押金',
  `book_returns_type` enum('room','service_charge','extra_bed','extra_service') DEFAULT NULL COMMENT '退款类型',
  `book_returns_add_date` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`book_returns_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_returns` */

/*Table structure for table `book_room_extra_bed_price` */

DROP TABLE IF EXISTS `book_room_extra_bed_price`;

CREATE TABLE `book_room_extra_bed_price` (
  `book_room_extra_bed_price_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_id` bigint(19) NOT NULL,
  `book_order_number` bigint(19) NOT NULL,
  `room_layout_price_id` bigint(19) NOT NULL DEFAULT '0',
  `room_sell_layout_id` bigint(19) NOT NULL COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL COMMENT '基本房型ID',
  `room_layout_price_system_id` int(11) NOT NULL COMMENT '价格体系',
  `employee_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作员工',
  `hotel_id` int(11) NOT NULL,
  `room_layout_date_year` enum('2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030') NOT NULL,
  `room_layout_date_month` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL,
  `01_day` double DEFAULT NULL,
  `02_day` double DEFAULT NULL,
  `03_day` double DEFAULT NULL,
  `04_day` double DEFAULT NULL,
  `05_day` double DEFAULT NULL,
  `06_day` double DEFAULT NULL,
  `07_day` double DEFAULT NULL,
  `08_day` double DEFAULT NULL,
  `09_day` double DEFAULT NULL,
  `10_day` double DEFAULT NULL,
  `11_day` double DEFAULT NULL,
  `12_day` double DEFAULT NULL,
  `13_day` double DEFAULT NULL,
  `14_day` double DEFAULT NULL,
  `15_day` double DEFAULT NULL,
  `16_day` double DEFAULT NULL,
  `17_day` double DEFAULT NULL,
  `18_day` double DEFAULT NULL,
  `19_day` double DEFAULT NULL,
  `20_day` double DEFAULT NULL,
  `21_day` double DEFAULT NULL,
  `22_day` double DEFAULT NULL,
  `23_day` double DEFAULT NULL,
  `24_day` double DEFAULT NULL,
  `25_day` double DEFAULT NULL,
  `26_day` double DEFAULT NULL,
  `27_day` double DEFAULT NULL,
  `28_day` double DEFAULT NULL,
  `29_day` double DEFAULT NULL,
  `30_day` double DEFAULT NULL,
  `31_day` double DEFAULT NULL,
  PRIMARY KEY (`book_room_extra_bed_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_room_extra_bed_price` */

/*Table structure for table `book_room_price` */

DROP TABLE IF EXISTS `book_room_price`;

CREATE TABLE `book_room_price` (
  `book_room_price_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_id` bigint(19) NOT NULL,
  `book_order_number` bigint(19) NOT NULL,
  `room_layout_price_id` bigint(19) NOT NULL DEFAULT '0',
  `room_sell_layout_id` bigint(19) NOT NULL COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL COMMENT '基本房型ID',
  `room_layout_price_system_id` int(11) NOT NULL COMMENT '价格体系',
  `employee_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作员工',
  `hotel_id` int(11) NOT NULL,
  `room_layout_date_year` enum('2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030') NOT NULL,
  `room_layout_date_month` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL,
  `01_day` double DEFAULT NULL,
  `02_day` double DEFAULT NULL,
  `03_day` double DEFAULT NULL,
  `04_day` double DEFAULT NULL,
  `05_day` double DEFAULT NULL,
  `06_day` double DEFAULT NULL,
  `07_day` double DEFAULT NULL,
  `08_day` double DEFAULT NULL,
  `09_day` double DEFAULT NULL,
  `10_day` double DEFAULT NULL,
  `11_day` double DEFAULT NULL,
  `12_day` double DEFAULT NULL,
  `13_day` double DEFAULT NULL,
  `14_day` double DEFAULT NULL,
  `15_day` double DEFAULT NULL,
  `16_day` double DEFAULT NULL,
  `17_day` double DEFAULT NULL,
  `18_day` double DEFAULT NULL,
  `19_day` double DEFAULT NULL,
  `20_day` double DEFAULT NULL,
  `21_day` double DEFAULT NULL,
  `22_day` double DEFAULT NULL,
  `23_day` double DEFAULT NULL,
  `24_day` double DEFAULT NULL,
  `25_day` double DEFAULT NULL,
  `26_day` double DEFAULT NULL,
  `27_day` double DEFAULT NULL,
  `28_day` double DEFAULT NULL,
  `29_day` double DEFAULT NULL,
  `30_day` double DEFAULT NULL,
  `31_day` double DEFAULT NULL,
  PRIMARY KEY (`book_room_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_room_price` */

/*Table structure for table `book_sales_type` */

DROP TABLE IF EXISTS `book_sales_type`;

CREATE TABLE `book_sales_type` (
  `book_sales_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `book_sales_type_name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`book_sales_type_id`,`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `book_sales_type` */

insert  into `book_sales_type`(`book_sales_type_id`,`hotel_id`,`book_sales_type_name`,`type`) values (1,0,'本店直销','member'),(2,0,'分销渠道','OTA'),(3,0,'集团预定','agreement');

/*Table structure for table `book_type` */

DROP TABLE IF EXISTS `book_type`;

CREATE TABLE `book_type` (
  `book_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '预定类型：前台预定或电   协议公司预订  团队预定  渠道纸质订单',
  `book_type_father_id` int(11) DEFAULT NULL COMMENT '父ID',
  `hotel_id` int(11) NOT NULL DEFAULT '0',
  `book_sales_type_id` int(11) NOT NULL COMMENT '销售类型',
  `book_type_name` varchar(50) NOT NULL COMMENT '名称',
  `book_type_comments` varchar(1000) DEFAULT NULL COMMENT '备注',
  `type` enum('OTA','member','agreement','team','walk-in','other') NOT NULL,
  PRIMARY KEY (`book_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `book_type` */

insert  into `book_type`(`book_type_id`,`book_type_father_id`,`hotel_id`,`book_sales_type_id`,`book_type_name`,`book_type_comments`,`type`) values (1,1,0,1,'会员',NULL,'member'),(2,2,0,1,'散客',NULL,'walk-in'),(3,2,0,1,'散客步入',NULL,'walk-in'),(4,4,0,3,'集团订房热线',NULL,'agreement'),(5,5,0,1,'协议公司',NULL,'agreement'),(6,5,0,1,'协议公司',NULL,'agreement'),(7,7,0,2,'国外OTA',NULL,'OTA'),(8,8,0,2,'国内OTA',NULL,'OTA'),(9,7,0,2,'booking',NULL,'OTA'),(10,4,0,3,'400电话',NULL,'agreement');

/*Table structure for table `book_type_laguage` */

DROP TABLE IF EXISTS `book_type_laguage`;

CREATE TABLE `book_type_laguage` (
  `book_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '预定类型：前台预定或电   协议公司预订  团队预定  渠道纸质订单',
  `multi_laguage` enum('English') DEFAULT NULL,
  `book_type_name` varchar(50) NOT NULL COMMENT '名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_type_laguage` */

/*Table structure for table `book_user` */

DROP TABLE IF EXISTS `book_user`;

CREATE TABLE `book_user` (
  `book_user_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `book_id` bigint(19) NOT NULL DEFAULT '0' COMMENT '主订单订单ID',
  `employee_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `user_id` bigint(19) NOT NULL DEFAULT '0',
  `room_id` int(11) NOT NULL COMMENT '真实房号',
  `book_order_number` bigint(19) NOT NULL COMMENT '订单号',
  `room_sell_layout_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL DEFAULT '0' COMMENT '基础房型ID',
  `book_user_name` varchar(50) DEFAULT NULL,
  `book_user_sex` enum('0','1') NOT NULL DEFAULT '1',
  `book_user_lodger_type` enum('adult','children','extra_bed') NOT NULL DEFAULT 'adult',
  `book_user_mobile` bigint(11) NOT NULL DEFAULT '0',
  `book_user_email` varchar(50) DEFAULT NULL,
  `book_user_address` varchar(200) DEFAULT NULL,
  `book_user_id_card_type` varchar(200) DEFAULT NULL COMMENT '证件类型',
  `book_user_id_card` varchar(200) DEFAULT NULL COMMENT '证件号',
  `book_is_extra_bed` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否是加床',
  `book_check_in` datetime DEFAULT NULL COMMENT '入住时间',
  `book_check_out` datetime DEFAULT NULL COMMENT '退房时间',
  `book_add_date` date NOT NULL COMMENT '添加时间',
  `book_add_time` time NOT NULL COMMENT '添加时间',
  `book_user_comments` varchar(2000) NOT NULL DEFAULT '' COMMENT '备注',
  `book_user_change` enum('0','1','2','3','4','-1') NOT NULL DEFAULT '0' COMMENT '0无变化 1换房 2退房 -1取消入住',
  `book_user_room_card` enum('0','1','2','-1') NOT NULL DEFAULT '0' COMMENT '0为领 1已领 2已退',
  PRIMARY KEY (`book_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `book_user` */

/*Table structure for table `cancellation_policy` */

DROP TABLE IF EXISTS `cancellation_policy`;

CREATE TABLE `cancellation_policy` (
  `cancellation_policy_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`cancellation_policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cancellation_policy` */

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_group` int(11) DEFAULT NULL COMMENT '公司群 company_id == company_group 为母公司',
  `company_is_delet` bit(1) NOT NULL DEFAULT b'0' COMMENT '公司是否被删除',
  `company_name` varchar(200) NOT NULL DEFAULT '' COMMENT '公司名称',
  `company_address` varchar(200) NOT NULL DEFAULT '' COMMENT '公司地址',
  `company_mobile` bigint(19) DEFAULT NULL COMMENT '移动电话',
  `company_phone` varchar(50) DEFAULT '' COMMENT '公司电话',
  `company_fax` varchar(50) DEFAULT '' COMMENT '公司传真',
  `company_email` varchar(100) DEFAULT '' COMMENT '公司email',
  `company_web` varchar(255) DEFAULT NULL,
  `company_finance_phone` varchar(100) DEFAULT NULL COMMENT '财会电话',
  `company_finance_email` varchar(100) DEFAULT NULL,
  `company_sales_phone` varchar(100) DEFAULT NULL COMMENT '销售电话',
  `company_sales_email` varchar(100) DEFAULT NULL,
  `company_information_phone` varchar(100) DEFAULT NULL COMMENT '信息部电话',
  `company_information_email` varchar(100) DEFAULT NULL,
  `company_introduction` text NOT NULL COMMENT '公司介绍',
  `company_longitude` varchar(50) NOT NULL DEFAULT '' COMMENT '经度',
  `company_latitude` varchar(50) NOT NULL DEFAULT '' COMMENT '纬度',
  `company_country` varchar(50) NOT NULL DEFAULT '' COMMENT '国家',
  `company_province` varchar(50) NOT NULL DEFAULT '' COMMENT '省、直辖市',
  `company_city` varchar(50) NOT NULL DEFAULT '' COMMENT '市、直辖市下级类型',
  `company_town` varchar(50) NOT NULL DEFAULT '' COMMENT '县\\城镇\\区',
  `company_add_date` date NOT NULL,
  `company_add_time` time NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `company` */

insert  into `company`(`company_id`,`company_group`,`company_is_delet`,`company_name`,`company_address`,`company_mobile`,`company_phone`,`company_fax`,`company_email`,`company_web`,`company_finance_phone`,`company_finance_email`,`company_sales_phone`,`company_sales_email`,`company_information_phone`,`company_information_email`,`company_introduction`,`company_longitude`,`company_latitude`,`company_country`,`company_province`,`company_city`,`company_town`,`company_add_date`,`company_add_time`) values (0,0,'\0','','',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','0000-00-00','00:00:00'),(1,NULL,'\0','有一点漂亮的公司','',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','2017-01-20','00:00:00'),(2,NULL,'\0','北京远见信诚投资咨询有限公司','',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','2017-01-20','00:00:00');

/*Table structure for table `company_laguage` */

DROP TABLE IF EXISTS `company_laguage`;

CREATE TABLE `company_laguage` (
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

/*Data for the table `company_laguage` */

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `department_same` int(11) DEFAULT NULL COMMENT '同级父类ID',
  `department_same_order` int(11) NOT NULL DEFAULT '0' COMMENT '同级排序',
  `department_father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父类ID',
  `department_name` varchar(100) NOT NULL COMMENT '部门名称',
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`department_id`,`hotel_id`,`department_same`,`department_same_order`,`department_father_id`,`department_name`) values (1,1,NULL,0,0,'IT部'),(2,2,NULL,0,0,'总经理');

/*Table structure for table `department_position` */

DROP TABLE IF EXISTS `department_position`;

CREATE TABLE `department_position` (
  `department_position_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `department_position_name` varchar(50) NOT NULL,
  PRIMARY KEY (`department_position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `department_position` */

insert  into `department_position`(`department_position_id`,`hotel_id`,`department_id`,`department_position_name`) values (1,1,1,'IT管理员'),(2,2,2,'总经理');

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL COMMENT '默认公司',
  `hotel_id` int(11) NOT NULL COMMENT '默认酒店',
  `department_id` int(11) NOT NULL,
  `department_position_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `employee_name` varchar(50) NOT NULL COMMENT '名字',
  `employee_sex` enum('0','1') NOT NULL COMMENT '性别',
  `employee_birthday` date DEFAULT NULL COMMENT '出生日期',
  `employee_photo` varchar(200) DEFAULT NULL COMMENT '头像',
  `employee_mobile` bigint(11) NOT NULL,
  `employee_email` varchar(200) DEFAULT NULL,
  `employee_weixin` varchar(200) DEFAULT NULL,
  `employee_password` varchar(50) NOT NULL,
  `employee_password_salt` varchar(50) NOT NULL,
  `employee_add_date` date NOT NULL,
  `employee_add_time` time NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `hotel_id` (`hotel_id`,`employee_mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `employee` */

insert  into `employee`(`employee_id`,`company_id`,`hotel_id`,`department_id`,`department_position_id`,`role_id`,`employee_name`,`employee_sex`,`employee_birthday`,`employee_photo`,`employee_mobile`,`employee_email`,`employee_weixin`,`employee_password`,`employee_password_salt`,`employee_add_date`,`employee_add_time`) values (1,1,1,1,1,0,'luochi','1',NULL,NULL,18500353881,'kefu@yelove.cn',NULL,'74ac44b1aaec5037c424ccece16bdd14','585568','2017-01-20','00:00:00'),(2,2,2,2,2,0,'王思远','0',NULL,NULL,13381187822,'wangsiyuan@hotelbrain.cn',NULL,'74ac44b1aaec5037c424ccece16bdd14','585568','2017-01-20','00:00:00');

/*Table structure for table `employee_department` */

DROP TABLE IF EXISTS `employee_department`;

CREATE TABLE `employee_department` (
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL DEFAULT '0',
  `employee_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL DEFAULT '0',
  `department_position_id` int(11) NOT NULL COMMENT '职位ID （多职位）',
  PRIMARY KEY (`company_id`,`hotel_id`,`employee_id`,`department_id`),
  UNIQUE KEY `company_hotel_employee_department_` (`company_id`,`hotel_id`,`employee_id`,`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employee_department` */

insert  into `employee_department`(`company_id`,`hotel_id`,`employee_id`,`department_id`,`department_position_id`) values (1,1,1,1,1),(2,2,2,2,2);

/*Table structure for table `employee_images` */

DROP TABLE IF EXISTS `employee_images`;

CREATE TABLE `employee_images` (
  `employee_images_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `employee_images_name` varchar(100) DEFAULT NULL,
  `employee_images_path` varchar(200) NOT NULL DEFAULT '' COMMENT '路径',
  `employee_images_filesize` int(11) NOT NULL DEFAULT '0' COMMENT '图片大小',
  `employee_images_type` enum('id_card','labor','avatar') DEFAULT 'avatar',
  `employee_images_add_date` date NOT NULL,
  `employee_images_add_time` time NOT NULL,
  PRIMARY KEY (`employee_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employee_images` */

/*Table structure for table `employee_personnel_file` */

DROP TABLE IF EXISTS `employee_personnel_file`;

CREATE TABLE `employee_personnel_file` (
  `employee_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `employee_id_card` varchar(50) DEFAULT NULL COMMENT '身份证',
  `employee_address` varchar(255) DEFAULT NULL COMMENT '家庭地址',
  `employee_present_address` varchar(255) DEFAULT NULL COMMENT '现住址',
  `employee_positive_id_card` varchar(255) DEFAULT NULL COMMENT '身份证正面',
  `employee_back_id_card` varchar(255) DEFAULT NULL COMMENT '身份证背面',
  `employee_entry_date` date DEFAULT NULL COMMENT '入职时间',
  `employee_probation_date` date DEFAULT NULL COMMENT '试用期结束时间',
  `employee_number` varchar(255) DEFAULT NULL COMMENT '员工工号',
  `employee_photo_labor` text COMMENT '劳动合同照片',
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employee_personnel_file` */

/*Table structure for table `hotel` */

DROP TABLE IF EXISTS `hotel`;

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL COMMENT '属于公司ID',
  `company_group` int(11) DEFAULT NULL COMMENT '属于公司集团',
  `hotel_group` varchar(50) DEFAULT NULL COMMENT '酒店群',
  `hotel_is_delet` bit(1) NOT NULL DEFAULT b'0' COMMENT '酒店是否被删除',
  `hotel_name` varchar(200) NOT NULL COMMENT '酒店名称',
  `hotel_en_name` varchar(500) DEFAULT NULL COMMENT '英文名称',
  `hotel_short_name` varchar(500) DEFAULT NULL COMMENT '简称',
  `hotel_address` varchar(200) DEFAULT NULL COMMENT '酒店地址',
  `hotel_nearest_intersection` varchar(1000) DEFAULT NULL COMMENT '最近路口或标志建筑',
  `hotel_phone` varchar(50) DEFAULT NULL COMMENT '酒店电话',
  `hotel_mobile` varchar(50) DEFAULT NULL COMMENT '酒店手机',
  `hotel_fax` varchar(50) DEFAULT NULL COMMENT '酒店传真',
  `hotel_email` varchar(50) DEFAULT NULL COMMENT '酒店emial',
  `hotel_longitude` float DEFAULT NULL COMMENT '经度',
  `hotel_latitude` float DEFAULT NULL COMMENT '纬度',
  `hotel_country` varchar(50) DEFAULT NULL COMMENT '国家',
  `hotel_province` varchar(50) DEFAULT NULL COMMENT '省',
  `hotel_city` varchar(50) DEFAULT NULL COMMENT '市、县',
  `hotel_town` varchar(50) DEFAULT NULL COMMENT '城镇',
  `hotel_booking_notes` varchar(1000) NOT NULL COMMENT '预定须知',
  `hotel_type` varchar(50) NOT NULL DEFAULT 'hotel' COMMENT '酒店类型',
  `hotel_star` varchar(3) DEFAULT NULL COMMENT '酒店星级',
  `hotel_brand` varchar(100) DEFAULT NULL COMMENT '酒店品牌',
  `hotel_wifi` bit(1) NOT NULL DEFAULT b'1' COMMENT '酒店wifi',
  `hotel_checkin` varchar(50) DEFAULT NULL,
  `hotel_checkout` varchar(50) DEFAULT NULL,
  `hotel_overtime` varchar(50) DEFAULT NULL COMMENT '几点前算半天房费，几点后算1天房费',
  `hotel_web` varchar(255) DEFAULT NULL COMMENT '酒店网站',
  `hotel_opening_date` date DEFAULT NULL COMMENT '酒店开业年月',
  `hotel_latest_decoration_date` date DEFAULT NULL COMMENT '最新装修年月',
  `hotel_number_of_rooms` int(11) DEFAULT NULL COMMENT '房间数',
  `hotel_introduce_short` varchar(1000) DEFAULT NULL COMMENT '酒店简短介绍',
  `hotel_introduce` text COMMENT '酒店介绍',
  `hotel_design_style` varchar(2000) DEFAULT NULL COMMENT '设计风格',
  `hotel_architectural_feature` varchar(2000) DEFAULT NULL COMMENT '建筑特色',
  `hotel_features` varchar(2000) DEFAULT NULL COMMENT '酒店特色',
  `hotel_breakfast_introduction` varchar(2000) DEFAULT NULL COMMENT '早餐介绍:',
  `hotel_restaurant_features` varchar(2000) DEFAULT NULL COMMENT '餐厅特色',
  `hotel_traffic` varchar(2000) DEFAULT NULL COMMENT '酒店交通',
  `hotel_peripheral_features` varchar(2000) DEFAULT NULL COMMENT '周边特色',
  `hotel_general_manager` varchar(50) DEFAULT NULL COMMENT '负责人/店长/总经理',
  `hotel_general_manager_title` varchar(50) DEFAULT NULL COMMENT '职务',
  `hotel_general_manager_mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `hotel_general_manager_phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `hotel_general_manager_email` varchar(50) DEFAULT NULL COMMENT 'email',
  `hotel_general_manager_fax` varchar(50) DEFAULT NULL COMMENT '传真',
  `hotel_sales_contact` varchar(50) DEFAULT NULL,
  `hotel_sales_contact_title` varchar(50) DEFAULT NULL,
  `hotel_sales_contact_mobile` varchar(50) DEFAULT NULL,
  `hotel_sales_contact_phone` varchar(50) DEFAULT NULL,
  `hotel_sales_contact_email` varchar(50) DEFAULT NULL,
  `hotel_sales_contact_fax` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact_title` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact_mobile` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact_phone` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact_email` varchar(50) DEFAULT NULL,
  `hotel_reservation_contact_fax` varchar(50) DEFAULT NULL,
  `hotel_finance_contact` varchar(50) DEFAULT NULL,
  `hotel_finance_contact_title` varchar(50) DEFAULT NULL,
  `hotel_finance_contact_mobile` varchar(50) DEFAULT NULL,
  `hotel_finance_contact_phone` varchar(50) DEFAULT NULL,
  `hotel_finance_contact_email` varchar(50) DEFAULT NULL,
  `hotel_finance_contact_fax` varchar(50) DEFAULT NULL,
  `hotel_add_date` date NOT NULL,
  `hotel_add_time` time NOT NULL,
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `hotel` */

insert  into `hotel`(`hotel_id`,`company_id`,`company_group`,`hotel_group`,`hotel_is_delet`,`hotel_name`,`hotel_en_name`,`hotel_short_name`,`hotel_address`,`hotel_nearest_intersection`,`hotel_phone`,`hotel_mobile`,`hotel_fax`,`hotel_email`,`hotel_longitude`,`hotel_latitude`,`hotel_country`,`hotel_province`,`hotel_city`,`hotel_town`,`hotel_booking_notes`,`hotel_type`,`hotel_star`,`hotel_brand`,`hotel_wifi`,`hotel_checkin`,`hotel_checkout`,`hotel_overtime`,`hotel_web`,`hotel_opening_date`,`hotel_latest_decoration_date`,`hotel_number_of_rooms`,`hotel_introduce_short`,`hotel_introduce`,`hotel_design_style`,`hotel_architectural_feature`,`hotel_features`,`hotel_breakfast_introduction`,`hotel_restaurant_features`,`hotel_traffic`,`hotel_peripheral_features`,`hotel_general_manager`,`hotel_general_manager_title`,`hotel_general_manager_mobile`,`hotel_general_manager_phone`,`hotel_general_manager_email`,`hotel_general_manager_fax`,`hotel_sales_contact`,`hotel_sales_contact_title`,`hotel_sales_contact_mobile`,`hotel_sales_contact_phone`,`hotel_sales_contact_email`,`hotel_sales_contact_fax`,`hotel_reservation_contact`,`hotel_reservation_contact_title`,`hotel_reservation_contact_mobile`,`hotel_reservation_contact_phone`,`hotel_reservation_contact_email`,`hotel_reservation_contact_fax`,`hotel_finance_contact`,`hotel_finance_contact_title`,`hotel_finance_contact_mobile`,`hotel_finance_contact_phone`,`hotel_finance_contact_email`,`hotel_finance_contact_fax`,`hotel_add_date`,`hotel_add_time`) values (0,0,NULL,NULL,'\0','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','hotel',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0000-00-00','00:00:00'),(1,1,NULL,NULL,'\0','有一点公司',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','hotel',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-20','00:00:00'),(2,2,NULL,NULL,'\0','欣得酒店上地店',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','hotel',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-01-20','00:00:00');

/*Table structure for table `hotel_attribute` */

DROP TABLE IF EXISTS `hotel_attribute`;

CREATE TABLE `hotel_attribute` (
  `hotel_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL DEFAULT '0',
  `hotel_attribute_father_id` int(11) NOT NULL COMMENT '父ID 2级总共',
  `hotel_attribute_name` varchar(200) NOT NULL COMMENT '属性名称',
  `hotel_attribute_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `hotel_attribute_value_type` enum('time','date','datetime','text') DEFAULT NULL,
  `hotel_attribute_is_filter` enum('0','1') DEFAULT '0' COMMENT '作为筛选',
  PRIMARY KEY (`hotel_attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute` */

insert  into `hotel_attribute`(`hotel_attribute_id`,`hotel_id`,`hotel_attribute_father_id`,`hotel_attribute_name`,`hotel_attribute_order`,`hotel_attribute_value_type`,`hotel_attribute_is_filter`) values (1,0,1,'订前必读',0,NULL,'0'),(2,0,1,'儿童和加床',0,NULL,'0'),(3,0,1,'宠物',0,NULL,'0'),(4,0,4,'酒店设施',0,NULL,'0'),(5,0,4,'商务设施',0,NULL,'0'),(6,0,4,'活动设施',0,NULL,'0'),(7,0,7,'酒店周边',0,NULL,'0'),(8,0,7,'附近地标',0,NULL,'0'),(9,0,7,'附近交通',0,NULL,'0'),(11,1,1,'食品',0,NULL,'0');

/*Table structure for table `hotel_attribute_laguage` */

DROP TABLE IF EXISTS `hotel_attribute_laguage`;

CREATE TABLE `hotel_attribute_laguage` (
  `hotel_attribute_id` int(11) NOT NULL DEFAULT '0',
  `multi_laguage` enum('English') DEFAULT NULL,
  `hotel_attribute_name` varchar(200) NOT NULL COMMENT '属性名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute_laguage` */

/*Table structure for table `hotel_attribute_value` */

DROP TABLE IF EXISTS `hotel_attribute_value`;

CREATE TABLE `hotel_attribute_value` (
  `hotel_attribute_id` int(11) NOT NULL,
  `hotel_attribute_father_id` int(11) DEFAULT NULL,
  `hotel_id` int(11) NOT NULL DEFAULT '0',
  `hotel_attribute_value` varchar(200) NOT NULL COMMENT '属性值',
  `hotel_attribute_value_ico` varchar(255) DEFAULT NULL COMMENT '图标',
  `hotel_attribute_value_url` varchar(255) DEFAULT NULL COMMENT 'url',
  PRIMARY KEY (`hotel_attribute_id`,`hotel_id`,`hotel_attribute_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute_value` */

/*Table structure for table `hotel_attribute_value_laguage` */

DROP TABLE IF EXISTS `hotel_attribute_value_laguage`;

CREATE TABLE `hotel_attribute_value_laguage` (
  `hotel_attribute_value_id` int(11) NOT NULL DEFAULT '0',
  `hotel_attribute_id` int(11) NOT NULL,
  `hotel_attribute_value` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_attribute_value_laguage` */

/*Table structure for table `hotel_images` */

DROP TABLE IF EXISTS `hotel_images`;

CREATE TABLE `hotel_images` (
  `hotel_images_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_images_name` varchar(100) DEFAULT NULL COMMENT '标题名称',
  `hotel_images_path` varchar(300) NOT NULL COMMENT '路径',
  `hotel_images_add_date` date NOT NULL COMMENT '添加时间',
  `hotel_images_add_time` time NOT NULL COMMENT '添加时间',
  `hotel_images_is_360` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是360°图',
  `hotel_images_is_main` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是主图',
  `hotel_images_recommend` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0' COMMENT '推荐图片，越高越排前',
  `hotel_images_filesize` bigint(19) NOT NULL DEFAULT '0' COMMENT '图片大小',
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
  `hotel_modules_ico` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `hotel_modules_show` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否显示在菜单中',
  PRIMARY KEY (`hotel_id`,`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_modules` */

insert  into `hotel_modules`(`hotel_id`,`modules_id`,`hotel_modules_father_id`,`hotel_modules_name`,`hotel_modules_navigation`,`hotel_modules_order`,`hotel_modules_ico`,`hotel_modules_show`) values (1,1,1,'','index',0,'','1'),(1,2,2,'','frontOffice',0,'','1'),(1,3,3,'','roomsManagement',0,'','1'),(1,4,4,'','restaurant',0,'','0'),(1,5,5,'','entertainment',0,'','0'),(1,6,6,'','security',0,'','0'),(1,7,7,'','sales',0,'','0'),(1,8,8,'','administration',0,'','0'),(1,9,9,'','financial',0,'','1'),(1,10,8,'','administration',0,'','0'),(1,11,8,'','administration',0,'','0'),(1,12,12,'','engineering',0,'','0'),(1,13,13,'','purchase',0,'','0'),(1,14,14,'','hotelSetting',0,'','1'),(1,15,14,'','hotelSetting',0,'','1'),(1,16,14,'','hotelSetting',0,'','1'),(1,17,14,'','hotelSetting',0,'','1'),(1,18,14,'','hotelSetting',0,'','1'),(1,19,3,'','roomsManagement',0,'','1'),(1,20,14,'','hotelSetting',0,'','1'),(1,21,3,'','hotelSetting',0,'','1'),(1,22,14,'','hotelSetting',0,'','1'),(1,23,14,'','hotelSetting',0,'','1'),(1,24,14,'','hotelSetting',0,'','0'),(1,25,14,'','hotelSetting',0,'','0'),(1,26,14,'','hotelSetting',0,'','0'),(1,27,14,'','hotelSetting',0,'','0'),(1,28,14,'','hotelSetting',0,'','0'),(1,29,14,'','hotelSetting',0,'','0'),(1,30,14,'','hotelSetting',0,'','1'),(1,31,14,'','hotelSetting',0,'','1'),(1,32,14,'','hotelSetting',0,'','0'),(1,33,3,'','roomsManagement',0,'','0'),(1,34,14,'','hotelSetting',0,'','0'),(1,35,14,'','hotelSetting',0,'','0'),(1,36,3,'基础房型','roomsManagement',0,'','1'),(1,37,3,'','roomsManagement',0,'','0'),(1,38,3,'','roomsManagement',0,'','0'),(1,39,3,'','roomsManagement',0,'','0'),(1,40,1,'','upload',0,'','0'),(1,41,3,'','roomsManagement',0,'','0'),(1,42,40,'','upload',0,'','0'),(1,43,3,'','roomsManagement',0,'','0'),(1,44,14,'','hotelSetting',0,'','0'),(1,45,14,'','hotelSetting',0,'','0'),(1,46,14,'','hotelSetting',0,'','0'),(1,47,14,'','hotelSetting',0,'','1'),(1,48,2,'','frontOffice',0,'','1'),(1,49,2,'','frontOffice',0,'','1'),(1,50,2,'','frontOffice',0,'','0'),(1,51,2,'','frontOffice',0,'','0'),(1,52,3,'','roomsManagement',0,'','0'),(1,53,3,'','roomsManagement',0,'','0'),(1,54,3,'','roomsManagement',0,'','0'),(1,55,3,'','roomsManagement',0,'','0'),(1,56,3,'','roomsManagement',0,'','1'),(1,57,3,'','roomsManagement',0,'','0'),(1,58,3,'','roomsManagement',0,'','0'),(1,59,3,'','roomsManagement',0,'','0'),(1,60,3,'','roomsManagement',0,'','1'),(1,61,3,'','roomsManagement',0,'','0'),(1,62,3,'','roomsManagement',0,'','0'),(1,63,3,'','roomsManagement',0,'','0'),(1,64,2,'','frontOffice',0,'','1'),(1,65,2,'','frontOffice',0,'','0'),(1,66,2,'','frontOffice',0,'','0'),(1,67,2,'','frontOffice',0,'','0'),(1,68,2,'','frontOffice',0,'','1'),(1,69,2,'','frontOffice',0,'','0'),(1,70,2,'','frontOffice',0,'','0'),(1,71,14,'','hotelSetting',0,'','0'),(1,72,14,'','hotelSetting',0,'','0'),(1,73,14,'','hotelSetting',0,'','0'),(1,74,14,'','hotelSetting',0,'','0'),(1,75,14,'','hotelSetting',0,'','0'),(1,76,14,'','hotelSetting',0,'','0'),(1,77,14,'','hotelSetting',0,'','0'),(1,78,14,'','hotelSetting',0,'','0'),(1,79,14,'','hotelSetting',0,'','0'),(1,80,14,'','hotelSetting',0,'','0'),(1,81,14,'','hotelSetting',0,'','0'),(1,82,14,'','hotelSetting',0,'','0'),(1,83,14,'','hotelSetting',0,'','0'),(1,84,14,'','hotelSetting',0,'','0'),(1,85,14,'','hotelSetting',0,'','0'),(1,86,14,'','hotelSetting',0,'','0'),(1,87,14,'','hotelSetting',0,'','0'),(1,88,14,'','hotelSetting',0,'','0'),(1,89,14,'','hotelSetting',0,'','0'),(1,90,3,'','roomsManagement',0,'','1'),(2,1,1,'','index',0,'','1'),(2,2,2,'','frontOffice',0,'','1'),(2,3,3,'','roomsManagement',0,'','1'),(2,4,4,'','restaurant',0,'','0'),(2,5,5,'','entertainment',0,'','0'),(2,6,6,'','security',0,'','0'),(2,7,7,'','sales',0,'','0'),(2,8,8,'','administration',0,'','0'),(2,9,9,'','financial',0,'','1'),(2,10,8,'','administration',0,'','0'),(2,11,8,'','administration',0,'','0'),(2,12,12,'','engineering',0,'','0'),(2,13,13,'','purchase',0,'','0'),(2,14,14,'','hotelSetting',0,'','1'),(2,15,14,'','hotelSetting',0,'','1'),(2,16,14,'','hotelSetting',0,'','1'),(2,17,14,'','hotelSetting',0,'','1'),(2,18,14,'','hotelSetting',0,'','1'),(2,19,3,'','roomsManagement',0,'','1'),(2,20,14,'','hotelSetting',0,'','1'),(2,21,3,'','hotelSetting',0,'','1'),(2,22,14,'','hotelSetting',0,'','1'),(2,23,14,'','hotelSetting',0,'','1'),(2,24,14,'','hotelSetting',0,'','0'),(2,25,14,'','hotelSetting',0,'','0'),(2,26,14,'','hotelSetting',0,'','0'),(2,27,14,'','hotelSetting',0,'','0'),(2,28,14,'','hotelSetting',0,'','0'),(2,29,14,'','hotelSetting',0,'','0'),(2,30,14,'','hotelSetting',0,'','1'),(2,31,14,'','hotelSetting',0,'','1'),(2,32,14,'','hotelSetting',0,'','0'),(2,33,3,'','roomsManagement',0,'','0'),(2,34,14,'','hotelSetting',0,'','0'),(2,35,14,'','hotelSetting',0,'','0'),(2,36,3,'基础房型','roomsManagement',0,'','1'),(2,37,3,'','roomsManagement',0,'','0'),(2,38,3,'','roomsManagement',0,'','0'),(2,39,3,'','roomsManagement',0,'','0'),(2,40,1,'','upload',0,'','0'),(2,41,3,'','roomsManagement',0,'','0'),(2,42,40,'','upload',0,'','0'),(2,43,3,'','roomsManagement',0,'','0'),(2,44,14,'','hotelSetting',0,'','0'),(2,45,14,'','hotelSetting',0,'','0'),(2,46,14,'','hotelSetting',0,'','0'),(2,47,14,'','hotelSetting',0,'','1'),(2,48,2,'','frontOffice',0,'','1'),(2,49,2,'','frontOffice',0,'','1'),(2,50,2,'','frontOffice',0,'','0'),(2,51,2,'','frontOffice',0,'','0'),(2,52,3,'','roomsManagement',0,'','0'),(2,53,3,'','roomsManagement',0,'','0'),(2,54,3,'','roomsManagement',0,'','0'),(2,55,3,'','roomsManagement',0,'','0'),(2,56,3,'','roomsManagement',0,'','1'),(2,57,3,'','roomsManagement',0,'','0'),(2,58,3,'','roomsManagement',0,'','0'),(2,59,3,'','roomsManagement',0,'','0'),(2,60,3,'','roomsManagement',0,'','1'),(2,61,3,'','roomsManagement',0,'','0'),(2,62,3,'','roomsManagement',0,'','0'),(2,63,3,'','roomsManagement',0,'','0'),(2,64,2,'','frontOffice',0,'','1'),(2,65,2,'','frontOffice',0,'','0'),(2,66,2,'','frontOffice',0,'','0'),(2,67,2,'','frontOffice',0,'','0'),(2,68,2,'','frontOffice',0,'','1'),(2,69,2,'','frontOffice',0,'','0'),(2,70,2,'','frontOffice',0,'','0'),(2,71,14,'','hotelSetting',0,'','0'),(2,72,14,'','hotelSetting',0,'','0'),(2,73,14,'','hotelSetting',0,'','0'),(2,74,14,'','hotelSetting',0,'','0'),(2,75,14,'','hotelSetting',0,'','0'),(2,76,14,'','hotelSetting',0,'','0'),(2,77,14,'','hotelSetting',0,'','0'),(2,78,14,'','hotelSetting',0,'','0'),(2,79,14,'','hotelSetting',0,'','0'),(2,80,14,'','hotelSetting',0,'','0'),(2,81,14,'','hotelSetting',0,'','0'),(2,82,14,'','hotelSetting',0,'','0'),(2,83,14,'','hotelSetting',0,'','0'),(2,84,14,'','hotelSetting',0,'','0'),(2,85,14,'','hotelSetting',0,'','0'),(2,86,14,'','hotelSetting',0,'','0'),(2,87,14,'','hotelSetting',0,'','0'),(2,88,14,'','hotelSetting',0,'','0'),(2,89,14,'','hotelSetting',0,'','0'),(2,90,3,'','roomsManagement',0,'','1');

/*Table structure for table `hotel_multi_laguage` */

DROP TABLE IF EXISTS `hotel_multi_laguage`;

CREATE TABLE `hotel_multi_laguage` (
  `hotel_id` int(11) NOT NULL DEFAULT '0',
  `multi_laguage` enum('English') NOT NULL,
  `hotel_name` varchar(200) DEFAULT NULL COMMENT '酒店名称',
  `hotel_address` varchar(200) DEFAULT NULL COMMENT '酒店地址',
  `hotel_introduce_short` varchar(1000) DEFAULT NULL COMMENT '酒店简短介绍',
  `hotel_introduce` text COMMENT '酒店介绍'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_multi_laguage` */

/*Table structure for table `hotel_service` */

DROP TABLE IF EXISTS `hotel_service`;

CREATE TABLE `hotel_service` (
  `hotel_service_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_service_father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父ID',
  `hotel_service_name` varchar(50) DEFAULT NULL,
  `hotel_service_price` double NOT NULL DEFAULT '-1' COMMENT '价格 -1 表示此类不含价格 0表示免费',
  `hotel_service_begin_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '开始时间',
  `hotel_service_end_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '失效时间',
  `hotel_service_ahead_datetime` smallint(6) NOT NULL DEFAULT '0' COMMENT '提前预定时间 0不需要预定',
  `hotel_service_add_time` time NOT NULL DEFAULT '00:00:00',
  `hotel_service_add_date` date NOT NULL DEFAULT '0000-00-00',
  `hotel_service_describe` varchar(200) DEFAULT NULL,
  `hotel_service_valid` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否有效',
  `employee_id` int(11) NOT NULL DEFAULT '0' COMMENT '添加员工',
  PRIMARY KEY (`hotel_service_id`),
  UNIQUE KEY `hotel_service` (`hotel_id`,`hotel_service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotel_service` */

insert  into `hotel_service`(`hotel_service_id`,`hotel_id`,`hotel_service_father_id`,`hotel_service_name`,`hotel_service_price`,`hotel_service_begin_datetime`,`hotel_service_end_datetime`,`hotel_service_ahead_datetime`,`hotel_service_add_time`,`hotel_service_add_date`,`hotel_service_describe`,`hotel_service_valid`,`employee_id`) values (-2,0,0,'押金',0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,'00:00:00','0000-00-00',NULL,'1',0),(-1,0,0,'服务费',0,'0000-00-00 00:00:00','0000-00-00 00:00:00',0,'00:00:00','0000-00-00',NULL,'1',0);

/*Table structure for table `hotel_service_setting` */

DROP TABLE IF EXISTS `hotel_service_setting`;

CREATE TABLE `hotel_service_setting` (
  `hotel_service_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `hotel_service_setting_name` varchar(50) NOT NULL,
  `hotel_service_setting_type` enum('book_order_retention_time','night_audit','half_price_date') DEFAULT NULL COMMENT 'NightAudit夜审',
  `hotel_service_setting_value` varchar(50) NOT NULL DEFAULT '',
  `hotel_service_setting_value_ext` varchar(50) NOT NULL DEFAULT '' COMMENT '第二个值',
  PRIMARY KEY (`hotel_service_setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `hotel_service_setting` */

insert  into `hotel_service_setting`(`hotel_service_setting_id`,`hotel_id`,`hotel_service_setting_name`,`hotel_service_setting_type`,`hotel_service_setting_value`,`hotel_service_setting_value_ext`) values (1,1,'夜审时间','night_audit','00:00',''),(2,1,'预定保留时间','book_order_retention_time','18:00','');

/*Table structure for table `hotels_attribute` */

DROP TABLE IF EXISTS `hotels_attribute`;

CREATE TABLE `hotels_attribute` (
  `hotel_layout_id` int(11) NOT NULL,
  `hotel_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`hotel_layout_id`,`hotel_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hotels_attribute` */

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `locations_id` int(11) NOT NULL,
  `locations_type` enum('province','city','town') DEFAULT NULL,
  `country` varchar(50) NOT NULL DEFAULT 'china',
  `province_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `location_name` varchar(50) NOT NULL,
  PRIMARY KEY (`locations_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `locations` */

insert  into `locations`(`locations_id`,`locations_type`,`country`,`province_id`,`city_id`,`location_name`) values (110000,'province','china',110000,0,'北京市'),(110100,'city','china',110000,110100,'市辖区'),(110101,'town','china',110000,110100,'东城区'),(110102,'town','china',110000,110100,'西城区'),(110105,'town','china',110000,110100,'朝阳区'),(110106,'town','china',110000,110100,'丰台区'),(110107,'town','china',110000,110100,'石景山区'),(110108,'town','china',110000,110100,'海淀区'),(110109,'town','china',110000,110100,'门头沟区'),(110111,'town','china',110000,110100,'房山区'),(110112,'town','china',110000,110100,'通州区'),(110113,'town','china',110000,110100,'顺义区'),(110114,'town','china',110000,110100,'昌平区'),(110115,'town','china',110000,110100,'大兴区'),(110116,'town','china',110000,110100,'怀柔区'),(110117,'town','china',110000,110100,'平谷区'),(110200,'city','china',110000,110200,'县'),(110228,'town','china',110000,110200,'密云县'),(110229,'town','china',110000,110200,'延庆县'),(120000,'province','china',120000,0,'天津市'),(120100,'city','china',120000,120100,'市辖区'),(120101,'town','china',120000,120100,'和平区'),(120102,'town','china',120000,120100,'河东区'),(120103,'town','china',120000,120100,'河西区'),(120104,'town','china',120000,120100,'南开区'),(120105,'town','china',120000,120100,'河北区'),(120106,'town','china',120000,120100,'红桥区'),(120110,'town','china',120000,120100,'东丽区'),(120111,'town','china',120000,120100,'西青区'),(120112,'town','china',120000,120100,'津南区'),(120113,'town','china',120000,120100,'北辰区'),(120114,'town','china',120000,120100,'武清区'),(120115,'town','china',120000,120100,'宝坻区'),(120116,'town','china',120000,120100,'滨海新区'),(120117,'town','china',120000,120100,'宁河区'),(120118,'town','china',120000,120100,'静海区'),(120200,'city','china',120000,120200,'县'),(120225,'town','china',120000,120200,'蓟县'),(130000,'province','china',130000,0,'河北省'),(130100,'city','china',130000,130100,'石家庄市'),(130101,'town','china',130000,130100,'市辖区'),(130102,'town','china',130000,130100,'长安区'),(130104,'town','china',130000,130100,'桥西区'),(130105,'town','china',130000,130100,'新华区'),(130107,'town','china',130000,130100,'井陉矿区'),(130108,'town','china',130000,130100,'裕华区'),(130109,'town','china',130000,130100,'藁城区'),(130110,'town','china',130000,130100,'鹿泉区'),(130111,'town','china',130000,130100,'栾城区'),(130121,'town','china',130000,130100,'井陉县'),(130123,'town','china',130000,130100,'正定县'),(130125,'town','china',130000,130100,'行唐县'),(130126,'town','china',130000,130100,'灵寿县'),(130127,'town','china',130000,130100,'高邑县'),(130128,'town','china',130000,130100,'深泽县'),(130129,'town','china',130000,130100,'赞皇县'),(130130,'town','china',130000,130100,'无极县'),(130131,'town','china',130000,130100,'平山县'),(130132,'town','china',130000,130100,'元氏县'),(130133,'town','china',130000,130100,'赵县'),(130183,'town','china',130000,130100,'晋州市'),(130184,'town','china',130000,130100,'新乐市'),(130200,'city','china',130000,130200,'唐山市'),(130201,'town','china',130000,130200,'市辖区'),(130202,'town','china',130000,130200,'路南区'),(130203,'town','china',130000,130200,'路北区'),(130204,'town','china',130000,130200,'古冶区'),(130205,'town','china',130000,130200,'开平区'),(130207,'town','china',130000,130200,'丰南区'),(130208,'town','china',130000,130200,'丰润区'),(130209,'town','china',130000,130200,'曹妃甸区'),(130223,'town','china',130000,130200,'滦县'),(130224,'town','china',130000,130200,'滦南县'),(130225,'town','china',130000,130200,'乐亭县'),(130227,'town','china',130000,130200,'迁西县'),(130229,'town','china',130000,130200,'玉田县'),(130281,'town','china',130000,130200,'遵化市'),(130283,'town','china',130000,130200,'迁安市'),(130300,'city','china',130000,130300,'秦皇岛市'),(130301,'town','china',130000,130300,'市辖区'),(130302,'town','china',130000,130300,'海港区'),(130303,'town','china',130000,130300,'山海关区'),(130304,'town','china',130000,130300,'北戴河区'),(130306,'town','china',130000,130300,'抚宁区'),(130321,'town','china',130000,130300,'青龙满族自治县'),(130322,'town','china',130000,130300,'昌黎县'),(130324,'town','china',130000,130300,'卢龙县'),(130400,'city','china',130000,130400,'邯郸市'),(130401,'town','china',130000,130400,'市辖区'),(130402,'town','china',130000,130400,'邯山区'),(130403,'town','china',130000,130400,'丛台区'),(130404,'town','china',130000,130400,'复兴区'),(130406,'town','china',130000,130400,'峰峰矿区'),(130421,'town','china',130000,130400,'邯郸县'),(130423,'town','china',130000,130400,'临漳县'),(130424,'town','china',130000,130400,'成安县'),(130425,'town','china',130000,130400,'大名县'),(130426,'town','china',130000,130400,'涉县'),(130427,'town','china',130000,130400,'磁县'),(130428,'town','china',130000,130400,'肥乡县'),(130429,'town','china',130000,130400,'永年县'),(130430,'town','china',130000,130400,'邱县'),(130431,'town','china',130000,130400,'鸡泽县'),(130432,'town','china',130000,130400,'广平县'),(130433,'town','china',130000,130400,'馆陶县'),(130434,'town','china',130000,130400,'魏县'),(130435,'town','china',130000,130400,'曲周县'),(130481,'town','china',130000,130400,'武安市'),(130500,'city','china',130000,130500,'邢台市'),(130501,'town','china',130000,130500,'市辖区'),(130502,'town','china',130000,130500,'桥东区'),(130503,'town','china',130000,130500,'桥西区'),(130521,'town','china',130000,130500,'邢台县'),(130522,'town','china',130000,130500,'临城县'),(130523,'town','china',130000,130500,'内丘县'),(130524,'town','china',130000,130500,'柏乡县'),(130525,'town','china',130000,130500,'隆尧县'),(130526,'town','china',130000,130500,'任县'),(130527,'town','china',130000,130500,'南和县'),(130528,'town','china',130000,130500,'宁晋县'),(130529,'town','china',130000,130500,'巨鹿县'),(130530,'town','china',130000,130500,'新河县'),(130531,'town','china',130000,130500,'广宗县'),(130532,'town','china',130000,130500,'平乡县'),(130533,'town','china',130000,130500,'威县'),(130534,'town','china',130000,130500,'清河县'),(130535,'town','china',130000,130500,'临西县'),(130581,'town','china',130000,130500,'南宫市'),(130582,'town','china',130000,130500,'沙河市'),(130600,'city','china',130000,130600,'保定市'),(130601,'town','china',130000,130600,'市辖区'),(130602,'town','china',130000,130600,'竞秀区'),(130606,'town','china',130000,130600,'莲池区'),(130607,'town','china',130000,130600,'满城区'),(130608,'town','china',130000,130600,'清苑区'),(130609,'town','china',130000,130600,'徐水区'),(130623,'town','china',130000,130600,'涞水县'),(130624,'town','china',130000,130600,'阜平县'),(130626,'town','china',130000,130600,'定兴县'),(130627,'town','china',130000,130600,'唐县'),(130628,'town','china',130000,130600,'高阳县'),(130629,'town','china',130000,130600,'容城县'),(130630,'town','china',130000,130600,'涞源县'),(130631,'town','china',130000,130600,'望都县'),(130632,'town','china',130000,130600,'安新县'),(130633,'town','china',130000,130600,'易县'),(130634,'town','china',130000,130600,'曲阳县'),(130635,'town','china',130000,130600,'蠡县'),(130636,'town','china',130000,130600,'顺平县'),(130637,'town','china',130000,130600,'博野县'),(130638,'town','china',130000,130600,'雄县'),(130681,'town','china',130000,130600,'涿州市'),(130683,'town','china',130000,130600,'安国市'),(130684,'town','china',130000,130600,'高碑店市'),(130700,'city','china',130000,130700,'张家口市'),(130701,'town','china',130000,130700,'市辖区'),(130702,'town','china',130000,130700,'桥东区'),(130703,'town','china',130000,130700,'桥西区'),(130705,'town','china',130000,130700,'宣化区'),(130706,'town','china',130000,130700,'下花园区'),(130721,'town','china',130000,130700,'宣化县'),(130722,'town','china',130000,130700,'张北县'),(130723,'town','china',130000,130700,'康保县'),(130724,'town','china',130000,130700,'沽源县'),(130725,'town','china',130000,130700,'尚义县'),(130726,'town','china',130000,130700,'蔚县'),(130727,'town','china',130000,130700,'阳原县'),(130728,'town','china',130000,130700,'怀安县'),(130729,'town','china',130000,130700,'万全县'),(130730,'town','china',130000,130700,'怀来县'),(130731,'town','china',130000,130700,'涿鹿县'),(130732,'town','china',130000,130700,'赤城县'),(130733,'town','china',130000,130700,'崇礼县'),(130800,'city','china',130000,130800,'承德市'),(130801,'town','china',130000,130800,'市辖区'),(130802,'town','china',130000,130800,'双桥区'),(130803,'town','china',130000,130800,'双滦区'),(130804,'town','china',130000,130800,'鹰手营子矿区'),(130821,'town','china',130000,130800,'承德县'),(130822,'town','china',130000,130800,'兴隆县'),(130823,'town','china',130000,130800,'平泉县'),(130824,'town','china',130000,130800,'滦平县'),(130825,'town','china',130000,130800,'隆化县'),(130826,'town','china',130000,130800,'丰宁满族自治县'),(130827,'town','china',130000,130800,'宽城满族自治县'),(130828,'town','china',130000,130800,'围场满族蒙古族自治县'),(130900,'city','china',130000,130900,'沧州市'),(130901,'town','china',130000,130900,'市辖区'),(130902,'town','china',130000,130900,'新华区'),(130903,'town','china',130000,130900,'运河区'),(130921,'town','china',130000,130900,'沧县'),(130922,'town','china',130000,130900,'青县'),(130923,'town','china',130000,130900,'东光县'),(130924,'town','china',130000,130900,'海兴县'),(130925,'town','china',130000,130900,'盐山县'),(130926,'town','china',130000,130900,'肃宁县'),(130927,'town','china',130000,130900,'南皮县'),(130928,'town','china',130000,130900,'吴桥县'),(130929,'town','china',130000,130900,'献县'),(130930,'town','china',130000,130900,'孟村回族自治县'),(130981,'town','china',130000,130900,'泊头市'),(130982,'town','china',130000,130900,'任丘市'),(130983,'town','china',130000,130900,'黄骅市'),(130984,'town','china',130000,130900,'河间市'),(131000,'city','china',130000,131000,'廊坊市'),(131001,'town','china',130000,131000,'市辖区'),(131002,'town','china',130000,131000,'安次区'),(131003,'town','china',130000,131000,'广阳区'),(131022,'town','china',130000,131000,'固安县'),(131023,'town','china',130000,131000,'永清县'),(131024,'town','china',130000,131000,'香河县'),(131025,'town','china',130000,131000,'大城县'),(131026,'town','china',130000,131000,'文安县'),(131028,'town','china',130000,131000,'大厂回族自治县'),(131081,'town','china',130000,131000,'霸州市'),(131082,'town','china',130000,131000,'三河市'),(131100,'city','china',130000,131100,'衡水市'),(131101,'town','china',130000,131100,'市辖区'),(131102,'town','china',130000,131100,'桃城区'),(131121,'town','china',130000,131100,'枣强县'),(131122,'town','china',130000,131100,'武邑县'),(131123,'town','china',130000,131100,'武强县'),(131124,'town','china',130000,131100,'饶阳县'),(131125,'town','china',130000,131100,'安平县'),(131126,'town','china',130000,131100,'故城县'),(131127,'town','china',130000,131100,'景县'),(131128,'town','china',130000,131100,'阜城县'),(131181,'town','china',130000,131100,'冀州市'),(131182,'town','china',130000,131100,'深州市'),(139000,'city','china',130000,139000,'省直辖县级行政区划'),(139001,'town','china',130000,139000,'定州市'),(139002,'town','china',130000,139000,'辛集市'),(140000,'province','china',140000,0,'山西省'),(140100,'city','china',140000,140100,'太原市'),(140101,'town','china',140000,140100,'市辖区'),(140105,'town','china',140000,140100,'小店区'),(140106,'town','china',140000,140100,'迎泽区'),(140107,'town','china',140000,140100,'杏花岭区'),(140108,'town','china',140000,140100,'尖草坪区'),(140109,'town','china',140000,140100,'万柏林区'),(140110,'town','china',140000,140100,'晋源区'),(140121,'town','china',140000,140100,'清徐县'),(140122,'town','china',140000,140100,'阳曲县'),(140123,'town','china',140000,140100,'娄烦县'),(140181,'town','china',140000,140100,'古交市'),(140200,'city','china',140000,140200,'大同市'),(140201,'town','china',140000,140200,'市辖区'),(140202,'town','china',140000,140200,'城区'),(140203,'town','china',140000,140200,'矿区'),(140211,'town','china',140000,140200,'南郊区'),(140212,'town','china',140000,140200,'新荣区'),(140221,'town','china',140000,140200,'阳高县'),(140222,'town','china',140000,140200,'天镇县'),(140223,'town','china',140000,140200,'广灵县'),(140224,'town','china',140000,140200,'灵丘县'),(140225,'town','china',140000,140200,'浑源县'),(140226,'town','china',140000,140200,'左云县'),(140227,'town','china',140000,140200,'大同县'),(140300,'city','china',140000,140300,'阳泉市'),(140301,'town','china',140000,140300,'市辖区'),(140302,'town','china',140000,140300,'城区'),(140303,'town','china',140000,140300,'矿区'),(140311,'town','china',140000,140300,'郊区'),(140321,'town','china',140000,140300,'平定县'),(140322,'town','china',140000,140300,'盂县'),(140400,'city','china',140000,140400,'长治市'),(140401,'town','china',140000,140400,'市辖区'),(140402,'town','china',140000,140400,'城区'),(140411,'town','china',140000,140400,'郊区'),(140421,'town','china',140000,140400,'长治县'),(140423,'town','china',140000,140400,'襄垣县'),(140424,'town','china',140000,140400,'屯留县'),(140425,'town','china',140000,140400,'平顺县'),(140426,'town','china',140000,140400,'黎城县'),(140427,'town','china',140000,140400,'壶关县'),(140428,'town','china',140000,140400,'长子县'),(140429,'town','china',140000,140400,'武乡县'),(140430,'town','china',140000,140400,'沁县'),(140431,'town','china',140000,140400,'沁源县'),(140481,'town','china',140000,140400,'潞城市'),(140500,'city','china',140000,140500,'晋城市'),(140501,'town','china',140000,140500,'市辖区'),(140502,'town','china',140000,140500,'城区'),(140521,'town','china',140000,140500,'沁水县'),(140522,'town','china',140000,140500,'阳城县'),(140524,'town','china',140000,140500,'陵川县'),(140525,'town','china',140000,140500,'泽州县'),(140581,'town','china',140000,140500,'高平市'),(140600,'city','china',140000,140600,'朔州市'),(140601,'town','china',140000,140600,'市辖区'),(140602,'town','china',140000,140600,'朔城区'),(140603,'town','china',140000,140600,'平鲁区'),(140621,'town','china',140000,140600,'山阴县'),(140622,'town','china',140000,140600,'应县'),(140623,'town','china',140000,140600,'右玉县'),(140624,'town','china',140000,140600,'怀仁县'),(140700,'city','china',140000,140700,'晋中市'),(140701,'town','china',140000,140700,'市辖区'),(140702,'town','china',140000,140700,'榆次区'),(140721,'town','china',140000,140700,'榆社县'),(140722,'town','china',140000,140700,'左权县'),(140723,'town','china',140000,140700,'和顺县'),(140724,'town','china',140000,140700,'昔阳县'),(140725,'town','china',140000,140700,'寿阳县'),(140726,'town','china',140000,140700,'太谷县'),(140727,'town','china',140000,140700,'祁县'),(140728,'town','china',140000,140700,'平遥县'),(140729,'town','china',140000,140700,'灵石县'),(140781,'town','china',140000,140700,'介休市'),(140800,'city','china',140000,140800,'运城市'),(140801,'town','china',140000,140800,'市辖区'),(140802,'town','china',140000,140800,'盐湖区'),(140821,'town','china',140000,140800,'临猗县'),(140822,'town','china',140000,140800,'万荣县'),(140823,'town','china',140000,140800,'闻喜县'),(140824,'town','china',140000,140800,'稷山县'),(140825,'town','china',140000,140800,'新绛县'),(140826,'town','china',140000,140800,'绛县'),(140827,'town','china',140000,140800,'垣曲县'),(140828,'town','china',140000,140800,'夏县'),(140829,'town','china',140000,140800,'平陆县'),(140830,'town','china',140000,140800,'芮城县'),(140881,'town','china',140000,140800,'永济市'),(140882,'town','china',140000,140800,'河津市'),(140900,'city','china',140000,140900,'忻州市'),(140901,'town','china',140000,140900,'市辖区'),(140902,'town','china',140000,140900,'忻府区'),(140921,'town','china',140000,140900,'定襄县'),(140922,'town','china',140000,140900,'五台县'),(140923,'town','china',140000,140900,'代县'),(140924,'town','china',140000,140900,'繁峙县'),(140925,'town','china',140000,140900,'宁武县'),(140926,'town','china',140000,140900,'静乐县'),(140927,'town','china',140000,140900,'神池县'),(140928,'town','china',140000,140900,'五寨县'),(140929,'town','china',140000,140900,'岢岚县'),(140930,'town','china',140000,140900,'河曲县'),(140931,'town','china',140000,140900,'保德县'),(140932,'town','china',140000,140900,'偏关县'),(140981,'town','china',140000,140900,'原平市'),(141000,'city','china',140000,141000,'临汾市'),(141001,'town','china',140000,141000,'市辖区'),(141002,'town','china',140000,141000,'尧都区'),(141021,'town','china',140000,141000,'曲沃县'),(141022,'town','china',140000,141000,'翼城县'),(141023,'town','china',140000,141000,'襄汾县'),(141024,'town','china',140000,141000,'洪洞县'),(141025,'town','china',140000,141000,'古县'),(141026,'town','china',140000,141000,'安泽县'),(141027,'town','china',140000,141000,'浮山县'),(141028,'town','china',140000,141000,'吉县'),(141029,'town','china',140000,141000,'乡宁县'),(141030,'town','china',140000,141000,'大宁县'),(141031,'town','china',140000,141000,'隰县'),(141032,'town','china',140000,141000,'永和县'),(141033,'town','china',140000,141000,'蒲县'),(141034,'town','china',140000,141000,'汾西县'),(141081,'town','china',140000,141000,'侯马市'),(141082,'town','china',140000,141000,'霍州市'),(141100,'city','china',140000,141100,'吕梁市'),(141101,'town','china',140000,141100,'市辖区'),(141102,'town','china',140000,141100,'离石区'),(141121,'town','china',140000,141100,'文水县'),(141122,'town','china',140000,141100,'交城县'),(141123,'town','china',140000,141100,'兴县'),(141124,'town','china',140000,141100,'临县'),(141125,'town','china',140000,141100,'柳林县'),(141126,'town','china',140000,141100,'石楼县'),(141127,'town','china',140000,141100,'岚县'),(141128,'town','china',140000,141100,'方山县'),(141129,'town','china',140000,141100,'中阳县'),(141130,'town','china',140000,141100,'交口县'),(141181,'town','china',140000,141100,'孝义市'),(141182,'town','china',140000,141100,'汾阳市'),(150000,'province','china',150000,0,'内蒙古自治区'),(150100,'city','china',150000,150100,'呼和浩特市'),(150101,'town','china',150000,150100,'市辖区'),(150102,'town','china',150000,150100,'新城区'),(150103,'town','china',150000,150100,'回民区'),(150104,'town','china',150000,150100,'玉泉区'),(150105,'town','china',150000,150100,'赛罕区'),(150121,'town','china',150000,150100,'土默特左旗'),(150122,'town','china',150000,150100,'托克托县'),(150123,'town','china',150000,150100,'和林格尔县'),(150124,'town','china',150000,150100,'清水河县'),(150125,'town','china',150000,150100,'武川县'),(150200,'city','china',150000,150200,'包头市'),(150201,'town','china',150000,150200,'市辖区'),(150202,'town','china',150000,150200,'东河区'),(150203,'town','china',150000,150200,'昆都仑区'),(150204,'town','china',150000,150200,'青山区'),(150205,'town','china',150000,150200,'石拐区'),(150206,'town','china',150000,150200,'白云鄂博矿区'),(150207,'town','china',150000,150200,'九原区'),(150221,'town','china',150000,150200,'土默特右旗'),(150222,'town','china',150000,150200,'固阳县'),(150223,'town','china',150000,150200,'达尔罕茂明安联合旗'),(150300,'city','china',150000,150300,'乌海市'),(150301,'town','china',150000,150300,'市辖区'),(150302,'town','china',150000,150300,'海勃湾区'),(150303,'town','china',150000,150300,'海南区'),(150304,'town','china',150000,150300,'乌达区'),(150400,'city','china',150000,150400,'赤峰市'),(150401,'town','china',150000,150400,'市辖区'),(150402,'town','china',150000,150400,'红山区'),(150403,'town','china',150000,150400,'元宝山区'),(150404,'town','china',150000,150400,'松山区'),(150421,'town','china',150000,150400,'阿鲁科尔沁旗'),(150422,'town','china',150000,150400,'巴林左旗'),(150423,'town','china',150000,150400,'巴林右旗'),(150424,'town','china',150000,150400,'林西县'),(150425,'town','china',150000,150400,'克什克腾旗'),(150426,'town','china',150000,150400,'翁牛特旗'),(150428,'town','china',150000,150400,'喀喇沁旗'),(150429,'town','china',150000,150400,'宁城县'),(150430,'town','china',150000,150400,'敖汉旗'),(150500,'city','china',150000,150500,'通辽市'),(150501,'town','china',150000,150500,'市辖区'),(150502,'town','china',150000,150500,'科尔沁区'),(150521,'town','china',150000,150500,'科尔沁左翼中旗'),(150522,'town','china',150000,150500,'科尔沁左翼后旗'),(150523,'town','china',150000,150500,'开鲁县'),(150524,'town','china',150000,150500,'库伦旗'),(150525,'town','china',150000,150500,'奈曼旗'),(150526,'town','china',150000,150500,'扎鲁特旗'),(150581,'town','china',150000,150500,'霍林郭勒市'),(150600,'city','china',150000,150600,'鄂尔多斯市'),(150601,'town','china',150000,150600,'市辖区'),(150602,'town','china',150000,150600,'东胜区'),(150621,'town','china',150000,150600,'达拉特旗'),(150622,'town','china',150000,150600,'准格尔旗'),(150623,'town','china',150000,150600,'鄂托克前旗'),(150624,'town','china',150000,150600,'鄂托克旗'),(150625,'town','china',150000,150600,'杭锦旗'),(150626,'town','china',150000,150600,'乌审旗'),(150627,'town','china',150000,150600,'伊金霍洛旗'),(150700,'city','china',150000,150700,'呼伦贝尔市'),(150701,'town','china',150000,150700,'市辖区'),(150702,'town','china',150000,150700,'海拉尔区'),(150703,'town','china',150000,150700,'扎赉诺尔区'),(150721,'town','china',150000,150700,'阿荣旗'),(150722,'town','china',150000,150700,'莫力达瓦达斡尔族自治旗'),(150723,'town','china',150000,150700,'鄂伦春自治旗'),(150724,'town','china',150000,150700,'鄂温克族自治旗'),(150725,'town','china',150000,150700,'陈巴尔虎旗'),(150726,'town','china',150000,150700,'新巴尔虎左旗'),(150727,'town','china',150000,150700,'新巴尔虎右旗'),(150781,'town','china',150000,150700,'满洲里市'),(150782,'town','china',150000,150700,'牙克石市'),(150783,'town','china',150000,150700,'扎兰屯市'),(150784,'town','china',150000,150700,'额尔古纳市'),(150785,'town','china',150000,150700,'根河市'),(150800,'city','china',150000,150800,'巴彦淖尔市'),(150801,'town','china',150000,150800,'市辖区'),(150802,'town','china',150000,150800,'临河区'),(150821,'town','china',150000,150800,'五原县'),(150822,'town','china',150000,150800,'磴口县'),(150823,'town','china',150000,150800,'乌拉特前旗'),(150824,'town','china',150000,150800,'乌拉特中旗'),(150825,'town','china',150000,150800,'乌拉特后旗'),(150826,'town','china',150000,150800,'杭锦后旗'),(150900,'city','china',150000,150900,'乌兰察布市'),(150901,'town','china',150000,150900,'市辖区'),(150902,'town','china',150000,150900,'集宁区'),(150921,'town','china',150000,150900,'卓资县'),(150922,'town','china',150000,150900,'化德县'),(150923,'town','china',150000,150900,'商都县'),(150924,'town','china',150000,150900,'兴和县'),(150925,'town','china',150000,150900,'凉城县'),(150926,'town','china',150000,150900,'察哈尔右翼前旗'),(150927,'town','china',150000,150900,'察哈尔右翼中旗'),(150928,'town','china',150000,150900,'察哈尔右翼后旗'),(150929,'town','china',150000,150900,'四子王旗'),(150981,'town','china',150000,150900,'丰镇市'),(152200,'city','china',150000,152200,'兴安盟'),(152201,'town','china',150000,152200,'乌兰浩特市'),(152202,'town','china',150000,152200,'阿尔山市'),(152221,'town','china',150000,152200,'科尔沁右翼前旗'),(152222,'town','china',150000,152200,'科尔沁右翼中旗'),(152223,'town','china',150000,152200,'扎赉特旗'),(152224,'town','china',150000,152200,'突泉县'),(152500,'city','china',150000,152500,'锡林郭勒盟'),(152501,'town','china',150000,152500,'二连浩特市'),(152502,'town','china',150000,152500,'锡林浩特市'),(152522,'town','china',150000,152500,'阿巴嘎旗'),(152523,'town','china',150000,152500,'苏尼特左旗'),(152524,'town','china',150000,152500,'苏尼特右旗'),(152525,'town','china',150000,152500,'东乌珠穆沁旗'),(152526,'town','china',150000,152500,'西乌珠穆沁旗'),(152527,'town','china',150000,152500,'太仆寺旗'),(152528,'town','china',150000,152500,'镶黄旗'),(152529,'town','china',150000,152500,'正镶白旗'),(152530,'town','china',150000,152500,'正蓝旗'),(152531,'town','china',150000,152500,'多伦县'),(152900,'city','china',150000,152900,'阿拉善盟'),(152921,'town','china',150000,152900,'阿拉善左旗'),(152922,'town','china',150000,152900,'阿拉善右旗'),(152923,'town','china',150000,152900,'额济纳旗'),(210000,'province','china',210000,0,'辽宁省'),(210100,'city','china',210000,210100,'沈阳市'),(210101,'town','china',210000,210100,'市辖区'),(210102,'town','china',210000,210100,'和平区'),(210103,'town','china',210000,210100,'沈河区'),(210104,'town','china',210000,210100,'大东区'),(210105,'town','china',210000,210100,'皇姑区'),(210106,'town','china',210000,210100,'铁西区'),(210111,'town','china',210000,210100,'苏家屯区'),(210112,'town','china',210000,210100,'浑南区'),(210113,'town','china',210000,210100,'沈北新区'),(210114,'town','china',210000,210100,'于洪区'),(210122,'town','china',210000,210100,'辽中县'),(210123,'town','china',210000,210100,'康平县'),(210124,'town','china',210000,210100,'法库县'),(210181,'town','china',210000,210100,'新民市'),(210200,'city','china',210000,210200,'大连市'),(210201,'town','china',210000,210200,'市辖区'),(210202,'town','china',210000,210200,'中山区'),(210203,'town','china',210000,210200,'西岗区'),(210204,'town','china',210000,210200,'沙河口区'),(210211,'town','china',210000,210200,'甘井子区'),(210212,'town','china',210000,210200,'旅顺口区'),(210213,'town','china',210000,210200,'金州区'),(210224,'town','china',210000,210200,'长海县'),(210281,'town','china',210000,210200,'瓦房店市'),(210282,'town','china',210000,210200,'普兰店市'),(210283,'town','china',210000,210200,'庄河市'),(210300,'city','china',210000,210300,'鞍山市'),(210301,'town','china',210000,210300,'市辖区'),(210302,'town','china',210000,210300,'铁东区'),(210303,'town','china',210000,210300,'铁西区'),(210304,'town','china',210000,210300,'立山区'),(210311,'town','china',210000,210300,'千山区'),(210321,'town','china',210000,210300,'台安县'),(210323,'town','china',210000,210300,'岫岩满族自治县'),(210381,'town','china',210000,210300,'海城市'),(210400,'city','china',210000,210400,'抚顺市'),(210401,'town','china',210000,210400,'市辖区'),(210402,'town','china',210000,210400,'新抚区'),(210403,'town','china',210000,210400,'东洲区'),(210404,'town','china',210000,210400,'望花区'),(210411,'town','china',210000,210400,'顺城区'),(210421,'town','china',210000,210400,'抚顺县'),(210422,'town','china',210000,210400,'新宾满族自治县'),(210423,'town','china',210000,210400,'清原满族自治县'),(210500,'city','china',210000,210500,'本溪市'),(210501,'town','china',210000,210500,'市辖区'),(210502,'town','china',210000,210500,'平山区'),(210503,'town','china',210000,210500,'溪湖区'),(210504,'town','china',210000,210500,'明山区'),(210505,'town','china',210000,210500,'南芬区'),(210521,'town','china',210000,210500,'本溪满族自治县'),(210522,'town','china',210000,210500,'桓仁满族自治县'),(210600,'city','china',210000,210600,'丹东市'),(210601,'town','china',210000,210600,'市辖区'),(210602,'town','china',210000,210600,'元宝区'),(210603,'town','china',210000,210600,'振兴区'),(210604,'town','china',210000,210600,'振安区'),(210624,'town','china',210000,210600,'宽甸满族自治县'),(210681,'town','china',210000,210600,'东港市'),(210682,'town','china',210000,210600,'凤城市'),(210700,'city','china',210000,210700,'锦州市'),(210701,'town','china',210000,210700,'市辖区'),(210702,'town','china',210000,210700,'古塔区'),(210703,'town','china',210000,210700,'凌河区'),(210711,'town','china',210000,210700,'太和区'),(210726,'town','china',210000,210700,'黑山县'),(210727,'town','china',210000,210700,'义县'),(210781,'town','china',210000,210700,'凌海市'),(210782,'town','china',210000,210700,'北镇市'),(210800,'city','china',210000,210800,'营口市'),(210801,'town','china',210000,210800,'市辖区'),(210802,'town','china',210000,210800,'站前区'),(210803,'town','china',210000,210800,'西市区'),(210804,'town','china',210000,210800,'鲅鱼圈区'),(210811,'town','china',210000,210800,'老边区'),(210881,'town','china',210000,210800,'盖州市'),(210882,'town','china',210000,210800,'大石桥市'),(210900,'city','china',210000,210900,'阜新市'),(210901,'town','china',210000,210900,'市辖区'),(210902,'town','china',210000,210900,'海州区'),(210903,'town','china',210000,210900,'新邱区'),(210904,'town','china',210000,210900,'太平区'),(210905,'town','china',210000,210900,'清河门区'),(210911,'town','china',210000,210900,'细河区'),(210921,'town','china',210000,210900,'阜新蒙古族自治县'),(210922,'town','china',210000,210900,'彰武县'),(211000,'city','china',210000,211000,'辽阳市'),(211001,'town','china',210000,211000,'市辖区'),(211002,'town','china',210000,211000,'白塔区'),(211003,'town','china',210000,211000,'文圣区'),(211004,'town','china',210000,211000,'宏伟区'),(211005,'town','china',210000,211000,'弓长岭区'),(211011,'town','china',210000,211000,'太子河区'),(211021,'town','china',210000,211000,'辽阳县'),(211081,'town','china',210000,211000,'灯塔市'),(211100,'city','china',210000,211100,'盘锦市'),(211101,'town','china',210000,211100,'市辖区'),(211102,'town','china',210000,211100,'双台子区'),(211103,'town','china',210000,211100,'兴隆台区'),(211121,'town','china',210000,211100,'大洼县'),(211122,'town','china',210000,211100,'盘山县'),(211200,'city','china',210000,211200,'铁岭市'),(211201,'town','china',210000,211200,'市辖区'),(211202,'town','china',210000,211200,'银州区'),(211204,'town','china',210000,211200,'清河区'),(211221,'town','china',210000,211200,'铁岭县'),(211223,'town','china',210000,211200,'西丰县'),(211224,'town','china',210000,211200,'昌图县'),(211281,'town','china',210000,211200,'调兵山市'),(211282,'town','china',210000,211200,'开原市'),(211300,'city','china',210000,211300,'朝阳市'),(211301,'town','china',210000,211300,'市辖区'),(211302,'town','china',210000,211300,'双塔区'),(211303,'town','china',210000,211300,'龙城区'),(211321,'town','china',210000,211300,'朝阳县'),(211322,'town','china',210000,211300,'建平县'),(211324,'town','china',210000,211300,'喀喇沁左翼蒙古族自治县'),(211381,'town','china',210000,211300,'北票市'),(211382,'town','china',210000,211300,'凌源市'),(211400,'city','china',210000,211400,'葫芦岛市'),(211401,'town','china',210000,211400,'市辖区'),(211402,'town','china',210000,211400,'连山区'),(211403,'town','china',210000,211400,'龙港区'),(211404,'town','china',210000,211400,'南票区'),(211421,'town','china',210000,211400,'绥中县'),(211422,'town','china',210000,211400,'建昌县'),(211481,'town','china',210000,211400,'兴城市'),(220000,'province','china',220000,0,'吉林省'),(220100,'city','china',220000,220100,'长春市'),(220101,'town','china',220000,220100,'市辖区'),(220102,'town','china',220000,220100,'南关区'),(220103,'town','china',220000,220100,'宽城区'),(220104,'town','china',220000,220100,'朝阳区'),(220105,'town','china',220000,220100,'二道区'),(220106,'town','china',220000,220100,'绿园区'),(220112,'town','china',220000,220100,'双阳区'),(220113,'town','china',220000,220100,'九台区'),(220122,'town','china',220000,220100,'农安县'),(220182,'town','china',220000,220100,'榆树市'),(220183,'town','china',220000,220100,'德惠市'),(220200,'city','china',220000,220200,'吉林市'),(220201,'town','china',220000,220200,'市辖区'),(220202,'town','china',220000,220200,'昌邑区'),(220203,'town','china',220000,220200,'龙潭区'),(220204,'town','china',220000,220200,'船营区'),(220211,'town','china',220000,220200,'丰满区'),(220221,'town','china',220000,220200,'永吉县'),(220281,'town','china',220000,220200,'蛟河市'),(220282,'town','china',220000,220200,'桦甸市'),(220283,'town','china',220000,220200,'舒兰市'),(220284,'town','china',220000,220200,'磐石市'),(220300,'city','china',220000,220300,'四平市'),(220301,'town','china',220000,220300,'市辖区'),(220302,'town','china',220000,220300,'铁西区'),(220303,'town','china',220000,220300,'铁东区'),(220322,'town','china',220000,220300,'梨树县'),(220323,'town','china',220000,220300,'伊通满族自治县'),(220381,'town','china',220000,220300,'公主岭市'),(220382,'town','china',220000,220300,'双辽市'),(220400,'city','china',220000,220400,'辽源市'),(220401,'town','china',220000,220400,'市辖区'),(220402,'town','china',220000,220400,'龙山区'),(220403,'town','china',220000,220400,'西安区'),(220421,'town','china',220000,220400,'东丰县'),(220422,'town','china',220000,220400,'东辽县'),(220500,'city','china',220000,220500,'通化市'),(220501,'town','china',220000,220500,'市辖区'),(220502,'town','china',220000,220500,'东昌区'),(220503,'town','china',220000,220500,'二道江区'),(220521,'town','china',220000,220500,'通化县'),(220523,'town','china',220000,220500,'辉南县'),(220524,'town','china',220000,220500,'柳河县'),(220581,'town','china',220000,220500,'梅河口市'),(220582,'town','china',220000,220500,'集安市'),(220600,'city','china',220000,220600,'白山市'),(220601,'town','china',220000,220600,'市辖区'),(220602,'town','china',220000,220600,'浑江区'),(220605,'town','china',220000,220600,'江源区'),(220621,'town','china',220000,220600,'抚松县'),(220622,'town','china',220000,220600,'靖宇县'),(220623,'town','china',220000,220600,'长白朝鲜族自治县'),(220681,'town','china',220000,220600,'临江市'),(220700,'city','china',220000,220700,'松原市'),(220701,'town','china',220000,220700,'市辖区'),(220702,'town','china',220000,220700,'宁江区'),(220721,'town','china',220000,220700,'前郭尔罗斯蒙古族自治县'),(220722,'town','china',220000,220700,'长岭县'),(220723,'town','china',220000,220700,'乾安县'),(220781,'town','china',220000,220700,'扶余市'),(220800,'city','china',220000,220800,'白城市'),(220801,'town','china',220000,220800,'市辖区'),(220802,'town','china',220000,220800,'洮北区'),(220821,'town','china',220000,220800,'镇赉县'),(220822,'town','china',220000,220800,'通榆县'),(220881,'town','china',220000,220800,'洮南市'),(220882,'town','china',220000,220800,'大安市'),(222400,'city','china',220000,222400,'延边朝鲜族自治州'),(222401,'town','china',220000,222400,'延吉市'),(222402,'town','china',220000,222400,'图们市'),(222403,'town','china',220000,222400,'敦化市'),(222404,'town','china',220000,222400,'珲春市'),(222405,'town','china',220000,222400,'龙井市'),(222406,'town','china',220000,222400,'和龙市'),(222424,'town','china',220000,222400,'汪清县'),(222426,'town','china',220000,222400,'安图县'),(230000,'province','china',230000,0,'黑龙江省'),(230100,'city','china',230000,230100,'哈尔滨市'),(230101,'town','china',230000,230100,'市辖区'),(230102,'town','china',230000,230100,'道里区'),(230103,'town','china',230000,230100,'南岗区'),(230104,'town','china',230000,230100,'道外区'),(230108,'town','china',230000,230100,'平房区'),(230109,'town','china',230000,230100,'松北区'),(230110,'town','china',230000,230100,'香坊区'),(230111,'town','china',230000,230100,'呼兰区'),(230112,'town','china',230000,230100,'阿城区'),(230113,'town','china',230000,230100,'双城区'),(230123,'town','china',230000,230100,'依兰县'),(230124,'town','china',230000,230100,'方正县'),(230125,'town','china',230000,230100,'宾县'),(230126,'town','china',230000,230100,'巴彦县'),(230127,'town','china',230000,230100,'木兰县'),(230128,'town','china',230000,230100,'通河县'),(230129,'town','china',230000,230100,'延寿县'),(230183,'town','china',230000,230100,'尚志市'),(230184,'town','china',230000,230100,'五常市'),(230200,'city','china',230000,230200,'齐齐哈尔市'),(230201,'town','china',230000,230200,'市辖区'),(230202,'town','china',230000,230200,'龙沙区'),(230203,'town','china',230000,230200,'建华区'),(230204,'town','china',230000,230200,'铁锋区'),(230205,'town','china',230000,230200,'昂昂溪区'),(230206,'town','china',230000,230200,'富拉尔基区'),(230207,'town','china',230000,230200,'碾子山区'),(230208,'town','china',230000,230200,'梅里斯达斡尔族区'),(230221,'town','china',230000,230200,'龙江县'),(230223,'town','china',230000,230200,'依安县'),(230224,'town','china',230000,230200,'泰来县'),(230225,'town','china',230000,230200,'甘南县'),(230227,'town','china',230000,230200,'富裕县'),(230229,'town','china',230000,230200,'克山县'),(230230,'town','china',230000,230200,'克东县'),(230231,'town','china',230000,230200,'拜泉县'),(230281,'town','china',230000,230200,'讷河市'),(230300,'city','china',230000,230300,'鸡西市'),(230301,'town','china',230000,230300,'市辖区'),(230302,'town','china',230000,230300,'鸡冠区'),(230303,'town','china',230000,230300,'恒山区'),(230304,'town','china',230000,230300,'滴道区'),(230305,'town','china',230000,230300,'梨树区'),(230306,'town','china',230000,230300,'城子河区'),(230307,'town','china',230000,230300,'麻山区'),(230321,'town','china',230000,230300,'鸡东县'),(230381,'town','china',230000,230300,'虎林市'),(230382,'town','china',230000,230300,'密山市'),(230400,'city','china',230000,230400,'鹤岗市'),(230401,'town','china',230000,230400,'市辖区'),(230402,'town','china',230000,230400,'向阳区'),(230403,'town','china',230000,230400,'工农区'),(230404,'town','china',230000,230400,'南山区'),(230405,'town','china',230000,230400,'兴安区'),(230406,'town','china',230000,230400,'东山区'),(230407,'town','china',230000,230400,'兴山区'),(230421,'town','china',230000,230400,'萝北县'),(230422,'town','china',230000,230400,'绥滨县'),(230500,'city','china',230000,230500,'双鸭山市'),(230501,'town','china',230000,230500,'市辖区'),(230502,'town','china',230000,230500,'尖山区'),(230503,'town','china',230000,230500,'岭东区'),(230505,'town','china',230000,230500,'四方台区'),(230506,'town','china',230000,230500,'宝山区'),(230521,'town','china',230000,230500,'集贤县'),(230522,'town','china',230000,230500,'友谊县'),(230523,'town','china',230000,230500,'宝清县'),(230524,'town','china',230000,230500,'饶河县'),(230600,'city','china',230000,230600,'大庆市'),(230601,'town','china',230000,230600,'市辖区'),(230602,'town','china',230000,230600,'萨尔图区'),(230603,'town','china',230000,230600,'龙凤区'),(230604,'town','china',230000,230600,'让胡路区'),(230605,'town','china',230000,230600,'红岗区'),(230606,'town','china',230000,230600,'大同区'),(230621,'town','china',230000,230600,'肇州县'),(230622,'town','china',230000,230600,'肇源县'),(230623,'town','china',230000,230600,'林甸县'),(230624,'town','china',230000,230600,'杜尔伯特蒙古族自治县'),(230700,'city','china',230000,230700,'伊春市'),(230701,'town','china',230000,230700,'市辖区'),(230702,'town','china',230000,230700,'伊春区'),(230703,'town','china',230000,230700,'南岔区'),(230704,'town','china',230000,230700,'友好区'),(230705,'town','china',230000,230700,'西林区'),(230706,'town','china',230000,230700,'翠峦区'),(230707,'town','china',230000,230700,'新青区'),(230708,'town','china',230000,230700,'美溪区'),(230709,'town','china',230000,230700,'金山屯区'),(230710,'town','china',230000,230700,'五营区'),(230711,'town','china',230000,230700,'乌马河区'),(230712,'town','china',230000,230700,'汤旺河区'),(230713,'town','china',230000,230700,'带岭区'),(230714,'town','china',230000,230700,'乌伊岭区'),(230715,'town','china',230000,230700,'红星区'),(230716,'town','china',230000,230700,'上甘岭区'),(230722,'town','china',230000,230700,'嘉荫县'),(230781,'town','china',230000,230700,'铁力市'),(230800,'city','china',230000,230800,'佳木斯市'),(230801,'town','china',230000,230800,'市辖区'),(230803,'town','china',230000,230800,'向阳区'),(230804,'town','china',230000,230800,'前进区'),(230805,'town','china',230000,230800,'东风区'),(230811,'town','china',230000,230800,'郊区'),(230822,'town','china',230000,230800,'桦南县'),(230826,'town','china',230000,230800,'桦川县'),(230828,'town','china',230000,230800,'汤原县'),(230833,'town','china',230000,230800,'抚远县'),(230881,'town','china',230000,230800,'同江市'),(230882,'town','china',230000,230800,'富锦市'),(230900,'city','china',230000,230900,'七台河市'),(230901,'town','china',230000,230900,'市辖区'),(230902,'town','china',230000,230900,'新兴区'),(230903,'town','china',230000,230900,'桃山区'),(230904,'town','china',230000,230900,'茄子河区'),(230921,'town','china',230000,230900,'勃利县'),(231000,'city','china',230000,231000,'牡丹江市'),(231001,'town','china',230000,231000,'市辖区'),(231002,'town','china',230000,231000,'东安区'),(231003,'town','china',230000,231000,'阳明区'),(231004,'town','china',230000,231000,'爱民区'),(231005,'town','china',230000,231000,'西安区'),(231024,'town','china',230000,231000,'东宁县'),(231025,'town','china',230000,231000,'林口县'),(231081,'town','china',230000,231000,'绥芬河市'),(231083,'town','china',230000,231000,'海林市'),(231084,'town','china',230000,231000,'宁安市'),(231085,'town','china',230000,231000,'穆棱市'),(231100,'city','china',230000,231100,'黑河市'),(231101,'town','china',230000,231100,'市辖区'),(231102,'town','china',230000,231100,'爱辉区'),(231121,'town','china',230000,231100,'嫩江县'),(231123,'town','china',230000,231100,'逊克县'),(231124,'town','china',230000,231100,'孙吴县'),(231181,'town','china',230000,231100,'北安市'),(231182,'town','china',230000,231100,'五大连池市'),(231200,'city','china',230000,231200,'绥化市'),(231201,'town','china',230000,231200,'市辖区'),(231202,'town','china',230000,231200,'北林区'),(231221,'town','china',230000,231200,'望奎县'),(231222,'town','china',230000,231200,'兰西县'),(231223,'town','china',230000,231200,'青冈县'),(231224,'town','china',230000,231200,'庆安县'),(231225,'town','china',230000,231200,'明水县'),(231226,'town','china',230000,231200,'绥棱县'),(231281,'town','china',230000,231200,'安达市'),(231282,'town','china',230000,231200,'肇东市'),(231283,'town','china',230000,231200,'海伦市'),(232700,'city','china',230000,232700,'大兴安岭地区'),(232721,'town','china',230000,232700,'呼玛县'),(232722,'town','china',230000,232700,'塔河县'),(232723,'town','china',230000,232700,'漠河县'),(310000,'province','china',310000,0,'上海市'),(310100,'city','china',310000,310100,'市辖区'),(310101,'town','china',310000,310100,'黄浦区'),(310104,'town','china',310000,310100,'徐汇区'),(310105,'town','china',310000,310100,'长宁区'),(310106,'town','china',310000,310100,'静安区'),(310107,'town','china',310000,310100,'普陀区'),(310108,'town','china',310000,310100,'闸北区'),(310109,'town','china',310000,310100,'虹口区'),(310110,'town','china',310000,310100,'杨浦区'),(310112,'town','china',310000,310100,'闵行区'),(310113,'town','china',310000,310100,'宝山区'),(310114,'town','china',310000,310100,'嘉定区'),(310115,'town','china',310000,310100,'浦东新区'),(310116,'town','china',310000,310100,'金山区'),(310117,'town','china',310000,310100,'松江区'),(310118,'town','china',310000,310100,'青浦区'),(310120,'town','china',310000,310100,'奉贤区'),(310200,'city','china',310000,310200,'县'),(310230,'town','china',310000,310200,'崇明县'),(320000,'province','china',320000,0,'江苏省'),(320100,'city','china',320000,320100,'南京市'),(320101,'town','china',320000,320100,'市辖区'),(320102,'town','china',320000,320100,'玄武区'),(320104,'town','china',320000,320100,'秦淮区'),(320105,'town','china',320000,320100,'建邺区'),(320106,'town','china',320000,320100,'鼓楼区'),(320111,'town','china',320000,320100,'浦口区'),(320113,'town','china',320000,320100,'栖霞区'),(320114,'town','china',320000,320100,'雨花台区'),(320115,'town','china',320000,320100,'江宁区'),(320116,'town','china',320000,320100,'六合区'),(320117,'town','china',320000,320100,'溧水区'),(320118,'town','china',320000,320100,'高淳区'),(320200,'city','china',320000,320200,'无锡市'),(320201,'town','china',320000,320200,'市辖区'),(320202,'town','china',320000,320200,'崇安区'),(320203,'town','china',320000,320200,'南长区'),(320204,'town','china',320000,320200,'北塘区'),(320205,'town','china',320000,320200,'锡山区'),(320206,'town','china',320000,320200,'惠山区'),(320211,'town','china',320000,320200,'滨湖区'),(320281,'town','china',320000,320200,'江阴市'),(320282,'town','china',320000,320200,'宜兴市'),(320300,'city','china',320000,320300,'徐州市'),(320301,'town','china',320000,320300,'市辖区'),(320302,'town','china',320000,320300,'鼓楼区'),(320303,'town','china',320000,320300,'云龙区'),(320305,'town','china',320000,320300,'贾汪区'),(320311,'town','china',320000,320300,'泉山区'),(320312,'town','china',320000,320300,'铜山区'),(320321,'town','china',320000,320300,'丰县'),(320322,'town','china',320000,320300,'沛县'),(320324,'town','china',320000,320300,'睢宁县'),(320381,'town','china',320000,320300,'新沂市'),(320382,'town','china',320000,320300,'邳州市'),(320400,'city','china',320000,320400,'常州市'),(320401,'town','china',320000,320400,'市辖区'),(320402,'town','china',320000,320400,'天宁区'),(320404,'town','china',320000,320400,'钟楼区'),(320411,'town','china',320000,320400,'新北区'),(320412,'town','china',320000,320400,'武进区'),(320413,'town','china',320000,320400,'金坛区'),(320481,'town','china',320000,320400,'溧阳市'),(320500,'city','china',320000,320500,'苏州市'),(320501,'town','china',320000,320500,'市辖区'),(320505,'town','china',320000,320500,'虎丘区'),(320506,'town','china',320000,320500,'吴中区'),(320507,'town','china',320000,320500,'相城区'),(320508,'town','china',320000,320500,'姑苏区'),(320509,'town','china',320000,320500,'吴江区'),(320581,'town','china',320000,320500,'常熟市'),(320582,'town','china',320000,320500,'张家港市'),(320583,'town','china',320000,320500,'昆山市'),(320585,'town','china',320000,320500,'太仓市'),(320600,'city','china',320000,320600,'南通市'),(320601,'town','china',320000,320600,'市辖区'),(320602,'town','china',320000,320600,'崇川区'),(320611,'town','china',320000,320600,'港闸区'),(320612,'town','china',320000,320600,'通州区'),(320621,'town','china',320000,320600,'海安县'),(320623,'town','china',320000,320600,'如东县'),(320681,'town','china',320000,320600,'启东市'),(320682,'town','china',320000,320600,'如皋市'),(320684,'town','china',320000,320600,'海门市'),(320700,'city','china',320000,320700,'连云港市'),(320701,'town','china',320000,320700,'市辖区'),(320703,'town','china',320000,320700,'连云区'),(320706,'town','china',320000,320700,'海州区'),(320707,'town','china',320000,320700,'赣榆区'),(320722,'town','china',320000,320700,'东海县'),(320723,'town','china',320000,320700,'灌云县'),(320724,'town','china',320000,320700,'灌南县'),(320800,'city','china',320000,320800,'淮安市'),(320801,'town','china',320000,320800,'市辖区'),(320802,'town','china',320000,320800,'清河区'),(320803,'town','china',320000,320800,'淮安区'),(320804,'town','china',320000,320800,'淮阴区'),(320811,'town','china',320000,320800,'清浦区'),(320826,'town','china',320000,320800,'涟水县'),(320829,'town','china',320000,320800,'洪泽县'),(320830,'town','china',320000,320800,'盱眙县'),(320831,'town','china',320000,320800,'金湖县'),(320900,'city','china',320000,320900,'盐城市'),(320901,'town','china',320000,320900,'市辖区'),(320902,'town','china',320000,320900,'亭湖区'),(320903,'town','china',320000,320900,'盐都区'),(320904,'town','china',320000,320900,'大丰区'),(320921,'town','china',320000,320900,'响水县'),(320922,'town','china',320000,320900,'滨海县'),(320923,'town','china',320000,320900,'阜宁县'),(320924,'town','china',320000,320900,'射阳县'),(320925,'town','china',320000,320900,'建湖县'),(320981,'town','china',320000,320900,'东台市'),(321000,'city','china',320000,321000,'扬州市'),(321001,'town','china',320000,321000,'市辖区'),(321002,'town','china',320000,321000,'广陵区'),(321003,'town','china',320000,321000,'邗江区'),(321012,'town','china',320000,321000,'江都区'),(321023,'town','china',320000,321000,'宝应县'),(321081,'town','china',320000,321000,'仪征市'),(321084,'town','china',320000,321000,'高邮市'),(321100,'city','china',320000,321100,'镇江市'),(321101,'town','china',320000,321100,'市辖区'),(321102,'town','china',320000,321100,'京口区'),(321111,'town','china',320000,321100,'润州区'),(321112,'town','china',320000,321100,'丹徒区'),(321181,'town','china',320000,321100,'丹阳市'),(321182,'town','china',320000,321100,'扬中市'),(321183,'town','china',320000,321100,'句容市'),(321200,'city','china',320000,321200,'泰州市'),(321201,'town','china',320000,321200,'市辖区'),(321202,'town','china',320000,321200,'海陵区'),(321203,'town','china',320000,321200,'高港区'),(321204,'town','china',320000,321200,'姜堰区'),(321281,'town','china',320000,321200,'兴化市'),(321282,'town','china',320000,321200,'靖江市'),(321283,'town','china',320000,321200,'泰兴市'),(321300,'city','china',320000,321300,'宿迁市'),(321301,'town','china',320000,321300,'市辖区'),(321302,'town','china',320000,321300,'宿城区'),(321311,'town','china',320000,321300,'宿豫区'),(321322,'town','china',320000,321300,'沭阳县'),(321323,'town','china',320000,321300,'泗阳县'),(321324,'town','china',320000,321300,'泗洪县'),(330000,'province','china',330000,0,'浙江省'),(330100,'city','china',330000,330100,'杭州市'),(330101,'town','china',330000,330100,'市辖区'),(330102,'town','china',330000,330100,'上城区'),(330103,'town','china',330000,330100,'下城区'),(330104,'town','china',330000,330100,'江干区'),(330105,'town','china',330000,330100,'拱墅区'),(330106,'town','china',330000,330100,'西湖区'),(330108,'town','china',330000,330100,'滨江区'),(330109,'town','china',330000,330100,'萧山区'),(330110,'town','china',330000,330100,'余杭区'),(330111,'town','china',330000,330100,'富阳区'),(330122,'town','china',330000,330100,'桐庐县'),(330127,'town','china',330000,330100,'淳安县'),(330182,'town','china',330000,330100,'建德市'),(330185,'town','china',330000,330100,'临安市'),(330200,'city','china',330000,330200,'宁波市'),(330201,'town','china',330000,330200,'市辖区'),(330203,'town','china',330000,330200,'海曙区'),(330204,'town','china',330000,330200,'江东区'),(330205,'town','china',330000,330200,'江北区'),(330206,'town','china',330000,330200,'北仑区'),(330211,'town','china',330000,330200,'镇海区'),(330212,'town','china',330000,330200,'鄞州区'),(330225,'town','china',330000,330200,'象山县'),(330226,'town','china',330000,330200,'宁海县'),(330281,'town','china',330000,330200,'余姚市'),(330282,'town','china',330000,330200,'慈溪市'),(330283,'town','china',330000,330200,'奉化市'),(330300,'city','china',330000,330300,'温州市'),(330301,'town','china',330000,330300,'市辖区'),(330302,'town','china',330000,330300,'鹿城区'),(330303,'town','china',330000,330300,'龙湾区'),(330304,'town','china',330000,330300,'瓯海区'),(330305,'town','china',330000,330300,'洞头区'),(330324,'town','china',330000,330300,'永嘉县'),(330326,'town','china',330000,330300,'平阳县'),(330327,'town','china',330000,330300,'苍南县'),(330328,'town','china',330000,330300,'文成县'),(330329,'town','china',330000,330300,'泰顺县'),(330381,'town','china',330000,330300,'瑞安市'),(330382,'town','china',330000,330300,'乐清市'),(330400,'city','china',330000,330400,'嘉兴市'),(330401,'town','china',330000,330400,'市辖区'),(330402,'town','china',330000,330400,'南湖区'),(330411,'town','china',330000,330400,'秀洲区'),(330421,'town','china',330000,330400,'嘉善县'),(330424,'town','china',330000,330400,'海盐县'),(330481,'town','china',330000,330400,'海宁市'),(330482,'town','china',330000,330400,'平湖市'),(330483,'town','china',330000,330400,'桐乡市'),(330500,'city','china',330000,330500,'湖州市'),(330501,'town','china',330000,330500,'市辖区'),(330502,'town','china',330000,330500,'吴兴区'),(330503,'town','china',330000,330500,'南浔区'),(330521,'town','china',330000,330500,'德清县'),(330522,'town','china',330000,330500,'长兴县'),(330523,'town','china',330000,330500,'安吉县'),(330600,'city','china',330000,330600,'绍兴市'),(330601,'town','china',330000,330600,'市辖区'),(330602,'town','china',330000,330600,'越城区'),(330603,'town','china',330000,330600,'柯桥区'),(330604,'town','china',330000,330600,'上虞区'),(330624,'town','china',330000,330600,'新昌县'),(330681,'town','china',330000,330600,'诸暨市'),(330683,'town','china',330000,330600,'嵊州市'),(330700,'city','china',330000,330700,'金华市'),(330701,'town','china',330000,330700,'市辖区'),(330702,'town','china',330000,330700,'婺城区'),(330703,'town','china',330000,330700,'金东区'),(330723,'town','china',330000,330700,'武义县'),(330726,'town','china',330000,330700,'浦江县'),(330727,'town','china',330000,330700,'磐安县'),(330781,'town','china',330000,330700,'兰溪市'),(330782,'town','china',330000,330700,'义乌市'),(330783,'town','china',330000,330700,'东阳市'),(330784,'town','china',330000,330700,'永康市'),(330800,'city','china',330000,330800,'衢州市'),(330801,'town','china',330000,330800,'市辖区'),(330802,'town','china',330000,330800,'柯城区'),(330803,'town','china',330000,330800,'衢江区'),(330822,'town','china',330000,330800,'常山县'),(330824,'town','china',330000,330800,'开化县'),(330825,'town','china',330000,330800,'龙游县'),(330881,'town','china',330000,330800,'江山市'),(330900,'city','china',330000,330900,'舟山市'),(330901,'town','china',330000,330900,'市辖区'),(330902,'town','china',330000,330900,'定海区'),(330903,'town','china',330000,330900,'普陀区'),(330921,'town','china',330000,330900,'岱山县'),(330922,'town','china',330000,330900,'嵊泗县'),(331000,'city','china',330000,331000,'台州市'),(331001,'town','china',330000,331000,'市辖区'),(331002,'town','china',330000,331000,'椒江区'),(331003,'town','china',330000,331000,'黄岩区'),(331004,'town','china',330000,331000,'路桥区'),(331021,'town','china',330000,331000,'玉环县'),(331022,'town','china',330000,331000,'三门县'),(331023,'town','china',330000,331000,'天台县'),(331024,'town','china',330000,331000,'仙居县'),(331081,'town','china',330000,331000,'温岭市'),(331082,'town','china',330000,331000,'临海市'),(331100,'city','china',330000,331100,'丽水市'),(331101,'town','china',330000,331100,'市辖区'),(331102,'town','china',330000,331100,'莲都区'),(331121,'town','china',330000,331100,'青田县'),(331122,'town','china',330000,331100,'缙云县'),(331123,'town','china',330000,331100,'遂昌县'),(331124,'town','china',330000,331100,'松阳县'),(331125,'town','china',330000,331100,'云和县'),(331126,'town','china',330000,331100,'庆元县'),(331127,'town','china',330000,331100,'景宁畲族自治县'),(331181,'town','china',330000,331100,'龙泉市'),(340000,'province','china',340000,0,'安徽省'),(340100,'city','china',340000,340100,'合肥市'),(340101,'town','china',340000,340100,'市辖区'),(340102,'town','china',340000,340100,'瑶海区'),(340103,'town','china',340000,340100,'庐阳区'),(340104,'town','china',340000,340100,'蜀山区'),(340111,'town','china',340000,340100,'包河区'),(340121,'town','china',340000,340100,'长丰县'),(340122,'town','china',340000,340100,'肥东县'),(340123,'town','china',340000,340100,'肥西县'),(340124,'town','china',340000,340100,'庐江县'),(340181,'town','china',340000,340100,'巢湖市'),(340200,'city','china',340000,340200,'芜湖市'),(340201,'town','china',340000,340200,'市辖区'),(340202,'town','china',340000,340200,'镜湖区'),(340203,'town','china',340000,340200,'弋江区'),(340207,'town','china',340000,340200,'鸠江区'),(340208,'town','china',340000,340200,'三山区'),(340221,'town','china',340000,340200,'芜湖县'),(340222,'town','china',340000,340200,'繁昌县'),(340223,'town','china',340000,340200,'南陵县'),(340225,'town','china',340000,340200,'无为县'),(340300,'city','china',340000,340300,'蚌埠市'),(340301,'town','china',340000,340300,'市辖区'),(340302,'town','china',340000,340300,'龙子湖区'),(340303,'town','china',340000,340300,'蚌山区'),(340304,'town','china',340000,340300,'禹会区'),(340311,'town','china',340000,340300,'淮上区'),(340321,'town','china',340000,340300,'怀远县'),(340322,'town','china',340000,340300,'五河县'),(340323,'town','china',340000,340300,'固镇县'),(340400,'city','china',340000,340400,'淮南市'),(340401,'town','china',340000,340400,'市辖区'),(340402,'town','china',340000,340400,'大通区'),(340403,'town','china',340000,340400,'田家庵区'),(340404,'town','china',340000,340400,'谢家集区'),(340405,'town','china',340000,340400,'八公山区'),(340406,'town','china',340000,340400,'潘集区'),(340421,'town','china',340000,340400,'凤台县'),(340500,'city','china',340000,340500,'马鞍山市'),(340501,'town','china',340000,340500,'市辖区'),(340503,'town','china',340000,340500,'花山区'),(340504,'town','china',340000,340500,'雨山区'),(340506,'town','china',340000,340500,'博望区'),(340521,'town','china',340000,340500,'当涂县'),(340522,'town','china',340000,340500,'含山县'),(340523,'town','china',340000,340500,'和县'),(340600,'city','china',340000,340600,'淮北市'),(340601,'town','china',340000,340600,'市辖区'),(340602,'town','china',340000,340600,'杜集区'),(340603,'town','china',340000,340600,'相山区'),(340604,'town','china',340000,340600,'烈山区'),(340621,'town','china',340000,340600,'濉溪县'),(340700,'city','china',340000,340700,'铜陵市'),(340701,'town','china',340000,340700,'市辖区'),(340702,'town','china',340000,340700,'铜官山区'),(340703,'town','china',340000,340700,'狮子山区'),(340711,'town','china',340000,340700,'郊区'),(340721,'town','china',340000,340700,'铜陵县'),(340800,'city','china',340000,340800,'安庆市'),(340801,'town','china',340000,340800,'市辖区'),(340802,'town','china',340000,340800,'迎江区'),(340803,'town','china',340000,340800,'大观区'),(340811,'town','china',340000,340800,'宜秀区'),(340822,'town','china',340000,340800,'怀宁县'),(340823,'town','china',340000,340800,'枞阳县'),(340824,'town','china',340000,340800,'潜山县'),(340825,'town','china',340000,340800,'太湖县'),(340826,'town','china',340000,340800,'宿松县'),(340827,'town','china',340000,340800,'望江县'),(340828,'town','china',340000,340800,'岳西县'),(340881,'town','china',340000,340800,'桐城市'),(341000,'city','china',340000,341000,'黄山市'),(341001,'town','china',340000,341000,'市辖区'),(341002,'town','china',340000,341000,'屯溪区'),(341003,'town','china',340000,341000,'黄山区'),(341004,'town','china',340000,341000,'徽州区'),(341021,'town','china',340000,341000,'歙县'),(341022,'town','china',340000,341000,'休宁县'),(341023,'town','china',340000,341000,'黟县'),(341024,'town','china',340000,341000,'祁门县'),(341100,'city','china',340000,341100,'滁州市'),(341101,'town','china',340000,341100,'市辖区'),(341102,'town','china',340000,341100,'琅琊区'),(341103,'town','china',340000,341100,'南谯区'),(341122,'town','china',340000,341100,'来安县'),(341124,'town','china',340000,341100,'全椒县'),(341125,'town','china',340000,341100,'定远县'),(341126,'town','china',340000,341100,'凤阳县'),(341181,'town','china',340000,341100,'天长市'),(341182,'town','china',340000,341100,'明光市'),(341200,'city','china',340000,341200,'阜阳市'),(341201,'town','china',340000,341200,'市辖区'),(341202,'town','china',340000,341200,'颍州区'),(341203,'town','china',340000,341200,'颍东区'),(341204,'town','china',340000,341200,'颍泉区'),(341221,'town','china',340000,341200,'临泉县'),(341222,'town','china',340000,341200,'太和县'),(341225,'town','china',340000,341200,'阜南县'),(341226,'town','china',340000,341200,'颍上县'),(341282,'town','china',340000,341200,'界首市'),(341300,'city','china',340000,341300,'宿州市'),(341301,'town','china',340000,341300,'市辖区'),(341302,'town','china',340000,341300,'埇桥区'),(341321,'town','china',340000,341300,'砀山县'),(341322,'town','china',340000,341300,'萧县'),(341323,'town','china',340000,341300,'灵璧县'),(341324,'town','china',340000,341300,'泗县'),(341500,'city','china',340000,341500,'六安市'),(341501,'town','china',340000,341500,'市辖区'),(341502,'town','china',340000,341500,'金安区'),(341503,'town','china',340000,341500,'裕安区'),(341521,'town','china',340000,341500,'寿县'),(341522,'town','china',340000,341500,'霍邱县'),(341523,'town','china',340000,341500,'舒城县'),(341524,'town','china',340000,341500,'金寨县'),(341525,'town','china',340000,341500,'霍山县'),(341600,'city','china',340000,341600,'亳州市'),(341601,'town','china',340000,341600,'市辖区'),(341602,'town','china',340000,341600,'谯城区'),(341621,'town','china',340000,341600,'涡阳县'),(341622,'town','china',340000,341600,'蒙城县'),(341623,'town','china',340000,341600,'利辛县'),(341700,'city','china',340000,341700,'池州市'),(341701,'town','china',340000,341700,'市辖区'),(341702,'town','china',340000,341700,'贵池区'),(341721,'town','china',340000,341700,'东至县'),(341722,'town','china',340000,341700,'石台县'),(341723,'town','china',340000,341700,'青阳县'),(341800,'city','china',340000,341800,'宣城市'),(341801,'town','china',340000,341800,'市辖区'),(341802,'town','china',340000,341800,'宣州区'),(341821,'town','china',340000,341800,'郎溪县'),(341822,'town','china',340000,341800,'广德县'),(341823,'town','china',340000,341800,'泾县'),(341824,'town','china',340000,341800,'绩溪县'),(341825,'town','china',340000,341800,'旌德县'),(341881,'town','china',340000,341800,'宁国市'),(350000,'province','china',350000,0,'福建省'),(350100,'city','china',350000,350100,'福州市'),(350101,'town','china',350000,350100,'市辖区'),(350102,'town','china',350000,350100,'鼓楼区'),(350103,'town','china',350000,350100,'台江区'),(350104,'town','china',350000,350100,'仓山区'),(350105,'town','china',350000,350100,'马尾区'),(350111,'town','china',350000,350100,'晋安区'),(350121,'town','china',350000,350100,'闽侯县'),(350122,'town','china',350000,350100,'连江县'),(350123,'town','china',350000,350100,'罗源县'),(350124,'town','china',350000,350100,'闽清县'),(350125,'town','china',350000,350100,'永泰县'),(350128,'town','china',350000,350100,'平潭县'),(350181,'town','china',350000,350100,'福清市'),(350182,'town','china',350000,350100,'长乐市'),(350200,'city','china',350000,350200,'厦门市'),(350201,'town','china',350000,350200,'市辖区'),(350203,'town','china',350000,350200,'思明区'),(350205,'town','china',350000,350200,'海沧区'),(350206,'town','china',350000,350200,'湖里区'),(350211,'town','china',350000,350200,'集美区'),(350212,'town','china',350000,350200,'同安区'),(350213,'town','china',350000,350200,'翔安区'),(350300,'city','china',350000,350300,'莆田市'),(350301,'town','china',350000,350300,'市辖区'),(350302,'town','china',350000,350300,'城厢区'),(350303,'town','china',350000,350300,'涵江区'),(350304,'town','china',350000,350300,'荔城区'),(350305,'town','china',350000,350300,'秀屿区'),(350322,'town','china',350000,350300,'仙游县'),(350400,'city','china',350000,350400,'三明市'),(350401,'town','china',350000,350400,'市辖区'),(350402,'town','china',350000,350400,'梅列区'),(350403,'town','china',350000,350400,'三元区'),(350421,'town','china',350000,350400,'明溪县'),(350423,'town','china',350000,350400,'清流县'),(350424,'town','china',350000,350400,'宁化县'),(350425,'town','china',350000,350400,'大田县'),(350426,'town','china',350000,350400,'尤溪县'),(350427,'town','china',350000,350400,'沙县'),(350428,'town','china',350000,350400,'将乐县'),(350429,'town','china',350000,350400,'泰宁县'),(350430,'town','china',350000,350400,'建宁县'),(350481,'town','china',350000,350400,'永安市'),(350500,'city','china',350000,350500,'泉州市'),(350501,'town','china',350000,350500,'市辖区'),(350502,'town','china',350000,350500,'鲤城区'),(350503,'town','china',350000,350500,'丰泽区'),(350504,'town','china',350000,350500,'洛江区'),(350505,'town','china',350000,350500,'泉港区'),(350521,'town','china',350000,350500,'惠安县'),(350524,'town','china',350000,350500,'安溪县'),(350525,'town','china',350000,350500,'永春县'),(350526,'town','china',350000,350500,'德化县'),(350527,'town','china',350000,350500,'金门县'),(350581,'town','china',350000,350500,'石狮市'),(350582,'town','china',350000,350500,'晋江市'),(350583,'town','china',350000,350500,'南安市'),(350600,'city','china',350000,350600,'漳州市'),(350601,'town','china',350000,350600,'市辖区'),(350602,'town','china',350000,350600,'芗城区'),(350603,'town','china',350000,350600,'龙文区'),(350622,'town','china',350000,350600,'云霄县'),(350623,'town','china',350000,350600,'漳浦县'),(350624,'town','china',350000,350600,'诏安县'),(350625,'town','china',350000,350600,'长泰县'),(350626,'town','china',350000,350600,'东山县'),(350627,'town','china',350000,350600,'南靖县'),(350628,'town','china',350000,350600,'平和县'),(350629,'town','china',350000,350600,'华安县'),(350681,'town','china',350000,350600,'龙海市'),(350700,'city','china',350000,350700,'南平市'),(350701,'town','china',350000,350700,'市辖区'),(350702,'town','china',350000,350700,'延平区'),(350703,'town','china',350000,350700,'建阳区'),(350721,'town','china',350000,350700,'顺昌县'),(350722,'town','china',350000,350700,'浦城县'),(350723,'town','china',350000,350700,'光泽县'),(350724,'town','china',350000,350700,'松溪县'),(350725,'town','china',350000,350700,'政和县'),(350781,'town','china',350000,350700,'邵武市'),(350782,'town','china',350000,350700,'武夷山市'),(350783,'town','china',350000,350700,'建瓯市'),(350800,'city','china',350000,350800,'龙岩市'),(350801,'town','china',350000,350800,'市辖区'),(350802,'town','china',350000,350800,'新罗区'),(350803,'town','china',350000,350800,'永定区'),(350821,'town','china',350000,350800,'长汀县'),(350823,'town','china',350000,350800,'上杭县'),(350824,'town','china',350000,350800,'武平县'),(350825,'town','china',350000,350800,'连城县'),(350881,'town','china',350000,350800,'漳平市'),(350900,'city','china',350000,350900,'宁德市'),(350901,'town','china',350000,350900,'市辖区'),(350902,'town','china',350000,350900,'蕉城区'),(350921,'town','china',350000,350900,'霞浦县'),(350922,'town','china',350000,350900,'古田县'),(350923,'town','china',350000,350900,'屏南县'),(350924,'town','china',350000,350900,'寿宁县'),(350925,'town','china',350000,350900,'周宁县'),(350926,'town','china',350000,350900,'柘荣县'),(350981,'town','china',350000,350900,'福安市'),(350982,'town','china',350000,350900,'福鼎市'),(360000,'province','china',360000,0,'江西省'),(360100,'city','china',360000,360100,'南昌市'),(360101,'town','china',360000,360100,'市辖区'),(360102,'town','china',360000,360100,'东湖区'),(360103,'town','china',360000,360100,'西湖区'),(360104,'town','china',360000,360100,'青云谱区'),(360105,'town','china',360000,360100,'湾里区'),(360111,'town','china',360000,360100,'青山湖区'),(360112,'town','china',360000,360100,'新建区'),(360121,'town','china',360000,360100,'南昌县'),(360123,'town','china',360000,360100,'安义县'),(360124,'town','china',360000,360100,'进贤县'),(360200,'city','china',360000,360200,'景德镇市'),(360201,'town','china',360000,360200,'市辖区'),(360202,'town','china',360000,360200,'昌江区'),(360203,'town','china',360000,360200,'珠山区'),(360222,'town','china',360000,360200,'浮梁县'),(360281,'town','china',360000,360200,'乐平市'),(360300,'city','china',360000,360300,'萍乡市'),(360301,'town','china',360000,360300,'市辖区'),(360302,'town','china',360000,360300,'安源区'),(360313,'town','china',360000,360300,'湘东区'),(360321,'town','china',360000,360300,'莲花县'),(360322,'town','china',360000,360300,'上栗县'),(360323,'town','china',360000,360300,'芦溪县'),(360400,'city','china',360000,360400,'九江市'),(360401,'town','china',360000,360400,'市辖区'),(360402,'town','china',360000,360400,'庐山区'),(360403,'town','china',360000,360400,'浔阳区'),(360421,'town','china',360000,360400,'九江县'),(360423,'town','china',360000,360400,'武宁县'),(360424,'town','china',360000,360400,'修水县'),(360425,'town','china',360000,360400,'永修县'),(360426,'town','china',360000,360400,'德安县'),(360427,'town','china',360000,360400,'星子县'),(360428,'town','china',360000,360400,'都昌县'),(360429,'town','china',360000,360400,'湖口县'),(360430,'town','china',360000,360400,'彭泽县'),(360481,'town','china',360000,360400,'瑞昌市'),(360482,'town','china',360000,360400,'共青城市'),(360500,'city','china',360000,360500,'新余市'),(360501,'town','china',360000,360500,'市辖区'),(360502,'town','china',360000,360500,'渝水区'),(360521,'town','china',360000,360500,'分宜县'),(360600,'city','china',360000,360600,'鹰潭市'),(360601,'town','china',360000,360600,'市辖区'),(360602,'town','china',360000,360600,'月湖区'),(360622,'town','china',360000,360600,'余江县'),(360681,'town','china',360000,360600,'贵溪市'),(360700,'city','china',360000,360700,'赣州市'),(360701,'town','china',360000,360700,'市辖区'),(360702,'town','china',360000,360700,'章贡区'),(360703,'town','china',360000,360700,'南康区'),(360721,'town','china',360000,360700,'赣县'),(360722,'town','china',360000,360700,'信丰县'),(360723,'town','china',360000,360700,'大余县'),(360724,'town','china',360000,360700,'上犹县'),(360725,'town','china',360000,360700,'崇义县'),(360726,'town','china',360000,360700,'安远县'),(360727,'town','china',360000,360700,'龙南县'),(360728,'town','china',360000,360700,'定南县'),(360729,'town','china',360000,360700,'全南县'),(360730,'town','china',360000,360700,'宁都县'),(360731,'town','china',360000,360700,'于都县'),(360732,'town','china',360000,360700,'兴国县'),(360733,'town','china',360000,360700,'会昌县'),(360734,'town','china',360000,360700,'寻乌县'),(360735,'town','china',360000,360700,'石城县'),(360781,'town','china',360000,360700,'瑞金市'),(360800,'city','china',360000,360800,'吉安市'),(360801,'town','china',360000,360800,'市辖区'),(360802,'town','china',360000,360800,'吉州区'),(360803,'town','china',360000,360800,'青原区'),(360821,'town','china',360000,360800,'吉安县'),(360822,'town','china',360000,360800,'吉水县'),(360823,'town','china',360000,360800,'峡江县'),(360824,'town','china',360000,360800,'新干县'),(360825,'town','china',360000,360800,'永丰县'),(360826,'town','china',360000,360800,'泰和县'),(360827,'town','china',360000,360800,'遂川县'),(360828,'town','china',360000,360800,'万安县'),(360829,'town','china',360000,360800,'安福县'),(360830,'town','china',360000,360800,'永新县'),(360881,'town','china',360000,360800,'井冈山市'),(360900,'city','china',360000,360900,'宜春市'),(360901,'town','china',360000,360900,'市辖区'),(360902,'town','china',360000,360900,'袁州区'),(360921,'town','china',360000,360900,'奉新县'),(360922,'town','china',360000,360900,'万载县'),(360923,'town','china',360000,360900,'上高县'),(360924,'town','china',360000,360900,'宜丰县'),(360925,'town','china',360000,360900,'靖安县'),(360926,'town','china',360000,360900,'铜鼓县'),(360981,'town','china',360000,360900,'丰城市'),(360982,'town','china',360000,360900,'樟树市'),(360983,'town','china',360000,360900,'高安市'),(361000,'city','china',360000,361000,'抚州市'),(361001,'town','china',360000,361000,'市辖区'),(361002,'town','china',360000,361000,'临川区'),(361021,'town','china',360000,361000,'南城县'),(361022,'town','china',360000,361000,'黎川县'),(361023,'town','china',360000,361000,'南丰县'),(361024,'town','china',360000,361000,'崇仁县'),(361025,'town','china',360000,361000,'乐安县'),(361026,'town','china',360000,361000,'宜黄县'),(361027,'town','china',360000,361000,'金溪县'),(361028,'town','china',360000,361000,'资溪县'),(361029,'town','china',360000,361000,'东乡县'),(361030,'town','china',360000,361000,'广昌县'),(361100,'city','china',360000,361100,'上饶市'),(361101,'town','china',360000,361100,'市辖区'),(361102,'town','china',360000,361100,'信州区'),(361103,'town','china',360000,361100,'广丰区'),(361121,'town','china',360000,361100,'上饶县'),(361123,'town','china',360000,361100,'玉山县'),(361124,'town','china',360000,361100,'铅山县'),(361125,'town','china',360000,361100,'横峰县'),(361126,'town','china',360000,361100,'弋阳县'),(361127,'town','china',360000,361100,'余干县'),(361128,'town','china',360000,361100,'鄱阳县'),(361129,'town','china',360000,361100,'万年县'),(361130,'town','china',360000,361100,'婺源县'),(361181,'town','china',360000,361100,'德兴市'),(370000,'province','china',370000,0,'山东省'),(370100,'city','china',370000,370100,'济南市'),(370101,'town','china',370000,370100,'市辖区'),(370102,'town','china',370000,370100,'历下区'),(370103,'town','china',370000,370100,'市中区'),(370104,'town','china',370000,370100,'槐荫区'),(370105,'town','china',370000,370100,'天桥区'),(370112,'town','china',370000,370100,'历城区'),(370113,'town','china',370000,370100,'长清区'),(370124,'town','china',370000,370100,'平阴县'),(370125,'town','china',370000,370100,'济阳县'),(370126,'town','china',370000,370100,'商河县'),(370181,'town','china',370000,370100,'章丘市'),(370200,'city','china',370000,370200,'青岛市'),(370201,'town','china',370000,370200,'市辖区'),(370202,'town','china',370000,370200,'市南区'),(370203,'town','china',370000,370200,'市北区'),(370211,'town','china',370000,370200,'黄岛区'),(370212,'town','china',370000,370200,'崂山区'),(370213,'town','china',370000,370200,'李沧区'),(370214,'town','china',370000,370200,'城阳区'),(370281,'town','china',370000,370200,'胶州市'),(370282,'town','china',370000,370200,'即墨市'),(370283,'town','china',370000,370200,'平度市'),(370285,'town','china',370000,370200,'莱西市'),(370300,'city','china',370000,370300,'淄博市'),(370301,'town','china',370000,370300,'市辖区'),(370302,'town','china',370000,370300,'淄川区'),(370303,'town','china',370000,370300,'张店区'),(370304,'town','china',370000,370300,'博山区'),(370305,'town','china',370000,370300,'临淄区'),(370306,'town','china',370000,370300,'周村区'),(370321,'town','china',370000,370300,'桓台县'),(370322,'town','china',370000,370300,'高青县'),(370323,'town','china',370000,370300,'沂源县'),(370400,'city','china',370000,370400,'枣庄市'),(370401,'town','china',370000,370400,'市辖区'),(370402,'town','china',370000,370400,'市中区'),(370403,'town','china',370000,370400,'薛城区'),(370404,'town','china',370000,370400,'峄城区'),(370405,'town','china',370000,370400,'台儿庄区'),(370406,'town','china',370000,370400,'山亭区'),(370481,'town','china',370000,370400,'滕州市'),(370500,'city','china',370000,370500,'东营市'),(370501,'town','china',370000,370500,'市辖区'),(370502,'town','china',370000,370500,'东营区'),(370503,'town','china',370000,370500,'河口区'),(370521,'town','china',370000,370500,'垦利县'),(370522,'town','china',370000,370500,'利津县'),(370523,'town','china',370000,370500,'广饶县'),(370600,'city','china',370000,370600,'烟台市'),(370601,'town','china',370000,370600,'市辖区'),(370602,'town','china',370000,370600,'芝罘区'),(370611,'town','china',370000,370600,'福山区'),(370612,'town','china',370000,370600,'牟平区'),(370613,'town','china',370000,370600,'莱山区'),(370634,'town','china',370000,370600,'长岛县'),(370681,'town','china',370000,370600,'龙口市'),(370682,'town','china',370000,370600,'莱阳市'),(370683,'town','china',370000,370600,'莱州市'),(370684,'town','china',370000,370600,'蓬莱市'),(370685,'town','china',370000,370600,'招远市'),(370686,'town','china',370000,370600,'栖霞市'),(370687,'town','china',370000,370600,'海阳市'),(370700,'city','china',370000,370700,'潍坊市'),(370701,'town','china',370000,370700,'市辖区'),(370702,'town','china',370000,370700,'潍城区'),(370703,'town','china',370000,370700,'寒亭区'),(370704,'town','china',370000,370700,'坊子区'),(370705,'town','china',370000,370700,'奎文区'),(370724,'town','china',370000,370700,'临朐县'),(370725,'town','china',370000,370700,'昌乐县'),(370781,'town','china',370000,370700,'青州市'),(370782,'town','china',370000,370700,'诸城市'),(370783,'town','china',370000,370700,'寿光市'),(370784,'town','china',370000,370700,'安丘市'),(370785,'town','china',370000,370700,'高密市'),(370786,'town','china',370000,370700,'昌邑市'),(370800,'city','china',370000,370800,'济宁市'),(370801,'town','china',370000,370800,'市辖区'),(370811,'town','china',370000,370800,'任城区'),(370812,'town','china',370000,370800,'兖州区'),(370826,'town','china',370000,370800,'微山县'),(370827,'town','china',370000,370800,'鱼台县'),(370828,'town','china',370000,370800,'金乡县'),(370829,'town','china',370000,370800,'嘉祥县'),(370830,'town','china',370000,370800,'汶上县'),(370831,'town','china',370000,370800,'泗水县'),(370832,'town','china',370000,370800,'梁山县'),(370881,'town','china',370000,370800,'曲阜市'),(370883,'town','china',370000,370800,'邹城市'),(370900,'city','china',370000,370900,'泰安市'),(370901,'town','china',370000,370900,'市辖区'),(370902,'town','china',370000,370900,'泰山区'),(370911,'town','china',370000,370900,'岱岳区'),(370921,'town','china',370000,370900,'宁阳县'),(370923,'town','china',370000,370900,'东平县'),(370982,'town','china',370000,370900,'新泰市'),(370983,'town','china',370000,370900,'肥城市'),(371000,'city','china',370000,371000,'威海市'),(371001,'town','china',370000,371000,'市辖区'),(371002,'town','china',370000,371000,'环翠区'),(371003,'town','china',370000,371000,'文登区'),(371082,'town','china',370000,371000,'荣成市'),(371083,'town','china',370000,371000,'乳山市'),(371100,'city','china',370000,371100,'日照市'),(371101,'town','china',370000,371100,'市辖区'),(371102,'town','china',370000,371100,'东港区'),(371103,'town','china',370000,371100,'岚山区'),(371121,'town','china',370000,371100,'五莲县'),(371122,'town','china',370000,371100,'莒县'),(371200,'city','china',370000,371200,'莱芜市'),(371201,'town','china',370000,371200,'市辖区'),(371202,'town','china',370000,371200,'莱城区'),(371203,'town','china',370000,371200,'钢城区'),(371300,'city','china',370000,371300,'临沂市'),(371301,'town','china',370000,371300,'市辖区'),(371302,'town','china',370000,371300,'兰山区'),(371311,'town','china',370000,371300,'罗庄区'),(371312,'town','china',370000,371300,'河东区'),(371321,'town','china',370000,371300,'沂南县'),(371322,'town','china',370000,371300,'郯城县'),(371323,'town','china',370000,371300,'沂水县'),(371324,'town','china',370000,371300,'兰陵县'),(371325,'town','china',370000,371300,'费县'),(371326,'town','china',370000,371300,'平邑县'),(371327,'town','china',370000,371300,'莒南县'),(371328,'town','china',370000,371300,'蒙阴县'),(371329,'town','china',370000,371300,'临沭县'),(371400,'city','china',370000,371400,'德州市'),(371401,'town','china',370000,371400,'市辖区'),(371402,'town','china',370000,371400,'德城区'),(371403,'town','china',370000,371400,'陵城区'),(371422,'town','china',370000,371400,'宁津县'),(371423,'town','china',370000,371400,'庆云县'),(371424,'town','china',370000,371400,'临邑县'),(371425,'town','china',370000,371400,'齐河县'),(371426,'town','china',370000,371400,'平原县'),(371427,'town','china',370000,371400,'夏津县'),(371428,'town','china',370000,371400,'武城县'),(371481,'town','china',370000,371400,'乐陵市'),(371482,'town','china',370000,371400,'禹城市'),(371500,'city','china',370000,371500,'聊城市'),(371501,'town','china',370000,371500,'市辖区'),(371502,'town','china',370000,371500,'东昌府区'),(371521,'town','china',370000,371500,'阳谷县'),(371522,'town','china',370000,371500,'莘县'),(371523,'town','china',370000,371500,'茌平县'),(371524,'town','china',370000,371500,'东阿县'),(371525,'town','china',370000,371500,'冠县'),(371526,'town','china',370000,371500,'高唐县'),(371581,'town','china',370000,371500,'临清市'),(371600,'city','china',370000,371600,'滨州市'),(371601,'town','china',370000,371600,'市辖区'),(371602,'town','china',370000,371600,'滨城区'),(371603,'town','china',370000,371600,'沾化区'),(371621,'town','china',370000,371600,'惠民县'),(371622,'town','china',370000,371600,'阳信县'),(371623,'town','china',370000,371600,'无棣县'),(371625,'town','china',370000,371600,'博兴县'),(371626,'town','china',370000,371600,'邹平县'),(371700,'city','china',370000,371700,'菏泽市'),(371701,'town','china',370000,371700,'市辖区'),(371702,'town','china',370000,371700,'牡丹区'),(371721,'town','china',370000,371700,'曹县'),(371722,'town','china',370000,371700,'单县'),(371723,'town','china',370000,371700,'成武县'),(371724,'town','china',370000,371700,'巨野县'),(371725,'town','china',370000,371700,'郓城县'),(371726,'town','china',370000,371700,'鄄城县'),(371727,'town','china',370000,371700,'定陶县'),(371728,'town','china',370000,371700,'东明县'),(410000,'province','china',410000,0,'河南省'),(410100,'city','china',410000,410100,'郑州市'),(410101,'town','china',410000,410100,'市辖区'),(410102,'town','china',410000,410100,'中原区'),(410103,'town','china',410000,410100,'二七区'),(410104,'town','china',410000,410100,'管城回族区'),(410105,'town','china',410000,410100,'金水区'),(410106,'town','china',410000,410100,'上街区'),(410108,'town','china',410000,410100,'惠济区'),(410122,'town','china',410000,410100,'中牟县'),(410181,'town','china',410000,410100,'巩义市'),(410182,'town','china',410000,410100,'荥阳市'),(410183,'town','china',410000,410100,'新密市'),(410184,'town','china',410000,410100,'新郑市'),(410185,'town','china',410000,410100,'登封市'),(410200,'city','china',410000,410200,'开封市'),(410201,'town','china',410000,410200,'市辖区'),(410202,'town','china',410000,410200,'龙亭区'),(410203,'town','china',410000,410200,'顺河回族区'),(410204,'town','china',410000,410200,'鼓楼区'),(410205,'town','china',410000,410200,'禹王台区'),(410211,'town','china',410000,410200,'金明区'),(410212,'town','china',410000,410200,'祥符区'),(410221,'town','china',410000,410200,'杞县'),(410222,'town','china',410000,410200,'通许县'),(410223,'town','china',410000,410200,'尉氏县'),(410225,'town','china',410000,410200,'兰考县'),(410300,'city','china',410000,410300,'洛阳市'),(410301,'town','china',410000,410300,'市辖区'),(410302,'town','china',410000,410300,'老城区'),(410303,'town','china',410000,410300,'西工区'),(410304,'town','china',410000,410300,'瀍河回族区'),(410305,'town','china',410000,410300,'涧西区'),(410306,'town','china',410000,410300,'吉利区'),(410311,'town','china',410000,410300,'洛龙区'),(410322,'town','china',410000,410300,'孟津县'),(410323,'town','china',410000,410300,'新安县'),(410324,'town','china',410000,410300,'栾川县'),(410325,'town','china',410000,410300,'嵩县'),(410326,'town','china',410000,410300,'汝阳县'),(410327,'town','china',410000,410300,'宜阳县'),(410328,'town','china',410000,410300,'洛宁县'),(410329,'town','china',410000,410300,'伊川县'),(410381,'town','china',410000,410300,'偃师市'),(410400,'city','china',410000,410400,'平顶山市'),(410401,'town','china',410000,410400,'市辖区'),(410402,'town','china',410000,410400,'新华区'),(410403,'town','china',410000,410400,'卫东区'),(410404,'town','china',410000,410400,'石龙区'),(410411,'town','china',410000,410400,'湛河区'),(410421,'town','china',410000,410400,'宝丰县'),(410422,'town','china',410000,410400,'叶县'),(410423,'town','china',410000,410400,'鲁山县'),(410425,'town','china',410000,410400,'郏县'),(410481,'town','china',410000,410400,'舞钢市'),(410482,'town','china',410000,410400,'汝州市'),(410500,'city','china',410000,410500,'安阳市'),(410501,'town','china',410000,410500,'市辖区'),(410502,'town','china',410000,410500,'文峰区'),(410503,'town','china',410000,410500,'北关区'),(410505,'town','china',410000,410500,'殷都区'),(410506,'town','china',410000,410500,'龙安区'),(410522,'town','china',410000,410500,'安阳县'),(410523,'town','china',410000,410500,'汤阴县'),(410526,'town','china',410000,410500,'滑县'),(410527,'town','china',410000,410500,'内黄县'),(410581,'town','china',410000,410500,'林州市'),(410600,'city','china',410000,410600,'鹤壁市'),(410601,'town','china',410000,410600,'市辖区'),(410602,'town','china',410000,410600,'鹤山区'),(410603,'town','china',410000,410600,'山城区'),(410611,'town','china',410000,410600,'淇滨区'),(410621,'town','china',410000,410600,'浚县'),(410622,'town','china',410000,410600,'淇县'),(410700,'city','china',410000,410700,'新乡市'),(410701,'town','china',410000,410700,'市辖区'),(410702,'town','china',410000,410700,'红旗区'),(410703,'town','china',410000,410700,'卫滨区'),(410704,'town','china',410000,410700,'凤泉区'),(410711,'town','china',410000,410700,'牧野区'),(410721,'town','china',410000,410700,'新乡县'),(410724,'town','china',410000,410700,'获嘉县'),(410725,'town','china',410000,410700,'原阳县'),(410726,'town','china',410000,410700,'延津县'),(410727,'town','china',410000,410700,'封丘县'),(410728,'town','china',410000,410700,'长垣县'),(410781,'town','china',410000,410700,'卫辉市'),(410782,'town','china',410000,410700,'辉县市'),(410800,'city','china',410000,410800,'焦作市'),(410801,'town','china',410000,410800,'市辖区'),(410802,'town','china',410000,410800,'解放区'),(410803,'town','china',410000,410800,'中站区'),(410804,'town','china',410000,410800,'马村区'),(410811,'town','china',410000,410800,'山阳区'),(410821,'town','china',410000,410800,'修武县'),(410822,'town','china',410000,410800,'博爱县'),(410823,'town','china',410000,410800,'武陟县'),(410825,'town','china',410000,410800,'温县'),(410882,'town','china',410000,410800,'沁阳市'),(410883,'town','china',410000,410800,'孟州市'),(410900,'city','china',410000,410900,'濮阳市'),(410901,'town','china',410000,410900,'市辖区'),(410902,'town','china',410000,410900,'华龙区'),(410922,'town','china',410000,410900,'清丰县'),(410923,'town','china',410000,410900,'南乐县'),(410926,'town','china',410000,410900,'范县'),(410927,'town','china',410000,410900,'台前县'),(410928,'town','china',410000,410900,'濮阳县'),(411000,'city','china',410000,411000,'许昌市'),(411001,'town','china',410000,411000,'市辖区'),(411002,'town','china',410000,411000,'魏都区'),(411023,'town','china',410000,411000,'许昌县'),(411024,'town','china',410000,411000,'鄢陵县'),(411025,'town','china',410000,411000,'襄城县'),(411081,'town','china',410000,411000,'禹州市'),(411082,'town','china',410000,411000,'长葛市'),(411100,'city','china',410000,411100,'漯河市'),(411101,'town','china',410000,411100,'市辖区'),(411102,'town','china',410000,411100,'源汇区'),(411103,'town','china',410000,411100,'郾城区'),(411104,'town','china',410000,411100,'召陵区'),(411121,'town','china',410000,411100,'舞阳县'),(411122,'town','china',410000,411100,'临颍县'),(411200,'city','china',410000,411200,'三门峡市'),(411201,'town','china',410000,411200,'市辖区'),(411202,'town','china',410000,411200,'湖滨区'),(411221,'town','china',410000,411200,'渑池县'),(411222,'town','china',410000,411200,'陕县'),(411224,'town','china',410000,411200,'卢氏县'),(411281,'town','china',410000,411200,'义马市'),(411282,'town','china',410000,411200,'灵宝市'),(411300,'city','china',410000,411300,'南阳市'),(411301,'town','china',410000,411300,'市辖区'),(411302,'town','china',410000,411300,'宛城区'),(411303,'town','china',410000,411300,'卧龙区'),(411321,'town','china',410000,411300,'南召县'),(411322,'town','china',410000,411300,'方城县'),(411323,'town','china',410000,411300,'西峡县'),(411324,'town','china',410000,411300,'镇平县'),(411325,'town','china',410000,411300,'内乡县'),(411326,'town','china',410000,411300,'淅川县'),(411327,'town','china',410000,411300,'社旗县'),(411328,'town','china',410000,411300,'唐河县'),(411329,'town','china',410000,411300,'新野县'),(411330,'town','china',410000,411300,'桐柏县'),(411381,'town','china',410000,411300,'邓州市'),(411400,'city','china',410000,411400,'商丘市'),(411401,'town','china',410000,411400,'市辖区'),(411402,'town','china',410000,411400,'梁园区'),(411403,'town','china',410000,411400,'睢阳区'),(411421,'town','china',410000,411400,'民权县'),(411422,'town','china',410000,411400,'睢县'),(411423,'town','china',410000,411400,'宁陵县'),(411424,'town','china',410000,411400,'柘城县'),(411425,'town','china',410000,411400,'虞城县'),(411426,'town','china',410000,411400,'夏邑县'),(411481,'town','china',410000,411400,'永城市'),(411500,'city','china',410000,411500,'信阳市'),(411501,'town','china',410000,411500,'市辖区'),(411502,'town','china',410000,411500,'浉河区'),(411503,'town','china',410000,411500,'平桥区'),(411521,'town','china',410000,411500,'罗山县'),(411522,'town','china',410000,411500,'光山县'),(411523,'town','china',410000,411500,'新县'),(411524,'town','china',410000,411500,'商城县'),(411525,'town','china',410000,411500,'固始县'),(411526,'town','china',410000,411500,'潢川县'),(411527,'town','china',410000,411500,'淮滨县'),(411528,'town','china',410000,411500,'息县'),(411600,'city','china',410000,411600,'周口市'),(411601,'town','china',410000,411600,'市辖区'),(411602,'town','china',410000,411600,'川汇区'),(411621,'town','china',410000,411600,'扶沟县'),(411622,'town','china',410000,411600,'西华县'),(411623,'town','china',410000,411600,'商水县'),(411624,'town','china',410000,411600,'沈丘县'),(411625,'town','china',410000,411600,'郸城县'),(411626,'town','china',410000,411600,'淮阳县'),(411627,'town','china',410000,411600,'太康县'),(411628,'town','china',410000,411600,'鹿邑县'),(411681,'town','china',410000,411600,'项城市'),(411700,'city','china',410000,411700,'驻马店市'),(411701,'town','china',410000,411700,'市辖区'),(411702,'town','china',410000,411700,'驿城区'),(411721,'town','china',410000,411700,'西平县'),(411722,'town','china',410000,411700,'上蔡县'),(411723,'town','china',410000,411700,'平舆县'),(411724,'town','china',410000,411700,'正阳县'),(411725,'town','china',410000,411700,'确山县'),(411726,'town','china',410000,411700,'泌阳县'),(411727,'town','china',410000,411700,'汝南县'),(411728,'town','china',410000,411700,'遂平县'),(411729,'town','china',410000,411700,'新蔡县'),(419000,'city','china',410000,419000,'省直辖县级行政区划'),(419001,'town','china',410000,419000,'济源市'),(420000,'province','china',420000,0,'湖北省'),(420100,'city','china',420000,420100,'武汉市'),(420101,'town','china',420000,420100,'市辖区'),(420102,'town','china',420000,420100,'江岸区'),(420103,'town','china',420000,420100,'江汉区'),(420104,'town','china',420000,420100,'硚口区'),(420105,'town','china',420000,420100,'汉阳区'),(420106,'town','china',420000,420100,'武昌区'),(420107,'town','china',420000,420100,'青山区'),(420111,'town','china',420000,420100,'洪山区'),(420112,'town','china',420000,420100,'东西湖区'),(420113,'town','china',420000,420100,'汉南区'),(420114,'town','china',420000,420100,'蔡甸区'),(420115,'town','china',420000,420100,'江夏区'),(420116,'town','china',420000,420100,'黄陂区'),(420117,'town','china',420000,420100,'新洲区'),(420200,'city','china',420000,420200,'黄石市'),(420201,'town','china',420000,420200,'市辖区'),(420202,'town','china',420000,420200,'黄石港区'),(420203,'town','china',420000,420200,'西塞山区'),(420204,'town','china',420000,420200,'下陆区'),(420205,'town','china',420000,420200,'铁山区'),(420222,'town','china',420000,420200,'阳新县'),(420281,'town','china',420000,420200,'大冶市'),(420300,'city','china',420000,420300,'十堰市'),(420301,'town','china',420000,420300,'市辖区'),(420302,'town','china',420000,420300,'茅箭区'),(420303,'town','china',420000,420300,'张湾区'),(420304,'town','china',420000,420300,'郧阳区'),(420322,'town','china',420000,420300,'郧西县'),(420323,'town','china',420000,420300,'竹山县'),(420324,'town','china',420000,420300,'竹溪县'),(420325,'town','china',420000,420300,'房县'),(420381,'town','china',420000,420300,'丹江口市'),(420500,'city','china',420000,420500,'宜昌市'),(420501,'town','china',420000,420500,'市辖区'),(420502,'town','china',420000,420500,'西陵区'),(420503,'town','china',420000,420500,'伍家岗区'),(420504,'town','china',420000,420500,'点军区'),(420505,'town','china',420000,420500,'猇亭区'),(420506,'town','china',420000,420500,'夷陵区'),(420525,'town','china',420000,420500,'远安县'),(420526,'town','china',420000,420500,'兴山县'),(420527,'town','china',420000,420500,'秭归县'),(420528,'town','china',420000,420500,'长阳土家族自治县'),(420529,'town','china',420000,420500,'五峰土家族自治县'),(420581,'town','china',420000,420500,'宜都市'),(420582,'town','china',420000,420500,'当阳市'),(420583,'town','china',420000,420500,'枝江市'),(420600,'city','china',420000,420600,'襄阳市'),(420601,'town','china',420000,420600,'市辖区'),(420602,'town','china',420000,420600,'襄城区'),(420606,'town','china',420000,420600,'樊城区'),(420607,'town','china',420000,420600,'襄州区'),(420624,'town','china',420000,420600,'南漳县'),(420625,'town','china',420000,420600,'谷城县'),(420626,'town','china',420000,420600,'保康县'),(420682,'town','china',420000,420600,'老河口市'),(420683,'town','china',420000,420600,'枣阳市'),(420684,'town','china',420000,420600,'宜城市'),(420700,'city','china',420000,420700,'鄂州市'),(420701,'town','china',420000,420700,'市辖区'),(420702,'town','china',420000,420700,'梁子湖区'),(420703,'town','china',420000,420700,'华容区'),(420704,'town','china',420000,420700,'鄂城区'),(420800,'city','china',420000,420800,'荆门市'),(420801,'town','china',420000,420800,'市辖区'),(420802,'town','china',420000,420800,'东宝区'),(420804,'town','china',420000,420800,'掇刀区'),(420821,'town','china',420000,420800,'京山县'),(420822,'town','china',420000,420800,'沙洋县'),(420881,'town','china',420000,420800,'钟祥市'),(420900,'city','china',420000,420900,'孝感市'),(420901,'town','china',420000,420900,'市辖区'),(420902,'town','china',420000,420900,'孝南区'),(420921,'town','china',420000,420900,'孝昌县'),(420922,'town','china',420000,420900,'大悟县'),(420923,'town','china',420000,420900,'云梦县'),(420981,'town','china',420000,420900,'应城市'),(420982,'town','china',420000,420900,'安陆市'),(420984,'town','china',420000,420900,'汉川市'),(421000,'city','china',420000,421000,'荆州市'),(421001,'town','china',420000,421000,'市辖区'),(421002,'town','china',420000,421000,'沙市区'),(421003,'town','china',420000,421000,'荆州区'),(421022,'town','china',420000,421000,'公安县'),(421023,'town','china',420000,421000,'监利县'),(421024,'town','china',420000,421000,'江陵县'),(421081,'town','china',420000,421000,'石首市'),(421083,'town','china',420000,421000,'洪湖市'),(421087,'town','china',420000,421000,'松滋市'),(421100,'city','china',420000,421100,'黄冈市'),(421101,'town','china',420000,421100,'市辖区'),(421102,'town','china',420000,421100,'黄州区'),(421121,'town','china',420000,421100,'团风县'),(421122,'town','china',420000,421100,'红安县'),(421123,'town','china',420000,421100,'罗田县'),(421124,'town','china',420000,421100,'英山县'),(421125,'town','china',420000,421100,'浠水县'),(421126,'town','china',420000,421100,'蕲春县'),(421127,'town','china',420000,421100,'黄梅县'),(421181,'town','china',420000,421100,'麻城市'),(421182,'town','china',420000,421100,'武穴市'),(421200,'city','china',420000,421200,'咸宁市'),(421201,'town','china',420000,421200,'市辖区'),(421202,'town','china',420000,421200,'咸安区'),(421221,'town','china',420000,421200,'嘉鱼县'),(421222,'town','china',420000,421200,'通城县'),(421223,'town','china',420000,421200,'崇阳县'),(421224,'town','china',420000,421200,'通山县'),(421281,'town','china',420000,421200,'赤壁市'),(421300,'city','china',420000,421300,'随州市'),(421301,'town','china',420000,421300,'市辖区'),(421303,'town','china',420000,421300,'曾都区'),(421321,'town','china',420000,421300,'随县'),(421381,'town','china',420000,421300,'广水市'),(422800,'city','china',420000,422800,'恩施土家族苗族自治州'),(422801,'town','china',420000,422800,'恩施市'),(422802,'town','china',420000,422800,'利川市'),(422822,'town','china',420000,422800,'建始县'),(422823,'town','china',420000,422800,'巴东县'),(422825,'town','china',420000,422800,'宣恩县'),(422826,'town','china',420000,422800,'咸丰县'),(422827,'town','china',420000,422800,'来凤县'),(422828,'town','china',420000,422800,'鹤峰县'),(429000,'city','china',420000,429000,'省直辖县级行政区划'),(429004,'town','china',420000,429000,'仙桃市'),(429005,'town','china',420000,429000,'潜江市'),(429006,'town','china',420000,429000,'天门市'),(429021,'town','china',420000,429000,'神农架林区'),(430000,'province','china',430000,0,'湖南省'),(430100,'city','china',430000,430100,'长沙市'),(430101,'town','china',430000,430100,'市辖区'),(430102,'town','china',430000,430100,'芙蓉区'),(430103,'town','china',430000,430100,'天心区'),(430104,'town','china',430000,430100,'岳麓区'),(430105,'town','china',430000,430100,'开福区'),(430111,'town','china',430000,430100,'雨花区'),(430112,'town','china',430000,430100,'望城区'),(430121,'town','china',430000,430100,'长沙县'),(430124,'town','china',430000,430100,'宁乡县'),(430181,'town','china',430000,430100,'浏阳市'),(430200,'city','china',430000,430200,'株洲市'),(430201,'town','china',430000,430200,'市辖区'),(430202,'town','china',430000,430200,'荷塘区'),(430203,'town','china',430000,430200,'芦淞区'),(430204,'town','china',430000,430200,'石峰区'),(430211,'town','china',430000,430200,'天元区'),(430221,'town','china',430000,430200,'株洲县'),(430223,'town','china',430000,430200,'攸县'),(430224,'town','china',430000,430200,'茶陵县'),(430225,'town','china',430000,430200,'炎陵县'),(430281,'town','china',430000,430200,'醴陵市'),(430300,'city','china',430000,430300,'湘潭市'),(430301,'town','china',430000,430300,'市辖区'),(430302,'town','china',430000,430300,'雨湖区'),(430304,'town','china',430000,430300,'岳塘区'),(430321,'town','china',430000,430300,'湘潭县'),(430381,'town','china',430000,430300,'湘乡市'),(430382,'town','china',430000,430300,'韶山市'),(430400,'city','china',430000,430400,'衡阳市'),(430401,'town','china',430000,430400,'市辖区'),(430405,'town','china',430000,430400,'珠晖区'),(430406,'town','china',430000,430400,'雁峰区'),(430407,'town','china',430000,430400,'石鼓区'),(430408,'town','china',430000,430400,'蒸湘区'),(430412,'town','china',430000,430400,'南岳区'),(430421,'town','china',430000,430400,'衡阳县'),(430422,'town','china',430000,430400,'衡南县'),(430423,'town','china',430000,430400,'衡山县'),(430424,'town','china',430000,430400,'衡东县'),(430426,'town','china',430000,430400,'祁东县'),(430481,'town','china',430000,430400,'耒阳市'),(430482,'town','china',430000,430400,'常宁市'),(430500,'city','china',430000,430500,'邵阳市'),(430501,'town','china',430000,430500,'市辖区'),(430502,'town','china',430000,430500,'双清区'),(430503,'town','china',430000,430500,'大祥区'),(430511,'town','china',430000,430500,'北塔区'),(430521,'town','china',430000,430500,'邵东县'),(430522,'town','china',430000,430500,'新邵县'),(430523,'town','china',430000,430500,'邵阳县'),(430524,'town','china',430000,430500,'隆回县'),(430525,'town','china',430000,430500,'洞口县'),(430527,'town','china',430000,430500,'绥宁县'),(430528,'town','china',430000,430500,'新宁县'),(430529,'town','china',430000,430500,'城步苗族自治县'),(430581,'town','china',430000,430500,'武冈市'),(430600,'city','china',430000,430600,'岳阳市'),(430601,'town','china',430000,430600,'市辖区'),(430602,'town','china',430000,430600,'岳阳楼区'),(430603,'town','china',430000,430600,'云溪区'),(430611,'town','china',430000,430600,'君山区'),(430621,'town','china',430000,430600,'岳阳县'),(430623,'town','china',430000,430600,'华容县'),(430624,'town','china',430000,430600,'湘阴县'),(430626,'town','china',430000,430600,'平江县'),(430681,'town','china',430000,430600,'汨罗市'),(430682,'town','china',430000,430600,'临湘市'),(430700,'city','china',430000,430700,'常德市'),(430701,'town','china',430000,430700,'市辖区'),(430702,'town','china',430000,430700,'武陵区'),(430703,'town','china',430000,430700,'鼎城区'),(430721,'town','china',430000,430700,'安乡县'),(430722,'town','china',430000,430700,'汉寿县'),(430723,'town','china',430000,430700,'澧县'),(430724,'town','china',430000,430700,'临澧县'),(430725,'town','china',430000,430700,'桃源县'),(430726,'town','china',430000,430700,'石门县'),(430781,'town','china',430000,430700,'津市市'),(430800,'city','china',430000,430800,'张家界市'),(430801,'town','china',430000,430800,'市辖区'),(430802,'town','china',430000,430800,'永定区'),(430811,'town','china',430000,430800,'武陵源区'),(430821,'town','china',430000,430800,'慈利县'),(430822,'town','china',430000,430800,'桑植县'),(430900,'city','china',430000,430900,'益阳市'),(430901,'town','china',430000,430900,'市辖区'),(430902,'town','china',430000,430900,'资阳区'),(430903,'town','china',430000,430900,'赫山区'),(430921,'town','china',430000,430900,'南县'),(430922,'town','china',430000,430900,'桃江县'),(430923,'town','china',430000,430900,'安化县'),(430981,'town','china',430000,430900,'沅江市'),(431000,'city','china',430000,431000,'郴州市'),(431001,'town','china',430000,431000,'市辖区'),(431002,'town','china',430000,431000,'北湖区'),(431003,'town','china',430000,431000,'苏仙区'),(431021,'town','china',430000,431000,'桂阳县'),(431022,'town','china',430000,431000,'宜章县'),(431023,'town','china',430000,431000,'永兴县'),(431024,'town','china',430000,431000,'嘉禾县'),(431025,'town','china',430000,431000,'临武县'),(431026,'town','china',430000,431000,'汝城县'),(431027,'town','china',430000,431000,'桂东县'),(431028,'town','china',430000,431000,'安仁县'),(431081,'town','china',430000,431000,'资兴市'),(431100,'city','china',430000,431100,'永州市'),(431101,'town','china',430000,431100,'市辖区'),(431102,'town','china',430000,431100,'零陵区'),(431103,'town','china',430000,431100,'冷水滩区'),(431121,'town','china',430000,431100,'祁阳县'),(431122,'town','china',430000,431100,'东安县'),(431123,'town','china',430000,431100,'双牌县'),(431124,'town','china',430000,431100,'道县'),(431125,'town','china',430000,431100,'江永县'),(431126,'town','china',430000,431100,'宁远县'),(431127,'town','china',430000,431100,'蓝山县'),(431128,'town','china',430000,431100,'新田县'),(431129,'town','china',430000,431100,'江华瑶族自治县'),(431200,'city','china',430000,431200,'怀化市'),(431201,'town','china',430000,431200,'市辖区'),(431202,'town','china',430000,431200,'鹤城区'),(431221,'town','china',430000,431200,'中方县'),(431222,'town','china',430000,431200,'沅陵县'),(431223,'town','china',430000,431200,'辰溪县'),(431224,'town','china',430000,431200,'溆浦县'),(431225,'town','china',430000,431200,'会同县'),(431226,'town','china',430000,431200,'麻阳苗族自治县'),(431227,'town','china',430000,431200,'新晃侗族自治县'),(431228,'town','china',430000,431200,'芷江侗族自治县'),(431229,'town','china',430000,431200,'靖州苗族侗族自治县'),(431230,'town','china',430000,431200,'通道侗族自治县'),(431281,'town','china',430000,431200,'洪江市'),(431300,'city','china',430000,431300,'娄底市'),(431301,'town','china',430000,431300,'市辖区'),(431302,'town','china',430000,431300,'娄星区'),(431321,'town','china',430000,431300,'双峰县'),(431322,'town','china',430000,431300,'新化县'),(431381,'town','china',430000,431300,'冷水江市'),(431382,'town','china',430000,431300,'涟源市'),(433100,'city','china',430000,433100,'湘西土家族苗族自治州'),(433101,'town','china',430000,433100,'吉首市'),(433122,'town','china',430000,433100,'泸溪县'),(433123,'town','china',430000,433100,'凤凰县'),(433124,'town','china',430000,433100,'花垣县'),(433125,'town','china',430000,433100,'保靖县'),(433126,'town','china',430000,433100,'古丈县'),(433127,'town','china',430000,433100,'永顺县'),(433130,'town','china',430000,433100,'龙山县'),(440000,'province','china',440000,0,'广东省'),(440100,'city','china',440000,440100,'广州市'),(440101,'town','china',440000,440100,'市辖区'),(440103,'town','china',440000,440100,'荔湾区'),(440104,'town','china',440000,440100,'越秀区'),(440105,'town','china',440000,440100,'海珠区'),(440106,'town','china',440000,440100,'天河区'),(440111,'town','china',440000,440100,'白云区'),(440112,'town','china',440000,440100,'黄埔区'),(440113,'town','china',440000,440100,'番禺区'),(440114,'town','china',440000,440100,'花都区'),(440115,'town','china',440000,440100,'南沙区'),(440117,'town','china',440000,440100,'从化区'),(440118,'town','china',440000,440100,'增城区'),(440200,'city','china',440000,440200,'韶关市'),(440201,'town','china',440000,440200,'市辖区'),(440203,'town','china',440000,440200,'武江区'),(440204,'town','china',440000,440200,'浈江区'),(440205,'town','china',440000,440200,'曲江区'),(440222,'town','china',440000,440200,'始兴县'),(440224,'town','china',440000,440200,'仁化县'),(440229,'town','china',440000,440200,'翁源县'),(440232,'town','china',440000,440200,'乳源瑶族自治县'),(440233,'town','china',440000,440200,'新丰县'),(440281,'town','china',440000,440200,'乐昌市'),(440282,'town','china',440000,440200,'南雄市'),(440300,'city','china',440000,440300,'深圳市'),(440301,'town','china',440000,440300,'市辖区'),(440303,'town','china',440000,440300,'罗湖区'),(440304,'town','china',440000,440300,'福田区'),(440305,'town','china',440000,440300,'南山区'),(440306,'town','china',440000,440300,'宝安区'),(440307,'town','china',440000,440300,'龙岗区'),(440308,'town','china',440000,440300,'盐田区'),(440400,'city','china',440000,440400,'珠海市'),(440401,'town','china',440000,440400,'市辖区'),(440402,'town','china',440000,440400,'香洲区'),(440403,'town','china',440000,440400,'斗门区'),(440404,'town','china',440000,440400,'金湾区'),(440500,'city','china',440000,440500,'汕头市'),(440501,'town','china',440000,440500,'市辖区'),(440507,'town','china',440000,440500,'龙湖区'),(440511,'town','china',440000,440500,'金平区'),(440512,'town','china',440000,440500,'濠江区'),(440513,'town','china',440000,440500,'潮阳区'),(440514,'town','china',440000,440500,'潮南区'),(440515,'town','china',440000,440500,'澄海区'),(440523,'town','china',440000,440500,'南澳县'),(440600,'city','china',440000,440600,'佛山市'),(440601,'town','china',440000,440600,'市辖区'),(440604,'town','china',440000,440600,'禅城区'),(440605,'town','china',440000,440600,'南海区'),(440606,'town','china',440000,440600,'顺德区'),(440607,'town','china',440000,440600,'三水区'),(440608,'town','china',440000,440600,'高明区'),(440700,'city','china',440000,440700,'江门市'),(440701,'town','china',440000,440700,'市辖区'),(440703,'town','china',440000,440700,'蓬江区'),(440704,'town','china',440000,440700,'江海区'),(440705,'town','china',440000,440700,'新会区'),(440781,'town','china',440000,440700,'台山市'),(440783,'town','china',440000,440700,'开平市'),(440784,'town','china',440000,440700,'鹤山市'),(440785,'town','china',440000,440700,'恩平市'),(440800,'city','china',440000,440800,'湛江市'),(440801,'town','china',440000,440800,'市辖区'),(440802,'town','china',440000,440800,'赤坎区'),(440803,'town','china',440000,440800,'霞山区'),(440804,'town','china',440000,440800,'坡头区'),(440811,'town','china',440000,440800,'麻章区'),(440823,'town','china',440000,440800,'遂溪县'),(440825,'town','china',440000,440800,'徐闻县'),(440881,'town','china',440000,440800,'廉江市'),(440882,'town','china',440000,440800,'雷州市'),(440883,'town','china',440000,440800,'吴川市'),(440900,'city','china',440000,440900,'茂名市'),(440901,'town','china',440000,440900,'市辖区'),(440902,'town','china',440000,440900,'茂南区'),(440904,'town','china',440000,440900,'电白区'),(440981,'town','china',440000,440900,'高州市'),(440982,'town','china',440000,440900,'化州市'),(440983,'town','china',440000,440900,'信宜市'),(441200,'city','china',440000,441200,'肇庆市'),(441201,'town','china',440000,441200,'市辖区'),(441202,'town','china',440000,441200,'端州区'),(441203,'town','china',440000,441200,'鼎湖区'),(441204,'town','china',440000,441200,'高要区'),(441223,'town','china',440000,441200,'广宁县'),(441224,'town','china',440000,441200,'怀集县'),(441225,'town','china',440000,441200,'封开县'),(441226,'town','china',440000,441200,'德庆县'),(441284,'town','china',440000,441200,'四会市'),(441300,'city','china',440000,441300,'惠州市'),(441301,'town','china',440000,441300,'市辖区'),(441302,'town','china',440000,441300,'惠城区'),(441303,'town','china',440000,441300,'惠阳区'),(441322,'town','china',440000,441300,'博罗县'),(441323,'town','china',440000,441300,'惠东县'),(441324,'town','china',440000,441300,'龙门县'),(441400,'city','china',440000,441400,'梅州市'),(441401,'town','china',440000,441400,'市辖区'),(441402,'town','china',440000,441400,'梅江区'),(441403,'town','china',440000,441400,'梅县区'),(441422,'town','china',440000,441400,'大埔县'),(441423,'town','china',440000,441400,'丰顺县'),(441424,'town','china',440000,441400,'五华县'),(441426,'town','china',440000,441400,'平远县'),(441427,'town','china',440000,441400,'蕉岭县'),(441481,'town','china',440000,441400,'兴宁市'),(441500,'city','china',440000,441500,'汕尾市'),(441501,'town','china',440000,441500,'市辖区'),(441502,'town','china',440000,441500,'城区'),(441521,'town','china',440000,441500,'海丰县'),(441523,'town','china',440000,441500,'陆河县'),(441581,'town','china',440000,441500,'陆丰市'),(441600,'city','china',440000,441600,'河源市'),(441601,'town','china',440000,441600,'市辖区'),(441602,'town','china',440000,441600,'源城区'),(441621,'town','china',440000,441600,'紫金县'),(441622,'town','china',440000,441600,'龙川县'),(441623,'town','china',440000,441600,'连平县'),(441624,'town','china',440000,441600,'和平县'),(441625,'town','china',440000,441600,'东源县'),(441700,'city','china',440000,441700,'阳江市'),(441701,'town','china',440000,441700,'市辖区'),(441702,'town','china',440000,441700,'江城区'),(441704,'town','china',440000,441700,'阳东区'),(441721,'town','china',440000,441700,'阳西县'),(441781,'town','china',440000,441700,'阳春市'),(441800,'city','china',440000,441800,'清远市'),(441801,'town','china',440000,441800,'市辖区'),(441802,'town','china',440000,441800,'清城区'),(441803,'town','china',440000,441800,'清新区'),(441821,'town','china',440000,441800,'佛冈县'),(441823,'town','china',440000,441800,'阳山县'),(441825,'town','china',440000,441800,'连山壮族瑶族自治县'),(441826,'town','china',440000,441800,'连南瑶族自治县'),(441881,'town','china',440000,441800,'英德市'),(441882,'town','china',440000,441800,'连州市'),(441900,'city','china',440000,441900,'东莞市'),(442000,'city','china',440000,442000,'中山市'),(445100,'city','china',440000,445100,'潮州市'),(445101,'town','china',440000,445100,'市辖区'),(445102,'town','china',440000,445100,'湘桥区'),(445103,'town','china',440000,445100,'潮安区'),(445122,'town','china',440000,445100,'饶平县'),(445200,'city','china',440000,445200,'揭阳市'),(445201,'town','china',440000,445200,'市辖区'),(445202,'town','china',440000,445200,'榕城区'),(445203,'town','china',440000,445200,'揭东区'),(445222,'town','china',440000,445200,'揭西县'),(445224,'town','china',440000,445200,'惠来县'),(445281,'town','china',440000,445200,'普宁市'),(445300,'city','china',440000,445300,'云浮市'),(445301,'town','china',440000,445300,'市辖区'),(445302,'town','china',440000,445300,'云城区'),(445303,'town','china',440000,445300,'云安区'),(445321,'town','china',440000,445300,'新兴县'),(445322,'town','china',440000,445300,'郁南县'),(445381,'town','china',440000,445300,'罗定市'),(450000,'province','china',450000,0,'广西壮族自治区'),(450100,'city','china',450000,450100,'南宁市'),(450101,'town','china',450000,450100,'市辖区'),(450102,'town','china',450000,450100,'兴宁区'),(450103,'town','china',450000,450100,'青秀区'),(450105,'town','china',450000,450100,'江南区'),(450107,'town','china',450000,450100,'西乡塘区'),(450108,'town','china',450000,450100,'良庆区'),(450109,'town','china',450000,450100,'邕宁区'),(450110,'town','china',450000,450100,'武鸣区'),(450123,'town','china',450000,450100,'隆安县'),(450124,'town','china',450000,450100,'马山县'),(450125,'town','china',450000,450100,'上林县'),(450126,'town','china',450000,450100,'宾阳县'),(450127,'town','china',450000,450100,'横县'),(450200,'city','china',450000,450200,'柳州市'),(450201,'town','china',450000,450200,'市辖区'),(450202,'town','china',450000,450200,'城中区'),(450203,'town','china',450000,450200,'鱼峰区'),(450204,'town','china',450000,450200,'柳南区'),(450205,'town','china',450000,450200,'柳北区'),(450221,'town','china',450000,450200,'柳江县'),(450222,'town','china',450000,450200,'柳城县'),(450223,'town','china',450000,450200,'鹿寨县'),(450224,'town','china',450000,450200,'融安县'),(450225,'town','china',450000,450200,'融水苗族自治县'),(450226,'town','china',450000,450200,'三江侗族自治县'),(450300,'city','china',450000,450300,'桂林市'),(450301,'town','china',450000,450300,'市辖区'),(450302,'town','china',450000,450300,'秀峰区'),(450303,'town','china',450000,450300,'叠彩区'),(450304,'town','china',450000,450300,'象山区'),(450305,'town','china',450000,450300,'七星区'),(450311,'town','china',450000,450300,'雁山区'),(450312,'town','china',450000,450300,'临桂区'),(450321,'town','china',450000,450300,'阳朔县'),(450323,'town','china',450000,450300,'灵川县'),(450324,'town','china',450000,450300,'全州县'),(450325,'town','china',450000,450300,'兴安县'),(450326,'town','china',450000,450300,'永福县'),(450327,'town','china',450000,450300,'灌阳县'),(450328,'town','china',450000,450300,'龙胜各族自治县'),(450329,'town','china',450000,450300,'资源县'),(450330,'town','china',450000,450300,'平乐县'),(450331,'town','china',450000,450300,'荔浦县'),(450332,'town','china',450000,450300,'恭城瑶族自治县'),(450400,'city','china',450000,450400,'梧州市'),(450401,'town','china',450000,450400,'市辖区'),(450403,'town','china',450000,450400,'万秀区'),(450405,'town','china',450000,450400,'长洲区'),(450406,'town','china',450000,450400,'龙圩区'),(450421,'town','china',450000,450400,'苍梧县'),(450422,'town','china',450000,450400,'藤县'),(450423,'town','china',450000,450400,'蒙山县'),(450481,'town','china',450000,450400,'岑溪市'),(450500,'city','china',450000,450500,'北海市'),(450501,'town','china',450000,450500,'市辖区'),(450502,'town','china',450000,450500,'海城区'),(450503,'town','china',450000,450500,'银海区'),(450512,'town','china',450000,450500,'铁山港区'),(450521,'town','china',450000,450500,'合浦县'),(450600,'city','china',450000,450600,'防城港市'),(450601,'town','china',450000,450600,'市辖区'),(450602,'town','china',450000,450600,'港口区'),(450603,'town','china',450000,450600,'防城区'),(450621,'town','china',450000,450600,'上思县'),(450681,'town','china',450000,450600,'东兴市'),(450700,'city','china',450000,450700,'钦州市'),(450701,'town','china',450000,450700,'市辖区'),(450702,'town','china',450000,450700,'钦南区'),(450703,'town','china',450000,450700,'钦北区'),(450721,'town','china',450000,450700,'灵山县'),(450722,'town','china',450000,450700,'浦北县'),(450800,'city','china',450000,450800,'贵港市'),(450801,'town','china',450000,450800,'市辖区'),(450802,'town','china',450000,450800,'港北区'),(450803,'town','china',450000,450800,'港南区'),(450804,'town','china',450000,450800,'覃塘区'),(450821,'town','china',450000,450800,'平南县'),(450881,'town','china',450000,450800,'桂平市'),(450900,'city','china',450000,450900,'玉林市'),(450901,'town','china',450000,450900,'市辖区'),(450902,'town','china',450000,450900,'玉州区'),(450903,'town','china',450000,450900,'福绵区'),(450921,'town','china',450000,450900,'容县'),(450922,'town','china',450000,450900,'陆川县'),(450923,'town','china',450000,450900,'博白县'),(450924,'town','china',450000,450900,'兴业县'),(450981,'town','china',450000,450900,'北流市'),(451000,'city','china',450000,451000,'百色市'),(451001,'town','china',450000,451000,'市辖区'),(451002,'town','china',450000,451000,'右江区'),(451021,'town','china',450000,451000,'田阳县'),(451022,'town','china',450000,451000,'田东县'),(451023,'town','china',450000,451000,'平果县'),(451024,'town','china',450000,451000,'德保县'),(451026,'town','china',450000,451000,'那坡县'),(451027,'town','china',450000,451000,'凌云县'),(451028,'town','china',450000,451000,'乐业县'),(451029,'town','china',450000,451000,'田林县'),(451030,'town','china',450000,451000,'西林县'),(451031,'town','china',450000,451000,'隆林各族自治县'),(451081,'town','china',450000,451000,'靖西市'),(451100,'city','china',450000,451100,'贺州市'),(451101,'town','china',450000,451100,'市辖区'),(451102,'town','china',450000,451100,'八步区'),(451121,'town','china',450000,451100,'昭平县'),(451122,'town','china',450000,451100,'钟山县'),(451123,'town','china',450000,451100,'富川瑶族自治县'),(451200,'city','china',450000,451200,'河池市'),(451201,'town','china',450000,451200,'市辖区'),(451202,'town','china',450000,451200,'金城江区'),(451221,'town','china',450000,451200,'南丹县'),(451222,'town','china',450000,451200,'天峨县'),(451223,'town','china',450000,451200,'凤山县'),(451224,'town','china',450000,451200,'东兰县'),(451225,'town','china',450000,451200,'罗城仫佬族自治县'),(451226,'town','china',450000,451200,'环江毛南族自治县'),(451227,'town','china',450000,451200,'巴马瑶族自治县'),(451228,'town','china',450000,451200,'都安瑶族自治县'),(451229,'town','china',450000,451200,'大化瑶族自治县'),(451281,'town','china',450000,451200,'宜州市'),(451300,'city','china',450000,451300,'来宾市'),(451301,'town','china',450000,451300,'市辖区'),(451302,'town','china',450000,451300,'兴宾区'),(451321,'town','china',450000,451300,'忻城县'),(451322,'town','china',450000,451300,'象州县'),(451323,'town','china',450000,451300,'武宣县'),(451324,'town','china',450000,451300,'金秀瑶族自治县'),(451381,'town','china',450000,451300,'合山市'),(451400,'city','china',450000,451400,'崇左市'),(451401,'town','china',450000,451400,'市辖区'),(451402,'town','china',450000,451400,'江州区'),(451421,'town','china',450000,451400,'扶绥县'),(451422,'town','china',450000,451400,'宁明县'),(451423,'town','china',450000,451400,'龙州县'),(451424,'town','china',450000,451400,'大新县'),(451425,'town','china',450000,451400,'天等县'),(451481,'town','china',450000,451400,'凭祥市'),(460000,'province','china',460000,0,'海南省'),(460100,'city','china',460000,460100,'海口市'),(460101,'town','china',460000,460100,'市辖区'),(460105,'town','china',460000,460100,'秀英区'),(460106,'town','china',460000,460100,'龙华区'),(460107,'town','china',460000,460100,'琼山区'),(460108,'town','china',460000,460100,'美兰区'),(460200,'city','china',460000,460200,'三亚市'),(460201,'town','china',460000,460200,'市辖区'),(460202,'town','china',460000,460200,'海棠区'),(460203,'town','china',460000,460200,'吉阳区'),(460204,'town','china',460000,460200,'天涯区'),(460205,'town','china',460000,460200,'崖州区'),(460300,'city','china',460000,460300,'三沙市'),(460321,'town','china',460000,460300,'西沙群岛'),(460322,'town','china',460000,460300,'南沙群岛'),(460323,'town','china',460000,460300,'中沙群岛的岛礁及其海域'),(469000,'city','china',460000,469000,'省直辖县级行政区划'),(469001,'town','china',460000,469000,'五指山市'),(469002,'town','china',460000,469000,'琼海市'),(469003,'town','china',460000,469000,'儋州市'),(469005,'town','china',460000,469000,'文昌市'),(469006,'town','china',460000,469000,'万宁市'),(469007,'town','china',460000,469000,'东方市'),(469021,'town','china',460000,469000,'定安县'),(469022,'town','china',460000,469000,'屯昌县'),(469023,'town','china',460000,469000,'澄迈县'),(469024,'town','china',460000,469000,'临高县'),(469025,'town','china',460000,469000,'白沙黎族自治县'),(469026,'town','china',460000,469000,'昌江黎族自治县'),(469027,'town','china',460000,469000,'乐东黎族自治县'),(469028,'town','china',460000,469000,'陵水黎族自治县'),(469029,'town','china',460000,469000,'保亭黎族苗族自治县'),(469030,'town','china',460000,469000,'琼中黎族苗族自治县'),(500000,'province','china',500000,0,'重庆市'),(500100,'city','china',500000,500100,'市辖区'),(500101,'town','china',500000,500100,'万州区'),(500102,'town','china',500000,500100,'涪陵区'),(500103,'town','china',500000,500100,'渝中区'),(500104,'town','china',500000,500100,'大渡口区'),(500105,'town','china',500000,500100,'江北区'),(500106,'town','china',500000,500100,'沙坪坝区'),(500107,'town','china',500000,500100,'九龙坡区'),(500108,'town','china',500000,500100,'南岸区'),(500109,'town','china',500000,500100,'北碚区'),(500110,'town','china',500000,500100,'綦江区'),(500111,'town','china',500000,500100,'大足区'),(500112,'town','china',500000,500100,'渝北区'),(500113,'town','china',500000,500100,'巴南区'),(500114,'town','china',500000,500100,'黔江区'),(500115,'town','china',500000,500100,'长寿区'),(500116,'town','china',500000,500100,'江津区'),(500117,'town','china',500000,500100,'合川区'),(500118,'town','china',500000,500100,'永川区'),(500119,'town','china',500000,500100,'南川区'),(500120,'town','china',500000,500100,'璧山区'),(500151,'town','china',500000,500100,'铜梁区'),(500152,'town','china',500000,500100,'潼南区'),(500153,'town','china',500000,500100,'荣昌区'),(500200,'city','china',500000,500200,'县'),(500228,'town','china',500000,500200,'梁平县'),(500229,'town','china',500000,500200,'城口县'),(500230,'town','china',500000,500200,'丰都县'),(500231,'town','china',500000,500200,'垫江县'),(500232,'town','china',500000,500200,'武隆县'),(500233,'town','china',500000,500200,'忠县'),(500234,'town','china',500000,500200,'开县'),(500235,'town','china',500000,500200,'云阳县'),(500236,'town','china',500000,500200,'奉节县'),(500237,'town','china',500000,500200,'巫山县'),(500238,'town','china',500000,500200,'巫溪县'),(500240,'town','china',500000,500200,'石柱土家族自治县'),(500241,'town','china',500000,500200,'秀山土家族苗族自治县'),(500242,'town','china',500000,500200,'酉阳土家族苗族自治县'),(500243,'town','china',500000,500200,'彭水苗族土家族自治县'),(510000,'province','china',510000,0,'四川省'),(510100,'city','china',510000,510100,'成都市'),(510101,'town','china',510000,510100,'市辖区'),(510104,'town','china',510000,510100,'锦江区'),(510105,'town','china',510000,510100,'青羊区'),(510106,'town','china',510000,510100,'金牛区'),(510107,'town','china',510000,510100,'武侯区'),(510108,'town','china',510000,510100,'成华区'),(510112,'town','china',510000,510100,'龙泉驿区'),(510113,'town','china',510000,510100,'青白江区'),(510114,'town','china',510000,510100,'新都区'),(510115,'town','china',510000,510100,'温江区'),(510121,'town','china',510000,510100,'金堂县'),(510122,'town','china',510000,510100,'双流县'),(510124,'town','china',510000,510100,'郫县'),(510129,'town','china',510000,510100,'大邑县'),(510131,'town','china',510000,510100,'蒲江县'),(510132,'town','china',510000,510100,'新津县'),(510181,'town','china',510000,510100,'都江堰市'),(510182,'town','china',510000,510100,'彭州市'),(510183,'town','china',510000,510100,'邛崃市'),(510184,'town','china',510000,510100,'崇州市'),(510300,'city','china',510000,510300,'自贡市'),(510301,'town','china',510000,510300,'市辖区'),(510302,'town','china',510000,510300,'自流井区'),(510303,'town','china',510000,510300,'贡井区'),(510304,'town','china',510000,510300,'大安区'),(510311,'town','china',510000,510300,'沿滩区'),(510321,'town','china',510000,510300,'荣县'),(510322,'town','china',510000,510300,'富顺县'),(510400,'city','china',510000,510400,'攀枝花市'),(510401,'town','china',510000,510400,'市辖区'),(510402,'town','china',510000,510400,'东区'),(510403,'town','china',510000,510400,'西区'),(510411,'town','china',510000,510400,'仁和区'),(510421,'town','china',510000,510400,'米易县'),(510422,'town','china',510000,510400,'盐边县'),(510500,'city','china',510000,510500,'泸州市'),(510501,'town','china',510000,510500,'市辖区'),(510502,'town','china',510000,510500,'江阳区'),(510503,'town','china',510000,510500,'纳溪区'),(510504,'town','china',510000,510500,'龙马潭区'),(510521,'town','china',510000,510500,'泸县'),(510522,'town','china',510000,510500,'合江县'),(510524,'town','china',510000,510500,'叙永县'),(510525,'town','china',510000,510500,'古蔺县'),(510600,'city','china',510000,510600,'德阳市'),(510601,'town','china',510000,510600,'市辖区'),(510603,'town','china',510000,510600,'旌阳区'),(510623,'town','china',510000,510600,'中江县'),(510626,'town','china',510000,510600,'罗江县'),(510681,'town','china',510000,510600,'广汉市'),(510682,'town','china',510000,510600,'什邡市'),(510683,'town','china',510000,510600,'绵竹市'),(510700,'city','china',510000,510700,'绵阳市'),(510701,'town','china',510000,510700,'市辖区'),(510703,'town','china',510000,510700,'涪城区'),(510704,'town','china',510000,510700,'游仙区'),(510722,'town','china',510000,510700,'三台县'),(510723,'town','china',510000,510700,'盐亭县'),(510724,'town','china',510000,510700,'安县'),(510725,'town','china',510000,510700,'梓潼县'),(510726,'town','china',510000,510700,'北川羌族自治县'),(510727,'town','china',510000,510700,'平武县'),(510781,'town','china',510000,510700,'江油市'),(510800,'city','china',510000,510800,'广元市'),(510801,'town','china',510000,510800,'市辖区'),(510802,'town','china',510000,510800,'利州区'),(510811,'town','china',510000,510800,'昭化区'),(510812,'town','china',510000,510800,'朝天区'),(510821,'town','china',510000,510800,'旺苍县'),(510822,'town','china',510000,510800,'青川县'),(510823,'town','china',510000,510800,'剑阁县'),(510824,'town','china',510000,510800,'苍溪县'),(510900,'city','china',510000,510900,'遂宁市'),(510901,'town','china',510000,510900,'市辖区'),(510903,'town','china',510000,510900,'船山区'),(510904,'town','china',510000,510900,'安居区'),(510921,'town','china',510000,510900,'蓬溪县'),(510922,'town','china',510000,510900,'射洪县'),(510923,'town','china',510000,510900,'大英县'),(511000,'city','china',510000,511000,'内江市'),(511001,'town','china',510000,511000,'市辖区'),(511002,'town','china',510000,511000,'市中区'),(511011,'town','china',510000,511000,'东兴区'),(511024,'town','china',510000,511000,'威远县'),(511025,'town','china',510000,511000,'资中县'),(511028,'town','china',510000,511000,'隆昌县'),(511100,'city','china',510000,511100,'乐山市'),(511101,'town','china',510000,511100,'市辖区'),(511102,'town','china',510000,511100,'市中区'),(511111,'town','china',510000,511100,'沙湾区'),(511112,'town','china',510000,511100,'五通桥区'),(511113,'town','china',510000,511100,'金口河区'),(511123,'town','china',510000,511100,'犍为县'),(511124,'town','china',510000,511100,'井研县'),(511126,'town','china',510000,511100,'夹江县'),(511129,'town','china',510000,511100,'沐川县'),(511132,'town','china',510000,511100,'峨边彝族自治县'),(511133,'town','china',510000,511100,'马边彝族自治县'),(511181,'town','china',510000,511100,'峨眉山市'),(511300,'city','china',510000,511300,'南充市'),(511301,'town','china',510000,511300,'市辖区'),(511302,'town','china',510000,511300,'顺庆区'),(511303,'town','china',510000,511300,'高坪区'),(511304,'town','china',510000,511300,'嘉陵区'),(511321,'town','china',510000,511300,'南部县'),(511322,'town','china',510000,511300,'营山县'),(511323,'town','china',510000,511300,'蓬安县'),(511324,'town','china',510000,511300,'仪陇县'),(511325,'town','china',510000,511300,'西充县'),(511381,'town','china',510000,511300,'阆中市'),(511400,'city','china',510000,511400,'眉山市'),(511401,'town','china',510000,511400,'市辖区'),(511402,'town','china',510000,511400,'东坡区'),(511403,'town','china',510000,511400,'彭山区'),(511421,'town','china',510000,511400,'仁寿县'),(511423,'town','china',510000,511400,'洪雅县'),(511424,'town','china',510000,511400,'丹棱县'),(511425,'town','china',510000,511400,'青神县'),(511500,'city','china',510000,511500,'宜宾市'),(511501,'town','china',510000,511500,'市辖区'),(511502,'town','china',510000,511500,'翠屏区'),(511503,'town','china',510000,511500,'南溪区'),(511521,'town','china',510000,511500,'宜宾县'),(511523,'town','china',510000,511500,'江安县'),(511524,'town','china',510000,511500,'长宁县'),(511525,'town','china',510000,511500,'高县'),(511526,'town','china',510000,511500,'珙县'),(511527,'town','china',510000,511500,'筠连县'),(511528,'town','china',510000,511500,'兴文县'),(511529,'town','china',510000,511500,'屏山县'),(511600,'city','china',510000,511600,'广安市'),(511601,'town','china',510000,511600,'市辖区'),(511602,'town','china',510000,511600,'广安区'),(511603,'town','china',510000,511600,'前锋区'),(511621,'town','china',510000,511600,'岳池县'),(511622,'town','china',510000,511600,'武胜县'),(511623,'town','china',510000,511600,'邻水县'),(511681,'town','china',510000,511600,'华蓥市'),(511700,'city','china',510000,511700,'达州市'),(511701,'town','china',510000,511700,'市辖区'),(511702,'town','china',510000,511700,'通川区'),(511703,'town','china',510000,511700,'达川区'),(511722,'town','china',510000,511700,'宣汉县'),(511723,'town','china',510000,511700,'开江县'),(511724,'town','china',510000,511700,'大竹县'),(511725,'town','china',510000,511700,'渠县'),(511781,'town','china',510000,511700,'万源市'),(511800,'city','china',510000,511800,'雅安市'),(511801,'town','china',510000,511800,'市辖区'),(511802,'town','china',510000,511800,'雨城区'),(511803,'town','china',510000,511800,'名山区'),(511822,'town','china',510000,511800,'荥经县'),(511823,'town','china',510000,511800,'汉源县'),(511824,'town','china',510000,511800,'石棉县'),(511825,'town','china',510000,511800,'天全县'),(511826,'town','china',510000,511800,'芦山县'),(511827,'town','china',510000,511800,'宝兴县'),(511900,'city','china',510000,511900,'巴中市'),(511901,'town','china',510000,511900,'市辖区'),(511902,'town','china',510000,511900,'巴州区'),(511903,'town','china',510000,511900,'恩阳区'),(511921,'town','china',510000,511900,'通江县'),(511922,'town','china',510000,511900,'南江县'),(511923,'town','china',510000,511900,'平昌县'),(512000,'city','china',510000,512000,'资阳市'),(512001,'town','china',510000,512000,'市辖区'),(512002,'town','china',510000,512000,'雁江区'),(512021,'town','china',510000,512000,'安岳县'),(512022,'town','china',510000,512000,'乐至县'),(512081,'town','china',510000,512000,'简阳市'),(513200,'city','china',510000,513200,'阿坝藏族羌族自治州'),(513221,'town','china',510000,513200,'汶川县'),(513222,'town','china',510000,513200,'理县'),(513223,'town','china',510000,513200,'茂县'),(513224,'town','china',510000,513200,'松潘县'),(513225,'town','china',510000,513200,'九寨沟县'),(513226,'town','china',510000,513200,'金川县'),(513227,'town','china',510000,513200,'小金县'),(513228,'town','china',510000,513200,'黑水县'),(513229,'town','china',510000,513200,'马尔康县'),(513230,'town','china',510000,513200,'壤塘县'),(513231,'town','china',510000,513200,'阿坝县'),(513232,'town','china',510000,513200,'若尔盖县'),(513233,'town','china',510000,513200,'红原县'),(513300,'city','china',510000,513300,'甘孜藏族自治州'),(513301,'town','china',510000,513300,'康定市'),(513322,'town','china',510000,513300,'泸定县'),(513323,'town','china',510000,513300,'丹巴县'),(513324,'town','china',510000,513300,'九龙县'),(513325,'town','china',510000,513300,'雅江县'),(513326,'town','china',510000,513300,'道孚县'),(513327,'town','china',510000,513300,'炉霍县'),(513328,'town','china',510000,513300,'甘孜县'),(513329,'town','china',510000,513300,'新龙县'),(513330,'town','china',510000,513300,'德格县'),(513331,'town','china',510000,513300,'白玉县'),(513332,'town','china',510000,513300,'石渠县'),(513333,'town','china',510000,513300,'色达县'),(513334,'town','china',510000,513300,'理塘县'),(513335,'town','china',510000,513300,'巴塘县'),(513336,'town','china',510000,513300,'乡城县'),(513337,'town','china',510000,513300,'稻城县'),(513338,'town','china',510000,513300,'得荣县'),(513400,'city','china',510000,513400,'凉山彝族自治州'),(513401,'town','china',510000,513400,'西昌市'),(513422,'town','china',510000,513400,'木里藏族自治县'),(513423,'town','china',510000,513400,'盐源县'),(513424,'town','china',510000,513400,'德昌县'),(513425,'town','china',510000,513400,'会理县'),(513426,'town','china',510000,513400,'会东县'),(513427,'town','china',510000,513400,'宁南县'),(513428,'town','china',510000,513400,'普格县'),(513429,'town','china',510000,513400,'布拖县'),(513430,'town','china',510000,513400,'金阳县'),(513431,'town','china',510000,513400,'昭觉县'),(513432,'town','china',510000,513400,'喜德县'),(513433,'town','china',510000,513400,'冕宁县'),(513434,'town','china',510000,513400,'越西县'),(513435,'town','china',510000,513400,'甘洛县'),(513436,'town','china',510000,513400,'美姑县'),(513437,'town','china',510000,513400,'雷波县'),(520000,'province','china',520000,0,'贵州省'),(520100,'city','china',520000,520100,'贵阳市'),(520101,'town','china',520000,520100,'市辖区'),(520102,'town','china',520000,520100,'南明区'),(520103,'town','china',520000,520100,'云岩区'),(520111,'town','china',520000,520100,'花溪区'),(520112,'town','china',520000,520100,'乌当区'),(520113,'town','china',520000,520100,'白云区'),(520115,'town','china',520000,520100,'观山湖区'),(520121,'town','china',520000,520100,'开阳县'),(520122,'town','china',520000,520100,'息烽县'),(520123,'town','china',520000,520100,'修文县'),(520181,'town','china',520000,520100,'清镇市'),(520200,'city','china',520000,520200,'六盘水市'),(520201,'town','china',520000,520200,'钟山区'),(520203,'town','china',520000,520200,'六枝特区'),(520221,'town','china',520000,520200,'水城县'),(520222,'town','china',520000,520200,'盘县'),(520300,'city','china',520000,520300,'遵义市'),(520301,'town','china',520000,520300,'市辖区'),(520302,'town','china',520000,520300,'红花岗区'),(520303,'town','china',520000,520300,'汇川区'),(520321,'town','china',520000,520300,'遵义县'),(520322,'town','china',520000,520300,'桐梓县'),(520323,'town','china',520000,520300,'绥阳县'),(520324,'town','china',520000,520300,'正安县'),(520325,'town','china',520000,520300,'道真仡佬族苗族自治县'),(520326,'town','china',520000,520300,'务川仡佬族苗族自治县'),(520327,'town','china',520000,520300,'凤冈县'),(520328,'town','china',520000,520300,'湄潭县'),(520329,'town','china',520000,520300,'余庆县'),(520330,'town','china',520000,520300,'习水县'),(520381,'town','china',520000,520300,'赤水市'),(520382,'town','china',520000,520300,'仁怀市'),(520400,'city','china',520000,520400,'安顺市'),(520401,'town','china',520000,520400,'市辖区'),(520402,'town','china',520000,520400,'西秀区'),(520403,'town','china',520000,520400,'平坝区'),(520422,'town','china',520000,520400,'普定县'),(520423,'town','china',520000,520400,'镇宁布依族苗族自治县'),(520424,'town','china',520000,520400,'关岭布依族苗族自治县'),(520425,'town','china',520000,520400,'紫云苗族布依族自治县'),(520500,'city','china',520000,520500,'毕节市'),(520501,'town','china',520000,520500,'市辖区'),(520502,'town','china',520000,520500,'七星关区'),(520521,'town','china',520000,520500,'大方县'),(520522,'town','china',520000,520500,'黔西县'),(520523,'town','china',520000,520500,'金沙县'),(520524,'town','china',520000,520500,'织金县'),(520525,'town','china',520000,520500,'纳雍县'),(520526,'town','china',520000,520500,'威宁彝族回族苗族自治县'),(520527,'town','china',520000,520500,'赫章县'),(520600,'city','china',520000,520600,'铜仁市'),(520601,'town','china',520000,520600,'市辖区'),(520602,'town','china',520000,520600,'碧江区'),(520603,'town','china',520000,520600,'万山区'),(520621,'town','china',520000,520600,'江口县'),(520622,'town','china',520000,520600,'玉屏侗族自治县'),(520623,'town','china',520000,520600,'石阡县'),(520624,'town','china',520000,520600,'思南县'),(520625,'town','china',520000,520600,'印江土家族苗族自治县'),(520626,'town','china',520000,520600,'德江县'),(520627,'town','china',520000,520600,'沿河土家族自治县'),(520628,'town','china',520000,520600,'松桃苗族自治县'),(522300,'city','china',520000,522300,'黔西南布依族苗族自治州'),(522301,'town','china',520000,522300,'兴义市'),(522322,'town','china',520000,522300,'兴仁县'),(522323,'town','china',520000,522300,'普安县'),(522324,'town','china',520000,522300,'晴隆县'),(522325,'town','china',520000,522300,'贞丰县'),(522326,'town','china',520000,522300,'望谟县'),(522327,'town','china',520000,522300,'册亨县'),(522328,'town','china',520000,522300,'安龙县'),(522600,'city','china',520000,522600,'黔东南苗族侗族自治州'),(522601,'town','china',520000,522600,'凯里市'),(522622,'town','china',520000,522600,'黄平县'),(522623,'town','china',520000,522600,'施秉县'),(522624,'town','china',520000,522600,'三穗县'),(522625,'town','china',520000,522600,'镇远县'),(522626,'town','china',520000,522600,'岑巩县'),(522627,'town','china',520000,522600,'天柱县'),(522628,'town','china',520000,522600,'锦屏县'),(522629,'town','china',520000,522600,'剑河县'),(522630,'town','china',520000,522600,'台江县'),(522631,'town','china',520000,522600,'黎平县'),(522632,'town','china',520000,522600,'榕江县'),(522633,'town','china',520000,522600,'从江县'),(522634,'town','china',520000,522600,'雷山县'),(522635,'town','china',520000,522600,'麻江县'),(522636,'town','china',520000,522600,'丹寨县'),(522700,'city','china',520000,522700,'黔南布依族苗族自治州'),(522701,'town','china',520000,522700,'都匀市'),(522702,'town','china',520000,522700,'福泉市'),(522722,'town','china',520000,522700,'荔波县'),(522723,'town','china',520000,522700,'贵定县'),(522725,'town','china',520000,522700,'瓮安县'),(522726,'town','china',520000,522700,'独山县'),(522727,'town','china',520000,522700,'平塘县'),(522728,'town','china',520000,522700,'罗甸县'),(522729,'town','china',520000,522700,'长顺县'),(522730,'town','china',520000,522700,'龙里县'),(522731,'town','china',520000,522700,'惠水县'),(522732,'town','china',520000,522700,'三都水族自治县'),(530000,'province','china',530000,0,'云南省'),(530100,'city','china',530000,530100,'昆明市'),(530101,'town','china',530000,530100,'市辖区'),(530102,'town','china',530000,530100,'五华区'),(530103,'town','china',530000,530100,'盘龙区'),(530111,'town','china',530000,530100,'官渡区'),(530112,'town','china',530000,530100,'西山区'),(530113,'town','china',530000,530100,'东川区'),(530114,'town','china',530000,530100,'呈贡区'),(530122,'town','china',530000,530100,'晋宁县'),(530124,'town','china',530000,530100,'富民县'),(530125,'town','china',530000,530100,'宜良县'),(530126,'town','china',530000,530100,'石林彝族自治县'),(530127,'town','china',530000,530100,'嵩明县'),(530128,'town','china',530000,530100,'禄劝彝族苗族自治县'),(530129,'town','china',530000,530100,'寻甸回族彝族自治县'),(530181,'town','china',530000,530100,'安宁市'),(530300,'city','china',530000,530300,'曲靖市'),(530301,'town','china',530000,530300,'市辖区'),(530302,'town','china',530000,530300,'麒麟区'),(530321,'town','china',530000,530300,'马龙县'),(530322,'town','china',530000,530300,'陆良县'),(530323,'town','china',530000,530300,'师宗县'),(530324,'town','china',530000,530300,'罗平县'),(530325,'town','china',530000,530300,'富源县'),(530326,'town','china',530000,530300,'会泽县'),(530328,'town','china',530000,530300,'沾益县'),(530381,'town','china',530000,530300,'宣威市'),(530400,'city','china',530000,530400,'玉溪市'),(530401,'town','china',530000,530400,'市辖区'),(530402,'town','china',530000,530400,'红塔区'),(530421,'town','china',530000,530400,'江川县'),(530422,'town','china',530000,530400,'澄江县'),(530423,'town','china',530000,530400,'通海县'),(530424,'town','china',530000,530400,'华宁县'),(530425,'town','china',530000,530400,'易门县'),(530426,'town','china',530000,530400,'峨山彝族自治县'),(530427,'town','china',530000,530400,'新平彝族傣族自治县'),(530428,'town','china',530000,530400,'元江哈尼族彝族傣族自治县'),(530500,'city','china',530000,530500,'保山市'),(530501,'town','china',530000,530500,'市辖区'),(530502,'town','china',530000,530500,'隆阳区'),(530521,'town','china',530000,530500,'施甸县'),(530523,'town','china',530000,530500,'龙陵县'),(530524,'town','china',530000,530500,'昌宁县'),(530581,'town','china',530000,530500,'腾冲市'),(530600,'city','china',530000,530600,'昭通市'),(530601,'town','china',530000,530600,'市辖区'),(530602,'town','china',530000,530600,'昭阳区'),(530621,'town','china',530000,530600,'鲁甸县'),(530622,'town','china',530000,530600,'巧家县'),(530623,'town','china',530000,530600,'盐津县'),(530624,'town','china',530000,530600,'大关县'),(530625,'town','china',530000,530600,'永善县'),(530626,'town','china',530000,530600,'绥江县'),(530627,'town','china',530000,530600,'镇雄县'),(530628,'town','china',530000,530600,'彝良县'),(530629,'town','china',530000,530600,'威信县'),(530630,'town','china',530000,530600,'水富县'),(530700,'city','china',530000,530700,'丽江市'),(530701,'town','china',530000,530700,'市辖区'),(530702,'town','china',530000,530700,'古城区'),(530721,'town','china',530000,530700,'玉龙纳西族自治县'),(530722,'town','china',530000,530700,'永胜县'),(530723,'town','china',530000,530700,'华坪县'),(530724,'town','china',530000,530700,'宁蒗彝族自治县'),(530800,'city','china',530000,530800,'普洱市'),(530801,'town','china',530000,530800,'市辖区'),(530802,'town','china',530000,530800,'思茅区'),(530821,'town','china',530000,530800,'宁洱哈尼族彝族自治县'),(530822,'town','china',530000,530800,'墨江哈尼族自治县'),(530823,'town','china',530000,530800,'景东彝族自治县'),(530824,'town','china',530000,530800,'景谷傣族彝族自治县'),(530825,'town','china',530000,530800,'镇沅彝族哈尼族拉祜族自治县'),(530826,'town','china',530000,530800,'江城哈尼族彝族自治县'),(530827,'town','china',530000,530800,'孟连傣族拉祜族佤族自治县'),(530828,'town','china',530000,530800,'澜沧拉祜族自治县'),(530829,'town','china',530000,530800,'西盟佤族自治县'),(530900,'city','china',530000,530900,'临沧市'),(530901,'town','china',530000,530900,'市辖区'),(530902,'town','china',530000,530900,'临翔区'),(530921,'town','china',530000,530900,'凤庆县'),(530922,'town','china',530000,530900,'云县'),(530923,'town','china',530000,530900,'永德县'),(530924,'town','china',530000,530900,'镇康县'),(530925,'town','china',530000,530900,'双江拉祜族佤族布朗族傣族自治县'),(530926,'town','china',530000,530900,'耿马傣族佤族自治县'),(530927,'town','china',530000,530900,'沧源佤族自治县'),(532300,'city','china',530000,532300,'楚雄彝族自治州'),(532301,'town','china',530000,532300,'楚雄市'),(532322,'town','china',530000,532300,'双柏县'),(532323,'town','china',530000,532300,'牟定县'),(532324,'town','china',530000,532300,'南华县'),(532325,'town','china',530000,532300,'姚安县'),(532326,'town','china',530000,532300,'大姚县'),(532327,'town','china',530000,532300,'永仁县'),(532328,'town','china',530000,532300,'元谋县'),(532329,'town','china',530000,532300,'武定县'),(532331,'town','china',530000,532300,'禄丰县'),(532500,'city','china',530000,532500,'红河哈尼族彝族自治州'),(532501,'town','china',530000,532500,'个旧市'),(532502,'town','china',530000,532500,'开远市'),(532503,'town','china',530000,532500,'蒙自市'),(532504,'town','china',530000,532500,'弥勒市'),(532523,'town','china',530000,532500,'屏边苗族自治县'),(532524,'town','china',530000,532500,'建水县'),(532525,'town','china',530000,532500,'石屏县'),(532527,'town','china',530000,532500,'泸西县'),(532528,'town','china',530000,532500,'元阳县'),(532529,'town','china',530000,532500,'红河县'),(532530,'town','china',530000,532500,'金平苗族瑶族傣族自治县'),(532531,'town','china',530000,532500,'绿春县'),(532532,'town','china',530000,532500,'河口瑶族自治县'),(532600,'city','china',530000,532600,'文山壮族苗族自治州'),(532601,'town','china',530000,532600,'文山市'),(532622,'town','china',530000,532600,'砚山县'),(532623,'town','china',530000,532600,'西畴县'),(532624,'town','china',530000,532600,'麻栗坡县'),(532625,'town','china',530000,532600,'马关县'),(532626,'town','china',530000,532600,'丘北县'),(532627,'town','china',530000,532600,'广南县'),(532628,'town','china',530000,532600,'富宁县'),(532800,'city','china',530000,532800,'西双版纳傣族自治州'),(532801,'town','china',530000,532800,'景洪市'),(532822,'town','china',530000,532800,'勐海县'),(532823,'town','china',530000,532800,'勐腊县'),(532900,'city','china',530000,532900,'大理白族自治州'),(532901,'town','china',530000,532900,'大理市'),(532922,'town','china',530000,532900,'漾濞彝族自治县'),(532923,'town','china',530000,532900,'祥云县'),(532924,'town','china',530000,532900,'宾川县'),(532925,'town','china',530000,532900,'弥渡县'),(532926,'town','china',530000,532900,'南涧彝族自治县'),(532927,'town','china',530000,532900,'巍山彝族回族自治县'),(532928,'town','china',530000,532900,'永平县'),(532929,'town','china',530000,532900,'云龙县'),(532930,'town','china',530000,532900,'洱源县'),(532931,'town','china',530000,532900,'剑川县'),(532932,'town','china',530000,532900,'鹤庆县'),(533100,'city','china',530000,533100,'德宏傣族景颇族自治州'),(533102,'town','china',530000,533100,'瑞丽市'),(533103,'town','china',530000,533100,'芒市'),(533122,'town','china',530000,533100,'梁河县'),(533123,'town','china',530000,533100,'盈江县'),(533124,'town','china',530000,533100,'陇川县'),(533300,'city','china',530000,533300,'怒江傈僳族自治州'),(533321,'town','china',530000,533300,'泸水县'),(533323,'town','china',530000,533300,'福贡县'),(533324,'town','china',530000,533300,'贡山独龙族怒族自治县'),(533325,'town','china',530000,533300,'兰坪白族普米族自治县'),(533400,'city','china',530000,533400,'迪庆藏族自治州'),(533401,'town','china',530000,533400,'香格里拉市'),(533422,'town','china',530000,533400,'德钦县'),(533423,'town','china',530000,533400,'维西傈僳族自治县'),(540000,'province','china',540000,0,'西藏自治区'),(540100,'city','china',540000,540100,'拉萨市'),(540101,'town','china',540000,540100,'市辖区'),(540102,'town','china',540000,540100,'城关区'),(540121,'town','china',540000,540100,'林周县'),(540122,'town','china',540000,540100,'当雄县'),(540123,'town','china',540000,540100,'尼木县'),(540124,'town','china',540000,540100,'曲水县'),(540125,'town','china',540000,540100,'堆龙德庆县'),(540126,'town','china',540000,540100,'达孜县'),(540127,'town','china',540000,540100,'墨竹工卡县'),(540200,'city','china',540000,540200,'日喀则市'),(540202,'town','china',540000,540200,'桑珠孜区'),(540221,'town','china',540000,540200,'南木林县'),(540222,'town','china',540000,540200,'江孜县'),(540223,'town','china',540000,540200,'定日县'),(540224,'town','china',540000,540200,'萨迦县'),(540225,'town','china',540000,540200,'拉孜县'),(540226,'town','china',540000,540200,'昂仁县'),(540227,'town','china',540000,540200,'谢通门县'),(540228,'town','china',540000,540200,'白朗县'),(540229,'town','china',540000,540200,'仁布县'),(540230,'town','china',540000,540200,'康马县'),(540231,'town','china',540000,540200,'定结县'),(540232,'town','china',540000,540200,'仲巴县'),(540233,'town','china',540000,540200,'亚东县'),(540234,'town','china',540000,540200,'吉隆县'),(540235,'town','china',540000,540200,'聂拉木县'),(540236,'town','china',540000,540200,'萨嘎县'),(540237,'town','china',540000,540200,'岗巴县'),(540300,'city','china',540000,540300,'昌都市'),(540302,'town','china',540000,540300,'卡若区'),(540321,'town','china',540000,540300,'江达县'),(540322,'town','china',540000,540300,'贡觉县'),(540323,'town','china',540000,540300,'类乌齐县'),(540324,'town','china',540000,540300,'丁青县'),(540325,'town','china',540000,540300,'察雅县'),(540326,'town','china',540000,540300,'八宿县'),(540327,'town','china',540000,540300,'左贡县'),(540328,'town','china',540000,540300,'芒康县'),(540329,'town','china',540000,540300,'洛隆县'),(540330,'town','china',540000,540300,'边坝县'),(540400,'city','china',540000,540400,'林芝市'),(540402,'town','china',540000,540400,'巴宜区'),(540421,'town','china',540000,540400,'工布江达县'),(540422,'town','china',540000,540400,'米林县'),(540423,'town','china',540000,540400,'墨脱县'),(540424,'town','china',540000,540400,'波密县'),(540425,'town','china',540000,540400,'察隅县'),(540426,'town','china',540000,540400,'朗县'),(542200,'city','china',540000,542200,'山南地区'),(542221,'town','china',540000,542200,'乃东县'),(542222,'town','china',540000,542200,'扎囊县'),(542223,'town','china',540000,542200,'贡嘎县'),(542224,'town','china',540000,542200,'桑日县'),(542225,'town','china',540000,542200,'琼结县'),(542226,'town','china',540000,542200,'曲松县'),(542227,'town','china',540000,542200,'措美县'),(542228,'town','china',540000,542200,'洛扎县'),(542229,'town','china',540000,542200,'加查县'),(542231,'town','china',540000,542200,'隆子县'),(542232,'town','china',540000,542200,'错那县'),(542233,'town','china',540000,542200,'浪卡子县'),(542400,'city','china',540000,542400,'那曲地区'),(542421,'town','china',540000,542400,'那曲县'),(542422,'town','china',540000,542400,'嘉黎县'),(542423,'town','china',540000,542400,'比如县'),(542424,'town','china',540000,542400,'聂荣县'),(542425,'town','china',540000,542400,'安多县'),(542426,'town','china',540000,542400,'申扎县'),(542427,'town','china',540000,542400,'索县'),(542428,'town','china',540000,542400,'班戈县'),(542429,'town','china',540000,542400,'巴青县'),(542430,'town','china',540000,542400,'尼玛县'),(542431,'town','china',540000,542400,'双湖县'),(542500,'city','china',540000,542500,'阿里地区'),(542521,'town','china',540000,542500,'普兰县'),(542522,'town','china',540000,542500,'札达县'),(542523,'town','china',540000,542500,'噶尔县'),(542524,'town','china',540000,542500,'日土县'),(542525,'town','china',540000,542500,'革吉县'),(542526,'town','china',540000,542500,'改则县'),(542527,'town','china',540000,542500,'措勤县'),(610000,'province','china',610000,0,'陕西省'),(610100,'city','china',610000,610100,'西安市'),(610101,'town','china',610000,610100,'市辖区'),(610102,'town','china',610000,610100,'新城区'),(610103,'town','china',610000,610100,'碑林区'),(610104,'town','china',610000,610100,'莲湖区'),(610111,'town','china',610000,610100,'灞桥区'),(610112,'town','china',610000,610100,'未央区'),(610113,'town','china',610000,610100,'雁塔区'),(610114,'town','china',610000,610100,'阎良区'),(610115,'town','china',610000,610100,'临潼区'),(610116,'town','china',610000,610100,'长安区'),(610117,'town','china',610000,610100,'高陵区'),(610122,'town','china',610000,610100,'蓝田县'),(610124,'town','china',610000,610100,'周至县'),(610125,'town','china',610000,610100,'户县'),(610200,'city','china',610000,610200,'铜川市'),(610201,'town','china',610000,610200,'市辖区'),(610202,'town','china',610000,610200,'王益区'),(610203,'town','china',610000,610200,'印台区'),(610204,'town','china',610000,610200,'耀州区'),(610222,'town','china',610000,610200,'宜君县'),(610300,'city','china',610000,610300,'宝鸡市'),(610301,'town','china',610000,610300,'市辖区'),(610302,'town','china',610000,610300,'渭滨区'),(610303,'town','china',610000,610300,'金台区'),(610304,'town','china',610000,610300,'陈仓区'),(610322,'town','china',610000,610300,'凤翔县'),(610323,'town','china',610000,610300,'岐山县'),(610324,'town','china',610000,610300,'扶风县'),(610326,'town','china',610000,610300,'眉县'),(610327,'town','china',610000,610300,'陇县'),(610328,'town','china',610000,610300,'千阳县'),(610329,'town','china',610000,610300,'麟游县'),(610330,'town','china',610000,610300,'凤县'),(610331,'town','china',610000,610300,'太白县'),(610400,'city','china',610000,610400,'咸阳市'),(610401,'town','china',610000,610400,'市辖区'),(610402,'town','china',610000,610400,'秦都区'),(610403,'town','china',610000,610400,'杨陵区'),(610404,'town','china',610000,610400,'渭城区'),(610422,'town','china',610000,610400,'三原县'),(610423,'town','china',610000,610400,'泾阳县'),(610424,'town','china',610000,610400,'乾县'),(610425,'town','china',610000,610400,'礼泉县'),(610426,'town','china',610000,610400,'永寿县'),(610427,'town','china',610000,610400,'彬县'),(610428,'town','china',610000,610400,'长武县'),(610429,'town','china',610000,610400,'旬邑县'),(610430,'town','china',610000,610400,'淳化县'),(610431,'town','china',610000,610400,'武功县'),(610481,'town','china',610000,610400,'兴平市'),(610500,'city','china',610000,610500,'渭南市'),(610501,'town','china',610000,610500,'市辖区'),(610502,'town','china',610000,610500,'临渭区'),(610521,'town','china',610000,610500,'华县'),(610522,'town','china',610000,610500,'潼关县'),(610523,'town','china',610000,610500,'大荔县'),(610524,'town','china',610000,610500,'合阳县'),(610525,'town','china',610000,610500,'澄城县'),(610526,'town','china',610000,610500,'蒲城县'),(610527,'town','china',610000,610500,'白水县'),(610528,'town','china',610000,610500,'富平县'),(610581,'town','china',610000,610500,'韩城市'),(610582,'town','china',610000,610500,'华阴市'),(610600,'city','china',610000,610600,'延安市'),(610601,'town','china',610000,610600,'市辖区'),(610602,'town','china',610000,610600,'宝塔区'),(610621,'town','china',610000,610600,'延长县'),(610622,'town','china',610000,610600,'延川县'),(610623,'town','china',610000,610600,'子长县'),(610624,'town','china',610000,610600,'安塞县'),(610625,'town','china',610000,610600,'志丹县'),(610626,'town','china',610000,610600,'吴起县'),(610627,'town','china',610000,610600,'甘泉县'),(610628,'town','china',610000,610600,'富县'),(610629,'town','china',610000,610600,'洛川县'),(610630,'town','china',610000,610600,'宜川县'),(610631,'town','china',610000,610600,'黄龙县'),(610632,'town','china',610000,610600,'黄陵县'),(610700,'city','china',610000,610700,'汉中市'),(610701,'town','china',610000,610700,'市辖区'),(610702,'town','china',610000,610700,'汉台区'),(610721,'town','china',610000,610700,'南郑县'),(610722,'town','china',610000,610700,'城固县'),(610723,'town','china',610000,610700,'洋县'),(610724,'town','china',610000,610700,'西乡县'),(610725,'town','china',610000,610700,'勉县'),(610726,'town','china',610000,610700,'宁强县'),(610727,'town','china',610000,610700,'略阳县'),(610728,'town','china',610000,610700,'镇巴县'),(610729,'town','china',610000,610700,'留坝县'),(610730,'town','china',610000,610700,'佛坪县'),(610800,'city','china',610000,610800,'榆林市'),(610801,'town','china',610000,610800,'市辖区'),(610802,'town','china',610000,610800,'榆阳区'),(610821,'town','china',610000,610800,'神木县'),(610822,'town','china',610000,610800,'府谷县'),(610823,'town','china',610000,610800,'横山县'),(610824,'town','china',610000,610800,'靖边县'),(610825,'town','china',610000,610800,'定边县'),(610826,'town','china',610000,610800,'绥德县'),(610827,'town','china',610000,610800,'米脂县'),(610828,'town','china',610000,610800,'佳县'),(610829,'town','china',610000,610800,'吴堡县'),(610830,'town','china',610000,610800,'清涧县'),(610831,'town','china',610000,610800,'子洲县'),(610900,'city','china',610000,610900,'安康市'),(610901,'town','china',610000,610900,'市辖区'),(610902,'town','china',610000,610900,'汉滨区'),(610921,'town','china',610000,610900,'汉阴县'),(610922,'town','china',610000,610900,'石泉县'),(610923,'town','china',610000,610900,'宁陕县'),(610924,'town','china',610000,610900,'紫阳县'),(610925,'town','china',610000,610900,'岚皋县'),(610926,'town','china',610000,610900,'平利县'),(610927,'town','china',610000,610900,'镇坪县'),(610928,'town','china',610000,610900,'旬阳县'),(610929,'town','china',610000,610900,'白河县'),(611000,'city','china',610000,611000,'商洛市'),(611001,'town','china',610000,611000,'市辖区'),(611002,'town','china',610000,611000,'商州区'),(611021,'town','china',610000,611000,'洛南县'),(611022,'town','china',610000,611000,'丹凤县'),(611023,'town','china',610000,611000,'商南县'),(611024,'town','china',610000,611000,'山阳县'),(611025,'town','china',610000,611000,'镇安县'),(611026,'town','china',610000,611000,'柞水县'),(620000,'province','china',620000,0,'甘肃省'),(620100,'city','china',620000,620100,'兰州市'),(620101,'town','china',620000,620100,'市辖区'),(620102,'town','china',620000,620100,'城关区'),(620103,'town','china',620000,620100,'七里河区'),(620104,'town','china',620000,620100,'西固区'),(620105,'town','china',620000,620100,'安宁区'),(620111,'town','china',620000,620100,'红古区'),(620121,'town','china',620000,620100,'永登县'),(620122,'town','china',620000,620100,'皋兰县'),(620123,'town','china',620000,620100,'榆中县'),(620200,'city','china',620000,620200,'嘉峪关市'),(620201,'town','china',620000,620200,'市辖区'),(620300,'city','china',620000,620300,'金昌市'),(620301,'town','china',620000,620300,'市辖区'),(620302,'town','china',620000,620300,'金川区'),(620321,'town','china',620000,620300,'永昌县'),(620400,'city','china',620000,620400,'白银市'),(620401,'town','china',620000,620400,'市辖区'),(620402,'town','china',620000,620400,'白银区'),(620403,'town','china',620000,620400,'平川区'),(620421,'town','china',620000,620400,'靖远县'),(620422,'town','china',620000,620400,'会宁县'),(620423,'town','china',620000,620400,'景泰县'),(620500,'city','china',620000,620500,'天水市'),(620501,'town','china',620000,620500,'市辖区'),(620502,'town','china',620000,620500,'秦州区'),(620503,'town','china',620000,620500,'麦积区'),(620521,'town','china',620000,620500,'清水县'),(620522,'town','china',620000,620500,'秦安县'),(620523,'town','china',620000,620500,'甘谷县'),(620524,'town','china',620000,620500,'武山县'),(620525,'town','china',620000,620500,'张家川回族自治县'),(620600,'city','china',620000,620600,'武威市'),(620601,'town','china',620000,620600,'市辖区'),(620602,'town','china',620000,620600,'凉州区'),(620621,'town','china',620000,620600,'民勤县'),(620622,'town','china',620000,620600,'古浪县'),(620623,'town','china',620000,620600,'天祝藏族自治县'),(620700,'city','china',620000,620700,'张掖市'),(620701,'town','china',620000,620700,'市辖区'),(620702,'town','china',620000,620700,'甘州区'),(620721,'town','china',620000,620700,'肃南裕固族自治县'),(620722,'town','china',620000,620700,'民乐县'),(620723,'town','china',620000,620700,'临泽县'),(620724,'town','china',620000,620700,'高台县'),(620725,'town','china',620000,620700,'山丹县'),(620800,'city','china',620000,620800,'平凉市'),(620801,'town','china',620000,620800,'市辖区'),(620802,'town','china',620000,620800,'崆峒区'),(620821,'town','china',620000,620800,'泾川县'),(620822,'town','china',620000,620800,'灵台县'),(620823,'town','china',620000,620800,'崇信县'),(620824,'town','china',620000,620800,'华亭县'),(620825,'town','china',620000,620800,'庄浪县'),(620826,'town','china',620000,620800,'静宁县'),(620900,'city','china',620000,620900,'酒泉市'),(620901,'town','china',620000,620900,'市辖区'),(620902,'town','china',620000,620900,'肃州区'),(620921,'town','china',620000,620900,'金塔县'),(620922,'town','china',620000,620900,'瓜州县'),(620923,'town','china',620000,620900,'肃北蒙古族自治县'),(620924,'town','china',620000,620900,'阿克塞哈萨克族自治县'),(620981,'town','china',620000,620900,'玉门市'),(620982,'town','china',620000,620900,'敦煌市'),(621000,'city','china',620000,621000,'庆阳市'),(621001,'town','china',620000,621000,'市辖区'),(621002,'town','china',620000,621000,'西峰区'),(621021,'town','china',620000,621000,'庆城县'),(621022,'town','china',620000,621000,'环县'),(621023,'town','china',620000,621000,'华池县'),(621024,'town','china',620000,621000,'合水县'),(621025,'town','china',620000,621000,'正宁县'),(621026,'town','china',620000,621000,'宁县'),(621027,'town','china',620000,621000,'镇原县'),(621100,'city','china',620000,621100,'定西市'),(621101,'town','china',620000,621100,'市辖区'),(621102,'town','china',620000,621100,'安定区'),(621121,'town','china',620000,621100,'通渭县'),(621122,'town','china',620000,621100,'陇西县'),(621123,'town','china',620000,621100,'渭源县'),(621124,'town','china',620000,621100,'临洮县'),(621125,'town','china',620000,621100,'漳县'),(621126,'town','china',620000,621100,'岷县'),(621200,'city','china',620000,621200,'陇南市'),(621201,'town','china',620000,621200,'市辖区'),(621202,'town','china',620000,621200,'武都区'),(621221,'town','china',620000,621200,'成县'),(621222,'town','china',620000,621200,'文县'),(621223,'town','china',620000,621200,'宕昌县'),(621224,'town','china',620000,621200,'康县'),(621225,'town','china',620000,621200,'西和县'),(621226,'town','china',620000,621200,'礼县'),(621227,'town','china',620000,621200,'徽县'),(621228,'town','china',620000,621200,'两当县'),(622900,'city','china',620000,622900,'临夏回族自治州'),(622901,'town','china',620000,622900,'临夏市'),(622921,'town','china',620000,622900,'临夏县'),(622922,'town','china',620000,622900,'康乐县'),(622923,'town','china',620000,622900,'永靖县'),(622924,'town','china',620000,622900,'广河县'),(622925,'town','china',620000,622900,'和政县'),(622926,'town','china',620000,622900,'东乡族自治县'),(622927,'town','china',620000,622900,'积石山保安族东乡族撒拉族自治县'),(623000,'city','china',620000,623000,'甘南藏族自治州'),(623001,'town','china',620000,623000,'合作市'),(623021,'town','china',620000,623000,'临潭县'),(623022,'town','china',620000,623000,'卓尼县'),(623023,'town','china',620000,623000,'舟曲县'),(623024,'town','china',620000,623000,'迭部县'),(623025,'town','china',620000,623000,'玛曲县'),(623026,'town','china',620000,623000,'碌曲县'),(623027,'town','china',620000,623000,'夏河县'),(630000,'province','china',630000,0,'青海省'),(630100,'city','china',630000,630100,'西宁市'),(630101,'town','china',630000,630100,'市辖区'),(630102,'town','china',630000,630100,'城东区'),(630103,'town','china',630000,630100,'城中区'),(630104,'town','china',630000,630100,'城西区'),(630105,'town','china',630000,630100,'城北区'),(630121,'town','china',630000,630100,'大通回族土族自治县'),(630122,'town','china',630000,630100,'湟中县'),(630123,'town','china',630000,630100,'湟源县'),(630200,'city','china',630000,630200,'海东市'),(630202,'town','china',630000,630200,'乐都区'),(630203,'town','china',630000,630200,'平安区'),(630222,'town','china',630000,630200,'民和回族土族自治县'),(630223,'town','china',630000,630200,'互助土族自治县'),(630224,'town','china',630000,630200,'化隆回族自治县'),(630225,'town','china',630000,630200,'循化撒拉族自治县'),(632200,'city','china',630000,632200,'海北藏族自治州'),(632221,'town','china',630000,632200,'门源回族自治县'),(632222,'town','china',630000,632200,'祁连县'),(632223,'town','china',630000,632200,'海晏县'),(632224,'town','china',630000,632200,'刚察县'),(632300,'city','china',630000,632300,'黄南藏族自治州'),(632321,'town','china',630000,632300,'同仁县'),(632322,'town','china',630000,632300,'尖扎县'),(632323,'town','china',630000,632300,'泽库县'),(632324,'town','china',630000,632300,'河南蒙古族自治县'),(632500,'city','china',630000,632500,'海南藏族自治州'),(632521,'town','china',630000,632500,'共和县'),(632522,'town','china',630000,632500,'同德县'),(632523,'town','china',630000,632500,'贵德县'),(632524,'town','china',630000,632500,'兴海县'),(632525,'town','china',630000,632500,'贵南县'),(632600,'city','china',630000,632600,'果洛藏族自治州'),(632621,'town','china',630000,632600,'玛沁县'),(632622,'town','china',630000,632600,'班玛县'),(632623,'town','china',630000,632600,'甘德县'),(632624,'town','china',630000,632600,'达日县'),(632625,'town','china',630000,632600,'久治县'),(632626,'town','china',630000,632600,'玛多县'),(632700,'city','china',630000,632700,'玉树藏族自治州'),(632701,'town','china',630000,632700,'玉树市'),(632722,'town','china',630000,632700,'杂多县'),(632723,'town','china',630000,632700,'称多县'),(632724,'town','china',630000,632700,'治多县'),(632725,'town','china',630000,632700,'囊谦县'),(632726,'town','china',630000,632700,'曲麻莱县'),(632800,'city','china',630000,632800,'海西蒙古族藏族自治州'),(632801,'town','china',630000,632800,'格尔木市'),(632802,'town','china',630000,632800,'德令哈市'),(632821,'town','china',630000,632800,'乌兰县'),(632822,'town','china',630000,632800,'都兰县'),(632823,'town','china',630000,632800,'天峻县'),(640000,'province','china',640000,0,'宁夏回族自治区'),(640100,'city','china',640000,640100,'银川市'),(640101,'town','china',640000,640100,'市辖区'),(640104,'town','china',640000,640100,'兴庆区'),(640105,'town','china',640000,640100,'西夏区'),(640106,'town','china',640000,640100,'金凤区'),(640121,'town','china',640000,640100,'永宁县'),(640122,'town','china',640000,640100,'贺兰县'),(640181,'town','china',640000,640100,'灵武市'),(640200,'city','china',640000,640200,'石嘴山市'),(640201,'town','china',640000,640200,'市辖区'),(640202,'town','china',640000,640200,'大武口区'),(640205,'town','china',640000,640200,'惠农区'),(640221,'town','china',640000,640200,'平罗县'),(640300,'city','china',640000,640300,'吴忠市'),(640301,'town','china',640000,640300,'市辖区'),(640302,'town','china',640000,640300,'利通区'),(640303,'town','china',640000,640300,'红寺堡区'),(640323,'town','china',640000,640300,'盐池县'),(640324,'town','china',640000,640300,'同心县'),(640381,'town','china',640000,640300,'青铜峡市'),(640400,'city','china',640000,640400,'固原市'),(640401,'town','china',640000,640400,'市辖区'),(640402,'town','china',640000,640400,'原州区'),(640422,'town','china',640000,640400,'西吉县'),(640423,'town','china',640000,640400,'隆德县'),(640424,'town','china',640000,640400,'泾源县'),(640425,'town','china',640000,640400,'彭阳县'),(640500,'city','china',640000,640500,'中卫市'),(640501,'town','china',640000,640500,'市辖区'),(640502,'town','china',640000,640500,'沙坡头区'),(640521,'town','china',640000,640500,'中宁县'),(640522,'town','china',640000,640500,'海原县'),(650000,'province','china',650000,0,'新疆维吾尔自治区'),(650100,'city','china',650000,650100,'乌鲁木齐市'),(650101,'town','china',650000,650100,'市辖区'),(650102,'town','china',650000,650100,'天山区'),(650103,'town','china',650000,650100,'沙依巴克区'),(650104,'town','china',650000,650100,'新市区'),(650105,'town','china',650000,650100,'水磨沟区'),(650106,'town','china',650000,650100,'头屯河区'),(650107,'town','china',650000,650100,'达坂城区'),(650109,'town','china',650000,650100,'米东区'),(650121,'town','china',650000,650100,'乌鲁木齐县'),(650200,'city','china',650000,650200,'克拉玛依市'),(650201,'town','china',650000,650200,'市辖区'),(650202,'town','china',650000,650200,'独山子区'),(650203,'town','china',650000,650200,'克拉玛依区'),(650204,'town','china',650000,650200,'白碱滩区'),(650205,'town','china',650000,650200,'乌尔禾区'),(650400,'city','china',650000,650400,'吐鲁番市'),(650402,'town','china',650000,650400,'高昌区'),(650421,'town','china',650000,650400,'鄯善县'),(650422,'town','china',650000,650400,'托克逊县'),(652200,'city','china',650000,652200,'哈密地区'),(652201,'town','china',650000,652200,'哈密市'),(652222,'town','china',650000,652200,'巴里坤哈萨克自治县'),(652223,'town','china',650000,652200,'伊吾县'),(652300,'city','china',650000,652300,'昌吉回族自治州'),(652301,'town','china',650000,652300,'昌吉市'),(652302,'town','china',650000,652300,'阜康市'),(652323,'town','china',650000,652300,'呼图壁县'),(652324,'town','china',650000,652300,'玛纳斯县'),(652325,'town','china',650000,652300,'奇台县'),(652327,'town','china',650000,652300,'吉木萨尔县'),(652328,'town','china',650000,652300,'木垒哈萨克自治县'),(652700,'city','china',650000,652700,'博尔塔拉蒙古自治州'),(652701,'town','china',650000,652700,'博乐市'),(652702,'town','china',650000,652700,'阿拉山口市'),(652722,'town','china',650000,652700,'精河县'),(652723,'town','china',650000,652700,'温泉县'),(652800,'city','china',650000,652800,'巴音郭楞蒙古自治州'),(652801,'town','china',650000,652800,'库尔勒市'),(652822,'town','china',650000,652800,'轮台县'),(652823,'town','china',650000,652800,'尉犁县'),(652824,'town','china',650000,652800,'若羌县'),(652825,'town','china',650000,652800,'且末县'),(652826,'town','china',650000,652800,'焉耆回族自治县'),(652827,'town','china',650000,652800,'和静县'),(652828,'town','china',650000,652800,'和硕县'),(652829,'town','china',650000,652800,'博湖县'),(652900,'city','china',650000,652900,'阿克苏地区'),(652901,'town','china',650000,652900,'阿克苏市'),(652922,'town','china',650000,652900,'温宿县'),(652923,'town','china',650000,652900,'库车县'),(652924,'town','china',650000,652900,'沙雅县'),(652925,'town','china',650000,652900,'新和县'),(652926,'town','china',650000,652900,'拜城县'),(652927,'town','china',650000,652900,'乌什县'),(652928,'town','china',650000,652900,'阿瓦提县'),(652929,'town','china',650000,652900,'柯坪县'),(653000,'city','china',650000,653000,'克孜勒苏柯尔克孜自治州'),(653001,'town','china',650000,653000,'阿图什市'),(653022,'town','china',650000,653000,'阿克陶县'),(653023,'town','china',650000,653000,'阿合奇县'),(653024,'town','china',650000,653000,'乌恰县'),(653100,'city','china',650000,653100,'喀什地区'),(653101,'town','china',650000,653100,'喀什市'),(653121,'town','china',650000,653100,'疏附县'),(653122,'town','china',650000,653100,'疏勒县'),(653123,'town','china',650000,653100,'英吉沙县'),(653124,'town','china',650000,653100,'泽普县'),(653125,'town','china',650000,653100,'莎车县'),(653126,'town','china',650000,653100,'叶城县'),(653127,'town','china',650000,653100,'麦盖提县'),(653128,'town','china',650000,653100,'岳普湖县'),(653129,'town','china',650000,653100,'伽师县'),(653130,'town','china',650000,653100,'巴楚县'),(653131,'town','china',650000,653100,'塔什库尔干塔吉克自治县'),(653200,'city','china',650000,653200,'和田地区'),(653201,'town','china',650000,653200,'和田市'),(653221,'town','china',650000,653200,'和田县'),(653222,'town','china',650000,653200,'墨玉县'),(653223,'town','china',650000,653200,'皮山县'),(653224,'town','china',650000,653200,'洛浦县'),(653225,'town','china',650000,653200,'策勒县'),(653226,'town','china',650000,653200,'于田县'),(653227,'town','china',650000,653200,'民丰县'),(654000,'city','china',650000,654000,'伊犁哈萨克自治州'),(654002,'town','china',650000,654000,'伊宁市'),(654003,'town','china',650000,654000,'奎屯市'),(654004,'town','china',650000,654000,'霍尔果斯市'),(654021,'town','china',650000,654000,'伊宁县'),(654022,'town','china',650000,654000,'察布查尔锡伯自治县'),(654023,'town','china',650000,654000,'霍城县'),(654024,'town','china',650000,654000,'巩留县'),(654025,'town','china',650000,654000,'新源县'),(654026,'town','china',650000,654000,'昭苏县'),(654027,'town','china',650000,654000,'特克斯县'),(654028,'town','china',650000,654000,'尼勒克县'),(654200,'city','china',650000,654200,'塔城地区'),(654201,'town','china',650000,654200,'塔城市'),(654202,'town','china',650000,654200,'乌苏市'),(654221,'town','china',650000,654200,'额敏县'),(654223,'town','china',650000,654200,'沙湾县'),(654224,'town','china',650000,654200,'托里县'),(654225,'town','china',650000,654200,'裕民县'),(654226,'town','china',650000,654200,'和布克赛尔蒙古自治县'),(654300,'city','china',650000,654300,'阿勒泰地区'),(654301,'town','china',650000,654300,'阿勒泰市'),(654321,'town','china',650000,654300,'布尔津县'),(654322,'town','china',650000,654300,'富蕴县'),(654323,'town','china',650000,654300,'福海县'),(654324,'town','china',650000,654300,'哈巴河县'),(654325,'town','china',650000,654300,'青河县'),(654326,'town','china',650000,654300,'吉木乃县'),(659000,'city','china',650000,659000,'自治区直辖县级行政区划'),(659001,'town','china',650000,659000,'石河子市'),(659002,'town','china',650000,659000,'阿拉尔市'),(659003,'town','china',650000,659000,'图木舒克市'),(659004,'town','china',650000,659000,'五家渠市'),(710000,'province','china',710000,0,'台湾省'),(810000,'province','china',810000,0,'香港特别行政区'),(820000,'province','china',820000,0,'澳门特别行政区');

/*Table structure for table `modules` */

DROP TABLE IF EXISTS `modules`;

CREATE TABLE `modules` (
  `modules_id` int(11) NOT NULL AUTO_INCREMENT,
  `modules_father_id` int(11) NOT NULL COMMENT '父ID',
  `modules_name` varchar(100) NOT NULL COMMENT '模块名称',
  `modules_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `modules_module` varchar(100) NOT NULL COMMENT '模块',
  `modules_describe` varchar(200) NOT NULL DEFAULT '' COMMENT '模块描述',
  `modules_action` varchar(100) NOT NULL COMMENT '模块action',
  `modules_action_field` text COMMENT '模块action field权限',
  `modules_action_permissions` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '查 增 改 删 权限',
  `modules_ico` varchar(50) NOT NULL DEFAULT '' COMMENT '图标',
  `modules_show` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否显示在菜单中',
  `modules_open` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否启用',
  PRIMARY KEY (`modules_id`)
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

/*Data for the table `modules` */

insert  into `modules`(`modules_id`,`modules_father_id`,`modules_name`,`modules_order`,`modules_module`,`modules_describe`,`modules_action`,`modules_action_field`,`modules_action_permissions`,`modules_ico`,`modules_show`,`modules_open`) values (1,1,'智能酒店管理',0,'index','index','',NULL,'3','icon-home','1','1'),(2,2,'前厅',0,'frontOffice','frontOffice','',NULL,'3','icon-reception','1','1'),(3,3,'客房',0,'roomsManagement','roomsManagement','',NULL,'3','icon-rooms-management','1','1'),(4,4,'餐饮',0,'restaurant','restaurant','',NULL,'3','icon-restaurant','1','0'),(5,5,'娱乐',0,'entertainment','entertainment','',NULL,'3','icon-entertainment','1','0'),(6,6,'保安',0,'security','security','',NULL,'3','icon-security','1','0'),(7,7,'销售',0,'sales','sales','',NULL,'3','icon-sales','1','0'),(8,8,'行政',0,'administration','administration','',NULL,'3','icon-administration','1','0'),(9,9,'财务',0,'financial','financial','',NULL,'3','icon-financial','1','1'),(10,8,'后勤',0,'logistics','logistics','',NULL,'3','icon-bell','1','0'),(11,8,'人事',0,'personnel','personnel','',NULL,'3','icon-user','1','0'),(12,12,'工程',0,'engineering','engineering','',NULL,'3','icon-magnet','1','0'),(13,13,'采购',0,'purchase','purchase','',NULL,'3','icon-inbox','1','0'),(14,14,'酒店信息管理',0,'hotelSetting','hotelSetting','',NULL,'3','icon-th','1','1'),(15,14,'公司信息设置',0,'company','company','',NULL,'3','','1','1'),(16,14,'酒店信息设置',0,'hotel','hotel','',NULL,'3','','1','1'),(18,14,'酒店房间信息设置',0,'roomsSetting','roomsSetting','',NULL,'3','','1','1'),(20,14,'客人来源与折扣管理',0,'memberSetting','memberSetting','',NULL,'3','','1','1'),(21,3,'售卖房型价格',0,'roomLayoutPrice','roomLayoutPrice','',NULL,'3','am-icon-money am-yellow-FFAA3C','1','1'),(22,14,'设置酒店取消政策',0,'cancellationPolicy','cancellationPolicy','',NULL,'3','','1','1'),(23,14,'设置付款方式',0,'modeOfPayment','modeOfPayment','',NULL,'3','','1','1'),(24,14,'编辑公司信息',0,'company','company_edit','edit',NULL,'3','','0','1'),(25,14,'删除公司信息',0,'company','company_delete','delete',NULL,'3','','0','1'),(26,14,'编辑酒店信息',0,'hotel','hotel_edit','edit',NULL,'3','','0','1'),(27,14,'删除酒店信息',0,'hotel','hotel_delete','delete',NULL,'3','','0','1'),(28,14,'添加公司信息',0,'company','company_add','add',NULL,'3','','0','1'),(29,14,'添加酒店信息',0,'hotel','hotel_add','add',NULL,'3','','0','1'),(19,3,'基础房型属性',0,'roomsAttribute','roomsAttribute','',NULL,'3','','1','1'),(17,14,'酒店属性设置',0,'hotelAttribute','hotelAttribute','',NULL,'3','','1','1'),(30,14,'酒店部门管理',0,'department','department','',NULL,'3','','1','1'),(31,14,'酒店员工管理',0,'employee','employee','',NULL,'3','','1','1'),(32,14,'添加酒店房间信息',0,'roomsSetting','roomsSetting','add',NULL,'3','','0','1'),(33,3,'添加酒店房间属性',0,'roomsAttribute','roomsAttribute','add',NULL,'3','','0','1'),(34,14,'编辑酒店房间信息',0,'roomsSetting','roomsSetting','edit',NULL,'3','','0','1'),(35,14,'删除酒店房间',0,'roomsSetting','roomsSetting','delete',NULL,'3','','0','1'),(36,3,'基础房型',0,'roomsLayout','roomsLayout','',NULL,'3','am-icon-bed am-green-A1C200','1','1'),(37,3,'增加基础房型',0,'roomsLayout','roomsLayout','add',NULL,'3','','0','1'),(38,3,'修改基础房型',0,'roomsLayout','roomsLayout','edit',NULL,'3','','0','1'),(39,3,'删除基础房型',0,'roomsLayout','roomsLayout','delete',NULL,'3','','0','1'),(40,40,'上传文件',0,'upload','upload','',NULL,'3','','0','1'),(41,3,'保存基础房型属性值',0,'roomsLayout','roomsLayout','saveAttrValue',NULL,'3','','0','1'),(42,40,'上传图片',0,'upload','upload','uploadImages',NULL,'3','','0','1'),(43,3,'修改删除酒店房间属性',0,'roomsAttribute','roomsAttribute','delete',NULL,'0','','0','1'),(44,14,'增加酒店属性设置',0,'hotelAttribute','hotelAttribute','add',NULL,'0','','0','1'),(45,14,'删除酒店属性',0,'hotelAttribute','hotelAttribute','delete',NULL,'0','','0','1'),(46,14,'保存酒店属性值',0,'hotel','hotel','saveAttrValue',NULL,'0','','1','1'),(47,14,'角色管理',0,'role','role','',NULL,'0','','1','1'),(48,2,'管理预定/入住',0,'book','book','',NULL,'0','am-icon-clock-o am-green-54B51C','1','1'),(49,2,'新增预定/入住',0,'book','book','add',NULL,'0','am-icon-clock-o am-blue-2F93FF','1','1'),(50,2,'编辑预订/入住',0,'book','book','edit',NULL,'0','','0','1'),(51,2,'删除预定/入住',0,'book','book','delete',NULL,'0','','0','1'),(52,3,'编辑房型价格',0,'roomLayoutPrice','roomLayoutPrice','edit',NULL,'0','','0','1'),(53,3,'添加房型价格',0,'roomLayoutPrice','roomLayoutPrice','add',NULL,'0','','0','1'),(54,3,'删除房型价格',0,'roomLayoutPrice','roomLayoutPrice','delete',NULL,'0','','0','1'),(56,3,'附加服务',0,'accessorialService','accessorialService','',NULL,'0','am-icon-bell am-yellow-E88A26','1','1'),(55,3,'管理房型价格体系',0,'roomLayoutPrice','roomLayoutPrice','editSystem',NULL,'0','','0','1'),(57,3,'添加附加服务',0,'accessorialService','accessorialService','add',NULL,'0','','0','1'),(58,3,'删除附加服务',0,'accessorialService','accessorialService','delete',NULL,'0','','0','1'),(59,3,'编辑附加服务',0,'accessorialService','accessorialService','edit',NULL,'0','','0','1'),(60,3,'售卖房型',0,'roomsSellLayout','roomsSellLayout','',NULL,'0','am-icon-bed am-red-FB0000','1','1'),(61,3,'增加售卖房型',0,'roomsSellLayout','roomsSellLayout','add',NULL,'0','','0','1'),(62,3,'编辑售卖房型',0,'roomsSellLayout','roomsSellLayout','edit',NULL,'0','','0','1'),(63,3,'删除售卖房型',0,'roomsSellLayout','roomsSellLayout','delete',NULL,'0','','0','1'),(64,2,'房态',0,'roomsStatus','roomsStatus','',NULL,'0','am-icon-braille am-yellow-E88A26','1','1'),(65,2,'添加房态',0,'roomsStatus','roomsStatus','add',NULL,'0','','0','1'),(66,2,'编辑房态',0,'roomsStatus','roomsStatus','edit',NULL,'0','','0','1'),(67,2,'删除房态',0,'roomsStatus','roomsStatus','delete',NULL,'0','','0','1'),(68,2,'夜审',0,'nightAudit','nightAudit','',NULL,'0','am-icon-server am-yellow-EBC012','1','1'),(69,2,'添加夜审',0,'nightAudit','nightAudit','add',NULL,'0','','0','1'),(70,2,'编辑夜审',0,'nightAudit','nightAudit','edit',NULL,'0','','0','1'),(71,14,'添加酒店部门',0,'department','department','add',NULL,'0','','0','1'),(72,14,'编辑酒店部门',0,'department','department','edit',NULL,'0','','0','1'),(73,14,'删除酒店部门',0,'department','department','delete',NULL,'0','','0','1'),(74,14,'添加员工',0,'employee','employee','add',NULL,'0','','0','1'),(75,14,'编辑员工',0,'employee','employee','edit',NULL,'0','','0','1'),(76,14,'删除员工',0,'employee','employee','delete',NULL,'0','','0','1'),(77,14,'添加会员/折扣设置',0,'memberSetting','memberSetting','add',NULL,'0','','0','1'),(78,14,'编辑会员/折扣设置',0,'memberSetting','memberSetting','edit',NULL,'0','','0','1'),(79,14,'删除会员/折扣设置',0,'memberSetting','memberSetting','delete',NULL,'0','','0','1'),(80,14,'添加付款方式',0,'modeOfPayment','modeOfPayment','add',NULL,'0','','0','1'),(81,14,'编辑付款方式',0,'modeOfPayment','modeOfPayment','edit',NULL,'0','','0','1'),(82,14,'删除付款方式',0,'modeOfPayment','modeOfPayment','delete',NULL,'0','','0','1'),(83,14,'添加取消政策',0,'cancellationPolicy','cancellationPolicy','add',NULL,'0','','0','1'),(84,14,'编辑取消政策',0,'cancellationPolicy','cancellationPolicy','edit',NULL,'0','','0','1'),(85,14,'删除取消政策',0,'cancellationPolicy','cancellationPolicy','delete',NULL,'0','','0','1'),(86,14,'添加角色',0,'role','role','add',NULL,'0','','1','1'),(87,14,'编辑角色',0,'role','role','edit',NULL,'0','','1','1'),(88,14,'删除角色',0,'role','role','delete',NULL,'0','','1','1'),(89,14,'员工人事信息管理',0,'employee','employee','personnelFile',NULL,'0','','0','1'),(90,3,'协议公司房型价格种类',0,'roomLayoutPrice','roomLayoutPrice','agreement_corp',NULL,'0','am-icon-briefcase am-blue-2F93FF','1','1');

/*Table structure for table `multi_laguage_page` */

DROP TABLE IF EXISTS `multi_laguage_page`;

CREATE TABLE `multi_laguage_page` (
  `laguage` enum('简体中文','English') NOT NULL DEFAULT '简体中文' COMMENT '语言',
  `page_module` enum('common','company','hotel','roomsSetting','roomsAttribute','roomsLayout','hotelAttribute','department','book','roomLayoutPrice','accessorialService','roomsSellLayout','memberSetting','nightAudit') NOT NULL COMMENT '页面模块，一个模块一个页面',
  `page_laguage_key` varchar(100) NOT NULL COMMENT '页面的多语言的key',
  `page_laguage_value` varchar(100) NOT NULL COMMENT '多语言的值',
  PRIMARY KEY (`laguage`,`page_module`,`page_laguage_key`),
  UNIQUE KEY `laguage_key` (`page_laguage_key`,`page_module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `multi_laguage_page` */

insert  into `multi_laguage_page`(`laguage`,`page_module`,`page_laguage_key`,`page_laguage_value`) values ('简体中文','common','add','增加'),('简体中文','common','address','地址'),('简体中文','common','add_attribute_value','增加属性值'),('简体中文','common','add_category','添加类别'),('简体中文','common','add_customize_attr','增加自定属性'),('简体中文','common','add_number_of_people','增加人数'),('简体中文','common','add_or_edit_category','添加/修改类别'),('简体中文','common','adult','成人'),('简体中文','common','agreement','协议'),('简体中文','common','all','全部'),('简体中文','common','apellation','名称'),('简体中文','common','area','面积'),('简体中文','common','back','返回上一页'),('简体中文','common','back_list','返回列表'),('简体中文','common','base_room_price','基本房费'),('简体中文','common','book','预订'),('简体中文','common','booking_information','预订信息'),('简体中文','common','book_type','来源'),('简体中文','common','brand','品牌'),('简体中文','common','cancel','取消'),('简体中文','common','cancel_edit','取消编辑'),('简体中文','common','cash_pledge','押金'),('简体中文','common','certificate_officers','军官证'),('简体中文','common','checkin','入住日期'),('简体中文','common','checkin_name','入住人姓名'),('简体中文','common','checkout','离店日期'),('简体中文','common','check_in_room','办理入住'),('简体中文','common','children','儿童'),('简体中文','common','close','关闭'),('简体中文','common','close_an_account','结算'),('简体中文','common','confirm','确定'),('简体中文','common','contacts','联系人'),('简体中文','common','delete','删除'),('简体中文','common','department_role_setting','权限角色'),('简体中文','common','describe','描述'),('简体中文','common','dining','厨房'),('简体中文','common','discount','折扣'),('简体中文','common','discount_describe','折扣说明'),('简体中文','common','east','东'),('简体中文','common','edit','编辑'),('简体中文','common','email','Email'),('简体中文','common','email&lotel','email或者移动电话'),('简体中文','common','excute_success','恭喜你，操作成功！'),('简体中文','common','excute_update_success','恭喜你，更新信息成功！'),('简体中文','common','extra_bed','加床'),('简体中文','common','extra_service','附加服务'),('简体中文','common','female','女'),('简体中文','common','find_hour_room','查找钟点房'),('简体中文','common','find_room','查找客房'),('简体中文','common','full-payout','全额支付'),('简体中文','common','have','有'),('简体中文','common','hotel','酒店'),('简体中文','common','hotel_attribute_setting_next','下一步,设置酒店属性'),('简体中文','common','hotel_checkin','入住时间'),('简体中文','common','hotel_checkout','退房时间'),('简体中文','common','hotel_department_manage','部门管理'),('简体中文','common','hotel_star','酒店星级'),('简体中文','common','hotel_wifi','酒店wifi'),('简体中文','common','id_card','身份证'),('简体中文','common','info','信息'),('简体中文','common','is_valid','是否有效'),('简体中文','common','male','男'),('简体中文','common','manage','管理'),('简体中文','common','max_people','最多人数'),('简体中文','common','member','会员'),('简体中文','common','mobile','移动电话'),('简体中文','common','modal_fail','操作失败'),('简体中文','common','modal_success','操作成功'),('简体中文','common','name','姓名'),('简体中文','common','new_category','新类别'),('简体中文','common','next','下一步'),('简体中文','common','no','无'),('简体中文','common','north','北'),('简体中文','common','northeast','东北'),('简体中文','common','northwest','西北'),('简体中文','common','not_have','无'),('简体中文','common','no_avail','无效'),('简体中文','common','no_permission','您没有权限，请分配权限。'),('简体中文','common','number_of_people','人数'),('简体中文','common','office','办公室'),('简体中文','common','operate','操作'),('简体中文','common','order_chechin','入住'),('简体中文','common','order_failure','失效'),('简体中文','common','order_no_show','退房完成'),('简体中文','common','order_number','订单号'),('简体中文','common','order_success','预定成功'),('简体中文','common','orientations','朝向'),('简体中文','common','OTA','OTA及渠道'),('简体中文','common','other','其它'),('简体中文','common','overall_number_of_people','总人数'),('简体中文','common','passport','护照'),('简体中文','common','pay','支付'),('简体中文','common','payment_account','支付帐号'),('简体中文','common','payment_type','支付方式'),('简体中文','common','phone','电话'),('简体中文','common','please_select','请选择'),('简体中文','common','position_manage','职位管理'),('简体中文','common','prepayment','预付'),('简体中文','common','prepayment_price','预付价'),('简体中文','common','price','价格'),('简体中文','common','remaining_sum','余额'),('简体中文','common','reminder','提示信息'),('简体中文','common','restaurant','餐厅'),('简体中文','common','room','客房'),('简体中文','common','room_area','房间面积'),('简体中文','common','room_floor','楼层'),('简体中文','common','room_layout','房型'),('简体中文','common','room_layout_attr','房型属性'),('简体中文','common','room_layout_name','基础房型名称'),('简体中文','common','room_layout_price','房型价格'),('简体中文','common','room_layout_room_number','房间号'),('简体中文','common','room_mansion','楼栋编号'),('简体中文','common','room_name','客房名称'),('简体中文','common','room_number','房间号'),('简体中文','common','room_price','房价'),('简体中文','common','room_setting_type','类别'),('简体中文','common','save','保存'),('简体中文','common','save_next','保存，下一步'),('简体中文','common','save_nothings','没有保存任何数据！'),('简体中文','common','save_success','保存成功！'),('简体中文','common','search','搜索'),('简体中文','common','search_map','查询地图位置'),('简体中文','common','selective_type','选择类型'),('简体中文','common','select_category','选择类别'),('简体中文','common','sex','性别'),('简体中文','common','south','南'),('简体中文','common','southeast','东南'),('简体中文','common','southwest','西南'),('简体中文','common','status','状态'),('简体中文','common','store','仓库'),('简体中文','common','team','团队'),('简体中文','common','total_price','总价'),('简体中文','common','total_room_rate','总房费'),('简体中文','common','upload_images','上传图片'),('简体中文','common','user_comments','备注'),('简体中文','common','valid','有效'),('简体中文','common','varia','杂物房'),('简体中文','common','view','查看'),('简体中文','common','walk-in','散客'),('简体中文','common','warm_prompt','提示信息'),('简体中文','common','warning','警告'),('简体中文','common','warning_confirm_delete','您确定要删除吗?'),('简体中文','common','warning_confirm_update','您确定要更新信息吗？'),('简体中文','common','west','西'),('简体中文','company','company_add','添加公司'),('简体中文','company','company_address','公司地址'),('简体中文','company','company_cancel_edit','取消编辑公司资料'),('简体中文','company','company_edit','点击编辑公司资料'),('简体中文','company','company_email','公司联系email'),('简体中文','company','company_fax','公司传真号码'),('简体中文','company','company_information','公司信息'),('简体中文','company','company_introduction','公司介绍'),('简体中文','company','company_location','所在位置'),('简体中文','company','company_map','公司地图位置'),('简体中文','company','company_mobile','公司移动电话'),('简体中文','company','company_name','公司名称'),('简体中文','company','company_phone','公司联系电话'),('简体中文','company','contact_information','联系方式'),('简体中文','company','list_of_companies','公司列表'),('简体中文','company','mobile','移动电话'),('简体中文','hotel','belong_to_company','属于公司'),('简体中文','hotel','booking_information','预定信息'),('简体中文','hotel','hotel_add','添加酒店'),('简体中文','hotel','hotel_address','酒店地址'),('简体中文','hotel','hotel_attribute_setting','属性信息'),('简体中文','hotel','hotel_attribute_setting_next','下一步,设置酒店属性信息'),('简体中文','hotel','hotel_booking_notes','预定须知'),('简体中文','hotel','hotel_email','酒店email'),('简体中文','hotel','hotel_fax','酒店传真'),('简体中文','hotel','hotel_information','酒店信息'),('简体中文','hotel','hotel_introduce','酒店介绍'),('简体中文','hotel','hotel_location','所在位置'),('简体中文','hotel','hotel_map','酒店地图'),('简体中文','hotel','hotel_mobile','酒店移动电话'),('简体中文','hotel','hotel_name','酒店名称'),('简体中文','hotel','hotel_phone','酒店联系电话'),('简体中文','hotel','hotel_service_setting','酒店服务'),('简体中文','hotel','hotel_setting','酒店基本信息'),('简体中文','hotel','hotel_type','酒店类型'),('简体中文','hotel','list_of_hotel','酒店列表'),('简体中文','hotel','upload_holte_images','上传酒店图片'),('简体中文','roomsSetting','add_hotel_rooms','添加酒店房间信息'),('简体中文','roomsSetting','equipment room','设备间'),('简体中文','roomsSetting','garden','花园'),('简体中文','roomsSetting','gazebo','露台'),('简体中文','roomsSetting','list_of_rooms','酒店所有房间信息'),('简体中文','roomsSetting','meeting room','会议室'),('简体中文','roomsSetting','multiple-function hall','多功能厅'),('简体中文','roomsSetting','room_name','名称'),('简体中文','roomsAttribute','add_attribute_setting','增加属性'),('简体中文','roomsAttribute','add_attr_classes','增加新属性类别'),('简体中文','roomsAttribute','attribute_setting','属性设置'),('简体中文','roomsAttribute','attr_classes','属性类别'),('简体中文','roomsAttribute','attr_name','属性名称'),('简体中文','roomsAttribute','modify_customize_attr','批量修改属性，清空为删除'),('简体中文','roomsLayout','add_rooms_layout','增加房型'),('简体中文','roomsLayout','next_rooms_attribute_setting','下一步,设置房型属性信息'),('简体中文','roomsLayout','rooms_layout_setting','基本信息'),('简体中文','roomsLayout','room_layout_extra_bed','可加床'),('简体中文','roomsLayout','room_layout_max_children','最多住几个小孩'),('简体中文','roomsLayout','room_layout_max_people','最多住几人'),('简体中文','roomsLayout','room_layout_price_setting','设置房型售卖价格'),('简体中文','roomsLayout','room_layout_type','基础房型类别'),('简体中文','roomsLayout','room_layout_valid','房型是否有效'),('简体中文','roomsLayout','set_room','设置客房'),('简体中文','roomsLayout','upload_room_layout_images','上传房型图片'),('简体中文','hotelAttribute','add_hotel_attribute','增加酒店属性'),('简体中文','hotelAttribute','attr_classes','属性类别'),('简体中文','hotelAttribute','attr_name','属性名称'),('简体中文','hotelAttribute','hotel_attribute_setting','酒店属性设置'),('简体中文','hotelAttribute','modify_customize_attr','批量修改属性，清空为删除'),('简体中文','department','employee_manage','员工管理'),('简体中文','book','add_book','新增预定/入住'),('简体中文','book','already_collection','已收款'),('简体中文','book','before_half_of_the_rate','前退房算半天房费，后算1天房费'),('简体中文','book','begin_book','开始预定'),('简体中文','book','book_days_total','总共几天'),('简体中文','book','book_info','预订信息'),('简体中文','book','book_man','预订人'),('简体中文','book','book_order_retention_time','预定保留到时间'),('简体中文','book','check_in_information','入住信息'),('简体中文','book','contact_information','联系信息'),('简体中文','book','identification_number','证件号码'),('简体中文','book','identity_information','身份信息'),('简体中文','book','include_service','包含服务'),('简体中文','book','money_has_to_account','付款已到账'),('简体中文','book','need_service','附加服务'),('简体中文','book','need_service_price','附加服务费'),('简体中文','book','new_add_room','新增房'),('简体中文','book','not_receivable','未收款'),('简体中文','book','order_number_ourter','外部订单号'),('简体中文','book','payment_voucher','支付凭证'),('简体中文','book','reduce_number_of_people','减少人数'),('简体中文','book','room_rate_calculation','计算房费'),('简体中文','book','service_charge','服务费'),('简体中文','book','today_is','今天是'),('简体中文','roomLayoutPrice','add_room_layout_price','新增房型价格'),('简体中文','roomLayoutPrice','add_room_layout_price_system','新增/编辑价格体系'),('简体中文','roomLayoutPrice','common_room_layout','通用房型'),('简体中文','roomLayoutPrice','extra_bed_price','加床价格'),('简体中文','roomLayoutPrice','history_prices','历史价格'),('简体中文','roomLayoutPrice','manager_room_layout_price','管理房型价格'),('简体中文','roomLayoutPrice','manager_room_layout_price_system','管理价格体系'),('简体中文','roomLayoutPrice','month_price','按月价格'),('简体中文','roomLayoutPrice','no_price','没有设置价格'),('简体中文','roomLayoutPrice','room_layout_price_system','价格体系'),('简体中文','roomLayoutPrice','sale_room','售卖房型'),('简体中文','roomLayoutPrice','select_additional_services','选择附加服务'),('简体中文','roomLayoutPrice','sell_price','售卖价格'),('简体中文','roomLayoutPrice','set_price','设置价格'),('简体中文','roomLayoutPrice','set_prices_on_a_monthly','按月设置'),('简体中文','roomLayoutPrice','set_prices_on_a_week','按周快速设置'),('简体中文','roomLayoutPrice','system_price_name','价格体系名称'),('简体中文','roomLayoutPrice','uniform_price','统一价格'),('简体中文','roomLayoutPrice','week_price','按周价格'),('简体中文','accessorialService','0_free','0为免费'),('简体中文','accessorialService','accessorial_service','附加服务'),('简体中文','accessorialService','add_accessorial_service','添加附加服务'),('简体中文','accessorialService','add_or_edit_accessorial_service','添加/修改附加服务'),('简体中文','accessorialService','edit_accessorial_service','批量修改附加服务，清空为删除'),('简体中文','accessorialService','new_service_classes','新服务类别'),('简体中文','accessorialService','select_classes','选择类别'),('简体中文','accessorialService','service_name','服务名称'),('简体中文','roomsSellLayout','add&edit_sell_layout','添加/修改售卖房型'),('简体中文','roomsSellLayout','add_sell_layout','添加售卖房型'),('简体中文','roomsSellLayout','select_base_layout','选择基础房型'),('简体中文','roomsSellLayout','sell_layout_name','售卖房型名称'),('简体中文','memberSetting','add_discount','添加折扣'),('简体中文','nightAudit','begin_night_audit','开始今天夜审'),('简体中文','nightAudit','service_charge','服务费');

/*Table structure for table `operate_log` */

DROP TABLE IF EXISTS `operate_log`;

CREATE TABLE `operate_log` (
  `operate_log_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '操作日志ID',
  `employee_id` bigint(19) NOT NULL COMMENT '操作人ID',
  `operate_log_url_referer` varchar(200) DEFAULT NULL,
  `operate_log_url` varbinary(200) NOT NULL DEFAULT '0' COMMENT '被操作URL',
  `operate_log_type` varchar(50) NOT NULL DEFAULT '0' COMMENT '操作类型',
  `operate_log_remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `operate_log_add_date` date NOT NULL COMMENT '添加日期',
  `operate_log_add_time` time NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`operate_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `operate_log` */

/*Table structure for table `payment_type` */

DROP TABLE IF EXISTS `payment_type`;

CREATE TABLE `payment_type` (
  `payment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `payment_type_father_id` int(11) NOT NULL COMMENT '父ID',
  `payment_type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `payment_type` */

insert  into `payment_type`(`payment_type_id`,`hotel_id`,`payment_type_father_id`,`payment_type_name`) values (1,0,1,'现金'),(2,0,2,'借记卡'),(3,0,3,'信用卡消费'),(4,0,4,'信用卡预授权'),(5,0,5,'POS机直连'),(6,0,6,'支票'),(7,0,7,'银行汇款'),(8,0,8,'移动支付'),(9,0,9,'应收账款'),(10,0,10,'银联'),(11,0,11,'其它'),(12,0,1,'现金'),(13,0,6,'支票'),(14,0,9,'booking'),(15,0,2,'中国工商银行'),(16,0,4,'中国工商银行信用卡'),(17,0,3,'中国工商银行信用卡'),(18,0,7,'中国工商银行'),(19,0,8,'支付宝');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色权限ID',
  `company_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL DEFAULT '0' COMMENT '0表示系统的初始权限',
  `department_id` int(11) NOT NULL COMMENT '部门ID',
  `department_position_id` int(11) NOT NULL COMMENT '职位ID 根据职位添加权限',
  `role_name` varchar(100) DEFAULT NULL COMMENT '权限名称',
  `role_describe` varchar(2000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`role_id`,`company_id`,`hotel_id`,`department_id`,`department_position_id`,`role_name`,`role_describe`) values (1,1,1,1,1,'超级管理员','超级管理员'),(2,2,2,2,2,'超级管理员','超级管理员');

/*Table structure for table `role_employee` */

DROP TABLE IF EXISTS `role_employee`;

CREATE TABLE `role_employee` (
  `hotel_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL COMMENT '角色权限',
  `employee_id` int(11) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`hotel_id`,`role_id`,`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_employee` */

insert  into `role_employee`(`hotel_id`,`role_id`,`employee_id`) values (1,1,1),(2,2,2);

/*Table structure for table `role_modules` */

DROP TABLE IF EXISTS `role_modules`;

CREATE TABLE `role_modules` (
  `role_id` int(11) NOT NULL COMMENT '角色权限',
  `hotel_id` int(11) NOT NULL DEFAULT '1',
  `modules_id` int(11) NOT NULL,
  `role_modules_action_permissions` enum('0','1','2','3','4') DEFAULT NULL,
  PRIMARY KEY (`role_id`,`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role_modules` */

insert  into `role_modules`(`role_id`,`hotel_id`,`modules_id`,`role_modules_action_permissions`) values (1,1,1,'4'),(1,1,2,'4'),(1,1,3,'4'),(1,1,4,'4'),(1,1,5,'4'),(1,1,6,'4'),(1,1,7,'4'),(1,1,8,'4'),(1,1,9,'4'),(1,1,10,'4'),(1,1,11,'4'),(1,1,12,'4'),(1,1,13,'4'),(1,1,14,'4'),(1,1,15,'4'),(1,1,16,'4'),(1,1,17,'4'),(1,1,18,'4'),(1,1,19,'4'),(1,1,20,'4'),(1,1,21,'4'),(1,1,22,'4'),(1,1,23,'4'),(1,1,24,'4'),(1,1,25,'4'),(1,1,26,'4'),(1,1,27,'4'),(1,1,28,'4'),(1,1,29,'4'),(1,1,30,'4'),(1,1,31,'4'),(1,1,32,'4'),(1,1,33,'4'),(1,1,34,'4'),(1,1,35,'4'),(1,1,36,'4'),(1,1,37,'4'),(1,1,38,'4'),(1,1,39,'4'),(1,1,40,'4'),(1,1,41,'4'),(1,1,42,'4'),(1,1,43,'0'),(1,1,44,'4'),(1,1,45,'4'),(1,1,46,'4'),(1,1,47,'4'),(1,1,48,'4'),(1,1,49,'4'),(1,1,50,'4'),(1,1,51,'4'),(1,1,52,'4'),(1,1,53,'4'),(1,1,54,'4'),(1,1,55,'4'),(1,1,56,'4'),(1,1,57,'4'),(1,1,58,'4'),(1,1,59,'4'),(1,1,60,'4'),(1,1,61,'4'),(1,1,62,'4'),(1,1,63,'4'),(1,1,64,'4'),(1,1,65,'4'),(1,1,66,'4'),(1,1,67,'4'),(1,1,68,'4'),(1,1,69,'4'),(1,1,70,'4'),(1,1,71,'4'),(1,1,72,'4'),(1,1,73,'4'),(1,1,74,'4'),(1,1,75,'4'),(1,1,76,'4'),(1,1,77,'4'),(1,1,78,'4'),(1,1,79,'4'),(1,1,80,'4'),(1,1,81,'4'),(1,1,82,'4'),(1,1,83,'4'),(1,1,84,'4'),(1,1,85,'4'),(1,1,86,'4'),(1,1,87,'4'),(1,1,88,'4'),(1,1,89,'4'),(1,1,90,'4'),(1,1,91,'4'),(1,1,92,'4'),(1,1,93,'4'),(1,1,95,'4'),(1,1,96,'4'),(1,1,97,'4'),(1,1,98,'4'),(1,1,99,'4'),(1,1,100,'4'),(1,1,101,'4'),(2,2,1,'4'),(2,2,2,'4'),(2,2,3,'4'),(2,2,4,'4'),(2,2,5,'4'),(2,2,6,'4'),(2,2,7,'4'),(2,2,8,'4'),(2,2,9,'4'),(2,2,10,'4'),(2,2,11,'4'),(2,2,12,'4'),(2,2,13,'4'),(2,2,14,'4'),(2,2,15,'4'),(2,2,16,'4'),(2,2,17,'4'),(2,2,18,'4'),(2,2,19,'4'),(2,2,20,'4'),(2,2,21,'4'),(2,2,22,'4'),(2,2,23,'4'),(2,2,24,'4'),(2,2,25,'4'),(2,2,26,'4'),(2,2,27,'4'),(2,2,28,'4'),(2,2,29,'4'),(2,2,30,'4'),(2,2,31,'4'),(2,2,32,'4'),(2,2,33,'4'),(2,2,34,'4'),(2,2,35,'4'),(2,2,36,'4'),(2,2,37,'4'),(2,2,38,'4'),(2,2,39,'4'),(2,2,40,'4'),(2,2,41,'4'),(2,2,42,'4'),(2,2,43,'0'),(2,2,44,'4'),(2,2,45,'4'),(2,2,46,'4'),(2,2,47,'4'),(2,2,48,'4'),(2,2,49,'4'),(2,2,50,'4'),(2,2,51,'4'),(2,2,52,'4'),(2,2,53,'4'),(2,2,54,'4'),(2,2,55,'4'),(2,2,56,'4'),(2,2,57,'4'),(2,2,58,'4'),(2,2,59,'4'),(2,2,60,'4'),(2,2,61,'4'),(2,2,62,'4'),(2,2,63,'4'),(2,2,64,'4'),(2,2,65,'4'),(2,2,66,'4'),(2,2,67,'4'),(2,2,68,'4'),(2,2,69,'4'),(2,2,70,'4'),(2,2,71,'4'),(2,2,72,'4'),(2,2,73,'4'),(2,2,74,'4'),(2,2,75,'4'),(2,2,76,'4'),(2,2,77,'4'),(2,2,78,'4'),(2,2,79,'4'),(2,2,80,'4'),(2,2,81,'4'),(2,2,82,'4'),(2,2,83,'4'),(2,2,84,'4'),(2,2,85,'4'),(2,2,86,'4'),(2,2,87,'4'),(2,2,88,'4'),(2,2,89,'4'),(2,2,90,'4'),(2,2,91,'4'),(2,2,92,'4'),(2,2,93,'4'),(2,2,95,'4'),(2,2,96,'4'),(2,2,97,'4'),(2,2,98,'4'),(2,2,99,'4'),(2,2,100,'4'),(2,2,101,'4');

/*Table structure for table `room` */

DROP TABLE IF EXISTS `room`;

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房ID 酒店实际客房',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_type` int(11) NOT NULL COMMENT '房间类别',
  `room_on_sell` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否在售卖',
  `room_status` enum('-1','0','1','2','3','4','5','6') DEFAULT '0' COMMENT '房间状态 -1 删除 0正常 1预定 2入住 3预离 4脏房 5维修 6...',
  `room_name` varchar(200) NOT NULL COMMENT '原始房型名称 自定义',
  `room_describe` text NOT NULL COMMENT '原始房间描述',
  `room_mansion` varchar(50) DEFAULT NULL COMMENT '楼栋编号',
  `room_floor` varchar(50) DEFAULT NULL COMMENT '房型楼层',
  `room_number` varchar(50) DEFAULT NULL COMMENT '房号',
  `room_area` double DEFAULT NULL COMMENT '面积 单位 平方米',
  `room_orientations` enum('east','south','west','north','southeast','northeast','southwest','northwest','no') DEFAULT NULL COMMENT '朝向',
  `room_landscape` varchar(50) DEFAULT NULL COMMENT '景观',
  `room_add_date` date DEFAULT NULL COMMENT '添加时间',
  `room_add_time` time DEFAULT NULL COMMENT '添加时间',
  `temp_max_people` tinyint(3) DEFAULT '0' COMMENT '最多人数',
  `temp_max_children` tinyint(3) DEFAULT '0' COMMENT '最多小孩',
  `temp_extra_bed` tinyint(3) DEFAULT '0' COMMENT '加床',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room` (`hotel_id`,`room_mansion`,`room_number`,`room_floor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `room` */

insert  into `room`(`room_id`,`hotel_id`,`room_type`,`room_on_sell`,`room_status`,`room_name`,`room_describe`,`room_mansion`,`room_floor`,`room_number`,`room_area`,`room_orientations`,`room_landscape`,`room_add_date`,`room_add_time`,`temp_max_people`,`temp_max_children`,`temp_extra_bed`) values (0,0,0,'','0','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0);

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
  `hotel_id` int(11) NOT NULL COMMENT '自定义房型属于酒店ID',
  `room_layout_type_id` int(11) NOT NULL COMMENT '类型',
  `room_layout_name` varchar(50) NOT NULL COMMENT '房型名称',
  `room_layout_valid` enum('0','1') NOT NULL DEFAULT '1' COMMENT '房型是否有效 1 有效 0无效',
  `room_layout_cash_pledge` int(11) NOT NULL DEFAULT '0' COMMENT '押金',
  `room_layout_area` varchar(50) DEFAULT '0' COMMENT '房型面积 平方米',
  `room_layout_max_people` tinyint(3) DEFAULT NULL COMMENT '最多住几人',
  `room_layout_max_children` tinyint(3) DEFAULT '0' COMMENT '最多住几个小孩 0不能住小孩',
  `room_layout_extra_bed` tinyint(3) DEFAULT '0' COMMENT '是否可加床 0不可以',
  `room_bed_type` enum('standard','non_standard','tatami','round_bed') DEFAULT 'standard' COMMENT '床型',
  `room_bed_type_num` int(11) NOT NULL DEFAULT '0' COMMENT '床型数量',
  `room_bed_type_wide` varchar(1000) DEFAULT NULL COMMENT '床宽',
  `room_layout_orientations` enum('east','south','west','north','southeast','northeast','southwest','northwest','no') NOT NULL DEFAULT 'no' COMMENT '朝向',
  `room_layout_add_date` date NOT NULL COMMENT '添加时间',
  `room_layout_add_time` time NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`room_layout_id`),
  UNIQUE KEY `layout_name` (`hotel_id`,`room_layout_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `room_layout` */

insert  into `room_layout`(`room_layout_id`,`hotel_id`,`room_layout_type_id`,`room_layout_name`,`room_layout_valid`,`room_layout_cash_pledge`,`room_layout_area`,`room_layout_max_people`,`room_layout_max_children`,`room_layout_extra_bed`,`room_bed_type`,`room_bed_type_num`,`room_bed_type_wide`,`room_layout_orientations`,`room_layout_add_date`,`room_layout_add_time`) values (0,0,0,'','0',0,'0',NULL,0,0,'standard',0,'[\"1\"]','no','0000-00-00','00:00:00');

/*Table structure for table `room_layout_attribute` */

DROP TABLE IF EXISTS `room_layout_attribute`;

CREATE TABLE `room_layout_attribute` (
  `room_layout_attribute_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客房属性',
  `hotel_id` int(11) NOT NULL DEFAULT '0' COMMENT '酒店ID',
  `room_type` varchar(50) NOT NULL DEFAULT 'room' COMMENT '房间类型',
  `room_layout_attribute_father_id` int(11) NOT NULL COMMENT '父类 2级总共',
  `room_layout_attribute_name` varchar(100) NOT NULL COMMENT '客房属性名称',
  `room_layout_attribute_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `room_layout_attribute_value_type` enum('time','date','datetime','text','select','checkbox','radio') NOT NULL DEFAULT 'text',
  `room_layout_attribute_value_type_default` text,
  `room_layout_attribute_is_appoint` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否系统指定值',
  `room_layout_attribute_is_filter` enum('0','1') NOT NULL DEFAULT '0' COMMENT '作为筛选',
  PRIMARY KEY (`room_layout_attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_attribute` */

insert  into `room_layout_attribute`(`room_layout_attribute_id`,`hotel_id`,`room_type`,`room_layout_attribute_father_id`,`room_layout_attribute_name`,`room_layout_attribute_order`,`room_layout_attribute_value_type`,`room_layout_attribute_value_type_default`,`room_layout_attribute_is_appoint`,`room_layout_attribute_is_filter`) values (1,0,'room',1,'基本设施',0,'',NULL,'0','1'),(2,0,'room',1,'采光',0,'radio','明窗|无窗|天井窗','1','1'),(3,0,'room',1,'卫生间',0,'radio','房间内独立卫生间|楼层共用卫生间|公寓内共用卫生间','1','1'),(4,0,'room',1,'制冷设施',0,'radio','无|风扇|中央空调|分体空调','1','1'),(5,0,'room',1,'加热设施',0,'radio','无|集中供热|地暖|中央空调|分体空调','1','1'),(6,0,'room',1,'新风设施',0,'radio','无|新风系统|空气净化器','1','1'),(7,0,'room',7,'娱乐设施',0,'radio','','0','1'),(8,0,'room',7,'电视',0,'',NULL,'0','1'),(9,0,'room',9,'商务设施',0,'',NULL,'0','1'),(10,0,'room',9,'电话',0,'',NULL,'0','1'),(11,0,'room',9,'网络',0,'',NULL,'0','1'),(12,0,'room',9,'WIFI',0,'text',NULL,'0','0'),(13,0,'room',13,'其他设施',0,'text',NULL,'0','0'),(15,2,'room',13,'可长租',0,'text',NULL,'0','0'),(16,2,'room',13,'婚房布置',0,'text',NULL,'0','0'),(17,2,'room',13,'其它',0,'text',NULL,'0','0');

/*Table structure for table `room_layout_attribute_laguage` */

DROP TABLE IF EXISTS `room_layout_attribute_laguage`;

CREATE TABLE `room_layout_attribute_laguage` (
  `room_layout_attribute_id` int(11) NOT NULL DEFAULT '0' COMMENT '客房属性',
  `multi_laguage` enum('English') DEFAULT NULL,
  `room_layout_attribute_name` varchar(100) NOT NULL COMMENT '客房属性名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_attribute_laguage` */

/*Table structure for table `room_layout_attribute_value` */

DROP TABLE IF EXISTS `room_layout_attribute_value`;

CREATE TABLE `room_layout_attribute_value` (
  `room_layout_id` int(11) NOT NULL,
  `room_layout_attribute_father_id` int(11) NOT NULL,
  `room_layout_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_layout_attribute_value` varchar(200) NOT NULL COMMENT '属性值',
  PRIMARY KEY (`room_layout_id`,`room_layout_attribute_id`,`hotel_id`,`room_layout_attribute_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_attribute_value` */

/*Table structure for table `room_layout_attribute_value_laguage` */

DROP TABLE IF EXISTS `room_layout_attribute_value_laguage`;

CREATE TABLE `room_layout_attribute_value_laguage` (
  `room_layout_attribute_value_id` int(11) NOT NULL DEFAULT '0',
  `multi_laguage` enum('English') DEFAULT NULL,
  `room_layout_attribute_value` varchar(200) NOT NULL COMMENT '属性值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_attribute_value_laguage` */

/*Table structure for table `room_layout_corp` */

DROP TABLE IF EXISTS `room_layout_corp`;

CREATE TABLE `room_layout_corp` (
  `room_layout_corp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '协议公司房型体系ID',
  `hotel_id` int(11) NOT NULL,
  `union_id` int(11) NOT NULL DEFAULT '0',
  `room_layout_corp_name` varchar(50) NOT NULL,
  `room_layout_corp_system` text NOT NULL,
  `room_layout_corp_add_datetime` datetime NOT NULL,
  PRIMARY KEY (`room_layout_corp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_corp` */

/*Table structure for table `room_layout_images` */

DROP TABLE IF EXISTS `room_layout_images`;

CREATE TABLE `room_layout_images` (
  `room_layout_images_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_layout_id` int(11) NOT NULL COMMENT '房型ID',
  `room_layout_images_name` varchar(100) DEFAULT NULL,
  `room_layout_images_path` varchar(200) NOT NULL DEFAULT '' COMMENT '路径',
  `room_layout_images_is_main` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是主图',
  `room_layout_images_recommend` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0' COMMENT '推荐图片，越高越排前',
  `room_layout_images_filesize` int(11) NOT NULL DEFAULT '0' COMMENT '图片大小',
  `room_layout_images_add_date` date NOT NULL,
  `room_layout_images_add_time` time NOT NULL,
  PRIMARY KEY (`room_layout_images_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_images` */

/*Table structure for table `room_layout_price` */

DROP TABLE IF EXISTS `room_layout_price`;

CREATE TABLE `room_layout_price` (
  `room_layout_price_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `room_sell_layout_id` bigint(19) NOT NULL COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL DEFAULT '0' COMMENT '基础房型ID',
  `hotel_id` int(11) NOT NULL,
  `room_layout_price_system_id` int(11) NOT NULL COMMENT '价格体系',
  `room_layout_price` double NOT NULL DEFAULT '0' COMMENT '基本价格',
  `room_layout_extra_bed_price` double NOT NULL DEFAULT '0' COMMENT '加床价格',
  `room_layout_price_begin_datetime` date NOT NULL COMMENT '开售时间',
  `room_layout_price_end_datetime` date NOT NULL DEFAULT '0000-00-00' COMMENT '结束时间',
  `room_layout_price_ahead_datetime` smallint(6) NOT NULL DEFAULT '0' COMMENT '提前预定时间 0 不限制',
  `room_layout_price_type` enum('base','custom') DEFAULT 'custom' COMMENT 'custom 自定义价格 base 基准价格',
  `room_layout_price_add_date` date NOT NULL COMMENT '房价添加时间',
  `room_layout_price_add_time` time NOT NULL COMMENT '房价添加时间',
  `room_layout_price_is_active` enum('0','1','-1') DEFAULT '1' COMMENT '是否在活动状态的价格 0不活动 1活动 -1删除',
  `employee_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作员工',
  `room_layout_date_year` enum('2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030') NOT NULL,
  `room_layout_date_month` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL,
  `room_layout_is_corp` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否协议公司',
  `room_layout_corp_id` int(11) NOT NULL DEFAULT '0' COMMENT '协议公司房型体系ID',
  `01_day` double DEFAULT NULL,
  `02_day` double DEFAULT NULL,
  `03_day` double DEFAULT NULL,
  `04_day` double DEFAULT NULL,
  `05_day` double DEFAULT NULL,
  `06_day` double DEFAULT NULL,
  `07_day` double DEFAULT NULL,
  `08_day` double DEFAULT NULL,
  `09_day` double DEFAULT NULL,
  `10_day` double DEFAULT NULL,
  `11_day` double DEFAULT NULL,
  `12_day` double DEFAULT NULL,
  `13_day` double DEFAULT NULL,
  `14_day` double DEFAULT NULL,
  `15_day` double DEFAULT NULL,
  `16_day` double DEFAULT NULL,
  `17_day` double DEFAULT NULL,
  `18_day` double DEFAULT NULL,
  `19_day` double DEFAULT NULL,
  `20_day` double DEFAULT NULL,
  `21_day` double DEFAULT NULL,
  `22_day` double DEFAULT NULL,
  `23_day` double DEFAULT NULL,
  `24_day` double DEFAULT NULL,
  `25_day` double DEFAULT NULL,
  `26_day` double DEFAULT NULL,
  `27_day` double DEFAULT NULL,
  `28_day` double DEFAULT NULL,
  `29_day` double DEFAULT NULL,
  `30_day` double DEFAULT NULL,
  `31_day` double DEFAULT NULL,
  PRIMARY KEY (`room_layout_price_id`),
  UNIQUE KEY `room_price` (`hotel_id`,`room_layout_price_system_id`,`room_layout_date_year`,`room_layout_date_month`,`room_sell_layout_id`,`room_layout_is_corp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_price` */

/*Table structure for table `room_layout_price_extra_bed` */

DROP TABLE IF EXISTS `room_layout_price_extra_bed`;

CREATE TABLE `room_layout_price_extra_bed` (
  `room_sell_layout_id` bigint(19) NOT NULL,
  `room_layout_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖房型ID',
  `hotel_id` int(11) NOT NULL,
  `room_layout_price_system_id` int(11) NOT NULL COMMENT '价格体系',
  `room_layout_price_add_date` date NOT NULL COMMENT '添加时间',
  `room_layout_price_add_time` time NOT NULL COMMENT '添加时间',
  `room_layout_price_is_active` enum('0','1','-1') DEFAULT '1' COMMENT '是否在活动状态的价格 0不活动 1活动 -1删除',
  `employee_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作员工',
  `room_layout_price_begin_datetime` date DEFAULT NULL,
  `room_layout_date_year` enum('2016','2017','2018','2019','2020','2021','2022','2023','2024','2025','2026','2027','2028','2029','2030') NOT NULL,
  `room_layout_date_month` enum('1','2','3','4','5','6','7','8','9','10','11','12') NOT NULL,
  `room_layout_is_corp` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否协议公司',
  `room_layout_corp_id` int(11) NOT NULL COMMENT '协议公司房型体系ID',
  `01_day` double DEFAULT NULL,
  `02_day` double DEFAULT NULL,
  `03_day` double DEFAULT NULL,
  `04_day` double DEFAULT NULL,
  `05_day` double DEFAULT NULL,
  `06_day` double DEFAULT NULL,
  `07_day` double DEFAULT NULL,
  `08_day` double DEFAULT NULL,
  `09_day` double DEFAULT NULL,
  `10_day` double DEFAULT NULL,
  `11_day` double DEFAULT NULL,
  `12_day` double DEFAULT NULL,
  `13_day` double DEFAULT NULL,
  `14_day` double DEFAULT NULL,
  `15_day` double DEFAULT NULL,
  `16_day` double DEFAULT NULL,
  `17_day` double DEFAULT NULL,
  `18_day` double DEFAULT NULL,
  `19_day` double DEFAULT NULL,
  `20_day` double DEFAULT NULL,
  `21_day` double DEFAULT NULL,
  `22_day` double DEFAULT NULL,
  `23_day` double DEFAULT NULL,
  `24_day` double DEFAULT NULL,
  `25_day` double DEFAULT NULL,
  `26_day` double DEFAULT NULL,
  `27_day` double DEFAULT NULL,
  `28_day` double DEFAULT NULL,
  `29_day` double DEFAULT NULL,
  `30_day` double DEFAULT NULL,
  `31_day` double DEFAULT NULL,
  PRIMARY KEY (`room_sell_layout_id`,`room_layout_id`,`hotel_id`,`room_layout_price_system_id`,`room_layout_date_year`,`room_layout_date_month`,`room_layout_is_corp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_price_extra_bed` */

/*Table structure for table `room_layout_price_system` */

DROP TABLE IF EXISTS `room_layout_price_system`;

CREATE TABLE `room_layout_price_system` (
  `room_layout_price_system_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '价格体系ID',
  `room_sell_layout_id` bigint(19) NOT NULL COMMENT '售卖房型ID',
  `room_layout_id` int(11) NOT NULL DEFAULT '0' COMMENT '基础房型ID',
  `room_layout_is_corp` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否协议公司',
  `room_layout_corp_id` int(11) NOT NULL DEFAULT '0' COMMENT '协议公司房型体系ID',
  `room_layout_price_system_name` varchar(200) NOT NULL COMMENT '价格体系名称',
  `hotel_id` int(11) NOT NULL COMMENT '酒店名称',
  `room_layout_price_system_add_date` date NOT NULL,
  `room_layout_price_system_add_time` time NOT NULL,
  `room_layout_price_system_valid` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否有效 1有效 0无效',
  PRIMARY KEY (`room_layout_price_system_id`),
  UNIQUE KEY `room_layout_price_system_name` (`room_layout_price_system_name`,`hotel_id`,`room_layout_price_system_id`,`room_layout_id`,`room_layout_price_system_valid`,`room_layout_is_corp`),
  KEY `hotel_id` (`hotel_id`,`room_layout_id`,`room_layout_is_corp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_price_system` */

/*Table structure for table `room_layout_price_system_filter` */

DROP TABLE IF EXISTS `room_layout_price_system_filter`;

CREATE TABLE `room_layout_price_system_filter` (
  `room_layout_price_system_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `hotel_service_id` int(11) NOT NULL,
  PRIMARY KEY (`room_layout_price_system_id`,`hotel_id`,`hotel_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_price_system_filter` */

/*Table structure for table `room_layout_room` */

DROP TABLE IF EXISTS `room_layout_room`;

CREATE TABLE `room_layout_room` (
  `room_layout_id` int(11) NOT NULL COMMENT '房型',
  `hotel_id` int(11) NOT NULL COMMENT '酒店ID',
  `room_id` int(11) NOT NULL COMMENT '对应真正的客房号',
  `room_layout_room_max_people` tinyint(3) NOT NULL COMMENT '最多住几人',
  `room_layout_room_max_children` tinyint(3) NOT NULL DEFAULT '0' COMMENT '最多住几个小孩 0不能住小孩',
  `room_layout_room_extra_bed` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否可加床 0不可以',
  `room_layout_room_orientations` varchar(10) DEFAULT NULL COMMENT '朝向',
  PRIMARY KEY (`room_layout_id`,`hotel_id`,`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_room` */

/*Table structure for table `room_layout_type` */

DROP TABLE IF EXISTS `room_layout_type`;

CREATE TABLE `room_layout_type` (
  `room_layout_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` int(11) DEFAULT NULL,
  `room_layout_type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`room_layout_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `room_layout_type` */

insert  into `room_layout_type`(`room_layout_type_id`,`hotel_id`,`room_layout_type_name`) values (1,0,'单人间'),(2,0,'双人间'),(3,0,'多人间'),(4,0,'家庭间'),(5,0,'套房'),(6,0,'度假小屋'),(7,0,'整套公寓'),(8,0,'整个公寓中的一个独立房间'),(9,0,'宿舍间'),(10,0,'宿舍间床位'),(11,0,'院子'),(12,0,'别墅'),(13,0,'集装箱'),(14,0,'房车'),(15,0,'帐篷'),(16,0,'胶囊'),(17,0,'可用于休息的某个场景');

/*Table structure for table `room_sell_layout` */

DROP TABLE IF EXISTS `room_sell_layout`;

CREATE TABLE `room_sell_layout` (
  `room_sell_layout_id` bigint(19) NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint(19) NOT NULL,
  `room_layout_id` bigint(19) NOT NULL,
  `room_sell_layout_name` varchar(50) NOT NULL,
  `room_sell_layout_valid` enum('0','1') NOT NULL DEFAULT '1' COMMENT '有效无效',
  `room_sell_add_date` date NOT NULL,
  `room_sell_add_time` time NOT NULL,
  PRIMARY KEY (`room_sell_layout_id`),
  KEY `hotel_id` (`hotel_id`,`room_sell_layout_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `room_sell_layout` */

/*Table structure for table `room_type` */

DROP TABLE IF EXISTS `room_type`;

CREATE TABLE `room_type` (
  `room_type_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint(11) NOT NULL DEFAULT '0',
  `room_type_name` varchar(50) NOT NULL COMMENT '名称',
  `room_type_key` varchar(50) DEFAULT NULL,
  `room_type_type` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `room_type` */

insert  into `room_type`(`room_type_id`,`hotel_id`,`room_type_name`,`room_type_key`,`room_type_type`) values (1,0,'客房','room',1),(2,0,'餐厅','restaurant',1),(3,0,'会议室','meeting room',0),(4,0,'多功能厅','multiple-function hall',0),(5,0,'花园','garden',0),(6,0,'露台','gazebo',0),(7,0,'办公室','office',0),(8,0,'设备间','equipment room',0),(9,0,'仓库','store',0),(10,0,'厨房','dining',0);

/*Table structure for table `rooms_layout_attribute` */

DROP TABLE IF EXISTS `rooms_layout_attribute`;

CREATE TABLE `rooms_layout_attribute` (
  `room_layout_id` int(11) NOT NULL,
  `room_attribute_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  PRIMARY KEY (`room_layout_id`,`room_attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `rooms_layout_attribute` */

/*Table structure for table `union` */

DROP TABLE IF EXISTS `union`;

CREATE TABLE `union` (
  `union_id` int(11) NOT NULL AUTO_INCREMENT,
  `union_name` varchar(50) NOT NULL,
  `union_add_datetime` datetime NOT NULL,
  PRIMARY KEY (`union_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `union` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` bigint(19) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名字',
  `user_sex` enum('男','女') NOT NULL COMMENT '性别',
  `user_birthday` date DEFAULT NULL COMMENT '用户生日',
  `user_address` varchar(200) DEFAULT NULL COMMENT '用户住址',
  `user_photo` varchar(200) DEFAULT NULL COMMENT '用户头像',
  `user_id_card_type` varchar(200) NOT NULL DEFAULT '' COMMENT '证件类型',
  `user_id_card` varchar(200) NOT NULL DEFAULT '' COMMENT '证件号',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

/*Table structure for table `user_login` */

DROP TABLE IF EXISTS `user_login`;

CREATE TABLE `user_login` (
  `user_id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '登录用户ID',
  `user_password` varchar(50) NOT NULL COMMENT '密码',
  `user_salt` varchar(50) NOT NULL COMMENT '盐',
  `user_login_name` varchar(50) NOT NULL DEFAULT '' COMMENT '登录名',
  `user_id_card` varchar(50) DEFAULT NULL COMMENT '身份证',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录email',
  `user_email_confirm` bit(1) NOT NULL DEFAULT b'0' COMMENT 'email是否确认',
  `user_mobile` bigint(11) NOT NULL COMMENT '登录mobile',
  `user_mobile_confirm` bit(1) NOT NULL DEFAULT b'0' COMMENT 'mobile是否确认',
  `book_type_id` int(11) DEFAULT NULL COMMENT '会员级别',
  `book_discount_id` int(11) DEFAULT NULL COMMENT '折扣ID',
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
  `user_activate` enum('0','1') NOT NULL DEFAULT '0' COMMENT '用户是否激活 0未激活 1激活',
  PRIMARY KEY (`user_login_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_login_log` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
