<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 最新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="df/includes/bootstrap/2.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="df/includes/easyui/1.3.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="df/includes/easyui/1.3.5/themes/icon.css">
<link rel="stylesheet" href="df/css/index.css">
<title>表单设计</title>
<script type="text/javascript"
	src="df/includes/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript"
	src="df/includes/easyui/1.3.5/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="df/includes/easyui/1.3.5/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/jquery.easyui.extend.min.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/mask.js"></script>
<script type="text/javascript" src="df/form.js"></script>
<script type="text/javascript">
		var viewBasicPath = "${viewBasicPath}";
		var dbUpdate = "${dbUpdate}";
	</script>
<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	color: #666;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

#helptt p {
	font-size: 14px;
	line-height: 20pt;
}

.contact-us {
	font-size: 13px;
	float: right;
	font-weight: bold;
}

.icon-copy {
	background: url("df/images/copy.png") no-repeat;
}

.icon-load {
	background: url("df/images/load.png") no-repeat;
}

.icon-email {
	background: url("df/images/email.png") no-repeat;
}

.icon-update {
	background: url('df/images/update.png') no-repeat;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div id="helpdlg" class="easyui-dialog" title="使用说明【自定义表单】"
		data-options="iconCls:'icon-help',closed: true"
		style="width: 800px; height: 500px; padding: 1px;">
		<div id="helptt" class="easyui-tabs">
			<div title="表单基本信息" style="padding: 10px;" class="easyui-layout">
				<p>
					基本信息分为：<strong>编码、名称、表名、界面风格、说明和所属模块 </strong><br /> 1.<strong>编码</strong>为必填项，且必须保证唯一性。<br />
					2.<strong>名称</strong>为该表单对应的中文名称，可以为空。如果为空将默认为编码值。<br /> 3.<strong>表名</strong>为该表单对应的数据库存储的表名，可以为空。如果为空将默认为编码值。<br />
					4.界面目前支持三种<strong>风格</strong>，标准、查询（简单）和查询（标准）。如果为空默认为标准界面风格。<br />
					5.<strong>说明</strong>为该表单的备注信息，可以为空。<br /> 6.<strong>所属模块</strong>用于和BTP平台的模块管理进行对接，模块数据来源于BTP平台的功能模块管理。表单一旦选择模块保存发布后，此表单将作为一个功能保存在BTP平台的模块管理中，接收平台的配置管理（譬如权限）。
				</p>
			</div>
			<div title="表单字段信息" style="padding: 10px;" class="easyui-layout">
				<p>
					字段分为四大模块属性。<strong>基本、数据库表、校验和列表属性</strong> <br /> 1.<strong>字段基本属性</strong>包含字段的常用属性。其中编码是必填项。如果不填，保存时将自动省略此字段。其余项皆有默认值，可选填。
					<strong>默认值参考【字段类型：text，名称：编码值】</strong><br /> 2.<strong>数据库表属性</strong>是此字段对应的数据库表的字段定义，可选填。<strong>默认值参考【字段名：编码值，字段长度：255】</strong><br />
					3.<strong>字段校验属性</strong>主要用于表单提交前的前端校验定义，可选填。其中“字段验证”填写其他的字段编码，用于和其他字段进行值匹配。主要用于密码验证。
					字段长度如果不填写，默认最大长度值为数据库字段长度的三分之一（主要考虑64位ORACLE中文字符的问题）。<br /> 4.<strong>列表属性</strong>用来配置数据列表显示字段的定义，可选填。<strong>默认值参考【列表宽度：100】</strong><br />
					5.字段<strong>数据源定义</strong>用于该字段与其他模块（数据）的关系定义，支持自定义、字典和表单关联<span
						class="label label-success">v1.2</span>三种模式，目前只能类型为select、radio、checkbox下使用。<br />
				</p>
			</div>
			<div title="表单操作区" style="padding: 10px;" class="easyui-layout">
				<p>
					表单操作区包含<strong>新建、保存、删除、发布和帮助</strong>功能。 <br /> 1.<strong>新建</strong>操作会清空所有数据，建立一个新表单。<br />
					2.<strong>保存</strong>操作主要用于保存表单的所有信息。<span
						class="badge badge-important">注意</span>：保存完成后，可以浏览表单的界面效果，但是无法做任何操作，且BTP模块管理也无法看到此表单。<br />
					3.<strong>删除</strong>操作主要用于删除表单的信息。<span
						class="badge badge-important">注意</span>：删除的信息包括表单的基本信息、表单字段的信息、表单的数据信息（发布后）和表单的模块信息（发布后）。且无法恢复，请谨慎使用。<br />
					4.表单定义成功后必须<strong>发布</strong>后才能进行数据操作和模块管理。<span
						class="badge badge-important">注意</span>：一旦发布，该表单将无法修改任何信息。<br />
					5.<span class="label label-success">v1.1</span>表单发布后如果想重新修改，可以使用<strong>取消发布</strong>操作。<span
						class="badge badge-important">注意</span>：表单取消发布后，对应的数据库表数据将被删除(系统会自动创建备份表用于保存历史数据。备份表的命名规则为“BAK_表名_时间戳”,如“BAK_USER_20140329093720”)和模块的关联也将被取消，表单将恢复到发布前的状态。<br />
					6.<span class="label label-success">v1.1</span>如果您创建的表单大部分的字段信息和以前的某个表单相似，那么您可以<strong>载入表单</strong>和<strong>复制表单</strong>操作来自动加载表单和字段信息，减轻工作量。
					<span class="badge badge-important">注意</span>：<strong>载入表单</strong>和<strong>复制表单</strong>的区别在于一个只提供数据载入，另一个提供自动保存功能。另外复制出的新表单默认为未发布状态。<br />
					7.<span class="label label-success">v1.2</span><strong>系统更新</strong>主要用于检查和升级数据库表的版本信息，此功能主要由开发人员操作使用。
				</p>
			</div>
			<div title="注意事项" style="padding: 10px;" class="easyui-layout">
				<p>
					1.如果所有字段都未选择<span class="badge badge-important">列表查询</span>，系统将自动设置成标准风格（不管选择任何风格都没用）。<br />
					2.字段校验属性中的<span class="badge badge-important">字段验证</span>如果不为空，那么该字段将不会建立数据库关联（不会保存于数据库表）。<br />
					3.如果字段类型选择<span class="badge badge-important">密码框</span>，那么输入该字段的信息将自动进行MD5加密。<br />
					4.目前校验仅支持文本框、多项选择框、选择框、电子邮件框、密码框五种字段类型。<br />
				</p>
			</div>
		</div>
	</div>
	<!-- 载入表单 -->
	<div id="loaddlg" class="easyui-dialog" title="载入表单"
		data-options="iconCls:'icon-load',closed: true,modal:true"
		style="width: 500px; height: 150px; padding: 1px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<form class="form-horizontal">
					<div class="control-group">
						<label class="control-label">请选择载入表单来源：</label>
						<div class="controls">
							<input class="easyui-combobox" id="loadFormSources"
								name="loadFormSources"
								data-options="valueField:'id',textField:'name'">
						</div>
					</div>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align: right; padding: 5px 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="javascript:loadStart();">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#loaddlg').dialog('close')">取消</a>
			</div>
		</div>
	</div>
	<!-- 复制表单 -->
	<div id="copydlg" class="easyui-dialog" title="复制表单"
		data-options="iconCls:'icon-copy',closed: true,modal:true"
		style="width: 500px; height: 400px; padding: 1px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<form class="form-horizontal" action="dfcode/copyForm.zb"
					method="post">
					<div class="control-group">
						<label class="control-label">请选择复制表单来源：</label>
						<div class="controls">
							<input class="easyui-combobox" id="copyFormSources" name="id"
								data-options="valueField:'id',textField:'name'">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">新表单编码：</label>
						<div class="controls">
							<input type="text" class="easyui-validatebox" name="no"
								placeholder="请输入表单编码">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">新表单名称：</label>
						<div class="controls">
							<input type="text" class="easyui-validatebox" name="name"
								placeholder="请输入表单名称">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">新表单表名：</label>
						<div class="controls">
							<input type="text" class="easyui-validatebox" name="table"
								placeholder="请输入表单对应的数据库表名">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">新表单表名：</label>
						<div class="controls">
							<textarea name="remark" class="easyui-validatebox"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align: center; padding: 5px 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
					href="javascript:void(0)" onclick="javascript:copyStart();">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					href="javascript:void(0)" onclick="$('#copydlg').dialog('close')">取消</a>
			</div>
		</div>
	</div>
	<!-- 数据源定义框 -->
	<div id="dsd" class="easyui-dialog" title="数据源定义"
		style="width: 400px; height: 300px;" closed="true" modal="true"
		buttons="#ds-buttons">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north',split:true,border:false"
				style="height: 35px">
				<form class="form-horizontal">
					<div class="control-group">
						<label class="control-label"><strong>请选择数据源定义方式：</strong></label>
						<div class="controls">
							<label class="radio inline"> <input type="radio"
								class="ds-type" name="dsType" value="1" checked> 基本
							</label> <label class="radio inline"> <input type="radio"
								class="ds-type" name="dsType" value="2"> 字典
							</label> <label class="radio inline"> <input type="radio"
								class="ds-type" name="dsType" value="3"> 表单关联
							</label>
						</div>
					</div>
				</form>
			</div>
			<div data-options="region:'center',border:false">
				<div id="dsBasic" class="ds-info easyui-layout" fit="true">
					<table id="dsGrid" class="easyui-datagrid" fit="true"
						toolbar="#dsTool" singleSelect="true">
						<thead>
							<tr>
								<th
									data-options="field:'dsValue',width:150,editor:'validatebox'">值</th>
								<th data-options="field:'dsText',width:150,editor:'validatebox'">描述</th>
								<th
									data-options="field:'del', width: 60, align: 'center', formatter: function(value, rowData, rowIndex){
				            	return '<a href=\'javascript:removeRecord(2);\'><i
									class=\'icon-delete\'></i></a>'; }">删除</th>
							</tr>
						</thead>
						<div id="dsTool" style="margin: auto;">
							<a href="javascript:addRecord('dsGrid');"
								class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
						</div>
					</table>
				</div>
				<div id="dsDict" class="ds-info easyui-layout" fit="true">
					<div data-options="region:'west',split:true,width: 160">
						<ul id="dictTree"></ul>
					</div>
					<div class="easyui-layout" data-options="region:'center'"
						style="padding: 1px;">
						<input id="dictItemId" type="hidden" value=""> <input
							id="dictItemVal" type="text" data-options="reigon:'north'">
						<select id="dictItemOpt" data-options="reigon:'center'"
							multiple="multiple" fit="true" style="height: 150px;">
							<option>请选择</option>
						</select>
					</div>
				</div>
				<div id="dsUrl" class="ds-info">
					<form class="form-horizontal" id="dsUrlForm">
						<table width="100%">
							<tr>
								<td>关联表单：</td>
								<td><select name="dsValue"></select></td>
							</tr>
							<tr>
								<td>字段值：</td>
								<td><select name="dsUrlId"></select></td>
							</tr>
							<tr>
								<td>字段描述：</td>
								<td><select name="dsUrlText"></select></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="ds-buttons">
		<a class="easyui-linkbutton" iconCls="icon-ok" onclick="saveDs();">保
			存</a> <a class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#dsd').dialog('close')">关 闭</a>
	</div>
	<!-- 系统配置 -->
	<div id="settingd" style="padding: 1px;"></div>
	<!-- 导入字段选择 -->
	<div id="impd" class="easyui-dialog" title="公共字段"
		style="width: 400px; height: 300px; padding: 1px;" closed="true"
		modal="true" buttons="#imp-buttons">
		<div class="easyui-layout" data-options="fit:true">
			<table id="commFieldGrid" class="easyui-datagrid" fit="true"
				rownumbers="true" url="dfcode/impRecords.zb">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th
							data-options="field:'type',width:100,align:'center',formatter: function(value, rowData, rowIndex){
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
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="imp-buttons">
		<a class="easyui-linkbutton" iconCls="icon-ok" onclick="saveImp();">保
			存</a> <a class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#impd').dialog('close')">关 闭</a>
	</div>
	<div region="north"
		style="padding: 5px; margin: 1px; height: 35px; overflow: hidden;">
		<!--div class="navbar">
		  <div class="navbar-inner">
			    <a class="brand" href="#">自定义表单</a>
			    <ul class="nav">
				      <li class="active"><a href="#">表单管理</a></li>
				      <li><a href="#">表单发布</a></li>
				      <li><a href="#">帮助</a></li>
			    </ul>
		  </div>
	</div-->
		<a id="addForm" href="javascript:void(0)"
			onclick="javascript:addForm();" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'">新 建</a> <a id="saveForm"
			href="javascript:void(0)" onclick="javascript:saveForm();"
			class="easyui-linkbutton" data-options="iconCls:'icon-save'">保 存</a>
		<a id="loadForm" href="javascript:void(0)"
			onclick="javascript:loadForm();" class="easyui-linkbutton"
			data-options="iconCls:'icon-load'">载 入</a> <a id="copyForm"
			href="javascript:void(0)" onclick="javascript:copyForm();"
			class="easyui-linkbutton" data-options="iconCls:'icon-copy'">复 制</a>
		<a id="delForm" href="javascript:void(0)"
			onclick="javascript:delForm();" class="easyui-linkbutton"
			data-options="iconCls:'icon-delete'">删 除</a> <a id="publishForm"
			href="javascript:void(0)" onclick="javascript:publishForm();"
			class="easyui-linkbutton" data-options="iconCls:'icon-save'">发 布</a>
		<a id="unPublishForm" href="javascript:void(0)"
			onclick="javascript:unPublishForm();" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'">取消发布</a> <a id="settingForm"
			href="javascript:void(0)" onclick="javascript:settingForm();"
			class="easyui-linkbutton" data-options="iconCls:'icon-update'">系统设置</a>
		<a id="helpForm" href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-help'"
			onclick="$('#helpdlg').dialog('open');">帮 助</a> <a id="updateForm"
			href="javascript:void(0)" onclick="javascript:updateForm();"
			class="easyui-linkbutton" data-options="iconCls:'icon-update'">系统更新</a>
		<a id="helpForm" href="mailto:wangjj@zebone.cn"
			class="easyui-linkbutton" data-options="iconCls:'icon-email'">联系我们</a>
		<!--p class="text-error contact-us">如果对自定义表单系统有任何疑问、意见或建议，请点击<strong>帮助</strong>按钮或联系<a href="mailto:wangjj@zebone.cn">开发人员</a>。</p-->
	</div>
	<div style="padding: 5px; width: 150px;"
		data-options="region:'west',split:true" title="表单列表">
		<ul id="formTree" class="easyui-tree"
			data-options="url:'dfcode/tree.zb'"></ul>
	</div>
	<div region="center" style="padding: 5px; margin: 1px;">
		<div id="tt" class="easyui-tabs" fit="true" tools="#moduleTools">
			<div title="表单信息" style="padding: 1px;">
				<div class="easyui-layout" fit="true">
					<div region="center" title="基本属性" style="padding: 1px;">
						<div class="easyui-layout" fit="true">
							<div region="center" style="margin: 1px; padding: 5px;"
								border="true" fit="true">
								<form id="formInfo">
									<input type="hidden" name="id" value="">
									<table width="100%">
										<tr>
											<td width="50%"><div class="control-group">
													<label class="control-label" for="code">编码</label>
													<div class="controls">
														<input type="text" class="easyui-validatebox" name="no"
															placeholder="请输入表单编码">
													</div>
												</div></td>
											<td><div class="control-group">
													<label class="control-label" for="name">名称</label>
													<div class="controls">
														<input type="text" class="easyui-validatebox" name="name"
															placeholder="请输入表单名称">
													</div>
												</div></td>
										</tr>
										<tr>
											<td><div class="control-group">
													<label class="control-label" for="code">表名</label>
													<div class="controls">
														<input type="text" class="easyui-validatebox" name="table"
															placeholder="请输入表单对应表名">
													</div>
												</div></td>
											<td><div class="control-group">
													<label class="control-label" for="code">界面风格</label>
													<div class="controls">
														<select name="tempType">
															<option value="grid" selected="selected">标准</option>
															<option value="grid_query_simple">查询（简单）</option>
															<option value="grid_query_standard">查询（标准）</option>
														</select>
													</div>
												</div></td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="control-group" style="width: 100%;">
													<label class="control-label" for="code">说明</label>
													<div class="controls">
														<textarea name="remark" style="width: 90%;"
															class="easyui-validatebox"></textarea>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="control-group" style="width: 100%;">
													<label class="control-label" for="code">功能设置</label>
													<div class="controls">
														<label class="checkbox inline"> <input
															type="checkbox" name="actionAdd" value="1"
															disabled="disabled" checked> 新建
														</label> <label class="checkbox inline"> <input
															type="checkbox" name="actionUpdate" value="1"
															disabled="disabled" checked> 修改
														</label> <label class="checkbox inline"> <input
															type="checkbox" name="actionDel" value="1"
															disabled="disabled" checked> 删除
														</label> <label class="checkbox inline"> <input
															type="checkbox" name="actionImp" value="1"> 导入
														</label> <label class="checkbox inline"> <input
															type="checkbox" name="actionExp" value="1"> 导出
														</label>
													</div>
												</div>
											</td>
										</tr>
									</table>
								</form>
							</div>
							<div id="moduleTools" style="margin: auto; padding: 3px;">
								请选择所属模块：<select class="easyui-combotree" id="moduleId"
									name="moduleId"
									data-options="url:'dfcode/moduletree.zb',cascadeCheck:false"></select>
							</div>
							<div region="east" style="width: 300px;" title="版本信息"
								style="margin:1px;">
								<div style="padding-left: 10px;">
									<h5 class="text-success">
										<span class="badge badge-success">2014-04-18</span>
										&nbsp;&nbsp;自定义表单v1.3正式发布 &nbsp;&nbsp;
									</h5>
									<hr />
									<ul>
										<li>表单新增导入、导出功能</li>
										<li>表单功能实现动态设置</li>
										<li>修正了其他一些小BUG</li>
									</ul>
								</div>
								<br />
								<div style="padding-left: 10px;">
									<h5 class="text-success">
										<span class="badge badge-success">2014-04-11</span>
										&nbsp;&nbsp;自定义表单v1.2正式发布 &nbsp;&nbsp;
									</h5>
									<hr />
									<ul>
										<li>新增日期、时间、文件上传框</li>
										<li>增加了新的数据源模式 - 表单关联</li>
										<li>大幅优化了表单列表查询性能</li>
										<li>提供了系统更新，减少发布工作量</li>
										<li>修正了其他一些小BUG</li>
									</ul>
								</div>
								<br />
								<div style="padding-left: 10px;">
									<h5 class="text-success">
										<span class="badge badge-success">2014-03-28</span>
										&nbsp;&nbsp;自定义表单v1.1正式发布 &nbsp;&nbsp;
									</h5>
									<hr />
									<ul>
										<li>新增了载入表单、复制表单功能</li>
										<li>增加了取消发布功能，自动进行数据备份</li>
										<li>增强了表单编码、表校验和字段重复性校验</li>
										<li>修正了其他一些小BUG</li>
									</ul>
								</div>
								<br />
								<div style="padding-left: 10px;">
									<h5 class="text-success">
										<span class="badge badge-success">2014-03-21</span>
										&nbsp;&nbsp;自定义表单v1.0正式发布 &nbsp;&nbsp;
									</h5>
									<hr />
									<ul>
										<li>支持text、select、textarea等8种控件</li>
										<li>支持长度、空值、密码等校验</li>
										<li>支持select、radio等数据源定义</li>
										<li>与BTP4.0完美结合</li>
										<li>支持查询模式，支持三种界面风格</li>
										<li>完整的使用说明和帮助文档</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div title="字段信息" style="overflow: auto; padding: 1px;">
				<table id="formGrid" class="easyui-datagrid" fit="true"
					toolbar="#search" singleSelect="true" rownumbers="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true" rowspan="2"></th>
							<th colspan="8">基本属性</th>
							<th colspan="5">数据库表属性</th>
							<th colspan="3">字段校验属性</th>
							<th colspan="3">列表属性</th>
						</tr>
						<tr>
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
								data-options="field:'primary',width:60,align:'center',editor: {
		                	type:'checkbox',
		                	options: {  
		                        on: 1,  
		                        off: 0  
		                    }
		                },formatter: function(value, rowData, rowIndex){
		                	return value=='1'?'√':'×';
		                }">主键</th>
							<th
								data-options="field:'unique',width:60,align:'center', editor: {
		                	type:'checkbox',
		                	options: {  
		                        on: 1,  
		                        off: 0  
		                    }
		                },formatter: function(value, rowData, rowIndex){
		                	return value=='1'?'√':'×';
		                }">唯一性</th>
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
								data-options="field:'defaultValue',width:80,align:'center',editor: 'validatebox'">默认值</th>
							<th
								data-options="field:'dictId', width: 60, align: 'center', formatter: function(value, rowData, rowIndex){
		            	return '<a href=\'
								javascript:showDsd('+rowIndex+');\' class=\ 'btnbtn-mini\'>定义</a>';
								}">数据源
							</th>
							<th data-options="field:'dsType',width:0,hidden:true">数据源类型</th>
							<th data-options="field:'dsValue',width:0,hidden:true">数据源</th>
							<th data-options="field:'dsUrlId',width:0,hidden:true">URL值</th>
							<th data-options="field:'dsUrlText',width:0,hidden:true">URL描述</th>
							<th
								data-options="field:'dbId',width:100,align:'center',editor: 'validatebox'">字段名</th>
							<th
								data-options="field:'dbLength',width:80,align:'center',editor: 'numberbox'">字段长度</th>
							<th
								data-options="field:'allowValue',width:80,align:'center',editor: 'validatebox'">默认值</th>
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
								data-options="field:'fieldEquals',width:80,align:'center',editor: 'validatebox'">字段验证</th>
							<th
								data-options="field:'minLen',width:80,align:'center',editor: 'numberbox'">最小长度</th>
							<th
								data-options="field:'maxLen',width:80,align:'center',editor: 'numberbox'">最大长度</th>
							<th
								data-options="field:'gridQuery',width:60,align:'center',editor: {
	                	type:'checkbox',
	                	options: {  
	                        on: 1,  
	                        off: 0  
	                    }
	                },formatter: function(value, rowData, rowIndex){
	                	return value=='1'?'√':'×';
	                }">支持查询</th>
							<th
								data-options="field:'gridHide',width:60,align:'center',editor: {
	                	type:'checkbox',
	                	options: {  
	                        on: 1,  
	                        off: 0  
	                    }
	                },formatter: function(value, rowData, rowIndex){
	                	return value=='1'?'√':'×';
	                }">是否隐藏</th>
							<th
								data-options="field:'gridWidth',width:80,align:'center',editor: 'numberbox'">列表宽度</th>
						</tr>
					</thead>
				</table>
				<div id="search" style="margin: auto;">
					<a href="javascript:addRecord('formGrid');"
						class="easyui-linkbutton" iconCls="icon-add" plain="true">新建字段</a>
					<a href="javascript:removeRecord(1);" class="easyui-linkbutton"
						iconCls="icon-remove" plain="true">删除字段</a> <a
						href="javascript:impRecord(1);" class="easyui-linkbutton"
						iconCls="icon-remove" plain="true">导入公共字段</a>
				</div>
			</div>
			<div id="formView" title="表单预览" fit="true">
				<div class="easyui-layout" fit="true" style="padding: 1px;">
					<div region="north" style="margin: 1px;">
						<form class="form-search">
							<div class="input-prepend" style="width: 95%;">
								<span class="add-on"><i class="icon-star"></i></span> <input
									type="text" class="span2" style="width: 97%;" id="urlAddress"
									name="urlAddress">
							</div>
							<div class="input-append">
								<button class="btn btn-url" type="button">Go!</button>
							</div>
						</form>
					</div>
					<div region="center" style="margin: 1px; overflow: hidden;">
						<iframe src="" frameborder="0" width="100%" height="100%">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>