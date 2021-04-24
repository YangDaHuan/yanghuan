<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>模块功能参数管理</title>
<jsp:include page="../common.jsp" />
<script>
/**
 * 扩展校验框架，校验创建或者修改时，不能够在字典上创建子类别
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkDictType : {
		validator : function(value, param) {
			var t = $("#dictCode").combotree("tree");
			var n = t.tree("getSelected");
			if (n.attributes.dictType == "1") {
				return true;
			}
			return false;
		},
		message : "必须选择字典，不能选择字典类型"
	}
});
/**
 * 扩展校验框架，增加模块组名称校验。模块组名称应该唯一。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkFunGroupName : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "moduleFun/checkFunGroupName.zb",
				dataType : "json",
				data : {
					name : value,
					id : $("#funGroupId_").val(),
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp == "true";
		},
		message : "功能组名称已经存在"
	}
});

/**
 * 扩展校验框架，增加模块编码校验。机构编码应该唯一。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkFunGroupCode : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "moduleFun/checkFunGroupCode.zb",
				dataType : "json",
				data : {
					code : value,
					id : $("#funGroupId_").val(),
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp == "true";
		},
		message : "功能组编码已经存在"
	}
});
function openAddGroupDialog(){
	$("#funGroupForm").form("reset");
	$("#funGroupCode").textbox("readonly",false);
	$("#funGroupId_").val("");
	$("#groupFormDlg").dialog({
		title:"新增功能组",
		iconCls:"icon-add"
		});
	$("#groupFormDlg").dialog("open");
}
function openEditFunGroupDialog(index){
	$("#funGroupTable").datagrid("selectRow",index);
	var row=$("#funGroupTable").datagrid("getSelected");
	$("#funGroupId_").val(row.id);
	$("#funGroupForm").form("load",row);
	$("#funGroupCode").textbox("readonly",true);
	$("#groupFormDlg").dialog({
		title:"编辑功能组",
		iconCls:"icon-edit"
		});
	$("#groupFormDlg").dialog("open");
}



function boolFormatter(value,row,index){
	if(value=="1"){
		return "是";
	}else{
		return "否";
	}
}

function funGroupFormatter(value,row,index){
	var s =  " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditFunGroupDialog("+index+")\"></div>";
    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteModuleFunGroup('"+row.funGroupCode+"')\"></div>";
    return s;
}

function saveFunGroup(){
	
	$("#funGroupForm").form("submit", {
		//提交前验证
		onSubmit : function() {
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			var isValid = $(this).form("validate");
			if (!isValid) {
				$.messager.progress("close");
			}
			return isValid;
		},
		//提交成功
		success : function(result) {
			result = $.parseJSON(result);
			$.messager.progress("close");
			//操作成功,关闭对话框，显示提示信息，并重新加载功能组表格。
			if (result.success) {
				$("#groupFormDlg").dialog("close");
				$("#funGroupTable").datagrid("reload");//重新加载功能组表格
				$.noty.closeAll();
				var n = noty({
					text : "操作成功",
					type : "success",
					layout : "topCenter",
					timeout : 1000
				});
			} else {//保存失败
				$.noty.closeAll();
				var n = noty({
					text : result.msg,
					type : "warning",
					layout : "topCenter",
					timeout : 1500
				});
			}
		}
	});
}


/**
 * 扩展校验框架，增加模块组名称校验。模块组名称应该唯一。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkFunName : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "moduleFun/checkFunName.zb",
				dataType : "json",
				data : {
					name : value,
					id : $("#funId_").val(),
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp == "true";
		},
		message : "功能组名称已经存在"
	}
});

/**
 * 扩展校验框架，增加模块编码校验。机构编码应该唯一。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkFunCode : {
		validator : function(value, param) {
			var resp = $.ajax({
				url : "moduleFun/checkFunCode.zb",
				dataType : "json",
				data : {
					code : value,
					id : $("#funId_").val(),
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp == "true";
		},
		message : "功能组编码已经存在"
	}
});
function openAddFunDialog(){
	var row=$("#funGroupTable").datagrid("getSelected");
	if(row==null){
		$.messager.alert("错误","必须选择一个功能组后新增功能"); 
		return;
	}
	$("#funForm").form("reset");
	$("#funCode").textbox("readonly",false);
	$("#funId_").val("");
	$("#funGroupCode_").val(row.funGroupCode);
	
	
	$("#funFormDlg").dialog({
		title:"新增功能",
		iconCls:"icon-add"
		});
	$("#funFormDlg").dialog("open");
}
function openEditFunDialog(index){
	$("#funFormDlg").dialog({
		title:"编辑功能组",
		iconCls:"icon-edit"
		});
	$("#funFormDlg").dialog("open");
	$("#funTable").datagrid("selectRow",index);
	var row=$("#funTable").datagrid("getSelected");
	$("#funId_").val(row.id);
	$("#funForm").form("load",row);
	$("#funCode").textbox("readonly",true);
}


function funFormatter(value,row,index){
	
    var s =  " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditFunDialog("+index+")\"></div>";
    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteModuleFun('"+row.funCode+"')\"></div>";
    return s;
}

function saveModuleFun(){
	
	$("#funForm").form("submit", {
		//提交前验证
		onSubmit : function() {
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			var isValid = $(this).form("validate");
			if (!isValid) {
				$.messager.progress("close");
			}
			return isValid;
		},
		//提交成功
		success : function(result) {
			result = $.parseJSON(result);
			$.messager.progress("close");
			//操作成功,关闭对话框，显示提示信息，并重新加载功能组表格。
			if (result.success) {
				$("#funFormDlg").dialog("close");
				$("#funTable").datagrid("reload");//重新加载功能组表格
				$.noty.closeAll();
				var n = noty({
					text : "操作成功",
					type : "success",
					layout : "topCenter",
					timeout : 1000
				});
			} else {//保存失败
				$.noty.closeAll();
				var n = noty({
					text : result.msg,
					type : "warning",
					layout : "topCenter",
					timeout : 1500
				});
			}
		}
	});
}
//功能组列表排序
function sortModuleFunGroup(targetRow,sourceRow,point){
	var rows=$(this).datagrid("getRows");
	var id="";
	for(var i=0; i<rows.length; i++){
		id+=rows[i].id+",";	
		
	}
		
	id = id.substring(0, id.length-1);
	$.messager.confirm("提示", "您确认要排序吗?", function(r){
		if (!r){
			return;
		}
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		$.post("moduleFun/sortModuleFunGroup.zb",{id:id},function(data){
			if(data.success){
				var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
				
			}else{
				$.messager.alert("错误","更新数据时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	});
}
//功能列表排序
function sortModuleFun(targetRow,sourceRow,point){
	var rows=$(this).datagrid("getRows");
	var id="";
	for(var i=0; i<rows.length; i++){
		id+=rows[i].id+",";	
		
	}
		
	id = id.substring(0, id.length-1);
	$.messager.confirm("提示", "您确认要排序吗?", function(r){
		if (!r){
			return;
		}
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		$.post("moduleFun/sortModuleFun.zb",{id:id},function(data){
			if(data.success){
				var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
			
				
			}else{
				$.messager.alert("错误","更新数据时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	});
}
//删除模块功能
function deleteModuleFun(funCode){
	$.messager.confirm("提示", "删除模块功能同时会删除该功能授权，您确认要删除吗?", function(r){
		if (!r){
			return;
		}
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		$.post("moduleFun/deleteModuleFunByCode.zb",{funCode:funCode},function(data){
			if(data.success){
				var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
				$("#funTable").datagrid("reload");//重新加载功能组表格
				
				
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	});
}

//删除模块功能组
function deleteModuleFunGroup(groupCode){
	$.messager.confirm("提示", "删除模块功能组的同时会删除该功能组下的功能和功能授权，您确认要删除吗?", function(r){
		if (!r){
			return;
		}
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		$.post("moduleFun/deleteModuleFunGroupByCode.zb",{groupCode:groupCode},function(data){
			if(data.success){
				var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
				$("#funGroupTable").datagrid("reload");//重新加载功能组表格
				
				
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	});
}
</script>
</head>
<body class="easyui-layout">
	<!-- 左侧功能组列表 -->
	<div data-options="region:'west',title:'功能参数组',split:true"
		style="width: 370px;">
		<!-- 工具栏 -->
		<div id="funGroupTB" class="datagrid-toolbar">
			<a onclick="openAddGroupDialog()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增</a>
		</div>
		<!-- 功能参数组列表 -->
		<table id="funGroupTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'moduleFun/getModuleFunGroupList.zb',
			toolbar:'#funGroupTB',  
	        fit: true,
	        border:false,
	        onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
	        onDrop:sortModuleFunGroup,
	        onClickRow:function(rowIndex, rowData){
	        	$('#funTable').datagrid({
					queryParams:{funGroupCode:rowData.funGroupCode}
				});
	        	
	        }
	        
		">
			<thead>
				<tr>
					<th data-options="field:'funGroupCode',width:'100',align:'center'">编码</th>
					<th data-options="field:'funGroupName',width:'100',align:'center'">名称</th>
					<th
						data-options="field:'isPublic',width:'45',align:'center',formatter:boolFormatter">公用</th>
					<th
						data-options="field:'disabled',width:'45',align:'center',formatter:boolFormatter">禁用</th>
					<th
						data-options="field:'id',width:'70',align:'center',formatter:funGroupFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- 右侧功能参数列表 -->
	<div data-options="region:'center',title:'功能参数列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			<a onclick="openAddFunDialog()" class="easyui-linkbutton"
				data-options="
				iconCls:'icon-add',
				plain:true
			">新增</a>

		</div>
		<table id="funTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'moduleFun/getModuleFunListByGroupCode.zb',
			toolbar:'#tb',
			onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
			onDrop:sortModuleFun,
	        rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'funCode',width:'100'">编码</th>
					<th data-options="field:'funName',width:'100'">名称</th>
					<th data-options="field:'dictCode',hidden:true,width:'80'">字典</th>
					<th data-options="field:'id',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="groupFormDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 250,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="funGroupForm" action="moduleFun/saveFunGroup.zb"
				method="post">
				<input type="hidden" name="id" id="funGroupId_" />
				<table style="margin: 0 auto;">

					<tr>
						<td>编码：</td>
						<td><input type="text" id="funGroupCode" name="funGroupCode"
							class="easyui-textbox"
							data-options="
								validType:['length[0,32]','checkFunGroupCode','commonChar'],
								required:true,
								width:149
							" />
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td><input type="text" name="funGroupName"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar','checkFunGroupName'],
								required:true,
								width:149
							" />
						</td>
					</tr>
					<tr>
						<td>是否公用：</td>
						<td><input type="radio" name="isPublic" value="1" />是&nbsp;&nbsp;&nbsp;
							<input type="radio" name="isPublic" value="0" checked="checked" />否
						</td>
					</tr>
					<tr>
						<td>是否禁用:</td>
						<td><input type="radio" name="disabled" value="1" />是&nbsp;&nbsp;&nbsp;
							<input type="radio" name="disabled" value="0" checked="checked" />否
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveFunGroup()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#groupFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div style="display: none;">
		<div id="funFormDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 250,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#fundlgbtns'
		">
			<form id="funForm" action="moduleFun/saveModuleFun.zb" method="post">
				<input type="hidden" name="id" id="funId_" /> <input type="hidden"
					name="funGroupCode" id="funGroupCode_" />
				<table style="margin: 0 auto;">

					<tr>
						<td>编码：</td>
						<td><input type="text" id="funCode" name="funCode"
							class="easyui-textbox"
							data-options="
								validType:['length[0,32]','checkFunCode','commonChar'],
								required:true,
								width:149
							" />
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td><input type="text" name="funName" class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar','checkFunName'],
								required:true,
								width:149
							" />
						</td>
					</tr>
					<tr>
						<td>字典：</td>
						<td><select id="dictCode" name="dictCode"
							class="easyui-combotree"
							data-options="
								customAttr: {
									dataModel: 'simpleData',
									textField: 'dictName',
									parentField: 'parentId',
									attributes: ['id','dictType','parentId']
								},
								url:'dict/dictTree.zb?root=true',
								idFiled:'id',
								width:130,
								validType:'checkDictType'
							"></select>
						</td>
					</tr>

				</table>
			</form>
		</div>
		<div id="fundlgbtns">
			<a class="easyui-linkbutton" onclick="saveModuleFun()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#funFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>
