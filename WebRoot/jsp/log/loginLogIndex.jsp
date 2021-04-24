<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录日志管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript">
var removeData, viewData;
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
	if(month < 10)month='0'+month;
	var dt = d.getDate();
	if(dt < 10)dt='0'+dt;
	var today = year + "-" + month + "-" + dt;
	var listTable = $("#logTable");	
	listTable.datagrid({
	    url:'log/searchLoginLog.zb',
	    queryParams:{loginStartTime:today},
	    title: '日志列表',
	    iconCls: 'grid-log',
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit: true,
	    frozenColumns:[[
	    	{field:'ck',checkbox:true}
	    ]],
	    columns:[[
	    	{field:'id', width:0, hidden: true},
	        {field:'userName',title:'操作人',width:90},	        	       
	        {field:'loginTime',title:'登录时间',width:150},
	        {field:'ip',title:'IP地址',width:150},
	        {field:'logoutTime',title:'注销时间',width:150},
	        {field:'organName',title:'所属机构',width:150}
	    ]],
	    toolbar:['-',{
			id:'btnDel',
			text: '删除',
			iconCls: 'icon-del',
			handler: function(){
				var rows = listTable.datagrid("getSelections");
				if(rows.length<=0){
					var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
					return;
				}
				var id="";
				for(var i=0; i<rows.length; i++)
					id+=rows[i].id+",";
				id = id.substring(0, id.length-1);
				removeData(id);
			}
		},{
			id:'exportBtn',
			text: '导出',
			iconCls:"icon-export",
			handler: function(){
				$("#exportForm").attr("action","log/exportLoginLog.zb");
				$("#exportForm").attr("target","exportFram");
				$("#exportForm").submit();
				
				/* $.ajax({
					url: "log/exportLoginLog.zb",
					type: 'post',
					data: $("#searchForm").serialize(),
					dataType:"json",
					success: function(res){
											
					}
				}); */
			}
		},'-']
	});	
	//删除数据
	removeData = function(rowIndexs, index){
		$.messager.confirm('警告','确认删除所选日志信息吗？',function(r){
		    if (r){
		        $.ajax({
					url: "log/removeLoginLog.zb",
					type: 'post',
					data: "id="+rowIndexs,
					dataType:"json",
					success: function(res){
						if(res.success){
							$.noty.closeAll();
							var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
						}else {
							$.messager.alert("错误","操作失败");
						}
						listTable.datagrid("load");						
					}
				});
		    }
		});		
	};
	$("#search").click(function(){
		var startTime = $("#loginStartTime").val();
		var endTime = $("#loginEndTime").val();
		if (startTime!=''&&endTime!=''){
			if (!checkDate(startTime,endTime)){
				$.messager.alert("提示","开始时间要小于结束时间!","info");	
				return;
			}
		}
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			ip : $("#ip").val(),
			userName : $("#userName").val(),
			loginStartTime: $("#loginStartTime").val(),
			loginEndTime: $("#loginEndTime").val()
		});	
		$("#export_ipAddress").val($("#ip").val());
		$("#export_userName").val($("#userName").val());
		$("#export_loginStartTime").val($("#loginStartTime").val());
		$("#export_loginEndTime").val($("#loginEndTime").val());
	});
	$("#searchAll").click(function(){
		$("#searchForm").clearForm();
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			ip : $("#ip").val(),
			userName : $("#userName").val(),
			loginStartTime: $("#loginStartTime").val(),
			loginEndTime: $("#loginEndTime").val()
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
		data-options="region:'north',title:'日志查询',split:false,border:false"
		style="height: 80px; padding: 10px;">
		<form id="searchForm" method="post">
			<div style="float: left;">
				IP地址： <input type="text" id="ip" name="ip" style="width: 110px;" />&nbsp;&nbsp;&nbsp;&nbsp;
				操作人： <input type="text" id="userName" name="userName"
					style="width: 110px;" />&nbsp;&nbsp;&nbsp;&nbsp; 登录时间：<input
					type="text" id="loginStartTime" name="loginStartTime"
					class="Wdate time-field" onClick="WdatePicker()"
					style="width: 110px;" /> - <input type="text" id="loginEndTime"
					name="loginEndTime" class="Wdate time-field"
					onClick="WdatePicker()" style="width: 110px;" />
			</div>
			<div style="float: left; margin-left: 10px;">
				<a id="search" iconCls="icon-search" class="easyui-linkbutton">查
					询</a>
			</div>
		</form>
		<form id="exportForm">
			<input type="hidden" id="export_ip" name="ip" /> <input
				type="hidden" id="export_userName" name="userName" /> <input
				type="hidden" id="export_loginStartTime" name="loginStartTime" /> <input
				type="hidden" id="export_loginEndTime" name="loginEndTime" />
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="logTable"></table>
	</div>
	<iframe name="exportFram" style="display: none"></iframe>
</body>
</html>