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

function addRow(){
var index=$("#dataTable").datagrid("appendRow",{ticketStateId:'1035433b623642cea57b602233e96594'}).datagrid('getRows').length-1;
$("#dataTable").datagrid("beginEdit",index);
}

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
		message : "出库单号已经存在"
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
console.log(jsonStr);	
$.post("ticket/saveTicketOut.zb",{jsonStr:jsonStr},function(data){
			if(data.success && data.msg!=""){
				$.messager.alert("信息","提交成功!<br>您的出库单号为:"+data.msg,"info",function(){
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
if(deployCode==null||deployCode==""){
	alert("请输入调配单号");
}else{
$.post("ticket/findByAttrBizTicketDeploy.zb",{"deployCode":deployCode},function(data){
			if(data.success){
				var row=data.extData[0];
				var formdata={};
				formdata.outOrg=row.fromOrg;
				formdata.toOrg=row.toOrg;
				formdata.deployCode=row.deployCode;
				
				
				$("#dataForm").form("load",formdata);
				//console.log(JSON.stringify(row));
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
}
function lianDong(newValue,oldValue) {
	console.log("newValue is : "+newValue);
	console.log("oldValue is : "+oldValue);
    if (newValue!=oldValue) {  
        $('#deployCode').combobox({  
            url: "ticket/findByAttrBizTicketDeploy.zb?depolyState=1&fromOrg=" + newValue  
        });  
    }  
 
}
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'票卡出库'" style="padding:20px;background:#eee;">
<form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="applyId" value=""/>
    	<input name="applyType" type="hidden" value="2"> 
    	<input name="auditingState" type="hidden" value="1"> 
		<caption align="top" style="font-size:24px;color:#006600;">票卡出库单</caption> 			
    	<tr><td>&nbsp</td>   </tr>
		<tr>
		<!-- <td>
        <label for="outCode">出库单号:</label>  
        </td> <td>
			<input name="outCode" class="easyui-textbox" style="width:150px"  data-options="required:false,readonly:true"> 
       </td> -->
       <td>
        <label for="outOrg">出库部门:</label>   
       </td> <td>
			<input id="outOrg" class="easyui-combotree" name="outOrg"
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
						    	var tree=$('#outOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
						    idFiled: 'id',
						    onChange:lianDong
						    ">
       </td>
		<td>
		<label for="deployCode">调配单号:</label>   
		</td> 
		 <td>
			<input id="deployCode"  name="deployCode" class="easyui-combobox" 
								style="width: 150px;"
								data-options="
							url:'ticket/findByAttrBizTicketDeploy.zb?depolyState=1&fromOrg=<%=sys_orgid %>', 
							required:false,
							loadFilter: function (data) { 
                					return data.extData;
            　　　　						　},
            				valueField: 'deployCode',
							textField: 'deployCode',
								onSelect:function(){
								importData();
							}">
			<!-- <a class="easyui-linkbutton" onclick="importData()" data-options="iconCls:'icon-edit',plain:true">导入调配单</a> -->
       </td></tr>	
    	<tr><td>
        <label for="toOrg">目标部门:</label>   
       </td> <td>
			<input id="toOrg" class="easyui-combotree" name="toOrg"
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
						    	var tree=$('#toOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },idFiled: 'id'">
       </td><td>   
        <label for="applyContacts">出库类型:</label>   
        </td><td>
			<select  id="outType" name="outType" class="easyui-combobox" style="width:150px;">
					 <option value="1" selected>调配出库</option>
  		 			 <option value="2">直接出库</option>
    		</select> 
       </td>
		<!-- <td >   
        <label for="description">出库日期:</label>   
        </td>
        <td>
			<input name="description" class="easyui-textbox" style="width:200px"> 
       </td> -->
       </tr> 
       <tr><td>   
        <label for="description">备注:</label>   
        </td><td  colspan=3>
			<input name="description" class="easyui-textbox" style="width:403px;height:50px"> 
       </td></tr> 
       
    	<tr>
    	<td colspan=8>
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
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar',rownumbers:true">   
    <thead>   
        <tr>
      			<th data-options="field:'applyDetailId',width:100,checkbox:true" ></th>
      			<th data-options="field:'ticketTypeId',width:100,formatter:typeFormatter,editor:{type:'combobox',options:{data:getTicketTypes(),valueField:'ticketTypeId',textField:'ticketTypeName',editable:false,required:true}}" >票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:100,formatter:stateFormatter,editor:{type:'combobox',options:{data:getTicketStates(),valueField:'ticketStateId',textField:'ticketStateName',editable:false,required:true}}" >票卡状态</th>  
      			 
      			<th data-options="field:'ticketMoney',width:100,editor: { type: 'numberbox', options: { min:0,max:1000000,required: false} }" >金额</th>  
        		<th data-options="field:'ticketNumber',width:100,editor: { type: 'numberbox', options: { min:0,max:1000000,required: true} }" >数量</th> 
      			
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