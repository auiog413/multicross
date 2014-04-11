<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<script type="text/javascript" src="js/pickcolor.js"></script>
<script type="text/javascript">
var MEMBER_I = 0, SPECIAL_I = 0, old_value, old_input;

function docheck(){
	var value ,creditslower;
	creditslower = $("input[name*='creditslower']:visible");
	if (creditslower.length > 1){
		value = creditslower.val(); //first value
		value = parseInt(value);
		
		if (value >=0){
			alert('注意：第一个用户组的起始经验必须小于0！');
			$("input[name*='creditslower']:first").val(-999999).focus();
			return false;
		}
			
		for (key in creditslower){
			value = parseInt(creditslower[key].value);
			if (value > 999999000){
				alert('注意：用户组的起始最大经验必须小于'+999999000);
				$(creditslower[key]).val(999999000).focus();
				return false;
			}
		}
		
		if(!dochecktitle()){
			return false;
		}
		
		
	}else {
		alert('注意：至少设置两个用户组！');
		return false;
	}
}

function dochecktitle(){
	var temp=[], temp2=[], groupnames=[], grouptitle=$("input[name*='grouptitle']:visible");
	grouptitle.each(function(i){
		this.value=$.trim(this.value);
		if(!this.value) return;
		if(!temp[this.value]){
			groupnames.push(this.value);
		}else{
			temp2.push(this.value);
		}
		temp[this.value]=this;
	});
	if(temp2.length>0){
		alert("组名称["+temp2.join(",")+"]存在重复！");
		return false;
	}
	
	for(var i in temp){
		creditslower=$(temp[i]).parents('tr').find('input[name*=creditslower]');
		if(creditslower.size()){
			if(!creditslower.val() || !/^-?\d+$/.test(creditslower.val()) ) {
				alert('经验值不能为空，并且必须是一个整数。');
				creditslower.focus();
				return false;
			}
		}
		
		stars=$(temp[i]).parents('tr').find('input[name*=stars]');
		if(stars.size()){
			if(stars.val() && !/^\d+$/.test(stars.val()) ) {
				alert('星星数必须是一个大于等于0的整数。');
				stars.focus();
				return false;
			}
		}
		
	}
	return true;
}

function disabled_submit(){
	$(":submit").removeClass('btn').attr('disabled',true);
}

function ok_submit(){
	$(":submit").addClass('btn').attr('disabled',false);
}

function on_focus(E){
	old_input = E;
	old_value = E.value;
	if (E.value !== ''){
		disabled_submit();
	}
}

function isNumber(E){
	var value = $.trim(E.value);
	var re = /^-?\d{1,9}$/;
	
	if (value == ''){
		if (old_value !== '' && re.test(old_value)){
			$(E).val(old_value);
		}
	}else {
		if (!re.test(value)){//error
			$(E).val(old_value);
			return false;
		}
	}
	ok_submit();
}

function isColor(E){
	var value = $.trim(E.value);
	var re = /^(#[0-9a-z]{2,6})$|^([a-z]{3,7})$/i;
	
	if (value == ''){
		if (old_value !== '' && re.test(old_value)){
			//$(E).val(old_value);
		}
	}else {
		if (!re.test(value)){//error
			$(E).val(old_value);
			return false;
		}
	}
	ok_submit();
}

function addUserGroup(tab){
	var html = $("#tr_"+ tab +"Template").html();
	
	switch(tab){
		case 'usergroupMember':
		html = html.replace(/MEMBER_I/g, MEMBER_I);
		MEMBER_I ++;
		break;
		case 'usergroupSpecial':
		html = html.replace(/SPECIAL_I/g, SPECIAL_I);
		SPECIAL_I ++;
		break;
	}
	html = "<tr>"+html+"</tr>";
	$("#tr_"+ tab +"Add").before(html);
	PickColor.hide();
}

function changeTab(tab, E){
	var usergroupTitle='';
	if(tab=='usergroupMember'){ usergroupTitle="组头衔";}
	if(tab=='usergroupSystem'){ usergroupTitle="系统用户组";}
	if(tab=='usergroupSpecial'){ usergroupTitle="特殊用户组";}
	$(".sec_nav a").removeClass('on');
	$(E).addClass('on');
	
	$('form:visible').hide();
	$("form[name="+ tab +"]").show();
	
	$('#current').attr('id', '');
	$(E).attr('id', 'current');
	PickColor.hide();
	$("#usergroupTitle").html(usergroupTitle);
}

$(document).ready(function(){
	$("input[name*='creditslower'],input[name*='stars']").focus(function(){
		on_focus(this);
	}).blur(function(){
		isNumber(this);
	});
	
	$("input[name*='color']").focus(function(){
		on_focus(this);
	}).blur(function(){
		isColor(this);
	});
	
	$("tr.submit").mousemove(function(){
		if (old_input == null) return false;
		if ($(old_input).attr('name').indexOf('color') > -1){
			isColor(old_input);
		} else {
			isNumber(old_input);
		}
	});
	
	$("p.sec_nav a.on").removeClass("on");
	$("#current").addClass("on");
});
</script>
<p class="map">用户管理：管理用户组</p>
<p class="sec_nav">管理用户组： 
	<a href="javascript:void(0);" onclick="changeTab('usergroupMember', this)" class="on" id="<?php echo $usergroupMember?>"  > <span>会员用户组</span></a> 
	<a href="javascript:void(0);" onclick="changeTab('usergroupSystem', this)" id="<?php echo $usergroupSystem?>"  ><span>系统用户组</span></a> 
	<a href="javascript:void(0);"onclick="changeTab('usergroupSpecial', this)" id="<?php echo $usergroupSpecial?>" ><span>特殊用户组</span></a></p>

<h3 class="col-h3" id="usergroupTitle">会员用户组</h3>
<ul class="col-ul tips">
	<li class="bold">提示: </li>
	<li>HDWiki用户组分为系统组、特殊组和会员组，会员组以经验确定组别和权限，而系统组和特殊组是人为设定，不会由百科系统自行改变。</li>
	<li>系统组和特殊组的设定不需要指定经验，HDWiki预留了从超级管理员到游客等 13 个系统头衔，特殊组的用户需要在编辑会员时将其加入。</li>
	<li>会员用户组至少分为两组，其经验下限分别为负值(任一负数)和 0，否则将导致部分用户无法与用户组匹配的问题。</li>
	<li class="red">打勾后的用户组将被删除，已经有用户的用户组和系统用户组不能被删除。</li> 
</ul>
	
<form name="usergroupMember"  action="index.php?admin_usergroup-change"  method="post" onsubmit="return docheck();" style="display:<?php echo $displayMember?>">
	<table  class="table">
    <tr>
	    <td style="width:30px;">&nbsp;</td>
	    <td style="width:120px;">组头衔</td>
	    <td style="width:240px;">经验介于</td>
	    <td style="width:80px;">星星数</td>
	    <td style="width:180px;">头衔颜色</td>
	    <td style="width:80px;display:none;">组头像</td>
	    <td></td>
    </tr>
<?php foreach((array)$usergroupMemberList as $usergroup) {?>
  <tr>
    <td>
	<input name="usergroup[<?php echo $usergroup['groupid']?>][groupid]" type="hidden" value="<?php echo $usergroup['groupid']?>">
	<input name="deleteids[]" type="checkbox" value="<?php echo $usergroup['groupid']?>" title="打勾后将删除此组" <?php if(!$usergroup['empty'] ) { ?>disabled<?php } ?>>
	</td>
    <td><input name="usergroup[<?php echo $usergroup['groupid']?>][grouptitle]" value="<?php echo $usergroup['grouptitle']?>" class="inp_txt w-60"  maxlength="30"/></td>
    <td>
	<input name="usergroup[<?php echo $usergroup['groupid']?>][creditslower]" value="<?php echo $usergroup['creditslower']?>" class="inp_txt w-60"  maxlength="10"/> ~ 
	<input name="usergroup[<?php echo $usergroup['groupid']?>][creditshigher]" value="<?php echo $usergroup['creditshigher']?>" class="inp_txt w-60" readonly="true"/>
	</td>
    <td><input name="usergroup[<?php echo $usergroup['groupid']?>][stars]" value="<?php echo $usergroup['stars']?>" class="inp_txt w-60"  maxlength="2"/></td>
	<td><input name="usergroup[<?php echo $usergroup['groupid']?>][color]" value="<?php echo $usergroup['color']?>" class="inp_txt w-60"  maxlength="7" 
		onclick="PickColor.init(this)" onkeyup="PickColor.keyup(this.value)" onchange="PickColor.change(this.value)"/>
	<input type="button" onclick="PickColor.init(this)" style="background-color:<?php echo $usergroup['color']?>" class="choose_c"/></td>
	<td style="display:none"><input name="usergroup[<?php echo $usergroup['groupid']?>][groupavatar]" class="inp_txt w-60" value="<?php echo $usergroup['groupavatar']?>" size="20" maxlength="60"/></td>
	<td><?php if($usergroup['groupid']!=4 ) { ?><a href="index.php?admin_regular-groupset-<?php echo $usergroup['groupid']?>">[编辑]</a><?php } ?></td>
  </tr>
<?php } ?>
    <tr id="tr_usergroupMemberAdd">
	    <td></td>
	    <td><a href="javascript:void(0);" onclick="addUserGroup('usergroupMember')">[+]添加新用户组</a></td>
	    <td></td>
	    <td></td>
	    <td></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
    <tr class="submit">
	    <td width="50"></td>
	    <td><input type="submit" class="inp_btn" value="提 交"/>
		<input type="hidden" name="usergroupType" value="usergroupMember" />
		</td>
	    <td></td>
	    <td></td>
	    <td></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
    <tr id="tr_usergroupMemberTemplate" style="display:none">
	    <td width="50"></td>
	    <td><input name="usergroupadd[MEMBER_I][grouptitle]" value="" class="inp_txt w-60" maxlength="30"/></td>
	    <td><input   name="usergroupadd[MEMBER_I][creditslower]" value="" class="inp_txt w-60" maxlength="7"/></td>
	    <td><input   name="usergroupadd[MEMBER_I][stars]" value="" class="inp_txt w-60" maxlength="2"/></td>
	    <td>
		<select name="usergroupadd[MEMBER_I][projectid]">
		<option value="0">用户组设置参照</option>
		<option value="0">------------</option>
		<?php foreach((array)$usergroupMemberList as $usergroup) {?>
		<option value="<?php echo $usergroup['groupid']?>"><?php echo $usergroup['grouptitle']?></option>
		<?php } ?>
		<option value="0">------------</option>
		</select></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
</table>
</form>


<form name="usergroupSystem"  action="index.php?admin_usergroup-change"  method="post" style="display:<?php echo $displaySystem?>" onsubmit="return dochecktitle()">
	<table class="table">
    <tr>
	    <td style="width:30px;"></td>
	    <td style="width:120px;">组头衔</td>
	    <td style="width:120px;">星星数</td>
	    <td style="width:150px;">头衔颜色</td>
	    <td style="display:none">组头像</td>
	    <td></td>
    </tr>
<?php foreach((array)$usergroupSystemList as $usergroup) {?>
  <tr>
    <td><input name="usergroup[<?php echo $usergroup['groupid']?>][groupid]" type="hidden" value="<?php echo $usergroup['groupid']?>">
	<input name="deleteids[]" type="checkbox" value="<?php echo $usergroup['groupid']?>" style="display:none"></td>
    <td><input name="usergroup[<?php echo $usergroup['groupid']?>][grouptitle]" value="<?php echo $usergroup['grouptitle']?>" class="inp_txt w-60" maxlength="30"/></td>
    <td><input   name="usergroup[<?php echo $usergroup['groupid']?>][stars]" value="<?php echo $usergroup['stars']?>" class="inp_txt w-60" maxlength="2"/></td>
	<td><input   name="usergroup[<?php echo $usergroup['groupid']?>][color]" value="<?php echo $usergroup['color']?>" class="inp_txt w-60" maxlength="7" 
	onclick="PickColor.init(this)" onkeyup="PickColor.keyup(this.value)" onchange="PickColor.change(this.value)"/>
	<input type="button" onclick="PickColor.init(this)" style="background-color:<?php echo $usergroup['color']?>" class="choose_c"/></td>
	<td style="display:none"><input name="usergroup[<?php echo $usergroup['groupid']?>][groupavatar]" value="<?php echo $usergroup['groupavatar']?>" class="inp_txt w-60" maxlength="60"/></td>
	<td><?php if($usergroup['groupid']!=4 ) { ?><a href="index.php?admin_regular-groupset-<?php echo $usergroup['groupid']?>">[编辑]</a><?php } ?></td>
  </tr>
<?php } ?>
    <tr class="submit">
	    <td></td>
	    <td><input type="submit" class="inp_btn" value="提 交">
		<input type="hidden" name="usergroupType" value="usergroupSystem" />
		</td>
	    <td></td>
	    <td></td>
	    <td></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
</table>
</form>

<form name="usergroupSpecial"  action="index.php?admin_usergroup-change"  method="post" style="display:<?php echo $displaySpecial?>" onsubmit="return dochecktitle()">
	<table class="table">
    <tr>
	    <td style="width:30px;"></td>
	    <td style="width:120px;">组头衔</td>
	    <td style="width:120px;">星星数</td>
	    <td style="width:150px;">头衔颜色</td>
	    <td style="display:none">组头像</td>
	    <td></td>
    </tr>
<?php foreach((array)$usergroupSpecialList as $usergroup) {?>
  <tr>
    <td>
	<input name="usergroup[<?php echo $usergroup['groupid']?>][groupid]" type="hidden" value="<?php echo $usergroup['groupid']?>">
	<input name="deleteids[]" type="checkbox" value="<?php echo $usergroup['groupid']?>" <?php if(!$usergroup['empty'] ) { ?>disabled<?php } ?>></td>
    <td><input name="usergroup[<?php echo $usergroup['groupid']?>][grouptitle]" value="<?php echo $usergroup['grouptitle']?>" class="inp_txt w-60" maxlength="30"/></td>
    <td><input   name="usergroup[<?php echo $usergroup['groupid']?>][stars]" value="<?php echo $usergroup['stars']?>" class="inp_txt w-60"  maxlength="2"/></td>
	<td><input   name="usergroup[<?php echo $usergroup['groupid']?>][color]" value="<?php echo $usergroup['color']?>" class="inp_txt w-60" maxlength="7" onclick="PickColor.init(this)" onkeyup="PickColor.keyup(this.value)" onchange="PickColor.change(this.value)"/>
	<input type="button" onclick="PickColor.init(this)" style="background-color:<?php echo $usergroup['color']?>" class="choose_c"/></td>
	<td style="display:none"><input name="usergroup[<?php echo $usergroup['groupid']?>][groupavatar]" value="<?php echo $usergroup['groupavatar']?>" class="inp_txt w-60" maxlength="60"/></td>
	<td><?php if($usergroup['groupid']!=4 ) { ?><a href="index.php?admin_regular-groupset-<?php echo $usergroup['groupid']?>">[编辑]</a><?php } ?></td>
  </tr>
<?php } ?>
    <tr id="tr_usergroupSpecialAdd">
	    <td width="50"></td>
	    <td><a href="javascript:void(0);" onclick="addUserGroup('usergroupSpecial')">[+] 添加新特殊用户组</a></td>
	    <td></td>
	    <td></td>
	    <td></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
    <tr class="submit">
	    <td width="50"></td>
	    <td><input type="submit" class="inp_btn" value="提 交">
		<input type="hidden" name="usergroupType" value="usergroupSpecial" />
		</td>
	    <td></td>
	    <td></td>
	    <td style="display:none"></td>
	    <td></td>
    </tr>
    <tr id="tr_usergroupSpecialTemplate" style="display:none">
	    <td width="50"></td>
	    <td><input name="usergroupadd[SPECIAL_I][grouptitle]" value="" class="inp_txt w-60" maxlength="30"/></td>
	    <td><input name="usergroupadd[SPECIAL_I][stars]" value="" class="inp_txt w-60" maxlength="2"/></td>
	    <td><input name="usergroupadd[SPECIAL_I][color]" value="" class="inp_txt w-60" maxlength="7"/></td>
	    <td>
		<select name="usergroupadd[SPECIAL_I][projectid]">
		<option value="0">用户组设置参照</option>
		<option value="0">------------</option>
		<?php foreach((array)$usergroupSpecialList as $usergroup) {?>
		<option value="<?php echo $usergroup['groupid']?>"><?php echo $usergroup['grouptitle']?></option>
		<?php } ?>
		<option value="0">------------</option>
		</select></td>
	    <td style="display:none"></td>
    </tr>
</table>
</form>

<?php include $this->gettpl('admin_footer');?>