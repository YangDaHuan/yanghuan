<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单类型管理</title>
<jsp:include page="../common.jsp" />
<script>
	//格式化角色树
function formatTree(node, data){
	var t=$(this);
	for(var i=0;i<data.length;i++){
		formatNode(data[i],t);
	}
}
function formatNode(nodeData,t){
	var iconCls="";
	if(nodeData.isLeaf=='1'){
		iconCls="roleNode";
	}else{
		iconCls="organNode";
	}
	//var t=$('#roles').combotree('tree');
	var node=t.tree('find',nodeData.id);
	t.tree('update', {
		target: node.target,
		iconCls:iconCls
	});
	var childs=nodeData.children;
	if(childs){
		for(var i=0;i<childs.length;i++){
			formatNode(childs[i],t);
		}
	}
}
	function openAddInputTaskDialog() {
		
		$("#inputTaskForm").form("reset");
		

		$("#inputTaskFormDlg").dialog({
			title : "新建填报任务",
			iconCls : "icon-add"
		});
		$("#inputTaskFormDlg").dialog("open");
	}
	function openEditInputTaskDialog(index) {
		$("#inputTaskFormDlg").dialog({
			title : "编辑填报任务",
			iconCls : "icon-edit"
		});
		$("#inputTaskFormDlg").dialog("open");
		$("#inputTaskTable").datagrid("selectRow", index);
		var row = $("#inputTaskTable").datagrid("getSelected");
		$("#inputTaskForm").form("load", row);
		
	}
	
	/**
	 * 日期类型Formatter
	 */
	function dateTypeFormatter(value,row,index){
		
				return value.substring(0,10);
		
		
	}
	/**
	 * 数据类型Formatter
	 */
	function dataTypeFormatter(value,row,index){
		for(var i=0;i<dataTypeData.length;i++){
			if(value==dataTypeData[i].value){
				return dataTypeData[i].label;
			}
		}
		return "未知";
	}
	
	
	/**
	 * 模块状态Formatter
	 */
	function statusFlagFormatter(value,row,index){
		switch (value) {
		case "0" :
			return "禁用";
		case "1" :
			return "启用";
		default:
			return "未知";
		}
	}
	
	function funFormatter(value, row, index) {

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditInputTaskDialog("
				+ index + ")\"></div>";
		s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteInputTask('"
				+ row.taskId + "')\"></div>";
		return s;
	}

	function saveInputTask() {

		$("#inputTaskForm").form("submit", {
			//提交前验证
			onSubmit : function() {
				$.messager.progress({
					title : "提示",
					text : "数据处理中，请稍后...."
				});
				var isValid = $(this).form("validate");
				if (!isValid) {
					$.messager.progress("close");
				}
				return isValid;
			},
			//提交成功
			success : function(result) {
				result = $.parseJSON(result);
				$.messager.progress("close");
				//操作成功,关闭对话框，显示提示信息，并重新加载功能组表格。
				if (result.success) {
					$("#inputTaskFormDlg").dialog("close");
					$("#inputTaskTable").datagrid("reload");//重新加载功能组表格
					$.noty.closeAll();
					var n = noty({
						text : "操作成功",
						type : "success",
						layout : "topCenter",
						timeout : 1000
					});
				} else {//保存失败
					$.noty.closeAll();
					var n = noty({
						text : result.msg,
						type : "warning",
						layout : "topCenter",
						timeout : 1500
					});
				}
			}
		});
	}
	
	//列表排序
	function sortInputTask(targetRow, sourceRow, point) {
		var rows = $(this).datagrid("getRows");
		var id = "";
		for (var i = 0; i < rows.length; i++) {
			id += rows[i].taskId + ",";

		}

		id = id.substring(0, id.length - 1);
		$.messager.confirm("提示", "您确认要排序吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("inputTask/sortInputTask.zb", {
				id : id
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});

				} else {
					$.messager.alert("错误", "更新数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}
	//删除
	function deleteInputTask(taskId) {
		$.messager.confirm("提示", "您确认要删除吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("inputTask/deleteInputTask.zb", {
				taskId : taskId
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});
					$("#inputTaskTable").datagrid("reload");//重新加载功能组表格

				} else {
					$.messager.alert("错误", "删除数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}


</script>
</head>
<body class="easyui-layout">
	
	<div data-options="region:'center',title:'填报任务列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			<a onclick="openAddInputTaskDialog()" class="easyui-linkbutton"
				data-options="
				iconCls:'icon-add',
				plain:true
			">新增</a>

		</div>
		<table id="inputTaskTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'inputTask/selectInputTask.zb',
			toolbar:'#tb',
			onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
			onDrop:sortInputTask,
	        rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'taskName',width:'100'">任务名称</th>
					<th data-options="field:'taskDescribe',width:'200'">任务描述</th>
					<th data-options="field:'taskStartTime',width:'100',formatter:dateTypeFormatter">任务开始日期</th>
					<th data-options="field:'taskEndTime',width:'80',formatter:dateTypeFormatter">任务结束日期</th>
					<th data-options="field:'disabled',width:'80',formatter:statusFlagFormatter">状态</th>
					<th	data-options="field:'createTime',width:'80',formatter:dateTypeFormatter">创建日期</th>
					<th data-options="field:'lastUpdateTime',width:'80',formatter:dateTypeFormatter">最后修改日期</th>
					<th data-options="field:'inputId',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="inputTaskFormDlg" class="easyui-dialog"
			style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 400,
		    height: 500,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="inputTaskForm" action="inputTask/saveInputTask.zb" method="post">
				<input type="hidden" name="taskId" />
				<table style="margin: 0 auto;">


					<tr>
						<td>任务名称：</td>
						<td><input type="text" name="taskName"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:250
							" />
						</td>
					</tr>
					<tr>
						<td>表单类型：</td>
						<td>
						<select  class="easyui-combobox" name="formType" style="width:200px;">   
    						<option value="1">系统表单</option>   
    						<option value="2">填报表</option>   
						</select>  
						</td>
					</tr>
					<tr>
						<td>表单：</td>
						<td>
						<input class="easyui-combobox" name="formId" style="width:200px;"  data-options="disabled:false,valueField:'formId',textField:'formName',url:'form/selectForm.zb'" /> 
						</td>
					</tr>
					<tr>
						<td>填报角色：</td>
						<td>
					<input name="inputRole" id="inputRole"
								class="easyui-combotree"
								data-options="
								url: 'role/getRoleTree.zb?organId=${organId}',
								customAttr:{
						            dataModel: 'simpleData',
						            textField: 'text',
						            parentField: 'parentId'
					        	},
					        	idFiled: 'id',
								width:150,
								editable:false,
								multiple:false,
								onLoadSuccess:formatTree,
								cascadeCheck:false,
								onBeforeSelect:function(node, checked){
									return node.isLeaf=='1';
								}
								
							" />
							</td></tr>
					
					<tr>
						<td>审核角色：</td>
						<td>
					<input name="auditRole" id="auditRole"
								class="easyui-combotree"
								data-options="
								url: 'role/getRoleTree.zb?organId=${organId}',
								customAttr:{
						            dataModel: 'simpleData',
						            textField: 'text',
						            parentField: 'parentId'
					        	},
					        	idFiled: 'id',
								width:150,
								editable:false,
								multiple:false,
								onLoadSuccess:formatTree,
								cascadeCheck:false,
								onBeforeSelect:function(node, checked){
									return node.isLeaf=='1';
								}
								
							" />
							</td></tr>
							
					<tr>
						<td>开始日期：</td>
						<td>
							<input name="taskStartTime" type="text" class="easyui-datebox" required="required" style="width:200px;"></input>
							
							</td></tr>
					<tr>
						<td>结束日期：</td>
						<td>
							<input name="taskEndTime" type="text" class="easyui-datebox" required="required" style="width:200px;"></input>
							
							</td></tr>
							
					<tr>
						<td>是否启用:</td>
						<td><input type="radio" name="disabled" value="1"
							checked="checked" />是&nbsp;&nbsp;&nbsp; <input type="radio"
							name="state" value="0" />否</td>
					</tr>

					<tr>
						<td>描述:</td>
						<td><input type="text" name="taskDescribe"
							class="easyui-textbox" style="height: 150px; width: 250px"
							data-options="validType:'length[0,200]',multiline:true"
							placeholder="不能大于200个字" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveInputTask()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#inputTaskFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	
</body>
</html>
