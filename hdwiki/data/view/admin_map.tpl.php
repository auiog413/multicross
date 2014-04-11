<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<div class="right sy">
	<h2 class="col-h4">后台菜单地图列表</h2>
	<div class="t_map" >
		<ul class="col-ul">
		<?php echo $map?>
		</ul>
	</div>
</div>
<?php include $this->gettpl('admin_footer');?>