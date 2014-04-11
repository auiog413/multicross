<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
	var selectALL = function (obj){
		$(".box").attr("checked",obj.checked);
	}
	var edit_available = function (advid){
		$.ajax({
			url: "index.php?admin_adv-edit",cache: false,dataType: "xml",type:"post",data: { advid: advid },
			success: function(xml){
				var	message=xml.lastChild.firstChild.nodeValue;
				if(message=='ok'){
					var available = $('#available_'+advid);
					if('是'==$.trim(available.html())){
						available.html('否');
					}else{
						available.html('是');
					}
				}
			}
		});
	}
	var deleteadv = function (){
		if(confirm('确定删除吗？')){
			if($(".box:checked").length==0){
				alert('没有选择任何广告!');
				return false;
			}
			$('#formadvlist').attr("action","index.php?admin_adv-remove");
			$('#formadvlist').submit();
		}else{
			return false;
		}
	}
	$(function(){
		$("#time").attr("value",'<?php echo $time?>')
		$("#type").attr("value",'<?php echo $type?>')
		$("#orderby").attr("value",'<?php echo $orderby?>')
	}); 
</script>
<p class="map">内容管理：广告管理</p>
<p class="sec_nav">广告管理：<a href="index.php?admin_adv-default" class="on"><span>管理广告</span></a>
<a href="index.php?admin_adv-config"><span>设置广告</span></a>
<a href="index.php?admin_adv-add"><span>添加广告</span></a>
<a href="index.php?admin_adv-union"><span>加入广告联盟</span></a>
</p>
<h3 class="col-h3">管理广告</h3>

<form name="seachadv" method="POST" action="index.php?admin_adv-search" >
	<ul class="col-ul ul_li_sp m-t10">
		<li><span>广告标题: </span><input name="title" type="text" class="inp_txt m-r10" size="30" value="<?php if(isset($title)) { ?><?php echo $title?><?php } ?>" /></li>
		<li><span>起始时间: </span>
			<select name="time" id="time" >
				<option value="">全部起始时间</option>
				<option value="86400"> 一天</option>
				<option value="604800"> 一周</option>
				<option value="2592000"> 一个月</option>
				<option value="7776000"> 三个月</option>
				<option value="15552000"> 半年</option>
				<option value="31536000"> 一年</option>
			</select>
		</li>
		<li><span>广告类型: </span>
			<select name="type" id="type" >
				<option value=""> 全部广告类型</option>
				<option value="0">页头通栏广告</option>
				<option value="1">页尾通栏广告</option>
				<option value="2">首页栏目广告</option>
				<option value="3">词条正文广告</option>
				<option value="4">词条右侧广告</option>
				<option value="5">对联广告</option>
				<option value="6">漂浮广告</option>
			</select>
		</li>
		<li><span>排序方式: </span>
			<select name="orderby" id="orderby" >
				<option value="type"> 广告类型排序</option>
				<option value="starttime"> 起始时间排序</option>
			</select>
		</li>
		<li><input name="searchsubmit" type="submit" value="搜 索" onclick="if(this.form.title.value=='请输入广告标题：'){this.form.title.value=''}window.loacation='admincp.php?action=adv&amp;title='+this.form.title.value+'&amp;starttime='+this.form.time.value+'&amp;type='+this.form.type.value+'&amp;orderby='+this.form.orderby.value;" class="inp_btn"/></li>
	</ul>
</form>
<h3 class="tol_table">[ 共 <b><?php echo $advsum?></b> 个广告 ]</h3>
<form name="formadvlist" id="formadvlist"  method="POST">
	<table class="table w-img">
		<thead>
			<tr>
				<td style="width:50px;">选择</td>
				<td style="width:100px;">可用(点击修改)</td>
				<td style="width:60px;">标题</td>
				<td style="width:70px;">类型</td>
				<td style="width:60px;">样式</td>
				<td style="width:100px;">起始时间</td>
				<td style="width:100px;">终止时间</td>
				<td style="width:100px;">投放范围</td>
				<td>投放范围</td>
			</tr>
		</thead>
		<!-- <?php if($advsum) { ?> -->
		<?php foreach((array)$advlist as $adv) {?>
		<tr>
			<td><input type="checkbox" class="box" name="advid[]" value="<?php echo $adv['advid']?>" /></td>
			<td>
				<a href="javascript:void(0)" onclick="edit_available(<?php echo $adv['advid']?>);">
				<!-- <?php if($adv['available']) { ?> -->
				<span id="available_<?php echo $adv['advid']?>">是</span>
				<!-- <?php } else { ?> -->
				<span id="available_<?php echo $adv['advid']?>">否</span>
				<!-- <?php } ?> -->
				</a>
			</td>
			<td><?php echo $adv['title']?></td>
			<td><?php echo $adv['type']?></td>
			<td><?php echo $adv['parameters']['style']?></td>
			<td><?php echo $adv['starttime']?></td>
			<td><?php echo $adv['endtime']?></td>
			<td><!-- <?php if($adv['targets']!=='') { ?> --><?php echo $adv['targets']?><!-- <?php } else { ?> -->默认投放范围<!-- <?php } ?> --></td>
			<td><a href="index.php?admin_adv-edit-<?php echo $adv['advid']?>" ><font color="#FF0000">详情/编辑</font></a></td>
		</tr>
		<?php } ?>
		<!-- <?php } else { ?> -->
		<tr>
			<td colspan="5">没有任何广告！</td>
		</tr>
		<!-- <?php } ?> -->
		
		<tr>
			<td><input name="checkbox"  type="checkbox" id="chkall" onclick="selectALL(this);"><label id="tip">全选</label></td>
			<td colspan="7"><input type="button" name="casemanage" onClick="deleteadv();" value="删除" class="inp_btn2 m-r10"/></td>
		</tr>
		<tr><td colspan="8"><p class="fenye a-r"><?php echo $departstr?></p></td></tr>
	</table>
</form>
<?php include $this->gettpl('admin_footer');?>
