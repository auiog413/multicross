<?php
/*
*	Q2A Market Snow Extended Dark
*
*	Theme functions
*	File: qa-theme.php
*	
*	@author			Q2A Market
*	@category		theme
*	@Version: 		1.2
*   @author URL:	http://www.q2amarket.com
*	
*	@Q2A Version	1.6
*
* 	Enjoy the extended version of Snow theme.
*/

	class qa_html_theme extends qa_html_theme_base
	{	

		function head_script() // change style of WYSIWYG editor to match theme better
		{
			qa_html_theme_base::head_script();
			
			$this->output(
				'<SCRIPT TYPE="text/javascript"><!--',
				"if (typeof qa_wysiwyg_editor_config == 'object')",
				"\tqa_wysiwyg_editor_config.skin='kama';",
				'//--></SCRIPT>'
			);
		}
		
		function head_css()
		{
			qa_html_theme_base::head_css();
			
			$avatarsize=(int)qa_opt('avatar_profile_size');
			
			if ($this->template=='user')
				$this->output(
					'<STYLE><!--',
					'.qa-main{
						width:100%;
						padding-right:10px;
						-webkit-box-sizing: border-box;
						-moz-box-sizing: border-box;
						box-sizing: border-box;
					}',
					// '.qa-template-user .qa-part-form-activity {top:'.(86+$avatarsize).'px}',
					// '.qa-template-user .qa-part-form-activity .qa-form-wide-table{width:'.$avatarsize.'px}',
					// '.qa-template-user tbody'
					'//--></STYLE>'
				);
		}
		
		function nav_user_search() // outputs login form if user not logged in
		{
			if (!qa_is_logged_in()) {
				$login=@$this->content['navigation']['user']['login'];
				
				if (isset($login) && !QA_FINAL_EXTERNAL_USERS) {
					$this->output(
						'<!--[Begin: login form]-->',				
						'<form id="qa-loginform" action="'.$login['url'].'" method="post">',
							'<input type="text" id="qa-userid" name="emailhandle" placeholder="'.trim(qa_lang_html('users/email_handle_label'), ':').'" />',
							'<input type="password" id="qa-password" name="password" placeholder="'.trim(qa_lang_html('users/password_label'), ':').'" />',
							'<div id="qa-rememberbox"><input type="checkbox" name="remember" id="qa-rememberme" value="1"/>',
							'<label for="qa-rememberme" id="qa-remember">'.qa_lang_html('users/remember').'</label></div>',
							'<input type="hidden" name="code" value="'.qa_html(qa_get_form_security_code('login')).'"/>',
							'<input type="submit" value="'.$login['label'].'" id="qa-login" name="dologin" />',
						'</form>',				
						'<!--[End: login form]-->'
					);
					
					unset($this->content['navigation']['user']['login']); // removes regular navigation link to log in page
				}
			}
			
			qa_html_theme_base::nav_user_search();
		}
        
        
		
		function logged_in() // adds points count after logged in username
		{
			// output user avatar to login bar
			if (qa_is_logged_in())
            $this->output('<DIV CLASS="qa-logged-in-avatar">'.qa_get_user_avatar_html(qa_get_logged_in_user_field('flags'), qa_get_logged_in_user_field('email'), qa_get_logged_in_user_field('handle'), qa_get_logged_in_user_field('avatarblobid'), 24,24, qa_opt('avatar_users_size'), false).'</DIV>');

			qa_html_theme_base::logged_in();

			if (qa_is_logged_in()) {
				$userpoints=qa_get_logged_in_points();
				
				$pointshtml=($userpoints==1)
					? qa_lang_html_sub('main/1_point', '1', '1')
					: qa_lang_html_sub('main/x_points', qa_html(number_format($userpoints)));
						
				$this->output(
					'<SPAN CLASS="qa-logged-in-points">',
					'('.$pointshtml.')',
					'</SPAN>'
				);
			}
		}
    
		function body_header() // adds login bar, user navigation and search at top of page in place of custom header content
		{
			$this->output('<div id="qa-login-bar"><div id="qa-login-group">');
			$this->nav_user_search();
            $this->output('</div></div>');
        }
		
		function header_custom() // allows modification of custom element shown inside header after logo
		{
			if (isset($this->content['body_header'])) {
				$this->output('<DIV CLASS="header-banner">');
				$this->output_raw($this->content['body_header']);
				$this->output('</DIV>');
			}
		}
		
		function header() // removes user navigation and search from header and replaces with custom header content. Also opens new <DIV>s
		{	
			$this->output('<DIV CLASS="qa-header">');
			$this->output('<DIV CLASS="qa-header-group">');
			
			$this->logo();						
			$this->header_clear();
			$this->header_custom();

			$this->output('</DIV> <!-- END qa-header-group -->', '');	
			$this->output('</DIV> <!-- END qa-header -->', '');			
			$this->nav_main_sub();
		}

		function body_content()
		{
			$this->body_prefix();
			$this->notices();

			$this->widgets('full', 'top');
			$this->header();

			$this->output('<DIV CLASS="qa-body-wrapper">', '');
			$this->output('<DIV CLASS="qa-main-wrapper">', '');

			$this->widgets('full', 'high');
			$this->sidepanel();
			$this->main();
			$this->widgets('full', 'low');
			$this->footer();
			$this->widgets('full', 'bottom');
			
			$this->output('</DIV> <!-- END body-wrapper -->');
			
			$this->body_suffix();
		}
		
		function main()
		{
			if ($this->template=='user')
				$this->reorder_parts(array('form_activity', 'form_profile'));
			
			qa_html_theme_base::main();
		}

		function sidepanel()
		{
			if($this->template != 'user')
			qa_html_theme_base::sidepanel();
		}
		
		function footer() // prevent display of regular footer content (see body_suffix()) and replace with closing new <DIV>s
		{
			$this->output('</DIV> <!-- END main-wrapper -->');		
		}		
		
		function title() // add RSS feed icon after the page title
		{
			qa_html_theme_base::title();
			
			$feed=@$this->content['feed'];
			
			if (!empty($feed))
				$this->output('<a href="'.$feed['url'].'" title="'.@$feed['label'].'"><img src="'.$this->rooturl.'images/rss.jpg" alt="" width="16" height="16" border="0" CLASS="qa-rss-icon"/></a>');
		}
		
		function q_item_stats($q_item) // add view count to question list
		{
			$this->output('<DIV CLASS="qa-q-item-stats">');
			
			$this->voting($q_item);
			$this->a_count($q_item);
			qa_html_theme_base::view_count($q_item);

			$this->output('</DIV>');
		}
		
		function view_count($q_item) // prevent display of view count in the usual place
		{
		}
		
		function body_suffix() // to replace standard Q2A footer
        {
			$this->output('<div class="qa-footer-bottom-group">');
			qa_html_theme_base::footer();
			$this->output('</DIV> <!-- END footer-bottom-group -->', '');
        }
		
		function attribution()
		{
			$this->output(
				'<DIV CLASS="qa-attribution">',
				'&nbsp;| Snow Theme by <a href="http://www.q2amarket.com">Q2A Market</a>',
				'</DIV>'
			);

			qa_html_theme_base::attribution();
		}
		
	}
	 

/*
	Omit PHP closing tag to help avoid accidental output
*/