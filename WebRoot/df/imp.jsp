<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
<!--
.imp-table, .sel-table {
	width: 100%;
	padding: 10px;
}

.imp-table tr td, .sel-table tr td {
	height: 30px;
}

.imp-table fieldset {
	border: 0;
	margin: 2px;
}

.foot-btn {
	width: 95%;
	position: absolute;
	bottom: 15px;
	text-align: right;
}

.imp-field {
	width: 150px;
	height: 200px;
	float: left;
}

.field-opera {
	width: 20px;
	height: 180px;
	text-align: center;
	padding: 20px 0px 5px 0px;
}

.opera-field {
	width: 100%;
	height: 20px;
	cursor: pointer;
	margin: 3px 0px 3px 0px;
}

.b-t-all {
	background: url("df/images/b-t-all.png") center no-repeat;
}

.b-t {
	background: url("df/images/b-t.png") center no-repeat;
}

.l-r-all {
	background: url("df/images/l-r-all.png") center no-repeat;
}

.l-r {
	background: url("df/images/l-r.png") center no-repeat;
}

.r-l {
	background: url("df/images/r-l.png") center no-repeat;
}

.r-l-all {
	background: url("df/images/r-l-all.png") center no-repeat;
}

.t-b {
	background: url("df/images/t-b.png") center no-repeat;
}

.t-b-all {
	background: url("df/images/t-b-all.png") center no-repeat;
}
-->
</style>
<div class="impDiv">
	<form action="df/imp/upload.zb" method="post" id="selFileForm"
		enctype="multipart/form-data">
		<input name="id" value="${fid}" type="hidden">
		<table class="sel-table">
			<tr>
				<td width="100">文件类型：</td>
				<td><input type="radio" name="fileType" value="1" checked>
					TXT格式 <input type="radio" name="fileType" value="2">
					EXCEL格式 <input type="radio" name="fileType" value="3">
					CSV格式</td>
			</tr>
			<tr>
				<td>请选择文件：</td>
				<td><input type="file" name="file" id="file"></td>
			</tr>
		</table>
	</form>
	<form action="df/imp/exec.zb" method="post" id="impForm">
		<input name="id" value="${fid}" type="hidden"> <input
			type="hidden" name="fileName" value="">
		<table class="imp-table">
			<tr>
				<td valign="top" style="padding-top: 5px;">请选择导入字段：</td>
				<td>
					<fieldset class="imp-field">
						<legend>表单字段</legend>
						<select multiple="multiple" class="imp-field" id="fields">
						</select>
					</fieldset>
					<fieldset class="imp-field">
						<legend>源字段</legend>
						<select multiple="multiple" class="imp-field" id="impSourceFields">
						</select>
					</fieldset>
					<div class="imp-field field-opera">
						<div class="b-t-all opera-field" title="置顶"></div>
						<div class="b-t opera-field" title="上移"></div>
						<div class="l-r-all opera-field" title="右移全部"></div>
						<div class="l-r opera-field" title="右移"></div>
						<div class="r-l opera-field" title="左移"></div>
						<div class="r-l-all opera-field" title="左移全部"></div>
						<div class="t-b opera-field" title="下移"></div>
						<div class="t-b-all opera-field" title="置底"></div>
					</div>
					<fieldset class="imp-field">
						<legend>导入字段</legend>
						<select multiple="multiple" class="imp-field" id="impFields"
							name="fields">
						</select>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td style="height: 40px;" valign="bottom">&nbsp;<input
					type="checkbox" name="title" value="1"> 第一行是标题
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="foot-btn">
	<a id="impPrevious" class="easyui-linkbutton"
		data-options="iconCls:'icon-ok'" href="javascript:void(0)"
		onclick="javascript:impPrevious();" style="display: none;">上一步</a> <a
		id="impNext" class="easyui-linkbutton"
		data-options="iconCls:'icon-ok'" href="javascript:void(0)"
		onclick="javascript:impNext();">下一步</a> <a id="impExec"
		class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
		href="javascript:void(0)" onclick="javascript:impExec();"
		style="display: none;">开始导入</a> <a class="easyui-linkbutton"
		data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
		onclick="$('#impDialog').dialog('close')">取 消</a>
</div>
<script language="javascript">
$(document.body).ready(function(){
	
	impNext = function(){
		$("#selFileForm").ajaxSubmit({
			success: function(res){
				var data = eval('('+res+')');
				if(data.success){
					 //var fields = $("#fields");
					 $("#fields").empty();					 
					 var fields = data.rows;
					 for(var i=0; i<fields.length; i++) 
						$("#fields").append("<option value='"+fields[i].no+"'>"+fields[i].name+"</option>");
					$("#impSourceFields").empty();						
					var sources = data.extData.split(",");
					for(var i=0; i<sources.length; i++)
						$("#impSourceFields").append("<option value='"+i+"'>"+sources[i]+"</option>");
						
					$("#impForm input[name=fileName]").val(data.msg);
					$("#impPrevious").show();
					$("#impExec").show();
					$("#impNext").hide();
					
					$("#impForm").show();
					$("#selFileForm").hide();	
				}else{
					$.messager.alert('数据导入','文件上传失败，请重试','error');
				}
			}
		});			
	}
	
	impPrevious = function(){
		$("#impPrevious").hide();
		$("#impExec").hide();
		$("#impNext").show();
		
		$("#impForm").hide();
		$("#selFileForm").show();
	}
	
	impExec = function(){
		var fields = "";
		$("#impFields option").each(function(){
			fields += $(this).val()+",";
		});		
		if(fields==''){
			$.messager.alert('数据导入','请选择导入字段','error');
 			return; 
		}
		$.messager.progress({
			text: '正在执行数据导入程序，请稍候...'
		}); 
		var fileType = $("#selFileForm input[type=radio]:checked").val();
		$("#impForm").ajaxSubmit({
			data: {
				fields : fields,
				fileType: fileType
			},
			success : function(res){
				$.messager.progress('close');	
				if(res=='error'){
					$.messager.alert('数据导入','数据导入失败','error');
				}else{					
					$('#impDialog').dialog('close');
					$.messager.alert('数据导入','数据导入成功。','info');
					$('#dfGrid').datagrid('reload');
				}
			}
		});
	}
	
	//$("#impPrevious").hide();
	//$("#impExec").hide();
	$("#impForm").hide();
	
	/*************SELECT交互****************/
	var impSourceFields = $("#impSourceFields");
	var impFields = $("#impFields"); 
	$(".l-r").click(function(){
		impSourceFields.find("option:selected").each(function(){
			impFields.append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
		});
		impSourceFields.find("option:selected").remove();
	});
	$(".r-l").click(function(){
		impFields.find("option:selected").each(function(){
			impSourceFields.append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
		});
		impFields.find("option:selected").remove();
	});	
	$(".l-r-all").click(function(){
		impFields.append(impSourceFields.html());
		impSourceFields.empty();
	});
	$(".r-l-all").click(function(){
		impSourceFields.append(impFields.html());
		impFields.empty();
	});
	$(".b-t-all").click(function(){
		var so = impFields.find("option:selected");
		var firstOption = impFields.find("option:first");
		if(so.length>0){
			if(so.get(0).index!=0){
				firstOption.before(so);
			}
		}
	});	
	$(".t-b-all").click(function(){
		var alloptions = impFields.find("option");  
		var so = impFields.find("option:selected");
		var firstOption = impFields.find("option:last");
		if(so.length>0){
		 	if(so.get(so.length-1).index!=alloptions.length-1){
				firstOption.after(so);
			}
		}
	});
	$(".b-t").click(function(){
		var so = impFields.find("option:selected");  
		if(so.length>0){
		    if(so.get(0).index!=0){  
		       so.each(function(){  
		           $(this).prev().before($(this));  
		       });  
		    }  
	    }
	});
	$(".t-b").click(function(){
		var alloptions = impFields.find("option");  
	    var so = impFields.find("option:selected");  
	    if(so.length>0){  
		    if(so.get(so.length-1).index!=alloptions.length-1){  
		       for(i=so.length-1;i>=0;i--)  
		       {  
		         	var item = $(so.get(i));  
		         	item.insertAfter(item.next());  
		       }  
		    }  
	    }
	});
});
</script>