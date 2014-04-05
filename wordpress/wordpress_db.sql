/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50616
 Source Host           : localhost
 Source Database       : wordpress_db

 Target Server Type    : MySQL
 Target Server Version : 50616
 File Encoding         : utf-8

 Date: 04/05/2014 18:37:39 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `wp_commentmeta`
-- ----------------------------
DROP TABLE IF EXISTS `wp_commentmeta`;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wp_comments`
-- ----------------------------
DROP TABLE IF EXISTS `wp_comments`;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_comments`
-- ----------------------------
BEGIN;
INSERT INTO `wp_comments` VALUES ('1', '1', 'WordPress先生', '', 'http://wordpress.org/', '', '2014-04-05 10:36:07', '2014-04-05 10:36:07', '您好，这是一条评论。\n要删除评论，请先登录，然后再查看这篇文章的评论。登录后您可以看到编辑或者删除评论的选项。', '0', '1', '', '', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `wp_links`
-- ----------------------------
DROP TABLE IF EXISTS `wp_links`;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `wp_options`
-- ----------------------------
DROP TABLE IF EXISTS `wp_options`;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_options`
-- ----------------------------
BEGIN;
INSERT INTO `wp_options` VALUES ('1', 'siteurl', 'http://wordpress.itron.me', 'yes'), ('2', 'blogname', 'iTron WP', 'yes'), ('3', 'blogdescription', '又一个WordPress站点', 'yes'), ('4', 'users_can_register', '0', 'yes'), ('5', 'admin_email', 'lbzqh156@gmail.com', 'yes'), ('6', 'start_of_week', '1', 'yes'), ('7', 'use_balanceTags', '0', 'yes'), ('8', 'use_smilies', '1', 'yes'), ('9', 'require_name_email', '1', 'yes'), ('10', 'comments_notify', '1', 'yes'), ('11', 'posts_per_rss', '10', 'yes'), ('12', 'rss_use_excerpt', '0', 'yes'), ('13', 'mailserver_url', 'mail.example.com', 'yes'), ('14', 'mailserver_login', 'login@example.com', 'yes'), ('15', 'mailserver_pass', 'password', 'yes'), ('16', 'mailserver_port', '110', 'yes'), ('17', 'default_category', '1', 'yes'), ('18', 'default_comment_status', 'open', 'yes'), ('19', 'default_ping_status', 'open', 'yes'), ('20', 'default_pingback_flag', '1', 'yes'), ('21', 'posts_per_page', '10', 'yes'), ('22', 'date_format', 'Y年n月j日', 'yes'), ('23', 'time_format', 'ag:i', 'yes'), ('24', 'links_updated_date_format', 'Y年n月j日ag:i', 'yes'), ('25', 'links_recently_updated_prepend', '<em>', 'yes'), ('26', 'links_recently_updated_append', '</em>', 'yes'), ('27', 'links_recently_updated_time', '120', 'yes'), ('28', 'comment_moderation', '0', 'yes'), ('29', 'moderation_notify', '1', 'yes'), ('30', 'permalink_structure', '', 'yes'), ('31', 'gzipcompression', '0', 'yes'), ('32', 'hack_file', '0', 'yes'), ('33', 'blog_charset', 'UTF-8', 'yes'), ('34', 'moderation_keys', '', 'no'), ('35', 'active_plugins', 'a:0:{}', 'yes'), ('36', 'home', 'http://wordpress.itron.me', 'yes'), ('37', 'category_base', '', 'yes'), ('38', 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'), ('39', 'advanced_edit', '0', 'yes'), ('40', 'comment_max_links', '2', 'yes'), ('41', 'gmt_offset', '0', 'yes'), ('42', 'default_email_category', '1', 'yes'), ('43', 'recently_edited', '', 'no'), ('44', 'template', 'twentythirteen', 'yes'), ('45', 'stylesheet', 'twentythirteen', 'yes'), ('46', 'comment_whitelist', '1', 'yes'), ('47', 'blacklist_keys', '', 'no'), ('48', 'comment_registration', '0', 'yes'), ('49', 'html_type', 'text/html', 'yes'), ('50', 'use_trackback', '0', 'yes'), ('51', 'default_role', 'subscriber', 'yes'), ('52', 'db_version', '25824', 'yes'), ('53', 'uploads_use_yearmonth_folders', '1', 'yes'), ('54', 'upload_path', '', 'yes'), ('55', 'blog_public', '1', 'yes'), ('56', 'default_link_category', '2', 'yes'), ('57', 'show_on_front', 'posts', 'yes'), ('58', 'tag_base', '', 'yes'), ('59', 'show_avatars', '1', 'yes'), ('60', 'avatar_rating', 'G', 'yes'), ('61', 'upload_url_path', '', 'yes'), ('62', 'thumbnail_size_w', '150', 'yes'), ('63', 'thumbnail_size_h', '150', 'yes'), ('64', 'thumbnail_crop', '1', 'yes'), ('65', 'medium_size_w', '300', 'yes'), ('66', 'medium_size_h', '300', 'yes'), ('67', 'avatar_default', 'mystery', 'yes'), ('68', 'large_size_w', '1024', 'yes'), ('69', 'large_size_h', '1024', 'yes'), ('70', 'image_default_link_type', 'file', 'yes'), ('71', 'image_default_size', '', 'yes'), ('72', 'image_default_align', '', 'yes'), ('73', 'close_comments_for_old_posts', '0', 'yes'), ('74', 'close_comments_days_old', '14', 'yes'), ('75', 'thread_comments', '1', 'yes'), ('76', 'thread_comments_depth', '5', 'yes'), ('77', 'page_comments', '0', 'yes'), ('78', 'comments_per_page', '50', 'yes'), ('79', 'default_comments_page', 'newest', 'yes'), ('80', 'comment_order', 'asc', 'yes'), ('81', 'sticky_posts', 'a:0:{}', 'yes'), ('82', 'widget_categories', 'a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'), ('83', 'widget_text', 'a:0:{}', 'yes'), ('84', 'widget_rss', 'a:0:{}', 'yes'), ('85', 'uninstall_plugins', 'a:0:{}', 'no'), ('86', 'timezone_string', 'Asia/Shanghai', 'yes'), ('87', 'page_for_posts', '0', 'yes'), ('88', 'page_on_front', '0', 'yes'), ('89', 'default_post_format', '0', 'yes'), ('90', 'link_manager_enabled', '0', 'yes'), ('91', 'initial_db_version', '25824', 'yes'), ('92', 'wp_user_roles', 'a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:62:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:9:\"add_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}', 'yes'), ('93', 'widget_search', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'), ('94', 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'), ('95', 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'), ('96', 'widget_archives', 'a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'), ('97', 'widget_meta', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'), ('98', 'sidebars_widgets', 'a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:9:\"sidebar-2\";a:0:{}s:13:\"array_version\";i:3;}', 'yes');
COMMIT;

-- ----------------------------
--  Table structure for `wp_postmeta`
-- ----------------------------
DROP TABLE IF EXISTS `wp_postmeta`;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_postmeta`
-- ----------------------------
BEGIN;
INSERT INTO `wp_postmeta` VALUES ('1', '2', '_wp_page_template', 'default');
COMMIT;

-- ----------------------------
--  Table structure for `wp_posts`
-- ----------------------------
DROP TABLE IF EXISTS `wp_posts`;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_posts`
-- ----------------------------
BEGIN;
INSERT INTO `wp_posts` VALUES ('1', '1', '2014-04-05 10:36:07', '2014-04-05 10:36:07', '欢迎使用WordPress。这是系统自动生成的演示文章。编辑或者删除它，然后开始您的博客！', '世界，你好！', '', 'publish', 'open', 'open', '', 'hello-world', '', '', '2014-04-05 10:36:07', '2014-04-05 10:36:07', '', '0', 'http://wordpress.itron.me/?p=1', '0', 'post', '', '1'), ('2', '1', '2014-04-05 10:36:07', '2014-04-05 10:36:07', '这是示范页面。页面和博客文章不同，它的位置是固定的，通常会在站点导航栏显示。很多用户都创建一个“关于”页面，向访客介绍自己。例如，个人博客通常有类似这样的介绍：\n\n<blockquote>欢迎！我白天是个邮递员，晚上就是个有抱负的演员。这是我的博客。我住在天朝的帝都，有条叫做杰克的狗。</blockquote>\n\n……公司博客可以这样写：\n\n<blockquote>XYZ Doohickey公司成立于1971年，自从建立以来，我们一直向社会贡献着优秀doohicky。我们的公司总部位于天朝魔都，有着超过两千名员工，对魔都政府税收有着巨大贡献。</blockquote>\n\n您可以访问<a href=\"http://wordpress.itron.me/wp-admin/\">仪表盘</a>，删除本页面，然后添加您自己的内容。祝您使用愉快！', '示例页面', '', 'publish', 'open', 'open', '', 'sample-page', '', '', '2014-04-05 10:36:07', '2014-04-05 10:36:07', '', '0', 'http://wordpress.itron.me/?page_id=2', '0', 'page', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `wp_term_relationships`
-- ----------------------------
DROP TABLE IF EXISTS `wp_term_relationships`;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_term_relationships`
-- ----------------------------
BEGIN;
INSERT INTO `wp_term_relationships` VALUES ('1', '1', '0');
COMMIT;

-- ----------------------------
--  Table structure for `wp_term_taxonomy`
-- ----------------------------
DROP TABLE IF EXISTS `wp_term_taxonomy`;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_term_taxonomy`
-- ----------------------------
BEGIN;
INSERT INTO `wp_term_taxonomy` VALUES ('1', '1', 'category', '', '0', '1');
COMMIT;

-- ----------------------------
--  Table structure for `wp_terms`
-- ----------------------------
DROP TABLE IF EXISTS `wp_terms`;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_terms`
-- ----------------------------
BEGIN;
INSERT INTO `wp_terms` VALUES ('1', '未分类', 'uncategorized', '0');
COMMIT;

-- ----------------------------
--  Table structure for `wp_usermeta`
-- ----------------------------
DROP TABLE IF EXISTS `wp_usermeta`;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_usermeta`
-- ----------------------------
BEGIN;
INSERT INTO `wp_usermeta` VALUES ('1', '1', 'first_name', ''), ('2', '1', 'last_name', ''), ('3', '1', 'nickname', 'auioh413'), ('4', '1', 'description', ''), ('5', '1', 'rich_editing', 'true'), ('6', '1', 'comment_shortcuts', 'false'), ('7', '1', 'admin_color', 'fresh'), ('8', '1', 'use_ssl', '0'), ('9', '1', 'show_admin_bar_front', 'true'), ('10', '1', 'wp_capabilities', 'a:1:{s:13:\"administrator\";b:1;}'), ('11', '1', 'wp_user_level', '10'), ('12', '1', 'dismissed_wp_pointers', 'wp330_toolbar,wp330_saving_widgets,wp340_choose_image_from_library,wp340_customize_current_theme_link,wp350_media,wp360_revisions,wp360_locks'), ('13', '1', 'show_welcome_panel', '1');
COMMIT;

-- ----------------------------
--  Table structure for `wp_users`
-- ----------------------------
DROP TABLE IF EXISTS `wp_users`;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `wp_users`
-- ----------------------------
BEGIN;
INSERT INTO `wp_users` VALUES ('1', 'auioh413', '$P$BfLVm.5WC/nG8RL34BsL7FSmhxdvPW.', 'auioh413', 'lbzqh156@gmail.com', '', '2014-04-05 10:36:07', '', '0', 'auioh413');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
