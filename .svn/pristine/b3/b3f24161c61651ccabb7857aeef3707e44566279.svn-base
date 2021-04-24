<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>我的填报</title>
<jsp:include page="../common.jsp" />
<script>
	function runInputTask(taskId,taskName,formId,taskInstanceId){
		var url="inputTask/runInputTask.zb?taskId="+taskId+"&formId="+formId+"&taskInstanceId="+taskInstanceId+"&inputType=1";
		parent.openTab(taskName,url);
						
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

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"runInputTask('"+ row.taskId + "','"+row.taskName+"','"+row.formId+"','"+ row.taskInstanceId + "')\"></div>";
		return s;
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
			url : 'inputTask/selectInputTaskInstance.zb?inputUserid=${userId}',
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
					<th data-options="field:'taskInstanceDescribe',width:'200'">填报实例名称</th>
					<th data-options="field:'taskName',width:'100'">填报任务名称</th>
					<th data-options="field:'inputTime',width:'100',formatter:dateTypeFormatter">填报日期</th>
					<th data-options="field:'inputState',width:'80',formatter:inputStatusFlagFormatter">填报状态</th>
					<th data-options="field:'auditState',width:'80',formatter:auditStatusFlagFormatter">审核状态</th>
					<th	data-options="field:'auditUsername',width:'80'">审核人</th>
					<th data-options="field:'auditTime',width:'80',formatter:dateTypeFormatter">审核日期</th>
					<th data-options="field:'auditOpinion',width:'200'">审核意见</th>
					<th data-options="field:'taskInstanceId',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	
	
</body>
</html>
