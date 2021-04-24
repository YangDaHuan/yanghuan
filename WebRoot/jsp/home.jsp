<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title> </title>
<link rel="stylesheet" type="text/css" href="css/index.css">
<style type="text/css">
</style>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="js/jsp/home.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
//标签页切换
var setTabs=function(){
	
		$("#menuList li a").click(function(){
			$("#menuList li").removeClass("active");
			$(this).parent().addClass("active");
			var id=$(this).parent().attr("id");
			var url=$(this).attr('href');
			if(url){
				$('.tab-body-child').hide();
				if($("#"+id+"-main").length==0){
					var iframe='<iframe name="frame_'+id+'"  src="'+url+'" frameborder="0" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" style="width:100%;height:100%;"></iframe>';
					$('#tab-body').append("<div id='"+id+"-main' class='tab-body-child'>"+iframe+"</div>");
				}	
				$("#"+id+"-main").show();
			}
			return false;
		});
}
$(function(){
	setTabs();
	dropDownMenu();
	//$('#index-main').find('iframe').attr('src','dashboard/show.zb');
	getHomePage();
	
});
function getHomePage(){
	var homePage='workBench.zb';
	var url = "user/getCurrentUser.zb";
	$.post(url,function(data){
		if(data){
			if(data.homeModule&&data.homeModule.length>0){
				$.post("module/getModuleByIdAndRole.zb?",{id:data.homeModule},function(data1){
					if(data1.success){
						if(data1.extData&&data1.extData.url&&data1.extData.url.length>0){
							var pUrl="";
							var funs=data1.extData.funs;
							if(typeof(funs)=="undefined"){
								homePage= data1.extData.url;
							}else{
								for(var i=0;i<funs.length;i++){
									if(typeof(funs[i].funCode)!="undefined"){
										pUrl=pUrl+"&"+funs[i].funCode+"="+funs[i].funValue;
									}
								}
								if(data1.extData.url.indexOf("?")>0){
									homePage= data1.extData.url+pUrl;
								}else{
									homePage= data1.extData.url+"?"+pUrl;
								}
							}
							
						}else{
							homePage= "subModule.zb?parentId="+data.homeModule;
							
						}
						$('#index-main').find('iframe').attr('src',homePage);
						
					}else{
						$.messager.alert("错误","加载数据时出现系统错误!","error");
					}
					
				},"json");
				
			}else{
				$('#index-main').find('iframe').attr('src',homePage);
			}
		}else{
			$.messager.alert("错误","加载时出现系统错误!","error");			
		}
	},"json");
	
}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false">
		<div class="index_header">
			<div class="topMenuList">
				<ul id="menuList" style="margin-left: 200px;">
					<li id="index" title="主页" class="active"><a
						href="workbench.zb" class=""> <img
							src="images/icons/app_mid_home.png" /> <span>首页</span>
					</a></li>
					<c:forEach items="${moduleList}" var="module">
						<li id="${module.id}" title="${module.moduleName}" class="">
							<c:if test="${module.isFolder!='1'}">
								<a href="${module.url}"> <c:if
										test="${empty module.iconCls}">
										<img src="images/icons/modules/setting.png" />
									</c:if> <c:if test="${not empty module.iconCls}">
										<img src="images/icons/modules/${module.iconCls}.png" />
									</c:if> <span>${module.moduleName}</span>
								</a>
							</c:if> <c:if test="${module.isFolder =='1'}">
								<a href="subModule.zb?parentId=${module.id}"> <c:if
										test="${empty module.iconCls}">
										<img src="images/icons/modules/setting.png" />
									</c:if> <c:if test="${not empty module.iconCls}">
										<img src="images/icons/modules/${module.iconCls}.png" />
									</c:if> <span>${module.moduleName}</span>
								</a>
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</div>
			<!-- 用户工具栏 -->
			<div id="umenu">
				<span class="noborder"></span> <span>${cureDate}</span> <span
					class="pipe">|</span> <span id="fullname">${userDetails.fullname}</span>
				<span class="pipe">|</span>
				<ul class="topmenu">
					<li><a href="javascript:void(0);">设置</a>
						<ul class="menu-sublist" style="display: none;">
							<li><a href="javascript:psnSetting();">个人设置</a></li>
							<li><a href="javascript:pwdSetting();">密码设置</a></li>
							<li><a href="home.zb?theme=mobile">移动版</a></li>
						</ul></li>
				</ul>

				<span class="pipe">|</span> <a href="javascript:logout()">退出</a>
			</div>
			<div class="index_logo" style=""></div>
		</div>
	</div>
	<div id="tab-body" data-options="region:'center'"
		style="overflow: hidden;">
		<div id="index-main" class='tab-body-child'>
			<iframe src="" name="appIframe" class="iframeApp" frameborder="0"
				SCROLLING="auto" marginwidth="0" marginheight="0"
				style="width: 100%; height: 100%;"> </iframe>
		</div>
	</div>
	<div data-options="region:'south',border:false">
		<div class="bottom_bar">五邑大学点餐后台管理系统欢迎您</div>
	</div>
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<!-- 个人设置对话框 -->
		<div id="psnDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '个人设置',
		    width: 400,
		    height: 200,
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
							data-options="required:true,validType:'length[0,20]'"
							class="easyui-validatebox" /></td>
						<td>性别：</td>
						<td><input type="radio" name="sex" value="1"
							onclick="changeSex(this)" />男 <input type="radio" name="sex"
							value="0" onclick="changeSex(this)" />女</td>
					</tr>
					<tr>
						<td>email：</td>
						<td><input type="text" name="email"
							class="easyui-validatebox"
							data-options="
							validType:['email','length[0,255]']
						" />
						</td>
						<td>出生日期：</td>
						<td><input type="text" name="birthday" readonly="readonly"
							class="easyui-validatebox Wdate time-field"
							onClick="WdatePicker()" /></td>
					</tr>
					<tr>
						<td>电话：</td>
						<td><input type="text" name="tel" class="easyui-validatebox"
							data-options="
							validType:['checkPhone','length[0,18]']
						" />
						</td>
						<td>手机：</td>
						<td><input type="text" name="mobile"
							class="easyui-validatebox"
							data-options="
							validType:['positiveInt','fixLength[11]']
						" />
						</td>
					</tr>
					<tr>
						<td>首页：</td>
						<td colspan="3"><input id="homeModule"
							class="easyui-combotree" name="homeModule" style="width: 250px;"
							data-options="
							url:'module/getModuleListByUser.zb',
							required:false,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'moduleName',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#homeModule').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
							<a id="btn" class="easyui-linkbutton"
							data-options="iconCls:'icon-reload'"
							onclick="javascript:$('#homeModule').combotree('clear')">默认首页</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
				onclick="savePsn()">确定</a> <a class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				onclick="$('#psnDlg').dialog('close')">取消</a>
		</div>
		<!-- 密码设置对话框 -->
		<div id="pwdDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '密码设置',
		    width: 260,
		    height: 160,
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
								validType:['length[6,18]']
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
								validType:['length[6,18]']
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
								validType:['length[6,18]']
							" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="pwdbtns">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
				onclick="savePwd()">确定</a> <a class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				onclick="$('#pwdDlg').dialog('close')">取消</a>
		</div>

	</div>
</body>
</html>
