<%@ page language="java" pageEncoding="UTF-8"%>
<style>
.setting-ul li {
	text-align: center;
}
</style>
<div class="easyui-layout" fit="true">
	<!--div data-options="region:'east',iconCls:'icon-reload',title:'属性窗口',split:true" style="width:200px;"></div-->
	<div data-options="region:'west',title:'导航',split:true"
		style="width: 150px; padding: 1px;">
		<ul class="nav nav-pills nav-stacked setting-ul">
			<li class="active"><a id="setting_field"
				href="javascript:void(0)" onclick="javascript:addForm();">公共字段设置</a></li>
		</ul>
	</div>
	<div data-options="region:'center',title:'公共字段设置'"
		style="padding: 1px;">
		<table id="settingFieldGrid" class="easyui-datagrid"
			toolbar="#setting-search" fit="true" singleSelect="true"
			rownumbers="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th
						data-options="field:'type',width:100,align:'center',editor: {
	                	type:'combobox',
                           options:{
							valueField: 'id',
        					textField: 'text',
                               data: fieldTypeData
                           }
	                },formatter: function(value, rowData, rowIndex){
	                	var text = value;
	                	for(var i=0; i<fieldTypeData.length;
						i++){
	                		if(fieldTypeData[i].id==text){
						text=fieldTypeData[i].text;
						break;
	                		}
	                	}
	                	returntext;
	                }">类型</th>
					<th
						data-options="field:'no',width:100,align:'center',editor: 'validatebox'">编码</th>
					<th
						data-options="field:'name',width:100,align:'center',editor: 'validatebox'">名称</th>
					<th
						data-options="field:'fieldNull',width:60,align:'center',editor: {
	                	type:'checkbox',
	                	options: {  
	                        on: 0,  
	                        off: 1  
	                    }
	                },formatter: function(value, rowData, rowIndex){
	                	return value=='0'?'√':'×';
	                }">必填</th>
					<th
						data-options="field:'allowAdd',width:60,align:'center',editor: {
	                	type:'checkbox',
	                	options: {  
	                        on: 1,  
	                        off: 0  
	                    }
	                },formatter: function(value, rowData, rowIndex){
	                	return value=='1'?'√':'×';
	                }">新建</th>
					<th
						data-options="field:'allowUpdate',width:60,align:'center', editor: {
	                	type:'checkbox',
	                	options: {  
	                        on: 1,  
	                        off: 0  
	                    }
	                },formatter: function(value, rowData, rowIndex){
	                	return value=='1'?'√':'×';
	                }">修改</th>
					<th
						data-options="field:'allowValue',width:80,align:'center',editor: 'validatebox'">默认值</th>
					<th
						data-options="field:'dbId',width:100,align:'center',editor: 'validatebox'">字段名</th>
					<th
						data-options="field:'dbLength',width:80,align:'center',editor: 'numberbox'">字段长度</th>
				</tr>
			</thead>
		</table>
		<div id="setting-search" style="margin: auto;">
			<a href="javascript:addRecord('settingFieldGrid');"
				class="easyui-linkbutton" iconCls="icon-add" plain="true">新建字段</a> <a
				href="javascript:removeRecord(1);" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除字段</a> <a
				href="javascript:settingSaveRecord();" class="easyui-linkbutton"
				iconCls="icon-save" plain="true">保 存</a>
		</div>
	</div>
</div>
<script>
// 结束编辑所有行
function endEdit(grid)
{
	var rowCount = $('#'+grid).datagrid('getRows').length;
	// 结束编辑所有行
	for (var i = 0; i < rowCount; i++)
	{
		$('#'+grid).datagrid('endEdit',i);
	}  
};
$('#settingFieldGrid').datagrid({
	onSelect:function(rowIndex, rowData){		
		endEdit("settingFieldGrid");			
		$('#settingFieldGrid').datagrid('beginEdit', rowIndex);			
	}
});
//保存默认字段
settingSaveRecord = function(){
	$(document.body).mask({
		maskMsg : "处理中，请稍候..."
	});	
	var form = {
		id : 0,
		no : '系统设置'
	};
	var fields = new Array();
	$('#settingFieldGrid').datagrid('acceptChanges');
	var data = $("#settingFieldGrid").datagrid("getData");
	var rows = data.rows;
	var x = 0;
	for(var i=0; i<data.total; i++){
		if(rows.type=='') continue;
		fields[x++] = rows[i];
	}
	form.fields = fields;
	form.fieldCount = i;	
	$.post("dfcode/setting/saveFields.zb",form, function(res){
		$(document.body).mask("hide");
		if(res.success){
			$.messager.alert('自定义表单',"默认字段设置成功",'info');			
		}else{
			 $.messager.alert('自定义表单',res.msg,'error');
		}
	}, 'json');
};
//初始化默认字段信息
initSettingFields = function(){
	$(document.body).mask({
		maskMsg : "数据加载中，请稍候..."
	});
	$("#settingFieldGrid").datagrid("loadData",[]);
	$.ajax({
		url : "dfcode/init.zb?id=0",
		type: 'POST',
		cache: false,
		dataType: 'json',
		success: function(res){
			for(var o in res){
				if(o=='fields'){
					for(var i=0; i<res[o].length; i++){
						addRecord("settingFieldGrid", res[o][i]);
					}
				}
			}
			$(document.body).mask("hide");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown){
			alert("默认字段信息加载失败"+errorThrown);
			$(document.body).mask("hide");
		}
	});
};
initSettingFields();
</script>