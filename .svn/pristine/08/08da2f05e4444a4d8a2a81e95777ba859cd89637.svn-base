<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>任务日志管理</title>
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
function jobLogFormatter(value, row, index) {
	if(value!=null&&value.length > 10){
		return value.substring(0,10)+".....&nbsp;&nbsp;【双击查看】";
	}else{
		return value;
	}
	
}
$(document.body).ready(function(){
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth() + 1; // 记得当前月是要+1的
	var dt = d.getDate();
	var today = year + "-" + month + "-" + dt;
	var listTable = $("#logTable");	
	listTable.datagrid({
	    url:'log/searchJobLog.zb',
	    queryParams:{fireState:'失败',searchStartTime:today},
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
	        {field:'jobId',title:'任务名称',width:150},	        	       
	        {field:'fireTime',title:'执行时间',width:150},
	        {field:'fireState',title:'执行结果',width:80},
	        {field:'logInfo',title:'日志信息',width:100},
	        {field:'timeLength',title:'执行时长',width:80},
	        {field:'retryCount',title:'重试次数',width:80}
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
					id+=rows[i].logId+",";
				id = id.substring(0, id.length-1);
				removeData(id);
			}
		},'-'],
		onDblClickRow:function(rowIndex, rowData){
			$.post("log/searchJobLogById.zb",{logId:rowData.logId},function(data){
				if(data){
					
					$("#jobLogDlg").dialog({"content":data.logInfo});
					$("#jobLogDlg").dialog("open");
					
				}else{
					$.messager.alert("错误","查询数据时出现系统错误!","error");
				}
				
			},"json");
			
			
		}
	});	
	//删除数据
	removeData = function(rowIndexs, index){
		$.messager.confirm('警告','确认删除所选日志信息吗？',function(r){
		    if (r){
		        $.ajax({
					url: "log/removeJobLog.zb",
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
			jobId : $("#jobIdCombo").combobox("getValue"),
			fireState : $("#fireStateCombo").combobox("getValue"),
			searchStartTime: $("#searchStartTime").datetimebox("getValue"),
			searchEndTime: $("#searchEndTime").datetimebox("getValue")
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
				任务组：<input id="jobGroupId" class="easyui-combotree"
					name="jobGroupId" style="width: 100px;"
					data-options="
							url:'job/selectJobGroup.zb',
							required:false,
							customAttr: {
								dataModel: 'simpleData',
					        	idField: 'jobGroupId',
								textField: 'jobGroupName',
								parentField: 'parentId'
					        },
					        onClick:function(node){
					        	$('#jobIdCombo').combobox('reload','job/selectJobByGroupId.zb?jobGroupId='+node.jobGroupId);
					        }
						">&nbsp;&nbsp;&nbsp;&nbsp;
				任务： <input id="jobIdCombo" class="easyui-combobox" name="jobId"
					style="width: 200px"
					data-options="
    				 width:149,
    				 valueField:'jobId',
    				 textField:'jobName',
    				 url:'job/selectJobByGroupId.zb?jobGroupId=0'" />&nbsp;&nbsp;&nbsp;&nbsp;
				执行结果： <select id="fireStateCombo" name="fireState"
					class="easyui-combobox" style="width: 60px;">
					<option value="">全部</option>
					<option selected value="失败">失败</option>
					<option value="成功">成功</option>
				</select> &nbsp;&nbsp;&nbsp;&nbsp; 执行时间：<input id="searchStartTime"
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
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="jobLogDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '日志信息',
			resizable:true,
		    width: 400,
		    height: 350,
		    closed: true,
		    cache: false,
		    modal: true
		">

		</div>
	</div>
	<div data-options="region:'center',border:false">
		<table id="logTable"></table>
	</div>
</body>
</html>