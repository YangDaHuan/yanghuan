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
					key:{
						name:"moduleName",
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
						if(treeNode.isFolder=='1'){
							dict_right_iframe.loadData(treeNode.id);
						}else{
							dict_right_iframe.openEditDialog(treeNode.id);
						}
						
					},
					onDrop: function(event, treeId, treeNodes, targetNode, moveType, isCopy){
						var parentNode;
			        	if(moveType==null){
			        		$.messager.alert("错误","拖拽无效!","error");
			        		return;
			        	}
			        	if(targetNode==null){
			        		$.messager.alert("错误","不能拖拽到模块树之外!","error");
			        		return;
			        	}
			        	if(moveType=="inner"){
			        		parentNode=targetNode;
			        	}else{
			        		parentNode=targetNode.getParentNode();

			        	}
			        	var id="";
			        	var nodes=parentNode.children;
			    		for(var i=0; i<nodes.length; i++){
			    			id+=nodes[i].id+",";	
			    			
			    		}
			    		id = id.substring(0, id.length-1);
			    		
			    		$.post("module/moveModule.zb",{id:id,parentId:parentNode.id},function(data){
							if(data.success){
								var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
								$("#dg").datagrid("load");
							}else{
								$.messager.alert("错误","更新数据时出现系统错误!","error");
							}
							$.messager.progress("close");
						},"json");
					}
					
				},
				view: {
					selectedMulti: false
				}
		};
		
		$.post("module/getModuleInfoList.zb",{},function(data){
			if(data){
				for(var i=0;i<data.length;i++){
					if(data[i].isFolder!='1'&&data[i].iconCls!=null&&data[i].iconCls.length>0){
						data[i].icon="images/icons/modules/tree/"+data[i].iconCls+".png";
					}else{
						data[i].icon=null;
					}
					//if(data[i].url==null||data[i].url.length<=0){
					if(data[i].isFolder=='1'){
						data[i].isParent=true;
					}else{
						data[i].isParent=false;
					}
				}
				$.fn.zTree.init($("#tt"), setting, data);
				var moduleTree=$.fn.zTree.getZTreeObj("tt");
				//moduleTree.expandAll(true);
				var nodes = moduleTree.getNodes();
            	for (var i = 0; i < nodes.length; i++) { //设置节点展开
                	moduleTree.expandNode(nodes[i], true, false, true);
            	}
				
				
			}else{
				$.messager.alert("错误","查询数据时出现系统错误!","error");
			}
			$.messager.progress("close");
			$('#moduleTreeDlg').dialog('close');
		},"json");
		
		
	}
	$(document).ready(function(){
		readTree();
		


	});
	
	
	</script>

</head>
<body class="easyui-layout" data-options="fit:true">
	<!--left-->
	<div data-options="region:'west',title:'模块树',split:true,border:true"
		style="width: 215px;">
		<ul id="tt" class="ztree"></ul>
	</div>
	<!--right-->
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<iframe id="iframe" src="jsp/module/moduleList.jsp"
			name="dict_right_iframe" class="iframeApp" frameborder="0"
			SCROLLING="no" marginwidth="0" marginheight="0"
			style="width: 100%; height: 100%;"></iframe>
	</div>
</body>
</html>

