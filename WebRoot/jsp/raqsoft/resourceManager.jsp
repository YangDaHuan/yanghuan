<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
	function readTree(){
		
		var setting = {
				edit: {
					enable: true,
					showRemoveBtn: false,
					showRenameBtn: false,
					
				},
				
				data: {
					keep: {
						parent: true,
						leaf: true
					},
					simpleData: {
						enable: true,
						idKey: "id",
						pIdKey: "parentId",
						rootPId: 0
					}
				},
				callback: {
					onClick: function(event, treeId, treeNode, clickFlag){
						loadData(treeNode.id);
						
						
					},
					onDrop: function(event, treeId, treeNodes, targetNode, moveType, isCopy){
						var parentNode;
			        	if(moveType==null){
			        		$.messager.alert("错误","拖拽无效!","error");
			        		return;
			        	}
			        	if(targetNode==null){
			        		$.messager.alert("错误","不能拖拽到树之外!","error");
			        		return;
			        	}
			        	if(moveType=="inner"){
			        		parentNode=targetNode;
			        	}else{
			        		parentNode=targetNode.getParentNode();

			        	}
			        	var newPath=parentNode.id;
			        	var oldPath=treeNodes[0].id.substring(0,treeNodes[0].id.length-treeNodes[0].name.length);
			        	var names=treeNodes[0].name;
			        	
			        	repath(newPath,oldPath,names);
			    		
			    		
					}
					
				},
				view: {
					selectedMulti: false
				}
		};
		
		$.post("raqsoft/getReportFileList.zb?fileSuffix=directory",{},function(data){
			if(data){
				
				$.fn.zTree.init($("#tt"), setting, data);
				var moduleTree=$.fn.zTree.getZTreeObj("tt");
				moduleTree.expandAll(true);
				
				
			}else{
				$.messager.alert("错误","查询数据时出现系统错误!","error");
			}
			$.messager.progress("close");
			$('#moduleTreeDlg').dialog('close');
		},"json");
		
		
	}
	function loadData(pid){
		$("#dg").datagrid("clearChecked");
		$("#dg").datagrid("load",{pid:pid});
		$("#path").val(pid);
		
	}
	
	var formatter=function(value,row,index){
		var fileName = row.name;
		var filePath = row.id;
		
	    var s =  " <a href=\"raqsoft/download.zb?fileName="+fileName+"&filePath="+filePath+"\"><div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-save\"  title=\"下载\" ></div></a>";
	    var d=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-del\" title=\"删除\" onclick=\"deleteFile('"+filePath+"')\"></div>";
	    var r=" <div style=\"float:left;display:inline;width: 30px;height: 20px;\" class=\"icon-edit\" title=\"重命名\" onclick=\"renameFile('"+fileName+"')\"></div>";
	    if(row.isParent){
	    	return r+d;
	    }else{
	    	return r+d+s;
	    }
	    
	}
	function fileTypeFormatter(value,row,index){
		if(row.isParent){
	    	return "<img src='images/icons/folder.png' width='16px' height='16px'>";
	    }else{
	    	return "<img src='images/icons/file.png' width='16px' height='16px'>";
	    }
		
	}
	$(document).ready(function(){
		readTree();
		


	});
	function renameFile(name){
		$("#oldName").val(name);
		$("#newName").textbox("setValue",name);
		var $dialog = $("#renameWin");
		$dialog.dialog("open");
	}
	function rename(){
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		var path=$("#path").val();
		var oldName=$("#oldName").val();

		var newName=$("#newName").val();
		var $dialog = $("#renameWin");
		$.post("raqsoft/rename.zb",{"path":path,"oldName":oldName,"newName":newName},function(data){
			if(data.success){
				var pid=$("#path").val();
				loadData(path);
				readTree()
				var n = noty({text: "重命名成功!",type:"success",layout:"topCenter",timeout:1500});
				
			}else{
				$.messager.alert("错误",data.msg,"error");
			}
			$.messager.progress("close");
			$dialog.dialog("close");
			
		},"json");
	}
	function moveFiles(){
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var names="";
		for(var i=0; i<rows.length; i++){
			
			names+=rows[i].name+",";	
			
		}
		names = names.substring(0, names.length-1);
		
		var oldPath=$("#path").val();
		
		
		var newPath=$("#newPath").val();
			
		$('#folderTreeDlg').dialog('close');
		repath(newPath,oldPath,names);
		
	}
	function repath(newPath,oldPath,names){
		$.messager.confirm("提示", "您确认要移动吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("raqsoft/repath.zb",{"newPath":newPath,"oldPath":oldPath,"names":names},function(data){
				if(data.success){
					var pid=$("#path").val();
					
					var n = noty({text: "删除文件成功!",type:"success",layout:"topCenter",timeout:1500});
					
				}else{
					$.messager.alert("错误",data.msg,"error");
				}
				$.messager.progress("close");
				loadData(oldPath);
				readTree()
				
			},"json");
		});
	}
	function deleteFiles(){
		var rows = $("#dg").datagrid("getSelections");	
		
		if(rows.length<=0){//如果没有选中行 
			var n = noty({text: "请选择一行记录!",type:"warning",layout:"topCenter",timeout:1500});
			return;
		}
		var filePaths="";
		for(var i=0; i<rows.length; i++){
			
			filePaths+=rows[i].id+",";	
			
		}
			
		filePaths = filePaths.substring(0, filePaths.length-1);
		deleteFile(filePaths);
	}
	function deleteFile(filePath){
		
		$.messager.confirm("提示", "您确认要删除吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("raqsoft/deleteFile.zb",{"filePaths":filePath},function(data){
				if(data.success){
					var pid=$("#path").val();
					loadData(pid);
					readTree()
					var n = noty({text: "删除文件成功!",type:"success",layout:"topCenter",timeout:1500});
					
				}else{
					$.messager.alert("错误",data.msg,"error");
				}
				$.messager.progress("close");
				
				
			},"json");
		});
		
	}
	function uploadFile(){
		
		var $form = $("#fileForm");
		var $dialog = $("#fileWin");
		$form.form("submit",{
			url: 'raqsoft/uploadFile.zb',
			//提交前验证
			onSubmit:function(){
				$.messager.progress({
					title:"提示",
					text:"数据处理中，请稍后...."
				});	
				var filepath=$("#fb").filebox("getValue");
				   var extStart=filepath.lastIndexOf(".");
				   var ext=filepath.substring(extStart,filepath.length).toUpperCase();
				   if(ext!=".RPX"&&ext!=".DFX"&&ext!=".SHT"&&ext!=".RPG"){
					   $.messager.progress("close");
					   $.messager.alert("错误","文件限于rpx,dfx类型","error"); //检测允许的上传文件类型
					   
				     	return false;
					}
				
				
				return true;   
			},
			//提交成功
			success:function(result){
				result = $.parseJSON(result);
				$.messager.progress("close");
				$dialog.dialog("close");
				if(result.success){
					var pid=$("#path").val();
					loadData(pid);
					
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误","查询信息失败","error");
				}
				
			}
		});
		return 0;
	}
	
	function createFolder(){
		var pid=$("#path").val();
		var folderName=$("#folderName").val();
		var $dialog = $("#folderWin");
		$.post("raqsoft/createFolder.zb",{"path":pid,"folderName":folderName},function(data){
			if(data.success){
				
				loadData(pid);
				readTree();
				var n = noty({text: "创建文件夹成功!",type:"success",layout:"topCenter",timeout:1500});
			}else{
				$.messager.alert("错误","创建文件夹失败!","error");
			}
			$.messager.progress("close");
			$dialog.dialog("close");
			
			
		},"json");
	}
	
	/**
	*显示报表文件树形窗口
	*/
	function showFolderTreeDlg(){
		
		
	    
	    
		var setting = {
				
				data: {
					keep: {
						parent: true,
						leaf: true
					},
					simpleData: {
						enable: true,
						idKey: "id",
						pIdKey: "parentId",
						rootPId: 0
					}
				},
				callback: {
					onClick: function(event, treeId, treeNode, clickFlag){
						$("#newPath").val(treeNode.id);
						
						
					},
					
					
				},
				view: {
					selectedMulti: false
				}
		};
		
		$.post("raqsoft/getReportFileList.zb?fileSuffix=directory",{},function(data){
			if(data){
				
				$.fn.zTree.init($("#folderTree"), setting, data);
				var folderTree=$.fn.zTree.getZTreeObj("folderTree");
				folderTree.expandAll(true);
	        	$('#folderTreeDlg').dialog('open');
				
				
			}else{
				$.messager.alert("错误","查询数据时出现系统错误!","error");
			}
			
		},"json");
		
	}
	</script>

</head>
<body class="easyui-layout" data-options="fit:true">
	<!--left-->
	<div data-options="region:'west',title:'资源树',split:true,border:true"
		style="width: 215px;">
		<ul id="tt" class="ztree"></ul>
	</div>
	<!--right-->
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<div id="tb" style="height: auto; display: none">
			<a onclick="$('#folderWin').window('open');"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">新建文件夹</a> <a
				onclick="$('#fileWin').window('open');" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">上传文件</a> <a
				onclick="deleteFiles()" class="easyui-linkbutton"
				data-options="iconCls:'icon-del',plain:true">删除</a> <a
				onclick="showFolderTreeDlg()" class="easyui-linkbutton"
				data-options="iconCls:'icon-cut',plain:true">移动</a>
		</div>
		<!-- grid定义 -->
		<table id="dg" class="easyui-datagrid" title="资源列表"
			style="display: none"
			data-options="collapsible:true,
				iconCls:'icon-module',
				url:'raqsoft/getFileListByPid.zb',method:'post',
				height:$(this).height(),
				rownumbers:true,
				toolbar: '#tb',
				fit:true,
				fitColumns:true,
				collapsible:false,
				frozenColumns:[[
			    	{field:'ck',checkbox:true}
			    ]],
				onDblClickRow: function(rowIndex, rowData){
					
					if(rowData.isParent){
						loadData(rowData.id)
					}
					
				}
			">
			<thead>
				<tr>
					<th
						data-options="field:'id',width:16,align:'right',formatter:fileTypeFormatter"></th>
					<th
						data-options="field:'name',width:120,align:'left',halign:'left'">名称</th>
					<th
						data-options="field:'lastModified',width:120,align:'left',halign:'left'">修改日期</th>
					<th
						data-options="field:'type',width:120,align:'left',halign:'left'">类型</th>
					<th
						data-options="field:'size',width:120,align:'left',halign:'left'">大小</th>

					<th
						data-options="field:'operation',width:100,align:'left',halign:'left',fixed:true,formatter:formatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	<!-- 创建文件夹窗口 -->
	<div id="folderWin" class="easyui-window" title="新建文件夹"
		style="width: 280px; height: 80px"
		data-options="iconCls:'icon-save',modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
		<div style="margin: 10px;">
			<input id="folderName" name="folderName" class="easyui-textbox"
				style="width: 150px"> <a class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'" onClick="createFolder()">创建</a>
		</div>
	</div>
	<!-- 文件上传窗口 -->
	<div id="fileWin" class="easyui-window" title="上传文件"
		style="width: 480px; height: 80px"
		data-options="iconCls:'icon-save',modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
		<div style="margin: 10px;">
			<form id="fileForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="path" id="path"> <input id="fb"
					name="file" class="easyui-filebox" style="width: 350px"
					data-options="buttonText: '选择文件'"> <a
					class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					onClick="uploadFile()">上传</a>
			</form>
		</div>
	</div>
	<!-- 修改文件名窗口 -->
	<div id="renameWin" class="easyui-window" title="修改文件名"
		style="width: 280px; height: 80px"
		data-options="iconCls:'icon-save',modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
		<div style="margin: 10px;">
			<input id="oldName" name="oldName" type="hidden"> <input
				id="newName" name="newName" class="easyui-textbox"
				style="width: 150px"> <a class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'" onClick="rename()">确定</a>
		</div>
	</div>
	<!-- 移动文件窗口 -->
	<div id="folderTreeDlg" class="easyui-dialog"
		data-options="closed:true" title="选择目录" style="width: 400px"
		iconCls="icon-edit" modal="true" closed="true"
		buttons="#folderTreeDlg-buttons">
		<div
			style="padding: 10px 0 10px 20px; width: 360px; height: 250px; overflow: auto">
			<input type="hidden" name="newPath" id="newPath">
			<ul id="folderTree" class="ztree"></ul>
		</div>

		<div id="folderTreeDlg-buttons">
			<a onclick="moveFiles();" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="$('#folderTreeDlg').dialog('close');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>

