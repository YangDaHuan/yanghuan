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
	$.post("ticket/findByAttrBizTicketDeploy.zb",formdata,function(data){
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
	$.post("ticket/saveBizTicketDeploy.zb",formdata,function(data){
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
      		
        		var deployId=new Array();
				for(var i=0;i<rows.length;i++){
					deployId.push(rows[i].deployId);
				}
				obj.deployId=deployId;
		
		
		
		$.post("ticket/deleteBizTicketDeploy.zb",obj,function(data){
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
			
					调配单ID:<input name="deployId" class="easyui-textbox" style="width:100px"> 
					调配单号:<input name="deployCode" class="easyui-textbox" style="width:100px"> 
					申请单号:<input name="applyCode" class="easyui-textbox" style="width:100px"> 
					调配单状态:<input name="depolyState" class="easyui-textbox" style="width:100px"> 
					调配部门:<input name="depolyOrg" class="easyui-textbox" style="width:100px"> 
					调配部门联系人:<input name="depolyContacts" class="easyui-textbox" style="width:100px"> 
					调配部门联系电话:<input name="depolyPhone" class="easyui-textbox" style="width:100px"> 
					来源部门:<input name="fromOrg" class="easyui-textbox" style="width:100px"> 
					来源部门联系人:<input name="fromContacts" class="easyui-textbox" style="width:100px"> 
					来源部门联系电话:<input name="fromPhone" class="easyui-textbox" style="width:100px"> 
					目标部门:<input name="toOrg" class="easyui-textbox" style="width:100px"> 
					目标部门联系人:<input name="toContacts" class="easyui-textbox" style="width:100px"> 
					目标部门联系电话:<input name="toPhone" class="easyui-textbox" style="width:100px"> 
        			调配日期:<input name="depolyDate" class="easyui-datebox" style="width:100px"> 
					填表人:<input name="designUser" class="easyui-textbox" style="width:100px"> 
					备注:<input name="description" class="easyui-textbox" style="width:100px"> 
        			创建日期:<input name="createTime" class="easyui-datebox" style="width:100px"> 
        			更新日期:<input name="updateTime" class="easyui-datebox" style="width:100px"> 
				
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
      			<th data-options="field:'deployId',width:100,checkbox:true" ></th>
      			<th data-options="field:'deployCode',width:100" >调配单号</th>  
      			<th data-options="field:'applyCode',width:100" >申请单号</th>  
      			<th data-options="field:'depolyState',width:100" >调配单状态</th>  
      			<th data-options="field:'depolyOrg',width:100" >调配部门</th>  
      			<th data-options="field:'depolyContacts',width:100" >调配部门联系人</th>  
      			<th data-options="field:'depolyPhone',width:100" >调配部门联系电话</th>  
      			<th data-options="field:'fromOrg',width:100" >来源部门</th>  
      			<th data-options="field:'fromContacts',width:100" >来源部门联系人</th>  
      			<th data-options="field:'fromPhone',width:100" >来源部门联系电话</th>  
      			<th data-options="field:'toOrg',width:100" >目标部门</th>  
      			<th data-options="field:'toContacts',width:100" >目标部门联系人</th>  
      			<th data-options="field:'toPhone',width:100" >目标部门联系电话</th>  
      			<th data-options="field:'depolyDate',width:100" >调配日期</th>  
      			<th data-options="field:'designUser',width:100" >填表人</th>  
      			<th data-options="field:'description',width:100" >备注</th>  
      			<th data-options="field:'createTime',width:100" >创建日期</th>  
      			<th data-options="field:'updateTime',width:100" >更新日期</th>  
        	
               
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
    	<input type="hidden" name="deployId" value=""/>
    	
				
    	<tr><td>   
        <label for="deployCode">调配单号:</label>   
        </td><td>
			<input name="deployCode" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="applyCode">申请单号:</label>   
        </td><td>
			<input name="applyCode" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="depolyState">调配单状态:</label>   
        </td><td>
			<input name="depolyState" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="depolyOrg">调配部门:</label>   
        </td><td>
			<input name="depolyOrg" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="depolyContacts">调配部门联系人:</label>   
        </td><td>
			<input name="depolyContacts" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="depolyPhone">调配部门联系电话:</label>   
        </td><td>
			<input name="depolyPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="fromOrg">来源部门:</label>   
        </td><td>
			<input name="fromOrg" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="fromContacts">来源部门联系人:</label>   
        </td><td>
			<input name="fromContacts" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="fromPhone">来源部门联系电话:</label>   
        </td><td>
			<input name="fromPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="toOrg">目标部门:</label>   
        </td><td>
			<input name="toOrg" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="toContacts">目标部门联系人:</label>   
        </td><td>
			<input name="toContacts" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="toPhone">目标部门联系电话:</label>   
        </td><td>
			<input name="toPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="depolyDate">调配日期:</label>   
        </td><td>
        	<input name="depolyDate" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="designUser">填表人:</label>   
        </td><td>
			<input name="designUser" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="description">备注:</label>   
        </td><td>
			<input name="description" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="createTime">创建日期:</label>   
        </td><td>
        	<input name="createTime" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="updateTime">更新日期:</label>   
        </td><td>
        	<input name="updateTime" class="easyui-datebox" style="width:100px"> 
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