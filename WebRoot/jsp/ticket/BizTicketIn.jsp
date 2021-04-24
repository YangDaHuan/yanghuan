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
	$.post("ticket/findByAttrBizTicketIn.zb",formdata,function(data){
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
$.extend($.fn.validatebox.defaults.rules, {
	checkApplyCode : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "ticket/isApplyCodeExist.zb",
				dataType : "json",
				data : {
					applyCode : value
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp != "true";
		},
		message : "入库单号已经存在"
	}
});
function saveData(){
	var formdata=$("#dataForm").serializeArray();
	$.post("ticket/saveBizTicketIn.zb",formdata,function(data){
			if(data.success&&data.msg!=""){
				$.messager.alert("信息","提交成功!<br>您的入库单号为:"+data.msg,"info");
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
      		
        		var inId=new Array();
				for(var i=0;i<rows.length;i++){
					inId.push(rows[i].inId);
				}
				obj.inId=inId;
		
		
		
		$.post("ticket/deleteBizTicketIn.zb",obj,function(data){
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
			
					:<input name="inId" class="easyui-textbox" style="width:100px"> 
					:<input name="deployId" class="easyui-textbox" style="width:100px"> 
					:<input name="inType" class="easyui-textbox" style="width:100px"> 
					:<input name="inOrg" class="easyui-textbox" style="width:100px"> 
					:<input name="fromOrg" class="easyui-textbox" style="width:100px"> 
        			:<input name="inDate" class="easyui-datebox" style="width:100px"> 
					:<input name="description" class="easyui-textbox" style="width:100px"> 
					:<input name="operator" class="easyui-textbox" style="width:100px"> 
				
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
      			<th data-options="field:'inId',width:100,checkbox:true" ></th>
      			<th data-options="field:'deployId',width:100" ></th>  
      			<th data-options="field:'inType',width:100" ></th>  
      			<th data-options="field:'inOrg',width:100" ></th>  
      			<th data-options="field:'fromOrg',width:100" ></th>  
      			<th data-options="field:'inDate',width:100" ></th>  
      			<th data-options="field:'description',width:100" ></th>  
      			<th data-options="field:'operator',width:100" ></th>  
        	
               
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
    	<input type="hidden" name="inId" value=""/>
    	
				
    	<tr><td>   
        <label for="deployId">:</label>   
        </td><td>
			<input name="deployId" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="inType">:</label>   
        </td><td>
			<input name="inType" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="inOrg">:</label>   
        </td><td>
			<input name="inOrg" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="fromOrg">:</label>   
        </td><td>
			<input name="fromOrg" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="inDate">:</label>   
        </td><td>
        	<input name="inDate" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="description">:</label>   
        </td><td>
			<input name="description" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="operator">:</label>   
        </td><td>
			<input name="operator" class="easyui-textbox" style="width:100px"> 
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