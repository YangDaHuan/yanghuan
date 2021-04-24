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

var orgName; 
function getOrgName(){
	if(orgName==null){
		$.ajax({ 

        	type: "post", 

       		url:'organ/findOrgs.zb', 

       		cache:false, 

       		async:false, 

        	dataType: 'json', 

         	success: function(data){ 
         		orgName=data.extData;
				
        	} 

		});
		return orgName;
	}else{
		return orgName;
	}
}

function deployTypeFormatter(value, row, index) {
	if(value=='1')
	{
		return "调配中";
	}else if(value=='2'){
		return "已出库";
	}else{
		return "已入库";
	}
}
function doSearch(){
	var isValid =$("#queryForm").form("validate");
	if(!isValid){
		return;
	}
	var formdata=$("#queryForm").serializeArray();
	$.post("ticket/findByAboutBizTicketDeploy.zb",formdata,function(data){
			if(data.success){
				var tableData = data.extData;
				for(var i = 0;i<data.extData.length;i++){
					tableData[i].ticketTypeId=data.extData[i].details[0].ticketTypeId;
					tableData[i].ticketStateId=data.extData[i].details[0].ticketStateId;
					tableData[i].ticketNumber=data.extData[i].details[0].ticketNumber;
					tableData[i].ticketMoney=data.extData[i].details[0].ticketMoney;
				}
				$("#dataTable").datagrid("loadData",data.extData);
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
}
function editrow(index){
		$("#dataTable").datagrid("selectRow",index);
		var row=$("#dataTable").datagrid("getSelected");
		$("#dataForm").form("load",row);
		$("#detailTable").datagrid("loadData",row.details);
		$("#dataDialog").dialog("open");
		
	
}

function closeDialog(){
	$("#dataForm").form("clear");
	$("#dataDialog").dialog("close");
}

function optFormatter(value, row, index) {
		return "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"editrow("+index+")\" title=\"查看\" class=\"icon-search\"></div>";
	}
	
function typeFormatter(value, row, index) {
	for(var i=0;i<ticketTypes.length;i++){
		if(value==ticketTypes[i].ticketTypeId)return ticketTypes[i].ticketTypeName;
	}
}
function stateFormatter(value, row, index) {
	for(var i=0;i<ticketStates.length;i++){
		if(value==ticketStates[i].ticketStateId)return ticketStates[i].ticketStateName;
	}
}

function auditStateFormatter (value, row, index) {
	var auditStates=[{stateId:1,stateName:'已提交'},{stateId:2,stateName:'审核中'},{stateId:3,stateName:'审核通过'},{stateId:4,stateName:'审核未通过'},];
	for(var i=0;i<auditStates.length;i++){
		if(value==auditStates[i].stateId)return auditStates[i].stateName;
	}
}
function dateFormatter (value, row, index) {
	if(value!=null&&value.length>10){
		value= value.substring(0,10);
	}
	return value;
}
function auditBizTicketApply(auditingState){
	var auditingOrg = $("#auditingOrg").combotree("getValue");
	var obj={"auditingState":auditingState,"auditingOrg":auditingOrg};
    var rows=$("#dataTable").datagrid("getChecked");
	if(rows.length<1){
		$.messager.alert("错误","至少选择一条记录审核!","error");
	}else{
			
        		var applyIds=new Array();
				var toOrgs=new Array();
				for(var i=0;i<rows.length;i++){
					applyIds.push(rows[i].applyId);
					toOrgs.push(rows[i].toOrg);
				}
				obj.applyIds=applyIds;
				obj.toOrgs=toOrgs;
		
		
		
		$.post("ticket/auditBizTicketApply.zb",obj,function(data){
			if(data.success){
				$.messager.alert("信息","审核成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","审核结果保存时出现系统错误!","error");
			}
						
		},"json");
		
	}
	
}
function orgFormatter(value, row, index){
	var orgName = getOrgName();
	for(var i=0;i<orgName.length;i++){
		if(value==orgName[i].id)return orgName[i].organName;
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
					调配单号:<input name="deployCode" class="easyui-textbox" style="width:100px"> 
					申请单号:<input name="applyCode" class="easyui-textbox" style="width:100px"> 
					调配单状态:<input name="depolyState" class="easyui-textbox" style="width:100px"> 
					我的部门:<input id="depolyOrgQ" class="easyui-combotree" name="depolyOrg"
								style="width: 200px;"
								data-options="
								value:'<%=sys_orgid %>',
								required:false,
								panelWidth:220,
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#depolyOrgQ').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'">
					调配日期:<input name="depolyDate" class="easyui-datebox" style="width:100px"> 
					
        			
					
			 <a onclick="doSearch()" class="easyui-linkbutton"
					data-options="
						iconCls:'icon-search',
						plain:true
					">查询</a>
					</form>
			</div>
			
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'deployCode',width:80,align:'center'" >调配单号</th>  
      			<th data-options="field:'applyCode',width:80,align:'center'" >申请单号</th>  
      			<th data-options="field:'fromOrg',formatter:orgFormatter,width:80,align:'center'" >来源部门</th> 
      			<th data-options="field:'toOrg',formatter:orgFormatter,width:80,align:'center'" >目标部门</th>
      			<th data-options="field:'depolyOrg',formatter:orgFormatter,width:80,align:'center'" >调配部门</th>
      			<th data-options="field:'depolyState',width:100,formatter:deployTypeFormatter,align:'center'" >调配单状态</th>
      			<th data-options="field:'depolyDate',width:100,align:'center'" >调配日期</th>  
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter,align:'center'" >票卡类型</th>
      			<th data-options="field:'ticketStateId',width:60,formatter:stateFormatter,align:'center'" >票卡状态</th>
      			<th data-options="field:'ticketMoney',width:56,align:'center'" >金额</th>
      			<th data-options="field:'ticketNumber',width:80,align:'center'" >数量</th>
      			<th data-options="field:'description',width:100" >描述</th>
        		<!-- <th data-options="field:'deployId',width:100,formatter:optFormatter" >操作</th> -->
      			
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:620px;height:500px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    
    <table align="center">
    	<input type="hidden" name="deployId" value=""/>
    	
				
    	<caption align="top" style="font-size:24px;color:#006600;">票卡调配单</caption> 
		<tr><td>&nbsp</td>   </tr><tr><td align="right">   
        <label for="deployCode">调配单号:</label>   
        </td><td>
			<input name="deployCode" class="easyui-textbox" style="width:100px"> 
       </td><td align="right">   
        <label for="applyCode">申请单号:</label>   
        </td><td>
			<input name="applyCode" class="easyui-textbox" style="width:100px"> 
			
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="depolyOrg">调配部门:</label>   
        </td><td  colspan=3>
			<input id="depolyOrg" class="easyui-combotree" name="depolyOrg"
								style="width: 200px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#depolyOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'">
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="depolyContacts">调配部门联系人:</label>   
        </td><td>
			<input name="depolyContacts" class="easyui-textbox" style="width:100px"> 
       </td><td align="right">   
        <label for="depolyPhone">调配部门联系电话:</label>   
        </td><td>
			<input name="depolyPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="fromOrg">来源部门:</label>   
        </td><td  colspan=3>
			<input id="fromOrg" class="easyui-combotree" name="fromOrg"
								style="width: 200px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#fromOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="fromContacts">来源部门联系人:</label>   
        </td><td>
			<input name="fromContacts" class="easyui-textbox" style="width:100px"> 
       </td><td align="right">   
        <label for="fromPhone">来源部门联系电话:</label>   
        </td><td>
			<input name="fromPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="toOrg">目标部门:</label>   
        </td><td  colspan=3>
			<input id="toOrg" class="easyui-combotree" name="toOrg"
								style="width: 200px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#toOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="toContacts">目标部门联系人:</label>   
        </td><td>
			<input name="toContacts" class="easyui-textbox" style="width:100px"> 
       </td><td align="right">   
        <label for="toPhone">目标部门联系电话:</label>   
        </td><td>
			<input name="toPhone" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	
    	<tr><td align="right">   
        <label for="description">备注:</label>   
        </td><td  colspan=3>
			<input name="description" class="easyui-textbox" style="width:300px;height:50px"> 
       </td></tr> 
    	<tr>
    	<td colspan=8>
    	
	<table id="detailTable" class="easyui-datagrid" data-options="rownumbers:true">   
    <thead>   
        <tr>
      			<th data-options="field:'applyDetailId',width:100,checkbox:true" ></th>
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter,editor:{type:'combobox',options:{data:getTicketTypes(),valueField:'ticketTypeId',textField:'ticketTypeName',editable:false,required:true}}" >票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:100,formatter:stateFormatter,editor:{type:'combobox',options:{data:getTicketStates(),valueField:'ticketStateId',textField:'ticketStateName',editable:false,required:true}}" >票卡状态</th>  
      			<th data-options="field:'ticketMoney',width:100,editor: { type: 'validatebox', options: { required: false} }" >金额</th>  
        		<th data-options="field:'ticketNumber',width:100,editor: { type: 'validatebox', options: { required: true} }" >数量</th> 
        		
      			
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
    	
    	</td>
    	
    	</tr>	
    	</table>  
</form>   
</div>
<div id="dataDialogButtons">
<a class="easyui-linkbutton" data-options="onClick:closeDialog">关闭</a>
</div>
</body>
</html>