<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>我的审核</title>
<jsp:include page="../common.jsp" />
<script>
	function runInputTask(taskId,taskName,formId,taskInstanceId){
		var url="inputTask/runInputTask.zb?taskId="+taskId+"&formId="+formId+"&taskInstanceId="+taskInstanceId+"&inputType=2";
		parent.openTab(null,taskName,url);
						
	}
	
	
	/**
	 * 日期类型Formatter
	 */
	function dateTypeFormatter(value,row,index){
			if(value==null)return null;
				return value.substring(0,10);
		
		
	}
	
	/**
	 * 填报状态Formatter
	 */
	function inputStatusFlagFormatter(value,row,index){
		switch (value) {
		case 1 :
			return "暂存";
		case 2 :
			return "提交";
		default:
			return "未知";
		}
	}
	
	/**
	 * 审核状态Formatter
	 */
	function auditStatusFlagFormatter(value,row,index){
		switch (value) {
		case 1 :
			return "通过";
		case 2 :
			return "未通过";
		case 3 :
			return "退回";
		default:
			return "未审核";
		}
	}
	
	function funFormatter(value, row, index) {

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-search\"  title=\"查看\" onclick=\"runInputTask('"+ row.taskId + "','"+row.taskName+"','"+row.formId+"','"+ row.taskInstanceId + "')\"></div>";
		s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"审核\" onclick=\"auditInputTask("+ index+ ")\"></div>";
		return s;
	}

	function auditInputTask(index) {
		$("#auditTaskFormDlg").dialog({
			title : "审核填报任务",
			iconCls : "icon-edit"
		});
		$("#auditTaskFormDlg").dialog("open");
		$("#inputTaskInstanceTable").datagrid("selectRow", index);
		var row = $("#inputTaskInstanceTable").datagrid("getSelected");
		$("#auditTaskForm").form("load", row);
		
	}


function saveInputTaskInstance() {

		$("#auditTaskForm").form("submit", {
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
					$("#auditTaskFormDlg").dialog("close");
					$("#inputTaskInstanceTable").datagrid("reload");//重新加载功能组表格
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

</script>
</head>
<body class="easyui-layout">
	
	<div data-options="region:'center',title:'填报任务实例列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			

		</div>
		<table id="inputTaskInstanceTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'inputTask/selectInputTaskInstance.zb',
			toolbar:'#tb',
			onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
			rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'taskInstanceDescribe',width:'200'">填报实例描述</th>
					<th data-options="field:'taskName',width:'100'">填报任务名称</th>
					<th data-options="field:'inputTime',width:'100',formatter:dateTypeFormatter">填报日期</th>
					<th data-options="field:'inputState',width:'80',formatter:inputStatusFlagFormatter">填报状态</th>
					<th	data-options="field:'inputUsername',width:'80'">填报人人</th>
					<th data-options="field:'auditState',width:'80',formatter:auditStatusFlagFormatter">审核状态</th>
					<th data-options="field:'auditTime',width:'80',formatter:dateTypeFormatter">审核日期</th>
					<th data-options="field:'auditOpinion',width:'200'">审核意见</th>
					<th data-options="field:'taskInstanceId',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="auditTaskFormDlg" class="easyui-dialog"
			style="padding-top: 5px"
			data-options="
			title: '审核',
		    width: 400,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="auditTaskForm" action="inputTask/saveInputTaskInstance.zb" method="post">
				<input type="hidden" name="inputType" value="2"/>
				<input type="hidden" name="taskInstanceId" />
				<table style="margin: 0 auto;">

				<tr><td>审核结果</td><td><input type="radio" name="auditState" value="1" />通过&nbsp;&nbsp;&nbsp;<input type="radio" name="auditState" value="2" />未通过&nbsp;&nbsp;&nbsp;<input type="radio" name="auditState" value="3" />退回&nbsp;&nbsp;&nbsp;</td></tr>
				<tr><td>审核意见</td><td><input type="text" name="auditOpinion" class="easyui-textbox" style="height: 80px; width: 250px" data-options="validType:'length[0,200]',multiline:true" 	placeholder="不能大于200个字" /></td></tr>
				
					
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveInputTaskInstance()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#auditTaskFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	
</body>
</html>
