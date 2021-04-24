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
/**
 * 扩展校验框架，登录名唯一校验。
 */
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
		message : "回收单号已经存在"
	}
});
function addRow(){
var index=$("#dataTable").datagrid("appendRow",{ticketStateId:'1035433b623642cea57b602233e96594'}).datagrid('getRows').length-1;
$("#dataTable").datagrid("beginEdit",index);
}

$(document).ready(function(){
	  addRow();
	});

function deleteRows(){
	var rows=$("#dataTable").datagrid("getChecked");
	if(rows.length<1){
		$.messager.alert("错误","至少选择一条记录删除!","error");
	}else{
		for(var i=0;i<rows.length;i++){
			var index=$("#dataTable").datagrid("getRowIndex",rows[i]);
			$("#dataTable").datagrid("deleteRow",index);
			}
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
       		
       		data:{groupName:"<%= groupName%>"},

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
$.fn.serializeObject = function()    
{    
   var o = {};    
   var a = this.serializeArray();    
   $.each(a, function() {    
       if (o[this.name]) {    
           if (!o[this.name].push) {    
               o[this.name] = [o[this.name]];    
           }    
           o[this.name].push(this.value || '');    
       } else {    
           o[this.name] = this.value || '';    
       }    
   });    
   return o;    
};  
function submitApply(){
var isValid =$("#dataForm").form("validate");
	if(!isValid){
		$.messager.alert("错误","请填写合法的数据!","error");
		return;
	}
	var allRrows=$("#dataTable").datagrid("getRows").length;
	if(allRrows==0){
		$.messager.alert("错误","请填写合法的数据!","error");
		return;
	}
var ticketApplydata=$("#dataForm").serializeObject();
var rows=$("#dataTable").datagrid("getRows");
	for(var i=0;i<rows.length;i++){
		var index=$("#dataTable").datagrid("getRowIndex",rows[i]);
		var isValid = $("#dataTable").datagrid("validateRow",index);
		if(!isValid){
			$.messager.alert("错误","请填写合法的数据!","error");
			return;
		}
		$("#dataTable").datagrid("endEdit",index);
	}
ticketApplydata.details=	$("#dataTable").datagrid("getData").rows;
var jsonStr=JSON.stringify(ticketApplydata);
console.log(jsonStr);	
$.post("ticket/saveBizTicketApply.zb",{jsonStr:jsonStr},function(data){
			if(data.success){
				$.messager.alert("信息","提交成功!<br>您的回收单号为:"+data.msg,"info",function(){
					location=location;
	　　　　　　});
				$("#dataForm").form("clear");
				$("#dataTable").datagrid("loadData",[]);
			}else{
				$.messager.alert("错误","提交时出现系统错误!","error");
				var rows=$("#dataTable").datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					var index=$("#dataTable").datagrid("getRowIndex",rows[i]);
					$("#dataTable").datagrid("beginEdit",index);
				}
			}
			$.messager.progress("close");
		},"json");	

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
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'票卡回收'" style="padding:20px;background:#eee;">
<form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="applyId" value=""/>
    	<input name="applyType" type="hidden" value="3"> 
    	<input name="auditingState" type="hidden" value="1"> 
		<caption align="top" style="font-size:24px;color:#006600;">票卡回收单</caption> 			
    	<tr><td>&nbsp</td>   </tr>
		<!-- <tr><td><label for="applyCode">回收单号:</label>   </td> 
		<td>
			<input name="applyCode" class="easyui-textbox" style="width:150px"  data-options="required:false,readonly:true"> 
       </td>
         </tr> -->	
    	<tr><td>
        <label for="toOrg">回收部门:</label>   
        </td><td>
			<input id="toOrg" class="easyui-combotree" name="toOrg"
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
						    	var tree=$('#toOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
       </td><td>   
        <label for="applyOrg">被回收部门:</label>   
        </td><td>
			<input id="applyOrg" class="easyui-combotree" name="applyOrg"
								style="width: 150px;"
								data-options="
							url:'organ/getOrganTree.zb?orgType=1&organId=1bc8e0a662f641eaa32bd39e51f42470',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#applyOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
       </td></tr> 
		<tr>
		<td>   
        <label for="applyContacts">回收人:</label>   
        </td><td>
			<input name="applyContacts" class="easyui-textbox" style="width:150px"> 
       </td>
       <td>   
        <label for="applyPhone">回收人电话:</label>   
        </td><td>
			<input name="applyPhone" class="easyui-textbox" style="width:150px"> 
       </td>
       </tr>		
    	
       <tr>
		<td >   
        <label for="description">备注:</label>   
        </td><td  colspan=3>
			<input name="description" class="easyui-textbox" style="width:403px;height:50px"> 
       </td></tr> 
    	<tr>
    	<td colspan=8>
    	<!-- <div id="dataTabelToolBar" style="height: auto">
			<a class="easyui-linkbutton" onclick="addRow()"
				data-options="
			iconCls:'icon-add',
			plain:true
		">添加</a> 
		 <a
				class="easyui-linkbutton" onclick="deleteRows()"
				data-options="
			iconCls:'icon-del',
			plain:true
		">删除</a>
		</div> -->
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar',rownumbers:true">   
    <thead>   
        <tr>
      			<th data-options="field:'applyDetailId',width:100,checkbox:true" ></th>
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter,editor:{type:'combobox',options:{data:getTicketTypes(),valueField:'ticketTypeId',textField:'ticketTypeName',editable:false,required:true}}" >票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:100,formatter:stateFormatter,editor:{type:'combobox',options:{data:getTicketStates(),valueField:'ticketStateId',textField:'ticketStateName',editable:false,required:true}}" >票卡状态</th>  
      			 
      			<th data-options="field:'ticketMoney',width:100,editor: { type: 'numberbox', options: { min:0,max:1000000,required: false} }" >金额</th>  
        		<th data-options="field:'ticketNumber',width:100,editor: { type: 'numberbox', options: { min:0,max:1000000,required: true} }" >数量(张)</th> 
      			
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
    	
    	</td>
    	
    	</tr>	
    	<tr><td colspan=4 align="center"><a  class="easyui-linkbutton" data-options="onClick:submitApply,iconCls:'icon-ok'">提交</a>  </td></tr>
    </table>   
</form> 
</body>
</html>