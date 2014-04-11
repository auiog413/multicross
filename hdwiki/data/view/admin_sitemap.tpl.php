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

<p class="map">全局：Sitemap</p>
<p class="sec_nav">Sitemap： <a href="index.php?admin_sitemap-default" class="on"><span>更新操作</span></a> <a href="index.php?admin_sitemap-setting"><span>参数设置</span></a></p>
<h3 class="col-h3">更新操作</h3>
<br /><br />
<style type="text/css">
fieldset { border: 1px solid #CCC; padding: 12px; margin-bottom: 10px; }
fieldset span { color: #333; }
</style>
<table align="center" cellpadding="10" cellspacing="0" width="98%" class="list"> 
  <tr> 
	<td valign="top">
	<form action="index.php?admin_sitemap-createdoc" method="POST">
	<fieldset>
	<legend>重建 Sitemap:</legend>
	<span>当您第一次使用此功能或需要彻底更新Sitemap时（例如修改了HDwiki的URL格式时），请使用此功能。</span>&nbsp;&nbsp;
	<input class="inp_btn2 m-r10" type="submit" value="重建 Sitemap" />
	</fieldset>
	</form>
	
	<form action="index.php?admin_sitemap-updatedoc" method="POST">
	<fieldset>
	<legend>更新 Sitemap:</legend>
	<span>把上次重建或更新操作之后新增的词条添加到Sitemap中。上次更新: <?php echo $sitemap_update?> </span>&nbsp;&nbsp;
	<input class="inp_btn2 m-r10" type="submit" value="更新 Sitemap" />
	</fieldset>
	</form>
	
	<form action="index.php?admin_sitemap-submit" method="POST">
	<fieldset style="border: 1px solid #CCC; padding: 12px; margin-bottom: 10px">
	<legend>提交到搜索引擎:</legend>
	<span>将Sitemap提交或通知到搜索引擎（Google、Ask.com）。</span>&nbsp;&nbsp;
	<input class="inp_btn2 m-r10" type="submit" value="提交到搜索引擎" />
	</fieldset>
	</form>

	<form action="index.php?admin_sitemap-baiduxml" method="POST">
	<fieldset style="border: 1px solid #CCC; padding: 12px; margin-bottom: 10px">
	<legend>更新百度互联网新闻开放协议XML:</legend>
	<span>生成或更新百度互联网新闻开放协议XML。上次更新: <?php echo $baidu_update?></span>&nbsp;&nbsp;
	<input class="inp_btn2 m-r10" type="submit" value="更新百度互联网新闻开放协议XML" />
	</fieldset>
	</form>

	
	</td> 
  </tr> 
</table> 


<?php include $this->gettpl('admin_footer');?>