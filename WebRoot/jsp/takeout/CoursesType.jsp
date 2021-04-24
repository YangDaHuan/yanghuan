<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<title>菜品类型管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var editData, delData, removeData,saveUser, queryValue,selectItemValue;
var currentRowIndex; //当前编辑行索引
	
var formatter=function(value,row,index){
	var p = row.coursesTypeId;
    var s =  " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditDialog("+p+","+isFolder+","+index+")\"></div>";
    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteModule("+index+")\"></div>";
    return s;
}

$(document.body).ready(function(){
	
	
	//ComboGrid
	/* $('#coursesTypeName').combogrid({
		panelWidth:650,
	    delay: 0,
	    mode: 'remote',
	    url: 'takeout/findByCoursesType.zb',
	    idField: 'coursesTypeName',
	    textField: 'coursesTypeName',
	    hasDownArrow: false,
	    columns: [[
	        {field:'coursesTypeName',title:'菜品类型名称',width:120,sortable:true},
	        {field:'coursesTypeDesc',title:'描述',width:200,sortable:true}
	    ]]
	}); */

	var listTable = $("#coursesTypeTable");
/* 	var listTree = $("#coursesTypeTree"); */
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
	    url:'takeout/findByCoursesType.zb',
	    title: '菜品类型',
	    border:false,
	    pageSize : 20,//默认选择的分页是每页20行数据  
        pageList : [ 10, 20, 50, 100 ],//可以选择的分页集合  
        nowrap : true,//设置为true，当数据长度超出列宽时将会自动截取  
        striped : true,//设置为true将交替显示行背景。  
        pagination : true,//分页  
        rownumbers : true,//行数
        fit:true,
        height:$(this).height()-8,
	    columns:[[
	    	{field:'coursesTypeId', checkbox:true},
	        {field:'coursesTypeName',title:'菜品类型名称',width:200,align:'left'},
	        {field:'coursesTypeDesc',title:'菜品类型描述',width:200,align:'left'},
	        {field:'operation',title:'操作',width:70,align:'left',formatter:function(value,rowData, rowIndex){
	        	return '<span onclick="editData(\''+rowData.coursesTypeId+'\', 2,'+rowIndex+');" class="icon-edit2" title="编辑"></span><span onclick="removeData(\''+rowData.coursesTypeId+'\','+rowIndex+');" class="icon-del2" title="删除"></span>';
			}}
	    ]]
	});		
	
	queryValue = function(){
		listTable.datagrid("load",{
			roleName : $("#coursesTypeName").val(),
		});	
	};
	
	//编辑数据
	editData = function(coursesTypeId, dataType,index){
		if(index){
			var row = listTable.datagrid("selectRow",index);	
		}
		//$("#parentId").combotree("reload","coursesType/getUsercoursesTypeTree.zb?orgType=1");
		 $('#form').form("reset");
		if(dataType==2){
			$("#opt").val("edit");
			$("#dlg").dialog({
				title:"修改",
				iconCls:"icon-edit"
			})
			//$("#coursesType").combobox("disable");
			$.post("takeout/getCoursesTypeById.zb",{coursesTypeId:coursesTypeId},function(data){
				if(data.success){
					$("#form").form("load",data.extData);
					$("#oldCoursesTypeName").val(data.extData.coursesTypeName);
					$("#oldCoursesTypeDesc").val(data.extData.coursesTypeCode);
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
		}
		$('#dlg').dialog('open');
		
	};
	
	//删除数据
	removeData = function(rowIndexs, index){
		if(index){
			listTable.datagrid("selectRow",index);
		}
		$.messager.confirm("警告","确认删除所选角色吗？",function(r){
		    if (r){
		        $.ajax({
					url: "takeout/deleteCoursesType.zb",
					type: "post",
					data: "coursesTypeId="+rowIndexs,
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

	deleteData = function(){
		var rows = listTable.datagrid("getSelections");
		if(rows.length<=0){
			$.messager.alert('BTP',"请选择数据进行删除。");
			return;
		}
		var coursesTypeId="";
		for(var i=0; i<rows.length; i++)
			coursesTypeId+=rows[i].coursesTypeId+",";
		coursesTypeId = coursesTypeId.substring(0, coursesTypeId.length-1);
		removeData(coursesTypeId);
	};
	
	/* 
	/*******************************************
	 * 保存更新用户信息
	 */
	saveUser = function(){
		var url = "takeout/saveCoursesType.zb";
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
					//listTree.tree("reload");
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	} 
	/* 
	listTree.tree({
	    url:'coursesType/getUsercoursesTypeTree.zb',
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
	});	 */
	
	selectItemValue = function(){
		listTable.datagrid("load",{
			coursesTypeName : $("#coursesTypeName").val()
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

.tree-coursesType {
	background: url("images/icons/tree-coursesType.png") no-repeat center;
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
<input id="coursesTypeId" type="hidden" />
<body class="easyui-layout">
	<div data-options="region:'center'">
		<table id="coursesTypeTable" data-options="toolbar:'#search'"></table>
	</div>
	<div id="search" style="display: none">
		<a class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true"
			onclick="editData('',1);">新增</a> <a class="easyui-linkbutton"
			data-options="iconCls:'icon-del',plain:true" onclick="deleteData();">删除</a>
		菜品类型：<input type="text" id="coursesTypeName" class="time-field" /> <a
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
			width: 300,
	    	height: 200,
	    	closed: true,
	    	cache: false,
	    	modal: true,
	    	buttons: '#dlgbtn'
		">
			<form id="form" action="" method="post">
				<input id="opt" type="hidden"> 
				<input name="coursesTypeId" type="hidden" /> 
				<table style="margin: 0 auto;">
					<tr>
						<td>菜品类型名称：</td>
						<td><input type="text" id="coursesTypeName" name="coursesTypeName"
							class="easyui-validatebox"
							data-options="
						required:true,
						validType:['length[1,18]','checkOrgCode','commonChar']
						" />
						</td>
					</tr>
					
					<tr>
						<td>菜品类型描述：</td>
						<td><input type="text" id="coursesTypeDesc" name="coursesTypeDesc"
							data-options="required:true,validType:['length[2,40]','checkOrgName']"
							class="easyui-validatebox" /></td>
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