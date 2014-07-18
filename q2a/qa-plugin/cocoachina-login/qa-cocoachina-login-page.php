<?php

/*
	Question2Answer (c) Gideon Greenspan

	http://www.question2answer.org/

	
	File: qa-plugin/cocoachina-login/qa-cocoachina-login-page.php
	Version: See define()s at top of qa-include/qa-base.php
	Description: Page which performs CocoaChina login action


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

	class qa_cocoachina_login_page {
                
                const COCOACHINA_LOGIN_URL = 'http://open.cocoachina.com/api/user_login';
		
		var $directory;
		var $urltoroot;

		function load_module($directory, $urltoroot)
		{
			$this->directory=$directory;
			$this->urltoroot=$urltoroot;
		}

		function match_request($request)
		{
			return ($request=='cocoachina-login');
		}
		
		function process_request($request)
		{
			if ($request=='cocoachina-login') {
				$app_id=qa_opt('cocoachina_id');
				$app_secret=qa_opt('cocoachina_secret');
				$tourl=qa_get('to');
                                
                                $username = qa_post_text('emailhandle');
                                $password = qa_post_text('password');
                                
                                qa_start_session();
                                
                                if (!empty($username) && !empty($password)) {
                                        $login_data = array(
                                            'from' => 'anysdk', 
                                            'username' => $username,
                                            'timestamp' => time(),
                                            'password' => md5($password)
                                        );
                                        $login_data['sign'] = $this->_cc_sign_data($login_data, qa_opt('cocoachina_secret'));
                                        
                                        $ch = curl_init();
                                        curl_setopt($ch, CURLOPT_URL, self::COCOACHINA_LOGIN_URL);
                                        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36");
                                        curl_setopt($ch, CURLOPT_POST, 1);
                                        curl_setopt($ch, CURLOPT_POSTFIELDS, $login_data);
                                        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                                        $result = curl_exec($ch);
                                        curl_close($ch);
                                        unset($ch);
                                        
                                        $result = json_decode($result,true);
                                        
                                        if ($result['status'] == 'success') {
                                                $cc_userid = $result['msg']['uid'];

                                                $cc_username = explode('@', $result['msg']['username']);
                                                $user = array(
                                                    'email' => $result['msg']['email'],
                                                    'name' => $cc_username[0],
                                                    'verified' => false,
                                                    'bio' => '',
                                                );

                                                qa_log_in_external_user('cocoachina', $cc_userid, array(
                                                        'email' => $user['email'],
                                                        'handle' => $user['name'],
                                                        'confirmed' => $user['verified'],
                                                        'name' => $user['name'],
                                                ));

                                                qa_redirect_raw($tourl);
                                        } else {
                                                // 登录失败，显示cocoachina返回的错误提示
                                                if ($result['status'] == 'error') {
                                                        $_SESSION['qa_login_password_error'] = $result['msg'];
                                                } else {
                                                        $_SESSION['qa_login_password_error'] = '未知错误，请重试';
                                                }
                                                
                                                $_SESSION['qa_login_email_value'] = $username;
                                                $_SESSION['qa_login_password_value'] = $password;
                                                
                                                qa_redirect_raw('index.php?qa=login&to=index.php');
                                        }
                                } else {
                                        // 用户名不能为空
                                        if (empty($username)){
                                                $_SESSION['qa_login_email_error'] = '邮箱不能为空';
                                        } else{
                                                $_SESSION['qa_login_email_value'] = $username;
                                        }
                                        // 密码不能为空
                                        if (empty($password)){
                                                $_SESSION['qa_login_password_error'] = '密码不能为空';
                                        } else {
                                                $_SESSION['qa_login_password_value'] = $password;
                                        }
                                        
                                        qa_redirect_raw('index.php?qa=login&to=index.php');
                                }
			}
		}
		
                /**
                 * cocoachina sign method
                 * @param type $arr
                 * @param type $secret
                 * @return type
                 */
                function _cc_sign_data($arr, $secret) {
                        ksort($arr);
                        $res = $secret;
                        foreach ($arr as $key => $value) {
                                $res.=$key . urlencode($value);
                        }
                        $res .= $secret;
                        return strtoupper(MD5($res));
                }
	}
	

/*
	Omit PHP closing tag to help avoid accidental output
*/