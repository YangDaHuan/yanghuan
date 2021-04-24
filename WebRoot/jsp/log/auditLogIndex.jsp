<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>审计管理</title>
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

	//明细框
	$('#win').window({
	    width:$(document.body).width() * 0.9,
	    height:$(document.body).height() * 0.9,
	    modal:true,
	    closed:true
	});
		
	var listTable = $("#logTable");	
	listTable.datagrid({
	    url:'log/searchAuditLog.zb',
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
	    	{field:'logId', width:0, hidden: true},
	        {field:'fullName',title:'操作人',width:90,align:'left'},	        	       
	        {field:'createTime',title:'操作时间',width:130,align:'left'},
	        {field:'ipAddress',title:'IP地址',width:130,align:'left'},
	        {field:'moduleName',title:'模块',width:150,align:'left'},
	        {field:'serviceId',title:'业务id',width:260,align:'left'},
	        {field:'opFlag',title:'操作标识',width:70,align:'left',formatter:function(value,rowData, rowIndex){
				if (value=="1")
	   	    	{
	   	    		return "新增";
	   	    	}
	   	    	if (value=="2")
	   	    	{
	   	    		return "修改";
	   	    	}
	   	    	if (value=="3")
	   	    	{
	   	    		return "删除";
	   	    	}
	   	    	if (value=="4")
	   	    	{
	   	    		return "查询";
	   	    	}
			}},
			{field:'description',title:'描述',width:250,align:'left'}
	    ]],
	    toolbar:['-',{
			id:'btnadd',
			text:'查看详情',
			iconCls:'icon-add',
			handler:function(){
				var rows = listTable.datagrid("getSelections");
				if(rows.length!=1){
					var n = noty({text: "请选择一条日志进行查看!",type:"warning",layout:"topCenter",timeout:1500});
					return;
				}
				viewData(rows[0].logId);
			}
		},{
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
					id+=rows[i].logId+",";
				id = id.substring(0, id.length-1);
				removeData(id);
			}
		},{
			id:"exportBtn",
			text: "导出",
			iconCls:"icon-export",
			handler: function(){
				$("#exportForm").attr("action","log/exportAuditLog.zb");
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
	//查看明细
	viewData = function(rowIndex){
		$("#win").find("iframe").attr("src", "log/findAuditLogById.zb?logId="+rowIndex);
		$("#win").window({
				width:"760",
				hight:"500",
				collapsible:false,
				minimizable:false,
				modal:true
			});
		$('#win').window("open");		
	};
	//删除数据
	removeData = function(rowIndexs, index){
		$.messager.confirm('警告','确认删除所选日志信息吗？',function(r){
		    if (r){
		        $.ajax({
					url: "log/removeAuditLog.zb",
					type: 'post',
					data: "id="+rowIndexs,
					dataType:"json",
					success: function(res){
						if(res.success){
							$.noty.closeAll();
							var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
						}else{
							$.messager.alert('错误',"操作失败");
						}
						listTable.datagrid("load");						
					}
				});
		    }
		});		
	};
	$("#search").click(function(){
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		if (startTime!=''&&endTime!=''){
			if (!checkDate(startTime,endTime)){
				$.messager.alert("提示","开始时间要小于结束时间!","info");	
				return;
			}
		}
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			ipAddress : $("#ipAddress").val(),
			opFlag : $("#opFlag").val(),
			startTime: $("#startTime").val(),
			endTime: $("#endTime").val()
		});	
		$("#export_ipAddress").val($("#ipAddress").val());
		$("#export_opFlag").val($("#opFlag").val());
		$("#export_startTime").val($("#startTime").val());
		$("#export_endTime").val($("#endTime").val());
	});
	$("#searchAll").click(function(){
		$("#searchForm").clearForm();
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			ipAddress : $("#ipAddress").val(),
			opFlag : $("#opFlag").val(),
			startTime: $("#startTime").val(),
			endTime: $("#endTime").val()
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
	<div region="north" title="日志查询" split="false"
		style="height: 80px; padding: 10px;">
		<form id="searchForm">
			<div style="float: left;">
				IP地址：<input type="text" id="ipAddress" name="ipAddress" />&nbsp;&nbsp;&nbsp;&nbsp;
				操作标识：<select id="opFlag" name="opFlag">
					<option value="">全部</option>
					<option value="1">新增</option>
					<option value="2">修改</option>
					<option value="3">删除</option>
					<option value="4">查询</option>
				</select>&nbsp;&nbsp;&nbsp;&nbsp; 操作时间：<input type="text" id="startTime"
					class="Wdate time-field" onClick="WdatePicker()" name="startTime" />
				- <input type="text" id="endTime" name="endTime"
					class="Wdate time-field" onClick="WdatePicker()" />
			</div>
			<div style="float: left; margin-left: 10px;">
				<a id="search" iconCls="icon-search" class="easyui-linkbutton">查
					询</a>
			</div>
		</form>
		<form id="exportForm">
			<input type="hidden" id="export_ipAddress" name="ipAddress" /> <input
				type="hidden" id="export_opFlag" name="opFlag" /> <input
				type="hidden" id="export_startTime" name="startTime" /> <input
				type="hidden" id="export_endTime" name="endTime" />
		</form>
	</div>
	<div region="center" style="">
		<table id="logTable"></table>
	</div>
	<div id="win" iconCls="icon-save" title="审计日志详细信息">
		<iframe src="" frameborder="0" scrolling="no" marginwidth="0"
			marginheight="0" style="width: 100%; height: 100%; overflow: hidden;"></iframe>
	</div>
	<iframe name="exportFram" style="display: none"></iframe>
</body>
</html>