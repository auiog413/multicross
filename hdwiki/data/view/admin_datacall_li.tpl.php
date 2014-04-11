<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
function selectAll(){
	$("input[name='callid[]']").attr('checked',$("input[name='checkbox']").attr('checked'));
}
function datacall_remove(){
	if($("input[name='callid[]']:checked").length==0){
		$.dialog.box('immageshow', '注意', '请选择函数');
		return false;
	}else{
		if(confirm('确定要删除选定的函数么？此操作不可逆转')==false){
			return false;
		}else{
			document.formdacalllist.action='index.php?admin_datacall-remove';
			document.formdacalllist.submit();
		}	
	}
}
$(document).ready(function(){
	$(".bg_hover").hover(function(){
		$(this).addClass("hover");
	},function(){
		$(this).removeClass("hover");
	});

})
</script>
<div>
	<p class="map">内容管理：数据调用</p>
	<p class="sec_nav">数据调用： <a href="index.php?admin_datacall" class="on" > <span>调用列表</span></a> <a href="index.php?admin_datacall-addsql" ><span>SQL调用</span></a> </p>
	<h3 class="col-h3">调用列表</h3>
	<form name="list" method="POST" action="index.php?admin_datacall-search"  style="margin: 0px;">
		<ul class="col-ul ul_li_sp m-t10">
			<li> <span>函数名称:</span>
				<input type="text" name="search[name]" class="inp_txt w-140" value="" />
			</li>
			<li>
				<input name="datacallsearch" type="submit" value="搜 索"   class="inp_btn"/>
			</li>
		</ul>
	</form>
	<form method="POST" name="formdacalllist">
		<table width="100%" cellspacing="0" cellpadding="3" class="table">
			<colgroup>
				<td style="width:50px;"></td>
				<td style="width:150px;"></td>
				<td style="width:70px;"></td>
				<td style="width:70px;"></td>
				<td style="width:70px;"></td>
				<td style="width:180px;"></td>
				<td style="width:70px;"></td>
				<td></td>
			</colgroup>
			<tr>
				<td colspan="8" ><input type="button" class="inp_btn2 m-r10" name="datacall_category" onclick="location.href='index.php?admin_datacall'" value="全部" 	
					<?php if("all" == $categorycss) { ?>
					style="background:#F5F5F5"
					<?php } ?>
					/>
					<?php foreach((array)$category as $k=>$v) {?>
					<input type="button" class="inp_btn2 m-r10" name="datacall_category" onclick="location.href='index.php?admin_datacall-search-<?php echo $k?>'" value="<?php echo $v?>"  
					<?php if((!empty($categorycss) && "$k" == $categorycss)) { ?>
					style="background:#F5F5F5"
					<?php } ?>
					/>
					<?php }?></td>
			</tr>
			<tr>
				<td>ID</td>
				<td>调用名称</td>
				<td>调用分类</td>
				<td>函数类型</td>
				<td>缓存（秒）</td>
				<td>简介</td>
				<td>代码</td>
				<td>操作</td>
			</tr>
			<!-- <?php if($datacalllist != null) { ?> -->
			<?php foreach((array)$datacalllist as $datacall) {?>
			<tr class="red_hover">
				<td><input type="checkbox" name="callid[]" value="<?php echo $datacall['id']?>" />
					<?php echo $datacall['id']?></td>
				<td><?php echo $datacall['name']?></td>
				<td><?php echo $datacall['category']?></td>
				<td><?php echo $datacall['type']?></td>
				<td><?php echo $datacall['cachetime']?></td>
				<td><?php echo $datacall['desc']?></td>
				<td><a href="index.php?admin_datacall-view-<?php echo $datacall['id']?>">查看代码</a></td>
				<td><a href="index.php?admin_datacall-editsql-<?php echo $datacall['id']?>">修改函数</a></td>
			</tr>
			<?php } ?>
			<!-- <?php } ?> -->
			<!-- <?php if($datacalllist == null) { ?> -->
			<tr>
				<td colspan="8">没有找到任何调用函数</td>
			</tr>
			<!-- <?php } ?> -->
			<tr>
				<td colspan="8"><input name="checkbox" type="checkbox" id="chkall" onclick="selectAll();">
								<label id="tip">全选</label>
								<input type="button" class="inp_btn2 m-r10" name="casemanage" onClick="datacall_remove(this.form)" value="删除所选内容" />
								<input type="button" class="inp_btn2 m-r10" name="add_sql" onclick="location.href='index.php?admin_datacall-addsql'" value="添加SQL调用" />			
				</td>
			</tr>
			<tr>
				<td colspan="8"><p class="fenye a-r"> <?php echo $departstr?> </p></td>
			</tr>
		</table>
	</form>
</div>
<?php include $this->gettpl('admin_footer');?>