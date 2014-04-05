/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50616
 Source Host           : localhost
 Source Database       : q2a_db

 Target Server Type    : MySQL
 Target Server Version : 50616
 File Encoding         : utf-8

 Date: 04/05/2014 16:38:02 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `qa_blobs`
-- ----------------------------
DROP TABLE IF EXISTS `qa_blobs`;
CREATE TABLE `qa_blobs` (
  `blobid` bigint(20) unsigned NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `content` mediumblob,
  `filename` varchar(255) DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  `cookieid` bigint(20) unsigned DEFAULT NULL,
  `createip` int(10) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`blobid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_cache`
-- ----------------------------
DROP TABLE IF EXISTS `qa_cache`;
CREATE TABLE `qa_cache` (
  `type` char(8) CHARACTER SET ascii NOT NULL,
  `cacheid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `content` mediumblob NOT NULL,
  `created` datetime NOT NULL,
  `lastread` datetime NOT NULL,
  PRIMARY KEY (`type`,`cacheid`),
  KEY `lastread` (`lastread`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_categories`
-- ----------------------------
DROP TABLE IF EXISTS `qa_categories`;
CREATE TABLE `qa_categories` (
  `categoryid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` int(10) unsigned DEFAULT NULL,
  `title` varchar(80) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `content` varchar(800) NOT NULL DEFAULT '',
  `qcount` int(10) unsigned NOT NULL DEFAULT '0',
  `position` smallint(5) unsigned NOT NULL,
  `backpath` varchar(804) NOT NULL DEFAULT '',
  PRIMARY KEY (`categoryid`),
  UNIQUE KEY `parentid` (`parentid`,`tags`),
  UNIQUE KEY `parentid_2` (`parentid`,`position`),
  KEY `backpath` (`backpath`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_categorymetas`
-- ----------------------------
DROP TABLE IF EXISTS `qa_categorymetas`;
CREATE TABLE `qa_categorymetas` (
  `categoryid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`categoryid`,`title`),
  CONSTRAINT `qa_categorymetas_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `qa_categories` (`categoryid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_contentwords`
-- ----------------------------
DROP TABLE IF EXISTS `qa_contentwords`;
CREATE TABLE `qa_contentwords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  `count` tinyint(3) unsigned NOT NULL,
  `type` enum('Q','A','C','NOTE') NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`),
  CONSTRAINT `qa_contentwords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  CONSTRAINT `qa_contentwords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_contentwords`
-- ----------------------------
BEGIN;
INSERT INTO `qa_contentwords` VALUES ('1', '10', '2', 'Q', '1'), ('1', '11', '2', 'Q', '1'), ('1', '12', '1', 'Q', '1'), ('1', '8', '1', 'Q', '1'), ('1', '13', '1', 'Q', '1'), ('1', '14', '2', 'Q', '1'), ('1', '15', '2', 'Q', '1'), ('1', '16', '1', 'Q', '1'), ('1', '17', '1', 'Q', '1'), ('1', '18', '1', 'Q', '1'), ('1', '19', '1', 'Q', '1'), ('1', '20', '1', 'Q', '1'), ('1', '21', '1', 'Q', '1'), ('1', '22', '1', 'Q', '1'), ('1', '23', '1', 'Q', '1'), ('2', '27', '1', 'Q', '2'), ('2', '37', '1', 'Q', '2'), ('2', '38', '1', 'Q', '2'), ('2', '8', '1', 'Q', '2'), ('2', '28', '1', 'Q', '2'), ('2', '29', '1', 'Q', '2'), ('2', '30', '2', 'Q', '2'), ('2', '6', '1', 'Q', '2'), ('2', '31', '1', 'Q', '2'), ('2', '39', '1', 'Q', '2'), ('2', '40', '1', 'Q', '2');
COMMIT;

-- ----------------------------
--  Table structure for `qa_cookies`
-- ----------------------------
DROP TABLE IF EXISTS `qa_cookies`;
CREATE TABLE `qa_cookies` (
  `cookieid` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `createip` int(10) unsigned NOT NULL,
  `written` datetime DEFAULT NULL,
  `writeip` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`cookieid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_iplimits`
-- ----------------------------
DROP TABLE IF EXISTS `qa_iplimits`;
CREATE TABLE `qa_iplimits` (
  `ip` int(10) unsigned NOT NULL,
  `action` char(1) CHARACTER SET ascii NOT NULL,
  `period` int(10) unsigned NOT NULL,
  `count` smallint(5) unsigned NOT NULL,
  UNIQUE KEY `ip` (`ip`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_iplimits`
-- ----------------------------
BEGIN;
INSERT INTO `qa_iplimits` VALUES ('2130706433', 'L', '387968', '1'), ('2130706433', 'Q', '387968', '1'), ('2130706433', 'R', '387968', '1');
COMMIT;

-- ----------------------------
--  Table structure for `qa_messages`
-- ----------------------------
DROP TABLE IF EXISTS `qa_messages`;
CREATE TABLE `qa_messages` (
  `messageid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('PUBLIC','PRIVATE') NOT NULL DEFAULT 'PRIVATE',
  `fromuserid` int(10) unsigned NOT NULL,
  `touserid` int(10) unsigned NOT NULL,
  `content` varchar(8000) NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`messageid`),
  KEY `type` (`type`,`fromuserid`,`touserid`,`created`),
  KEY `touserid` (`touserid`,`type`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_options`
-- ----------------------------
DROP TABLE IF EXISTS `qa_options`;
CREATE TABLE `qa_options` (
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_options`
-- ----------------------------
BEGIN;
INSERT INTO `qa_options` VALUES ('allow_change_usernames', '1'), ('allow_close_questions', '1'), ('allow_login_email_only', ''), ('allow_private_messages', '1'), ('allow_self_answer', '1'), ('allow_user_walls', '1'), ('allow_view_q_bots', '1'), ('approve_user_required', ''), ('avatar_allow_gravatar', '1'), ('avatar_allow_upload', '1'), ('avatar_default_blobid', ''), ('avatar_default_height', ''), ('avatar_default_show', ''), ('avatar_default_width', ''), ('avatar_message_list_size', '20'), ('avatar_profile_size', '200'), ('avatar_q_list_size', '0'), ('avatar_q_page_a_size', '40'), ('avatar_q_page_c_size', '20'), ('avatar_q_page_q_size', '50'), ('avatar_store_size', '400'), ('avatar_users_size', '30'), ('block_bad_words', ''), ('block_ips_write', ''), ('cache_flaggedcount', ''), ('cache_qcount', '2'), ('cache_queuedcount', ''), ('cache_tagcount', '2'), ('cache_uapprovecount', '1'), ('cache_unaqcount', '2'), ('cache_unselqcount', '2'), ('cache_unupaqcount', '2'), ('cache_userpointscount', '2'), ('captcha_module', 'reCAPTCHA'), ('captcha_on_anon_post', '1'), ('captcha_on_feedback', '1'), ('captcha_on_register', '1'), ('captcha_on_reset_password', '1'), ('captcha_on_unapproved', ''), ('captcha_on_unconfirmed', '0'), ('columns_tags', '3'), ('columns_users', '2'), ('comment_on_as', '1'), ('comment_on_qs', '0'), ('confirm_user_emails', '1'), ('confirm_user_required', ''), ('custom_footer', ''), ('custom_header', ''), ('custom_home_content', ''), ('custom_home_heading', ''), ('custom_in_head', ''), ('custom_register', ''), ('custom_sidepanel', ''), ('custom_welcome', ''), ('db_version', '56'), ('do_ask_check_qs', '0'), ('do_complete_tags', '1'), ('do_count_q_views', '1'), ('do_example_tags', '1'), ('editor_for_as', 'WYSIWYG Editor'), ('editor_for_qs', 'WYSIWYG Editor'), ('event_logger_to_database', ''), ('event_logger_to_files', ''), ('extra_field_active', ''), ('facebook_app_id', ''), ('facebook_app_secret', ''), ('feedback_email', 'lbzqh156@gmail.com'), ('feedback_enabled', '1'), ('feed_for_activity', '1'), ('feed_for_hot', ''), ('feed_for_qa', '1'), ('feed_for_questions', '1'), ('feed_for_tag_qs', ''), ('feed_for_unanswered', '1'), ('feed_per_category', '1'), ('flagging_hide_after', '5'), ('flagging_notify_every', '2'), ('flagging_notify_first', '1'), ('flagging_of_posts', '1'), ('form_security_salt', '3oqiyijnij4v30hzg9u17yo9aqlubup0'), ('from_email', 'no-reply@itron.me'), ('home_description', ''), ('hot_weight_answers', '100'), ('hot_weight_a_age', '100'), ('hot_weight_q_age', '100'), ('hot_weight_views', '100'), ('hot_weight_votes', '100'), ('links_in_new_window', ''), ('logo_height', ''), ('logo_show', ''), ('logo_url', ''), ('logo_width', ''), ('match_example_tags', '3'), ('max_copy_user_updates', '10'), ('max_len_q_title', '120'), ('max_num_q_tags', '5'), ('max_rate_ip_as', '50'), ('max_rate_ip_cs', '40'), ('max_rate_ip_flags', '10'), ('max_rate_ip_logins', '20'), ('max_rate_ip_messages', '10'), ('max_rate_ip_qs', '20'), ('max_rate_ip_registers', '5'), ('max_rate_ip_uploads', '20'), ('max_rate_ip_votes', '600'), ('max_rate_user_as', '25'), ('max_rate_user_cs', '20'), ('max_rate_user_flags', '5'), ('max_rate_user_messages', '5'), ('max_rate_user_qs', '10'), ('max_rate_user_uploads', '10'), ('max_rate_user_votes', '300'), ('max_store_user_updates', '50'), ('min_len_q_content', '0'), ('min_len_q_title', '12'), ('min_num_q_tags', '0'), ('moderate_anon_post', ''), ('moderate_by_points', ''), ('moderate_edited_again', ''), ('moderate_notify_admin', '1'), ('moderate_points_limit', '150'), ('moderate_unapproved', ''), ('moderate_unconfirmed', ''), ('moderate_update_time', '1'), ('moderate_users', ''), ('mouseover_content_on', ''), ('nav_activity', '1'), ('nav_ask', '1'), ('nav_categories', '1'), ('nav_home', ''), ('nav_hot', '1'), ('nav_qa_is_home', '1'), ('nav_questions', '1'), ('nav_tags', '1'), ('nav_unanswered', '1'), ('nav_users', '1'), ('neat_urls', '5'), ('notice_visitor', ''), ('notice_welcome', ''), ('notify_admin_q_post', ''), ('notify_users_default', '1'), ('pages_prev_next', '3'), ('page_size_activity', '20'), ('page_size_ask_tags', '5'), ('page_size_home', '20'), ('page_size_hot_qs', '20'), ('page_size_qs', '20'), ('page_size_q_as', '10'), ('page_size_search', '10'), ('page_size_tags', '30'), ('page_size_tag_qs', '20'), ('page_size_una_qs', '20'), ('page_size_users', '20'), ('page_size_wall', '10'), ('permit_anon_view_ips', '70'), ('permit_anon_view_ips_points', ''), ('permit_close_q', '70'), ('permit_close_q_points', ''), ('permit_delete_hidden', '40'), ('permit_delete_hidden_points', ''), ('permit_edit_a', '100'), ('permit_edit_a_points', ''), ('permit_edit_c', '70'), ('permit_edit_c_points', ''), ('permit_edit_q', '70'), ('permit_edit_q_points', ''), ('permit_edit_silent', '40'), ('permit_edit_silent_points', ''), ('permit_flag', '110'), ('permit_flag_points', ''), ('permit_hide_show', '70'), ('permit_hide_show_points', ''), ('permit_moderate', '100'), ('permit_moderate_points', ''), ('permit_post_a', '150'), ('permit_post_a_points', ''), ('permit_post_c', '150'), ('permit_post_c_points', ''), ('permit_post_q', '150'), ('permit_post_q_points', ''), ('permit_post_wall', '110'), ('permit_post_wall_points', ''), ('permit_retag_cat', '70'), ('permit_retag_cat_points', ''), ('permit_select_a', '100'), ('permit_select_a_points', ''), ('permit_view_q_page', '150'), ('permit_view_voters_flaggers', '20'), ('permit_view_voters_flaggers_points', ''), ('permit_vote_a', '120'), ('permit_vote_a_points', ''), ('permit_vote_down', '120'), ('permit_vote_down_points', ''), ('permit_vote_q', '120'), ('permit_vote_q_points', ''), ('points_a_selected', '30'), ('points_a_voted_max_gain', '20'), ('points_a_voted_max_loss', '5'), ('points_base', '100'), ('points_multiple', '10'), ('points_per_a_voted', ''), ('points_per_a_voted_down', '2'), ('points_per_a_voted_up', '2'), ('points_per_q_voted', ''), ('points_per_q_voted_down', '1'), ('points_per_q_voted_up', '1'), ('points_post_a', '4'), ('points_post_q', '2'), ('points_q_voted_max_gain', '10'), ('points_q_voted_max_loss', '3'), ('points_select_a', '3'), ('points_to_titles', ''), ('points_vote_down_a', '1'), ('points_vote_down_q', '1'), ('points_vote_on_a', ''), ('points_vote_on_q', ''), ('points_vote_up_a', '1'), ('points_vote_up_q', '1'), ('q_urls_remove_accents', ''), ('q_urls_title_length', '50'), ('recaptcha_public_key', ''), ('register_notify_admin', ''), ('search_module', ''), ('show_a_c_links', '1'), ('show_a_form_immediate', 'if_no_as'), ('show_custom_answer', ''), ('show_custom_ask', ''), ('show_custom_footer', ''), ('show_custom_header', ''), ('show_custom_home', ''), ('show_custom_in_head', ''), ('show_custom_register', ''), ('show_custom_sidebar', '1'), ('show_custom_sidepanel', ''), ('show_custom_welcome', '1'), ('show_fewer_cs_from', '10'), ('show_full_date_days', '7'), ('show_home_description', ''), ('show_message_history', '1'), ('show_notice_visitor', ''), ('show_notice_welcome', ''), ('show_url_links', '1'), ('show_user_points', '1'), ('show_user_titles', '1'), ('show_view_counts', ''), ('show_view_count_q_page', ''), ('show_when_created', '1'), ('site_language', 'zh'), ('site_maintenance', '0'), ('site_theme', 'Snow'), ('site_theme_mobile', 'Snow'), ('site_title', 'Itron Q&A'), ('site_url', 'http://q2a.itron.me/'), ('smtp_active', ''), ('smtp_address', ''), ('smtp_authenticate', ''), ('smtp_password', ''), ('smtp_port', '25'), ('smtp_secure', ''), ('smtp_username', ''), ('sort_answers_by', 'created'), ('suspend_register_users', ''), ('tags_or_categories', 'tc'), ('tag_separator_comma', ''), ('votes_separated', ''), ('voting_on_as', '1'), ('voting_on_qs', '1'), ('voting_on_q_page_only', ''), ('wysiwyg_editor_upload_images', '');
COMMIT;

-- ----------------------------
--  Table structure for `qa_pages`
-- ----------------------------
DROP TABLE IF EXISTS `qa_pages`;
CREATE TABLE `qa_pages` (
  `pageid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `nav` char(1) CHARACTER SET ascii NOT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `flags` tinyint(3) unsigned NOT NULL,
  `permit` tinyint(3) unsigned DEFAULT NULL,
  `tags` varchar(200) NOT NULL,
  `heading` varchar(800) DEFAULT NULL,
  `content` mediumtext,
  PRIMARY KEY (`pageid`),
  UNIQUE KEY `position` (`position`),
  KEY `tags` (`tags`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_pages`
-- ----------------------------
BEGIN;
INSERT INTO `qa_pages` VALUES ('1', '首页', 'B', '1', '1', '150', 'http://www.anysdk.com/', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `qa_postmetas`
-- ----------------------------
DROP TABLE IF EXISTS `qa_postmetas`;
CREATE TABLE `qa_postmetas` (
  `postid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`postid`,`title`),
  CONSTRAINT `qa_postmetas_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_posts`
-- ----------------------------
DROP TABLE IF EXISTS `qa_posts`;
CREATE TABLE `qa_posts` (
  `postid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('Q','A','C','Q_HIDDEN','A_HIDDEN','C_HIDDEN','Q_QUEUED','A_QUEUED','C_QUEUED','NOTE') NOT NULL,
  `parentid` int(10) unsigned DEFAULT NULL,
  `categoryid` int(10) unsigned DEFAULT NULL,
  `catidpath1` int(10) unsigned DEFAULT NULL,
  `catidpath2` int(10) unsigned DEFAULT NULL,
  `catidpath3` int(10) unsigned DEFAULT NULL,
  `acount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `amaxvote` smallint(5) unsigned NOT NULL DEFAULT '0',
  `selchildid` int(10) unsigned DEFAULT NULL,
  `closedbyid` int(10) unsigned DEFAULT NULL,
  `userid` int(10) unsigned DEFAULT NULL,
  `cookieid` bigint(20) unsigned DEFAULT NULL,
  `createip` int(10) unsigned DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `lastip` int(10) unsigned DEFAULT NULL,
  `upvotes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `downvotes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `netvotes` smallint(6) NOT NULL DEFAULT '0',
  `lastviewip` int(10) unsigned DEFAULT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `hotness` float DEFAULT NULL,
  `flagcount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `format` varchar(20) CHARACTER SET ascii NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `title` varchar(800) DEFAULT NULL,
  `content` varchar(8000) DEFAULT NULL,
  `tags` varchar(800) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `notify` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`postid`),
  KEY `type` (`type`,`created`),
  KEY `type_2` (`type`,`acount`,`created`),
  KEY `type_4` (`type`,`netvotes`,`created`),
  KEY `type_5` (`type`,`views`,`created`),
  KEY `type_6` (`type`,`hotness`),
  KEY `type_7` (`type`,`amaxvote`,`created`),
  KEY `parentid` (`parentid`,`type`),
  KEY `userid` (`userid`,`type`,`created`),
  KEY `selchildid` (`selchildid`,`type`,`created`),
  KEY `closedbyid` (`closedbyid`),
  KEY `catidpath1` (`catidpath1`,`type`,`created`),
  KEY `catidpath2` (`catidpath2`,`type`,`created`),
  KEY `catidpath3` (`catidpath3`,`type`,`created`),
  KEY `categoryid` (`categoryid`,`type`,`created`),
  KEY `createip` (`createip`,`created`),
  KEY `updated` (`updated`,`type`),
  KEY `flagcount` (`flagcount`,`created`,`type`),
  KEY `catidpath1_2` (`catidpath1`,`updated`,`type`),
  KEY `catidpath2_2` (`catidpath2`,`updated`,`type`),
  KEY `catidpath3_2` (`catidpath3`,`updated`,`type`),
  KEY `categoryid_2` (`categoryid`,`updated`,`type`),
  KEY `lastuserid` (`lastuserid`,`updated`,`type`),
  KEY `lastip` (`lastip`,`updated`,`type`),
  CONSTRAINT `qa_posts_ibfk_2` FOREIGN KEY (`parentid`) REFERENCES `qa_posts` (`postid`),
  CONSTRAINT `qa_posts_ibfk_3` FOREIGN KEY (`categoryid`) REFERENCES `qa_categories` (`categoryid`) ON DELETE SET NULL,
  CONSTRAINT `qa_posts_ibfk_4` FOREIGN KEY (`closedbyid`) REFERENCES `qa_posts` (`postid`),
  CONSTRAINT `qa_posts_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_posts`
-- ----------------------------
BEGIN;
INSERT INTO `qa_posts` VALUES ('1', 'Q', null, null, null, null, null, '0', '0', null, null, '1', null, '2130706433', null, null, '0', '0', '0', '2130706433', '1', '26833800000', '0', '', '2014-04-02 20:32:27', null, null, '李播在q2a提的第一个问题', '问题有一些描述信息，以便详细地描述问题', 'q2a部署', null, '@'), ('2', 'Q', null, null, null, null, null, '0', '0', null, null, '2', null, '2130706433', null, null, '0', '0', '0', '2130706433', '1', '26882800000', '0', '', '2014-04-05 16:37:22', null, null, '想问一下，明天的天气会是怎样的？', '想知道一下明天的天气状况', '天气', null, '@');
COMMIT;

-- ----------------------------
--  Table structure for `qa_posttags`
-- ----------------------------
DROP TABLE IF EXISTS `qa_posttags`;
CREATE TABLE `qa_posttags` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  `postcreated` datetime NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`,`postcreated`),
  CONSTRAINT `qa_posttags_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  CONSTRAINT `qa_posttags_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_posttags`
-- ----------------------------
BEGIN;
INSERT INTO `qa_posttags` VALUES ('1', '26', '2014-04-02 20:32:27'), ('2', '41', '2014-04-05 16:37:22');
COMMIT;

-- ----------------------------
--  Table structure for `qa_sharedevents`
-- ----------------------------
DROP TABLE IF EXISTS `qa_sharedevents`;
CREATE TABLE `qa_sharedevents` (
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  `lastpostid` int(10) unsigned NOT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `updated` datetime NOT NULL,
  KEY `entitytype` (`entitytype`,`entityid`,`updated`),
  KEY `questionid` (`questionid`,`entitytype`,`entityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_sharedevents`
-- ----------------------------
BEGIN;
INSERT INTO `qa_sharedevents` VALUES ('Q', '1', '1', '1', null, '1', '2014-04-02 20:32:27'), ('U', '1', '1', '1', null, '1', '2014-04-02 20:32:27'), ('T', '26', '1', '1', null, '1', '2014-04-02 20:32:27'), ('Q', '2', '2', '2', null, '2', '2014-04-05 16:37:22'), ('U', '2', '2', '2', null, '2', '2014-04-05 16:37:22'), ('T', '41', '2', '2', null, '2', '2014-04-05 16:37:22');
COMMIT;

-- ----------------------------
--  Table structure for `qa_tagmetas`
-- ----------------------------
DROP TABLE IF EXISTS `qa_tagmetas`;
CREATE TABLE `qa_tagmetas` (
  `tag` varchar(80) NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`tag`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_tagwords`
-- ----------------------------
DROP TABLE IF EXISTS `qa_tagwords`;
CREATE TABLE `qa_tagwords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`),
  CONSTRAINT `qa_tagwords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  CONSTRAINT `qa_tagwords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_tagwords`
-- ----------------------------
BEGIN;
INSERT INTO `qa_tagwords` VALUES ('1', '4'), ('1', '24'), ('1', '25'), ('2', '30'), ('2', '31');
COMMIT;

-- ----------------------------
--  Table structure for `qa_titlewords`
-- ----------------------------
DROP TABLE IF EXISTS `qa_titlewords`;
CREATE TABLE `qa_titlewords` (
  `postid` int(10) unsigned NOT NULL,
  `wordid` int(10) unsigned NOT NULL,
  KEY `postid` (`postid`),
  KEY `wordid` (`wordid`),
  CONSTRAINT `qa_titlewords_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  CONSTRAINT `qa_titlewords_ibfk_2` FOREIGN KEY (`wordid`) REFERENCES `qa_words` (`wordid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_titlewords`
-- ----------------------------
BEGIN;
INSERT INTO `qa_titlewords` VALUES ('1', '1'), ('1', '2'), ('1', '3'), ('1', '4'), ('1', '5'), ('1', '6'), ('1', '7'), ('1', '8'), ('1', '9'), ('1', '10'), ('1', '11'), ('2', '27'), ('2', '10'), ('2', '8'), ('2', '28'), ('2', '18'), ('2', '29'), ('2', '30'), ('2', '6'), ('2', '31'), ('2', '32'), ('2', '33'), ('2', '34'), ('2', '35'), ('2', '36');
COMMIT;

-- ----------------------------
--  Table structure for `qa_userevents`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userevents`;
CREATE TABLE `qa_userevents` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `questionid` int(10) unsigned NOT NULL,
  `lastpostid` int(10) unsigned NOT NULL,
  `updatetype` char(1) CHARACTER SET ascii DEFAULT NULL,
  `lastuserid` int(10) unsigned DEFAULT NULL,
  `updated` datetime NOT NULL,
  KEY `userid` (`userid`,`updated`),
  KEY `questionid` (`questionid`,`userid`),
  CONSTRAINT `qa_userevents_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_userfavorites`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userfavorites`;
CREATE TABLE `qa_userfavorites` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `nouserevents` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`userid`,`entitytype`,`entityid`),
  KEY `userid` (`userid`,`nouserevents`),
  KEY `entitytype` (`entitytype`,`entityid`,`nouserevents`),
  CONSTRAINT `qa_userfavorites_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_userfields`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userfields`;
CREATE TABLE `qa_userfields` (
  `fieldid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `content` varchar(40) DEFAULT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `flags` tinyint(3) unsigned NOT NULL,
  `permit` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`fieldid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_userfields`
-- ----------------------------
BEGIN;
INSERT INTO `qa_userfields` VALUES ('1', 'name', null, '1', '0', null), ('2', 'location', null, '2', '0', null), ('3', 'website', null, '3', '2', null), ('4', 'about', null, '4', '1', null);
COMMIT;

-- ----------------------------
--  Table structure for `qa_userlevels`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userlevels`;
CREATE TABLE `qa_userlevels` (
  `userid` int(10) unsigned NOT NULL,
  `entitytype` char(1) CHARACTER SET ascii NOT NULL,
  `entityid` int(10) unsigned NOT NULL,
  `level` tinyint(3) unsigned DEFAULT NULL,
  UNIQUE KEY `userid` (`userid`,`entitytype`,`entityid`),
  KEY `entitytype` (`entitytype`,`entityid`),
  CONSTRAINT `qa_userlevels_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_userlimits`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userlimits`;
CREATE TABLE `qa_userlimits` (
  `userid` int(10) unsigned NOT NULL,
  `action` char(1) CHARACTER SET ascii NOT NULL,
  `period` int(10) unsigned NOT NULL,
  `count` smallint(5) unsigned NOT NULL,
  UNIQUE KEY `userid` (`userid`,`action`),
  CONSTRAINT `qa_userlimits_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_userlimits`
-- ----------------------------
BEGIN;
INSERT INTO `qa_userlimits` VALUES ('1', 'Q', '387900', '1'), ('2', 'Q', '387968', '1');
COMMIT;

-- ----------------------------
--  Table structure for `qa_userlogins`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userlogins`;
CREATE TABLE `qa_userlogins` (
  `userid` int(10) unsigned NOT NULL,
  `source` varchar(16) CHARACTER SET ascii NOT NULL,
  `identifier` varbinary(1024) NOT NULL,
  `identifiermd5` binary(16) NOT NULL,
  KEY `source` (`source`,`identifiermd5`),
  KEY `userid` (`userid`),
  CONSTRAINT `qa_userlogins_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_usermetas`
-- ----------------------------
DROP TABLE IF EXISTS `qa_usermetas`;
CREATE TABLE `qa_usermetas` (
  `userid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  PRIMARY KEY (`userid`,`title`),
  CONSTRAINT `qa_usermetas_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_usernotices`
-- ----------------------------
DROP TABLE IF EXISTS `qa_usernotices`;
CREATE TABLE `qa_usernotices` (
  `noticeid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `content` varchar(8000) NOT NULL,
  `format` varchar(20) CHARACTER SET ascii NOT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`noticeid`),
  KEY `userid` (`userid`,`created`),
  CONSTRAINT `qa_usernotices_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_userpoints`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userpoints`;
CREATE TABLE `qa_userpoints` (
  `userid` int(10) unsigned NOT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `qposts` mediumint(9) NOT NULL DEFAULT '0',
  `aposts` mediumint(9) NOT NULL DEFAULT '0',
  `cposts` mediumint(9) NOT NULL DEFAULT '0',
  `aselects` mediumint(9) NOT NULL DEFAULT '0',
  `aselecteds` mediumint(9) NOT NULL DEFAULT '0',
  `qupvotes` mediumint(9) NOT NULL DEFAULT '0',
  `qdownvotes` mediumint(9) NOT NULL DEFAULT '0',
  `aupvotes` mediumint(9) NOT NULL DEFAULT '0',
  `adownvotes` mediumint(9) NOT NULL DEFAULT '0',
  `qvoteds` int(11) NOT NULL DEFAULT '0',
  `avoteds` int(11) NOT NULL DEFAULT '0',
  `upvoteds` int(11) NOT NULL DEFAULT '0',
  `downvoteds` int(11) NOT NULL DEFAULT '0',
  `bonus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `points` (`points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_userpoints`
-- ----------------------------
BEGIN;
INSERT INTO `qa_userpoints` VALUES ('1', '120', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'), ('2', '120', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `qa_userprofile`
-- ----------------------------
DROP TABLE IF EXISTS `qa_userprofile`;
CREATE TABLE `qa_userprofile` (
  `userid` int(10) unsigned NOT NULL,
  `title` varchar(40) NOT NULL,
  `content` varchar(8000) NOT NULL,
  UNIQUE KEY `userid` (`userid`,`title`),
  CONSTRAINT `qa_userprofile_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_users`
-- ----------------------------
DROP TABLE IF EXISTS `qa_users`;
CREATE TABLE `qa_users` (
  `userid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `createip` int(10) unsigned NOT NULL,
  `email` varchar(80) NOT NULL,
  `handle` varchar(20) NOT NULL,
  `avatarblobid` bigint(20) unsigned DEFAULT NULL,
  `avatarwidth` smallint(5) unsigned DEFAULT NULL,
  `avatarheight` smallint(5) unsigned DEFAULT NULL,
  `passsalt` binary(16) DEFAULT NULL,
  `passcheck` binary(20) DEFAULT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `loggedin` datetime NOT NULL,
  `loginip` int(10) unsigned NOT NULL,
  `written` datetime DEFAULT NULL,
  `writeip` int(10) unsigned DEFAULT NULL,
  `emailcode` char(8) CHARACTER SET ascii NOT NULL DEFAULT '',
  `sessioncode` char(8) CHARACTER SET ascii NOT NULL DEFAULT '',
  `sessionsource` varchar(16) CHARACTER SET ascii DEFAULT '',
  `flags` smallint(5) unsigned NOT NULL DEFAULT '0',
  `wallposts` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `email` (`email`),
  KEY `handle` (`handle`),
  KEY `level` (`level`),
  KEY `created` (`created`,`level`,`flags`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_users`
-- ----------------------------
BEGIN;
INSERT INTO `qa_users` VALUES ('1', '2014-04-02 20:30:16', '2130706433', 'lbzqh156@gmail.com', 'auioh413', null, null, null, 0x327834357971746c6679676c7473326e, 0x122dd2a0db3e7570c9ef558d22e8a0e179cda253, '120', '2014-04-05 16:32:30', '2130706433', '2014-04-02 20:32:27', '2130706433', '', '0cbqztub', null, '0', '0'), ('2', '2014-04-05 16:32:48', '2130706433', 'lbzqh156@tom.com', 'auiog413', null, null, null, 0x3864783563326e796f3833796c65796d, 0xd95bc7cfe0b259fde4c7c16e0f7a7b2e781c2f2d, '0', '2014-04-05 16:32:48', '2130706433', '2014-04-05 16:37:30', '2130706433', 'qeqplfxw', 'dnitl7y5', null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `qa_uservotes`
-- ----------------------------
DROP TABLE IF EXISTS `qa_uservotes`;
CREATE TABLE `qa_uservotes` (
  `postid` int(10) unsigned NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `vote` tinyint(4) NOT NULL,
  `flag` tinyint(4) NOT NULL,
  UNIQUE KEY `userid` (`userid`,`postid`),
  KEY `postid` (`postid`),
  CONSTRAINT `qa_uservotes_ibfk_1` FOREIGN KEY (`postid`) REFERENCES `qa_posts` (`postid`) ON DELETE CASCADE,
  CONSTRAINT `qa_uservotes_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `qa_users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_widgets`
-- ----------------------------
DROP TABLE IF EXISTS `qa_widgets`;
CREATE TABLE `qa_widgets` (
  `widgetid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `place` char(2) CHARACTER SET ascii NOT NULL,
  `position` smallint(5) unsigned NOT NULL,
  `tags` varchar(800) CHARACTER SET ascii NOT NULL,
  `title` varchar(80) NOT NULL,
  PRIMARY KEY (`widgetid`),
  UNIQUE KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qa_words`
-- ----------------------------
DROP TABLE IF EXISTS `qa_words`;
CREATE TABLE `qa_words` (
  `wordid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(80) NOT NULL,
  `titlecount` int(10) unsigned NOT NULL DEFAULT '0',
  `contentcount` int(10) unsigned NOT NULL DEFAULT '0',
  `tagwordcount` int(10) unsigned NOT NULL DEFAULT '0',
  `tagcount` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`wordid`),
  KEY `word` (`word`),
  KEY `tagcount` (`tagcount`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `qa_words`
-- ----------------------------
BEGIN;
INSERT INTO `qa_words` VALUES ('1', '李', '1', '0', '0', '0'), ('2', '播', '1', '0', '0', '0'), ('3', '在', '1', '0', '0', '0'), ('4', 'q2a', '1', '0', '1', '0'), ('5', '提', '1', '0', '0', '0'), ('6', '的', '2', '1', '0', '0'), ('7', '第', '1', '0', '0', '0'), ('8', '一', '2', '2', '0', '0'), ('9', '个', '1', '0', '0', '0'), ('10', '问', '2', '1', '0', '0'), ('11', '题', '1', '1', '0', '0'), ('12', '有', '0', '1', '0', '0'), ('13', '些', '0', '1', '0', '0'), ('14', '描', '0', '1', '0', '0'), ('15', '述', '0', '1', '0', '0'), ('16', '信', '0', '1', '0', '0'), ('17', '息', '0', '1', '0', '0'), ('18', '，', '1', '1', '0', '0'), ('19', '以', '0', '1', '0', '0'), ('20', '便', '0', '1', '0', '0'), ('21', '详', '0', '1', '0', '0'), ('22', '细', '0', '1', '0', '0'), ('23', '地', '0', '1', '0', '0'), ('24', '部', '0', '0', '1', '0'), ('25', '署', '0', '0', '1', '0'), ('26', 'q2a部署', '0', '0', '0', '1'), ('27', '想', '1', '1', '0', '0'), ('28', '下', '1', '1', '0', '0'), ('29', '明', '1', '1', '0', '0'), ('30', '天', '1', '1', '1', '0'), ('31', '气', '1', '1', '1', '0'), ('32', '会', '1', '0', '0', '0'), ('33', '是', '1', '0', '0', '0'), ('34', '怎', '1', '0', '0', '0'), ('35', '样', '1', '0', '0', '0'), ('36', '？', '1', '0', '0', '0'), ('37', '知', '0', '1', '0', '0'), ('38', '道', '0', '1', '0', '0'), ('39', '状', '0', '1', '0', '0'), ('40', '况', '0', '1', '0', '0'), ('41', '天气', '0', '0', '0', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
