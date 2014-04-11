<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript" src="js/ui/ui.core.js"></script>
<script type="text/javascript" src="js/ui/ui.sortable.js"></script>
<script type="text/javascript">
var beginMoving=false;
var isDrag = true;
function doSubmit(){
	if(confirm('是否更新所用分类排列顺序？')==false){
		return false;
	}
}

function doEditCat(catid,pcid){
	var catname=$("input[name=cateid\["+catid+"-"+pcid+"\]]").val();
	window.location="index.php?admin_category-edit-"+catid+"-"+pcid;
}

function doDelCat(catid){
	if(confirm('删除分类会删除此分类及子分类以及它们关联的词条!是否删除？')==false){
		return false;
	}else{
		window.location="index.php?admin_category-remove-"+catid;
	}
}

function drag(){
	isDrag = !isDrag;
	if (isDrag){
		$('#list').sortable('enable');
		$('#switchDrag').val("关闭拖动");
	}else{
		$('#list').sortable('disable');
		$('#switchDrag').val("开启拖动");
	}
}

$(document).ready(function() {
	$("#list").sortable({
		update : function () {
			var reorderid="";
			var numValue=$("input[name='order[]']");
			for(var i=0;i<numValue.length;i++){
				reorderid+=$(numValue[i]).val()+",";
			}
			hiddencid=$("input[name='hiddencid']").val();
			$.post("index.php?admin_category-reorder",{order:reorderid,hiddencid:hiddencid});
		}
	});
});
</script>
<script type="text/javascript">
	function doSubmit(){
		var tag=0;
		$("input[name^='cateid']").each(function(){
			var catname = $(this).val();
			catname=$.trim(catname.replace(/<script(.*)>(.*)<\/script>/ig,''));
			$(this).val(catname);
			if(""==catname){
				$(this).attr("style","border:1px #f30 solid;");
				tag=1;
			}else{
				$(this).removeAttr("style");
			}
		});
		if(tag==1){
			$("#box-show").text('红框区域分类不能为空');
			$("#box-show").fadeOut(100).fadeIn(100);
			return false;
		}else{
			return true;
		}
		
	}
	function addInput(){
		$('#catblock').append("<tr><td><input name=\"catname[]\" class=\"inp_txt2\" type=\"text\" size=\"20\" maxlength=\"40\" />&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"javascript:delInput(this)\">删除</a></td></tr>");
	}

	function delInput(obj){
	//	j[0].removeChild(obj.parentNode);
		$(obj).parent().parent().remove();
	}
</script>
<p class="map">内容管理：分类管理</p>
<p class="sec_nav">分类管理： <a href="index.php?admin_category-list" class="on"  > <span>管理分类</span></a> <a href="index.php?admin_category-add"  ><span>添加分类</span></a> <a href="index.php?admin_category-merge"  ><span>合并分类</span></a> </p>
<h3 class="col-h3">管理分类</h3>
<ul class="col-ul tips">
	<li class="bold">提示: 	</li>
	<li>可以通过鼠标上下拖动来实现分类的排序!</li>
	<li class="m-t10"><input id="switchDrag" type="button" class="inp_btn2" value="关闭拖动" onclick="drag()"/></li>
</ul>

<H3 class="col-h4 m-t10">分类 : <a href="index.php?admin_category-list">根目录</a> <?php if(is_array($catnavi)) { ?><?php foreach((array)$catnavi as $tid=>$tcat) {?>
	&gt;&gt; <a href="index.php?admin_category-list-<?php echo $tcat['cid']?>"><?php echo $tcat['name']?></a> <?php }?><?php } ?>
</H3>
<form name="orderlist" method="POST" action="index.php?admin_category-batchedit" onsubmit="return doSubmit();">
	<input type="hidden" name="hiddencid" value="<?php echo $pid?>" />
	<table class="table" style="margin:0px;padding:0px;">
		<colgroup>
			<col  style="width:160px;"></col>
			<col  style="width:120px;"></col>
			<col  style="width:120px;"></col>
			<col  style="width:120px;"></col>
			<col></col>
		</colgroup>
		<thead>
		<tr>
			<td>分类名称</td>
			<td >查看子分类</td>
			<td>添加</td>
			<td>删除分类</td>
			<td>移动分类</td>
		</tr>
		</thead>
	</table>
	<ul id="list" style="cursor: hand; cursor: pointer;margin:0px;padding:0px;">
		<?php if(is_array($cats)) { ?>
		<?php foreach((array)$cats as $cid=>$cat) {?>
		<li style="list-style:none;margin:0px;padding:0px;line-height:22px;">
			<table class="table" style="margin:0px;padding:0px;">
			<colgroup>
				<col style="width:160px;"></col>
				<col style="width:120px;"></col>
				<col style="width:120px;"></col>
				<col style="width:120px;"></col>
				<col></col>
			</colgroup>
				<tr>
					<td style="width:120px;"><input name="order[]" type="hidden" value="<?php echo $cat['cid']?>"/>
						<input class="inp_txt2" size="20" name="cateid[<?php echo $cat['cid']?>-<?php echo $cat['pid']?>]" value="<?php echo $cat['name']?>"></td>
					<td style="width:80px;"><a href="index.php?admin_category-list-<?php echo $cat['cid']?>">查看子分类</a></td>
					<td style="width:80px;" ><a href="index.php?admin_category-add-<?php echo $cat['cid']?>">添加子分类</a></td>
					<td style="width:80px;" ><a href="#" onclick="doDelCat('<?php echo $cat['cid']?>');">删除分类</a></td>
					<td><a href="#" onclick="doEditCat('<?php echo $cat['cid']?>','<?php echo $cat['pid']?>');">移动分类</a></td>
				</tr>
			</table>
		</li>
		<?php }?>
		<?php } else { ?>
		<table class="table">
			<tr>
				<td colspan="5">还没添加分类，<a href="index.php?admin_category-add">添加分类</a></td>
			</tr>
		</table>
		<?php } ?>
	</ul>
	<table class="table" id="catblock">
		<colgroup>
			<col style="width:300px;"></col>
			<col></col>
		</colgroup>

		<tr>
			<td >
				<input name="catname[]" class="inp_txt2" type="text" size="20" maxlength="40" value=""/>&nbsp;&nbsp;<input name="Submit1"  type="button" onclick="javascript:addInput()" value="+添加当前分类" class="inp_btn2 m-r10"/>&nbsp;&nbsp;
			</td>
			<td></td>
		</tr>
		<tfoot>
			<tr>
				<td colspan="2"><input name="Submit1" type="submit" value="提 交"  class="inp_btn m-r10"/><span id="box-show" align="left" style="color:red;display:inline;font-weight:normal;"></span></td>
			</tr>
		</tfoot>
	</table>
</form>
<?php include $this->gettpl('admin_footer');?>