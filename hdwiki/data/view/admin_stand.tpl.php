<?php if(!defined('HDWIKI_ROOT')) exit('Access Denied');?>
<?php include $this->gettpl('admin_header');?>
<p class="map">站内统计：基本概况</p>
<h3 class="col-h4 m-t10">会员统计</h3>
<table class="table">
	<tr>
		<td style="width:200px;">注册会员: <?php echo $stand['register']?></td>
		<td>贡献会员: <?php echo $stand['edit_user']?></td>
	</tr>
	<tr>
		<td>管理成员: <?php echo $stand['manage_user']?></td>
		<td>未贡献会员: <?php echo $stand['unedit_user']?></td>
	</tr>
	<tr>
		<td>新会员: <a href="<?php echo $setting['seo_prefix']?>user-space-<?php echo $stand['new_user'][uid]?><?php echo $setting['seo_suffix']?>" target="_blank"><?php echo $stand['new_user']['username']?></a></td>
		<td>贡献会员占总数: <?php echo $stand['edit_user_percent']?></td>
	</tr>
	<tr>
		<td>今日百科之星: <a href="<?php echo $setting['seo_prefix']?>user-space-<?php echo $stand['star_today'][authorid]?><?php echo $setting['seo_suffix']?>" target="_blank"><?php echo $stand['star_today']['author']?></a></td>
		<td>平均每人贡献数: <?php echo $stand['average_edition']?></td>
	</tr>
</table>
<h3 class="col-h4 m-t10">百科统计</h3>
<table class="table">
	<tr>
		<td style="width:200px;">分类数: <?php echo $stand['category_num']?></td>
		<td style="width:200px;">平均每日新增词条数: <?php echo $stand['average_day_doc']?></td>
		<td>最热门的分类: <a href="<?php echo $setting['seo_prefix']?>category-view-<?php echo $stand['hot_category'][cid]?><?php echo $setting['seo_suffix']?>" target="_blank" ><?php echo $stand['hot_category']['name']?></a></td>
	</tr>
	<tr>
		<td>创建词条总数: <?php echo $stand['create_doc_num']?></td>
		<td>平均每日注册会员数: <?php echo $stand['average_day_user']?></td>
		<td>词条评论数: <?php echo $stand['doc_comment_num']?></td>
	</tr>
	<tr>
		<td>词条版本总数: <?php echo $stand['edition_num']?></td>
		<td>最近 24 小时新增词条数: <?php echo $stand['day_recent_doc']?></td>
		<td>每个词条平均版本数: <?php echo $stand['average_doc_edition']?></td>
	</tr>
	<tr>
		<td>最近 24 小时新增会员数: <?php echo $stand['day_recent_user']?></td>
		<td>百科活跃度: <?php echo $stand['activity_index']?></td>
		<td>UV/PV: <?php if(isset($count)) { ?> <?php echo $count[0]?>/<?php echo $count[1]?><?php } else { ?>暂无<?php } ?></td>
	</tr>
</table>
<table class="table">
  <tr>
    <td>统计数据已被缓存，上次于 <?php echo $stand['last_cache_time']?> 被更新，下次将于 <?php echo $stand['cache_time']?> 进行更新。</td>
  </tr>
</table>
<?php include $this->gettpl('admin_footer');?>