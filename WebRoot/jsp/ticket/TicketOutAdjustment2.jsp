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

function addRow(){
var index=$("#dataTable").datagrid("appendRow",{ticketStateId:'1035433b623642cea57b602233e96594'}).datagrid('getRows').length-1;
$("#dataTable").datagrid("beginEdit",index);
}
$(document).ready(function(){
	  addRow();
	});
$.extend($.fn.validatebox.defaults.rules, {
	checkOutCode : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "ticket/isOutCodeExist.zb",
				dataType : "json",
				data : {
					outCode : value
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp != "true";
		},
		message : "调整单号已经存在"
	}
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

var ticketType;
$.extend($.fn.validatebox.defaults.rules, {  
	leixing: {    
	    validator: function(value,param){ 
	    		 ticketType = value;
	    		 return  true; 
	    },    
	    message: ''   
	}
});

$.extend($.fn.validatebox.defaults.rules, {  
		jiaoyan: {    
		    validator: function(value,param){ 
		    	if( ticketType=='一卡通普通储值卡'){
		    		$.fn.validatebox.defaults.rules.jiaoyan.message ="请输入2000的整数倍";
		    		 return  value % 2000 == 0; 
		    	}else if(ticketType.indexOf("发票")!=-1){
		    		$.fn.validatebox.defaults.rules.jiaoyan.message ="请输入200的整数倍";
		    		return value % 200 == 0;
		    	}else if(ticketType=='本地互通卡'){
		    		$.fn.validatebox.defaults.rules.jiaoyan.message ="请输入100的整数倍";
		    		return value % 100 == 0;
		    	}else if(ticketType=='单程票'){
		    		$.fn.validatebox.defaults.rules.jiaoyan.message ="请输入2000的整数倍";
		    		 return  value % 2000 == 0; 
		    	}else if(ticketType=='预赋值单程票'){
		    		$.fn.validatebox.defaults.rules.jiaoyan.message ="请输入2000的整数倍";
		    		 return  value % 2000 == 0; 
		    	}else{
		    		return true;
		    	}
		    },    
		    message: ''
		}
	}); 
	
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
function submitTicketOut(){
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
var ticketOutdata=$("#dataForm").serializeObject();
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
ticketOutdata.details=	$("#dataTable").datagrid("getData").rows;
var jsonStr=JSON.stringify(ticketOutdata);
$.post("ticket/saveTicketOut.zb",{jsonStr:jsonStr},function(data){
	if(data.success&&data.msg!=""){
		$.messager.alert("信息","提交成功!<br>您的入库单号为:"+data.msg,"info",function(){
		　　　　　　location=location;
	　　　　　　});
				$("#dataForm").form("clear");
				$("#dataTable").datagrid("loadData",[]);
			}else if(data.success && data.msg==""){
				$.messager.alert("错误","库存不足","error");
				var rows=$("#dataTable").datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					var index=$("#dataTable").datagrid("getRowIndex",rows[i]);
					$("#dataTable").datagrid("beginEdit",index);
				}
			}
			else{
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

function importData(){
var deployCode=$("#deployCode").textbox("getValue");
$.post("ticket/findByAttrBizTicketDeploy.zb",{"deployCode":deployCode},function(data){
			if(data.success){
				var row=data.extData[0];
				var formdata={};
				formdata.outOrg=row.fromOrg;
				formdata.toOrg=row.toOrg;
				formdata.deployCode=row.deployCode;
				
				
				$("#dataForm").form("load",formdata);
				var details=new Array();
				for(var i=0;i<row.details.length;i++){
					var detail={};
					detail.ticketTypeId=row.details[i].ticketTypeId;
					detail.ticketStateId=row.details[i].ticketStateId;
					detail.ticketNumber=row.details[i].ticketNumber;
					detail.ticketMoney=row.details[i].ticketMoney;
					
					details.push(detail);
				}
				$("#dataTable").datagrid("loadData",details);
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
}
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'票卡调整'" style="padding:20px;background:#eee;">
<form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="applyId" value=""/>
    	<input name="applyType" type="hidden" value="2"> 
    	<input name="auditingState" type="hidden" value="1"> 
		<caption align="top" style="font-size:24px;color:#006600;">调整出库</caption> 			
    	<tr><td>&nbsp</td>   </tr>
		<tr>
		<%-- <td>
        <label for="outCode">调整单号:</label>  
        </td> 
        <td>
			<input name="outCode" class="easyui-textbox" style="width:150px" value="${newTicketOutCode }" data-options="required:true,readonly:true"> 
       </td> --%>
    	<td>
        <label for="outOrg">调整部门:</label>   
       </td> <td>
			<input id="outOrg" class="easyui-combotree" name="outOrg"
								style="width: 150px;"
								data-options="
								value:'<%=sys_orgid %>',
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							panelWidth:220,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#outOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },idFiled: 'id'">
       </td>
		<!-- <td>
			<input type="hidden" name="outType" value="3"/>
		</td> -->
		 <td>   
        <label for="applyContacts">调整类型:</label>  
			<select  id="outType" name="outType" class="easyui-combobox" style="width:150px;">
					 <option value="3" selected>调整出库</option>
  		 			 <option value="5">丢失出库</option>
    		</select>
       </td>
		<!-- <td >   
        <label for="description">调整日期:</label>   
        </td>
        <td>
			<input name="description" class="easyui-textbox" style="width:200px"> 
       </td> -->
       </tr> 
       <tr><td>   
        <label for="description">备注:</label>   
        </td><td  colspan=3>
			<input name="description" class="easyui-textbox" style="width:436px;height:50px"> 
       </td></tr> 
       
    	<tr>
    	<td colspan=8>
    	<!-- 
    		<div id="dataTabelToolBar" style="height: auto">
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
		</div>
    	 -->
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar',rownumbers:true">   
    <thead>   
        <tr>
      			<!-- <th data-options="field:'applyDetailId',width:100,checkbox:true" ></th> -->
      			<th data-options="field:'ticketTypeId',width:117,formatter:typeFormatter,editor:{type:'combobox',options:{data:getTicketTypes(),valueField:'ticketTypeId',textField:'ticketTypeName',editable:false,required:true,validType:'leixing'}}" >票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:115,formatter:stateFormatter,editor:{type:'combobox',options:{data:getTicketStates(),valueField:'ticketStateId',textField:'ticketStateName',editable:false,required:true}}" >票卡状态</th>  
      			
      			<th data-options="field:'ticketMoney',width:115,editor: { type: 'numberbox', options: { min:0,max:1000000,required: false} }" >金额</th>  
        		<th data-options="field:'ticketNumber',width:115,editor: { type: 'numberbox', options: { min:0,max:1000000,required: true,validType:'jiaoyan'} }" >数量(张/本)</th> 
      			
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
    	
    	</td>
    	
    	</tr>	
    	<tr><td colspan=4 align="center"><a  class="easyui-linkbutton" data-options="onClick:submitTicketOut,iconCls:'icon-ok'">提交</a>  </td></tr>
    </table>   
</form> 
</body>
</html>