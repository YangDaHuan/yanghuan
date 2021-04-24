<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>系统登录-江苏振邦区域医疗平台</title>
	<link rel="shortcut icon" href="favorite.ico" />
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="css/login.css" />
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
		<script type="text/javascript">
jQuery.fn.shake = function (setting){
	var so=jQuery(this);
    var style = so[0].style,
        p = [4, 8, 4, 0, -4, -8, -4, 0],
        fx = function () {
            style.marginLeft = p.shift() + 'px';
            if (p.length <= 0) {
                style.marginLeft = 0;
                clearInterval(timerId);
            };
        };
    p = p.concat(p.concat(p));
    timerId = setInterval(fx, 13);
    return this;
};
function tip(msg){
	$.messager.show({
		title:'提示',
		msg:msg,
		showType:'slide',
		style:{
			right:'',
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		},
		closable:false
	});
}
var ie=navigator.appName=="Microsoft Internet Explorer"?true:false;
var tipBg=function(){
	if($.trim($("#username").val())==''){
		$('#usernameTip').show();
	}else{
		$('#usernameTip').hide();;
	}
	if($.trim($("#password").val())==''){
		$('#pwdTip').show();
	}else{
		$('#pwdTip').hide();
	}
}
var loginStart=function(){
	$('#loginState').show();
	$('#loginBtn').hide();
}
var loginEnd=function(){
	$('#loginState').hide();
	$('#loginBtn').show();
}
var loginStart=function(){
	$('#loginState').show();
	$('#loginBtn').hide();
}
var loginEnd=function(){
	$('#loginState').hide();
	$('#loginBtn').show();
}
var loginAjax=function(){
	var username = $.trim($("#username").val());
	var password = $.trim($("#password").val());
	if(username==''){ tip('用户名不能为空');$('#login-box').shake();return;}
	if(password==''){ tip('密码名不能为空');$('#login-box').shake();return;}
	var datas = "username="+username+"&password="+password;
	loginStart();
	$.ajax({
		url: 'login.zb',
		type: 'POST',
		data: encodeURI(datas),
		cache: false,
		dataType: 'json',
		success: function(data){
	 		if(data.success){
 				var url='home.zb';
	 			if(ie){
	 				try{
	 					var win=window.open(url+"?tmpOrganId="+tmpOrganId,"",'alwaysRaised=yes,width='+ (screen.availWidth - 5) +',height='+ (screen.availHeight-30) +',location=no,menubar=no,resizable=yes,status=no,scrollbars=no,toolbar=no,title=no,center=yes');
	 					if(win){
	 						top.window.opener=null;
							top.window.open('','_self');
							top.window.close(); 
	 					}
	 				}catch(e){
	 					window.top.location=url;
	 				}
	 			}else{
	 				window.top.location=url;
	 			}
	 		}else{
	 			loginEnd();
	 			$('#login-box').shake();
	 			JDialog.tip(data.msg);
	 		}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			loginEnd();
			JDialog.tip('服务器出现异常，用户登录失败。');
		}
	});
}

$(function(){
	$('#username').focus();
	$('#username').click(function(){
		$('#usernameTip').hide();
	}).keydown(function(){
		$('#usernameTip').hide();
	}).blur(function(){
		tipBg();
	});
	$('#password').click(function(){
		$('#pwdTip').hide();
	}).keydown(function(){
		$('#pwdTip').hide();
	}).blur(function(){
		tipBg();
	});
	$('#loginBtn').click(function(){
		loginAjax();
	});
	$('#password').bind('keydown', function(event){
	   if (event.keyCode=="13"){
	    loginAjax();
	   }
	});
	tipBg();
});
</script>
		<!--[if IE 6]>
<script type="text/javascript" src="js/ie6/DD_belatedPNG_0.0.8a-min.js" ></script>
<script type="text/javascript">
 DD_belatedPNG.fix('DIV');
 DD_belatedPNG.fix('A');
 DD_belatedPNG.fix('SPAN');
 DD_belatedPNG.fix('INPUT');
</script>
<![endif]-->
</head>
<body>
	<div class="login_bg_div">
		<img src="images/login/login_bg.png" class="login_bg_img" />
	</div>
	<div class="login_box_outer">
		<div id="login-box" class="login_box">
			<div class="login_box_inner">
				<div class="username_bg"></div>
				<div class="password_bg"></div>
				<div id="usernameTip">用户名</div>
				<div id="pwdTip">密&nbsp;&nbsp;码</div>
				<input type="text" id="username" name="username" class="username"
					value="" /> <input type="password" id="password" name="password"
					class="password" value="" /> <a id="loginBtn"> <span></span>
				</a> <a id="loginState"> <span></span>
				</a>
			</div>
		</div>
		<div class="logo"></div>
	</div>
	<div id="copyright">
		<span> 江苏振邦智慧城市信息系统有限公司<br /> Copyright © 2013- All Rights
			Reserved
		</span>
	</div>
</body>
</html>