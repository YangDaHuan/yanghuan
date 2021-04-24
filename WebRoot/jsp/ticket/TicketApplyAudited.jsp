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
function doSearch(){
	var isValid =$("#queryForm").form("validate");
	if(!isValid){
		return;
	}
	var formdata=$("#queryForm").serializeArray();
	$.post("ticket/findByAuditedBizTicketApply.zb",formdata,function(data){
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
		$("#report_iframe").attr('src','reportJsp/showReport.jsp?rpx=ticket/ticketApply.rpx&applyCode='+row.applyCode);
		$("#dataDialog").dialog("open");
		
	
}

function closeDialog(){
	$("#dataForm").form("clear");
	$("#dataDialog").dialog("close");
}

function applyTypeFormatter(value, row, index) {
	if(value=='1')
	{
		return "申领";
	}else{
		return "上交";
	}
}
function optFormatter(value, row, index) {
		return "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"editrow("+index+")\" title=\"查看\" class=\"icon-search\"></div>";
	}
	
function typeFormatter(value, row, index) {
	var ticketTypes = getTicketTypes();
	for(var i=0;i<ticketTypes.length;i++){
		if(value==ticketTypes[i].ticketTypeId)return ticketTypes[i].ticketTypeName;
	}
}
function stateFormatter(value, row, index) {
	var ticketStates= getTicketStates();
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
					<input type="hidden" name="auditingStates" value="2,3,4">
					
					审核部门:<input id="auditingOrg" class="easyui-combotree" name="auditingOrg"
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
						    	var tree=$('#auditingOrg').combotree('tree');
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
			
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'applyCode',width:80,align:'center'" >申请单号</th>
      			<th data-options="field:'applyType',width:60,formatter:applyTypeFormatter,align:'center'" >申请类型</th>  
      			<th data-options="field:'applyOrg',formatter:orgFormatter,width:80,align:'center'" >申请部门</th>  
      			<!-- <th data-options="field:'applyContacts',width:60,align:'center'" >申请人</th> -->  
      			<!-- <th data-options="field:'applyPhone',width:80,align:'center'" >申请人电话</th> -->  
      			<th data-options="field:'toOrg',formatter:orgFormatter,width:80,align:'center'" >目标部门</th>  
      			<th data-options="field:'applyDate',width:80,formatter:dateFormatter,align:'center'" >申请日期</th>
				<th data-options="field:'auditingDate',width:80,formatter:dateFormatter,align:'center'" >审核日期</th>
				<th data-options="field:'auditingState',width:70,formatter:auditStateFormatter,align:'center'" >审核状态</th>
      			<th data-options="field:'auditingOrg',formatter:orgFormatter,width:80,align:'center'" >审核部门</th>  
      			<th data-options="field:'auditingUsr',width:60,align:'center'" >审核人</th>  
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter,align:'center'" >票卡类型</th>
      			<th data-options="field:'ticketStateId',width:60,formatter:stateFormatter,align:'center'" >票卡状态</th>
      			<th data-options="field:'ticketMoney',width:56,align:'center'" >金额</th>
      			<th data-options="field:'ticketNumber',width:80,align:'center'" >数量</th>
      			<th data-options="field:'description',width:100" >描述</th> 
        		<!-- <th data-options="field:'applyId',width:100,formatter:optFormatter" >操作</th> -->
      			
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:800px;height:400px;padding: 0px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
        <iframe src='' id='report_iframe' class='iframeApp'	frameborder='0' SCROLLING='auto' marginwidth='0' marginheight='0' style='width: 100%; height: 100%; overflow: hidden;'></iframe>

</div>
<div id="dataDialogButtons">
<a class="easyui-linkbutton" data-options="onClick:closeDialog">关闭</a>
</div>
</body>
</html>