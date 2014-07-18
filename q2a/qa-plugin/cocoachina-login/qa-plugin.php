<?php

/*
	Question2Answer (c) Gideon Greenspan

	http://www.question2answer.org/

	
	File: qa-plugin/cocoachina-login/qa-plugin.php
	Version: See define()s at top of qa-include/qa-base.php
	Description: Initiates CocoaChina login plugin


	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	More about this license: http://www.question2answer.org/license.php
*/

/*
	Plugin Name: CocoaChina Login
	Plugin URI: 
	Plugin Description: Allows users to log in via CocoaChina
	Plugin Version: 1.0.0
	Plugin Date: 2014-07-16
	Plugin Author: libo<libo@chukong-inc.com>
	Plugin Author URI: http://www.anysdk.com/
	Plugin License: GPLv2
	Plugin Minimum Question2Answer Version: 1.6.3
	Plugin Minimum PHP Version: 5.3
	Plugin Update Check URI:
*/

	if (!defined('QA_VERSION')) { // don't allow this page to be requested directly from browser
		header('Location: ../../');
		exit;
	}

	if (!QA_FINAL_EXTERNAL_USERS) { // login modules don't work with external user integration
		qa_register_plugin_module('login', 'qa-cocoachina-login.php', 'qa_cocoachina_login', 'CocoaChina Login');
		qa_register_plugin_module('page', 'qa-cocoachina-login-page.php', 'qa_cocoachina_login_page', 'CocoaChina Login Page');
		qa_register_plugin_layer('qa-cocoachina-layer.php', 'CocoaChina Login Layer');
	}
	
/*
	Omit PHP closing tag to help avoid accidental output
*/