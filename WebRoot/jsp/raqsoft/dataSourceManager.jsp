<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
	function booleanFormatter(value,row,index){
		
					if(value== "true")
							return "是";
							else
					if(value=="false")
							return "否";
							else
							return value;
							
		}
	
	
	function dbTypeFormatter(value,row,index){
		
					if(value== "0")
							return "UNKNOWN";
							else
					if(value=="1")
							return "ORACLE";
							else
					if(value== "2")
							return "SQLSVR";
							else
					if(value== "3")
							return "SYBASE";
							else
					if(value== "4")
							return "SQLANY";
							else
					if(value== "5")
							return "INFMIX";
							else
					if(value== "6")
							return "FOXPRO";
							else
					if(value== "7")
							return "ACCESS";
							else
					if(value== "8")
							return "FOXBAS";
							else
					if(value== "9")
							return "DB2";
							else
					if(value== "10")
							return "MYSQL";
							else
					if(value== "11")
							return "KINGBASE";
							else
					if(value== "12")
							return "DERBY";
							else
					if(value== "13")
							return "HSQL";
							else
					if(value== "14")
							return "TERADATA";
					if(value== "15")
							return "POSTGRES";
							else
							return "UNKNOWN";
					
		
	}
	function deleteDS(){
		var rows=$("#dg").datagrid("getChecked");
		if(rows.length<1){
			alert("请至少选择一行进行删除");
			return;
		}
		var dsNames="";
		for(var i=0;i<rows.length;i++){
			dsNames+=rows[i].name+",";
		}
		dsNames=dsNames.substr(0, dsNames.length - 1);
		$.messager.confirm("提示", "您确认要删除吗?", function(r){
			if (!r){
				return;
			}
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
			$.post("raqsoft/deleteDataSource.zb",{names:dsNames},function(data){
				if(data.success){
					var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
					$("#dg").datagrid("load");
				}else{
					$.messager.alert("错误","删除数据时出现系统错误!","error");
				}
				$.messager.progress("close");
			},"json");
		});
	}
	function editDS(){
		var rows=$("#dg").datagrid("getChecked");
		if(rows.length!=1){
			alert("请选择一行进行编辑");
			return;
		}
		showDSWin(rows[0],1);
	}
	function showDSWin(rowData,editType){
		$("#editType").val(editType);
		if(editType==1){
			$("#dsName").textbox('readonly',true);
		}else{
			$("#dsName").textbox('readonly',false);
		}
		$("#type").combobox('setValue',rowData.type);
		//$("#dBCharset").textbox('setValue',rowData.dbcharset);
		//alert(rowData.needTransContent);
		//$("#needTransContent").combobox('setValue',1);
		//$("#needTransSentence").combobox('setValue',1);
		//$("#caseSentence").combobox('setValue',1);
		
		$('#dsForm').form('load',rowData);
		
		var $dialog = $("#dataSourceWin");
		$dialog.dialog("open");
	}
	/**
	 * 保存信息（增加或者更新）
	 */
	function save(dialog,form){
		var $form = $("#"+form);
		var $dialog = $("#"+dialog);
		$form.form("submit",{
			//提交前验证
			onSubmit:function(param){
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
				if(result.success){//操作成功
					$("#dg").datagrid("reload");
					$dialog.dialog("close");
					$.noty.closeAll();
					var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
				}else{//保存失败
					$.messager.alert("错误","保存数据时出现系统错误!","error");
				}
			}
		});
	}
	
	/**
	 * 测试数据库连接
	 */
	function testDS(form){
		var $form = $("#"+form);
		$.post("raqsoft/testDataSource.zb",$form.serializeArray(),function(data){
			if(data.success){
				
				$.messager.alert("信息",data.msg,"info");
				
				
			}else{
				$.messager.alert("错误",data.msg,"error");
			}
			$.messager.progress("close");
		},"json");
		
	}
	/**
	 * 点击编辑或者增加窗口中的取消按钮操纵。
	 * @param dialog 窗口ID
	 * @param form 表单ID
	 */
	function cancel(dialog,form){
		var $form = $("#"+form);
		var $dialog = $("#"+dialog);
		$dialog.dialog("close");
		$form.form("clear");
	}
	/**
	 * 修改数据库类型操纵。
	 * @param record 选项
	 */
	 function changeType(record){
	 	var driverData,urlData;
	 	var value=record.value;
	 	if(value== "0"){
							driverData=[];
							urlData=[];
							}else
					if(value=="1"){
							driverData=[{"text":"oracle.jdbc.driver.OracleDriver"}];
							urlData=[{"text":"jdbc:oracle:thin:@192.168.0.1:1521:[数据库名]"}];
							}else
					if(value== "2"){
							driverData=[{"text":"com.newatlanta.jturbo.driver.Driver"},{"text":"com.microsoft.sqlserver.jdbc.SQLServerDriver"}];
							urlData=[{"text":"jdbc:JTurbo://192.168.0.1/[DB Name]/charset=GBK"},{"text":"jdbc:sqlserver://192.168.0.1:1433;DatabaseName=[DB Name]"}];
							}else
					if(value== "3"){
							driverData=[{"text":"com.sybase.jdbc3.jdbc.SybDriver"}];
							urlData=[{"text":"jdbc:sybase:Tds:192.168.0.1:2048/[数据库名]"}];
							}else
					if(value== "4"){
							driverData=[{"text":""}];
							urlData=[{"text":""}];
							}else
					if(value== "5"){
							driverData=[{"text":"com.informix.jdbc.IfxDriver"}];
							urlData=[{"text":"jdbc:informix-sqli://192.168.0.1:1526/[数据库名]"}];
							}else
					if(value== "6"){
							driverData=[{"text":""}];
							urlData=[{"text":""}];
							}else
					if(value== "7"){
							driverData=[{"text":"sun.jdbc.odbc.JdbcOdbcDriver"}];
							urlData=[{"text":"jdbc:odbc:[odbc数据源名]"}];
							}else
					if(value== "8"){
							driverData=[{"text":""}];
							urlData=[{"text":""}];
							}else
					if(value== "9"){
							driverData=[{"text":"COM.ibm.db2.jdbc.app.DB2Driver"},{"text":"COM.ibm.db2.jdbc.net.DB2Driver"},{"text":"com.ibm.db2.jcc.DB2Driver"}];
							urlData=[{"text":"jdbc:Db2:[数据库名]"},{"text":"jdbc:db2://192.168.0.1:6789/[sample]"}];
							}else
					if(value== "10"){
							driverData=[{"text":"com.mysql.jdbc.Driver"}];
							urlData=[{"text":"jdbc:mysql://192.168.0.1:3306/[数据库名]?useCursorFetch=[true/false]"}];
							}else
					if(value== "11"){
							driverData=[{"text":""}];
							urlData=[{"text":""}];
							}else
					if(value== "12"){
							driverData=[{"text":"org.apache.derby.jdbc.EmbeddedDriver"}];
							urlData=[{"text":"jdbc:postgresql://127.0.0.1:5432/[database name]"}];
							}else
					if(value== "13"){
							driverData=[{"text":"org.hsqldb.jdbcDriver"}];
							urlData=[{"text":"jdbc:hsqldb:hsql://127.0.0.1/[数据库名]"}];
							}else
					if(value== "14"){
							driverData=[{"text":""}];
							urlData=[{"text":""}];
							}else
					if(value== "15"){
							driverData=[{"text":"org.postgresql.Driver"}];
							urlData=[{"text":"jdbc:postgresql://127.0.0.1:5432/[database name]"}];
							}else{
							driverData=[];
							urlData=[];
							}
		$("#driver").combobox("loadData",driverData);
		$("#url").combobox("loadData",urlData);
	 }
	</script>

</head>
<body class="easyui-layout" data-options="fit:true">
	
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<div id="tb" style="height: auto; display: none">
			<a onclick="showDSWin({'type':'0','batchSize':1000,'dbCharset':'GBK','clientCharset':'GBK'},0);"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">新建数据源</a>
				<a onclick="editDS();"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">编辑数据源</a>
				<a onclick="deleteDS();"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-del',plain:true">删除数据源</a>
		</div>
		<!-- grid定义 -->
		<table id="dg" class="easyui-datagrid" title="资源列表"
			style="display: none"
			data-options="collapsible:true,
				iconCls:'icon-module',
				url:'raqsoft/getDataSourceList.zb',method:'post',
				height:$(this).height(),
				rownumbers:true,
				toolbar: '#tb',
				fit:true,
				fitColumns:true,
				collapsible:false,
				frozenColumns:[[
			    	{field:'ck',checkbox:true}
			    ]],
				onDblClickRow: function(rowIndex, rowData){
					
					showDSWin(rowData,1);
					
				}
			">
			<thead>
				<tr>
					<th
						data-options="field:'id',width:16,align:'right'"></th>
					<th
						data-options="field:'name',width:120,align:'left',halign:'left'">数据源名称</th>
					<th
						data-options="field:'type',width:120,align:'left',halign:'left',formatter:dbTypeFormatter">数据库类型</th>
					<th
						data-options="field:'dbCharset',width:120,align:'left',halign:'left'">数据库编码</th>
					<th
						data-options="field:'clientCharset',width:120,align:'left',halign:'left'">客户端编码</th>
					<th
						data-options="field:'driver',width:120,align:'left',halign:'left'">驱动</th>
					<th
						data-options="field:'needTransContent',width:120,align:'left',halign:'left',formatter:booleanFormatter">数据是否转码</th>
					<th
						data-options="field:'needTransSentence',width:120,align:'left',halign:'left',formatter:booleanFormatter">sql是否转码</th>
					<th
						data-options="field:'caseSentence',width:120,align:'left',halign:'left',formatter:booleanFormatter">sql区分大小写</th>
					

					
				</tr>
			</thead>
		</table>
	</div>
	<!-- 编辑数据源窗口 -->
	<div id="dataSourceWin" class="easyui-window" title="数据源信息"
		style="width:550px; height: 400px"
		data-options="iconCls:'icon-save',modal:true,closed:true,collapsible:false,minimizable:false,maximizable:false">
		<div style="margin: 10px;">
			<div style="padding: 10px 0 10px 20px">
				<form id="dsForm" action="raqsoft/saveDataSource.zb" method="post">
					<input type="hidden" name="editType" id="editType" value="" /> 
						
					<table>
						<tr>
							<td>名称:</td>
							<td><input id="dsName" class="easyui-textbox" type="text"
								name="name"
								data-options="required:true,validType:['length[1,20]','checkModuleCode','commonChar'],width:150"
								placeholder="不能大于20个字" /></td>
						
							<td>数据库类型:</td>
							<td>
								<select id="type" class="easyui-combobox" name="type" style="width:150px;" >   
    								<option value="0">UNKNOWN</option>   
    								<option value="1">ORACLE</option>   
    								<option value="2">SQLSVR</option>   
    								<option value="3">SYBASE</option>   
    								<option value="4">SQLANY</option>   
    								<option value="5">INFMIX</option>   
    								<option value="6">FOXPRO</option>   
    								<option value="7">ACCESS</option>   
    								<option value="8">FOXBAS</option>   
    								<option value="9">DB2</option>   
    								<option value="10">MYSQL</option>   
    								<option value="11">KINGBASE</option>   
    								<option value="12">DERBY</option>   
    								<option value="13">HSQL</option>   
    								<option value="14">TERADATA</option>
    								<option value="15">POSTGRES</option>
    								
    								
    								
								</select> 
								</td>
						</tr>
						<tr>
							<td>驱动:</td>
							<td colspan=3><input id="driver" class="easyui-textbox" type="text"
								name="driver"
								data-options="valueField:'text',textField:'text',required:true,validType:'length[1,255]',width:400"
								placeholder="不能大于255个字" /></td>

						</tr>
						<tr>
							<td>连接串:</td>
							<td colspan=3><input id="url" class="easyui-textbox" type="text"
								name="url"
								data-options="valueField:'text',textField:'text',required:true,validType:'length[1,255]',width:400"
								placeholder="不能大于255个字" /></td>

						</tr>
						<tr>
							<td>用户名:</td>
							<td><input id="user" class="easyui-textbox" type="text"
								name="user"
								data-options="validType:'length[1,50]',width:150"
								placeholder="不能大于50个字" /> </td>

						
							<td>密码:</td>
							<td ><input id="password" class="easyui-textbox" type="text"
								name="password"
								data-options="validType:'length[1,50]',width:150"
								placeholder="不能大于50个字" /> </td>

						</tr>
						<tr>
							<td>数据库编码:</td>
							<td><input id="dbCharset" class="easyui-textbox" type="text"
								name="dbCharset"
								data-options="width:80" /> 
								</td>

						
							<td>客户端编码:</td>
							<td><input id="clientCharset" class="easyui-textbox" type="text"
								name="clientCharset"
								data-options="width:80" />
								</td>
								
							
						</tr>
						
						<tr>
						<td>批大小:</td>
							<td><input id="batchSize" class="easyui-numberbox" type="text"
								name="batchSize"
								data-options="width:80" />
								</td>
						</tr>
						<tr>
							<td>数据是否转码:</td>
							<td><select id="needTransContent" class="easyui-combobox" name="needTransContent" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
								</td>

						
							<td>sql是否转码:</td>
							<td>
								<select id="needTransSentence" class="easyui-combobox" name="needTransSentence" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
								</td>

						</tr>
						<tr>
							<td>sql区分大小写:</td>
							<td>
								<select id="caseSentence" class="easyui-combobox" name="caseSentence" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
							</td>
							<td>是否自动连接:</td>
							<td>
								<select id="autoConnect" class="easyui-combobox" name="autoConnect" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
							</td>
						</tr>
						<tr>
							<td>使用模式名:</td>
							<td>
								<select id="useSchema" class="easyui-combobox" name="useSchema" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
							</td>
							<td>addTilde:</td>
							<td>
								<select id="addTilde" class="easyui-combobox" name="addTilde" style="width:80px;">   
    								<option value="false">否</option>   
    								<option value="true">是</option>
								</select> 
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div id="dlg-buttons"  style="text-align:center;padding:5px 0 0;">
				<a onclick="testDS('dsForm');" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'">测试</a>
					<a onclick="save('dataSourceWin','dsForm');" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'">确定</a>
					 <a
					onclick="cancel('dataSourceWin','dsForm');" class="easyui-linkbutton"
					data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
	
	</div>
</body>
</html>

