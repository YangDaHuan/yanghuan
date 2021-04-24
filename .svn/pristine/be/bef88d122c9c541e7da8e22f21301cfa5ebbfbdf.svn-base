<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>短信管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var selectItemValue;
var showNum = function(value){
	var nums = value.split(",");
	var str = "";
	for(var i=0;i<nums.length;i++){
		str+="<tr class='num_temp'><td>"+nums[i]+"</td></tr>";
	}
	$(".num_temp").remove();
	$("#temp").append(str);
	$("#dlg").dialog("open");
}

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
	var listTable = $("#smsTable");
	listTable.datagrid({
	    url:'sms/list.zb',
	    title: '短信列表',
	    iconCls: 'icon-sms',
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit:true,
        checkOnSelect:false,
	   /*  frozenColumns:[[
	    	{field:'ck',checkbox:true}
	    ]], */
	    height:$(this).height()-8,
	    columns:[[
	    	{field:'id', width:0, hidden: true},
	        {field:'sendTime',title:'发送时间',width:150,align:'left'},	        	       
	        {field:'senderName',title:'操作人',width:100,align:'left'},
	        {field:'smsModuleName',title:'操作模块',width:100,align:'left'},
	        {field:'mobileNum',title:'接收号码',width:200,align:'left',formatter:function(value,rowData, rowIndex){
				if(value.length>23){
					var str = value.substring(0, 23);
					return "<a class='easyui-linkbutton' width='100px'  plain='true' style='cursor:pointer' onclick='showNum(\""+value+"\")' >"+str+"...</a>";
				} 
				else return value;
			}},
	        {field:'content',title:'短信内容',width:300,align:'left'}
	    ]]
	});			
	selectItemValue = function(){
		var senderName = $("#senderName").val();
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		if (startTime!=''&&endTime!=''){
			if (!checkDate(startTime,endTime)){
				$.messager.alert("提示","开始时间要小于结束时间!","info");	
				return;
			}
		}
		var smsModuleName = $("#smsModuleName").val();		
		listTable.datagrid("clearChecked");
		listTable.datagrid("load",{
			senderName : senderName,
			smsModuleName : smsModuleName,
			startTime: startTime,
			endTime: endTime
		});	
	};
});
</script>
<style type="text/css">
.grid-sms {
	background: url("images/icons/grid-role.png") no-repeat center;
}

.time-field {
	width: 100px;
}

.query-field {
	float: left;
	height: 27px;
	margin: 3px;
}
</style>
</head>
<body class="easyui-layout">
	<div region="center">
		<table id="smsTable" toolbar="#search"></table>
	</div>
	<div id="search" style="margin: auto; padding-top: 3px; height: 30px;">
		<div class="query-field" style="margin-top: 7px;">
			操作人：<input type="text" id="senderName" class="time-field" />
		</div>
		<div class="query-field" style="margin-top: 5px;">
			发送时间：<input type="text" id="startTime" class="Wdate time-field"
				onClick="WdatePicker()" /> - <input type="text" id="endTime"
				class="Wdate time-field" onClick="WdatePicker()" />
		</div>
		<div class="query-field" style="margin-top: 7px;">
			操作模块：<input type="text" id="smsModuleName" class="time-field" />
		</div>
		<div class="query-field">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-search" plain="true" onclick="selectItemValue();">查询</a>
		</div>
	</div>
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="dlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '接收号码',
		    width: 200,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<table style="margin: 0 auto;" id="temp">
			</table>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="$('#dlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>