<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
	/**
	 * 扩展校验框架，增加模块名称校验。机构编码应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkModuleName : {
			validator : function(value, param) {
				var resp = $.ajax({
					url : "module/checkName.zb",
					dataType : "json",
					data : {
						name : value,
						id : $("#moduleId").val(),
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "模块名称已经存在"
		}
	});
	
	/**
	 * 扩展校验框架，增加模块编码校验。机构编码应该唯一。
	 */
	$.extend($.fn.validatebox.defaults.rules, {
		checkModuleCode : {
			validator : function(value, param) {
				var resp = $.ajax({
					url : "module/checkCode.zb",
					dataType : "json",
					data : {
						name : value,
						id : $("#moduleId").val(),
					},
					async : false,
					cache : false,
					type : "post"
				}).responseText;
				return resp == "true";
			},
			message : "模块编码已经存在"
		}
	});
	
	function loadData(pid){
		$("#dg").datagrid("clearChecked");
		$("#dg").datagrid("load",{pid:pid});
		$("#parentId").val(pid);
		
	}
	
	/**
	 * 点击编辑或者增加窗口中的取消按钮操纵。
	 * @param dialog 窗口ID
	 * @param form 表单ID
	 */
	function cancel(dialog,form){
		var $form = $("#"+form);
		var $dialog = $("#"+dialog);
		$dialog.dialog("close");
		$("#moduleId").val("");
	}
	
	/**
	 * 保存信息（增加或者更新）
	 */
	function save(dialog,form){
		var $form = $("#"+form);
		var $dialog = $("#"+dialog);
		$form.form("submit",{
			//提交前验证
			onSubmit:function(param){
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
					parent.readTree();
					$dialog.dialog("close");
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
	/**
	 * 显示新增窗口
	 */
	function openAddDialog(isFolder){
		$("#moduleId").val("");
		var title="新建模块";
		if(isFolder){
			title="新建文件夹";
			//$("#urlRow").hide();
			$("#isFolder").val("1");
			$("#url").textbox("disableValidation");
			$("#funGroupRow").hide();
			
		}else{
			$("#urlRow").show();
			
			$("#isFolder").val("0");
			$("#url").textbox("enableValidation");
			$("#funGroupRow").show();
			
		}
		$("#dlg").dialog({
			title:title,
			iconCls:"icon-add"
			});
		$("#dlg").dialog("open")
	}
	
	/**
	 * 显示编辑窗口，并从后台取数据填充表单
	 */
	function openEditDialog(dataId,isFolder,index){
		$("#moduleId").val("");
// 		var row = $("#dg").datagrid("getSelected");
// 		alert(row.id);
// 		if(!row){//如果没有选中行 
// 			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
// 			return;
// 			
		$("#dg").datagrid("selectRow",index);	
		
		
		var title="编辑模块";
		if(isFolder){
			title="编辑文件夹";
			//$("#urlRow").hide();
			$("#url").textbox("disableValidation");
			
		}else{
			$("#urlRow").show();
			$("#url").textbox("enableValidation");
			
		}
		$("#dlg").dialog({
			title:title,
			iconCls:"icon-edit"
		});
		
		$("#dlg").dialog("open");
		$.post("module/getModuleById.zb?",{id:dataId},function(data){
			if(data.success){
				
				$("#form").form("load",data.extData);
				
			}else{
				$.messager.alert("错误","加载数据时出现系统错误!","error");
			}
			
		},"json");
	}
	
	
	/**
	 * 删除
	 */
	function deleteModule(index){
		if(index != null){
			var row = $("#dg").datagrid("selectRow",index);	
		}
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var id="";
		for(var i=0; i<rows.length; i++){
			if(rows[i].disabled == "0"){
				$.messager.alert("提示","不能删除启用状态的模块!","warning");
				return;
			}
			id+=rows[i].id+",";	
			
		}
			
		id = id.substring(0, id.length-1);
		var msg = "";
		$.messager.confirm("提示", "您确认要删除吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("module/deleteModule.zb",{id:id},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
					parent.readTree();
				}else{
					$.messager.alert("错误","删除数据时出现系统错误!","error");
				}
				$.messager.progress("close");
			},"json");
		});
	}
	/**
	*显示模块树形窗口
	*/
	function showModuleTreeDlg(){
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		$('#moduleTree').tree({
	        url: 'module/getModuleInfoList.zb?onlyFolder=1',
	        customAttr: {
				dataModel: 'simpleData',
				textField: 'moduleName',
				parentField: 'parentId',
				attributes: [],
	        },
	        onLoadSuccess:function(){
	        	var rows = $("#dg").datagrid("getSelections");
	        	for(var i=0;i<rows.length;i++){
	        		var node = $('#moduleTree').tree('find', rows[i].id);
	        		if(node)$("#moduleTree").tree('remove',node.target);
	        	}
	        	$("#moduleTree").tree('collapseAll');
	        	$('#moduleTreeDlg').dialog('open');
	        	
	        	
	        }
	    });
	    
	    
		
	}
	
	/**
	*显示报表文件树形窗口
	*/
	function showReportFileTreeDlg(){
		
		$('#reportFileTree').tree({
	        url: 'raqsoft/getReportFileList.zb?fileSuffix=rpx',
	        customAttr: {
				dataModel: 'simpleData',
				textField: 'name',
				parentField: 'parentId',
				attributes: [],
	        },
	        onLoadSuccess:function(){
	        	
	        	$("#reportFileTree").tree('collapseAll');
	        	$('#reportFileTreeDlg').dialog('open');
	        	
	        	
	        }
	    });
	    
	    
		
	}
	function isFileType(str,endStr){
	      var d=str.length-endStr.length;
	      return (d>=0&&str.lastIndexOf(endStr)==d);
	    }
	function setReportUrl(){
		var node=$("#reportFileTree").tree('getSelected');;
		if(node == null){
			var n = noty({text: "请选择报表!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		if(node.folder){
			var n = noty({text: "只能选择报表文件!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var fileName=node.id;
		fileName=fileName.toUpperCase();
		//alert(fileName);
		var url="reportJsp/showReport.jsp?rpx="+node.id;
		
		if(isFileType(fileName,".SHT")){
		 url="reportJsp/showInput.jsp?sht="+node.id;
		
		}else
		if(isFileType(fileName,".RPG")){
		 url="reportJsp/showReportGroup.jsp?rpg="+node.id;
		
		}
		$("#url").textbox("setValue",url);
		$('#reportFileTreeDlg').dialog('close');
	
	}
	/**
	 * 移动
	 */
	function moveModule(){
		
		var parentNode=$("#moduleTree").tree('getSelected');;
		if(parentNode == null){
			var n = noty({text: "请选择移动目标!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		if(parentNode.isFolder!='1'){
			var n = noty({text: "只能移动到文件夹下!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var parentId=parentNode.id;
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		if(parentId==rows[0].parentId){
    		var n = noty({text: "不能移动模块到当前父节点!",type:"warning",layout:"topCenter",timeout:1500});
    		return;
    	}
		var id="";
		for(var i=0; i<rows.length; i++){
			id+=rows[i].id+",";	
			
		}
			
		id = id.substring(0, id.length-1);
		var msg = "";
		$.messager.confirm("提示", "您确认要移动吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("module/moveModule.zb",{id:id,parentId:parentId},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
					parent.readTree();
				}else{
					$.messager.alert("错误","更新数据时出现系统错误!","error");
				}
				$.messager.progress("close");
				$('#moduleTreeDlg').dialog('close');
			},"json");
		});
	}
	/**
	 * 排序
	 */
	function sortModule(){
		var rows=$("#dg").datagrid("getRows");
		var id="";
		for(var i=0; i<rows.length; i++){
			id+=rows[i].id+",";	
			
		}
			
		id = id.substring(0, id.length-1);
		var msg = "";
		$.messager.confirm("提示", "您确认要排序吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("module/moveModule.zb",{id:id},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
					parent.readTree();
				}else{
					$.messager.alert("错误","更新数据时出现系统错误!","error");
				}
				$.messager.progress("close");
			},"json");
		});
	}
	
	/**
	 * 模块类型Formatter
	 */
	function typeFormatter(value,row,index){
		switch (value) {
		case "1":
			return "模块";
		case "2":
			return "功能";
		default:
			return "未知";
		}
		
	}

	/**
	 * 是否是公共模块Formatter
	 */
	function publisFlagFormatter(value,row,index){
		switch (value) {
		case "0":
			return "否";
		case "1":
			return "是";
		default:
			return "未知";
		}
	}
	/**
	 * 图标Formatter
	 */
	function iconFormatter(value,row,index){
		if (value==null||value.length==0) {
			
			return "";
		}else{
			return "<img src='images/icons/modules/tree/"+value+".png'/>"
		}
	}
	/**
	 * 模块状态Formatter
	 */
	function statusFlagFormatter(value,row,index){
		switch (value) {
		case "0":
			return "启用";
		case "1":
			return "禁用";
		default:
			return "未知";
		}
	}
	
	var formatter=function(value,row,index){
		var p = "'"+row.id+"'";
		var isFolder=row.isFolder;
		
		//var isFolder="false";
		//if(row.url==null||row.url.length<=0){
		//	isFolder="true";
		//}
	    var s =  " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditDialog("+p+","+isFolder+","+index+")\"></div>";
	    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteModule("+index+")\"></div>";
	    return s;
	}
	//dom ready
	$(function(){
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

</head>
<body>
	<!-- 按钮栏 -->
	<div id="tb" style="height: auto; display: none">
		<a onclick="openAddDialog(true)" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新建文件夹</a> <a
			onclick="openAddDialog(false)" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新建模块</a> <a
			onclick="deleteModule()" class="easyui-linkbutton"
			data-options="iconCls:'icon-del',plain:true">删除</a> <a
			onclick="showModuleTreeDlg()" class="easyui-linkbutton"
			data-options="iconCls:'icon-cut',plain:true">移动</a>
	</div>
	<!-- grid定义 -->
	<table id="dg" class="easyui-datagrid" title="模块列表"
		style="display: none"
		data-options="collapsible:true,
				iconCls:'icon-module',
				url:'module/getModuleByPid.zb',method:'post',
				height:$(this).height(),
				rownumbers:true,
				toolbar: '#tb',
				fit:true,
				fitColumns:true,
				collapsible:false,
				frozenColumns:[[
			    	{field:'ck',checkbox:true}
			    ]],
			    onLoadSuccess:function(){
					$(this).datagrid('enableDnd');
				},
				onDrop:function(targetRow,sourceRow,point){
					sortModule();
				},
				onDblClickRow: function(rowIndex, rowData){
					var isFolder=false;
					if(rowData.url==null||rowData.url.length<=0){
						isFolder=true;
					}
					openEditDialog(rowData.id,isFolder,rowIndex);
				}
			">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:'true'"></th>
				<th data-options="field:'moduleCode',width:100,halign:'left'">编码</th>
				<th
					data-options="field:'moduleName',width:120,align:'left',halign:'left'">名称</th>
					<th data-options="field:'isFolder',width:100,align:'left',halign:'left',formatter:publisFlagFormatter">是否文件夹</th>
				<th data-options="field:'url',width:150,align:'left',halign:'left'">URL地址</th>
				<th
					data-options="field:'iconCls',width:80,align:'left',halign:'left',formatter:iconFormatter">图标</th>
				<!-- <th data-options="field:'moduleType',width:80,align:'left',halign:'left',formatter:typeFormatter">类别</th> -->
				<!-- <th data-options="field:'isPublic',width:100,align:'left',halign:'left',formatter:publisFlagFormatter">是否为公共模块</th> -->
				<th
					data-options="field:'disabled',width:80,align:'left',halign:'left',formatter:statusFlagFormatter">状态</th>
				<th
					data-options="field:'remark',width:200,align:'left',halign:'left',fixed:true">备注</th>
				<th
					data-options="field:'operation',width:70,align:'left',halign:'left',fixed:true,formatter:formatter">操作</th>
			</tr>
		</thead>
	</table>

	<div style="display: none">
		<div id="dlg" class="easyui-dialog" title="编辑模块" style="width: 450px"
			iconCls="icon-edit" modal="true" closed="true" buttons="#dlg-buttons">
			<div style="padding: 10px 0 10px 20px">
				<form id="form" action="module/saveModule.zb" method="post">
					<input type="hidden" id="parentId" name="parentId" value="" /> 
					<input	type="hidden" name="id" id="moduleId" value="" /> 
					<input	type="hidden" name="moduleType" value="1" checked="checked" />
					<input  id="isFolder"	type="hidden" name="isFolder" value="1" />
					<table>
						<tr>
							<td>编码:</td>
							<td><input class="easyui-textbox" type="text"
								name="moduleCode"
								data-options="required:true,validType:['length[1,20]','checkModuleCode','commonChar'],width:250"
								placeholder="不能大于20个字" /></td>
						</tr>
						<tr>
							<td>名称:</td>
							<td><input class="easyui-textbox" type="text"
								name="moduleName"
								data-options="required:true,validType:['length[1,64]','commonChar'],width:250"
								placeholder="不能大于64个字" /></td>
						</tr>
						<tr id="urlRow">
							<td>url地址:</td>
							<td><input id="url" class="easyui-textbox" type="text"
								name="url"
								data-options="required:true,validType:'length[1,255]',width:250"
								placeholder="不能大于255个字" /> <a onclick="showReportFileTreeDlg();"
								class="easyui-linkbutton">选择报表</a></td>

						</tr>
						<tr id="funGroupRow">
							<td>功能组:</td>
							<td><input id="funGroupCode" class="easyui-combobox"
								type="text" name="funGroupCode"
								data-options="
    				 width:149,
    				 valueField:'funGroupCode',
    				 textField:'funGroupName',
    				 url:'moduleFun/getModuleFunGroupOptions.zb'" />
							</td>

						</tr>
						<tr>
							<td>图标:</td>
							<td><input class="easyui-combobox" type="text"
								name="iconCls" placeholder="不能大于255个字"
								data-options="
	    				width:149,
	    				url:'dict/findDictItemByDictCode.zb?dictCode=icon'" />
							</td>
						</tr>
						<!-- <tr>
    			<td>模块类别:</td>
    			<td>
    				<input type="radio" name="moduleType" value="1" checked="checked"/>模块
    				<input type="radio" name="moduleType" value="2"/>功能
    			</td>
    		</tr> -->
						<tr>
							<td>是否启用:</td>
							<td><input type="radio" name="disabled" value="0"
								checked="checked" />是&nbsp;&nbsp;&nbsp; <input type="radio"
								name="disabled" value="1" />否</td>
						</tr>
						<!-- <tr>
    			<td>是否公共模块:</td>
    			<td>
    				<input type="radio" name="isPublic" value="1" />是&nbsp;&nbsp;&nbsp;
    				<input type="radio" name="isPublic" value="0" checked="checked"/>否
    			</td>
    		</tr> -->
						<tr>
							<td>备注:</td>
							<td><textarea name="remark"
									class="easyui-validatebox easyui-textbox"
									style="height: 150px; width: 250px"
									data-options="validType:'length[0,200]'"
									placeholder="不能大于200个字"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="dlg-buttons">
				<a onclick="save('dlg','form');" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'">确定</a> <a
					onclick="cancel('dlg','form');" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>



	<div id="moduleTreeDlg" class="easyui-dialog"
		data-options="closed:true" title="移动模块" style="width: 400px"
		iconCls="icon-edit" modal="true" closed="true"
		buttons="#moduleTreeDlg-buttons">
		<div
			style="padding: 10px 0 10px 20px; width: 360px; height: 250px; overflow: auto">
			<ul id="moduleTree"></ul>
		</div>

		<div id="moduleTreeDlg-buttons">
			<a onclick="moveModule();" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="$('#moduleTreeDlg').dialog('close');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="reportFileTreeDlg" class="easyui-dialog"
		data-options="closed:true" title="选择报表" style="width: 400px"
		iconCls="icon-edit" modal="true" closed="true"
		buttons="#reportFileTreeDlg-buttons">
		<div
			style="padding: 10px 0 10px 20px; width: 360px; height: 250px; overflow: auto">
			<ul id="reportFileTree"></ul>
		</div>

		<div id="reportFileTreeDlg-buttons">
			<a onclick="setReportUrl();" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="$('#reportFileTreeDlg').dialog('close');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>