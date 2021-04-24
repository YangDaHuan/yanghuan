<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>江苏振邦技术研发平台</title>
<jsp:include page="common.jsp" />
<link rel="shortcut icon" href="favorite.ico" />
<link rel="stylesheet" type="text/css" href="css/index.css" />
<style type="text/css">
.panel-header, .panel-body {
	border-color: #E0E5E8;
}
</style>
<script type="text/javascript">
//个人设置
var psnSetting=function(){
	$("#psnDlg").dialog("open");
	$("#psnForm").form("reset");
	var url = "user/getCurrentUser.zb";
	$("#psnForm").form("load",url);
	
}
//密码设置
var pwdSetting=function(){
	$("#pwdDlg").dialog("open");
	$("#pwdForm").form("reset");
}
/**
* 下拉菜单
*/
var dropDownMenu=function(){
	$(".topmenu li").each(function(){
		if($(this).find("li").length==0){
			$(this).find(".menu-sublist").remove();
		}
	});
	$(".topmenu li").hover(
		function () {
			$(this).find(".menu-sublist").slideDown(100);
		},
		function () {
			$(this).find(".menu-sublist").slideUp(100);
		}
	); 
}
	$(function(){
	    //标签页切换
		$(".tabs-nav li a").click(function(){
			$(".tabs-nav li").removeClass("active");
			$(this).parent().addClass("active");
			var id=$(this).parent().attr("id");
			var url=$(this).attr('href');
			if(url){
				$('.tab-body-child').hide();
				if($("#"+id+"-main").length==0){
					var iframe='<iframe src="'+url+'" frameborder="0" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" style="width:100%;height:100%;"></iframe>';
					$('#tab-body').append("<div id='"+id+"-main' class='tab-body-child'>"+iframe+"</div>");
				}	
				$("#"+id+"-main").show();
			}
			return false;
		});
		dropDownMenu();
	});
	
	/**
	 * 打开子模块
	 */
	function openModule(id){
		var targetUrl = "subModule.zb?parentId="+id;
		$("#iframe").attr("src",targetUrl);	
	}
	
	function logout(){
		$.messager.confirm("提示", "您确认要退出系统吗?", function(r){
			if (!r){
				return;
			}
			//window.location = "logout.zb";
			$.post("logout.zb",{},function(res){
				window.location = "login.zb";
			},"json");
		});
	}
	
	/**
	 * 保存用户信息
	 */
	function savePsn(){
		$("#psnForm").form("submit",{
			//提交前验证
			onSubmit:function(){
				$.messager.progress({
					title:"提示",
					text:"数据处理中，请稍后...."
				});	
				var isValid = $(this).form("validate");
				if (!isValid) {
					$.messager.progress("close");
				}
				return isValid;
			},
			//提交成功
			success:function(result){
				result = $.parseJSON(result);
				$.messager.progress("close");
				if(result.success){//操作成功					
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
					$("#psnDlg").dialog("close");
					var fullname = $("input[name=fullname]").val();
					$("#fullname").html(fullname);
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
var savePwd = function(){
	var password = $("#password").val();
	var password2 = $("#password2").val();
	if(password!=password2){
		$.messager.alert("提示","新密码与确认密码不一致！","info");
	}
		var url = "user/savePwd.zb";
		var $form = $("#pwdForm");
		var $dialog = $("#pwdDlg");
		$form.form("submit",{
			url: url,
			//提交前验证
			onSubmit:function(){
				$.messager.progress({
					title:"提示",
					text:"数据处理中，请稍后...."
				});	
				var isValid = $(this).form("validate");
				if (!isValid) {
					$.messager.progress("close");
				}
				return isValid;
			},
			//提交成功
			success:function(result){
				result = $.parseJSON(result);
				$.messager.progress("close");
				if(result.success){//操作成功
					$form.form("reset");
					$dialog.dialog("close");
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误",result.msg,"error");
				}
			}
		});
	}
</script>
</head>
<body class="easyui-layout">
	<!-- 用户工具栏 -->
	<div id="umenu">
		<span class="noborder"></span> <span>2013年2月28日 星期四</span> <span
			class="pipe">|</span> <span id="fullname">${userDetails.fullname}</span>
		<span class="pipe">|</span>
		<ul class="topmenu">
			<li><a href="javascript:void(0);">设置</a>
				<ul class="menu-sublist" style="display: none;">
					<li><a href="javascript:psnSetting();">个人设置</a></li>
					<li><a href="javascript:pwdSetting();">密码设置</a></li>
				</ul></li>
		</ul>

		<span class="pipe">|</span> <a href="javascript:logout()">退出</a>
	</div>
	<div class="index_logo"></div>
	<div data-options="region:'north',border:false">
		<div class="tabBar tabBarBg">
			<ul class="tabs-nav" style="left: 0px; padding-left: 188px;">
				<li id="index" title="主页" class="active"><a
					href="workbench.html"><span>主页</span></a></li>
				<c:forEach items="${moduleList}" var="module">
					<li id="${module.id}" title="${module.moduleName}" class=""><c:if
							test="${not empty module.url}">
							<a href="${module.url}"> <span>${module.moduleName}</span>
							</a>
						</c:if> <c:if test="${empty module.url}">
							<a href="subModule.zb?parentId=${module.id}"> <span>${module.moduleName}</span>
							</a>
						</c:if></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div id="tab-body" data-options="region:'center'"
		style="overflow: hidden;">
		<div id="index-main" class='tab-body-child'>
			<iframe id="index-main" src="workBench.zb" name="appIframe"
				class="iframeApp" frameborder="0" SCROLLING="auto" marginwidth="0"
				marginheight="0" style="width: 100%; height: 100%;"></iframe>
		</div>
	</div>
	<div data-options="region:'south',border:false">
		<div class="bottom_bar">江苏振邦基础应用平台欢迎你</div>
	</div>
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<!-- 个人设置对话框 -->
		<div id="psnDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '个人设置',
		    width: 400,
		    height: 150,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="psnForm" action="user/updateCurrentUser.zb" method="post">
				<input name="id" type="hidden" />
				<table style="margin: 0 auto;">
					<tr>
						<td>姓名：</td>
						<td><input type="text" name="fullname"
							data-options="required:true" class="easyui-validatebox" /></td>
						<td>性别：</td>
						<td><input type="radio" name="sex" value="1" checked />男 <input
							type="radio" name="sex" value="0" />女</td>
					</tr>
					<tr>
						<td>email：</td>
						<td><input type="text" name="email"
							class="easyui-validatebox"
							data-options="
							validType:'email'
						" /></td>
						<td>出生日期：</td>
						<td><input type="text" name="birthday"
							class="easyui-validatebox easyui-datebox" /></td>
					</tr>
					<tr>
						<td>电话：</td>
						<td><input type="text" name="tel" class="easyui-validatebox"
							data-options="
							validType:['length[0,10]','number']
						" />
						</td>
						<td>手机：</td>
						<td><input type="text" name="mobile"
							class="easyui-validatebox"
							data-options="
							validType:'mobile'
						" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="savePsn()">保存</a> <a
				class="easyui-linkbutton" onclick="$('#psnDlg').dialog('close')">取消</a>
		</div>
		<!-- 密码设置对话框 -->
		<div id="pwdDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '密码设置',
		    width: 250,
		    height: 155,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#pwdbtns'
		">
			<form id="pwdForm" action="" method="post">
				<table style="margin: 0 auto;">
					<tr>
						<td>原始密码：</td>
						<td><input type="password" name="originPwd"
							class="easyui-validatebox"
							data-options="
								editable:false,
								required:true,
								validType:['length[0,20]']
							" />
						</td>
					</tr>
					<tr>
						<td>新密码：</td>
						<td><input type="password" name="password" id="password"
							class="easyui-validatebox"
							data-options="
								editable:false,
								required:true,
								validType:['length[0,20]']
							" />
						</td>
					</tr>
					<tr>
						<td>确认新密码：</td>
						<td><input type="password" name="confirmPwd" id="password2"
							class="easyui-validatebox"
							data-options="
								editable:false,
								required:true,
								validType:['length[0,20]']
							" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="pwdbtns">
			<a class="easyui-linkbutton" onclick="savePwd()">保存</a> <a
				class="easyui-linkbutton" onclick="$('#pwdDlg').dialog('close')">取消</a>
		</div>

	</div>
</body>
</html>
