<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<p class="map">全局：内容设置</p>
<p class="sec_nav">内容设置： <a href="index.php?admin_setting-index" class="on"> <span>首页设置</span></a> <a href="index.php?admin_setting-listdisplay" ><span>列表设置</span></a> <a href="index.php?admin_setting-watermark" ><span>图片设置</span></a><a href="index.php?admin_setting-watermark" ><span>批量加水印</span></a> <a href="index.php?admin_setting-docset" ><span>词条设置</span></a> <a href="index.php?admin_setting-search" ><span>搜索设置</span></a> <a href="index.php?admin_setting-attachment" ><span>附件设置</span></a></p>
<h3 class="col-h3">首页设置</h3>
<form method="POST" action="index.php?admin_setting-index">
<table class="table">
	<tr>
		<td width="200px"><span>参数名称</span></td>
		<td><span>参数值</span></td>
	</tr>
	<tr>
		
		<td><strong>首页排行榜默认显示</strong><br/>首页排行榜默认显示的方式</td>
		<td>
			<label>
			<input type="radio" name="base_toplist" value="1" <?php if($base_toplist=='1') { ?>checked<?php } ?>/>站内公告</label>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label><input type="radio"  name="base_toplist" value="0" <?php if($base_toplist=='0') { ?>checked<?php } ?>/>最新动态</label>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input class="inp_btn" name="indexsubmit" type="submit" value="保 存" />&nbsp;&nbsp;
		</td>
	</tr>
</table>
</from>
<?php include $this->gettpl('admin_footer');?>