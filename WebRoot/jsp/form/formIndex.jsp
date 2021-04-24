<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单类型管理</title>
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
	}];
	var dataTypeData=[{
		label: '文本',
		value: 'text'
	},{
		label: '数值',
		value: 'number'
	},{
		label: '日期',
		value: 'date'
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
			message : "表单类型名称已经存在"
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
	function openAddFormDialog() {
		$("#formId").val("");
		$("#formForm").form("reset");
		$("#formFormDlg").dialog({
			title : "新增表单类型",
			iconCls : "icon-add"
		});
		$("#formFormDlg").dialog("open");
	}
	function openEditFormDialog(index) {
		$("#formTable").datagrid("selectRow", index);
		var row = $("#formTable").datagrid("getSelected");
		$("#formForm").form("load", row);
		$("#formFormDlg").dialog({
			title : "编辑表单类型",
			iconCls : "icon-edit"
		});
		$("#formFormDlg").dialog("open");
	}

	

	function formFormatter(value, row, index) {
		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditFormDialog("
				+ index + ")\"></div>";
				s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteForm('"
					+ row.formId + "')\"></div>";
					s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-search\" title=\"预览\" onclick=\"initForm('"
					+ row.formId + "','"+row.formTitle+"',"+row.formColumnNumber+")\"></div>";
		return s;
	}

	function saveForm() {

		$("#formForm").form("submit", {
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
					$("#formFormDlg").dialog("close");
					$("#formTable").datagrid("reload");//重新加载功能组表格
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
	function openAddFormItemDialog() {
		var row = $("#formTable").datagrid("getSelected");
		if (row == null) {
			$.messager.alert("错误", "必须选择一个任务类型后新增参数");
			return;
		}
		$("#formItemForm").form("reset");
		$("#formId_").val(row.formId);
		$("#inputId_").val("");

		$("#formItemFormDlg").dialog({
			title : "新增表单项",
			iconCls : "icon-add"
		});
		$("#formItemFormDlg").dialog("open");
	}
	function openEditFormItemDialog(index) {
		$("#formItemFormDlg").dialog({
			title : "编辑表单类型表单项",
			iconCls : "icon-edit"
		});
		$("#formItemFormDlg").dialog("open");
		$("#formItemTable").datagrid("selectRow", index);
		var row = $("#formItemTable").datagrid("getSelected");
		
		$("#formItemForm").form("load", row);
		
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
	 * 数据类型Formatter
	 */
	function dataTypeFormatter(value,row,index){
		for(var i=0;i<dataTypeData.length;i++){
			if(value==dataTypeData[i].value){
				return dataTypeData[i].label;
			}
		}
		return "未知";
	}
	
	
	/**
	 * 模块状态Formatter
	 */
	function statusFlagFormatter(value,row,index){
		switch (value) {
		case "0" :
			return "禁用";
		case "1" :
			return "启用";
		default:
			return "未知";
		}
	}
	
	function funFormatter(value, row, index) {

		var s = " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditFormItemDialog("
				+ index + ")\"></div>";
		s += " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteFormItem('"
				+ row.inputId + "')\"></div>";
		return s;
	}

	function saveFormItem() {

		$("#formItemForm").form("submit", {
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
					$("#formItemFormDlg").dialog("close");
					$("#formItemTable").datagrid("reload");//重新加载功能组表格
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
	function sortFormItem(targetRow, sourceRow, point) {
		var rows = $(this).datagrid("getRows");
		var id = "";
		for (var i = 0; i < rows.length; i++) {
			id += rows[i].inputId + ",";

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
			$.post("form/sortFormItem.zb", {
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
	//删除表单项
	function deleteFormItem(inputId) {
		$.messager.confirm("提示", "您确认要删除吗?", function(r) {
			if (!r) {
				return;
			}
			$.messager.progress({
				title : "提示",
				text : "数据处理中，请稍后...."
			});
			$.post("form/deleteFormItem.zb", {
				formItemId : inputId
			}, function(data) {
				if (data.success) {
					var n = noty({
						text : "操作成功!",
						type : "success",
						layout : "topCenter",
						timeout : 1500
					});
					$("#formItemTable").datagrid("reload");//重新加载功能组表格

				} else {
					$.messager.alert("错误", "删除数据时出现系统错误!", "error");
				}
				$.messager.progress("close");
			}, "json");
		});
	}

	//删除表单
	function deleteForm(formId) {
		$.messager.confirm("提示", "删除表单的同时会删除该表单的表单项，您确认要删除吗?",
				function(r) {
					if (!r) {
						return;
					}
					$.messager.progress({
						title : "提示",
						text : "数据处理中，请稍后...."
					});
					$.post("form/deleteForm.zb", {
						formId : formId
					}, function(data) {
						if (data.success) {
							var n = noty({
								text : "操作成功!",
								type : "success",
								layout : "topCenter",
								timeout : 1500
							});
							$("#formTable").datagrid("reload");
							$("#formItemTable").datagrid("reload");
						} else {
							$.messager.alert("错误", data.msg, "error");
						}
						$.messager.progress("close");
					}, "json");
				});
	}
	
	/**
	*预览表单
	*/
	function initForm(formId,title,colCount){
		var colWidth=100;
		
		$.post("form/selectFormItemByFormId.zb",{formId:formId},function(data){
			//先清除原来的表单
			$("#testFormTable").empty();
			
			
			$("#testFormTable").append("<caption style=\"font-family:微软雅黑;font-size:18px;font-weight:bold\">"+title+"</caption>");
			for(var c=0;c<colCount;c++){
				$("#testFormTable").append("<th></th><th width='"+colWidth+"px'></th>");
			}
			//将表单项添加到表单中
			var trHtml="";
			var rowNo=0;
			for(var i=0;i<data.length;i++){
				var trInput="";
				var formItem=data[i];
				rowNo+=formItem.colspan;
				var colspan=formItem.colspan*2-1;
				if(data[i].inputType=="radio"){
					$.ajax({  
         				type : "post",  
          				url : "dict/getDictItemByDictId.zb",  
          				data : "dictId=" + formItem.dictId, 
          				dataType:"json", 
          				async : false,  
          				success : function(dataOption){  
           					var checked="";
           					for(var j=0;j<dataOption.length;j++){
								if(dataOption[j].itemCode==formItem.defaultValue){
									checked="checked=\"checked\"";
								}else{
									checked="";
								}
							
								trInput=trInput+"<input type=\"radio\" "+checked+" name=\""+formItem.inputName+"\" value=\""+dataOption[j].itemCode+"\" />"+dataOption[j].itemName+"&nbsp;&nbsp;&nbsp;";
								
							} 
          				}  
     				}); 
					
					
				}else{
					trInput="<input class=\"easyui-"+formItem.inputType+"\" type=\"text\"  name=\""+formItem.inputName+"\" data-options=\"valueField:'itemCode',textField:'itemName',url:'dict/getDictItemByDictId.zb?dictId="+formItem.dictId+"'\" style=\"width:100%\" />";
				}
				
    			
				trHtml+="<td align=\"right\">"+formItem.inputDisplay+":</td><td colspan="+colspan+">"+trInput+"</td>";
				if(rowNo%colCount==0){
					$("#testFormTable").append("<tr>"+trHtml+"</tr>");
					trHtml="";
				}else
				if(i==data.length-1){
					$("#testFormTable").append("<tr>"+trHtml+"</tr>");
				
				}
				
				
			}
			$.parser.parse("#testFormTable");
			$("#formDiv").dialog("open");
		},"json");
	}
	
	
</script>
</head>
<body class="easyui-layout">
	<!-- 左侧任务类型列表 -->
	<div data-options="region:'west',title:'表单类型',split:true"
		style="width: 370px;">
		<!-- 工具栏 -->
		<div id="formTB" class="datagrid-toolbar">
			<a onclick="openAddFormDialog()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增</a>
		</div>
		<!-- 任务类型列表 -->
		<table id="formTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'form/selectForm.zb',
			toolbar:'#formTB',  
	        fit: true,
	        border:false,
	        onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
	        onDrop:sortJobType,
	        onClickRow:function(rowIndex, rowData){
	        	$('#formItemTable').datagrid({
					queryParams:{formId:rowData.formId}
				});
	        	
	        }
	        
		">
			<thead>
				<tr>
					<th data-options="field:'formName',width:'220',align:'center'">名称</th>
					<th
						data-options="field:'state',width:'45',align:'center',formatter:statusFlagFormatter">状态</th>
					<th
						data-options="field:'formId',width:'100',align:'center',formatter:formFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- 右侧功能参数列表 -->
	<div data-options="region:'center',title:'表单项列表'">
		<!-- 工具栏 -->
		<div id="tb" style="padding: 2px 0">
			<a onclick="openAddFormItemDialog()" class="easyui-linkbutton"
				data-options="
				iconCls:'icon-add',
				plain:true
			">新增</a>

		</div>
		<table id="formItemTable" class="easyui-datagrid"
			data-options="
			singleSelect:true,
			url : 'form/selectFormItemByFormId.zb',
			queryParams : {formId:'0'},
			toolbar:'#tb',
			onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
			onDrop:sortFormItem,
	        rownumbers: true,
	        fit: true,
	        border:false
	       
	        
		">
			<thead>
				<tr>
					<th data-options="field:'inputName',width:'100'">名称</th>
					<th data-options="field:'inputDisplay',width:'100'">显示名称</th>
					<th data-options="field:'inputDiscription',width:'100'">描述</th>
					<th data-options="field:'colspan',width:'100'">跨栏数</th>
					<th data-options="field:'defaultValue',width:'80'">默认值</th>
					<th	data-options="field:'dataType',width:'80',formatter:dataTypeFormatter">数据类型</th>
					<th data-options="field:'inputType',width:'80',formatter:paramTypeFormatter">编辑类型</th>
					<th data-options="field:'disabled',width:'80',formatter:statusFlagFormatter">状态</th>
					<th data-options="field:'inputId',width:'70',formatter:funFormatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- -------------------------------------------------------------------------------------------------- -->
	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="formFormDlg" class="easyui-dialog"
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
			<form id="formForm" action="form/saveForm.zb" method="post">
				<input type="hidden" name="formId" id="formId" />
				<table style="margin: 0 auto;">


					<tr>
						<td>名称：</td>
						<td><input type="text" name="formName"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:250
							" />
						</td>
					</tr>
					<tr>
						<td>标题：</td>
						<td><input type="text" name="formTitle"
							class="easyui-textbox"
							data-options="
								validType:['length[2,40]','commonChar'],
								required:true,
								width:250
							" />
						</td>
					</tr>
					<tr>
						<td>分栏数：</td>
						<td><input type="text" name="formColumnNumber" value="1" class="easyui-numberbox"
							data-options="
								min:1,
								max:10,
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
						<td><input type="text" name="formDescription"
							class="easyui-textbox" style="height: 150px; width: 250px"
							data-options="validType:'length[0,200]',multiline:true"
							placeholder="不能大于200个字" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlgbtns">
			<a class="easyui-linkbutton" onclick="saveForm()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#formFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div style="display: none;">
		<div id="formItemFormDlg" class="easyui-dialog"
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
			<form id="formItemForm" action="form/saveFormItem.zb"
				method="post">
				<input type="hidden" name="inputId" id="inputId_" />
				<input type="hidden" name="formId" id="formId_" />
				<table style="margin: 0 auto;">

					<tr>

						<td>名称：</td>
						<td><input type="text" name="inputName"
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
						<td><input type="text" name="inputDisplay"
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
								validType:['length[1,40]'],
								width:249
							" />
						</td>
					</tr>
					<tr>
						<td>数据类型：</td>
						<td><input type="text" name="dataType"
							class="easyui-combobox"
							data-options="valueField: 'value',
								textField: 'label',
								required:true,
								data:dataTypeData,
								width:149
							" />

						</td>
					</tr>
					<tr>
						<td>编辑类型：</td>
						<td><input type="text" name="inputType"
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
						<td>跨栏数：</td>
						<td><input type="text" name="colspan"
							class="easyui-numbertbox"
							data-options="
							value:1,
								min:1,
								max:10,
								width:249
							" />
						</td>
					</tr>
					<tr>
							<td>数据字典:</td>
							<td><input id="dictId" class="easyui-combotree" name="dictId"
								style="width: 130px;"
								data-options="
							url:'dict/dictTree.zb.zb',
							
							customAttr: {
								dataModel: 'simpleData',
								textField: 'dictName',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#dictId').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
							</td>
						</tr>
					<tr>
						<td>描述：</td>
						<td><input type="text" name="inputDiscription"
							class="easyui-textbox" style="height: 100px; width: 250px"
							data-options="validType:'length[0,200]',multiline:true"
							placeholder="不能大于200个字" /></td>
					</tr>
					<tr>
						<td>是否启用:</td>
						<td><input type="radio" name="disabled" value="1"
							checked="checked" />是&nbsp;&nbsp;&nbsp; <input type="radio"
							name="state" value="0" />否</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="paramdlgbtns">
			<a class="easyui-linkbutton" onclick="saveFormItem()"
				data-options="iconCls:'icon-ok'">确定</a> <a class="easyui-linkbutton"
				onclick="$('#formItemFormDlg').dialog('close')"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div style="display: none;">
		<div id="formDiv" class="easyui-dialog"
			style="padding-top: 5px"
			data-options="
			title: '表单预览',
		    width: 800,
		    height: 600,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons: '#formdlgbtns'
		">
		<form id="testForm" method="post">
		<table id="testFormTable" style="padding: 10px 0 10px 20px">

						</table>
						</form>
      </div> 
      <div id="formdlgbtns">
			<a class="easyui-linkbutton"
				onclick="$('#formDiv').dialog('close')"
				data-options="iconCls:'icon-cancel'">关闭</a>
		</div>
	</div> 
</body>
</html>
