/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50616
 Source Host           : localhost
 Source Database       : zuitu_db

 Target Server Type    : MySQL
 Target Server Version : 50616
 File Encoding         : utf-8

 Date: 04/05/2014 17:13:02 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `ask`
-- ----------------------------
DROP TABLE IF EXISTS `ask`;
CREATE TABLE `ask` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('ask','transfer') NOT NULL DEFAULT 'ask',
  `content` text,
  `comment` text,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `card`
-- ----------------------------
DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `id` varchar(16) NOT NULL,
  `code` varchar(16) DEFAULT NULL,
  `partner_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `credit` int(10) unsigned NOT NULL DEFAULT '0',
  `consume` enum('Y','N') NOT NULL DEFAULT 'N',
  `ip` varchar(16) DEFAULT NULL,
  `begin_time` int(10) unsigned NOT NULL DEFAULT '0',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `cart`
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `detail` text,
  `money` double(10,2) NOT NULL DEFAULT '0.00',
  `action` varchar(16) NOT NULL DEFAULT 'buy',
  `state` varchar(16) NOT NULL DEFAULT 'unpay',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zone` varchar(16) DEFAULT NULL,
  `czone` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `ename` varchar(16) DEFAULT NULL,
  `letter` char(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `display` enum('Y','N') NOT NULL DEFAULT 'Y',
  `relate_data` text,
  `fid` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_zne` (`zone`,`name`,`ename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `coupon`
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` varchar(16) NOT NULL DEFAULT '',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `partner_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('consume','credit') NOT NULL DEFAULT 'consume',
  `credit` int(10) unsigned NOT NULL DEFAULT '0',
  `secret` varchar(10) DEFAULT NULL,
  `consume` enum('Y','N') NOT NULL DEFAULT 'N',
  `ip` varchar(16) DEFAULT NULL,
  `sms` int(10) unsigned NOT NULL DEFAULT '0',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  `consume_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `sms_time` int(10) unsigned NOT NULL DEFAULT '0',
  `buy_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `credit`
-- ----------------------------
DROP TABLE IF EXISTS `credit`;
CREATE TABLE `credit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `detail_id` varchar(32) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `score` double(10,2) NOT NULL DEFAULT '0.00',
  `action` varchar(16) NOT NULL DEFAULT 'buy',
  `rname` varchar(32) DEFAULT NULL,
  `rmobile` varchar(32) DEFAULT NULL,
  `rcode` char(6) DEFAULT NULL,
  `raddress` varchar(128) DEFAULT NULL,
  `send_time` int(10) DEFAULT NULL,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `state` enum('unpay','pay') NOT NULL DEFAULT 'unpay',
  `remark` text,
  `op_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `daysign`
-- ----------------------------
DROP TABLE IF EXISTS `daysign`;
CREATE TABLE `daysign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `credit` double(10,2) DEFAULT '0.00',
  `money` double(10,2) DEFAULT '0.00',
  `create_time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `feedback`
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `category` enum('suggest','seller') NOT NULL DEFAULT 'suggest',
  `title` varchar(128) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `content` text,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `flow`
-- ----------------------------
DROP TABLE IF EXISTS `flow`;
CREATE TABLE `flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `detail_id` varchar(32) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `direction` enum('income','expense') NOT NULL DEFAULT 'income',
  `money` double(10,2) NOT NULL DEFAULT '0.00',
  `action` varchar(16) NOT NULL DEFAULT 'buy',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `friendlink`
-- ----------------------------
DROP TABLE IF EXISTS `friendlink`;
CREATE TABLE `friendlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `display` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_l` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `image` varchar(128) DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `number` int(11) NOT NULL DEFAULT '0',
  `per_number` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `consume` int(11) NOT NULL DEFAULT '0',
  `display` enum('Y','N') NOT NULL DEFAULT 'Y',
  `enable` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `invite`
-- ----------------------------
DROP TABLE IF EXISTS `invite`;
CREATE TABLE `invite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_ip` varchar(16) DEFAULT NULL,
  `other_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `other_user_ip` varchar(16) DEFAULT NULL,
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pay` enum('Y','N','C') NOT NULL DEFAULT 'N',
  `credit` int(10) unsigned NOT NULL DEFAULT '0',
  `buy_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_uo` (`user_id`,`other_user_id`),
  UNIQUE KEY `UNQ_o` (`other_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `logger_admin`
-- ----------------------------
DROP TABLE IF EXISTS `logger_admin`;
CREATE TABLE `logger_admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `user_email` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `operation` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `relate_data` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `create_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `logger_admin`
-- ----------------------------
BEGIN;
INSERT INTO `logger_admin` VALUES ('1', '1', 'lbzqh156@gmail.com', 'system', '编辑选项设置', 'a:2:{s:6:\"option\";a:35:{s:10:\"navcomment\";s:1:\"N\";s:10:\"navpredict\";s:1:\"N\";s:10:\"navpartner\";s:1:\"N\";s:10:\"navseconds\";s:1:\"N\";s:8:\"navgoods\";s:1:\"N\";s:8:\"navforum\";s:1:\"N\";s:12:\"buycouponsms\";s:1:\"N\";s:12:\"usecouponsms\";s:1:\"N\";s:13:\"expressbuysms\";s:1:\"N\";s:14:\"displayfailure\";s:1:\"N\";s:7:\"teamask\";s:1:\"N\";s:13:\"creditseconds\";s:1:\"N\";s:12:\"smssubscribe\";s:1:\"N\";s:8:\"trsimple\";s:1:\"N\";s:9:\"moneysave\";s:1:\"N\";s:9:\"teamwhole\";s:1:\"N\";s:8:\"encodeid\";s:1:\"N\";s:11:\"userprivacy\";s:1:\"N\";s:10:\"usercredit\";s:1:\"N\";s:10:\"creditshop\";s:1:\"N\";s:9:\"citylocal\";s:1:\"N\";s:8:\"mycoupon\";s:1:\"N\";s:10:\"bindmobile\";s:1:\"N\";s:7:\"daysign\";s:1:\"N\";s:6:\"widget\";s:1:\"N\";s:10:\"onlycoupon\";s:1:\"N\";s:13:\"indexcateteam\";s:1:\"N\";s:8:\"cateteam\";s:1:\"N\";s:11:\"catepartner\";s:1:\"N\";s:11:\"citypartner\";s:1:\"N\";s:11:\"cateseconds\";s:1:\"N\";s:9:\"categoods\";s:1:\"N\";s:11:\"emailverify\";s:1:\"Y\";s:10:\"needmobile\";s:1:\"Y\";s:10:\"mobilecode\";s:1:\"N\";}s:6:\"system\";a:1:{s:6:\"editor\";s:4:\"kind\";}}', '2014-03-12 19:57:14');
COMMIT;

-- ----------------------------
--  Table structure for `mailer`
-- ----------------------------
DROP TABLE IF EXISTS `mailer`;
CREATE TABLE `mailer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `secret` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_e` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `news`
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `detail` text,
  `begin_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(32) DEFAULT NULL,
  `buy_id` int(11) NOT NULL DEFAULT '0',
  `service` varchar(16) NOT NULL DEFAULT 'alipay',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `card_id` varchar(16) DEFAULT NULL,
  `state` enum('unpay','pay') NOT NULL DEFAULT 'unpay',
  `allowrefund` enum('Y','N') NOT NULL DEFAULT 'N',
  `rstate` enum('normal','askrefund','berefund','norefund') NOT NULL DEFAULT 'normal',
  `rereason` text,
  `retime` int(11) DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '1',
  `realname` varchar(32) DEFAULT NULL,
  `mobile` varchar(128) DEFAULT NULL,
  `zipcode` char(6) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `express` enum('Y','N') NOT NULL DEFAULT 'Y',
  `express_xx` varchar(128) DEFAULT NULL,
  `express_id` int(10) unsigned NOT NULL DEFAULT '0',
  `express_no` varchar(32) DEFAULT NULL,
  `price` double(10,2) NOT NULL DEFAULT '0.00',
  `money` double(10,2) NOT NULL DEFAULT '0.00',
  `origin` double(10,2) NOT NULL DEFAULT '0.00',
  `credit` double(10,2) NOT NULL DEFAULT '0.00',
  `card` double(10,2) NOT NULL DEFAULT '0.00',
  `fare` double(10,2) NOT NULL DEFAULT '0.00',
  `condbuy` varchar(128) DEFAULT NULL,
  `remark` text,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0',
  `comment_content` text,
  `comment_display` enum('Y','N') NOT NULL DEFAULT 'Y',
  `comment_grade` enum('good','none','bad') NOT NULL DEFAULT 'good',
  `comment_wantmore` enum('Y','N') DEFAULT NULL,
  `comment_time` int(11) DEFAULT NULL,
  `partner_id` int(11) NOT NULL DEFAULT '0',
  `sms_express` enum('Y','N') NOT NULL DEFAULT 'N',
  `luky_id` int(11) NOT NULL DEFAULT '0',
  `adminremark` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_p` (`pay_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `page`
-- ----------------------------
DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `id` varchar(16) NOT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `partner`
-- ----------------------------
DROP TABLE IF EXISTS `partner`;
CREATE TABLE `partner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `homepage` varchar(128) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bank_name` varchar(128) DEFAULT NULL,
  `bank_no` varchar(128) DEFAULT NULL,
  `bank_user` varchar(128) DEFAULT NULL,
  `location` text NOT NULL,
  `contact` varchar(32) DEFAULT NULL,
  `image` varchar(128) DEFAULT NULL,
  `image1` varchar(128) DEFAULT NULL,
  `image2` varchar(128) DEFAULT NULL,
  `phone` varchar(18) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `other` text,
  `mobile` varchar(12) DEFAULT NULL,
  `open` enum('Y','N') NOT NULL DEFAULT 'N',
  `enable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `head` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `longlat` varchar(255) DEFAULT NULL,
  `display` enum('Y','N') NOT NULL DEFAULT 'Y',
  `comment_good` int(11) NOT NULL DEFAULT '0',
  `comment_none` int(11) NOT NULL DEFAULT '0',
  `comment_bad` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_ct` (`city_id`,`title`),
  UNIQUE KEY `UNQ_u` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `pay`
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `vid` varchar(32) DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bank` varchar(32) DEFAULT NULL,
  `money` double(10,2) DEFAULT NULL,
  `currency` enum('CNY','USD') NOT NULL DEFAULT 'CNY',
  `service` varchar(16) NOT NULL DEFAULT 'alipay',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_o` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `paycard`
-- ----------------------------
DROP TABLE IF EXISTS `paycard`;
CREATE TABLE `paycard` (
  `id` varchar(16) NOT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `consume` enum('Y','N') NOT NULL DEFAULT 'N',
  `recharge_time` int(10) unsigned NOT NULL DEFAULT '0',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `referer`
-- ----------------------------
DROP TABLE IF EXISTS `referer`;
CREATE TABLE `referer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL COMMENT '??id',
  `referer` varchar(400) COLLATE utf8_unicode_ci NOT NULL COMMENT '??',
  `create_time` int(10) unsigned NOT NULL COMMENT '????',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_o` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='??';

-- ----------------------------
--  Table structure for `smssubscribe`
-- ----------------------------
DROP TABLE IF EXISTS `smssubscribe`;
CREATE TABLE `smssubscribe` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` varchar(18) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `secret` char(6) DEFAULT NULL,
  `enable` enum('Y','N') NOT NULL DEFAULT 'N',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_e` (`mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `subscribe`
-- ----------------------------
DROP TABLE IF EXISTS `subscribe`;
CREATE TABLE `subscribe` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `secret` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_e` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `subscribe`
-- ----------------------------
BEGIN;
INSERT INTO `subscribe` VALUES ('1', 'lbzqh156@gmail.com', '0', 'd58473b4f1449562b777986e9ffe05bd');
COMMIT;

-- ----------------------------
--  Table structure for `system`
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `id` enum('1') NOT NULL DEFAULT '1',
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `system`
-- ----------------------------
BEGIN;
INSERT INTO `system` VALUES ('1', 'eyJkYiI6eyJob3N0IjoiMTI3LjAuMC4xIiwidXNlciI6InJvb3QiLCJwYXNzIjoiMTIzNDU2IiwibmFtZSI6Inp1aXR1X2RiIn0sIm1lbWNhY2hlIjpudWxsLCJ3ZWJyb290IjpudWxsLCJzeXN0ZW0iOnsid3d3cHJlZml4IjoiaHR0cDpcL1wvenVpdHUuaXRyb24ubWUiLCJpbWdwcmVmaXgiOiJodHRwOlwvXC96dWl0dS5pdHJvbi5tZSIsImNzc3ByZWZpeCI6Imh0dHA6XC9cL3p1aXR1Lml0cm9uLm1lIiwic2l0ZW5hbWUiOiJcdTY3MDBcdTU3MWZcdTdmNTEiLCJzaXRldGl0bGUiOiJcdTdjYmVcdTU0YzFcdTU2ZTJcdThkMmRcdTZiY2ZcdTRlMDBcdTU5MjkiLCJhYmJyZXZpYXRpb24iOiJcdTY3MDBcdTU3MWYiLCJjb3Vwb25uYW1lIjoiXHU0ZjE4XHU2MGUwXHU1MjM4IiwiY3VycmVuY3kiOiImIzE2NTsiLCJjdXJyZW5jeW5hbWUiOiJDTlkiLCJ0aW1lem9uZSI6IkV0Y1wvR01ULTgiLCJlZGl0b3IiOiJraW5kIn0sImJ1bGxldGluIjpudWxsLCJhbGlwYXkiOm51bGwsInRlbnBheSI6bnVsbCwic2RvcGF5IjpudWxsLCJiaWxsIjpudWxsLCJjaGluYWJhbmsiOm51bGwsInBheXBhbCI6bnVsbCwieWVlcGF5IjpudWxsLCJjbXBheSI6bnVsbCwiZ29wYXkiOm51bGwsIm90aGVyIjpudWxsLCJvcHRpb24iOnsibmF2Y29tbWVudCI6Ik4iLCJuYXZwcmVkaWN0IjoiTiIsIm5hdnBhcnRuZXIiOiJOIiwibmF2c2Vjb25kcyI6Ik4iLCJuYXZnb29kcyI6Ik4iLCJuYXZmb3J1bSI6Ik4iLCJidXljb3Vwb25zbXMiOiJOIiwidXNlY291cG9uc21zIjoiTiIsImV4cHJlc3NidXlzbXMiOiJOIiwiZGlzcGxheWZhaWx1cmUiOiJOIiwidGVhbWFzayI6Ik4iLCJjcmVkaXRzZWNvbmRzIjoiTiIsInNtc3N1YnNjcmliZSI6Ik4iLCJ0cnNpbXBsZSI6Ik4iLCJtb25leXNhdmUiOiJOIiwidGVhbXdob2xlIjoiTiIsImVuY29kZWlkIjoiTiIsInVzZXJwcml2YWN5IjoiTiIsInVzZXJjcmVkaXQiOiJOIiwiY3JlZGl0c2hvcCI6Ik4iLCJjaXR5bG9jYWwiOiJOIiwibXljb3Vwb24iOiJOIiwiYmluZG1vYmlsZSI6Ik4iLCJkYXlzaWduIjoiTiIsIndpZGdldCI6Ik4iLCJvbmx5Y291cG9uIjoiTiIsImluZGV4Y2F0ZXRlYW0iOiJOIiwiY2F0ZXRlYW0iOiJOIiwiY2F0ZXBhcnRuZXIiOiJOIiwiY2l0eXBhcnRuZXIiOiJOIiwiY2F0ZXNlY29uZHMiOiJOIiwiY2F0ZWdvb2RzIjoiTiIsImVtYWlsdmVyaWZ5IjoiWSIsIm5lZWRtb2JpbGUiOiJZIiwibW9iaWxlY29kZSI6Ik4ifSwibWFpbCI6eyJlbmNvZGluZyI6IlVURi04In0sInNtcyI6bnVsbCwiY3JlZGl0IjpudWxsLCJza2luIjpudWxsLCJhdXRob3JpemF0aW9uIjpudWxsLCJzaW5hIjpudWxsLCJxcSI6bnVsbCwicXpvbmUiOm51bGx9');
COMMIT;

-- ----------------------------
--  Table structure for `team`
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(128) DEFAULT NULL,
  `summary` text,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `city_ids` text,
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `partner_id` int(10) unsigned NOT NULL DEFAULT '0',
  `system` enum('Y','N') NOT NULL DEFAULT 'Y',
  `team_price` double(10,2) NOT NULL DEFAULT '0.00',
  `market_price` double(10,2) NOT NULL DEFAULT '0.00',
  `product` varchar(128) DEFAULT NULL,
  `condbuy` varchar(255) DEFAULT NULL,
  `per_number` int(10) unsigned NOT NULL DEFAULT '1',
  `permin_number` int(10) DEFAULT '1',
  `min_number` int(10) unsigned NOT NULL DEFAULT '1',
  `max_number` int(10) unsigned NOT NULL DEFAULT '0',
  `now_number` int(10) unsigned NOT NULL DEFAULT '0',
  `pre_number` int(10) unsigned NOT NULL DEFAULT '0',
  `allowrefund` enum('Y','N') NOT NULL DEFAULT 'N',
  `image` varchar(128) DEFAULT NULL,
  `image1` varchar(128) DEFAULT NULL,
  `image2` varchar(128) DEFAULT NULL,
  `flv` varchar(128) DEFAULT NULL,
  `mobile` varchar(16) DEFAULT NULL,
  `credit` int(10) unsigned NOT NULL DEFAULT '0',
  `card` int(10) unsigned NOT NULL DEFAULT '0',
  `fare` int(10) unsigned NOT NULL DEFAULT '0',
  `farefree` int(11) NOT NULL DEFAULT '0',
  `bonus` int(11) NOT NULL DEFAULT '0',
  `address` varchar(128) DEFAULT NULL,
  `detail` text,
  `systemreview` text,
  `userreview` text,
  `notice` text,
  `express` text,
  `delivery` varchar(16) NOT NULL DEFAULT 'coupon',
  `state` enum('none','success','soldout','failure','refund') NOT NULL DEFAULT 'none',
  `conduser` enum('Y','N') NOT NULL DEFAULT 'Y',
  `buyonce` enum('Y','N') NOT NULL DEFAULT 'Y',
  `team_type` varchar(20) DEFAULT 'normal',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  `begin_time` int(10) unsigned NOT NULL DEFAULT '0',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0',
  `reach_time` int(10) unsigned NOT NULL DEFAULT '0',
  `close_time` int(10) unsigned NOT NULL DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keyword` varchar(255) DEFAULT NULL,
  `seo_description` text,
  `express_relate` text,
  `sub_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `toolsbind`
-- ----------------------------
DROP TABLE IF EXISTS `toolsbind`;
CREATE TABLE `toolsbind` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `tools` varchar(16) NOT NULL,
  `secret` varchar(16) DEFAULT NULL,
  `enable` enum('Y','N') NOT NULL,
  `create_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `topic`
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(128) DEFAULT NULL,
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `public_id` int(10) unsigned NOT NULL DEFAULT '0',
  `content` text,
  `head` int(10) unsigned NOT NULL DEFAULT '0',
  `reply_number` int(10) unsigned NOT NULL DEFAULT '0',
  `view_number` int(10) unsigned NOT NULL DEFAULT '0',
  `last_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `realname` varchar(32) DEFAULT NULL,
  `alipay_id` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `gender` enum('M','F') NOT NULL DEFAULT 'M',
  `newbie` enum('Y','N') NOT NULL DEFAULT 'Y',
  `mobile` varchar(16) DEFAULT NULL,
  `qq` varchar(16) DEFAULT NULL,
  `money` double(10,2) NOT NULL DEFAULT '0.00',
  `score` int(11) NOT NULL DEFAULT '0',
  `zipcode` char(6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL DEFAULT '0',
  `emailable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `enable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `manager` enum('Y','N') NOT NULL DEFAULT 'N',
  `secret` varchar(32) DEFAULT NULL,
  `recode` varchar(32) DEFAULT NULL,
  `sns` varchar(64) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `login_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `mobilecode` char(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_name` (`username`),
  UNIQUE KEY `UNQ_e` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('1', 'lbzqh156@gmail.com', 'auioh413', null, null, 'e7fe8b88db51d86ef2f5e169144b9c1b', null, 'M', 'Y', '18695636303', null, '0.00', '0', null, null, '0', 'Y', 'Y', 'Y', '', null, null, '127.0.0.1', '1394625371', '1394625371', null);
COMMIT;

-- ----------------------------
--  Table structure for `vote_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `vote_feedback`;
CREATE TABLE `vote_feedback` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `addtime` char(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `vote_feedback_input`
-- ----------------------------
DROP TABLE IF EXISTS `vote_feedback_input`;
CREATE TABLE `vote_feedback_input` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feedback_id` bigint(20) unsigned NOT NULL,
  `options_id` mediumint(8) unsigned NOT NULL,
  `value` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `vote_feedback_question`
-- ----------------------------
DROP TABLE IF EXISTS `vote_feedback_question`;
CREATE TABLE `vote_feedback_question` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feedback_id` bigint(20) unsigned NOT NULL,
  `question_id` mediumint(8) unsigned NOT NULL,
  `options_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `vote_options`
-- ----------------------------
DROP TABLE IF EXISTS `vote_options`;
CREATE TABLE `vote_options` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` mediumint(8) unsigned NOT NULL,
  `name` varchar(60) NOT NULL,
  `is_br` char(1) NOT NULL DEFAULT '0',
  `is_input` char(1) NOT NULL DEFAULT '0',
  `is_show` char(1) NOT NULL DEFAULT '1',
  `order` mediumint(8) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `vote_question`
-- ----------------------------
DROP TABLE IF EXISTS `vote_question`;
CREATE TABLE `vote_question` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'radio',
  `is_show` char(1) NOT NULL DEFAULT '1',
  `addtime` char(10) NOT NULL,
  `order` mediumint(8) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `voucher`
-- ----------------------------
DROP TABLE IF EXISTS `voucher`;
CREATE TABLE `voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sms` int(10) unsigned NOT NULL DEFAULT '0',
  `sms_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_ct` (`code`,`team_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
