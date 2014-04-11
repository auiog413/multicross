<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript" src="js/ui/ui.core.js"></script>
<script type="text/javascript" src="js/ui/ui.sortable.js"></script>
<script type="text/javascript">
var beginMoving=false;
function checkAll(eleName,state){
	$("input[name='"+eleName+"']:enabled").attr('checked',state);
}
function checkdel()
{
	if(checkAllCheckbox('channel_id[]')!=false){
		if(confirm('是否删除该频道？')==false){
			return false;
		}else{
			$("form[name='channelinfo']").attr('action','index.php?admin_channel-remove');
			$("form[name='channelinfo']").submit();
		}
  	 }
}
function checkAllCheckbox(eleName)
{
	flag= false;
	if($("input[name='"+eleName+"']:checked").length>0)
		flag= true;
	return flag;
}
$(document).ready(function() {
	$("#list").sortable({
		update : function () {
			var order="";
			var numValue=$("input[name='channelnum[]']");
			for(var i=0;i<numValue.length;i++){
			order+=$(numValue[i]).val()+",";
			}
			$.post("index.php?admin_channel-changeorder",{order:order});
		}
	});
});

function checknull(){
	if($.trim($('#name').val())==""){
		alert("频道名称不能为空");
		$('#name').focus();
		return false;
	}
	if($.trim($('#url').val())==""){
		alert("频道URL不能为空");
		$('#url').focus();
		return false;
	}else if(IsURL($.trim($('#url').val()))==false){
		alert("URL格式不正确，请重新填写!");
		$('#siteurl').focus();
		return false;
	}
}
function IsURL(str_url){
	return(/(?:https?:\/\/)?\w+\.\w+/.test(str_url));
}

</script>
<p class="map">全局：基本设置</p>
<p class="sec_nav">基本设置：<a href="index.php?admin_channel" class="on"> <span>频道管理</span></a> <a href="index.php?admin_setting-cache"> <span>缓存设置</span></a> <a href="index.php?admin_setting-seo"><span>SEO设置</span></a> <a href="index.php?admin_setting-code"><span>验证码</span></a> <a href="index.php?admin_setting-time"><span>时间设置</span></a> <a href="index.php?admin_setting-cookie"><span>COOKIE设置</span></a> <a href="index.php?admin_setting-credit" ><span>经验金币设置</span></a> <a href="index.php?admin_setting-logo" ><span>LOGO设置</span></a></p>
<h3 class="col-h3">频道管理</h3>

<form name="channeledit" id="channeledit" method="post" action="index.php?admin_channel-add" onsubmit="return checknull();">
	<ul class="col-ul ul_li_sp m-t10">
		<li><span>频道名称</span><input type='text' class="inp_txt m-r10" name='name' id="name" value="" size='50'><input type = 'hidden' name='id' id='id' value="<?php echo $channel['id']?>" /><b class="red">*</b></li>
		<li><span>频道URL</span><input type='text' class="inp_txt m-r10" name='url' id="url" value="http://" size='50'><b class="red">*</b></li>
		<li>
			<span>频道状态</span>
			<input type="radio" name="available" value="1" checked="checked" />显示
			<input type="radio" name="available" value="0" />隐藏
		</li>
		<li>
			<span>位置</span>
			<input type="radio" name="position" value="1" checked="checked" />顶部
			<input type="radio" name="position" value="2" />头部导航
			<input type="radio" name="position" value="3" />底部
		</li>
			<li>
			<input name="channelsubmit" class="inp_btn" type="submit" value="添加"  /></li>
	</ul>
</form>

<form name="channelinfo" method="POST" action="">
<h3 class="col-h4">频道管理</h3>
<ul class="col-ul tips">
<li>hdwiki为您提供添加频道的功能!</li>
<li>修改数据可能会带来前台显示的错乱，请慎重修改每一条数据!</li>
<li>可以通过鼠标上下拖动来实现频道的排序!</li>
</ul>

<table class="table">
	<colgroup>
		<col  style="width:80px;"></col>
		<col  style="width:120px;"></col>
		<col  style="width:240px;"></col>
		<col></col>
	</colgroup>
	<thead>
	<tr>
		<td colspan="5"> <span class="r">筛选
			<select name="navmodelid" onchange="window.location='index.php?admin_channel-default-'+this.value">
				<option value="0">请选择</option>
				<option value="1" <?php if($position==1) { ?>selected<?php } ?>>顶部</option>
				<option value="2" <?php if($position==2) { ?>selected<?php } ?>>头部导航</option>
				<option value="3" <?php if($position==3) { ?>selected<?php } ?>>底部</option>
			</select></span></td>
	</tr>
	<tr>
		<td>选择</td>
		<td>频道名称</td>
		<td>频道URL</td>
		<td>频道位置</td>
		<td>操作</td>
	</tr>	
	</thead>
</table>
<ul id="list" style="cursor: hand; cursor: pointer; margin:0 auto; padding:0;">
	<?php foreach((array)$channellist as $key=>$value) {?>
	<li style="list-style:none;">
	<table class="table">
	<colgroup>
		<col  style="width:80px;"></col>
		<col  style="width:120px;"></col>
		<col  style="width:240px;"></col>
		<col></col>
	</colgroup>
	<tr>
		<td>
			<input type="checkbox" name="channel_id[]" value="<?php echo $value['id']?>" 
			<?php if(in_array($value['id'], range(1,5))) { ?>
				DISABLED="disabled"
			<?php } ?>
			/>
			<input type="hidden" name="channelid[]" value = "<?php echo $value['id']?>" />
			<input type="hidden" name="channelnum[]" value = "<?php echo $value['id']?>" />
			<input type="hidden" id="channel_num[<?php echo $key?>]" name="channel_num[]" value="<?php echo $value['displayorder']?>" size='4' readonly/>
		</td>
		<td><?php echo $value['name']?></td>
		<td><a href="<?php echo $value['url']?>" target="_blank"><?php echo $value['url']?></a></td>
		<td>
			<?php if($value['position']==1) { ?>顶部
			<?php } elseif($value['position']==2) { ?>头部导航
			<?php } elseif($value['position']==3) { ?>底部
			<?php } ?>
		</td>
		<td><a href="index.php?admin_channel-edit-<?php echo $value['id']?>">[修改频道信息]</a></td>
	</tr>
	</table>
	</li>
	<?php }?>
</ul>
<table class="table">
	<colgroup>
		<col  style="width:80px;"></col>
		<col  style="width:120px;"></col>
		<col  style="width:240px;"></col>
		<col></col>
	</colgroup>
	<tfoot>
		<tr>
			<td><input name="chkall" onclick="checkAll('channel_id[]',this.checked)" type="checkbox"/>全选</td>
			<td colspan="3">
			<input type="submit" class="inp_btn2 m-r10" name="delsel" value="删除选中项目" onclick="checkdel();"/> 
			<input type="button" class="inp_btn2 m-r10" value="开启拖动" onclick="$('#list').sortable('enable')"/> 
			<input type="button" class="inp_btn2 m-r10"  value="关闭拖动" onclick="$('#list').sortable('disable')"/>
		</tr>	
	</tfoot>
</table>
</form>
<?php include $this->gettpl('admin_footer');?>