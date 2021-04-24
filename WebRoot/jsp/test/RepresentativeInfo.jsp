<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
function formatDate(value,rowData, rowIndex){
	if(value==null)return value;
	return value.substring(0,10);
}
function addRow(){
	$("#form").form("clear");
	$("#detailDlg").dialog('open');
	return 0;
	
}
function delRow(){
	var row=$("#dataTable").datagrid('getSelected');
	if(row==null){
		$.messager.alert("错误","请选择要删除的行","error");
	}else{
		$.post("test/deleteRepresentativeInfo.zb",{id:row.id},function(data){
			if(data.success){
				$("#dataTable").datagrid("reload");
				$.noty.closeAll();
				var n = noty({text: "成功删除",type:"success",layout:"topCenter",timeout:1000});
			}else{
				$.messager.alert("错误","删除时出现系统错误!","error");			
			}
		},"json");
	}
	return 0;
	
}
function editRow(rowIndex, rowData){
	$("#form").form("load",rowData);
	$("#detailDlg").dialog('open');
	return 0;
	
}
function saveData(){
	
	var $form = $("#form");
	var $dialog = $("#detailDlg");
	$form.form("submit",{
		url: 'test/saveRepresentativeInfo.zb',
		//提交前验证
		onSubmit:function(){
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});	
			var isValid = $(this).form("validate");
			if (!isValid) {
				$.messager.progress("close");
			}
			return isValid;
		},
		//提交成功
		success:function(result){
			result = $.parseJSON(result);
			$.messager.progress("close");
			if(result.success){//保存成功
				$("#dataTable").datagrid("reload");
				$dialog.dialog("close");
				$.noty.closeAll();
				var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误","操作失败","error");
			}
		}
	});
}

</script>

</head>
<body class="easyui-layout" data-options="border:false">

	<!-- 弹出窗口 -->
	<div style="display: none;">
		<div id="detailDlg" class="easyui-dialog" style="padding-top: 5px"
			data-options="
			title: '详细信息',
			buttons: '#dlgbtn',
			resizable:true,
		    width: 600,
		    height: 500,
		    closed: true,
		    cache: false,
		    modal: true
		">
			<form id="form" action="" method="post">
				<input name="id" type="hidden" />
				<table style="margin: 0 auto;">
					<tr>
						<td>姓名：</td>
						<td><input type="text" name="name"
							data-options="validType:['length[0,20]'],width:130"
							class="easyui-textbox" /></td>
					</tr>
					<tr>
						<td>性别：</td>
						<td><input type="radio" name="gender" value="1" checked />男 <input
							type="radio" name="gender" value="0" />女</td>
					</tr>
					<tr>
						<td>现任职务：</td>
						<td colspan=3><input type="text" name="incumbentPost"
							data-options="validType:['length[3,12]'],width:300"
							class="easyui-textbox" /></td>
					</tr>
					<tr>
						<td>民族：</td>
						<td><input id="org" class="easyui-combobox" name="nation"
							style="width: 130px;"
							data-options="
							
							url:'dict/findDictItemByDictCode.zb?dictCode=nation',
							valueField:'value',    
    						textField:'text'
							
						">
						</td>
					</tr>
					<tr>
						<td>学历学位：</td>
						<td><input id="org" class="easyui-combobox"
							name="educationDegree" style="width: 130px;"
							data-options="
							
							url:'dict/findDictItemByDictCode.zb?dictCode=educationDegree',
							valueField:'value',    
    						textField:'text'
							
						">
						</td>
					</tr>
					<tr>
						<td>籍贯：</td>
						<td colspan=3><input type="text" name="placeOfOrigin"
							data-options="validType:['length[3,255]'],width:300"
							class="easyui-textbox" /></td>
					</tr>

					<tr>
						<td>出生日期：</td>
						<td><input type="text" name="birthday" class="easyui-datebox"
							data-options="width:130" /></td>
					</tr>
					<tr>

						<td>入党时间：</td>
						<td><input type="text" name="partyTime"
							class="easyui-datebox" data-options="width:130" /></td>
					</tr>
					<tr>
						<td>参加工作时间：</td>
						<td><input type="text" name="takeWorkTime"
							class="easyui-datebox" data-options="width:130" /></td>
					</tr>
					<tr>
						<td>岗位：</td>
						<td colspan=3><input type="radio" name="isLeadingCadres"
							value="1" checked="checked" />领导干部 <input type="radio"
							name="isLeadingCadres" value="2" />专业技术人员 <input type="radio"
							name="isLeadingCadres" value="3" />其他(含离退休干部)</td>
					</tr>

					<tr>
						<td>先进模范：</td>
						<td><input type="radio" name="isXjmf" value="1"
							checked="checked" />是 <input type="radio" name="isXjmf" value="0" />否
						</td>
						<td>上届党委委员：</td>
						<td><input type="radio" name="isSjdwwy" value="1"
							checked="checked" />是 <input type="radio" name="isSjdwwy"
							value="0" />否</td>
					</tr>
					<tr>
						<td>上届纪委委员：</td>
						<td><input type="radio" name="isSjjwwy" value="1"
							checked="checked" />是 <input type="radio" name="isSjjwwy"
							value="0" />否</td>
						<td>上届代表：</td>
						<td><input type="radio" name="isSjdb" value="1"
							checked="checked" />是 <input type="radio" name="isSjdb" value="0" />否
						</td>
					</tr>

					<tr>
						<td>备注：</td>
						<td colspan="3"><textarea name="remarks"
								class="easyui-validatebox" style="width: 332px; height: 70px"
								data-options="
							validType:'length[0,255]'
						"></textarea>
						</td>
					</tr>
				</table>

			</form>
			<div id="dlgbtn">
				<a class="easyui-linkbutton" onclick="saveData()"
					data-options="iconCls:'icon-ok'">确定</a> <a
					class="easyui-linkbutton"
					onclick="$('#detailDlg').dialog('close');"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center',border:false">
		<div id="tb">
			<a class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true" onclick="addRow();">新增</a>
			<a class="easyui-linkbutton"
				data-options="iconCls:'icon-del',plain:true" onclick="delRow();">删除</a>
			<a class="easyui-linkbutton"
				data-options="iconCls:'icon-reload',plain:true,onClick:function(){$('#dataTable').datagrid('reload');}">刷新</a>
		</div>

		<table id="dataTable" class="easyui-datagrid"
			data-options="url:'test/getRepresentativeInfoList.zb',singleSelect:true,toolbar:'#tb',fit:true,onDblClickRow:editRow">
			<thead>
				<tr>
					<th
						data-options="field:'id',width:20,formatter:function(value,rowData, rowIndex){
				return rowIndex+1;
			}">序号</th>
					<th data-options="field:'name',width:100">姓名</th>
					<th data-options="field:'incumbentPost',width:200">现任职务</th>
					<th
						data-options="field:'gender',width:50,formatter:function(value,rowData, rowIndex){
				if(value==1) return '男';
				else if(value==0) return '女';
				else return value;
			}">性别</th>
					<th data-options="field:'nation',width:50">民族</th>
					<th data-options="field:'placeOfOrigin',width:200">籍贯</th>
					<th data-options="field:'educationDegree',width:80">学历学位</th>
					<th data-options="field:'birthday',width:80,formatter:formatDate">出生日期</th>
					<th data-options="field:'partyTime',width:80,formatter:formatDate">入党时间</th>
					<th
						data-options="field:'takeWorkTime',width:80,formatter:formatDate">参加工作时间</th>
					<th data-options="field:'remarks',width:200">备注</th>
				</tr>
			</thead>
		</table>

	</div>
</body>
</html>