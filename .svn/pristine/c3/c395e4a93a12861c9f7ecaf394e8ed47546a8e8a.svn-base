<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SQL监控</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var sortName,sortOrder;
//获取并加载数据
function loadSql(){
	$.get("${pageContext.request.contextPath}/druid/sql.json",function(data,status){
		loadData(data.Content);
	},"json");
}

function loadData(content){
	$("#logTable").datagrid({
	    title: 'SQL监控列表',
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
	    onSortColumn: function(sort, order){
			sortName=sort;
			sortOrder=order;
	    },
	    columns:[[
	    	{field:'SQL',title:'SQL',width:180,align:'left',sortable:true,formatter:function(value,rowData,rowIndex){ 
                        //value当前字段值，rowData当前行数据对象，rowIndex行号（行号从0开始）
                        return "<a href='javascript:viewData("+rowData.ID+");' title='"+value+"'>"+value+"</a>";  
                   }  
	        },
	        {field:'ExecuteCount',title:'<span title="执行次数">执行次数</span>',width:70,align:'right',sortable:true},	        	       
	        {field:'TotalTime',title:'<span title="执行总时间(ms)">执行总时间(ms)</span>',width:105,align:'right',sortable:true},	        	       
	        {field:'MaxTimespan',title:'<span title="单次最长时间(ms)">单次最长时间(ms)</span>',width:115,align:'right',sortable:true},
	        {field:'InTransactionCount',title:'<span title="在事务中运行的次数">事务中</span',width:55,align:'right',sortable:true},
	        {field:'ErrorCount',title:'<span title="执行出错的次数">错误数</span>',width:55,align:'right',sortable:true},
	        {field:'EffectedRowCount',title:'<span title="更新/删除操作中影响的行数">更新行数</span>',width:70,align:'right',sortable:true},
	        {field:'FetchRowCount',title:'<span title="读取行数">读取行数</span>',width:70,align:'right',sortable:true},
	        {field:'RunningCount',title:'<span title="正在运行中的数量">执行中</span>',width:60,align:'right',sortable:true},
	        {field:'ConcurrentMax',title:'<span title="最大并发数量">最大并发</span>',width:70,align:'right',sortable:true},
	        {field:'Histogram',title:'<span title="execute操作的时间在以下时间区间的数量分布情况：0-1ms,1-10ms,10-100ms,100-1000ms,1-10s,10-100s,100-1000s,>1000s">执行时间分布</span>',width:110,align:'left',formatter:function(value){
	        	return '['+value+']';
	        	}
	        },
	        {field:'ExecuteAndResultHoldTimeHistogram',title:'<span title="execute操作和resultSet打开至关闭的时间总和，在以下时间区间的数量分布情况：0-1ms,1-10ms,10-100ms,100-1000ms,1-10s,10-100s,100-1000s,>1000s">执行+RS时间分布</span>',width:110,align:'left',formatter:function(value){
	        	return '['+value+']';
	        	}
	        },
	        {field:'FetchRowCountHistogram',title:'<span title="读取行数在以下行数区间的分布情况：0行,1-9行,10-99行,100-999行,1000-9999行,>9999行">读取行数分布</span>',width:120,align:'left',formatter:function(value){
	        	return '['+value+']';
	        	}
	        },
	        {field:'EffectedRowCountHistogram',title:'<span title="更新/删除行数在以下行数区间的分布情况：0行,1-9行,10-99行,100-999行,1000-9999行,>9999行">更新行数分布</span>',width:120,align:'left',formatter:function(value){
	        	return '['+value+']';
	        	}
	        }
	    ]],
	    toolbar: ["-",{
	    	text:"刷新",
			iconCls: 'icon-reload',
			handler: function(){loadSql()}
		}]
	});	
}


//查看明细
function viewData(sqlId){
	var openWin = function(data){
		$("#win").window({
			width:"650",
			height:"350",
			collapsible:false,
			minimizable:false,
			modal:true
		});
		$('#win').html("<pre>"+data.Content.formattedSql+"</pre>");
		$('#win').window("open");
	};
	
	$.get("${pageContext.request.contextPath}/druid/sql-"+sqlId+".json",function(data,status){
		openWin(data);
	},"json");
};

$(document.body).ready(function(){
	loadSql();
	//5秒刷新
	//setInterval(loadSql,5000);
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
	<div id="win" iconCls="icon-save" title="查看SQL"></div>
</body>

</html>