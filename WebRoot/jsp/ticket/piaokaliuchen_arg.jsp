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
	String groupName = request.getParameter("groupName");
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
	$.post("ticket/findByAuditBizTicketApply.zb?groupName=<%=groupName%>",formdata,function(data){
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
	}else if(value=='2'){
		return "上交";
	}else{
		return "回收";
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

<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
			
					<input type="hidden" name="auditingStates" value="1,2">
					部门:<input id="Org" class="easyui-combotree" name="bm"
								style="width: 150px;"
								data-options="
								value:'<%=sys_orgid %>',
							url:'organ/getUserOrganTree.zb?orgType=1',
							panelWidth:220,
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#Org').combotree('tree');
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

</body>
</html>