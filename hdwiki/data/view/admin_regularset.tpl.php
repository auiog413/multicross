<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript">
var Regular = {
	id: null,
	groupid:0,
	groupidlist:[],
	data : {
	'0':'未分组权限'
	<?php foreach((array)$regulargrouplist as $regulargroup) {?>
	,'<?php echo $regulargroup['id']?>':'<?php echo $regulargroup['title']?>'
	<?php } ?>
	},
	regulars:"<?php echo $regulars?>",
	
	makeChecked: function(){
		if ('' == this.regulars) return;
		var regulars = this.regulars.split('|');
		for (i in regulars){
			$(":checkbox[value='"+regulars[i]+"']").attr('checked', true);
		}
	},
	
	makeTab: function(){
		var html='', data = Regular.data;
		this.groupidlist = [];
		for(i in data){
			this.groupidlist.push(i);
			if (i != '0'){
				html += '<a name="a'+i+'" onclick="Regular.filter('+i+')" href="javascript:;" class="regulargroup">'+'<span>'+data[i]+'</span>'+'</a> ';
			}
		}
		
		$('#regulargrouptab').html(html);
	},
	
	filter: function(groupid){
		this.groupid = groupid;
		$(".grouplist").hide().filter('[name=group'+groupid+']').show();
		$('#selectRegularGroup').hide();
		$('a.on').removeClass('on');
		$('a[name=a'+groupid+']').addClass('on');
		$("#selectall").attr("checked",false);
	},
	
	setWidth: function(){
		var width = $(document).width();
		var grouplist, data = Regular.data;
		for(i in data){
			grouplist = $(".grouplist[name=group"+i+"]");
			if (grouplist.size() > 18){
				grouplist.each(function(i, n){
					if (i % 2 == 1){
						if (width>1024){
							$(n).css('width','65%');
						}else if(width<800){
							$(n).css('width','40%');
						}else{
							$(n).css('width','55%');
						}
					}else{
						if (width>1024){
							$(n).css('width','20%')
						}else if(width<800){
							$(n).css('width','40%');
						}else{
							$(n).css('width','30%');
						}
					}
				});
			}
		}
	},
	
	selectAll: function(E){
		$("span[name=group"+this.groupid+"]").find(':checkbox').attr('checked', E.checked);
	},
	
	click: function(E){
		var action,id = $(E).attr('id').replace('regular','');
		action = ($(E).attr('checked'))?'right':'left';
		var url = 'index.php?admin_regular-getrelation-'+id+'-'+action;
		$.get(url, function(data, state){
			data = $.trim(data);
			if ('' != data && 'OK' == data.substr(0,2)){
				var idlist = data.substr(2).split('|');
				var idrightlist = idlist[0].split(',');
				var idleftlist = idlist[1].split(',');
				
				for(i in idleftlist){
					$('#regular'+idleftlist[i]).attr('checked',false);
				}
				
				for(i in idrightlist){
					$('#regular'+idrightlist[i]).attr('checked',true);
				}
			}
		});
	}
}

$(document).ready(function(){
	$('#regulargrouptab').html(Regular.makeTab("selectTab"));
	
	var groupid = Regular.groupidlist[1];
	Regular.filter(groupid);

	setTimeout('timer()', 100);
});

function timer(){
	Regular.setWidth();
}
</script>
<p class="map">用户管理：管理权限</p>
<p class="sec_nav">管理权限：
	<?php if($ISOFFICIAL) { ?>
	<a href="index.php?admin_regular-list"> <span>管理权限</span></a> <a href="index.php?admin_regular-grouplist"><span>权限分类</span></a>
	<?php } ?>
	<a href="index.php?admin_regular-groupset-<?php echo $groupid?>"  class="on"   > <span>管理权限</span></a> <a href="index.php?admin_regular"><span>权限列表</span></a> </p>
<h3 class="col-h3">管理权限</h3>
<table class="table regular">
	<tr>
		<td width="160" height="40"><img src="style/default/admin/usergroupset.gif"/></td>
		<td><span id="regulargrouptab" class="sec_nav">Loading....</span></td>
	</tr>
	<tr>
		<td valign="top"><table class="table">
				<?php foreach((array)$usergrouplist as $usergroup) {?>
				<tr>
					<td height="30" class="usergroup <?php if($groupid==$usergroup['groupid']) { ?>selected<?php } ?>"><a value="<?php echo $usergroup['groupid']?>" 
				href="index.php?admin_regular-groupset-<?php echo $usergroup['groupid']?>"
				><?php echo $usergroup['grouptitle']?></a></td>
				</tr>
				<?php } ?>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table></td>
		<td  valign="top"><form name="regularform" id="regularform" action="index.php?admin_usergroup-edit-<?php echo $groupid?>"  method="post">
				<table class="table" style="width:100%;">
					<tr>
						<td><?php foreach((array)$regularlist as $regular) {?>
							<span id="tr<?php echo $regular['id']?>" class="grouplist" name="group<?php echo $regular['regulargroupid']?>">
							<label><input type="checkbox" name="regular[]" id="regular<?php echo $regular['id']?>" onclick="Regular.click(this)"
		  value="<?php if($regular['regular'] == 'list-default|list-recentupdate') { ?>list-default|list-recentchange<?php } else { ?><?php echo $regular['regular']?><?php } ?>"
								<?php if($regular['checked']) { ?>
								checked="true"
								<?php } ?>
								>
								<?php echo $regular['name']?></label>
							</span>
							<?php } ?></td>
					</tr>
					<tr>
						<td><label>
								<input id="selectall" type="checkbox" onclick="Regular.selectAll(this)">
								<b>全选</b></label></td>
					</tr>
					<tr>
						<td><input name="submit" class="inp_btn m-r10" type="submit" value="提 交">
							<input name="default" type="submit" class="inp_btn m-r10" value="恢复默认"></td>
					</tr>
				</table>
			</form></td>
	</tr>
</table>
<?php include $this->gettpl('admin_footer');?>