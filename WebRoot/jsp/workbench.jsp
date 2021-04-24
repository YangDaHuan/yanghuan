<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page
	import="com.solidextend.sys.security.UserDetails,org.apache.shiro.SecurityUtils,
	java.util.List"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<style type="text/css">
html, body {
	height: 100%;
	overflow: hidden;
	background-color: #fff;
}
</style>
<jsp:include page="common.jsp" />
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	var quickConfig = function() {
		$("#dlg").dialog("open");
	}
	//快捷方式事件
	bindQuickEvent = function() {
		$('.module')
				.click(
						function() {
							var url = $(this).attr('href');
							var window_id = 'w' + $(this).attr('id');
							var title = $(this).attr('title');
							if ($('#' + window_id).length == 0) {
								var windowDiv = '<div id="'+window_id+'"><iframe src="'
										+ url
										+ '" frameborder="0" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" style="width:100%;height:100%;"></iframe></div>';
								$(windowDiv).appendTo(document.body);
							}
							$('#' + window_id).window({
								width : 1000,
								height : domHeight - 60,
								modal : true,
								title : title
							});
							return false;
						});
	}
	var saveQuickModule = function() {
		var nodes = $('#tt').tree('getChecked');
		var s = '';
		if (nodes.length > 8) {
			$.messager.alert('BTP', "最多选择八个快捷菜单！");
			return;
		}
		for (var i = 0; i < nodes.length; i++) {
			s += nodes[i].id + ',';
		}
		if (s.length > 0) {
			s = s.substring(0, s.length - 1);
		}
		$.ajax({
			url : "module/saveQuickModule.zb",
			type : 'post',
			data : "id=" + s,
			dataType : "json",
			success : function(res) {
				if (res.success) {
					$('#dlg').dialog('close');
					$('#form').form('reset');
					$.noty.closeAll();
					var n = noty({
						text : "保存成功。",
						type : "success",
						layout : "topCenter",
						timeout : 1000,
						callback : { // 设置回调函数
							afterShow : function() {
								window.location.href = "workBench.zb";
							}
						}
					});
				} else
					$.messager.alert('BTP', "保存失败。");
			}
		});

	}
	/**
	 dom ready
	 */
	$(function() {
		domHeight = document.documentElement.clientHeight;
		$('#tt')
				.tree(
						{
							url : "module/getModuleListByUser.zb",
							customAttr : {
								dataModel : 'simpleData',
								textField : 'moduleName',
								parentField : 'parentId'
							},
							checkbox : "true",
							onCheck : function(node, checked) {
								if (checked == true) {
									$.ajax({
										url : "module/getModuleById.zb",
										type : 'post',
										dataType : 'json',
										data : "id=" + node.id,
										success : function(res) {
											if (res.success) {
												if (!res.extData.url) {
													$.messager.alert('BTP',
															"该模块没有操作页面");
													var node2 = $('#tt').tree(
															'find', node.id);
													$('#tt').tree('uncheck',
															node2.target);
												}
											} else
												$.messager
														.alert('BTP', "加载失败。");
										}
									});
								}
							},
							onLoadSuccess : function(node, data) {
								$
										.ajax({
											url : "getQuickModules.zb",
											type : 'post',
											dataType : 'json',
											success : function(res) {
												if (res.success) {
													quickModules = res.extData;
													var str = '';
													for (var i = 0; i < quickModules.length; i++) {
														if (quickModules[i].url) {
															var node = $('#tt')
																	.tree(
																			'find',
																			quickModules[i].id);
															$('#tt')
																	.tree(
																			'check',
																			node.target);
															str += '<li><a href="'+quickModules[i].url+'" id="'+quickModules[i].id+'" class="module" title="'+quickModules[i].moduleName+'" ><img src="images/icons/modules/'+quickModules[i].iconCls+'.png"/><span>'
																	+ quickModules[i].moduleName
																	+ '</span></a></li>';
														}
													}
													$("#quick_links").append(
															str);
												} else
													$.messager.alert('BTP',
															"快捷方式加载失败。");
												bindQuickEvent();
											}
										});

							}
						});

		//日历
		WdatePicker({
			eCont : 'date',
			doubleCalendar : true,
			skin : 'whyGreen',
			onpicked : function(dp) {
				alert('你选择的日期是:' + dp.cal.getDateStr())
			}
		})
	});
	<% 
    UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
	String sys_userid=userDetails.getLoginName();
	String sys_username=userDetails.getFullname();
	String sys_orgid=userDetails.getOrganId();
	String sys_orgcode=userDetails.getOrganCode();
	String groupName = request.getParameter("groupName");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
</script>
</head>
<body>
	<div class="workbench_bg">
		<div class="widget-place" id="widget-place-1"></div>
		<div class="widget-place" id="widget-place-2"></div>
		<ul class="workbench">
			<li class="">
				<div>
					<div class="block_header">
						<span class="block_name">日期时间</span>
					</div>

					<div class="block_body">
						<div id="date" style="margin-left: 30px;"></div>
					</div>
				</div>
			</li>
			<li class="">
				<div>
					<div class="block_header">
						<span class="block_name">快捷菜单</span> <span class="block_tools">
							<a href="javascript:quickConfig();" title="快捷菜单"
							class="block_config"></a>
						</span>
					</div>

					<div class="block_body">
						<ul class="quick_links" id="quick_links">
						</ul>

					</div>
				</div>
			</li>
			<li class="">
				<div>
					<div class="block_header">
						<span class="block_name">统计分析</span>
					</div>
					<div class="block_body" style="padding-left: 15px">
						<!-- <img alt="" src="images/tongji.png"
							style="height: 177px; width: 418px" /> -->
						
					</div>
				</div>
			</li>
			<li class="">
				<div>
					<div class="block_header">
						<span class="block_name">代办事项</span>
					</div>
					<div class="block_body" style="padding-left: 15px">
						<iframe id='1'
							<%-- src='<%=basePath%>reportJsp/indexReport.jsp?rpx=ticket/daiban.rpx&toOrg=<%=sys_orgid %>' --%>
							style='border: 0px' height='160' width='100%' scrolling='no'
							allowTransparency="true" frameborder='0'></iframe>
						<!-- 
							<p>
							<a style="font-size: 14px;">药品采购审批</a> <span
								style="float: right;">2014-04-01</span>
						</p>
						<p>
							<a style="font-size: 14px;">农保目录标准审核</a><span
								style="float: right;">2014-04-01</span>
						</p>
						 -->
					</div>
				</div>
			</li>
		</ul>
	</div>
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="dlg" class="easyui-dialog" style="padding-top: 10px"
			data-options="
			title:'快捷菜单配置',
			width: 500,
	    	height: 300,
	    	closed: true,
	    	cache: false,
	    	modal: true,
	    	buttons: '#dlgbtn'
		">
			<form id="form" action="">
				<ul id="tt"></ul>
			</form>
			<div id="dlgbtn" style="text-align: center; padding: 5px">
				<a class="easyui-linkbutton" onclick="saveQuickModule()">提交</a> <a
					class="easyui-linkbutton"
					onclick="$('#dlg').dialog('close');$('#form').form('reset');">取消</a>
			</div>
		</div>
	</div>
	<!-- 快捷通道弹出窗口 -->
	<div id="w"></div>
</body>
</html>
