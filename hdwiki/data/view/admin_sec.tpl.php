<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
function doSubmit(){
	var forbidden_edit_time = $("#forbidden_edit_time").val();
	if ( forbidden_edit_time=='' || !/^\d+$/.test(forbidden_edit_time) || forbidden_edit_time < 0){
		alert('禁言时间应该为0-999之间的整数!');
		$("#forbidden_edit_time").focus();
		return false;
	}
}
</script>

<p class="map">全局：扩展设置</p>
<p class="sec_nav">扩展设置：
    <a href="index.php?admin_setting-sec" class="on"> <span>防灌水设置</span></a>
    <a href="index.php?admin_setting-anticopy" ><span>防采集设置</span></a>
    <a href="index.php?admin_setting-mail"><span>邮件设置</span></a>
    <a href="index.php?admin_setting-noticemail"><span>邮件提醒设置</span></a>
    <a href="index.php?admin_banned" ><span>IP禁止</span></a>
    <a href="index.php?admin_setting-passport" ><span>通行证设置</span></a>
    <a href="index.php?admin_setting-ucenter"><span>UCenter设置</span></a>
    <a href="index.php?admin_setting-ldap"><span>LDAP设置</span></a>
</p><h3 class="col-h3">防灌水设置</h3>
<form method="POST" action="index.php?admin_setting-sec" onsubmit="return doSubmit();">
<table class="table">
	<tr>
		<td width="300px"><span>参数名称</span></td>
		<td><span>参数值</span></td>
	</tr>
	<tr>
		<td><span>创建词条需输入验证码</span>需在基本设置页面打开验证码功能，否则本设置无效</td>
		<td>
		<label><input type="radio"  name="doc_verification_create_code" value="1"
		<?php if($basecfginfo['doc_verification_create_code']=='1') { ?>checked<?php } ?>/>是</label>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label><input type="radio"  name="doc_verification_create_code" value="0" 
		<?php if($basecfginfo['doc_verification_create_code']=='0') { ?>checked<?php } ?>/>否</label>
		</td>
	</tr>
	<tr>
		<td><span>编辑词条需输入验证码</span>需在基本设置页面打开验证码功能，否则本设置无效</td>
		<td>
		<label><input type="radio"  name="doc_verification_edit_code" value="1"
		<?php if($basecfginfo['doc_verification_edit_code']=='1') { ?>checked<?php } ?>/>是</label>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label><input type="radio"  name="doc_verification_edit_code" value="0" 
		<?php if($basecfginfo['doc_verification_edit_code']=='0') { ?>checked<?php } ?>/>否</label>
		</td>
	</tr>
	<tr>
		<td><span>编辑参考资料需输入验证码</span>需在基本设置页面打开验证码功能，否则本设置无效</td>
		<td>
		<label><input type="radio"  name="doc_verification_reference_code" value="1"
		<?php if($basecfginfo['doc_verification_reference_code']=='1') { ?>checked<?php } ?>/>是</label>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label><input type="radio"  name="doc_verification_reference_code" value="0" 
		<?php if($basecfginfo['doc_verification_reference_code']!='1') { ?>checked<?php } ?>/>否</label>
		</td>
	</tr>
	<tr>
		<td><span>禁言时间</span>HDWiki新注册用户N分钟内无法创建和编辑词条。</td>
		<td><input class="inp_txt" id="forbidden_edit_time" name="forbidden_edit_time"  type="text" style="width:200px;"  maxlength="3" value="<?php if(!empty($basecfginfo['forbidden_edit_time'])) { ?><?php echo $basecfginfo['forbidden_edit_time']?><?php } ?>" /> 分钟</td>
	</tr>
	<tr>
		<td width="300px"><span>英文内容比例限制值错误</span>词条内容中的英文字节数占内容字节数的最大比值，如果超出此值，则判断为垃圾信息。<br />填写100则不限制，不建议填写 0 。</td>
		<td>
		<input class="inp_txt" id="eng_max_pcnt" name="eng_max_pcnt"  type="text" style="width:200px;"  maxlength="3" value="<?php if(!empty($basecfginfo['eng_max_pcnt'])) { ?><?php echo $basecfginfo['eng_max_pcnt']?><?php } ?>" /> %</td>
	</tr>
	<tr>
		<td width="300px"><span>外部链接比例限制</span>词条内容中外部链接字节数占内容字节数的最大比值，如果超出此值，则判断为垃圾信息。<br />填写100则不限制，填写0则只要出现外部链接即判断为垃圾信息。</td>
		<td>
		<input class="inp_txt" id="extlink_max_pcnt" name="extlink_max_pcnt"  type="text" style="width:200px;"  maxlength="3" value="<?php if(!empty($basecfginfo['extlink_max_pcnt'])) { ?><?php echo $basecfginfo['extlink_max_pcnt']?><?php } ?>" /> %</td>
	</tr>
	<tr>
		<td><span>词条发布时间间隔判断</span>如果词条发布时间间隔小于设定值，则判断为垃圾信息，设为0则不限制，最大99999。</td>
		<td >		<input class="inp_txt" id="submit_min_interval" name="submit_min_interval"  type="text" style="width:200px;"  maxlength="5" value="<?php if(!empty($basecfginfo['submit_min_interval'])) { ?><?php echo $basecfginfo['submit_min_interval']?><?php } ?>" /> 秒</td>
	</tr>
	
	<tr>
		<td><span>词条被判断为垃圾信息后的处理方式</span></td>
		<td >
		<label><input type="radio"  name="save_spam" value="1" 
		<?php if(!empty($basecfginfo['save_spam']) && $basecfginfo['save_spam']=='1') { ?>checked="checked"<?php } ?>/> 保存为待审核状态</label>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label><input type="radio"  name="save_spam" value="0"
		<?php if(!empty($basecfginfo['save_spam']) && $basecfginfo['save_spam']=='0') { ?>checked="checked"<?php } ?>/> 禁止发布</label>
		</td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input class="inp_btn" name="secsubmit" type="submit" value="保 存" />&nbsp;&nbsp;
			<input class="inp_btn" type="reset" value="重置" />
		</td>
	</tr>
</table>
</from>
<?php include $this->gettpl('admin_footer');?>