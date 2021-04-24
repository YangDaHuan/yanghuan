<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>模块访问日志管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript">
/*日期比较*/
function checkDate(startTime,endTime){
   var aStart=startTime.split('-'); //转成成数组，分别为年，月，日，下同
   var aEnd=endTime.split('-');
   var startDate = aStart[0]+"/" + aStart[1]+ "/" + aStart[2];
   var endDate = aEnd[0] + "/" + aEnd[1] + "/" + aEnd[2];
   if (startDate > endDate) {
    return false;
   }
   return true;
}
$(document.body).ready(function(){
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth() + 1; // 记得当前月是要+1的
	var dt = d.getDate();
	var today = year + "-" + month + "-" + dt;
	var today1 = month+"/"+dt+"/"+year;
	$("#searchStartTime").datebox("setValue",today1);
	$("#searchEndTime").datebox("setValue",today1);
	var listTable = $("#logTable");	
	listTable.datagrid({
	    url:'log/getModuleAccessCount.zb',
	    queryParams:{startDate:today},
	    title: '访问日志统计',
	    iconCls: 'grid-log',
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit: true,
	    
	    columns:[[
	    	{field:'moduleId', width:0, hidden: true},
	    	{field:'accessCount',title:'访问次数',width:100,align:'right'},
	        {field:'moduleCode',title:'模块编码',width:150},	        	       
	        {field:'moduleName',title:'模块名称',width:150},
	        {field:'url',title:'URL'}
	        
	    ]]
	});	
	
	$("#search").click(function(){
		var startTime = $("#searchStartTime").val();
		var endTime = $("#searchEndTime").val();
		if (startTime!=''&&endTime!=''){
			if (!checkDate(startTime,endTime)){
				$.messager.alert("提示","开始时间要小于结束时间!","info");	
				return;
			}
		}
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			startDate: $("#searchStartTime").datetimebox("getValue"),
			endDate: $("#searchEndTime").datetimebox("getValue")
		});	
		
	});
	
});
</script>
<style type="text/css">
.grid-log {
	background: url("images/icons/grid-role.png") no-repeat center;
}
</style>
</head>
<body class="easyui-layout" data-options="border:false">
	<div
		data-options="region:'north',title:'访问日志统计',split:false,border:false"
		style="height: 80px; padding: 10px;">
		<form id="searchForm" method="post">
			<div style="float: left;">
				
				访问时间：<input id="searchStartTime"
					name="searchStartTime" class="easyui-datebox" style="width: 100px;" />
				- <input id="searchEndTime" name="searchEndTime"
					class="easyui-datebox" style="width: 100px;" />
			</div>
			<div style="float: left; margin-left: 10px;">
				<a id="search" iconCls="icon-search" class="easyui-linkbutton">查
					询</a>
			</div>
		</form>

	</div>
	
	<div data-options="region:'center',border:false">
		<table id="logTable"></table>
	</div>
</body>
</html>