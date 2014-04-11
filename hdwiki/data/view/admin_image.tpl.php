<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
var searchdata = "<?php echo $searchdata?>".replace(/-/g, ",");
var manage = function (number){
	if($("input[name='chkdid[]']:checked").length==0){
		alert('请先选择图片');
		return false;
	}else{
		var imageform=$("form[name='imageform']");
		var tip=['确认要删除图片吗?','确认要设置精华图片吗?','确认要取消精华图片吗?'];
		var action=['remove','editimage-focus-1','editimage-focus-0'];
		if(confirm(tip[number])==false){
			return false;
		}else{
			imageform.attr("action", 'index.php?admin_image-'+action[number]+'-'+searchdata);
			imageform.submit();
		}
	}
}
var selectAll = function (){
	$("input[name='chkdid[]']").attr('checked',$("input[name='checkbox']").attr('checked'));
}
$(document).ready(function(){
	$("img").each(function(i){
		var img = this; 
		img.title="点击浏览大图";
	}).click(function(){
		var url=$(this).attr("src");
		$.dialog.open('image', '图片浏览', 'img:'+url);
	});
});
</script>

<p class="map">内容管理：图片百科</p>

<div class="tpbk">
	<form name="search" method="post" action="index.php?admin_image-default" >
	<ul class="col-ul ul_li_sp m-t10">
		<li><span>按词条分类: </span><select name="qcattype">
						<option value="0" >所有分类</option>
						<?php echo $catstr?>
					</select></li>
		<li><span>按词条名: </span><input name="qtitle" type="text" class="inp_txt m-r10" value="<?php echo $qtitle?>"/></li>
		<li><span>按词条创建作者:</span><input name="qauthor" type="text" class="inp_txt m-r10" value="<?php echo $qauthor?>"/></li>
		<li><span>按词条创建时间:</span><input readonly name="qstarttime" type="text" class="inp_txt" onclick="showcalendar(event, this);" value="<?php echo $qstarttime?>" /> — <input readonly name="qendtime" type="text" class="inp_txt" onclick="showcalendar(event, this);" value="<?php echo $qendtime?>"/></li>
		<li><input name="submit" type="submit" value="搜 索"  class="inp_btn"/></li>
	</ul>
	</form>
	<h3 class="tol_table">[ 共 <b><?php echo $docsum?></b> 张图片 ]</h3>
	<form method="post" name="imageform">
	<table class="table w-img">
		<thead>
			<tr>
				<td style="width:60px;">选择</td>
				<td style="width:100px;">图片</td>
				<td style="width:150px;">标题</td>
				<td style="width:80px;">大小</td>
				<td style="width:280px;">描述</td>
				<td>精华</td>
			</tr>
		</thead>
		<?php foreach((array)$imagewiki as $image) {?>	
		<tr>
			<td><input type="checkbox" name="chkdid[]" value="<?php echo $image['id']?>" /></td>
			<td><a class="a-img3">
				<?php if(file_exists($image['attachment'])) { ?>
					<img src="<?php echo $image['attachment']?>" />
				<?php } else { ?>
					<img src="style/default/plugin.jpg" />
				<?php } ?></a>
			</td>
			<td><?php echo $image['filename']?></td>
			<td><?php echo $image['filesize']?></td>
			<td><?php echo $image['description']?></td>
			<td><?php if($image['focus']==1) { ?><font class="red">是</font><?php } else { ?>否<?php } ?></td>
		</tr>
		<?php } ?>
		<tr>
			<td><label> <input name="checkbox" type="checkbox" id="chkall" onclick="selectAll();"> 全选</label></td>
			<td colspan="5"><input name="Button1" type="button" value="放入回收站"  class="inp_btn2 m-r10" onclick="manage(0);" /><input name="Button1" type="button" value="加 精"  class="inp_btn2 m-r10" onclick="manage(1);" /><input name="Button1" type="button" value="取消加精"  class="inp_btn2" onclick="manage(2);" /></td>
		</tr>
		<tr>
			<td colspan="6"><p class="fenye a-r"><?php echo $departstr?></p></td>
		</tr>
	</table>
	</form>
</div>

<?php include $this->gettpl('admin_footer');?>
