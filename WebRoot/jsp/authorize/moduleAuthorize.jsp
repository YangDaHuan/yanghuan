<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<!DOCTYPE html>
<html>
<head>
<title>模块授权</title>
<jsp:include page="../common.jsp" />

<script type="text/javascript">
var moduleIds;
$(document).ready(function(){
	loadModule();

});
/**
 * 加载当前角色能授权的模块
 */
function loadModule(){
	$.post("module/getModuleListByUser.zb?",{},function(data){
		if(data){
			var newData={};
			newData.total=data.length;
			newData.rows=data;
			for(var i=0;i<newData.total;i++){
				newData.rows[i]._parentId=newData.rows[i].parentId;
			}
			$("#moduleTree").treegrid({
				data:newData
			});
			
		}else{
			$.messager.alert("错误","加载数据时出现系统错误!","error");
		}
		
	},"json");
	
	
}
//格式化功能授权列
function formatterFuns(value,rowData,rowIndex){
	if(rowData.url==null||rowData.url=="")return "";
	var htmlStr="<form id='"+rowData.id+"FunForm'>";
	for(var i=0;i<value.length;i++){
		var fun=value[i];
		htmlStr+="&nbsp;"+fun.funName+":";
		htmlStr+="<select name='"+fun.funCode+"' class='easyui-combobox'>";
		var options=fun.options;
		for(var j=0;j<options.length;j++){
			htmlStr+="<option value='"+options[j].itemCode+"'>"+options[j].itemName+"</option>";
		}
		htmlStr+="</select>";
		
	}
	htmlStr+="</form>";
	return htmlStr;
}
//通过点击左侧 模块勾选右侧角色树
function checkRoleTree(row){
	var checkedNodes=$("#roleTree").tree("getChecked");
	for(var i=0;i<checkedNodes.length;i++){
		$("#roleTree").tree("uncheck",checkedNodes[i].target);
	}
	if(row.url==null||row.url==''){
		$("#btnAdd").linkbutton("disable");
		return;
	}
	var funForm=$("#"+row.id+"FunForm :input").serialize();
	$.post("role/getRoleListByModule.zb?",{moduleId:row.id,funForm:funForm},function(data){
		if(data){
			for(var i=0;i<data.length;i++){
				var node=$("#roleTree").tree("find",data[i].id);
				if(node!=null){
					$("#roleTree").tree("check",node.target);
				}
				
			}
			$("#btnAdd").linkbutton("enable");
			
			
		}else{
			$.messager.alert("错误","加载数据时出现系统错误!","error");
		}
		
	},"json");
	
}

/**
 * 保存授权信息
 */
function saveAuth(){
	
	var row = $("#moduleTree").treegrid("getSelected");
	var funForms=$("#"+row.id+"FunForm :input").serialize();
	var roleIds = "";
	var nodes = $("#roleTree").tree("getChecked");
	moduleIds=row.id;
	getParentModules(row.id);
	if(nodes){
		for(var i=0; i<nodes.length; i++){
			if(nodes[i].isLeaf=='1'){
				roleIds += nodes[i].id+",";
			}
			
		}	
	}
	
	var param = {
		roleId:roleIds,
		useModules:	moduleIds,
		funForms: funForms
	}
	var url = "authorize/saveModuleAuthorize.zb";
	$.post(url,param,function(res){
		if(res.success){
			$.noty.closeAll();
			var n = noty({
				text: "授权成功。",
				type:"success",
				layout:"topCenter",
				timeout:1000
			});				
		}else{
			$.messager.alert('BTP',"模块授权失败。");
		}
	},"json");
}
//获得上级模块
function getParentModules(id){
	var parent =$("#moduleTree").treegrid('getParent',id);
	if(parent!=null){  
        var parentId = parent.id;
        moduleIds+=','+parentId;
        getParentModules(parentId);
        
    }
    
}
//格式化角色树
function formatTree(node, data){
	for(var i=0;i<data.length;i++){
		formatNode(data[i]);
	}
}
function formatNode(nodeData){
	var iconCls="";
	if(nodeData.isLeaf=='1'){
		iconCls="roleNode";
	}else{
		iconCls="organNode";
	}
	node=$('#roleTree').tree('find',nodeData.id);
	$('#roleTree').tree('update', {
		target: node.target,
		iconCls:iconCls
	});
	var childs=nodeData.children;
	if(childs){
		for(var i=0;i<childs.length;i++){
			formatNode(childs[i]);
		}
	}
}
</script>
</head>

<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'功能模块',width:500">

		<table id="moduleTree" class="easyui-treegrid"
			data-options="
			fit:true,
			singleSelect:true,
			checkOnSelect:false,
			selectOnCheck:false,
			treeField:'moduleName',
			idField: 'id',
			onClickRow:checkRoleTree,
			rownumbers:true
		">
			<thead>
				<tr>
					<th data-options="field:'moduleName'">模块树</th>

					<th data-options="field:'funs',formatter:formatterFuns">功能授权</th>

				</tr>
			</thead>


		</table>
	</div>
	<div style="width: 200px;"
		data-options="title:'角色',region:'center',	split:true,collapsible:false">
		<div class="datagrid-toolbar">
			<a id="btnAdd" onclick="saveAuth()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-save',disabled:true"> 保存
			</a>
		</div>
		<!-- 组织机构角色树 -->

		<ul id="roleTree" class="easyui-tree"
			data-options="
			url: 'role/getRoleTree.zb?organId=${organId}',
			checkbox:true,
			onLoadSuccess:formatTree,
			customAttr:{
	            dataModel: 'simpleData',
	            textField: 'text',
	            parentField: 'parentId'
        	}
        	
		"></ul>
	</div>
</body>
</html>
