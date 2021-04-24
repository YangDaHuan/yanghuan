<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page
	import="org.apache.shiro.SecurityUtils,com.solidextend.sys.security.UserDetails"%>
<%
UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
String userName=userDetails.getLoginName();
String password=userDetails.getPassword();
%>
<!DOCTYPE html>
<html>
<head>
<title>dashboard</title>
<jsp:include page="../common.jsp"></jsp:include>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
<meta name="description" content="Freewall demo filter" />
<meta name="keywords"
	content="javascript, dynamic, grid, layout, jquery plugin, fit zone" />

<!-- Saiku CSS -->
<link rel="stylesheet" href="olap/css/saiku/src/styles.css"
	type="text/css">

<script type="text/javascript" src="js/freewall.js"></script>
<script type="text/javascript" src="js/dashboard.js"></script>
<!-- echarts -->
<script src="js/echarts/echarts-all.js"></script>
<style type="text/css">
.layout {
	padding: 15px;
}

.free-wall {
	
}

.filter-items {
	padding: 10px 0px;
}

.filter-items a {
	display: inline-block;
	margin: 0px 5px 5px 0px;
	cursor: pointer;
}

.filter-label.active, .filter-label:hover {
	background: rgb(238, 180, 34);
}
</style>
</head>
<body>
	<div id="cc" class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',title:'resource',split:true"
			style="width: 200px;">
			<ul id="tree" class="ztree" style="width: 230px; overflow: auto;"></ul>
		</div>
		<div
			data-options="region:'center',title:'dashboard',tools:'#dashboard-buttons'">
			<div class="datagrid-toolbar">
				<a
					onclick="$('#openDashboardDlg').dialog('open');$('#dashboardId').combobox('reload');"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-edit'">打开</a> <a
					onclick="$('#newDashboardDlg').dialog('open');"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-add'">新建仪表板</a> <a
					onclick="solidbi.addWidget(true);" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-add'">添加窗格</a> <a
					onclick="$('#saveDashboardDlg').dialog('open');$('#dashboardName').textbox('setValue',solidbi.dashboardName);"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-save'">保存</a> <a
					onclick="solidbi.deleteDashboard();" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-del'">删除</a>
			</div>
			<div class="layout">
				<div id="filterItems" class="filter-items"></div>
				<div id="freewall" class="free-wall"></div>
			</div>

		</div>

	</div>


	<script type="text/javascript">
			function saveDashboard(name){
				var id=solidbi.dashboardId;
				solidbi.dashboardName=name;
				var widgets=solidbi.dashboard;
				var formdata=JSON.stringify({id:id,name:name,widgets:widgets}) 
				$.post("dashboard/saveDashboard.zb",{jsonStr:formdata},
						function(result, status) {
							if(result.success){//操作成功
								solidbi.dashboardId=result.extData;
								$.noty.closeAll();
								var n = noty({text: "保存成功",type:"success",layout:"topCenter",timeout:1000});
							}else{//保存失败
								$.messager.alert("错误","保存数据时出现系统错误!","error");
							}							
							
						},
						"json"
					); 
					
			}
			
			function getZtreeData(data){
				for(var i=0;i< data.length;i++){
					var obj=data[i];
					if(obj.type=="FOLDER"){
						obj["isParent"]=true;
					}
					if(data.repoObjects!=null){
						for(var j=0;j<data.repoObjects.length;j++){
							getZtreeData(data.repoObjects[j]);
						}
					}
					
				}
				
			}
			
			$(function() {
				var setting = {
						view : {
							selectedMulti : false
						},
						edit : {
							enable : true,
							showRemoveBtn : false,
							showRenameBtn : false
						},
						data : {
							key : {
								children : "repoObjects",
								name : "name"
							},
							keep : {
								parent : true,
								leaf: true
							}
						},
						callback : {
							beforeDrop: function(treeId, treeNodes, targetNode, moveType){
								return false;
							},
							onDrop : function(event, treeId, treeNodes, targetNode, moveType) {
								var panelId = event.target.id;
								var type = "bar";
								if (!$(event.target).hasClass("panel-body")) {
									panelId = $(event.target).parents(".panel-body")
											.attr("id");

								}
								for (var i = 0; i < solidbi.dashboard.length; i++) {
									if (solidbi.dashboard[i].id == panelId) {
										solidbi.dashboard[i].source = treeNodes[0].path;
										if(solidbi.dashboard[i].type==null||typeof solidbi.dashboard[i].type=="undefined"){
											solidbi.dashboard[i].type= "bar";
										}else{
											type=solidbi.dashboard[i].type;
										}
										solidbi.executeQuery(treeNodes[0].path, panelId, type);
										break;
									}
								}

								

							}
						}
				};
				
				$.post("/saiku/rest/saiku/session", {"username":"<%=userName%>","password":"<%=password%>"}, function(data) {
					$.get("/saiku/rest/saiku/session", {}, function(data) {
						if (data.username="<%=userName%>") {
						$.get("/saiku/rest/saiku/admin/repository2/", {"type":"saiku"}, function(data) {
							if (data) {
								getZtreeData(data);
								$.fn.zTree.init($("#tree"), setting, data);

							} else {
								$.messager.alert("错误", "查询saiku资源时出现系统错误!", "error");
							}
							$.messager.progress("close");
						}, "json");
	
						} else {
							$.messager.alert("错误", "自动登录时出现系统错误!", "error");
						}
						$.messager.progress("close");
					}, "json");
				}, "xml");
					
				
				
				
				solidbi.filterItems="#filterItems";
				solidbi.biwall="#freewall";
				solidbi.user="<%=userName%>";
				
			});
			
			
		</script>
	<div id="widgetConfigDlg" class="easyui-dialog" title="配置窗体"
		style="width: 400px; height: 300px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#dlg-buttons'">
		<form id="widgetConfigForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 10px 0 10px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>名称:</td>
					<td><input name="name" class="easyui-textbox"
						data-options="required:true" style="width: 200px"></td>
				</tr>
				<tr>
					<td>组名:</td>
					<td><input name="groupName" class="easyui-textbox"
						data-options="required:true" style="width: 200px"></td>
				</tr>
				<tr>
					<td>类型:</td>
					<td><select name="type" class="easyui-combobox"
						style="width: 200px;">
							<option value="table">表格</option>
							<option value="bar">柱状图</option>
							<option value="line">折线图</option>
							<option value="area">面积图</option>
							<option value="pie">环状图</option>
							<option value="radar">雷达图</option>
							<option value="scatter">散点图</option>
							<option value="bubble">气泡图</option>
							<option value="map">中国地图</option>

					</select></td>
				</tr>
				<tr>
					<td>宽度:</td>
					<td><input name="width" class="easyui-numberspinner"
						style="width: 100px;" required="required"
						data-options="min:100,max:1000,increment:10,editable:false">
					</td>
				</tr>
				<tr>
					<td>高度:</td>
					<td><input name="height" class="easyui-numberspinner"
						style="width: 100px;" required="required"
						data-options="min:100,max:1000,increment:10,editable:false">
					</td>
				</tr>
			</table>
		</form>
		<div id="dlg-buttons">
			<a
				onclick="solidbi.saveWidgetConfig('#widgetConfigDlg','#widgetConfigForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#widgetConfigDlg','#widgetConfigForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="newDashboardDlg" class="easyui-dialog" title="新建仪表板"
		style="width: 250px; height: 120px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#dashboardDlg-buttons'">
		<form id="newDashboardForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 1px 0 1px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>窗格数:</td>
					<td><input id="widgetCount" name="widgetCount"
						class="easyui-numberspinner" value=6 style="width: 100px;"
						required="required"
						data-options="min:1,max:20,increment:1,editable:false"></td>
				</tr>
			</table>
		</form>
		<div id="dashboardDlg-buttons">
			<a
				onclick="solidbi.createDashboard($('#widgetCount').numberspinner('getValue'));solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="saveDashboardDlg" class="easyui-dialog" title="保存仪表板"
		style="width: 350px; height: 150px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#saveDashboardDlg-buttons'">
		<form id="saveDashboardForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 1px 0 1px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>名称:</td>
					<td><input id="dashboardName" name="dashboardName"
						class="easyui-textbox" style="width: 200px;"
						data-options="required:true"></td>
				</tr>
			</table>
		</form>
		<div id="saveDashboardDlg-buttons">
			<a
				onclick="saveDashboard($('#dashboardName').textbox('getValue'));solidbi.cancelForm('#saveDashboardDlg','#saveDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#saveDashboardDlg','#saveDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="openDashboardDlg" class="easyui-dialog" title="保存仪表板"
		style="width: 350px; height: 150px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#openDashboardDlg-buttons'">
		<form id="openDashboardForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 1px 0 1px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>仪表板:</td>
					<td><input id="dashboardId" class="easyui-combobox"
						name="dashboardId"
						data-options="valueField:'id',textField:'name',url:'dashboard/getDashboardList.zb'" />

					</td>
				</tr>
			</table>
		</form>
		<div id="openDashboardDlg-buttons">
			<a
				onclick="solidbi.dashboardId=$('#dashboardId').combobox('getValue');solidbi.openDashboard();solidbi.cancelForm('#openDashboardDlg','#openDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#openDashboardDlg','#openDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>
