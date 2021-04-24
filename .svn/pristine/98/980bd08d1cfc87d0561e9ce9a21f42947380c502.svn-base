<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单</title>
<jsp:include page="../common.jsp" />
<script>
$(document).ready(function(){
  initForm();
});
function initForm(){
		var inputType="${inputType}";
		var formId="${formId}";
		var taskInstanceId="${taskInstanceId}";
		var title,colCount;
		$.ajax({  
         				type : "post",  
          				url : "form/selectForm.zb",  
          				data : "formId=" + formId, 
          				dataType:"json", 
          				async : false,  
          				success : function(forms){  
           					if(forms.lenght<1){
           						alert("没有查询到对应表单");
           					}else{
           						var form=forms[0];
           						title=form.formTitle;
           						colCount=form.formColumnNumber;
           					}
          				}  
     				}); 
		var colWidth=100;
		
		
		
		$.post("form/selectFormItemByFormId.zb",{formId:formId},function(data){
			//先清除原来的表单
			$("#inputTaskFormTable").empty();
			
			
			$("#inputTaskFormTable").append("<caption style=\"font-family:微软雅黑;font-size:18px;font-weight:bold\">"+title+"</caption>");
			for(var c=0;c<colCount;c++){
				$("#inputTaskFormTable").append("<th></th><th width='"+colWidth+"px'></th>");
			}
			//将表单项添加到表单中
			if(inputType=="0"){
				$("#inputTaskFormTable").append("<tr><td>实例名称</td><td colspan="+(colCount*2-1)+"><input type=\"text\" name=\"taskInstanceDescribe\"	class=\"easyui-textbox\" data-options=\"validType:['length[2,40]'], required:true, width:'200px'\" /></td></tr>");
			}
			var trHtml="";
			var rowNo=0;
			for(var i=0;i<data.length;i++){
				var trInput="";
				var formItem=data[i];
				rowNo+=formItem.colspan;
				var colspan=formItem.colspan*2-1;
				if(data[i].inputType=="radio"){
					$.ajax({  
         				type : "post",  
          				url : "dict/getDictItemByDictId.zb",  
          				data : "dictId=" + formItem.dictId, 
          				dataType:"json", 
          				async : false,  
          				success : function(dataOption){  
           					var checked="";
           					for(var j=0;j<dataOption.length;j++){
								if(dataOption[j].itemCode==formItem.defaultValue){
									checked="checked=\"checked\"";
								}else{
									checked="";
								}
							
								trInput=trInput+"<input type=\"radio\" "+checked+" name=\""+formItem.inputName+"\" value=\""+dataOption[j].itemCode+"\" />"+dataOption[j].itemName+"&nbsp;&nbsp;&nbsp;";
								
							} 
          				}  
     				}); 
					
					
				}else{
					trInput="<input class=\"easyui-"+formItem.inputType+"\" type=\"text\"  name=\""+formItem.inputName+"\" data-options=\"valueField:'itemCode',textField:'itemName',url:'dict/getDictItemByDictId.zb?dictId="+formItem.dictId+"'\" style=\"width:100%\" />";
				}
				
    			
				trHtml+="<td align=\"right\">"+formItem.inputDisplay+":</td><td colspan="+colspan+">"+trInput+"</td>";
				if(rowNo%colCount==0){
					$("#inputTaskFormTable").append("<tr>"+trHtml+"</tr>");
					trHtml="";
				}else
				if(i==data.length-1){
					$("#inputTaskFormTable").append("<tr>"+trHtml+"</tr>");
					trHtml="";
				}
				
				
			}
			
			
			
			
			var savebt="<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-save'\"  onclick=\"javascript:saveInputTaskInstance(1,1)\">保存</a>" ;
			var submitbt="<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-ok'\"  onclick=\"javascript:saveInputTaskInstance(1,2)\">提交</a>" ;
			var btTrHtml="<tr><td>"+savebt+"</td><td>"+submitbt+"</td></tr>";
			$("#inputTaskFormTable").append(btTrHtml);
			$.parser.parse("#inputTaskFormTable");
			if(taskInstanceId!=""&&taskInstanceId!="null"){
				$.post("inputTask/selectInputTaskInstanceData.zb",{taskId:"${taskId}",taskInstanceId:taskInstanceId},function(formData){
					$("#inputTaskInstanceForm").form("load",formData);
				},"json");
			}
		},"json");
	}
	function saveInputTaskInstance(inputType,state) {
		
		$("#inputType").val(inputType);
		if(inputType==1){
			$("#inputState").val(state);
			
		}else{
			$("#auditState").val(state);
		}
		$("#inputTaskInstanceForm").form("submit", {
			//提交前验证
			onSubmit : function() {
				$.messager.progress({
					title : "提示",
					text : "数据处理中，请稍后...."
				});
				var isValid = $(this).form("validate");
				if (!isValid) {
					$.messager.progress("close");
				}
				return isValid;
			},
			//提交成功
			success : function(result) {
				result = $.parseJSON(result);
				$.messager.progress("close");
				//操作成功,关闭对话框，显示提示信息，并重新加载功能组表格。
				if (result.success) {
					$.noty.closeAll();
					var n = noty({
						text : "操作成功",
						type : "success",
						layout : "topCenter",
						timeout : 1000
					});
				} else {//保存失败
					$.noty.closeAll();
					var n = noty({
						text : result.msg,
						type : "warning",
						layout : "topCenter",
						timeout : 1500
					});
				}
			}
		});
	}
	
	


</script>
</head>
<body class="easyui-layout">
	
	<div data-options="region:'center',title:''" style="padding: 20px 20px 20px 20px">
		
		<form id="inputTaskInstanceForm" method="post" action="inputTask/saveInputTaskInstance.zb">
		<input type="hidden" name="taskId" value="${taskId}">
		<input type="hidden" name="taskInstanceId" value="${taskInstanceId}">
		<input type="hidden" name="formId" value="${formId}">
		<input id="inputType" type="hidden" name="inputType" value="${inputType}">
		<input id="inputState" type="hidden" name="inputState" value="0">
		<input id="auditState" type="hidden" name="auditState" value="0">
		
		<table id="inputTaskFormTable" width="500px" >

						</table>
						

						
						</form>
      </div> 
     
</body>
</html>
