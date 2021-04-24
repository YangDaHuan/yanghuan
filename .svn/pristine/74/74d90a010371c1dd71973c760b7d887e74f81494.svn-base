<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>字典管理</title>
<jsp:include page="../common.jsp" />

<script type="text/javascript">
	var parentDictId = 0; //当前父字典ID
	var editState = 0; //当前编辑状态 2 修改 1 新建。
	
	/**
	 * 扩展校验框架，增加字典代码校验。字典代码应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkDictCode : {
			validator : function(value, param) {
				//有id值，表示目前是修改操作。如果输入框中的字典编码没有修改，校验通过
				if ($("input[name=id]").val()) {
					var oldCode = $("#oldDictCode").val();
					if (value == oldCode) {
						return true;
					}
				}
				var resp = $.ajax({
					url : "dict/existDictCode.zb",
					dataType : "json",
					data : {
						code : value
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "类型编码已经存在"
		}
	});

	/**
	 * 扩展校验框架，增加字典项代码校验。字典项代码应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkDictItemCode : {
			validator : function(value, param) {
				var node = $("#dictTree").tree("getSelected");
				var row = $("#dictItemTable").datagrid("getSelected");
				var resp = $.ajax({
					url : "dict/existDictItemCode.zb",
					dataType : "json",
					data : {
						id : row.id,
						code : value,
						dictId : node.id
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "编码已经存在"
		}
	});

	/**
	 * 扩展校验框架，校验创建或者修改时，不能够在字典上创建子类别
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkDictType : {
			validator : function(value, param) {
				var t = $("#parentId").combotree("tree");
				var n = t.tree("getSelected");
				if (n.attributes.dictType == "1") {
					return false;
				}
				return true;
			},
			message : "不能在字典上创建子类别"
		}
	});
	
	/**
	 * 扩展校验框架，判断字典类别名字唯一性
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkDictName : {
			validator : function(value, param) {
				//有id值，为修改操作，如果值没有办法，验证通过
				if ($("input[name=id]").val()) {
					var oldName = $("#oldDictName").val();
					if (value == oldName) {
						return true;
					}
				}
				
				var resp = $.ajax({
					url : "dict/isExistDictName.zb",
					dataType : "json",
					data : {
						dictName : value
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp != "true";
			},
			message : "类型名称已经存在"
		}
	});
	
	
	

	/**
	 * 字典树节点格式化
	 */
	function treeFormatter(node) {
		var s = node.text;
		if (node.id != "0") {
			s += "&nbsp;<span style=\"color:blue\">[" + node.dictCode
					+ "]</span>";
			var options = "";
			if (node.remark) {
				options = " data-options=\"position:'right',content:'"
						+ node.remark + "'\"";
				s = "<a href='javascript:void(0)' class='easyui-tooltip' "
						+ options + ">" + s + "</a>"
			}
		}
		return s;
	}

	function initTreeTooltip() {
		$.parser.parse('#dictTree');
	}

	var flag;//点击树节点查询还是点击的查询按钮查询
	var dictIdQuery;//当前点击的字典ID
	/**
	 * 字典树点击事件
	 */
	function treeOnClick(node) {
		flag = "tree";
		//清空查询条件
		$("#dictCodeQuery").val("");
		$("#dictNameQuery").val("");
		parentDictId = node.id;
		if (node.attributes.dictType == "1") {//如果点击的是具体字典节点，加载字典数据	
			$("#dictItemTable").datagrid({
				
				queryParams:{dictId:node.id}
			});
			dictIdQuery = node.id;
			editIndex = undefined;
		}else{
			$('#dictItemTable').datagrid('loadData',{total:0,rows:[]}); 
		}
	}
    /**
     * 查询
     */
	function doSearch(){
		flag = "btn";
		var queryParams = {
			dictId:	dictIdQuery,
			dictName:$("#dictNameQuery").val(),
			dictCode:$("#dictCodeQuery").val()
		}
		$("#dictItemTable").datagrid({
			queryParams: queryParams,
		});
	}
    

	/**
	 * 点击增加字典按钮,显示对话框
	 */
	function openAddDialog() {
		$("#dictCode").attr("readOnly",false);
		$("#dictType").combobox("enable");
		var node = $("#dictTree").tree("getSelected");
		$("#dlg").dialog({
			title:"新增",
			iconCls:"icon-add"
			});
		$("#dlg").dialog("open");
		$("#form").form("reset");
		$("#dictId_").val("");
		$("#parentId").combotree({url:"dict/dictTree.zb?root=true"});
		$("#parentId").combotree("setValue", node.id);
	}

	/**
	 * 打开字典(类型)编辑对话框，从后台加载要编辑的数据
	 */
	function openEditDialog() {
		$("#dictType").combobox("enable");
		$("#dictCode").attr("readOnly",true);
		var node = $("#dictTree").tree("getSelected");
		if (!node) {
			var n = noty({
				text : "请选择要修改的节点",
				type : "warning",
				layout : "topCenter",
				timeout : 1000
			});
			return;
		}
		if (node.id == "0") {
			var n = noty({
				text : "不能修改根节点",
				type : "warning",
				layout : "topCenter",
				timeout : 1000
			});
			return;
		}
		//已经有子类别，所以不能够修改字典类别了
		if (node.children) {
			$("#dictType").combobox("disable");
		}

		$("#form").form("reset");
		$("#dictId_").val("");
		$("#dlg").dialog({
			title:"修改",
			iconCls:"icon-edit"
			});
		$("#dlg").dialog("open");
		
		$.post("dict/getDictByDictId.zb",{id:node.id},function(data){
			if(data.success){
				//保存修改前的值，在校验代码是否重复的时候使用此值，来判断是否修改过字典代码，以便进行校验。
				$("#oldDictCode").val(data.extData.dictCode);
				$("#oldDictName").val(data.extData.dictName);
				$("#form").form("load",data.extData);	
				
			}else{
				$.messager.alert("错误","加载时出现系统错误!","error");			
			}
		},"json");
		
		//$("#form").form("load", node.attributes);
		
		$("#parentId").combotree({url:"dict/dictTree.zb?root=true"});
		$("#parentId").combotree("setValue", node.attributes.parentId);
		
	}

	/**
	 * 保存新增字典或修改字典。后台根据是否有ID值来判断是新增，还是更新
	 */
	function saveDict() {
		$("#form").form("submit", {
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
				//操作成功,关闭对话框，显示提示信息，并动态增加字典树的节点。
				if (result.success) {
					$("#dlg").dialog("close");
					$("#dictTree").tree("reload");//重新加载字典树
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
	 * 删除字典
	 */
	var treeDelete = function() {
		var node = $("#dictTree").tree("getSelected");
		if (!node) {
			var n = noty({
				text : "请选择要删除的节点",
				type : "warning",
				layout : "topCenter",
				timeout : 1000
			});
			return;
		}
		$.messager.confirm("提示", "您确认要删除吗?", function(r) {
			if (!r) {
				return;
			}
			var node = $("#dictTree").tree("getSelected");
			var url = "dict/removeDict.zb";
			var param = {
				id : node.id
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post(url, param, function(result) {
				if (result.success) {
					//$("#dictTree").tree("remove",node.target);
					$("#dictTree").tree("reload");//重新加载字典树
					$.noty.closeAll();
					var n = noty({
						text : "操作成功",
						type : "success",
						layout : "topCenter",
						timeout : 1000
					});
				} else {
					$.messager.alert("提示", result.msg, "warning");
				}
				$.messager.progress("close");
			},"json");
		});
	}
	//处于编辑状态的行号
	var editIndex = undefined;
	//字典项：结束编辑
	function endEditing(){
		if (editIndex == undefined){return true}
		var dg=$('#dictItemTable');
		if (dg.datagrid('validateRow', editIndex)){
			dg.datagrid('endEdit', editIndex);
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 字典项：点击编辑按钮
	 */
	function editrow(index) {
		var dg=$("#dictItemTable");
		//var index = $(a).parent().parent().parent().attr("datagrid-row-index");
		if (editIndex != index){
			if (endEditing()){
				dg.datagrid('selectRow', index).datagrid('beginEdit', index);//选中行并编辑
				editIndex = index;
			} else {
				dg.datagrid('selectRow', editIndex);//选中正在编辑的行
			}
		}
		
	}
	/**
	 * 
	 * 字典项datagrid编辑完成后，触发
	 */
	function onAfterEdit(rowIndex, rowData, changes) {
		var data = "";
		var boolP = false;
		for ( var o in rowData) {
			if (o == 'dictId')
				boolP = true;
			data += o + "=" + rowData[o] + "&";
		}
		if (boolP)
			data = data.substring(0, data.length - 1);
		else
			data += "dictId=" + parentDictId;
		$.ajax({
			url : "dict/saveDictItem.zb",
			type : "post",
			data : data,
			dataType:"json",
			success : function(res) {
				if (res.success){
					rowData.editing = false;
					updateActions(rowIndex);
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
					$("#dictItemTable").datagrid("load");
					//$("#dictItemTable").datagrid("enableDnd");//设置为可拖动
 					
// 					var id=res.extData;
// 					$('#dictItemTable').datagrid('updateRow',{
// 						index: editIndex,
// 						row: res.extData
// 					});
					editIndex = undefined;//清空正在编辑的ID
				}
				else{
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
				//editState = 0;
				//$('#dictItemTable').datagrid("reload");
			}
		});
		
	}

	/**
	 * 字典编码编辑器器定义
	 */
	var dictCodeEditor = {
		type : 'validatebox',
		options : {
			required : true,
			validType : [ 'length[1,20]', 'checkDictItemCode', 'commonChar' ]
		}
	}

	/**
	 * 字典项：操纵列按钮定义
	 */
	function optFormatter(value, row, index) {
		if (row.editing) {
			var s = "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"saverow("+index+")\" title=\"保存\"  class=\"icon-save\"></div> ";
			var c = "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"cancelrow("+index+")\" title=\"取消\" class=\"icon-cancel\"></div> ";
			return s + c;
		} else {
			var e = "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"editrow("+index+")\" title=\"编辑\" class=\"icon-edit\"></div>";
			var d = "<div style=\"float:left;display:inline;width: 30px;height: 20px;\" onclick=\"deleterow("+index+")\" title=\"删除\" class=\"icon-del\"></div> ";
			return e + d;
		}
		
	}

	

	/**
	 * 字典项：删除一行
	 */
	function deleterow(index) {
		$.messager.confirm("确认", "您确认要删除吗", function(r) {
			if (r) {
// 				var tr = $(target).closest("tr.datagrid-row");
// 				var index =  parseInt(tr.attr("datagrid-row-index"));
				var row = $("#dictItemTable").datagrid("getSelected");
				if(row==null){
					$("#dictItemTable").datagrid("deleteRow", index);
					return;
				}
				//TODO 提交到后台删除。
				$.post("dict/deleteDictItem.zb",{id:row.id},function(res){
					if(res.success){
						$("#dictItemTable").datagrid("deleteRow", index);
						$.noty.closeAll();
						$("#dictItemTable").datagrid("load");
						var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
					}else{
						$.messager.alert("错误","保存数据时出现系统错误!","error");
					}
				},"json");
			}
		});
	}

	/**
	 * 字典项：保存当前编辑
	 */
	function saverow(index) {
// 		var tr = $(target).closest("tr.datagrid-row");
// 		var index =  parseInt(tr.attr("datagrid-row-index"));
		//提交到后台保存
		$("#dictItemTable").datagrid("endEdit", index);
	}
	/**
	 * 字典项：取消行编辑
	 */
	function cancelrow(index) {
// 		var index = $(a).parent().parent().parent().attr("datagrid-row-index");
		$("#dictItemTable").datagrid("cancelEdit", index);
		//$("#dictItemTable").datagrid("enableDnd");
	}

	/**
	 * 新增按钮点击事件
	 */
	function addBtnClick() {
		var node = $("#dictTree").tree("getSelected");
		var dg=$("#dictItemTable");
		if(node&&node.attributes.dictType == "1"){
			if (endEditing()){
				/*$("#dictItemTable").datagrid("insertRow", {
					index : 0,
					row : {
						editing : true
					}
				});
				$("#dictItemTable").datagrid("selectRow", 0).datagrid("beginEdit", 0);*/
				dg.datagrid('appendRow',{});
				editIndex = dg.datagrid('getRows').length-1;
				dg.datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
				var row = $("#dictItemTable").datagrid("getSelected");
				row.isAdd = true;
				
			}
		}else{
			var n = noty({text: "请选择字典",type:"success",layout:"topCenter",timeout:1500});
			return ;
		}
	}

	//TODO del
	/**
	 * 删除按钮点击事件
	 */
	function delBtnClick() {
		var rows = $("#dictItemTable").datagrid("getSelections");
		if (rows.length <= 0) {
			$.messager.alert("BTP", "请选择字典项进行删除。");
			return;
		}
		var id = "";
		for ( var i = 0; i < rows.length; i++)
			id += rows[i].id + ",";
		id = id.substring(0, id.length - 1);
		removeData(id);
	}
	
	
	/**
	 * 更新被编辑的行
	 */
	function updateActions(index){
		$("#dictItemTable").datagrid("refreshRow",index);
	}
	/**
	*加载字典树
	*/
	function initDictTree(){
		$("#dictTree").tree({
	        url: 'dict/dictTree.zb?root=false',
	        customAttr: {
				dataModel: 'simpleData',
				textField: 'dictName',
				parentField: 'parentId',
				attributes: ['id','dictType','parentId'],
	        },
	        onClick: function(node){
	            treeOnClick(node);
	        },
	        onLoadSuccess:function(){
	        	$("#dictTree").tree('collapseAll');
	        	var nodes= $("#dictTree").tree("getRoots");
	        	for(var i=0;i<nodes.length;i++){
	        		$("#dictTree").tree('expand',nodes[i].target);
	        	}
	        	
	        }
	    });
	    /*url:'dict/dictTree.zb?root=true',
			formatter:treeFormatter,
			onClick:treeOnClick,
			onLoadSuccess:initTreeTooltip,
			customAttr: {
				dataModel: 'simpleData',
				textField: 'dictName',
				parentField: 'parentId',
				attributes: ['id','dictType']*/
	}
	$(function() {
		initDictTree();
		var codeEditor = {
			type : 'validatebox',
			options : {
				required : true,
				validType : 'length[1,20]'
			}
		};
		
		$("#dictItemTable").datagrid({
			singleSelect:true,
			onBeforeEdit:function(index,row){
				row.editing = true;
				updateActions(index);
				
			},
			onAfterEdit:onAfterEdit,
			onCancelEdit:function(index,row){
				row.editing = false;
				updateActions(index);
				if(row.isAdd){
					$(this).datagrid("deleteRow", index);
				}
				editIndex = undefined;//清空正在编辑的ID
			},
			onLoadSuccess:function(data){
				$(this).datagrid("enableDnd");
				if(flag=="tree"){
					return;
				}
					
				
			},
			onDrop:function(targetRow,sourceRow,point){
				var rows = $(this).datagrid("getRows");
				var param = "";
				for(var i=0;i<rows.length;i++){
					param += rows[i].id+",";
				}
				$.post("dict/dictItemOrder.zb",{ids:param},function(res){
					if(res.success){
						$.noty.closeAll();
						var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					}else{
						$.messager.alert("错误","删除数据时出现系统错误!","error");
					}
				},"json");
			}
		});
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
	});
</script>
<style type="text/css">
.time-field {
	width: 100px;
}
</style>
</head>
<body class="easyui-layout">
	<input id="dictId" type="hidden" />
	<!-- 左侧菜单树 -->
	<div data-options="region:'west',title:'字典类别',split:true"
		style="width: 220px;">
		<!-- 工具栏 -->
		<div class="datagrid-toolbar">
			<a id="btnAdd" onclick="openAddDialog()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增</a> <a id="btnEdit"
				onclick="openEditDialog();" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-edit'">修改</a> <a id="btnDel"
				onclick="treeDelete();" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-del'">删除</a>
		</div>
		<!-- 字典树 -->
		<ul id="dictTree"></ul>
	</div>

	<!-- 右侧数据列表 -->
	<div data-options="region:'center',title:'字典项管理'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			<a onclick="addBtnClick()" class="easyui-linkbutton"
				data-options="
				iconCls:'icon-add',
				plain:true
			">新增</a>
			<span class="tool-separator"></span>&nbsp; 编码：<input type="text"
				id="dictCodeQuery" class="time-field" /> 名称：<input type="text"
				id="dictNameQuery" class="time-field" /> <a onclick="doSearch();"
				class="easyui-linkbutton"
				data-options="
				iconCls:'icon-search',
				plain:true
			">查询</a>
		</div>
		<table id="dictItemTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'dict/getDictItemByDictId.zb',
			iconCls: 'icon-dict',
			toolbar:'#tb',
	        nowrap: true,  
	        striped: true,  
	        rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'id',hidden:true">id</th>
					<th
						data-options="field:'itemCode',width:'100',editor:{
						type: 'validatebox',
						options: {
							required:true,
							validType:['length[1,32]','checkDictItemCode']
						}
					}">编码</th>
					<th
						data-options="field:'itemName',width:'100',editor:{
						type:'validatebox',
						options:{
							required:true,
							validType:['length[1,40]']
						}
					}">名称</th>
					<th
						data-options="field:'jianpin',width:'80',editor:{
						type:'validatebox',
						options:{
							validType:['length[0,40]','commonChar']
						}
					}">简拼</th>
					<th
						data-options="field:'nutrition',width:'70',formatter:optFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="dlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 250,
		    height: 200,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="form" action="dict/saveDict.zb" method="post">
				<input type="hidden" name="id" id="dictId_" /> <input
					id="oldDictCode" type="hidden" name="oldDictCode" /> <input
					id="oldDictName" type="hidden" name="oldDictName" />
				<table style="margin: 0 auto;">
					<tr>
						<td>父节点：</td>
						<td><input id="parentId" name="parentId"
							class="easyui-combotree"
							data-options="
								customAttr: {
									dataModel: 'simpleData',
									textField: 'dictName',
									parentField: 'parentId',
									attributes: ['id','dictType','parentId']
								},
								idFiled:'id',
								width:130,
								validType:'checkDictType'
							">
						</td>
					</tr>
					<tr>
						<td>类别：</td>
						<td><select id="dictType" name="dictType"
							class="easyui-validatebox easyui-combobox"
							data-options="
								width:130,
								editable:false,
								required:true
							">
								<option value="1">字典</option>
								<option value="2">字典类别</option>
						</select></td>
					</tr>
					<tr>
						<td>类型编码：</td>
						<td><input type="text" id="dictCode" name="dictCode"
							class="easyui-validatebox"
							data-options="
								editable:false,								
								validType:['length[0,32]','checkDictCode','commonChar'],
								required:true
							" />
						</td>
					</tr>
					<tr>
						<td>类型名称：</td>
						<td><input type="text" name="dictName"
							class="easyui-validatebox"
							data-options="
								validType:['length[2,40]','commonChar','checkDictName'],
								required:true
							" />
						</td>
					</tr>
					<tr>
						<td>备注：</td>
						<td><input type="text" name="remark"
							class="easyui-validatebox"
							data-options="
								validType:'length[0,200]'
							" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveDict()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#dlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>
