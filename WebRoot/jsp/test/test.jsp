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
	$.post("test1/getSysTestByAttr.zb",formdata,function(data){
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
	$.post("test1/saveSysTest.zb",formdata,function(data){
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
		var ids=new Array();
		for(var i=0;i<rows.length;i++){
			ids.push(rows[i].id);
		}
		$.post("test1/deleteSysTestById.zb",{ids:ids},function(data){
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
				姓名：<input id="qname" name="name" class="easyui-textbox" style="width:100px"> 
				
				性别：<select id="qsex" class="easyui-combobox"  name="sex" style="width:100px;" data-options="url:'dict/findDictItemByDictCode.zb?dictCode=sex',valueField:'value',textField:'text'">   
    					  
    				</select> 
    			出生日期：<input id="birthdayBegin" type="text" class="easyui-datebox" required="required"></input>  
    			至
    			<input id="birthdayEnd" type="text" class="easyui-datebox" required="required"></input>  
    			
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
            <th data-options="field:'name',width:100" >姓名</th>   
            <th data-options="field:'birthday',width:100">生日</th>   
            <th data-options="field:'sex',width:100">性别</th>   
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:400px;height:200px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    <input type="hidden" name="id" value=""/>
    <table><tr>
    <td>   
        <label for="name">姓名:</label>   
        </td><td>
        <input class="easyui-textbox" type="text" name="name" data-options="required:true" />   
    </td></tr>   
    <tr><td>   
        <label for="sex">性别:</label>   
        </td><td>
        <select class="easyui-combobox"  name="sex" style="width:100px;"  data-options="url:'dict/findDictItemByDictCode.zb?dictCode=sex',valueField:'value',textField:'text'"> 
    				</select> 
    			   
    </td>
    </tr> 
    <tr><td>   
        <label for="birthday">出生日期:</label>
        </td><td>
        <input name="birthday" type="text" class="easyui-datebox" required="required"></input>  
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