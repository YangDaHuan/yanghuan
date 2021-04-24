<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<!DOCTYPE html>
<html>
<head>
<title>角色授权</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
$(document).ready(function(){
	loadModule();

});	
	/**
	 * 点击角色列表中的角色时加载角色的模块
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
	
	/**
	 * 加载角色当前被授权的模块，将已经授权的模块在模块树中勾上
	 */
	
	function loadRoleModule(node){
		unchecktreegrid("#moduleTree","id");
		if(node.isLeaf!="1"){
			$("#btnAdd").linkbutton("disable");
			return;
		}
		$("#btnAdd").linkbutton("enable");
		$.ajax({
			url: "module/getUseModuleList.zb?roleId="+node.id,
			type: 'post',
			dataType:'json',
			success: function(res){
				$("#moduleTree").show();
				$("#btnAdd").linkbutton("enable");
				if(res.success) {
					var modules =res.extData;
					for(var i=0;i<modules.length;i++){
						var node = $("#moduleTree").treegrid('find', modules[i].id);
						if(node){
							node.checked=true;
							$("#"+node.id).attr("checked",true);
							
							var funs=modules[i].funs;
							for(var j=0;j<funs.length;j++){
								$("#"+node.id+"FunForm select[name="+funs[j].funCode+"]").val(funs[j].funValue);
							}
								
						}
					}
				}else{
					$.messager.alert("错误","系统内部错误");
				}
			}
		});
	}
	
	/**
	 * 保存授权信息
	 */
	function saveAuth(){
		
		var row = $("#roleTree").tree("getSelected");
		if(row==null){
			$.messager.alert('错误',"必须选择一个角色。");
			return;

		}
		var moduleUse = "";
		var funForms="";
		var nodes = getTreeGridChecked("#moduleTree");
		
		if(nodes){
			for(var i=0; i<nodes.length; i++){
				moduleUse += nodes[i].id+",";
				funForms+=$("#"+nodes[i].id+"FunForm :input").serialize()+",";
				
			}	
		}
		var param = {
			roleId:row.id,
			useModules:	moduleUse,
			funForms: funForms
		}
		var url = "authorize/save.zb";
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
	
	
	function onTreeGridCheck(target,id,checked){
		var opts = $(target).treegrid("options");  
		var idField = opts.idField;
		
		var row=$(target).treegrid("find",id);
		row.checked=checked;
		selectChildren(target,id,idField,checked);
		selectParent(target,id,idField,checked);
		
	}
	function selectParent(target,id,idField,checked){  
         var parent = $(target).treegrid('getParent',id);
         
         if(parent){  
             var parentId = parent[idField];  
             if(checked){  
            	 parent.checked=true;  
            	 $("#"+parentId).attr("checked",true);
             }else{  
            	 var childrens=$(target).treegrid('getChildren',parentId); 
            	 var childChecked=false;
            	 for(var i=0;i<childrens.length;i++){
            		 if(childrens[i].checked){
            			 childChecked=true;
            		 }
            	 }
            	 if(!childChecked){
            		 parent.checked=false;
            		 $("#"+parentId).attr("checked",false);
            	 }
             }
             selectParent(target,parentId,idField,checked);  
         }  
     }  
	function selectChildren(target,id,idField,checked){  
        var childrens = $(target).treegrid('getChildren',id);
        for(var i=0;i<childrens.length;i++){
        	var childId=childrens[i][idField];
        	childrens[i].checked=checked;
        	$("#"+childId).attr("checked",checked);
        	var isParent = $(target).treegrid('getChildren',childId);
        	if(isParent){
        		selectChildren(target,childId,idField,checked);
        	}

      	 }
        
    } 
	function formatterTreeCheckBox(value,rowData,rowIndex){
		return "<input id='"+rowData.id+"' name='checkBox' value='0' type='checkbox' onclick=\"onTreeGridCheck('#moduleTree','"+rowData.id+"',this.checked)\">"+rowData.moduleName;
		
	}
	function getTreeGridChecked(target){
		var checked=new Array();
		$(target).treegrid('selectAll');
		var rows=$(target).treegrid('getSelections');
		
		
		for(var i=0;i<rows.length;i++){
			if(rows[i].checked){
				checked.push(rows[i]);
			}
		}
		$(target).treegrid('unselectAll');
		return checked;
	}
	//取消选中模块树形表格
	function unchecktreegrid(target,idField){
		var checkedNodes=getTreeGridChecked(target);
		for(var i=0;i<checkedNodes.length;i++){
			var id=checkedNodes[i][idField];
			var row=$(target).treegrid("find",id);
			row.checked=false;
			$("#"+id).attr("checked",false);
		}
	}
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
	<input id="roleId" type="hidden" />
	<!-- 左侧组织机构角色树 -->
	<div style="width: 200px;"
		data-options="title:'角色',region:'west',	split:true,collapsible:false">
		<!-- 组织机构角色树 -->

		<ul id="roleTree" class="easyui-tree"
			data-options="
			url: 'role/getRoleTree.zb?organId=${organId}',
			onLoadSuccess:formatTree,
			onClick:loadRoleModule,
			customAttr:{
	            dataModel: 'simpleData',
	            textField: 'text',
	            parentField: 'parentId'
        	}
        	
		"></ul>

	</div>
	<!-- 右侧授权信息，采用嵌套布局 -->
	<div data-options="region:'center',title:'功能模块'">
		<div class="datagrid-toolbar">
			<a id="btnAdd" onclick="saveAuth()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-save',disabled:true"> 保存
			</a>
		</div>
		<table id="moduleTree" class="easyui-treegrid"
			data-options="
					fit:true,
					singleSelect:true,
					checkOnSelect:false,
					selectOnCheck:false,
					treeField:'moduleName',
					idField: 'id',
					rownumbers:true
				">
			<thead>
				<tr>
					<th
						data-options="field:'moduleName',formatter:formatterTreeCheckBox">模块树</th>

					<th data-options="field:'funs',formatter:formatterFuns">功能授权</th>

				</tr>
			</thead>


		</table>

	</div>
</body>
</html>