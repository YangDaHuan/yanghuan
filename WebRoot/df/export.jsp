<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.exp-field {
	width: 150px;
	height: 200px;
	float: left;
}

.exp-table {
	width: 100%;
}

.field-opera {
	width: 20px;
	height: 180px;
	text-align: center;
	padding: 5px 0px 5px 0px;
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
</style>
<form action="df/export/exec.zb" method="post" id="exportForm">
	<input type="hidden" name="id" value="${fid}">
	<table class="exp-table">
		<tr>
			<td height="25">文件格式：</td>
			<td><input type="radio" name="fileType" value="1" checked>
				TXT格式 <input type="radio" name="fileType" value="2"> EXCEL格式
				<input type="radio" name="fileType" value="3"> CSV格式</td>
		</tr>
		<tr>
			<td>导出字段：</td>
			<td><select multiple="multiple" class="exp-field"
				id="sourceFields">
					<c:forEach items="${fields}" var="field">
						<option value="${field.no}">${field.name}</option>
					</c:forEach>
			</select>
				<div class="exp-field field-opera">
					<div class="b-t-all opera-field" title="置顶"></div>
					<div class="b-t opera-field" title="上移"></div>
					<div class="l-r-all opera-field" title="右移全部"></div>
					<div class="l-r opera-field" title="右移"></div>
					<div class="r-l opera-field" title="左移"></div>
					<div class="r-l-all opera-field" title="左移全部"></div>
					<div class="t-b opera-field" title="下移"></div>
					<div class="t-b-all opera-field" title="置底"></div>
				</div> <select multiple="multiple" class="exp-field" id="expFields"
				name="fields">
			</select></td>
		</tr>
		<tr>
			<td height="25">&nbsp;</td>
			<td><input type="checkbox" name="title" value="1"> 导出标题</td>
		</tr>
		<tr>
			<td colspan="2" align="right" style="padding: 5px;"><a
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
				href="javascript:void(0)" onclick="javascript:exportExec();">开始导出</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				href="javascript:void(0)" onclick="$('#expDialog').dialog('close')">取
					消</a></td>
		</tr>
	</table>
</form>
<script language="javascript">
$(document.body).ready(function(){
	var sourceFields = $("#sourceFields");
	var expFields = $("#expFields"); 
	$(".l-r").click(function(){
		sourceFields.find("option:selected").each(function(){
			expFields.append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
		});
	});
	$(".r-l").click(function(){
		expFields.find("option:selected").remove();
	});	
	$(".l-r-all").click(function(){
		expFields.append(sourceFields.html());
	});
	$(".r-l-all").click(function(){
		expFields.empty();
	});
	$(".b-t-all").click(function(){
		var so = expFields.find("option:selected");
		var firstOption = expFields.find("option:first");
		if(so.length>0){
			if(so.get(0).index!=0){
				firstOption.before(so);
			}
		}
	});	
	$(".t-b-all").click(function(){
		var alloptions = expFields.find("option");  
		var so = expFields.find("option:selected");
		var firstOption = expFields.find("option:last");
		if(so.length>0){
		 	if(so.get(so.length-1).index!=alloptions.length-1){
				firstOption.after(so);
			}
		}
	});
	$(".b-t").click(function(){
		var so = expFields.find("option:selected");  
		if(so.length>0){
		    if(so.get(0).index!=0){  
		       so.each(function(){  
		           $(this).prev().before($(this));  
		       });  
		    }  
	    }
	});
	$(".t-b").click(function(){
		var alloptions = expFields.find("option");  
	    var so = expFields.find("option:selected");  
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
	
 	exportExec = function(){
 		var fields = "";
 		var fieldDescs = "";
 		expFields.find("option").each(function(){
 			fields += $(this).val() + ",";
 			fieldDescs += $(this).text() + ",";
 		});
 		if(fields.length>0) {
 			fields = fields.substring(0, fields.length-1);
 			fieldDescs = fieldDescs.substring(0, fieldDescs.length-1);
 		}else {
 			$.messager.alert('数据导出','请选择导出字段','error');
 			return; 			
 		}
 		$.messager.progress({
			text: '正在执行数据导出程序，请稍候...'
		}); 
		$("#exportForm").ajaxSubmit({
			data: {
				fields : fields,
				fieldDescs : fieldDescs
			},
			success : function(res){
				$.messager.progress('close');	
				if(res=='error'){
					$.messager.alert('数据导出','数据导出失败','error');
				}else{
					var t = $("#exportForm input:radio:checked").val();
					$('#expDialog').dialog('close');
					$.messager.alert('数据导出','数据导出成功。','info');
					window.location.href="df/download.zb?fid=${fid}&fn="+res+"&t="+t;
				}
			}
		});
	};
});
</script>