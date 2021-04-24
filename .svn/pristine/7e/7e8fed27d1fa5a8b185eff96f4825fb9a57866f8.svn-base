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
	$.post("subway/findByAttrBizStationFluxTransfer.zb",formdata,function(data){
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
	$.post("subway/saveBizStationFluxTransfer.zb",formdata,function(data){
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
		
		
		
		$.post("subway/deleteBizStationFluxTransfer.zb",obj,function(data){
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
			
					换乘站名:<input name="stationNameTransfer" class="easyui-textbox" style="width:100px"> 
        			日期:<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
					开始线路名称:<input name="lineNameStart" class="easyui-textbox" style="width:100px"> 
					开始线路ID:<input name="lineIdStart" class="easyui-textbox" style="width:100px"> 
					开始线路上下行:<input name="directionBegin" class="easyui-textbox" style="width:100px"> 
					换乘线路名称:<input name="lineNameEnd" class="easyui-textbox" style="width:100px"> 
					换乘线路ID:<input name="lineIdEnd" class="easyui-textbox" style="width:100px"> 
					换乘线路上下行:<input name="directionEnd" class="easyui-textbox" style="width:100px"> 
					时间段开始:<input name="sectionBegin" class="easyui-datetimebox" style="width:150px"> 
        			时间段结束:<input name="sectionEnd" class="easyui-datetimebox" style="width:150px"> 
				
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
      			<th data-options="field:'stationNameTransfer',width:100" >换乘站名</th>  
      			<th data-options="field:'settlementDate',width:100" >日期</th>  
      			<th data-options="field:'lineNameStart',width:100" >开始线路名称</th>  
      			<th data-options="field:'lineIdStart',width:100" >开始线路ID</th>  
      			<th data-options="field:'directionBegin',width:100" >开始线路上下行</th>  
      			<th data-options="field:'lineNameEnd',width:100" >换乘线路名称</th>  
      			<th data-options="field:'lineIdEnd',width:100" >换乘线路ID</th>  
      			<th data-options="field:'directionEnd',width:100" >换乘线路上下行</th>  
      			<th data-options="field:'transforNum',width:100" >换乘量</th>  
      			<th data-options="field:'sectionBegin',width:150" >时间段开始</th>  
      			<th data-options="field:'sectionEnd',width:150" >时间段结束</th>  
        	
               
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
        <label for="stationNameTransfer">换乘站名:</label>   
        </td><td>
			<input name="stationNameTransfer" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="settlementDate">日期:</label>   
        </td><td>
        	<input name="settlementDate" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineNameStart">开始线路名称:</label>   
        </td><td>
			<input name="lineNameStart" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineIdStart">开始线路ID:</label>   
        </td><td>
			<input name="lineIdStart" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="directionBegin">开始线路上下行:</label>   
        </td><td>
			<input name="directionBegin" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineNameEnd">换乘线路名称:</label>   
        </td><td>
			<input name="lineNameEnd" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="lineIdEnd">换乘线路ID:</label>   
        </td><td>
			<input name="lineIdEnd" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="directionEnd">换乘线路上下行:</label>   
        </td><td>
			<input name="directionEnd" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="transforNum">换乘量:</label>   
        </td><td>
			<input name="transforNum" class="easyui-textbox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionBegin">时间段开始:</label>   
        </td><td>
        	<input name="sectionBegin" class="easyui-datebox" style="width:100px"> 
       </td></tr> 
    	
				
    	<tr><td>   
        <label for="sectionEnd">时间段结束:</label>   
        </td><td>
        	<input name="sectionEnd" class="easyui-datebox" style="width:100px"> 
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
				<input type="hidden" name="excelType" value="transfor"> 
				<input id="fb" name="file" class="easyui-filebox" style="width: 350px" data-options="buttonText: '选择文件'"> 
					<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onClick="uploadFile()">上传</a>
			</form>
		</div>
	</div>
</body>
</html>