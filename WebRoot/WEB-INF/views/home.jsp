<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>江苏振邦技术研发平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<btp:htmlbase />
<link rel="shortcut icon" href="favorite.ico" />
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
		<style type="text/css">
html, body {
	height: 100%;
	overflow: hidden;
	background-color: #fff;
}
</style>
		<script type="text/javascript">
$(function(){
	$('#menuList li').click(function(){
		if($(this).attr('url')!=undefined){
			$('#iframe').attr('src',$(this).attr('url'));
			$(this).addClass('selected');
		}
	});
});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false">
		<div class="index_header">
			<div class="topMenuList">
				<ul id="menuList">
					<li url="workbench.html"><a href="javascript:;" class="">
							<img src="images/icons/app_mid_home.png" /> <span>首页</span>
					</a></li>
					<li url="msg.html"><a href="javascript:;" class=""> <img
							src="images/icons/app_mid_2.png" /> <span>信息管理</span>
					</a></li>
					<li url="左右结构.html"><a href="javascript:;" class=""> <img
							src="images/icons/app_mid_3.png" /> <span>左右结构</span>
					</a></li>
					<li><a href="javascript:;" class=""> <img
							src="images/icons/app_mid_4.png" /> <span>功能3</span>
					</a></li>
					<li><a href="javascript:;" class=""> <img
							src="images/icons/app_mid_5.png" /> <span>功能4</span>
					</a></li>
					<li><a href="javascript:;" class=""> <img
							src="images/icons/app_mid_6.png" /> <span>功能5</span>
					</a></li>
					<li url="sys-permission.html"><a href="javascript:;" class="">
							<img src="images/icons/modules/key.png" /> <span>授权管理</span>
					</a></li>
					<li><a href="javascript:void(0);" class=""> <img
							src="images/icons/modules/setting.png" /> <span>系统管理</span>
					</a></li>
				</ul>
			</div>
			<div class="user_toolbar">
				<a href="login.html" class="logout">退出</a> <a href="#"
					class="setting">设置</a> <a href="#" class="pwd">密码</a>
			</div>
			<div class="index_logo"></div>
		</div>
	</div>
	<div data-options="region:'center'">
		<iframe id="iframe" src="workbench.html" name="" class="iframeApp"
			frameborder="0" SCROLLING="auto" marginwidth="0" marginheight="0"
			style="width: 100%; height: 100%;"></iframe>
	</div>
	<div data-options="region:'south',border:false">
		<div class="bottom_bar">江苏振邦基础应用平台欢迎你</div>
	</div>
</body>
</html>
