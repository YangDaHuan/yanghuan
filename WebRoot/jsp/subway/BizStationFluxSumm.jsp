<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
function doSearch(){
	var formdata=$("#queryForm").serializeArray();
	$.post("subway/findByAttrBizStationFluxSumm.zb",formdata,function(data){
			if(data.success){
				$("#dataTable").datagrid("loadData",data.extData);
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
}
function openDialog(flag){
	if(flag==1){
		var rows=$("#dataTable").datagrid("getChecked");
		if(rows.length!=1){
			$.messager.alert("错误","请选择一条记录进行编辑!","error");
		}else{
			var row=rows[0];
			$("#dataForm").form("load",row);
			$("#dataDialog").dialog("open");
		}
	}else{
		$("#dataDialog").dialog("open");
	}
	
}
function saveData(){
	var formdata=$("#dataForm").serializeArray();
	$.post("subway/saveBizStationFluxSumm.zb",formdata,function(data){
			if(data.success){
				$.messager.alert("信息","保存成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","保存数据时出现系统错误!","error");
			}
			closeDialog();
			
		},"json");
}
function closeDialog(){
	$("#dataForm").form("clear");
	$("#dataDialog").dialog("close");
}
function deleteRows(){
	var rows=$("#dataTable").datagrid("getChecked");
	if(rows.length<1){
		$.messager.alert("错误","至少选择一条记录删除!","error");
	}else{
		var obj={};
      		
        		var id=new Array();
				for(var i=0;i<rows.length;i++){
					id.push(rows[i].id);
				}
				obj.id=id;
		
		
		
		$.post("subway/deleteBizStationFluxSumm.zb",obj,function(data){
			if(data.success){
				$.messager.alert("信息","删除成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
						
		},"json");
		
	}
	
	
}

</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'列表'" style="padding:5px;background:#eee;">
<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
			
					日期:<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
					站名:<input name="stationName" class="easyui-textbox" style="width:100px"> 
					时间段开始:<input name="sectionBegin" class="easyui-datetimebox" style="width:150px"> 
        			时间段结束:<input name="sectionEnd" class="easyui-datetimebox" style="width:150px"> 
				
			 <a onclick="doSearch()" class="easyui-linkbutton"
					data-options="
						iconCls:'icon-search',
						plain:true
					">查询</a>
					</form>
			</div>
			<a class="easyui-linkbutton" onclick="openDialog(0)"
				data-options="
			iconCls:'icon-add',
			plain:true
		">新增</a> 
		<a class="easyui-linkbutton" onclick="openDialog(1)"
				data-options="
			iconCls:'icon-edit',
			plain:true
		">编辑</a> 
		<a
				class="easyui-linkbutton" onclick="deleteRows()"
				data-options="
			iconCls:'icon-del',
			plain:true
		">删除</a> 
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'id',width:100,checkbox:true" ></th>
      			<th data-options="field:'settlementDate',width:100" >日期</th>  
      			<th data-options="field:'stationName',width:100" >站名</th>  
      			<th data-options="field:'stationEntry',width:100" >进站量</th>  
      			<th data-options="field:'stationExit',width:100" >出站量</th>  
      			<th data-options="field:'sectionBegin',width:150" >时间段开始</th>  
      			<th data-options="field:'sectionEnd',width:150" >时间段结束</th>  
        	
               
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:400px;height:200px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="id" value=""/>
    	
				
    	<tr><td>   
        <label for="settlementDate">日期:</label>   
        </td><td>
        	<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationName">站名:</label>   
        </td><td>
			<input name="stationName" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationEntry">进站量:</label>   
        </td><td>
			<input name="stationEntry" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationExit">出站量:</label>   
        </td><td>
			<input name="stationExit" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionBegin">时间段开始:</label>   
        </td><td>
        	<input name="sectionBegin" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionEnd">时间段结束:</label>   
        </td><td>
        	<input name="sectionEnd" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    
    </table>   
</form>    
</div>
<div id="dataDialogButtons">
<a class="easyui-linkbutton" data-options="onClick:saveData">保存</a>
<a class="easyui-linkbutton" data-options="onClick:closeDialog">关闭</a>
</div>
</body>
</html>