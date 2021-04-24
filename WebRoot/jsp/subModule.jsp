<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String parentId=request.getParameter("parentId");
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="common.jsp" />
<script type="text/javascript">
var curUrl;
function menuHandler(item){
	if(item.name=='newWindow'){
		 /*设置重新打开的页面
            * toolbar 不显示浏览器的工具栏
            * location 不显示地址字段
            * menubar 不显示菜单栏
            * directories 不显示目录添加按钮
            * scrollbars 窗体中内部超出窗口可视范围时不存在滚动条
            * */
            var win=window.open(curUrl,"_blank","resizable=yes;status=yes;toolbar=no;location=no;menubar=no;directories=no;scrollbars=no;");
        win.moveTo(0,0);
        win.resizeTo(screen.availWidth,screen.availHeight);//设置新打开窗口的宽、高

	}
}
function openTab(id,tabName,url){
	if(url.indexOf('?')>0){
		url=url+'&JSESSIONID=<%=session.getId()%>';
	}else{
		url=url+'?JSESSIONID=<%=session.getId()%>';
	}
	var html="<iframe src="+url+" name='right_iframe' class='iframeApp'	frameborder='0' SCROLLING='auto' marginwidth='0' marginheight='0' style='width: 100%; height: 100%; overflow: hidden;'></iframe>"
	var panelObj={title:tabName,content:html,closable:true,width:'100%',height:'100%'};
							
	if($("#showiframetab").tabs('exists',tabName)){
		var tab = $("#showiframetab").tabs('getTab',tabName);
		tab.panel(panelObj);
		$("#showiframetab").tabs('select',tabName);
	}else{
		if(id!=null){
			$.post("log/saveSysModuleLog.zb",{"moduleId":id},function(data){
									
			},"json");
		}
		$("#showiframetab").tabs('add',panelObj);
	}
							
							
						
	}
function onCloseTab(title,index){
	$("#showiframetab").tabs('getTab',title).panel("clear");
	return true;
}
$(document).ready(function(){
	
	var setting = {
					
			data: {
				keep: {
					parent: true,
					leaf: true
				},
				key:{
					name:"moduleName",
						url:null
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: "<%=parentId%>"
				}
			},
			callback:{
				onClick:function (event, treeId, treeNode, clickFlag){
					//if(treeNode.isParent){
					//	var moduleTree=$.fn.zTree.getZTreeObj(treeId);
					//	moduleTree.expandNode(treeNode, !treeNode.open, false, false, false);
					//}
					
					if(treeNode.url!=null&&treeNode.url.length>0){
						openTab(treeNode.id,treeNode.moduleName,treeNode.url);
						
					}
				},
				onRightClick: function(event, treeId, treeNode){
					curUrl=treeNode.url;
					if(curUrl!=null&&curUrl.length>0){
						$('#treeRightMenu').menu('show', {    
  							left: event.clientX,    
  							top: event.clientY    
						}); 
					}
				}
			},
			view: {
				selectedMulti: false
			}
	};
	
	$.post("module/getModuleListByUser.zb",{},function(data){
		if(data){
			var rootPid=setting.data.simpleData.rootPId;
			var treeNodes = new Array();
			for(var i=0;i<data.length;i++){
				data[i].target="right_iframe";
				if(data[i].url!=null&&data[i].url.length>0){
				
					var funs=data[i].funs;
					var paramStr="";
					for(var j=0;j<funs.length;j++){
						if(funs[j].funCode !=null&&typeof(funs[j].funCode) != "undefined"){
							paramStr+="&"+funs[j].funCode+"="+funs[j].funValue;	
						}
						
					}
					if(data[i].url.indexOf("?")>0){
						data[i].url+=paramStr;
					}else{
						data[i].url+="?"+paramStr;
					}
				
				}
				
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
				if(data[i].id==rootPid){
							
					var url=data[i].url;
					if(url!=null&&url!=undefined&&url.length>0){
						openTab(data[i].id,data[i].moduleName,url);
					}
					treeNodes.push(data[i]);
					addChilds(treeNodes,data,data[i].id);
					
				}
			}
			
			
			$.fn.zTree.init($("#menuTree"), setting, treeNodes);
			var moduleTree=$.fn.zTree.getZTreeObj("menuTree");
			//设置节点展开
			var nodes = moduleTree.getNodes();
            for (var i = 0; i < nodes.length; i++) { 
                moduleTree.expandNode(nodes[i], true, false, true);
            }
			
		}else{
			$.messager.alert("错误","查询数据时出现系统错误!","error");
		}
		$.messager.progress("close");
		$('#moduleTreeDlg').dialog('close');
	},"json");
	
	
});
function addChilds(treeNodes,data,parentId){
	for(var i=0;i<data.length;i++){
		if(data[i].parentId==parentId){
			treeNodes.push(data[i]);
			addChilds(treeNodes,data,data[i].id);
		}
	}
}

</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',border:true,title:'功能菜单'"
		style="width: 215px;">
		<!--左侧-->
		<ul id="menuTree" class="ztree"></ul>
		<!--<div id="accordion" class="j-panel-body"  style="height:100%;overflow:hidden;">
				
				<ul class="ui-accordion">
				<c:forEach items="${moduleList}" var="module">
					<li>
						<a href="${module.url}" target="right_iframe" class="ui-state-default ui-accordion-header">
							<span class="ui-accordion-header-icon ui-icon ui-icon-plus"></span>
							${module.moduleName}
						</a>
					</li>
				</c:forEach>
				</ul>
			</div>-->
	</div>
	<!--右键菜单-->
	<div id="treeRightMenu" class="easyui-menu" data-options="onClick:menuHandler" style="width:120px;">
	<div  data-options="name:'newWindow'">新窗口打开</div>
	</div>
	
	<!--right-->
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<div id="showiframetab" class="easyui-tabs" data-options="fit:true,onBeforeClose:onCloseTab">   
		</div>  
	</div>
</body>
</html>
