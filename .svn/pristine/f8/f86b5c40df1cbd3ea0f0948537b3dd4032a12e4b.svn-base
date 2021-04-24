<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
function uploadFile(){
		
		var $form = $("#fileForm");
		var $dialog = $("#fileWin");
		$form.form("submit",{
			url: 'subway/uploadExcel.zb',
			//提交前验证
			onSubmit:function(){
				$.messager.progress({
					title:"提示",
					text:"数据处理中，请稍后...."
				});	
				var filepath=$("#fb").filebox("getValue");
				   var extStart=filepath.lastIndexOf(".");
				   var ext=filepath.substring(extStart,filepath.length).toUpperCase();
				   if(ext!=".XLSX"&&ext!=".XLS"){
					   $.messager.progress("close");
					   $.messager.alert("错误","文件限于xls,xlsx类型","error"); //检测允许的上传文件类型
					   
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
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误","查询信息失败","error");
				}
				
			}
		});
		return 0;
	}
function doSearch(){
	var formdata=$("#queryForm").serializeArray();
	$.post("subway/findByAttrBizStationFluxSection.zb",formdata,function(data){
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
	$.post("subway/saveBizStationFluxSection.zb",formdata,function(data){
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
		
		
		
		$.post("subway/deleteBizStationFluxSection.zb",obj,function(data){
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
			
					日期:<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
					线路编号:<input name="lineId" class="easyui-textbox" style="width:100px"> 
					线路名称:<input name="lineName" class="easyui-textbox" style="width:100px"> 
					开始站名称:<input name="stationNameBegin" class="easyui-textbox" style="width:100px"> 
					开始站编号:<input name="stationIdBegin" class="easyui-textbox" style="width:100px"> 
					结束站名称:<input name="stationNameEnd" class="easyui-textbox" style="width:100px"> 
					结束站编号:<input name="stationIdEnd" class="easyui-textbox" style="width:100px"> 
        			开始时间:<input name="sectionBegin" class="easyui-datetimebox" style="width:100px"> 
        			结束时间:<input name="sectionEnd" class="easyui-datetimebox" style="width:100px"> 
					上下行:<input name="direction" class="easyui-textbox" style="width:100px"> 
				
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
		<a onclick="$('#fileWin').window('open');" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">上传文件</a>
		</div>
	<table id="dataTable" class="easyui-datagrid" data-options="toolbar:'#dataTabelToolBar'">   
    <thead>   
        <tr>
      			<th data-options="field:'id',width:100,checkbox:true" ></th>
      			<th data-options="field:'settlementDate',width:100" >日期</th>  
      			<th data-options="field:'lineId',width:100" >线路编号</th>  
      			<th data-options="field:'lineName',width:100" >线路名称</th>  
      			<th data-options="field:'stationNameBegin',width:100" >开始站名称</th>  
      			<th data-options="field:'stationIdBegin',width:100" >开始站编号</th>  
      			<th data-options="field:'stationNameEnd',width:100" >结束站名称</th>  
      			<th data-options="field:'stationIdEnd',width:100" >结束站编号</th>  
      			<th data-options="field:'sectionBegin',width:100" >开始时间</th>  
      			<th data-options="field:'sectionEnd',width:100" >结束时间</th>  
      			<th data-options="field:'sectionFluxNum',width:100" >客流</th>  
      			<th data-options="field:'direction',width:100" >上下行</th>  
        	
               
        </tr>   
    </thead>   
    <tbody>   
        
    </tbody>   
</table>  
		
</div>   
<div id="dataDialog" class="easyui-dialog" title="信息" style="width:400px;height:200px;padding: 15px"   
        data-options="buttons:'#dataDialogButtons',iconCls:'icon-save',resizable:true,modal:true,closed:true">   
    <form id="dataForm" >   
    
    <table>
    	<input type="hidden" name="id" value=""/>
    	
				
    	<tr><td>   
        <label for="settlementDate">日期:</label>   
        </td><td>
        	<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineId">线路编号:</label>   
        </td><td>
			<input name="lineId" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineName">线路名称:</label>   
        </td><td>
			<input name="lineName" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationNameBegin">开始站名称:</label>   
        </td><td>
			<input name="stationNameBegin" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationIdBegin">开始站编号:</label>   
        </td><td>
			<input name="stationIdBegin" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationNameEnd">结束站名称:</label>   
        </td><td>
			<input name="stationNameEnd" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="stationIdEnd">结束站编号:</label>   
        </td><td>
			<input name="stationIdEnd" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionBegin">开始时间:</label>   
        </td><td>
        	<input name="sectionBegin" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionEnd">结束时间:</label>   
        </td><td>
        	<input name="sectionEnd" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionFluxNum">客流:</label>   
        </td><td>
			<input name="sectionFluxNum" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="direction">上下行:</label>   
        </td><td>
			<input name="direction" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    
    </table>   
</form>    
</div>
<div id="dataDialogButtons">
<a class="easyui-linkbutton" data-options="onClick:saveData">保存</a>
<a class="easyui-linkbutton" data-options="onClick:closeDialog">关闭</a>
</div>

<!-- 文件上传窗口 -->
	<div id="fileWin" class="easyui-window" title="上传文件"
		style="width: 480px; height: 80px"
		data-options="iconCls:'icon-save',modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
		<div style="margin: 10px;">
			<form id="fileForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="excelType" value="section"> 
				<input id="fb" name="file" class="easyui-filebox" style="width: 350px" data-options="buttonText: '选择文件'"> 
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onClick="uploadFile()">上传</a>
			</form>
		</div>
	</div>
</body>
</html>