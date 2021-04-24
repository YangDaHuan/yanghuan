<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>${model.name}管理</title>
<jsp:include page="../common.jsp" />
<link rel="stylesheet" href="css/df.css">
<script type="text/javascript" src="js/jquery.form.js"></script>
<script>
<#list model.fields as field>
	<#if field.type=='select' || field.type=='radio'>
		<#if field.dsType!=3&&(field.dsType>0)>
	var ${field.no}Data;
		</#if>
	</#if>
</#list>
$(document.body).ready(function(){
<#list model.fields as field>
	<#if field.type=='select' || field.type=='radio' || field.type=='checkbox'>
		<#if field.dsType!=3&&(field.dsType>0)>
	${field.no}Data = ${'${'+field.no+'}'};
			<#if field.type=='select'>
	$("#${field.no}").combobox("loadData", ${field.no}Data);				
			<#elseif field.type=='radio'>
	for(var i=0; i<${field.no}Data.length; i++){
		$(".${field.no}").append("<input type='radio' class='easyui-validatebox' name='${field.no?upper_case}' value='"+${field.no}Data[i].ID+"'> "+${field.no}Data[i].TEXT+"&nbsp;&nbsp;");
	}
			<#elseif field.type=='checkbox'>
	for(var i=0; i<${field.no}Data.length; i++){
		$(".${field.no}").append("<input type='checkbox' class='easyui-validatebox' name='${field.no?upper_case}' value='"+${field.no}Data[i].ID+"'> "+${field.no}Data[i].TEXT+"&nbsp;&nbsp;");
	}			
			</#if>				
		<#elseif field.dsType==3>			
			<#if field.type=='select'>
		$("#${field.no}").combobox("reload", "df/ds.zb?fieldId=${field.id}");
			</#if>				
		</#if>
	</#if>
</#list>
});
</script>
</head>
<body class="easyui-layout">
<div region="center" style="padding:5px;" border="false">
<!-- Grid -->
<table id="dfGrid" title="${model.name}列表" class="easyui-datagrid" <#if model.publish==1>url="df/list.zb?fid=${model.id}"</#if>
        toolbar="#toolbar" fit="true" 
        rownumbers="true" singleSelect="false" striped="true"
        <#if model.publish==1>pagination="true" pageSize="15"</#if>>
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<#list model.fields as field>        	
        		<#if field.type=='select'||field.type=='radio'||field.type='checkbox'>
        	<th field="${field.no?upper_case}" width="${field.gridWidth}" <#if (field.gridHide>0)>hidden="true"</#if> data-options="formatter: function(value, rowData, rowIndex){
        		<#if field.dsType!=3&&(field.dsType>0)>
        		<#if field.type=='checkbox'>
        			var text = '';
        			if(value&&value!=''){
        				var vals = value.split(',');
        				for(var x=0; x<vals.length; x++){
        					for(var i=0; i<${field.no}Data.length;i++){
			            		if(${field.no}Data[i].ID==vals[x]){
			            			text += ${field.no}Data[i].TEXT+',';
			            			break;
			            		}
			            	}
        				}
        				if(text.length>0) text = text.substring(0, text.length-1);
        				return text;
        			}else{
        				return value;
        			}
        		<#else>
    			var text = value;
    			<#if field.dsType!=3&&(field.dsType>0)>
            	for(var i=0; i<${field.no}Data.length;i++){
            		if(${field.no}Data[i].ID==text){
            			text = ${field.no}Data[i].TEXT;
            			break;
            		}
            	}
            	</#if>
            	return text;
            	</#if>            	
            	<#else>
            	<#if field.type=='select'&&field.dsType==3>
            	return value;
            	<#else>
            	return (value&&value!='')?'√':'×';
            	</#if>
            	</#if>
        	}">${field.name}</th>
        		<#else>
            <th field="${field.no?upper_case}" width="100" <#if (field.gridHide>0)>hidden="true"</#if>>${field.name}</th>
            	</#if>            
            </#list>
        </tr>
    </thead>
</table>
</div>
<div id="toolbar">
    <a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newData()">新 建</a>
    <a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editData();" <#if model.publish==0>disabled="true"</#if>>修 改</a>
    <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteData();" <#if model.publish==0>disabled="true"</#if>>删 除</a>
<#if model.actionImp==1><a class="easyui-linkbutton" iconCls="icon-imp" plain="true" onclick="impData();" <#if model.publish==0>disabled="true"</#if>>导 入</a></#if>
<#if model.actionExp==1><a class="easyui-linkbutton" iconCls="icon-exp" plain="true" onclick="expData();" <#if model.publish==0>disabled="true"</#if>>导 出</a></#if>    
    <div style="float:right;padding:2px;">
		<input class="easyui-searchbox" data-options="prompt:'请输入查询条件',menu:'#mm',searcher:doSearch" style="width:200px;"></input>
		<div id="mm" style="width:120px">
			<#list model.fields as field>
				<#if (field.gridQuery>0)>
			<div data-options="name:'${field.no?upper_case}'">${field.name}</div>
				</#if>
			</#list>
		</div>
	</div>
</div>
<!-- Dialog -->
<div id="dfDialog" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
        closed="true" buttons="#df-buttons" modal="true">   
    <form id="fm" method="post" <#if model.fileUpload==1>enctype="multipart/form-data"</#if>>
    <table class="edit-data-table">
    	<#list model.fields as field>
    		<#if field.type=='hidden'>
    			<input type="${field.type}" id="${field.no}" name="${field.no?upper_case}">
    		<#else>
    	<tr>
    		<td><label>${field.name}:</label></td>
    		<td>
    			<#if field.type=='textarea'>
    		<textarea id="${field.no}" name="${field.no?upper_case}" class="easyui-validatebox" <#if field.fieldNull==0>required="true"</#if> 
    		<#if field.fieldEquals??&&field.fieldEquals!=''>validType="eqPwd['#${field.fieldEquals}']
    		<#else>data-options="
    			validType : [<#if field.type=='email'>'email',</#if>'length[${field.minLen},${field.maxLen}]']
    		</#if>"></textarea>
    			<#elseif field.type=='select'>
    		<input class="easyui-combobox" id="${field.no}" name="${field.no?upper_case}" data-options="
                valueField:'ID',
                textField:'TEXT',
                panelHeight:'auto'
    		" <#if field.fieldNull==0>required="true"</#if>>	
    			<#elseif field.type=='radio' || field.type=='checkbox'>
    			<#if (field.dsType>0)>
    				<div class="${field.no}"></div>
    			<#else>
    				<input type="${field.type}" id="${field.no}" name="${field.no?upper_case}" value="${(field.defaultValue)!}">
    			</#if>    		    
    			<#elseif field.type=='date' || field.type=='datetime'>
    			 <input type="${field.type}" id="${field.no}" name="${field.no?upper_case}" class="easyui-${field.type}box" <#if field.fieldNull==0>required="true"</#if>>
    			<#elseif field.type=='fileUpload'>
    			<input type="file" id="${field.no}" name="${field.no?upper_case}">		
    			<#else>                               
            <input type="${field.type}" id="${field.no}" name="${field.no?upper_case}" class="easyui-validatebox" <#if field.fieldNull==0>required="true"</#if> 
            <#if field.fieldEquals??&&field.fieldEquals!=''>validType="eqPwd['#${field.fieldEquals}']
    		<#else>data-options="
    			validType : [<#if field.type=='email'>'email',</#if>'length[${field.minLen},${field.maxLen}]']
    		</#if>" >        
        		</#if>
        	</td>
        </tr>
        	</#if>        
        </#list>   
    </table>     
    </form>
</div>
<div id="df-buttons">
    <a class="easyui-linkbutton" iconCls="icon-ok" onclick="saveData();" <#if model.publish==0>disabled="true"</#if>>保 存</a>
    <a class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dfDialog').dialog('close')">关 闭</a>
</div>
<#if model.actionExp==1><div id="expDialog">导出窗口</div></#if>
<#if model.actionImp==1><div id="impDialog">导入窗口</div></#if>
<script type="text/javascript">
	var dfGrid = $('#dfGrid');
	var dfDialog = $('#dfDialog');
	var dfForm = $('#fm');
	//新建
	function newData(){
	    dfDialog.dialog('open').dialog('setTitle','新建${model.name}');
	    dfForm.form('clear');
	    <#list model.fields as field>
        	<#if field.defaultValue??&&field.type!='checkbox'>
        		<#if field.type=='select'>
        $('#${field.no}').combobox('setValue', '${field.defaultValue}');
        		<#else>
		$("#${field.no}").val('${field.defaultValue}');        		
        		</#if>    	
        	</#if>
        </#list>
	}
	//修改
	function editData(){
		var rows = dfGrid.datagrid('getSelections');
		if (rows.length==1){
		    dfDialog.dialog('open').dialog('setTitle','修改${model.name}');
		    $.post('df/get.zb?fid=${model.id}',{id:rows[0].${(model.primary?upper_case)!}},function(result){
                if (result.success){
                    dfForm.form('load',result.extData);
                    <#list model.fields as field>
                    	<#if field.type="checkbox">
                	var ${field.no} = ","+result.extData.${field.no?upper_case}+",";
                	dfForm.find("input[name=${field.no?upper_case}]").each(function(){
						$(this).attr("checked", ${field.no}.indexOf(','+$(this).val()+',')>-1);
					});
                    	</#if>
                    </#list>
                } else {
                    $.messager.show({    // show error message
                        title: '错误',
                        msg: result.msg
                    });
                }
            },'json');		    
		}else{
			$.messager.alert('提示','请选择一条记录进行修改。');
		}
	}
	//删除
	function deleteData(){
		var rows = dfGrid.datagrid('getSelections');
	    if (rows.length > 0){
	        $.messager.confirm('警告','一旦删除，这些数据将无法恢复，您确定要删除所选记录吗？',function(r){
	            if (r){
	            	var id = "";
	            	for(var i=0; i<rows.length; i++) id += rows[i].${(model.primary?upper_case)!} + ",";
	            	id = id.substring(0, id.length-1);
	                $.post('df/delete.zb?fid=${model.id}',{id:id},function(result){
	                    if (result.success){
		                    $.messager.show({
			                    title: '信息',
			                    msg: "${model.name}删除成功。"
			                });
	                        dfGrid.datagrid('reload');    // reload the user data
	                    } else {
	                        $.messager.show({    // show error message
	                            title: '错误',
	                            msg: result.msg
	                        });
	                    }
	                },'json');
	            }
	        });
	    }else{
	    	$.messager.alert('提示','请选择记录进行删除。');
	    }
	}
	//保存
	function saveData(){
	    dfForm.form('submit',{
	        url: "df/saveu.zb?fid=${model.id}",
	        onSubmit: function(){
	            return $(this).form('validate');
	        },
	        success: function(result){
	        	var result = eval('('+result+')');
	            if (result.success){
	            	$.messager.show({
	                    title: '信息',
	                    msg: "${model.name}保存成功。"
	                });
	            	dfDialog.dialog('close');        // close the dialog
	                dfGrid.datagrid('reload');    // reload the user data	                
	            } else {
	                $.messager.show({
	                    title: '错误',
	                    msg: result.msg
	                });
	            }
	        }
	    });
	}
	//查询
	 function doSearch(value,name){
		 var query = "{"+name+":'"+value+"'}";
		 dfGrid.datagrid('load',eval('('+query+')')); 
	}
	<#if model.actionImp==1>
	//导入
	function impData(){
		$('#impDialog').dialog({   
			title: '数据导入',   
			width: 650,   
			height: 350,   
			closed: false,   
			cache: false,   
			href: 'df/imp.zb?fid=${model.id}', 
			modal: true  
		});
	}
	</#if>
	<#if model.actionExp==1>
	//导出
	function expData(){
		$('#expDialog').dialog({   
			title: '数据导出',   
			width: 430,   
			height: 330,   
			closed: false,   
			cache: false,   
			href: 'df/export.zb?fid=${model.id}', 
			modal: true  
		});
	}
	</#if>
</script>
</body>
</html>