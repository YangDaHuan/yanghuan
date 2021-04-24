<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>任务类型管理</title>
<jsp:include page="../common.jsp" />
<script>
	var paramTypeData=[{
		label: '文本输入框',
		value: 'textbox'
	},{
		label: '数值输入框',
		value: 'numberbox'
	},{
		label: '数值微调',
		value: 'numberspinner'
	},{
		label: '下拉框',
		value: 'combobox'
	},{
		label: '单选框',
		value: 'radio'
	},{
		label: '下拉日历',
		value: 'datebox'
	},{
		label: '下拉日历时间',
		value: 'datetimebox'
	},{
		label: '时间微调',
		value: 'timespinner'
	}]
	/**
	 * 扩展校验框架，增加任务类型名称校验。任务类型名称应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkJobTypeName : {
			validator : function(value, param) {
				var resp = $.ajax({
					url : "job/checkJobTypeName.zb",
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
			message : "任务类型名称已经存在"
		}
	});

	/**
	 * 扩展校验框架，增加任务类型参数名称校验。任务类型参数名称应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkJopTypeParamName : {
			validator : function(value, param) {
				var resp = $.ajax({
					url : "job/checkJopTypeParamName.zb",
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
			message : "任务类型参数名称已经存在"
		}
	});
	function openAddJobTypeDialog() {
		$("#jobTypeId").val("");
		$("#jobTypeForm").form("reset");
		$("#jobTypeFormDlg").dialog({
			title : "新增任务类型",
			iconCls : "icon-add"
		});
		$("#jobTypeFormDlg").dialog("open");
	}
	function openEditJobTypeDialog(index) {
		$("#jobTypeTable").datagrid("selectRow", index);
		var row = $("#jobTypeTable").datagrid("getSelected");
		$("#jobTypeForm").form("load", row);
		$("#jobTypeFormDlg").dialog({
			title : "编辑任务类型",
			iconCls : "icon-edit"
		});
		$("#jobTypeFormDlg").dialog("open");
	}

	

	function jobTypeFormatter(value, row, index) {
		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditJobTypeDialog("
				+ index + ")\"></div>";
				s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteJobType('"
					+ row.jobTypeId + "')\"></div>";
		return s;
	}

	function saveJobType() {

		$("#jobTypeForm").form("submit", {
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
					$("#jobTypeFormDlg").dialog("close");
					$("#jobTypeTable").datagrid("reload");//重新加载功能组表格
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
	function openAddParamDialog() {
		var row = $("#jobTypeTable").datagrid("getSelected");
		if (row == null) {
			$.messager.alert("错误", "必须选择一个任务类型后新增参数");
			return;
		}
		$("#jobTypeParamForm").form("reset");
		$("#jobTypeId_").val(row.jobTypeId);
		$("#paramId_").val("");

		$("#jobTypeParamFormDlg").dialog({
			title : "新增参数",
			iconCls : "icon-add"
		});
		$("#jobTypeParamFormDlg").dialog("open");
	}
	function openEditJobTypeParamDialog(index) {
		$("#funFormDlg").dialog({
			title : "编辑任务类型参数",
			iconCls : "icon-edit"
		});
		$("#jobTypeParamFormDlg").dialog("open");
		$("#jobTypeParamTable").datagrid("selectRow", index);
		var row = $("#jobTypeParamTable").datagrid("getSelected");
		
		$("#jobTypeParamForm").form("load", row);
		
	}
	
	/**
	 * 参数类型Formatter
	 */
	function paramTypeFormatter(value,row,index){
		for(var i=0;i<paramTypeData.length;i++){
			if(value==paramTypeData[i].value){
				return paramTypeData[i].label;
			}
		}
		return "未知";
	}
	
	/**
	 * 模块状态Formatter
	 */
	function statusFlagFormatter(value,row,index){
		switch (value) {
		case 0 :
			return "禁用";
		case 1 :
			return "启用";
		default:
			return "未知";
		}
	}
	
	function funFormatter(value, row, index) {

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditJobTypeParamDialog("
				+ index + ")\"></div>";
		s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteJobTypeParam('"
				+ row.paramId + "')\"></div>";
		return s;
	}

	function saveJobTypeParam() {

		$("#jobTypeParamForm").form("submit", {
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
					$("#jobTypeParamFormDlg").dialog("close");
					$("#jobTypeParamTable").datagrid("reload");//重新加载功能组表格
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
	function sortJobType(targetRow, sourceRow, point) {
		var rows = $(this).datagrid("getRows");
		var id = "";
		for (var i = 0; i < rows.length; i++) {
			id += rows[i].jobTypeId + ",";

		}

		id = id.substring(0, id.length - 1);
		$.messager.confirm("提示", "您确认要排序吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("job/sortJobTypes.zb", {
				id : id
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});

				} else {
					$.messager.alert("错误", "更新数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}
	//功能列表排序
	function sortJobTypeParams(targetRow, sourceRow, point) {
		var rows = $(this).datagrid("getRows");
		var id = "";
		for (var i = 0; i < rows.length; i++) {
			id += rows[i].paramId + ",";

		}

		id = id.substring(0, id.length - 1);
		$.messager.confirm("提示", "您确认要排序吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("job/sortJobTypeParams.zb", {
				id : id
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});

				} else {
					$.messager.alert("错误", "更新数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}
	//删除任务类型参数 
	function deleteJobTypeParam(paramId) {
		$.messager.confirm("提示", "您确认要删除吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("job/deleteJobTypeParamById.zb", {
				paramId : paramId
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});
					$("#jobTypeParamTable").datagrid("reload");//重新加载功能组表格

				} else {
					$.messager.alert("错误", "删除数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}

	//删除任务类型
	function deleteJobType(jobTypeId) {
		$.messager.confirm("提示", "删除任务类型的同时会删除该任务类型的任务类型参数，您确认要删除吗?",
				function(r) {
					if (!r) {
						return;
					}
					$.messager.progress({
						title : "提示",
						text : "数据处理中，请稍后...."
					});
					$.post("job/deleteJobTypeById.zb", {
						jobTypeId : jobTypeId
					}, function(data) {
						if (data.success) {
							var n = noty({
								text : "操作成功!",
								type : "success",
								layout : "topCenter",
								timeout : 1500
							});
							$("#jobTypeTable").datagrid("reload");
							$("#jobTypeParamTable").datagrid("reload");
						} else {
							$.messager.alert("错误", data.msg, "error");
						}
						$.messager.progress("close");
					}, "json");
				});
	}
</script>
</head>
<body class="easyui-layout">
	<!-- 左侧任务类型列表 -->
	<div data-options="region:'west',title:'任务类型',split:true"
		style="width: 370px;">
		<!-- 工具栏 -->
		<div id="jobTypeTB" class="datagrid-toolbar">
			<a onclick="openAddJobTypeDialog()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增</a>
		</div>
		<!-- 任务类型列表 -->
		<table id="jobTypeTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'job/getJobTypeList.zb',
			toolbar:'#jobTypeTB',  
	        fit: true,
	        border:false,
	        onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
	        onDrop:sortJobType,
	        onClickRow:function(rowIndex, rowData){
	        	$('#jobTypeParamTable').datagrid({
					queryParams:{jobTypeId:rowData.jobTypeId}
				});
	        	
	        }
	        
		">
			<thead>
				<tr>
					<th data-options="field:'jobTypeName',width:'250',align:'center'">名称</th>
					<th
						data-options="field:'state',width:'45',align:'center',formatter:statusFlagFormatter">状态</th>
					<th
						data-options="field:'id',width:'70',align:'center',formatter:jobTypeFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- 右侧功能参数列表 -->
	<div data-options="region:'center',title:'任务类型参数列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			<a onclick="openAddParamDialog()" class="easyui-linkbutton"
				data-options="
				iconCls:'icon-add',
				plain:true
			">新增</a>

		</div>
		<table id="jobTypeParamTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'job/getJobTypeParamListByTypeId.zb',
			toolbar:'#tb',
			onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
			onDrop:sortJobTypeParams,
	        rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'paramName',width:'100'">名称</th>
					<th data-options="field:'discription',width:'100'">显示名称</th>
					<th data-options="field:'defaultValue',width:'80'">默认值</th>
					<th
						data-options="field:'paramType',width:'80',formatter:paramTypeFormatter">参数类型</th>
					<th
						data-options="field:'state',width:'80',formatter:statusFlagFormatter">状态</th>
					<th
						data-options="field:'paramId',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="jobTypeFormDlg" class="easyui-dialog"
			style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 400,
		    height: 350,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#dlgbtns'
		">
			<form id="jobTypeForm" action="job/saveJobType.zb" method="post">
				<input type="hidden" name="jobTypeId" id="jobTypeId" />
				<table style="margin: 0 auto;">


					<tr>
						<td>名称：</td>
						<td><input type="text" name="jobTypeName"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:250
							" />
						</td>
					</tr>
					<tr>
						<td>执行类：</td>
						<td><input type="text" name="jobClass" class="easyui-textbox"
							data-options="
								validType:['length[2,100]'],
								required:true,
								width:250
							" />
						</td>
					</tr>
					<tr>
						<td>是否启用:</td>
						<td><input type="radio" name="state" value="1"
							checked="checked" />是&nbsp;&nbsp;&nbsp; <input type="radio"
							name="state" value="0" />否</td>
					</tr>

					<tr>
						<td>描述:</td>
						<td><input type="text" name="discription"
							class="easyui-textbox" style="height: 150px; width: 250px"
							data-options="validType:'length[0,200]',multiline:true"
							placeholder="不能大于200个字" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveJobType()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#jobTypeFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div style="display: none;">
		<div id="jobTypeParamFormDlg" class="easyui-dialog"
			style="padding-top: 5px"
			data-options="
			title: '编辑',
		    width: 400,
		    height: 400,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#paramdlgbtns'
		">
			<form id="jobTypeParamForm" action="job/saveJobTypeParam.zb"
				method="post">
				<input type="hidden" name="paramId" id="paramId_" /> <input
					type="hidden" name="jobTypeId" id="jobTypeId_" />
				<table style="margin: 0 auto;">

					<tr>

						<td>名称：</td>
						<td><input type="text" name="paramName"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:249
							" />
						</td>
					</tr>
					<tr>
						<td>显示名称：</td>
						<td><input type="text" name="discription"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:249
							" />
						</td>
					</tr>
					<tr>
						<td>默认值：</td>
						<td><input type="text" name="defaultValue"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]'],
								width:249
							" />
						</td>
					</tr>
					<tr>
						<td>类型：</td>
						<td><input type="text" name="paramType"
							class="easyui-combobox"
							data-options="valueField: 'value',
								textField: 'label',
								required:true,
								data:paramTypeData,
								width:149
							" />

						</td>
					</tr>
					<tr>
						<td>数据项：</td>
						<td><input type="text" name="dataOption"
							class="easyui-textbox" style="height: 160px; width: 250px"
							data-options="validType:'length[0,200]',multiline:true"
							placeholder="不能大于200个字" /></td>
					</tr>
					<tr>
						<td>是否启用:</td>
						<td><input type="radio" name="state" value="1"
							checked="checked" />是&nbsp;&nbsp;&nbsp; <input type="radio"
							name="state" value="0" />否</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="paramdlgbtns">
			<a class="easyui-linkbutton" onclick="saveJobTypeParam()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#jobTypeParamFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>
