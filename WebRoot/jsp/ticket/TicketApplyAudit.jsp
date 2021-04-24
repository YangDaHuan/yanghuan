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
function doSearch(){
	var isValid =$("#queryForm").form("validate");
	if(!isValid){
		return;
	}
	var formdata=$("#queryForm").serializeArray();
	$.post("ticket/findByAuditBizTicketApply.zb",formdata,function(data){
			if(data.success){
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
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'列表'" style="padding:5px;background:#eee;">
<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
					<input type="hidden" name="auditingStates" value="1,2">
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
			<a class="easyui-linkbutton" onclick="auditBizTicketApply(3)"
				data-options="
			iconCls:'icon-ok',
			plain:true
		">通过</a> 
		<a class="easyui-linkbutton" onclick="auditBizTicketApply(4)"
				data-options="
			iconCls:'icon-del',
			plain:true
		">不通过</a> 
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'applyId',width:100,checkbox:true" ></th>
      			<th data-options="field:'applyCode',width:100" >申请单号</th>
      			<th data-options="field:'applyType',width:100,formatter:applyTypeFormatter" >申请类型</th>  
      			<!--th data-options="field:'applyOrg',width:100" >申请部门</th-->  
      			<th data-options="field:'applyContacts',width:100" >申请人</th>  
      			<th data-options="field:'applyPhone',width:100" >申请人电话</th>  
      			<!--th data-options="field:'toOrg',width:100" >目标部门</th-->  
      			<th data-options="field:'applyDate',width:100,formatter:dateFormatter" >申请日期</th>  
      			<th data-options="field:'auditingState',width:100,formatter:auditStateFormatter" >审核状态</th>  
      			<!--th data-options="field:'auditingOrg',width:100" >审核部门</th-->  
      			<!--th data-options="field:'auditingUsr',width:100" >审核人</th-->  
      			<!--th data-options="field:'description',width:100" >描述</th--> 
        		<th data-options="field:'auditingUsr',width:100,formatter:optFormatter" >操作</th>
      			
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