<?php

/*
	Question2Answer (c) Gideon Greenspan

	http://www.question2answer.org/

	
	File: qa-plugin/cocoachina-login/qa-cocoachina-login.php
	Version: See define()s at top of qa-include/qa-base.php
	Description: Login module class for CocoaChina login plugin


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

	class qa_cocoachina_login {
		
		function match_source($source)
		{
			return $source=='cocoachina';
		}

		
		function login_html($tourl, $context)
		{
			$app_id=qa_opt('cocoachina_id');

			if (!strlen($app_id))
				return;
				
			$this->cocoachina_html(qa_path_absolute('cocoachina-login', array('to' => $tourl)), false, $context);
		}

		
		function logout_html($tourl)
		{
			$app_id=qa_opt('cocoachina_id');

			if (!strlen($app_id))
				return;
				
			$this->cocoachina_html($tourl, true, 'menu');
		}
		

		function cocoachina_html($tourl, $logout, $context)
		{
			if (($context=='login') || ($context=='register')) {
				$size='large';
                        } else {
				$size='medium';
                        }
                        
                        if ($logout) {
                                echo '<div id="cc-root" style="display:inline;"><a href="' . $tourl . '">退出</a></div>';
                        } else {
                        ?>
<script type="text/javascript">
        var logout = <?php echo (int)$logout;?>;
        $(document).ready(function(){
                if (!logout) {
                        $('#qa-loginform').attr('action', '<?php echo $tourl;?>');
                        $('#qa-rememberbox').remove();
                }
        });
</script>
                                <?php
                        }
		}
		
		
		function admin_form()
		{
			$saved=false;
			
			if (qa_clicked('cocoachina_save_button')) {
				qa_opt('cocoachina_id', qa_post_text('cocoachina_id_field'));
				qa_opt('cocoachina_secret', qa_post_text('cocoachina_secret_field'));
				qa_opt('original_login_page_secret', qa_post_text('original_login_page_secret_field'));
				$saved=true;
			}
			
			$ready=strlen(qa_opt('cocoachina_id')) && strlen(qa_opt('cocoachina_secret'));
			
			return array(
				'ok' => $saved ? 'CocoaChina 应用详情已保存' : null,
				
				'fields' => array(
					array(
						'label' => 'CocoaChina ID:',
						'value' => qa_html(qa_opt('cocoachina_id')),
						'tags' => 'name="cocoachina_id_field"',
					),

					array(
						'label' => 'CocoaChina Secret:',
						'value' => qa_html(qa_opt('cocoachina_secret')),
						'tags' => 'name="cocoachina_secret_field"',
						'error' => $ready ? null : 'To use CocoaChina Login, please <a href="http://open.cocoachina.com/" target="_blank">set up a CocoaChina application</a>.',
					),
					array(
						'label' => '原生登录页访问密码:',
						'value' => qa_html(qa_opt('original_login_page_secret')),
						'tags' => 'name="original_login_page_secret_field"',
						'error' => $ready ? '原生登录页面访问链接： http://' . $_SERVER['HTTP_HOST'] . '/index.php?qa=login&to=index.php&o=123456' : '原生登录页面需要输入访问密码才能打开，原生登录页面是为了方便管理员管理系统<br />如何使用：在登录页面url后面加上 &o=[此处输入的密码]',
					),
				),
				
				'buttons' => array(
					array(
						'label' => '保存',
						'tags' => 'name="cocoachina_save_button"',
					),
				),
			);
		}
	}
	

/*
	Omit PHP closing tag to help avoid accidental output
*/