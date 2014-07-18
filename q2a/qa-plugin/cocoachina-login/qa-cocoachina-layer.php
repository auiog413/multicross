<?php

/*
	Question2Answer (c) Gideon Greenspan

	http://www.question2answer.org/

	
	File: qa-plugin/cocoachina-login/qa-cocoachina-layer.php
	Version: See define()s at top of qa-include/qa-base.php
	Description: Theme layer class for mouseover layer plugin


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

	class qa_html_theme_layer extends qa_html_theme_base {
		
		function head_css()
		{
			qa_html_theme_base::head_css();
			
			if (strlen(qa_opt('cocoachina_id')) && strlen(qa_opt('cocoachina_secret'))){
                                $this->output(
					'<style><!--',
					'.cc-login-button.cc_iframe_widget.cc_hide_iframes span {display:none;}',
					'--></style>'
				);
                        }
		}
                
                function nav_list($navigation, $class, $level = null) {
                        $navigation['register']['url'] = 'http://dev.anysdk.com/reg';
                        
                        parent::nav_list($navigation, $class, $level);
                }
                
                function main_part ($key, $part) {
                        if (strpos($key, 'form')===0 && $part['hidden']['dologin'] == 1) {
                                
                                $tourl = 'http://' . $_SERVER['HTTP_HOST'] . '/index.php';
                                $ref_tourl = rawurlencode($tourl);
                                $referer = 'http://' . $_SERVER['HTTP_HOST'] . "/index.php?qa=cocoachina-login&to=$ref_tourl";
                                
                                // 输入密码可以访问faq自己的帐号系统，以便管理员可以通过这个进行登录
                                $origin_secret = qa_get('o');
                                if (empty($origin_secret) || $origin_secret != qa_opt('original_login_page_secret')){
                                        // 加工登录表单
                                        
                                        $part['tags'] = 'method="post" action="' . $referer . '"';
                                        unset($part['fields']['password']['note']);
                                        unset($part['fields']['remember']);
                                        
                                        qa_start_session();
                                        // 处理登录错误信息和帐号信息填回
                                        if ($_SESSION['qa_login_email_error']) {
                                                $part['fields']['email_handle']['error'] = $_SESSION['qa_login_email_error'];
                                                unset($_SESSION['qa_login_email_error']);
                                        }
                                        if ($_SESSION['qa_login_password_error']) {
                                                $part['fields']['password']['error'] = $_SESSION['qa_login_password_error'];
                                                unset($_SESSION['qa_login_password_error']);
                                        }
                                        if ($_SESSION['qa_login_email_value']) {
                                                $part['fields']['email_handle']['value'] = $_SESSION['qa_login_email_value'];
                                                unset($_SESSION['qa_login_email_value']);
                                        }
                                        if ($_SESSION['qa_login_password_value']) {
                                                $part['fields']['password']['value'] = $_SESSION['qa_login_password_value'];
                                                unset($_SESSION['qa_login_password_value']);
                                        }
                                }
                        }
                        
                        parent::main_part($key, $part);
                }
	}
	

/*
	Omit PHP closing tag to help avoid accidental output
*/