<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript" src="js/ui/ui.core.js"></script>
<script type="text/javascript" src="js/ui/ui.sortable.js"></script>
<script type="text/javascript">
var beginMoving=false;
var selectAll = function (eleName,state){
	$("input[name='"+eleName+"']").attr('checked',state);
}
var remove = function (){
	if(checkBox('link_id[]')!=false){
		if(confirm('是否删除该链接？')==false){
				return false;
		}else{
			$("form[name='linkinfo']").attr('action','index.php?admin_friendlink-remove');
			$("form[name='linkinfo']").submit();
		}
	}
}
var checkBox = function (eleName){
	flag= false;
	if($("input[name='"+eleName+"']:checked").length>0)
		flag= true;
	return flag;
}
$(document).ready(function() {
	$("#list").sortable({
		update : function () {
			var order="";
			var numValue=$("input[name='linknum[]']");
			for(var i=0;i<numValue.length;i++){
			order+=$(numValue[i]).val()+",";
			}
			$.post("index.php?admin_friendlink-changeorder",{order:order});
		}
	});
});
</script>

<p class="map">内容管理：友情链接</p>
<p class="sec_nav">友情链接：
<a href="index.php?admin_friendlink" class="on"><span>友情链接列表</span></a>
<a href="index.php?admin_friendlink-add" ><span>添加友情链接</span></a>
</p>

<form method="post" name="linkinfo">
<h3 class="col-h3">友情链接列表</h3>
<ul class="col-ul tips">
<li class="bold">提示: </li>
<li>hdwiki为您提供添加友情链接的功能 </li>
<li>修改数据可能会带来前台链接显示的错乱，请慎重修改每一个链接的数据! </li>
<li>可以通过鼠标上下拖动来实现链接的排序! </li>
</ul>

<h3 class="tol_table">[ 共 <b><?php echo $total?></b> 个友情链接 ]</h3>
<table class="table">
	<colgroup>
		<col  style="width:60px;"></col>
		<col  style="width:110px;"></col>
		<col  style="width:180px;"></col>
		<col  style="width:180px;"></col>
		<col  style="width:160px;"></col>
		<col></col>
	</colgroup>
	<thead>
	<tr>
		<td>选择</td>
		<td>友情链接名称</td>
		<td>友情链接URL</td>
		<td>友情链接简介</td>
		<td>Logo</td>
		<td>操作</td>
	</tr>	
	</thead>
	
	<tbody  id="list">
	<?php foreach((array)$linklist as $key=>$link) {?>
	<tr>
		<td><input type="checkbox" name="link_id[]" value="<?php echo $link['id']?>" />
			<input type="hidden" name="linkid[]" value = "<?php echo $link['id']?>" />
			<input type="hidden" name="linknum[]" value = "<?php echo $link['id']?>" />
			<input type="hidden" class="box" id="link_num[<?php echo $key?>]" name="link_num[]" value="<?php echo $link['displayorder']?>" size=4  readonly/>
		</td>
		<td><?php echo $link['name']?></td>
		<td><a href="<?php echo $link['url']?>" target="_blank"><?php echo $link['url']?></a></td>
		<td><?php echo $link['description']?></td>
		<td><?php if($link['logo']!="") { ?><a href="<?php echo $link['url']?>" target="_blank"><img src="<?php echo $link['logo']?>" width="160px"></a><?php } else { ?>暂无<?php } ?></td>
		<td><a href="index.php?admin_friendlink-edit-<?php echo $link['id']?>">[修改友情链接]</a></td>
	</tr>

	<?php }?>
	</tbody>

	<tfoot>
		<tr>
			<td><input name="chkall" onclick="selectAll('link_id[]',this.checked)" type="checkbox" /> 全选</td>
			<td colspan="5"><input type="button" class="inp_btn2 m-r10" name="delsel" value="删除选中项目" onclick="remove();"/> <input type="button" class="inp_btn2 m-r10" value="开启拖动" onclick="$('#list').sortable('enable')"/> <input type="button" class="inp_btn2 m-r10"  value="关闭拖动" onclick="$('#list').sortable('disable')"/></td>			
		</tr>	
	</tfoot>
</table>
</form>
<?php include $this->gettpl('admin_footer');?>
