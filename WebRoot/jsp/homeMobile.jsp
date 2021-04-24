<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<jsp:include page="common.jsp"></jsp:include>
<!-- SCRIPTS -->
<script src="js/jquery.zlight.menu.1.0.min.js"></script>
<script type="text/javascript" src="js/jsp/home.js"></script>
<!-- STYLES -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="css/font-awesome.min.css" media="screen">
<link rel="stylesheet" href="css/zlight.menu.css" media="screen">

<title>五邑大学外卖点餐后台管理系统</title>
<script>
    $(document).ready(function(){
    	initMenu($('#zlight-main-nav'),"appIframe");
    	
    });
    function getHomePage(mainUl,iframe,target){
    	var homePage='workBench.zb';
    	var url = "user/getCurrentUser.zb";
    	$.post(url,function(data){
    		if(data){
    			if(data.homeModule&&data.homeModule.length>0){
    				$.post("module/getModuleById.zb?",{id:data.homeModule},function(data1){
    					if(data1.success){
    						if(data1.extData&&data1.extData.url&&data1.extData.url.length>0){
    							homePage= data1.extData.url;
    						}else{
    							homePage= "subModule.zb?parentId="+data.homeModule;
    							
    						}
    						homeLi=$("<li><a target=\""+target+"\" href=\""+homePage+"\">首页</a></li>");
    						mainUl.prepend(homeLi);
    						addSettingMenu(mainUl);
    						iframe.attr('src',homePage);
    						
    					}else{
    						$.messager.alert("错误","加载数据时出现系统错误!","error");
    					}
    					
    				},"json");
    				
    			}else{
    				homeLi=$("<li><a target=\""+target+"\" href=\""+homePage+"\">首页</a></li>");
    				mainUl.prepend(homeLi);
    				addSettingMenu(mainUl);
    				iframe.attr('src',homePage);
    			}
    		}else{
    			$.messager.alert("错误","加载时出现系统错误!","error");			
    		}
    	},"json");
    	
    }
    function addSettingMenu(mainUl){
    	settingLi=$("<li  class=\"zlight-dropdown\"><a>${userDetails.fullname}</a><ul class=\"zlight-submenu\">"
    			  +"<li><a href=\"javascript:psnSetting();\">个人设置</a></li>"
				  +"<li><a href=\"javascript:pwdSetting();\">修改密码</a></li>"
    			  +"<li><a href=\"home.zb?theme=pc\">电脑版</a></li>"
				  +"<li><a href=\"javascript:logout()\">退出</a></li>"
				+"</ul></li>");
		mainUl.append(settingLi);
		$('#zlight-nav').zlightMenu();
    	
    }
    
     function initMenu(mainUl,target){
    	  $.post("module/getModuleListByUser.zb",function(data){
        		if(data){
    				var mainMenu=getChilds('0',data);
    				for(var i=0;i<mainMenu.length;i++){
    					var href="javascript:void(0);";
    					if(mainMenu[i].url!=null&&mainMenu[i].url!='')href=mainMenu[i].url;
    					var childs=getChilds(mainMenu[i].id,data);
    					var liObj;
    					if(childs.length>0){
    						liObj=$("<li class=\"zlight-dropdown\"><a target=\""+target+"\" href=\""+href+"\">"+mainMenu[i].moduleName+"<i class=\"icon-angle-right\"></i></a></li>");
    						addChilds(liObj,childs,data,target);
    					}else{
    						liObj=$("<li><a target=\""+target+"\" href=\""+href+"\">"+mainMenu[i].moduleName+"</a></li>");
    					}
    					mainUl.append(liObj);
    				}
    				getHomePage(mainUl,$("#appIframe"),target);	
    		    	  
    				
    			}
        	},"json");
        	
        }
      function addChilds(pLi,childs,data,target){
    	  var ulObj=$("<ul class=\"zlight-submenu\"></ul>");
		  for(var i=0;i<childs.length;i++){
				var href="javascript:void(0);";
				if(childs[i].url!=null&&childs[i].url!='')href=childs[i].url;
				var liObj;
				var newChilds=getChilds(childs[i].id,data);
				if(newChilds.length>0){
					liObj=$("<li class=\"zlight-dropdown\"><a target=\""+target+"\" href=\""+href+"\">"+childs[i].moduleName+"<i class=\"icon-angle-right\"></i></a></li>");
					addChilds(liObj,newChilds,data,target);
				}else{
					liObj=$("<li><a target=\""+target+"\" href=\""+href+"\">"+childs[i].moduleName+"</a></li>");
				}
				ulObj.append(liObj);
		  }
		  pLi.append(ulObj);
      }
    	function getChilds(pid,data){
    		var childs=new Array();
    		for(var i=0;i<data.length;i++){
    			if(data[i].parentId==pid){
    				childs.push(data[i]);
    			}
    		}
    		return childs;
    	}
</script>
<style type="text/css">
html, body {
	margin: 0px 0px;
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div class="container" id="main" style="height: 100%;">
		<div class="row">
			<div class="col-lg-12">
				<h4>五邑大学外卖点餐后台管理系统</h4>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<nav id="zlight-nav">
				<ul id="zlight-main-nav">


				</ul>
				<!-- MOBILE NAV -->
				<div id="zlight-mobile-nav">
					<span>菜单</span> <i class="icon-reorder zlight-icon"></i> <select>
					</select>
				</div>
				</nav>
				<!-- nav close -->
			</div>
		</div>
		<div
			style="-webkit-overflow-scrolling: touch; overflow-y: scroll; overflow-x: scroll; width: 100%; height: 100%">
			<iframe src="" id="appIframe" name="appIframe" class="iframeApp"
				frameborder="0" SCROLLING="auto" marginwidth="0" marginheight="0"
				style="width: 100%; height: 100%;"> </iframe>
		</div>
	</div>
	<!-- main close -->
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
							class="easyui-combotree" name="homeModule" style="width: 320px;"
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