<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<style type="text/css">
.page_wrap { margin-left: -15px; }
.head_title { line-height: 30px; padding-top: 2px; margin-bottom: 20px; border-bottom: solid 1px #CCC; }
ul li { line-height: 24px; border-bottom: 1px solid #EEE; padding: 0 2px; position: relative; }
ul span { position: absolute; right: 0; top: 0; }
</style>
<!--[if lte IE 6]>
<style type="text/css">.page_wrap { margin-left: -7px; }</style>
<![endif]-->
<div class="page_wrap">

<?php if(!empty($packages) && count($packages) > 0 ) { ?>
<div class="head_title">待安装的升级包：（建议在升级前 <a href="index.php?admin_setting-seo" target="_parent">关闭 Rewrite 支持</a>，并在 <a href="index.php?admin_setting-base" target="_parent">站点设置</a> 中暂时关闭网站。）</div>
<ul>
<?php foreach((array)$packages as $name=>$info) {?>
<li style = "color: orange"><?php echo $name?><span><?php echo $info['info']?></span></li>
<?php }?>
</ul>

<script type="text/javascript">
$(window.parent.document.getElementById('install_form')).attr('action', 'index.php?admin_upgrade-install');
$(window.parent.document.getElementById('next_button')).attr({disabled: false});
</script>
<?php } else { ?>
<div style="text-align: center; padding-top: 100px; line-height: 28px">HDwiki 已经是最新版。<br />V<?php echo HDWIKI_VERSION?> release <?php echo HDWIKI_RELEASE?></div>
<script type="text/javascript">
$(window.parent.document.getElementById('next_button')).attr({disabled: true});
</script>
<?php } ?>

<script type="text/javascript">
$(window.parent.document.getElementById('next_button')).text('开始安装');
</script>
</div>
<?php include $this->gettpl('admin_footer');?>