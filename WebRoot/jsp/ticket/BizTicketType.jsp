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
	$.post("ticket/findByAttrBizTicketType.zb",formdata,function(data){
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
	$.post("ticket/saveBizTicketType.zb",formdata,function(data){
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
      		
        		var ticketTypeId=new Array();
				for(var i=0;i<rows.length;i++){
					ticketTypeId.push(rows[i].ticketTypeId);
				}
				obj.ticketTypeId=ticketTypeId;
		$.post("ticket/deleteBizTicketType.zb",obj,function(data){
			if(data.success){
				$.messager.alert("信息","删除成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
		},"json");
	}
}
function booleanFormatter(value, row, index) {
	if(value=='1'){
		return '是';
	}else{
		return '否';
	}
}
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'列表'" style="padding:5px;background:#eee;">
<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
					票卡分组名称:<input name="groupName" class="easyui-textbox" style="width:100px"> 
					票卡类型名称:<input name="ticketTypeName" class="easyui-textbox" style="width:100px"> 
					是否包含金额:<input name="isHaveMoney" class="easyui-textbox" style="width:100px"> 
					描述:<input name="description" class="easyui-textbox" style="width:100px"> 
					是否启用:<input name="isenabled" class="easyui-textbox" style="width:100px"> 
        			
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
      			<th data-options="field:'ticketTypeId',width:100,checkbox:true" ></th>
      			<th data-options="field:'groupName',width:100" >票卡分组名称</th> 
      			<th data-options="field:'ticketTypeName',width:100" >票卡类型名称</th>  
      			<th data-options="field:'isHaveMoney',width:100,formatter:booleanFormatter" >是否包含金额</th>
      			<th data-options="field:'description',width:100" >描述</th>  
      			<th data-options="field:'isenabled',width:100,formatter:booleanFormatter" >是否启用</th>  
      			<th data-options="field:'createTime',width:160" >创建时间</th>  
      			<th data-options="field:'updateTime',width:160" >最后更新时间</th>  
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:400px;height:200px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    	<input name="ticketTypeId" type="hidden" >
    <table>
    	<tr><td>   
        <label for="groupName">票卡分组名称:</label>   
        </td><td>
			<input name="groupName" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
				
    	<tr><td>   
        <label for="ticketTypeName">票卡类型名称:</label>   
        </td><td>
			<input name="ticketTypeName" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
				
    	<tr><td>   
        <label for="isHaveMoney">是否包含金额:</label>   
        </td><td>
			<input type="radio" name="isHaveMoney" value="1" checked="checked" />是 
        	<input type="radio" name="isHaveMoney" value="0" />否 
       </td></tr> 
    	
    	<tr><td>   
        <label for="description">描述:</label>   
        </td><td>
			<input name="description" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
				
    	<tr><td>   
        <label for="isenabled">是否启用:</label>   
        </td><td>
			<input type="radio" name="isenabled" value="1" checked="checked" />是 
        	<input type="radio" name="isenabled" value="0" />否 
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