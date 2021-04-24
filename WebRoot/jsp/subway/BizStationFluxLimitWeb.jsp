<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
function doSearch(){
	var formdata=$("#queryForm").serializeArray();
	$.post("subway/findByAttrBizStationFluxLimitWeb.zb",formdata,function(data){
			if(data.success){
				$("#dataTable").datagrid("loadData",data.extData);
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
}
function openDialog(flag){
	if(flag==1){
		var rows=$("#dataTable").datagrid("getChecked");
		if(rows.length!=1){
			$.messager.alert("错误","请选择一条记录进行编辑!","error");
		}else{
			var row=rows[0];
			$("#dataForm").form("load",row);
			$("#dataDialog").dialog("open");
		}
	}else{
		$("#dataDialog").dialog("open");
	}
	
}
function saveData(){
	var formdata=$("#dataForm").serializeArray();
	$.post("subway/saveBizStationFluxLimitWeb.zb",formdata,function(data){
			if(data.success){
				$.messager.alert("信息","保存成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","保存数据时出现系统错误!","error");
			}
			closeDialog();
			
		},"json");
}
function closeDialog(){
	$("#dataForm").form("clear");
	$("#dataDialog").dialog("close");
}
function deleteRows(){
	var rows=$("#dataTable").datagrid("getChecked");
	if(rows.length<1){
		$.messager.alert("错误","至少选择一条记录删除!","error");
	}else{
		var obj={};
      		
        		var id=new Array();
				for(var i=0;i<rows.length;i++){
					id.push(rows[i].id);
				}
				obj.id=id;
		
		
		
		$.post("subway/deleteBizStationFluxLimitWeb.zb",obj,function(data){
			if(data.success){
				$.messager.alert("信息","删除成功!","info");
				doSearch();
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
						
		},"json");
		
	}
	
	
}

</script>
</head>
<body  class="easyui-layout" data-options="border:false">
<div data-options="region:'center',title:'列表'" style="padding:5px;background:#eee;">
<div id="dataTabelToolBar" style="height: auto">
			<div style="margin-left: 8px">
			<form id="queryForm">
			
					是否启用:<input name="isenable" class="easyui-textbox" style="width:100px"> 
				
			 <a onclick="doSearch()" class="easyui-linkbutton"
					data-options="
						iconCls:'icon-search',
						plain:true
					">查询</a>
					</form>
			</div>
			<a class="easyui-linkbutton" onclick="openDialog(0)"
				data-options="
			iconCls:'icon-add',
			plain:true
		">新增</a> 
		<a class="easyui-linkbutton" onclick="openDialog(1)"
				data-options="
			iconCls:'icon-edit',
			plain:true
		">编辑</a> 
		<a
				class="easyui-linkbutton" onclick="deleteRows()"
				data-options="
			iconCls:'icon-del',
			plain:true
		">删除</a> 
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'id',width:100,checkbox:true" ></th>
      			<th data-options="field:'stationEntrySafe',width:100" >进站正常值</th>  
      			<th data-options="field:'stationEntryWarn',width:100" >进站警告值</th>  
      			<th data-options="field:'stationEntryAlarm',width:100" >进站报警值</th>  
      			<th data-options="field:'stationExitSafe',width:100" >出站正常值</th>  
      			<th data-options="field:'stationExitWarn',width:100" >出站警告值</th>  
      			<th data-options="field:'stationExitAlarm',width:100" >出站报警值</th>  
      			<th data-options="field:'stationTransforSafe',width:100" >换乘正常值</th>  
      			<th data-options="field:'stationTransforWarn',width:100" >换乘警告值</th>  
      			<th data-options="field:'stationTransforAlarm',width:100" >换乘报警值</th>  
      			<th data-options="field:'isenable',width:100" >是否启用</th>  
      			<th data-options="field:'updateTime',width:150" >更新时间</th>  
        	
               
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:550px;height:220px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="id" value=""/>
    	
				
    	<tr><td>   
        <label for="stationEntrySafe">进站正常值:</label>   
        </td><td width=100>
			<input name="stationEntrySafe" class="easyui-textbox" style="width:50px">% 
       </td>
				
    	<td>   
        <label for="stationEntryWarn">进站警告值:</label>   
        </td><td width=100>
			<input name="stationEntryWarn" class="easyui-textbox" style="width:50px">%
       </td>
				
    	<td>   
        <label for="stationEntryAlarm">进站报警值:</label>   
        </td><td>
			<input name="stationEntryAlarm" class="easyui-textbox" style="width:50px">%
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationExitSafe">出站正常值:</label>   
        </td><td>
			<input name="stationExitSafe" class="easyui-textbox" style="width:50px">%
       </td>
				
    	<td>   
        <label for="stationExitWarn">出站警告值:</label>   
        </td><td>
			<input name="stationExitWarn" class="easyui-textbox" style="width:50px">%
       </td>
				
    	<td>   
        <label for="stationExitAlarm">出站报警值:</label>   
        </td><td>
			<input name="stationExitAlarm" class="easyui-textbox" style="width:50px">%
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationTransforSafe">换乘正常值:</label>   
        </td><td>
			<input name="stationTransforSafe" class="easyui-textbox" style="width:50px">%
       </td>
				
    	<td>   
        <label for="stationTransforWarn">换乘警告值:</label>   
        </td><td>
			<input name="stationTransforWarn" class="easyui-textbox" style="width:50px">%
       </td>
				
    	<td>   
        <label for="stationTransforAlarm">换乘报警值:</label>   
        </td><td>
			<input name="stationTransforAlarm" class="easyui-textbox" style="width:50px">% 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="isenable">是否启用:</label>   
        </td><td>
        <input type="radio" name="isenable" value="1" checked="checked" />是 
        <input type="radio" name="isenable" value="0" />否
       </td></tr> 
				
    
    </table>   
</form>    
</div>
<div id="dataDialogButtons">
<a class="easyui-linkbutton" data-options="onClick:saveData">保存</a>
<a class="easyui-linkbutton" data-options="onClick:closeDialog">关闭</a>
</div>
</body>
</html>