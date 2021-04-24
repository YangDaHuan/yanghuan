<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var editData, delData, removeData,saveRole,deleteData,queryValue;

/**
 * 扩展校验框架，校验角色名称不能重复。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkRoleName : {
		validator : function(value, param) {
			//有id值，表示目前是修改操作。如果输入框中的字典编码没有修改，校验通过
			if ($("input[name=id]").val()) {
				var oldCode = $("#oldRoleName").val();
				if (value == oldCode) {
					return true;
				}
			}
			var resp = $.ajax({
				url : "role/isExist.zb",
				dataType : "json",
				data : {
					roleName : value,
					organId: $("#orgId").val()
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp != "true";
		},
		message : "角色名称已经存在"
	}
});


$(document.body).ready(function(){	
	/*设置dialog显示事件:
		1,清空表单数据.
		2,使第一个校验错误的文本获取焦点,实现关闭dialog的时候隐藏错误信息
		3,dialog关闭时不需清空表单,否则错误信息会重新显示
	*/
	$("#dlg").dialog({
		onOpen:function(){
			$(this).dialog('body').find('form').form('reset');//清空表单数据
			$(this).dialog('body').find('.validatebox-invalid:first').focus();
		}
	});
	var listTable = $("#roleTable");
	var listTree = $("#organTree");	
	listTable.datagrid({
	    url:'role/list.zb',
	    title: '角色列表',
	    iconCls: 'grid-role',
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit:true,
        height:$(this).height(),
        toolbar:'#search',
	    frozenColumns:[[
	    	{field:'ck',checkbox:true}
	    ]],
	    columns:[[
	    	{field:'id', width:0, hidden: true},
	        {field:'roleName',title:'名 称',width:100,align:'left'},	        	       
	        {field:'remark',title:'备 注',width:150,align:'left'},
	        {field:'roleType',title:'类 型',width:60,align:'left',formatter:function(value,rowData, rowIndex){
				if(value==1) return "普通用户";
				else if(value==2) return "管理员";
				else return value;
			}},
	        {field:'operation',title:'操作',width:70,align:'left',formatter:function(value,rowData, rowIndex){
				return '<span onclick="editData(\''+rowData.id+'\', 2,'+rowIndex+');" class="icon-edit2" title="编辑"></span><span onclick="removeData(\''+rowData.id+"~"+rowData.roleName+'\','+rowIndex+');" class="icon-del2" title="删除"></span>';
			}}
	    ]]
	});		
	
	deleteData = function(){
		var rows = listTable.datagrid("getSelections");
		if(rows.length<=0){
			$.messager.alert('BTP',"请选择角色进行删除。");
			return;
		}
		var id="";
		for(var i=0; i<rows.length; i++)
			id+=rows[i].id+"~"+rows[i].roleName+",";
		id = id.substring(0, id.length-1);
		removeData(id);
	};
	
	queryValue = function(){
		listTable.datagrid("load",{
			roleName : $("#roleName").val(),
			orgId : $("#orgId").val()
		});	
	};
	
	//编辑数据
	editData = function(id, dataType,index){
		if(index){
			$("#roleTable").datagrid("selectRow",index);
		}
		$("#form").form("reset");
		$("input[name=id]").val("");
		$("#opt").val("");
		var orgName = $("#orgName").val();
		var orgId = $("#orgId").val();
		if(!orgName){
			var root = $("#organTree").tree("getRoot");	
			orgName = root.text;
		}
		if(!orgId){
			var root = $("#organTree").tree("getRoot");	
			orgId = root.id;
			$("#orgId").val(orgId);
		}
		//存在id进行修改，否则新建
		if(dataType==2){
			$("#opt").val("edit");
			$("#dlg").dialog({
				title:"修改",
				iconCls:"icon-edit"
			});
			$.post("role/getRoleById.zb",{roleId:id},function(data){
				if(data.success){
					$("#form").form("load",data.extData);
					var roleName = $("input[name=roleName]").val();
					$("#oldRoleName").val(roleName);
				}else{
					$.messager.alert("错误","加载时出现系统错误!","error");			
				}
			},"json");
			
		}else{
			$("#opt").val("insert");
			$("#dlg").dialog({
				title:"新增",
				iconCls:"icon-add"
			});
		}
		$("#dlg").dialog("open");
		$("#orgName2").val(orgName);
		
	};
	//删除数据
	removeData = function(rowIndexs, index){
		if(index){
			$("#roleTable").datagrid("selectRow",index);
		}
		$.messager.confirm("警告","确认删除所选角色吗？",function(r){
		    if (r){
		        $.ajax({
					url: "role/remove.zb",
					type: "post",
					data: "id="+rowIndexs,
					dataType:"json",
					success: function(res){
						if(res.success) {
							listTable.datagrid("load");
							if(res.msg){
								$.messager.alert("提示",res.msg,"warning");
							}else{
								var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
							}
						}
						else{
							$.messager.alert('BTP',"操作失败");
						}
												
					}
				});
		    }
		});		
	}
	
	saveRole = function(){
		$("#organId").val( $("#orgId").val());
		var url = "role/save.zb";
		var $form = $("#form");
		var $dialog = $("#dlg");
		$form.form("submit",{
			url: url,
			//提交前验证
			onSubmit:function(){
				$.messager.progress({
					title:"提示",
					text:"数据处理中，请稍后...."
				});	
				var isValid = $(this).form("validate");
				if (!isValid) {
					$.messager.progress("close");
				}
				return isValid;
			},
			//提交成功
			success:function(result){
				result = $.parseJSON(result);
				$.messager.progress("close");
				if(result.success){//操作成功
					$("#dg").datagrid("reload");
					$dialog.dialog("close");
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
					listTable.datagrid("reload");
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
	loadOrganTree();
});

/**
 * 点击机构树节点的时候，加载此机构下面的角色
 */
function loadRole(node){
	var orgId = node.id;
	$("#orgId").val(orgId);
	$("#orgName").val(node.text);
	$("#roleTable").datagrid("load",{
		orgId: node.id
	});
	$("#roleTable").datagrid("clearChecked");
}

/**
 * 加载机构数
 */
function loadOrganTree(){
	 var url= "organ/getUserOrganTree.zb";
	 $.post(url,{},function(res){
		 $("#organTree").tree({
			 data:res
		 });
	 },"json");
}

function onOrganLoadSuccess(){
	$("#organTree").tree('collapseAll');
	var node=$("#organTree").tree('getRoot');
	$("#organTree").tree('expand',node.target);
}
</script>
<style type="text/css">
.icon-edit2 {
	background: url("images/icons/pencil.png") no-repeat center;
	width: 20px;
	height: 20px;
	display: block;
	float: left;
	margin: 0px 5px 0px 5px;
	cursor: pointer;
}

.icon-del2 {
	background: url("images/icons/delete.gif") no-repeat center;
	width: 20px;
	height: 20px;
	display: block;
	float: left;
	margin: 0px 5px 0px 0px;
	cursor: pointer;
}

.tree-root {
	background: url("images/icons/tree-root.png") no-repeat center;
}

.tree-organ {
	background: url("images/icons/tree-organ.png") no-repeat center;
}

.grid-role {
	background: url("images/icons/grid-role.png") no-repeat center;
}
</style>
</head>
<input id="orgId" type="hidden" />
<input id="orgName" type="hidden" />
<body class="easyui-layout" data-options="fit:true">
	<div style="width: 200px;"
		data-options="title:'组织机构',region:'west',split:true,border:true">
		<ul id="organTree" class="easyui-tree"
			data-options="
		customAttr:{
            dataModel: 'simpleData',
            textField: 'text',
            parentField: 'parentId'
       	},
       	onClick:loadRole,
       	onLoadSuccess:onOrganLoadSuccess
	">
		</ul>
	</div>
	<div data-options="border:false,region:'center',split:true">
		<table id="roleTable"></table>
	</div>
	<div id="search">
		<a class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true"
			onclick="editData('',1);">新增</a> <a class="easyui-linkbutton"
			data-options="iconCls:'icon-del',plain:true" onclick="deleteData();">删除</a>
		角色名称：<input type="text" id="roleName" class="time-field" /> <a
			class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true"
			onclick="queryValue();">查询</a>
	</div>
	<!-- ---------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="dlg" class="easyui-dialog" style="padding-top: 10px"
			data-options="
			title:'编辑',
			width: 430,
	    	height: 200,
	    	closed: true,
	    	cache: false,
	    	modal: true,
	    	buttons: '#dlgbtn'
		">
			<form id="form" action="" method="post">
				<input id="opt" type="hidden"> <input name="id"
					type="hidden" /> <input id="oldRoleName" type="hidden"
					name="oldRoleName" /> <input id="organId" name="organId"
					type="hidden" />
				<table style="margin: 0 auto;">
					<tr>
						<td>所属机构:</td>
						<td colspan="3"><input readonly="readonly" id="orgName2">
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td><input type="text" name="roleName"
							data-options="required:true,validType:['length[1,20]','checkRoleName']"
							class="easyui-validatebox" /></td>
						<td>类型：</td>
						<td><select name="roleType"
							class="easyui-validatebox easyui-combobox"
							data-options="
								width:130,
								editable:false,
								required:true
							">
								<option value="1">普通用户</option>
								<option value="2">管理员</option>
						</select></td>
					</tr>
					<tr>
						<td>备注：</td>
						<td colspan="3"><textarea name="remark"
								class="easyui-validatebox" style="width: 320px; height: 50px"
								data-options="
							validType:'length[0,200]'
						"></textarea>
						</td>
					</tr>
				</table>
			</form>
			<div id="dlgbtn">
				<a class="easyui-linkbutton" onclick="saveRole()"
					data-options="iconCls:'icon-ok'">确定</a> <a
					class="easyui-linkbutton" onclick="$('#dlg').dialog('close');"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
</body>
</html>