<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>URL监控</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var sortName,sortOrder;
//获取并加载数据
function loadUri(){
	$.get("${pageContext.request.contextPath}/druid/weburi.json",function(data,status){
		//var json = eval("(" + data + ")");
		loadData(data.Content);
	},"json");
}

function loadData(content){
	$("#logTable").datagrid({
	    title: 'URI监控列表',
	    iconCls: 'grid-log',
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : false,//分页  
        rownumbers : true,//行数
        fit: true,
        singleSelect: true,
	    frozenColumns:[[
	    ]],
	    remoteSort:false,
	    data: content,
	    sortName: sortName,
	    sortOrder: sortOrder,
	    columns:[[
	    	{field:'URI',title:'URI',width:180,align:'left',title:'URI',sortable:true,formatter:function(value,rowData,rowIndex){ 
                        return "<a href='javascript:viewData(\""+value+"\");' title='"+value+"'>"+value+"</a>";  
                   }  
        	},
	        {field:'RequestCount',title:'<span title="请求次数">请求次数</span>',width:70,align:'right',sortable:true},	        	       
	        {field:'RequestTimeMillis',title:'<span title="请求时间(ms)">请求总时间(ms)</span>',width:110,align:'right',sortable:true},	        	       
	        {field:'RunningCount',title:'<span title="执行中">执行中</span>',width:80,align:'right',sortable:true},
	        {field:'ConcurrentMax',title:'<span title="最大并发">最大并发</span',width:80,align:'right',sortable:true},
	        {field:'JdbcExecuteCount',title:'<span title="jdbc执行数">jdbc执行数</span>',width:90,align:'right',sortable:true},
	        {field:'JdbcExecuteErrorCount',title:'<span title="jdbc出错数">jdbc出错数</span>',width:90,align:'right',sortable:true},
	        {field:'JdbcExecuteTimeMillis',title:'<span title="jdbc执行时间">jdbc执行时间</span>',width:100,align:'right',sortable:true},
	        {field:'JdbcCommitCount',title:'<span title="事务提交数">事务提交数</span>',width:90,align:'right',sortable:true},
	        {field:'JdbcRollbackCount',title:'<span title="事务回滚数">事务回滚数</span>',width:90,align:'right',sortable:true},
	        {field:'JdbcFetchRowCount',title:'<span title="读取行数">读取行数</span>',width:80,align:'right',sortable:true},
	        {field:'JdbcUpdateCount',title:'<span title="更新行数">更新行数</span>',width:80,align:'right',sortable:true}
	    ]],
	    toolbar: ["-",{
	    	text:"刷新",
			iconCls: 'icon-reload',
			handler: function(){loadUri()}
		}]
	});	
}

//查看明细
function viewData(fullUrl){
	$("#win").window({
			width:"650",
			height:"350",
			collapsible:false,
			minimizable:false,
			modal:true
		});
	$('#win').html(fullUrl);
	$('#win').window("open");		
};

$(document.body).ready(function(){
	loadUri();
	//5秒刷新
	//setInterval(loadUri,5000);
});
</script>
<style type="text/css">
.grid-log {
	background: url("images/icons/grid.png") no-repeat center;
}
</style>
</head>

<body class="easyui-layout" data-options="border:false">
	<div region="center" style="">
		<table id="logTable"></table>
	</div>
	<div id="win" iconCls="icon-save" title="查看URL"></div>
</body>

</html>