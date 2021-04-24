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
function form2json(rootNode, delimiter) {
    rootNode = typeof rootNode == 'string' ? document.getElementById(rootNode) : rootNode;
    delimiter = delimiter || '.';
    var formValues = getFormValues(rootNode);
    var result = {};
    var arrays = {};

    for (var i = 0; i < formValues.length; i++) {
        var value = formValues[i].value;
        if (value === '') continue;

        var name = formValues[i].name;
        var nameParts = name.split(delimiter);

        var currResult = result;

        for (var j = 0; j < nameParts.length; j++) {
            var namePart = nameParts[j];

            if (namePart.indexOf('[]') > -1 && j == nameParts.length - 1) {
                var arrName = namePart.substr(0, namePart.indexOf('['));

                if (!currResult[arrName]) currResult[arrName] = [];
                currResult[arrName].push(value);
            }
            else if (namePart.indexOf('[') > -1) {
                var arrName = namePart.substr(0, namePart.indexOf('['));
                var arrIdx = namePart.replace(/^[a-z]+\[|\]$/gi, '');

                /*
                 Т.к. индексы у нас могут не быть от 0 и с шагом 1,
                 то напрямую в массив запихивать данные нельзя.
                 Значит, делаем хеш, в котором по значению индекса в arrIdx
                 храним ссылку на соответствующий элемент массива
                 */

                if (!arrays[arrName]) arrays[arrName] = {};
                if (!currResult[arrName]) currResult[arrName] = [];

                if (j == nameParts.length - 1) {
                    currResult[arrName].push(value);
                }
                else if (!arrays[arrName][arrIdx]) {
                    currResult[arrName].push({});
                    arrays[arrName][arrIdx] = currResult[arrName][currResult[arrName].length - 1];
                }

                currResult = arrays[arrName][arrIdx];
            }
            else {
                if (j < nameParts.length - 1) /* Not the last part of name - means object */
                {
                    if (!currResult[namePart]) currResult[namePart] = {};
                    currResult = currResult[namePart];
                }
                else {
                    currResult[namePart] = value;
                }
            }
        }
    }

    return result;
}

function getFormValues(rootNode) {
    var result = [];
    var currentNode = rootNode.firstChild;

    while (currentNode) {
        if (currentNode.nodeName.match(/INPUT|SELECT|TEXTAREA|FIELDSET/i)) {
            result.push({ name: currentNode.name, value: getFieldValue(currentNode)});
        }
        else {
            var subresult = getFormValues(currentNode);
            result = result.concat(subresult);
        }

        currentNode = currentNode.nextSibling;
    }

    return result;
}

function getFieldValue(fieldNode) {
    if (fieldNode.nodeName == 'INPUT') {
        if (fieldNode.type.toLowerCase() == 'radio' || fieldNode.type.toLowerCase() == 'checkbox') {
            if (fieldNode.checked) {
                return fieldNode.value;
            }
        }
        else {
            if (!fieldNode.type.toLowerCase().match(/button|reset|submit|image/i)) {
                return fieldNode.value;
            }
        }
    }
    else {
        if (fieldNode.nodeName == 'TEXTAREA') {
            return fieldNode.innerHTML;
        }
        else {
            if (fieldNode.nodeName == 'SELECT') {
                return getSelectedOptionValue(fieldNode);
            }
        }
    }

    return '';
}

function getSelectedOptionValue(selectNode) {
    var multiple = selectNode.multiple;
    if (!multiple) return selectNode.value;

    var result = [];
    for (var options = selectNode.getElementsByTagName("option"), i = 0, l = options.length; i < l; i++) {
        if (options[i].selected) result.push(options[i].value);
    }

    return result;
}
</script>
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
	alert(JSON.stringify(form2json("form")));
	$.post(
			"mongodb/save.zb",
			{
				data : JSON.stringify(form2json("form")) ,
				rpx : 'testForm'
			},
			function(result){
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
			},
			"json"
		);
	
	/* $form.form("submit",{
		url: 'mongodb/save.zb',
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
	}); */
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
				<input name="rpx" value="testForm" type="text"
					data-options="validType:['length[0,20]'],width:130,value:'testForm'"
					class="easyui-textbox" /> <input name="id" type="hidden" />
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
			data-options="url:'mongodb/find.zb?rpx=testForm',singleSelect:true,toolbar:'#tb',fit:true,onDblClickRow:editRow">
			<thead>
				<tr>
					<th
						data-options="field:'id',width:20,formatter:function(value,rowData, rowIndex){
				return rowIndex+1;
			}">序号</th>
					<th data-options="field:'data.name',width:100">姓名</th>
					<th data-options="field:'data.incumbentPost',width:200">现任职务</th>
					<th
						data-options="field:'data.gender',width:50,formatter:function(value,rowData, rowIndex){
				if(value==1) return '男';
				else if(value==0) return '女';
				else return value;
			}">性别</th>
					<th data-options="field:'data.nation',width:50">民族</th>
					<th data-options="field:'data.placeOfOrigin',width:200">籍贯</th>
					<th data-options="field:'data.educationDegree',width:80">学历学位</th>
					<th
						data-options="field:'data.birthday',width:80,formatter:formatDate">出生日期</th>
					<th
						data-options="field:'data.partyTime',width:80,formatter:formatDate">入党时间</th>
					<th
						data-options="field:'data.takeWorkTime',width:80,formatter:formatDate">参加工作时间</th>
					<th data-options="field:'data.remarks',width:200">备注</th>
				</tr>
			</thead>
		</table>

	</div>
</body>
</html>