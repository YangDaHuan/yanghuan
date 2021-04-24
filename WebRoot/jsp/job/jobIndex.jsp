<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="js/cron.js"></script>
<script type="text/javascript">
	var currentJobGroupId ="0";
	function readTree() {

		var setting = {
			edit : {
				enable : true,
				showRemoveBtn : false,
				showRenameBtn : false,

			},

			data : {
				keep : {
					parent : true,
					leaf : true
				},
				key : {
					name : "jobGroupName",
				},
				simpleData : {
					enable : true,
					idKey : "jobGroupId",
					pIdKey : "parentId",
					rootPId : 0
				}
			},
			callback : {
				onClick : function(event, treeId, treeNode, clickFlag) {
					currentJobGroupId=treeNode.jobGroupId;
					loadData(treeNode.jobGroupId);

				},
				onDrop : function(event, treeId, treeNodes, targetNode,
						moveType, isCopy) {
					var parentNode;
					if (moveType == null) {
						$.messager.alert("错误", "拖拽无效!", "error");
						return;
					}
					if (targetNode == null) {
						$.messager.alert("错误", "不能拖拽到任务树之外!", "error");
						return;
					}
					if (moveType == "inner") {
						parentNode = targetNode;
					} else {
						parentNode = targetNode.getParentNode();

					}
					var id = "";
					var nodes = parentNode.children;
					for (var i = 0; i < nodes.length; i++) {
						id += nodes[i].id + ",";

					}
					id = id.substring(0, id.length - 1);

					$.post("job/moveJobGroup.zb", {
						id : id,
						parentId : parentNode.id
					}, function(data) {
						if (data.success) {
							var n = noty({
								text : "操作成功!",
								type : "success",
								layout : "topCenter",
								timeout : 1500
							});
							$("#dg").datagrid("load");
						} else {
							$.messager.alert("错误", "更新数据时出现系统错误!", "error");
						}
						$.messager.progress("close");
					}, "json");
				}

			},
			view : {
				selectedMulti : false
			}
		};

		$.post("job/selectJobGroup.zb", {}, function(data) {
			if (data) {
				for (var i = 0; i < data.length; i++) {
					data[i].icon = null;
					data[i].isParent = true;
				}
				$.fn.zTree.init($("#jobGroupTree"), setting, data);
				var jobGroupTree = $.fn.zTree.getZTreeObj("jobGroupTree");
				jobGroupTree.expandAll(true);

			} else {
				$.messager.alert("错误", "查询数据时出现系统错误!", "error");
			}
			$.messager.progress("close");
		}, "json");

	}
	$(document).ready(function() {
		readTree();

	});
	/**
	 * 显示新增窗口
	 */
	function openAddDialog(){
		$("#jobGroupId").val("");
		$("#form").form("reset");
		$("#dlg").dialog({
			title:"新建文件夹",
			iconCls:"icon-add"
			});
		$("#jobDlgTabs").tabs('enableTab',0);
		$("#dlg").dialog("open")
	}
	
	/**
	 * 显示编辑窗口，并从后台取数据填充表单
	 */
	function openEditDialog(){
			
		var jobGroupTree = $.fn.zTree.getZTreeObj("jobGroupTree");
		
		$("#dlg").dialog({
			title:"编辑文件夹",
			iconCls:"icon-edit"
		});
		
		$("#dlg").dialog("open");

		$.post("job/getJobGroupById.zb?",{jobGroupId:currentJobGroupId},function(data){
			if(data.success){
				
				$("#form").form("load",data.extData);
				
			}else{
				$.messager.alert("错误","加载数据时出现系统错误!","error");
			}
			
		},"json");
		
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
		$("#parentId").val("");
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
					readTree();
					$dialog.dialog("close");
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
	function deleteJobGroup(){
		
		$.messager.confirm("提示", "您确认要删除吗?",
				function(r) {
					if (!r) {
						return;
					}
					$.messager.progress({
						title : "提示",
						text : "数据处理中，请稍后...."
					});
					$.post("job/deleteJobGroup.zb?",{jobGroupId:currentJobGroupId},function(data){
						if(data.success){
							
							readTree();
							
						}else{
							$.messager.alert("错误",data.msg,"error");
						}
						$.messager.progress("close");
					},"json");
					
				});
		
		
	}
	
	
	
	
	
	function loadData(pid){
		$("#dg").datagrid("clearChecked");
		$("#dg").datagrid("load",{jobGroupId:pid});
		currentJobGroupId=pid;
		
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
		$("#jobId").val("");
	}
	
	/**
	 * 保存信息（增加或者更新）
	 */
	function saveJob(dialog,form){
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
	 * 显示新增任务窗口
	 */
	function openJobDialog(){
		$("#jobForm").form("reset");
		$("#jobId").val("");
		$("#groupId").val(currentJobGroupId);
		$('#cronexp').textbox("setValue","* * * * * ? *");
		$("#jobDlg").dialog({
			title:"新建任务",
			iconCls:"icon-add"
			});

		$("#jobDlgTabs").tabs('select',0);
		$("#jobDlg").dialog("open")
	}
	
	/**
	 * 显示编辑窗口，并从后台取数据填充表单
	 */
	function openEditDialog(dataId,jobTypeId,index){
		$("#jobForm").form("clear");
		$("#dg").datagrid("selectRow",index);	
		
		
		
		$("#jobDlg").dialog({
			title:"编辑任务",
			iconCls:"icon-edit"
		});
		initJobTypeParam(jobTypeId,dataId);
		
		
	}
	
	/**
	 * 执行任务
	 */
	function triggerJob(index){
		if(index != null){
			var row = $("#dg").datagrid("selectRow",index);	
		}
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var id="";
		var group="";
		for(var i=0; i<rows.length; i++){
			if(rows[i].state == "0"){
				$.messager.alert("提示","不能执行禁用状态的模块!","warning");
				return;
			}
			id+=rows[i].jobId;
			group=rows[i].jobGroupId;
			
		}
			
		var msg = "";
		$.messager.confirm("提示", "您确认要执行吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("job/triggerJob.zb",{jobId:id,jobGroupId:group},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
				}else{
					$.messager.alert("错误",data.Msg,"error");
				}
				$.messager.progress("close");
			},"json");
		});
		
	}
	/**
	 * 删除
	 */
	function deleteJob(index){
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
			if(rows[i].state == "1"){
				$.messager.alert("提示","不能删除启用状态的模块!","warning");
				return;
			}
			id+=rows[i].jobId+",";	
			
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
			$.post("job/deleteJob.zb",{jobId:id},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
				}else{
					$.messager.alert("错误","删除数据时出现系统错误!","error");
				}
				$.messager.progress("close");
			},"json");
		});
	}
	
	function parseOptions(s){
		var options = {};
		
		if (s){
			if (s.substring(0, 1) != '{'){
				s = '{' + s + '}';
			}
			options = (new Function('return ' + s))();
		}
			return options;
	}
	/**
	*改变任务类型，变换任务参数
	*/
	function initJobTypeParam(jobTypeId,jobId){
		
		$.post("job/getJobTypeParamListByTypeId.zb",{jobTypeId:jobTypeId},function(data){
			//先清除原来的任务参数
			$("#jobParamsTable").empty();
			//将任务参数添加到表单中
			for(var i=0;i<data.length;i++){
				var trInput="";
				
				if(data[i].paramType=="radio"){
					var dataOption=parseOptions(data[i].dataOption);
					var checked="";
					for(var j=0;j<dataOption.data.length;j++){
						if(dataOption.data[j].checked){
							checked="checked=\"checked\"";
						}else{
							checked="";
						}
						trInput=trInput+"<input type=\"radio\" "+checked+" name=\""+data[i].paramName+"\" value=\""+dataOption.data[j][dataOption.valueField]+"\" />"+dataOption.data[j][dataOption.textField]+"&nbsp;&nbsp;&nbsp;";
					}
					
				}else{
					var dataOptionStr=data[i].dataOption;
					if(dataOptionStr==null)dataOptionStr=""
					trInput="<input class=\"easyui-"+data[i].paramType+"\" type=\"text\"  name=\""+data[i].paramName+"\" data-options=\""+dataOptionStr+"\" style=\"width:250px\" />";
				}
				
    			
				var trHtml="<tr><td>"+data[i].discription+":</td><td>"+trInput+"</td></tr>";
				$("#jobParamsTable").append(trHtml);
				
			}
			
			$.parser.parse("#jobParamsTable");
			if(jobId!=null){
				$.post("job/getJobById.zb?",{jobId:jobId},function(data){
					if(data.success){
						var formData=data.extData;
						var params=data.extData.params;
						for(var i=0;i<params.length;i++){
							var name=params[i].paramName;
							var value=params[i].paramValue;
							formData[name]=value;
						}
						$("#jobForm").form("load",formData);
						$("#jobDlgTabs").tabs('select',0);
						$("#jobDlg").dialog("open");
						
					}else{
						$.messager.alert("错误","加载数据时出现系统错误!","error");
					}
					
				},"json");
			}
		},"json");
	}
	/**
	*改变任务类型，变换任务参数
	*/
	function changeJobType(record){
		var jobTypeId=record.jobTypeId;
		initJobTypeParam(jobTypeId);
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
	
	var formatter=function(value,row,index){
		var p = "'"+row.jobId+"'";
		var jobTypeId="'"+row.jobTypeId+"'";
		var g = "'"+row.jobGroupId+"'";
	    var s =  " <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\"  title=\"编辑\" onclick=\"openEditDialog("+p+","+jobTypeId+","+index+")\"></div>";
	    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-start\" title=\"执行\" onclick=\"triggerJob("+index+")\"></div>";
	    s+=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteJob("+index+")\"></div>";
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
	
	function initJobs(){
		$.post("job/initJobs.zb",{},function(data){
			if(data.success){
				$.noty.closeAll();
				var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误","装载任务过程出现错误!","error");
			}
		},"json");
	}
	
	function startJobs(){
		$.post("job/startJobs.zb",{},function(data){
			if(data.success){
				$.noty.closeAll();
				var n = noty({text: "启动成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误",data.msg,"error");
			}
		},"json");
	}
	function stopJobs(){
		$.post("job/stopJobs.zb",{},function(data){
			if(data.success){
				$.noty.closeAll();
				var n = noty({text: "停止成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误","停止过程出现错误!","error");
			}
		},"json");
	}

	//功能列表排序
	function sortJobs(targetRow, sourceRow, point) {
		var rows = $(this).datagrid("getRows");
		var id = "";
		for (var i = 0; i < rows.length; i++) {
			id += rows[i].jobId + ",";

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
			$.post("job/sortJobs.zb", {
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
	
</script>

</head>
<body class="easyui-layout" data-options="fit:true">
	<!--left-->
	<div data-options="region:'west',title:'任务树',split:true,border:true"
		style="width: 215px;">
		<div class="datagrid-toolbar">
			<a id="btnAdd" onclick="openAddDialog()" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-add'">新增</a> <a id="btnEdit"
				onclick="openEditDialog();" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-edit'">修改</a> <a id="btnDel"
				onclick="deleteJobGroup();" class="easyui-linkbutton"
				data-options="plain:true,iconCls:'icon-del'">删除</a>
		</div>
		<ul id="jobGroupTree" class="ztree"></ul>
	</div>
	<!--right-->
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<!-- <iframe id="iframe" src="jsp/job/jobList.jsp"
			name="dict_right_iframe" class="iframeApp" frameborder="0"
			SCROLLING="no" marginwidth="0" marginheight="0"
			style="width: 100%; height: 100%;"></iframe> -->
		<!-- 按钮栏 -->
		<div id="tb" style="height: auto; display: none">
			<a onclick="openJobDialog()" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">新建任务</a> <a
				onclick="deleteJob()" class="easyui-linkbutton"
				data-options="iconCls:'icon-del',plain:true">删除</a> <a
				onclick="initJobs()" class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true">重新装载所有任务</a> <a
				onclick="startJobs()" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true">启动调度器</a> <a
				onclick="stopJobs()" class="easyui-linkbutton"
				data-options="iconCls:'icon-no',plain:true">停止调度器</a>
		</div>
		<!-- grid定义 -->
		<table id="dg" class="easyui-datagrid" title="任务列表"
			style="display: none"
			data-options="collapsible:true,
				iconCls:'icon-module',
				url:'job/selectJobByGroupId.zb',method:'post',
				queryParams: {
					jobGroupId: '0'
				},
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
				onDrop:sortJobs,
				onDblClickRow: function(rowIndex, rowData){
					var isFolder=false;
					var jobTypeId=rowData.jobTypeId;
					openEditDialog(rowData.jobId,jobTypeId,rowIndex);
				}
			">
			<thead>
				<tr>
					<th data-options="field:'id',hidden:'true'"></th>
					<th data-options="field:'jobName',width:60,halign:'left'">任务名称</th>
					<th data-options="field:'discription',width:100,halign:'left'">描述</th>
					<th
						data-options="field:'cronexp',width:50,align:'left',halign:'left'">CRON表达式</th>
					<th
						data-options="field:'nextFireTime',width:50,align:'left',halign:'left'">下次執行時間</th>
					<th
						data-options="field:'timeout',width:40,align:'left',halign:'left'">超时时长</th>
					<th
						data-options="field:'retryCount',width:20,align:'left',halign:'left'">重试次数</th>
					<th
						data-options="field:'state',width:20,align:'left',halign:'left',formatter:statusFlagFormatter">状态</th>
					<th
						data-options="field:'operation',width:100,align:'left',halign:'left',fixed:true,formatter:formatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="display: none">
		<div id="dlg" class="easyui-dialog" title="编辑文件夹" style="width: 400px"
			iconCls="icon-edit" modal="true" closed="true" buttons="#dlg-buttons">
			<div style="padding: 10px 0 10px 20px">
				<form id="form" action="job/saveJobGroup.zb" method="post">
					<input type="hidden" id="parentId" name="parentId" value="" /> <input
						type="hidden" name="jobGroupId" id="jobGroupId" value="" /> <input
						type="hidden" name="userId" id="userId" value="" /> <input
						type="hidden" name="state" id="state" value="1" />


					<table>
						<tr>
							<td>名称:</td>
							<td><input class="easyui-validatebox" type="text"
								name="jobGroupName"
								data-options="required:true,validType:['length[1,64]','checkjobGroupName','commonChar']"
								placeholder="不能大于64个字" /></td>
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

	<div style="display: none">
		<div id="jobDlg" class="easyui-dialog" title="编辑任务"
			style="width: 400px; height: 400px" iconCls="icon-edit" modal="true"
			closed="true" buttons="#jobDlg-buttons">

			<form id="jobForm" action="job/saveJob.zb" method="post">
				<input type="hidden" id="jobId" name="jobId" value="" /> <input
					type="hidden" name="jobGroupId" id="groupId" value="" /> <input
					type="hidden" name="userId" id="userId" value="" />

				<div class="easyui-tabs" id="jobDlgTabs"
					style="width: 384px; height: 320px;">
					<div id="jobDlgTab1" title="基本信息" style="height: 400px">
						<table style="padding: 10px 0 10px 20px">
							<tr>
								<td>任务名称:</td>
								<td><input class="easyui-textbox" type="text"
									name="jobName" style="width: 250px"
									data-options="required:true,validType:['length[1,64]','checkjobGroupName','commonChar']"
									placeholder="不能大于64个字" /></td>
							</tr>
							<tr>
								<td>任务类型:</td>
								<td><input id="jobTypeIdCombo" class="easyui-combobox"
									name="jobTypeId" style="width: 250px"
									data-options="
    				 width:149,
    				 onSelect:changeJobType,
    				 valueField:'jobTypeId',
    				 textField:'jobTypeName',
    				 url:'job/getJobTypeList.zb?state=1'" />

								</td>
							</tr>
							<tr>
								<td>执行周期:</td>
								<td><input id="cronexp" class="easyui-textbox" type="text"
									name="cronexp" style="width: 200px"
									data-options="required:true" /> <a class="easyui-linkbutton"
									data-options="iconCls:'icon-edit',onClick:function(){
    				cronEditor.resolveCron($('#cronexp').textbox('getValue'));
    				$('#cronDlg').dialog('open');
    				}">编辑</a>
								</td>
							</tr>
							<tr>
								<td>超时时长:</td>
								<td><input class="easyui-numberbox" type="text"
									name="timeout" style="width: 250px" /></td>
							</tr>
							<tr>
								<td>重试次数:</td>
								<td><input class="easyui-numberspinner"
									style="width: 80px;" name="retryCount" style="width:250px"
									required="required" data-options="min:0,max:10,editable:false">
								</td>
							</tr>
							<tr>
								<td>日志保留天数:</td>
								<td><input class="easyui-numberspinner"
									style="width: 80px;" name="logDays" style="width:250px"
									required="required" data-options="min:1,max:1000,editable:true">
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
									class="easyui-textbox" style="height: 80px; width: 250px"
									data-options="validType:'length[0,200]',multiline:true"
									placeholder="不能大于200个字" /></td>
							</tr>
						</table>
					</div>
					<div id="jobDlgTab2" title="任务参数">
						<table id="jobParamsTable" style="padding: 10px 0 10px 20px">

						</table>
					</div>
				</div>





			</form>
			<div id="jobDlg-buttons">
				<a onclick="saveJob('jobDlg','jobForm');" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'">确定</a> <a
					onclick="cancel('jobDlg','jobForm');" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
	<div style="display: none">
		<div id="cronDlg" class="easyui-dialog" title="编辑执行周期"
			style="width: 600px" iconCls="icon-edit" modal="true" closed="true"
			buttons="#cronDlg-buttons">
			<table style="padding: 10px 0 10px 20px">
				<tr>
					<td width="50px">年：</td>
					<td width="150px"><select id="yearCronType"
						class="easyui-combobox" style="width: 150px;"
						data-options="onChange:cronEditor.selectYearType">
							<option value="1">任意</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>

					</select></td>
					<td>
						<div id="cronYearRangeDiv" style="display: none">
							<input id="cronYear_beginYear" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:2016,max:2099">年-
							<input id="cronYear_endYear" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:2016,max:2099">年

						</div>
						<div id="cronYearIntervalDiv" style="display: none">
							从<input id="cronYear_startYear" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:2016,max:2099">开始，每
							<input id="cronYear_countYear" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:9">年执行一次

						</div>
						<div id="cronYearValueDiv" style="display: none">
							<select id="cronYear_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="2016">2016年</option>
								<option value="2017">2017年</option>
								<option value="2018">2018年</option>
								<option value="2019">2019年</option>
								<option value="2020">2020年</option>
								<option value="2021">2021年</option>
								<option value="2022">2022年</option>
								<option value="2023">2023年</option>
								<option value="2024">2024年</option>

							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>月：</td>
					<td><select id="monthCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectMonthType">
							<option selected value="1">任意</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>

					</select></td>
					<td>
						<div id="cronMonthRangeDiv" style="display: none">
							<input id="cronMonth_beginMonth" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:12">月- <input
								id="cronMonth_endMonth" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:12">月

						</div>
						<div id="cronMonthIntervalDiv" style="display: none">
							从<input id="cronMonth_startMonth" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:12">月开始，每 <input
								id="cronMonth_countMonth" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:100">月执行一次

						</div>
						<div id="cronMonthValueDiv" style="display: none">
							<select id="cronMonth_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="1">1月</option>
								<option value="2">2月</option>
								<option value="3">3月</option>
								<option value="4">4月</option>
								<option value="5">5月</option>
								<option value="6">6月</option>
								<option value="7">7月</option>
								<option value="8">8月</option>
								<option value="9">9月</option>
								<option value="10">10月</option>
								<option value="11">11月</option>
								<option value="12">12月</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>周：</td>
					<td><select id="weekCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectWeekType">
							<option value="1">任意</option>
							<option value="2">不指定</option>
							<option value="3">范围</option>
							<option value="5">值</option>
							<option value="6">第几周</option>
							<option value="7">本月最后一个</option>
					</select></td>
					<td>
						<div id="cronWeekRangeDiv" style="display: none">
							<select id="cronWeek_beginWeek" class="easyui-combobox"
								style="width: 100px;">
								<option value="1">星期日</option>
								<option value="2">星期一</option>
								<option value="3">星期二</option>
								<option value="4">星期三</option>
								<option value="5">星期四</option>
								<option value="6">星期五</option>
								<option value="7">星期六</option>
							</select> - <select id="cronWeek_endWeek" class="easyui-combobox"
								style="width: 100px;">
								<option value="1">星期日</option>
								<option value="2">星期一</option>
								<option value="3">星期二</option>
								<option value="4">星期三</option>
								<option value="5">星期四</option>
								<option value="6">星期五</option>
								<option value="7">星期六</option>
							</select>
						</div>
						<div id="cronWeekValueDiv" style="display: none">
							<select id="cronWeek_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="1">星期日</option>
								<option value="2">星期一</option>
								<option value="3">星期二</option>
								<option value="4">星期三</option>
								<option value="5">星期四</option>
								<option value="6">星期五</option>
								<option value="7">星期六</option>

							</select>
						</div>
						<div id="cronWeekNumberDiv" style="display: none">
							第<input id="cronMonth_weekNumber" class="easyui-numberspinner"
								style="width: 50px;" data-options="min:1,max:5" />周的 <select
								id="cronWeek_numberValue" class="easyui-combobox"
								style="width: 100px;">
								<option value="1">星期日</option>
								<option value="2">星期一</option>
								<option value="3">星期二</option>
								<option value="4">星期三</option>
								<option value="5">星期四</option>
								<option value="6">星期五</option>
								<option value="7">星期六</option>

							</select>
						</div>
						<div id="cronWeekLastDiv" style="display: none">
							<select id="cronWeek_lastValue" class="easyui-combobox"
								style="width: 100px;">
								<option value="1">星期日</option>
								<option value="2">星期一</option>
								<option value="3">星期二</option>
								<option value="4">星期三</option>
								<option value="5">星期四</option>
								<option value="6">星期五</option>
								<option value="7">星期六</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>日：</td>
					<td><select id="dayCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectDayType">
							<option value="1">任意</option>
							<option value="2">不指定</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>
							<option value="8">月末</option>
							<option value="9">工作日</option>
							<option value="10">本月最后一个工作日</option>
					</select></td>
					<td>
						<div id="cronDayRangeDiv" style="display: none">
							<input id="cronDay_beginDay" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:31">日- <input
								id="cronDay_endDay" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:31">日

						</div>
						<div id="cronDayIntervalDiv" style="display: none">
							从<input id="cronDay_startDay" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:31">日开始，每 <input
								id="cronDay_countDay" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:100">天执行一次

						</div>
						<div id="cronDayValueDiv" style="display: none">
							<select id="cronDay_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="1">01日</option>
								<option value="2">02日</option>
								<option value="3">03日</option>
								<option value="4">04日</option>
								<option value="5">05日</option>
								<option value="6">06日</option>
								<option value="7">07日</option>
								<option value="8">08日</option>
								<option value="9">09日</option>
								<option value="10">10日</option>
								<option value="11">11日</option>
								<option value="12">12日</option>
								<option value="13">13日</option>
								<option value="14">14日</option>
								<option value="15">15日</option>
								<option value="16">16日</option>
								<option value="17">17日</option>
								<option value="18">18日</option>
								<option value="19">19日</option>
								<option value="20">20日</option>
								<option value="21">21日</option>
								<option value="22">22日</option>
								<option value="23">23日</option>
								<option value="24">24日</option>
								<option value="25">25日</option>
								<option value="26">26日</option>
								<option value="27">27日</option>
								<option value="28">28日</option>
								<option value="29">29日</option>
								<option value="30">30日</option>
								<option value="31">31日</option>
							</select>
						</div>
						<div id="cronDayWorkDiv" style="display: none">
							每月<input id="cronDay_workDay" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:31">日最近的工作日
						</div>
					</td>
				</tr>
				<tr>
					<td>小时：</td>
					<td><select id="hourCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectHourType">
							<option selected value="1">任意</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>

					</select></td>
					<td>
						<div id="cronHourRangeDiv" style="display: none">
							<input id="cronHour_beginHour" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:23">点- <input
								id="cronHour_endHour" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:23">点

						</div>
						<div id="cronHourIntervalDiv" style="display: none">
							从<input id="cronHour_startHour" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:23">点开始，每 <input
								id="cronHour_countHour" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:100">小时执行一次

						</div>
						<div id="cronHourValueDiv" style="display: none">
							<select id="cronHour_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="0">00</option>
								<option value="1">01</option>
								<option value="2">02</option>
								<option value="3">03</option>
								<option value="4">04</option>
								<option value="5">05</option>
								<option value="6">06</option>
								<option value="7">07</option>
								<option value="8">08</option>
								<option value="9">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>分钟：</td>
					<td><select id="minuteCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectMinuteType">
							<option selected value="1">任意</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>

					</select></td>
					<td>
						<div id="cronMinuteRangeDiv" style="display: none">
							<input id="cronMinute_beginMinute" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">分- <input
								id="cronMinute_endMinute" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">分

						</div>
						<div id="cronMinuteIntervalDiv" style="display: none">
							从<input id="cronMinute_startMinute" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">分开始，每 <input
								id="cronMinute_countMinute" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:100">分钟执行一次

						</div>
						<div id="cronMinuteValueDiv" style="display: none">
							<select id="cronMinute_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="0">00</option>
								<option value="1">01</option>
								<option value="2">02</option>
								<option value="3">03</option>
								<option value="4">04</option>
								<option value="5">05</option>
								<option value="6">06</option>
								<option value="7">07</option>
								<option value="8">08</option>
								<option value="9">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
								<option value="32">32</option>
								<option value="33">33</option>
								<option value="34">34</option>
								<option value="35">35</option>
								<option value="36">36</option>
								<option value="37">37</option>
								<option value="38">38</option>
								<option value="39">39</option>
								<option value="40">40</option>
								<option value="41">41</option>
								<option value="42">42</option>
								<option value="43">43</option>
								<option value="44">44</option>
								<option value="45">45</option>
								<option value="46">46</option>
								<option value="47">47</option>
								<option value="48">48</option>
								<option value="49">49</option>
								<option value="50">50</option>
								<option value="51">51</option>
								<option value="52">52</option>
								<option value="53">53</option>
								<option value="54">54</option>
								<option value="55">55</option>
								<option value="56">56</option>
								<option value="57">57</option>
								<option value="58">58</option>
								<option value="59">59</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>秒钟：</td>
					<td><select id="secondCronType" class="easyui-combobox"
						style="width: 150px;"
						data-options="onChange:cronEditor.selectSecondType">
							<option selected value="1">任意</option>
							<option value="3">范围</option>
							<option value="4">间隔</option>
							<option value="5">值</option>

					</select></td>
					<td>
						<div id="cronSecondRangeDiv" style="display: none">
							<input id="cronSecond_beginSecond" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">分- <input
								id="cronSecond_endSecond" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">分

						</div>
						<div id="cronSecondIntervalDiv" style="display: none">
							从<input id="cronSecond_startSecond" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:0,max:59">秒开始，每 <input
								id="cronSecond_countSecond" class="easyui-numberspinner"
								style="width: 80px;" data-options="min:1,max:100">秒执行一次

						</div>
						<div id="cronSecondValueDiv" style="display: none">
							<select id="cronSecond_value" class="easyui-combobox"
								style="width: 100px;" data-options="multiple:true">
								<option value="0">00</option>
								<option value="1">01</option>
								<option value="2">02</option>
								<option value="3">03</option>
								<option value="4">04</option>
								<option value="5">05</option>
								<option value="6">06</option>
								<option value="7">07</option>
								<option value="8">08</option>
								<option value="9">09</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
								<option value="32">32</option>
								<option value="33">33</option>
								<option value="34">34</option>
								<option value="35">35</option>
								<option value="36">36</option>
								<option value="37">37</option>
								<option value="38">38</option>
								<option value="39">39</option>
								<option value="40">40</option>
								<option value="41">41</option>
								<option value="42">42</option>
								<option value="43">43</option>
								<option value="44">44</option>
								<option value="45">45</option>
								<option value="46">46</option>
								<option value="47">47</option>
								<option value="48">48</option>
								<option value="49">49</option>
								<option value="50">50</option>
								<option value="51">51</option>
								<option value="52">52</option>
								<option value="53">53</option>
								<option value="54">54</option>
								<option value="55">55</option>
								<option value="56">56</option>
								<option value="57">57</option>
								<option value="58">58</option>
								<option value="59">59</option>
							</select>
						</div>
					</td>
				</tr>

			</table>

		</div>
		<div id="cronDlg-buttons">
			<a
				onclick="$('#cronexp').textbox('setValue',cronEditor.getCronExp());$('#cronDlg').dialog('close');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="$('#cronDlg').dialog('close');" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>

