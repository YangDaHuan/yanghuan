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
	$.post("ticket/findByAttrBizTicketInDetail.zb",formdata,function(data){
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
	$.post("ticket/saveBizTicketInDetail.zb",formdata,function(data){
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
      		
        		var inDetailId=new Array();
				for(var i=0;i<rows.length;i++){
					inDetailId.push(rows[i].inDetailId);
				}
				obj.inDetailId=inDetailId;
		
		
		
		$.post("ticket/deleteBizTicketInDetail.zb",obj,function(data){
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
			
					:<input name="inDetailId" class="easyui-textbox" style="width:100px"> 
					:<input name="inId" class="easyui-textbox" style="width:100px"> 
					:<input name="ticketTypeId" class="easyui-textbox" style="width:100px"> 
					:<input name="ticketStateId" class="easyui-textbox" style="width:100px"> 
					:<input name="ticketNumber" class="easyui-textbox" style="width:100px"> 
					:<input name="ticketMoney" class="easyui-textbox" style="width:100px"> 
				
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
      			<th data-options="field:'inDetailId',width:100,checkbox:true" ></th>
      			<th data-options="field:'inId',width:100" ></th>  
      			<th data-options="field:'ticketTypeId',width:100" ></th>  
      			<th data-options="field:'ticketStateId',width:100" ></th>  
      			<th data-options="field:'ticketNumber',width:100" ></th>  
      			<th data-options="field:'ticketMoney',width:100" ></th>  
        	
               
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
    	<input type="hidden" name="inDetailId" value=""/>
    	
				
    	<tr><td>   
        <label for="inId">:</label>   
        </td><td>
			<input name="inId" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketTypeId">:</label>   
        </td><td>
			<input name="ticketTypeId" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketStateId">:</label>   
        </td><td>
			<input name="ticketStateId" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketNumber">:</label>   
        </td><td>
			<input name="ticketNumber" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketMoney">:</label>   
        </td><td>
			<input name="ticketMoney" class="easyui-textbox" style="width:100px"> 
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