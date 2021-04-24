<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page
	import="com.solidextend.sys.security.UserDetails,org.apache.shiro.SecurityUtils,
	java.util.List"%>
    <% 
    UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
	String sys_userid=userDetails.getLoginName();
	String sys_username=userDetails.getFullname();
	String sys_orgid=userDetails.getOrganId();
	String sys_orgcode=userDetails.getOrganCode();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp" />
<jsp:include page="../ticket/combo.jsp" />
<script type="text/javascript">
function doSearch(){
	var formdata=$("#queryForm").serializeArray();
	$.post("ticket/findByAttrBizTicketStockThreshold.zb",formdata,function(data){
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
		var depId=$("#qStockOrg").combotree("getValue");
		$("#stockOrg").combotree("setValue",depId);
		$("#dataDialog").dialog("open");
	}
	
}
function saveData(){
	var isValid =$("#dataForm").form("validate");
	if(!isValid){
		$.messager.alert("错误","请填写合法的数据!","error");
		return;
	}
	var formdata=$("#dataForm").serializeArray();
	$.post("ticket/saveBizTicketStockThreshold.zb",formdata,function(data){
			if(data.success&&data.msg==""){
				$.messager.alert("信息","保存成功!","info");
				doSearch();
			}else if(data.success&&data.msg!=""){
				$.messager.alert("信息",data.msg,"info");
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
      		
        		var stockId=new Array();
				for(var i=0;i<rows.length;i++){
					stockId.push(rows[i].stockId);
				}
				obj.stockId=stockId;
		
		$.post("ticket/deleteBizTicketStockThreshold.zb",obj,function(data){
			if(data.success){
				$.messager.alert("信息","删除成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
						
		},"json");
		
	}
}

var ticketTypes;
function getTicketTypes(){
	if(ticketTypes==null){
		$.ajax({ 

        	type: "post", 

       		url:'ticket/findByAttrBizTicketType.zb', 

       		cache:false, 

       		async:false, 

        	dataType: 'json', 

         	success: function(data){ 
				ticketTypes=data.extData;
        	} 

		});
		return ticketTypes;
	}else{
		return ticketTypes;
	}
}
var ticketStates; 
function getTicketStates(){
	if(ticketStates==null){
		$.ajax({ 

        	type: "post", 

       		url:'ticket/findByAttrBizTicketState.zb', 

       		cache:false, 

       		async:false, 

        	dataType: 'json', 

         	success: function(data){ 
				ticketStates=data.extData;
				
        	} 

		});
		return ticketStates;
	}else{
		return ticketStates;
	}
}

function typeFormatter(value, row, index) {
	for(var i=0;i<ticketTypes.length;i++){
		if(value==ticketTypes[i].ticketTypeId)
			return ticketTypes[i].ticketTypeName;
	}
}
function stateFormatter(value, row, index) {
	for(var i=0;i<ticketStates.length;i++){
		if(value==ticketStates[i].ticketStateId)
			return ticketStates[i].ticketStateName;
	}
}
function dateFormatter (value, row, index) {
	if(value!=null&&value.length>10){
		value= value.substring(0,10);
	}
	return value;
}
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'列表'" style="padding:5px;background:#eee;">
<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
			 
					部门:<input id="qStockOrg" class="easyui-combotree" name="stockOrg"
								style="width: 150px;"
								data-options="
								value:'<%=sys_orgid %>',
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#qStockOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
						">
			 
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
      			<th data-options="field:'stockId',width:100,checkbox:true" ></th>
      			<!-- <th data-options="field:'stockOrg',width:100" >部门</th>   -->
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter">票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:100,formatter:stateFormatter">票卡状态</th>  
      			<th data-options="field:'ticketMoney',width:100" >票卡金额</th>  
      			<th data-options="field:'thresholdMinNumber',width:100" >库存阀值下限</th>  
      			<th data-options="field:'thresholdMaxNumber',width:100" >库存阀值上限</th> 
      			<th data-options="field:'stockUpdateDate',width:100,formatter:dateFormatter" >设置日期</th>  
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:400px;height:300px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    
    <table align="left">
    	<input type="hidden" name="stockId" value=""/>
    	
    	<tr><td>   
        <label for="stockOrg">部门:</label>   
        </td><td>
			<input id="stockOrg" class="easyui-combotree" name="stockOrg" style="width: 150px;"
								data-options="
								value:'<%=sys_orgid %>',
							url:'organ/getUserOrganTree.zb?orgType=1&1=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#stockOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
						">
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketTypeId">票卡类型:</label>   
        </td><td>
			<input id="ticketType" name="ticketTypeId" class="easyui-combobox" style="width:150px"  
			data-options="
			data:getTicketTypes(),
			valueField:'ticketTypeId',
			textField:'ticketTypeName',
			editable:false,
			required:true
			"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="ticketStateId">票卡状态:</label>   
        </td><td>
			<input name="ticketStateId" class="easyui-combobox" style="width:150px" 
			data-options="
			data:getTicketStates(),
			valueField:'ticketStateId',
			textField:'ticketStateName',
			editable:false,required:true
			"> 
       </td></tr> 
    	
		<tr><td>   
        <label for="ticketMoney">票卡金额:</label>   
        </td><td>
			<input name="ticketMoney" class="easyui-textbox" style="width:150px"> 
       </td></tr> 
				
    	<tr><td>   
        <label for="thresholdMinNumber">库存阀值下限:</label>   
        </td><td>
			<input name="thresholdMinNumber" class="easyui-textbox" style="width:150px" required=true> 
       </td></tr> 
    	<tr><td>   
        <label for="thresholdMaxNumber">库存阀值上限:</label>   
        </td><td>
			<input name="thresholdMaxNumber" class="easyui-textbox" style="width:150px" required=true> 
       </td></tr> 
				
    	
    	
				
    	<tr><td>   
        <label for="stockUpdateDate">日期:</label>   
        </td><td>
        	<input name="stockUpdateDate" class="easyui-datebox" style="width:150px" value="now()"> 
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