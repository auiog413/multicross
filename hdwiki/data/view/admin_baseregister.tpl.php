<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
function doSubmit(){
	var name_min_length = $.trim($("input[name*='name_min_length']").val());
	if ( name_min_length=='' || !/^\d+$/.test(name_min_length) || name_min_length < 1){
		//alert('注册用户名最小长度设置错误！');
		$.dialog.box('immageshow', '注意', '注册用户名最小长度设置错误！');
		$("input[name*='name_min_length']").focus();
		return false;
	}
	
	var name_max_length = $.trim($("input[name*='name_max_length']").val());
	if (name_max_length =='' || (!/^\d+$/.test(name_max_length) || name_max_length > 20)){
		//alert('注册用户名最大长度设置错误！');
		$.dialog.box('immageshow', '注意', '注册用户名最大长度设置错误！');
		$("input[name*='name_max_length']").focus();
		return false;
	}
	
	name_min_length = parseInt(name_min_length);
	name_max_length = parseInt(name_max_length);
	if (name_max_length <= name_min_length){
		//alert('注册用户名最小长度应该小于最大长度！');
		$.dialog.box('immageshow', '注意', '注册用户名最小长度应该小于最大长度！');
		$("input[name*='name_max_length']").focus();
		return false;
	}
	
	var register_least_minute = $.trim($("input[name*='register_least_minute']").val());
	if (register_least_minute && !/^\d+$/.test(register_least_minute)){
		//alert('IP 注册间隔限制必须为数字！');
		$.dialog.box('immageshow', '注意', 'IP 注册间隔限制必须为数字！');
		$("input[name*='register_least_minute']").focus();
		return false;
	}
	
	if ( isNaN($("input[name*='inviter_credit']").val())){
		$.dialog.box('immageshow', '注意', '邀请者奖励积分必须是一个数字');
		$("input[name*='inviter_credit']").focus();
		return false;
	}
	if ( isNaN($("input[name*='invitee_credit']").val())){
		$.dialog.box('immageshow', '注意', '被邀请者奖励积分必须是一个数字');
		$("input[name*='invitee_credit']").focus();
		return false;
	}

	
	if(confirm('警告：提交后将覆盖系统当前参数设置，是否继续?')==false){
		return false;
	}
}

function checkSize(itemId, noticeId){
	var size=300-$('#'+itemId).val().length;
	if(size<=0){
		$('#'+itemId).val($('#'+itemId).val().substr(0,300));
		size=0;
	}
	$('#'+noticeId).html('您还可以输入&nbsp;'+size+'个字符');
	//divDance('pmssize');
}
</script>
<p class="map">用户管理：注册控制</p>
<form method="post" action="index.php?admin_setting-baseregister" onsubmit="return doSubmit();">
<table  class="table">
	<tr>
		<td style="width:430px"><span>参数名称</span></td>
		<td><span>参数值</span></td>
	</tr>
	<tr>
		<td><span>允许新用户注册</span>
			设置是否新用户注册，此处设置不会影响已注册用户。</td>
		<td>
			
			<label><input type="radio"  name="setting[reg_status]" value="0" <?php if($basecfginfo['reg_status']=='0') { ?>checked="checked"<?php } ?> onclick="$('#close_reason').show(); $('#invite_setting').hide();" /> 关闭注册</label><br />
			<label><input type="radio"  name="setting[reg_status]" value="1" <?php if($basecfginfo['reg_status']=='1') { ?>checked="checked"<?php } ?> onclick="$('#close_reason').hide(); $('#invite_setting').hide();"  /> 只开放普通注册</label><br />
			<label><input type="radio"  name="setting[reg_status]" value="2" <?php if($basecfginfo['reg_status']=='2') { ?>checked="checked"<?php } ?> onclick="$('#close_reason').hide(); $('#invite_setting').show();"  /> 只开放邀请注册</label><br />
			<label><input type="radio"  name="setting[reg_status]" value="3" <?php if($basecfginfo['reg_status']=='3') { ?>checked="checked"<?php } ?> onclick="$('#close_reason').hide(); $('#invite_setting').show();"  /> 开放普通注册和邀请注册</label>
		</td>
	</tr>
	<tbody id="invite_setting"  <?php if($basecfginfo['reg_status']!= '2' && $basecfginfo['reg_status']!= '3') { ?> style="display: none"<?php } ?>>
	<tr><td><span>邀请者奖励经验值</span></td><td><input class="inp_txt" name="setting[inviter_credit]"  type="text" value="<?php echo $basecfginfo['inviter_credit']?>" maxlength="4" /></td></tr>
	<tr><td><span>被邀请者奖励经验值</span></td><td><input class="inp_txt" name="setting[invitee_credit]"  type="text" value="<?php echo $basecfginfo['invitee_credit']?>" maxlength="4" /></td></tr>
	
	<tr><td><span>邀请邮件标题</span></td><td><input class="inp_txt" name="setting[invite_subject]"  type="text" value="<?php echo $basecfginfo['invite_subject']?>" maxlength="40" /></td></tr>
	<tr><td><span>邀请邮件内容</span>邀请邮件内容支持变量替换，可使用的替换符如下：<br />
邀请者用户名：_USERNAME_ (也可用于邮件标题)<br />
网站名：_SITENAME_ <br />
链接地址：_LINK_ <br />
邀请附言：_PS_ <br />
邀请时间：_TIME_
	</td><td><textarea name="setting[invite_content]" class="textarea" rows="8" id="ivtContent" onkeyup="checkSize('ivtContent', 'ivtnotice');"><?php echo $basecfginfo['invite_content']?></textarea><br />
		<span id="ivtnotice"></span>
	</td></tr>
	</tbody>
	<tbody id="close_reason" <?php if($basecfginfo['reg_status']) { ?> style="display: none"<?php } ?>>
	<tr>
		<td><span>关闭用户注册的原因</span></td>
		<td><textarea name="setting[close_register_reason]" class="textarea" rows="5"><?php echo $basecfginfo['close_register_reason']?></textarea></td>
	</tr>
	</tbody>
	
	<tr>
		<td><span>禁止注册的用户名</span>
			可以设置通配符，每个关键字一行，可使用通配符 "*" 如 "*版主*"(不含引号)。</td>
		<td><textarea name="setting[error_names]" class="textarea" rows="4"><?php echo $basecfginfo['error_names']?></textarea></td>
	</tr>
	<tr>
		<td><span>新用户是否需审核</span>如果新用户需要审核，则在被审核之前是不能发布和编辑词条的。</td>
		<td><label>
				<input type="radio"  name="setting[register_check]" value="1" <?php if($basecfginfo['register_check']=='1') { ?>checked<?php } ?>/>
				是</label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label>
				<input type="radio"  name="setting[register_check]" value="0" <?php if($basecfginfo['register_check']=='0') { ?>checked<?php } ?>/>
				否</label></td>
	</tr>
		<td><span>注册用户名最小长度</span>用户在注册时的最小的用户名字符长度，一个汉字等于2个字符长度。<br>注意：如果开启了UC插件，请将最小长度设为3、最大长度设为15</td>
		<td><input class="inp_txt" name="setting[name_min_length]"  type="text"   maxlength="2" value="<?php echo $basecfginfo['name_min_length']?>" /></td>
	</tr>
	<tr>
		<td><span>用户名最大长度</span>最大长度应该大于最小长度并且小于等于20。</td>
		<td><input class="inp_txt" name="setting[name_max_length]"  type="text"  maxlength="2" value="<?php echo $basecfginfo['name_max_length']?>" /></td>
	</tr>
	<tr>
		<td><span>IP 注册间隔限制</span>同一 IP 在本时间间隔内将只能注册一个帐号，0 为不限制，单位是分钟。</td>
		<td><input class="inp_txt" name="setting[register_least_minute]"  type="text" maxlength="4"  value="<?php echo $basecfginfo['register_least_minute']?>" /></td>
	</tr>
	<tr><td><span>发送欢迎信息</span></td>
		<td>
			<label><input type="radio"  name="setting[send_welcome]" value="0" <?php if($basecfginfo['send_welcome']=='0') { ?>checked="checked"<?php } ?> onclick="$('#welcome_setting').hide();" /> 不发送</label><br />
			<label><input type="radio"  name="setting[send_welcome]" value="1" <?php if($basecfginfo['send_welcome']=='1') { ?>checked="checked"<?php } ?> onclick="$('#welcome_setting').show();"  /> 发送欢迎短消息</label><br />
			<label><input type="radio"  name="setting[send_welcome]" value="2" <?php if($basecfginfo['send_welcome']=='2') { ?>checked="checked"<?php } ?> onclick="$('#welcome_setting').show();"  /> 发送欢迎 Email</label><br />
		</td>
	</tr>
	
	<tbody id="welcome_setting" <?php if($basecfginfo['send_welcome']=='0') { ?>style="display: none;"<?php } ?>>
	<tr><td><span>欢迎信息标题</span></td><td><input class="inp_txt" name="setting[welcome_subject]"  type="text" value="<?php echo $basecfginfo['welcome_subject']?>" maxlength="35" /></td></tr>
	<tr><td><span>欢迎信息内容</span>邀请邮件内容支持变量替换，可使用的替换符如下：<br />
用户名：_USERNAME_ (也可用于邮件标题)<br />
网站名：_SITENAME_ <br />
网站地址：_LINK_ <br />
发送时间：_TIME_
	</td><td><textarea name="setting[welcome_content]" class="textarea" rows="8" id="wlcContent" onkeyup="checkSize('wlcContent', 'wcnotice');"><?php echo $basecfginfo['welcome_content']?></textarea><br />
		<span id="wcnotice"></span>
	</td></tr>
	</tbody>	
	
	<tr>
		<td colspan="2"><input class="inp_btn" name="settingsubmit" type="submit" value="保 存" />
			&nbsp;&nbsp;
			<input class="inp_btn" type="reset" value="重置" /></td>
	</tr>

	
</table>
</from>
<?php include $this->gettpl('admin_footer');?>