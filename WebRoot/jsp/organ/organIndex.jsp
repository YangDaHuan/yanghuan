<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>机构管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var editData, delData, removeData,saveUser, selectItemValue;
var currentRowIndex; //当前编辑行索引
	/**
	 * 扩展校验框架，增加机构编码校验。机构编码应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkOrgCode : {
			validator : function(value, param) {
				var oldOrganCode = $("#oldOrganCode").val();
				if(oldOrganCode==value){
					return true;
				}
				var resp = $.ajax({
					url : "organ/check.zb",
					dataType : "json",
					data : {
						code : value,
						id : $("input[name=id]").val(),
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "机构编码已经存在"
		}
	});
	
	/**
	 * 扩展校验框架，增加机构名称校验。同一组织机构下，机构名称应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkOrgName : {
			validator : function(value, param) {
				var oldOrganName = $("#oldOrganName").val();
				if(oldOrganName==value){
					return true;
				}
				var resp = $.ajax({
					url : "organ/checkOrgName.zb",
					dataType : "json",
					data : {
						name : value,
						id : $("input[name=id]").val(),
						parentId : $("#orgId").val(),
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "机构名称已经存在"
		}
	});
	
	/**
	 * 扩展校验框架，增加电话校验。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkPhone : {
			validator : function(value, param) {
				var ev = value;
				var regu = /^(\d{7,13}|\d{3,5}-\d{7,8})(\-\d{1,4})?$/;
				var re = new RegExp(regu);
				if (!re.test(ev)) {
					return false;
				}
				return true;
			},
			message : "电话格式不正确"
		}
	});
$(document.body).ready(function(){
	
	
	//ComboGrid
	$('#organName').combogrid({
		panelWidth:650,
	    delay: 0,
	    mode: 'remote',
	    url: 'organ/comboList.zb',
	    idField: 'organName',
	    textField: 'organName',
	    hasDownArrow: false,
	    columns: [[
	        {field:'organCode',title:'编码',width:120,sortable:true},
	        {field:'organName',title:'名称',width:200,sortable:true},
	        {field:'tel',title:'电话',width:100,sortable:true},
	        {field:'address',title:'地址',width:200,sortable:true}
	    ]]
	});

	var listTable = $("#organTable");
	var listTree = $("#organTree");
	var codeEditor = {
		type: 'validatebox',
		options: {
			required:true,
			validType:'length[1,20]'
		}
	};
	var reEditor = {
		type: 'validatebox',
		options: {
			required:false,
			validType:'length[1,100]'
		}
	};
	listTable.datagrid({
	    url:'organ/list.zb',
	    title: '机构列表',
	    border:false,
	    iconCls: 'tree-organ',
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit:true,
        height:$(this).height()-8,
	    columns:[[
	    	{field:'id', checkbox:true},
	        {field:'organCode',title:'编 码',width:100,align:'left'},
	        {field:'organName',title:'名 称',width:100,align:'left'},
	        {field:'tel',title:'电 话',width:100,align:'left'},
	        {field:'address',title:'地 址',width:150,align:'left'},	        
	        {field:'remark',title:'备 注',width:150,align:'left'},
	        {field:'legalPerson',title:'法 人',width:100,align:'left'},
	        {field:'website',title:'网 址',width:100,align:'left'},
	        {field:'organType',title:'类 型',width:60,align:'left',formatter:function(value,rowData, rowIndex){
				if(value==1) return "机构";
				else if(value==2) return "部门";
				else return value;
			}},
	        {field:'operation',title:'操作',width:70,align:'left',formatter:function(value,rowData, rowIndex){
				return '<span onclick="editData(\''+rowData.id+'\', 2,\''+rowIndex+'\');" class="icon-edit2" title="编辑"></span><span onclick="removeData(\''+rowIndex+'\');" class="icon-del2" title="删除"></span>';
			}}
	    ]]
	});		
	//编辑数据
	editData = function(id, dataType,index){
		if(index){
			var row = listTable.datagrid("selectRow",index);	
		}
		$("#parentId").combotree("reload","organ/getUserOrganTree.zb?orgType=1");
		if(dataType==2){
			$("#opt").val("edit");
			$("#dlg").dialog({
				title:"修改",
				iconCls:"icon-edit"
			})
			$("#organType").combobox("disable");
			$.post("organ/getOrgById.zb",{orgId:id},function(data){
				if(data.success){
					$("#form").form("load",data.extData);
					$("#oldOrganName").val(data.extData.organName);
					$("#oldOrganCode").val(data.extData.organCode);
				}else{
					$.messager.alert("错误","加载时出现系统错误!","error");			
				}
			},"json");;
		}else{
			$('#opt').val("insert");
			$("#dlg").dialog({
				title:"新增",
				iconCls:"icon-add"
			});
			$('#form').form("reset");
			$("#organType").combobox("enable");
			$("input[name=id]").val("");
			$('#opt').val("");
			var parentId=$("#orgId").val();
			$("#parentId").combotree("setValue", parentId);
			
		}
		$('#dlg').dialog('open');
		
	};
	//删除数据
	removeData = function(index){
		if(index){
			listTable.datagrid("selectRow",index);
		}
		var id="";
			var rows = listTable.datagrid("getSelections");
			if(rows.length<=0){
				var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
				return;
			}
			for(var i=0; i<rows.length; i++)
				id+=rows[i].id+",";
			id = id.substring(0, id.length-1);
		$.messager.confirm("警告","确认删除所选机构吗？",function(r){
		    if (r){
		        $.ajax({
					url: "organ/remove.zb",
					type: 'post',
					data: "id="+id,
					dataType:"json",
					success: function(res){
						if(res.success){
							var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
						}else{
							$.messager.alert("错误",res.msg);
						}					
						listTable.datagrid("load");
						listTree.tree("reload");
					}
				});
		    }
		});		
	};
	
	/*******************************************
	 * 保存更新用户信息
	 */
	saveUser = function(){
		var url = "organ/save.zb";
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
					listTree.tree("reload");
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
	listTree.tree({
	    url:'organ/getUserOrganTree.zb',
		customAttr: {
			dataModel: "simpleData",
			textField: "text",
			parentField: "parentId"
        },
	    onClick: function(node){	    	 	  
	    	var parentId = node.id;
	    	 $("#orgId").val(parentId);
	    	 listTable.datagrid("clearChecked");
	    	listTable.datagrid("load",{
	    		parentId: node.id
	    	});	  
	    },
	    onLoadSuccess:function(){
	    	listTree.tree('collapseAll');
	    	var node=listTree.tree('getRoot');
	    	listTree.tree('expand',node.target);
	    }
	});	
	
	selectItemValue = function(){
		var currOrgId = $("#orgId").val();
		listTable.datagrid("load",{
			organName : $("#organName").combogrid('getValue'),
			parentId:currOrgId
		});	
	};
});
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

.time-field {
	width: 100px;
}

.query-field {
	float: left;
	height: 27px;
	margin: 3px;
}
</style>
</head>
<input id="orgId" type="hidden" />
<body class="easyui-layout">
	<div style="width: 200px;"
		data-options="title:'组织机构',region:'west',split:true">
		<ul id="organTree"></ul>
	</div>
	<div data-options="region:'center'">
		<table id="organTable" data-options="toolbar:'#search'"></table>
	</div>
	<div id="search" style="display: none">
		<a class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true"
			onclick="editData('',1);">新增</a> <a class="easyui-linkbutton"
			data-options="iconCls:'icon-del',plain:true" onclick="removeData();">删除</a>
		名称：<input type="text" id="organName" class="time-field" /> <a
			class="easyui-linkbutton"
			data-options="iconCls:'icon-search',plain:true"
			onclick="selectItemValue();">查询</a>
	</div>
	<!-- ---------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="dlg" class="easyui-dialog" style="padding-top: 10px"
			data-options="
			title:'编辑',
			width: 500,
	    	height: 300,
	    	closed: true,
	    	cache: false,
	    	modal: true,
	    	buttons: '#dlgbtn'
		">
			<form id="form" action="" method="post">
				<input id="opt" type="hidden"> <input name="id"
					type="hidden" /> 
				<input id="oldOrganName" name="oldOrganName" type="hidden" /> <input
					id="oldOrganCode" name="oldOrganCode" type="hidden" />

				<table style="margin: 0 auto;">
					<tr>
						<td>编码：</td>
						<td><input type="text" id="organCode" name="organCode"
							class="easyui-validatebox"
							data-options="
						required:true,
						validType:['length[1,18]','checkOrgCode','commonChar']
						" />
						</td>
						<td>名称：</td>
						<td><input type="text" id="organName" name="organName"
							data-options="required:true,validType:['length[2,40]','checkOrgName']"
							class="easyui-validatebox" /></td>
					</tr>
					<tr>
						<td>电话：</td>
						<td><input type="text" name="tel" class="easyui-validatebox"
							data-options="
							required:false,validType:['length[7,20]','number']
						" />
						</td>
						<td>类型：</td>
						<td><select id="organType" name="organType"
							class="easyui-validatebox easyui-combobox"
							data-options="
								width:130,
								editable:false,
								required:true
							">
								<option value="1">机构</option>
								<option value="2">部门</option>
						</select></td>
					</tr>
					<tr>
						<td>法人：</td>
						<td ><input type="text" name="legalPerson"
							class="easyui-validatebox"
							data-options="
							required:false,validType:'length[0,10]'
						" />
						</td>
						<td>所属机构：</td>
							<td><input id="parentId" class="easyui-combotree" name="parentId"
								style="width: 130px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#parentId').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
							</td>
					</tr>
					<tr>
						<td>网 址：</td>
						<td colspan="3"><input name="website"
							class="easyui-validatebox" style="width: 332px;"
							data-options="
							validType:'url'
						"></input></td>
					</tr>
					<tr>
						<td>地 址：</td>
						<td colspan="3"><textarea name="address"
								class="easyui-validatebox" style="width: 332px; height: 50px"
								data-options="
							validType:'length[0,100]'
						"></textarea>
						</td>
					</tr>
					<tr>
						<td>备注：</td>
						<td colspan="3"><textarea name="remark"
								class="easyui-validatebox" style="width: 332px; height: 50px"
								data-options="
							validType:'length[0,1000]'
						"></textarea>
						</td>
					</tr>
				</table>
			</form>
			<div id="dlgbtn">
				<a class="easyui-linkbutton" onclick="saveUser()"
					data-options="iconCls:'icon-ok'">确定</a> <a
					class="easyui-linkbutton" onclick="$('#dlg').dialog('close');"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
</body>
</html>