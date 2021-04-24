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
//console.log(jsonStr);	
$.post("ticket/saveBizTicketDeploy.zb",{jsonStr:jsonStr},function(data){
			if(data.success&&data.msg!=""){
				$.messager.alert("信息","提交成功!<br>您的调配单号为:"+data.msg,"info",function(){
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
function importData(){
var applyCode=$("#applyCode").textbox("getValue");
if(applyCode==null||applyCode==""){
	alert("请输入申请单号");
}else{
$.post("ticket/findByAttrBizTicketApply.zb",{"applyCode":applyCode},function(data){
			if(data.success){
				var row=data.extData[0];
				var formdata={};
				formdata.depolyOrg=row.toOrg;
				if(row.applyType==1){
					formdata.fromOrg=row.toOrg
					formdata.toOrg=row.applyOrg;
					formdata.toContacts=row.applyContacts;
					formdata.toPhone=row.applyPhone;
				}else{
					formdata.toOrg=row.toOrg
					formdata.fromOrg=row.applyOrg;
					formdata.fromContacts=row.applyContacts;
					formdata.fromPhone=row.applyPhone;
				}
				
				
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
				var rows=$("#dataTable").datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					var index=$("#dataTable").datagrid("getRowIndex",rows[i]);
					$("#dataTable").datagrid("beginEdit",index);
				}
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	}
}
function lianDong(newValue,oldValue) {
		//console.log("newValue is : "+newValue);
		//console.log("oldValue is : "+oldValue);
        if (newValue!=oldValue) {  
            $('#applyCode').combobox({  
                url: "ticket/findByOrgandGroupName.zb?auditingState=3&groupName=<%=groupName%>&applyType=1&toOrg=" + newValue
            });  
        }  
        
}
</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'票卡申领'" style="padding:20px;background:#eee;">
<form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="deployId" value=""/>
    	
    	<caption align="top" style="font-size:24px;color:#006600;">票卡调配单</caption> 
		<tr><td>&nbsp</td>   </tr>
		
    	<tr><td align="right">   
        <label for="depolyOrg">调配部门:</label>   
        </td><td  colspan=1>
			<input id="depolyOrg" class="easyui-combotree" name="depolyOrg"
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
						    	var tree=$('#depolyOrg').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id',
					       onChange:lianDong
					        ">
       </td>
		<!-- <td style="display: none;">   
        <label for="deployCode">调配单号:</label>   
        </td><td>
			<input name="deployCode" class="easyui-textbox" style="width:100px"  data-options="required:false,readonly:true"> 
       </td> -->
       
       <td align="right" >   
        <label for="applyCode">申请单号:</label>   
        </td><td align="left">
			<input id="applyCode"  name="applyCode" class="easyui-combobox" 
								style="width: 150px;"
								data-options="
						    url: 'ticket/findByOrgandGroupName.zb?auditingState=3&groupName=<%=groupName%>&applyType=1&toOrg=<%=sys_orgid %>',
							required:false,
							panelHeight:'auto', 
							loadFilter: function (data) { 
                				return data.extData;
            　　　　						　},
            				valueField: 'applyCode',
							textField: 'applyCode',
							onSelect:function(){
								importData();
							}">
			
		<!--	<a
				class="easyui-linkbutton" onclick="importData()"
				data-options="
			iconCls:'icon-edit',
			plain:true
		">导入申请单</a> -->
       </td>
       <td></td><td></td>
       </tr> 
				
    	<tr><td>   
        <label for="depolyContacts">调配部门联系人:</label>   
        </td><td>
			<input name="depolyContacts" class="easyui-textbox" style="width:150px"> 
       </td><td align="right">   
        <label for="depolyPhone">调配部门联系电话:</label>   
        </td><td>
			<input name="depolyPhone" class="easyui-textbox" style="width:150px"> 
       </td></tr> 
    	
				
    	<tr><td align="right">   
        <label for="fromOrg">票卡来源部门:</label>   
        </td><td  colspan=3>
			<input id="fromOrg" class="easyui-combotree" name="fromOrg"
								style="width: 150px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							panelWidth:220,
							prompt:'*必填*',
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
						    },idFiled: 'id'">
       </td></tr> 
    	
    	<tr><td>   
        <label for="fromContacts">来源部门联系人:</label>   
        </td><td>
			<input name="fromContacts" class="easyui-textbox" style="width:150px"> 
       </td><td align="right">   
        <label for="fromPhone">来源部门联系电话:</label>   
        </td><td>
			<input name="fromPhone" class="easyui-textbox" style="width:150px"> 
       </td></tr> 
    	
    	<tr><td align="right">   
        <label for="toOrg">目标部门:</label>   
        </td><td  colspan=3>
			<input id="toOrg" class="easyui-combotree" name="toOrg"
								style="width: 150px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							panelWidth:220,
							prompt:'*必填*',
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
    	
				
    	<tr><td>   
        <label for="toContacts">目标部门联系人:</label>   
        </td><td>
			<input name="toContacts" class="easyui-textbox" style="width:150px"> 
       </td><td align="right">   
        <label for="toPhone">目标部门联系电话:</label>   
        </td><td>
			<input name="toPhone" class="easyui-textbox" style="width:150px"> 
       </td></tr> 
    	
				
    	
    	<tr><td align="right">   
        <label for="description">备注:</label>   
        </td><td  colspan=3>
			<input name="description" class="easyui-textbox" style="width:406px;height:50px"> 
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
      			<!-- <th data-options="field:'depolyDetailId',width:100,checkbox:true" ></th> -->
      			<th data-options="field:'ticketTypeId',width:124,formatter:typeFormatter,editor:{type:'combobox',options:{data:getTicketTypes(),valueField:'ticketTypeId',textField:'ticketTypeName',editable:false,required:true,validType:'leixing'}}" >票卡类型</th>  
      			<th data-options="field:'ticketStateId',width:118,formatter:stateFormatter,editor:{type:'combobox',options:{data:getTicketStates(),valueField:'ticketStateId',textField:'ticketStateName',editable:false,required:true}}" >票卡状态</th>  
      			<th data-options="field:'ticketMoney',width:118,editor: { type: 'numberbox', options: { min:0,max:1000000,required: false} }" >金额</th>  
        		<th data-options="field:'ticketNumber',width:118,editor: { type: 'numberbox', options: { min:0,max:1000000,required: true,validType:'jiaoyan'} }" >数量(张/本)</th> 
      			
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