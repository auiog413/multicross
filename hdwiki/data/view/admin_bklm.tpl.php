<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>

<p class="map">百科联盟：联盟首页</p>

<?php if(!$is_login) { ?>

	<script type="text/javascript">
	String.prototype.Trim = function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	}
	
	function getFormData(FormElement){
		var data={};
		var inputs=$(FormElement).find(":input"), fields=inputs.serializeArray();
		$.each(fields, function(i, field){
			var type=inputs.filter('[name='+field.name+']').attr('type');
			
			if(/checkbox/i.test(type)){
				if(!data[field.name]){
					data[field.name]=field.value;
				}else{
					data[field.name] += ', '+field.value;
				}
			}else{
				data[field.name]=field.value;
			}
		});
		
		return data;
	}
	
	function setTip(name, msg){
		$("#errorinfo").html(msg);
	}

	function check_login(FormElement){
		var re_email = /^[a-z0-9]([a-z0-9]*[-_.]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2,3})?$/i,
			re_qq = /^\d{5,12}$/,
			params=getFormData(FormElement);
		
		setTip('', '');
		
		if (params.email == '' || !re_email.test(params.email)){
			setTip('form-'+params.action+'-email', '请输入有效的Email地址');
			return false;
		}
		
		if (params.pwd.length <6 ){
			setTip('form-'+params.action+'-pwd', '请输入密码6--16位');
			return false;
		}

		params.wikiurl = '';
		
		//提取hdwiki访问路径以及主站域名
		if (location.href.indexOf('index.php?')){
			params.wikiurl = location.href.split('index.php?')[0];
		}
		params.sitedomain = location.host;
		
		var submit=$(FormElement).find(':submit');
		
		$.ajax({
			url:'index.php?admin_hdapi-login',
			type:'POST',
			data:params,
			timeout:60000,
			dataType:'html',
			beforeSend:function(){
				submit.attr('disabled', true);
				setTip('form-'+params.action+'-error', '正在提交信息...');
			},
			success :function(data, state){
				setTip('form-'+params.action+'-error', '');
				
			   var message=$.trim(data);
			   if(message.indexOf('<') > -1){
					setTip('form-'+params.action+'-error', '提交失败，原因可能是网络链接失败。');
			   }else if(message == 'OK'){
					alert('百科联盟开通成功；新知社分享申请成功。');
					location.reload();
			   }else{
					message = message || "：网络连接失败。";
					setTip('form-'+params.action+'-error', '提交失败，原因可能是'+message);
			   }
			},
			complete :function(response, state){
				if (state != 'success'){
					setTip('form-'+params.action+'-error', '由于网络连接错误，提交失败!');
				}
				submit.attr('disabled', false);
			}
		});
	}

	</script>

	<ul class="col-ul">
	<li>在使用联盟功能前，您需要进行一次登录。登录之后您就可以和互动百科网站通信。<br/> 
	Email和密码就是您在互动百科网站(baike.com)注册时填写的Email和密码。 <br/> 
	如果您还不是互动百科网站的用户，请先进行<a href="http://passport.baike.com/user/userRegister.jsp" target="_blank">注册</a>。</li>
	</ul>
	<form id="form-login" action="#" method="post" target="_self" onsubmit="check_login(this);return false;">
	<ul class="col-ul ul_li_sp">
	<li><span>E-mail：</span><input name="email" type="text" maxlength="50" class="inp_txt w-140 m-r10" />（在互动百科注册的E-mail）</li>
	<li><span>互动密码：</span><input name="pwd" type="password" maxlength="30" class="inp_txt w-140 m-r10" />（互动百科帐号对应的密码）</li>
	<li><input type="hidden" name="action" value="login" /><input type="submit" value="登 录"  class="inp_btn"/></li>
	<li id="errorinfo" class="red"></li>
	</ul>
	</form>
<?php } else { ?>

	<style>
		.bklmok, .bklmerr{display:none;}
	</style>
	<form method="post">
	<ul class="col-ul">
	
	<li class="bklm">正在获取联盟信息，请稍等...</li>
	
	<li class="bklmok">欢迎你，<span name="name"><?php echo $name?></span> 站长，去<a href="http://i.baike.com/profile.do?useriden=<?php echo $site_key?>" target="_blank">新知社</a>逛逛</li>
	<li class="bklmok">
		站点类型：<span name="site_class"><?php echo $site_class?></span> <br />
		在互动百科主站贡献：<span name="user_credit"><?php echo $user_credit?></span>个信用 <br />
		已经兑换信用数：<span name="user_credit_exchange"><?php echo $user_credit_exchange?></span> <br />
		还剩余信用数：<span name="user_credit_left"><?php echo $user_credit_left?></span> <br />
		在互动主站创建词条：<span name="doc_create"><?php echo $doc_create?></span> <br />
		在互动主站协作词条：<span name="doc_cooper"><?php echo $doc_cooper?></span> <br />
		违规数：<span name="warning_count"><?php echo $warning_count?></span> <br /> 
  </li>
	
	<li class="bklmerr">联盟信息获取失败，请稍候再试。</li>
	<li class="bklmerr">出现此问题，请先确认服务器是否可以访问外网。</li>
	
	
	<li><br />更多疑问请咨询：<a href="http://kaiyuan.hudong.com/bbs/forumdisplay.php?fid=41" target="_blank">HDWiki论坛百科联盟频道</a></li>
	<li class="wiki_url" style="display:none;color:red"></li>
	</ul>
	</form>
	
	<script>
	var wikiurl, sitedomain=location.host;
	
	if (location.href.indexOf('index.php?')>-1){
		wikiurl = location.href.split('index.php?')[0];
	}
	
	function getindexinfo(){
		var url="index.php?admin_hdapi-getindexinfo-"+Math.random();
		$.ajax({
			url:url,
			dataType:"json",
			timeout: 25000,
			type: "GET",
			success:function(obj){
				setindexinfo(obj);
			},
			complete:function(xmlhttp, state){
				if(state == "parsererror" && xmlhttp.responseText){
					alert("数据格式错误，可能HDWiki系统文件被修改，请检查。\n"+xmlhttp.responseText);
				}
				
				if(state!= "success"){
					$("li.bklm, li.bklmok").hide();
					$("li.bklmerr").show();
				} 
			}
		});
	}
	
	function setindexinfo(obj){
		if(obj && (typeof obj == 'object') && obj['success']){
			obj = obj['data'];
			for (var sitenick in obj){
				obj=obj[sitenick];
				$("span[name=name]").text(sitenick);
				for(var name in obj){
					$("span[name="+name+"]").text(obj[name]);
					if(name == 'wiki_url' && wikiurl && obj[name] != wikiurl && obj[name]+'/' != wikiurl){
						$("li.wiki_url").html('百科联盟记录的网址('+obj[name]+
							')和当前网址不一致，请在“修改联盟资料”页面重新提交站长信息！'
						).show();
					}
				}
				break;
			}
			
			$("li.bklmok").show();
			$("li.bklm,li.bklmerr").hide();
		}else{
					
		}
	}
	
	$(document).ready(function(){
		getindexinfo();
	});
	</script>
<?php } ?>

<?php include $this->gettpl('admin_footer');?> 