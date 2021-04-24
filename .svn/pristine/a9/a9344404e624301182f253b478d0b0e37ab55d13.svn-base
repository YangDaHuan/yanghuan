<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单类型管理</title>
<jsp:include page="../common.jsp" />
<script>
	function runInputTask(taskId,taskName,formId){
		var url="inputTask/runInputTask.zb?taskId="+taskId+"&formId="+formId+"&inputType=0";
		parent.openTab(taskName,url);
						
	}
	
	
	/**
	 * 日期类型Formatter
	 */
	function dateTypeFormatter(value,row,index){
		
				return value.substring(0,10);
		
		
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

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-start\"  title=\"启动\" onclick=\"runInputTask('"
				+ row.taskId + "','"+row.taskName+"','"+row.formId+"')\"></div>";
		return s;
	}

	


</script>
</head>
<body class="easyui-layout">
	
	<div data-options="region:'center',title:'填报任务列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			

		</div>
		<table id="inputTaskTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'inputTask/selectInputTask.zb',
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

	
	
</body>
</html>
