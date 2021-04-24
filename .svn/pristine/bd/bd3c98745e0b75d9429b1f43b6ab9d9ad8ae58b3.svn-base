<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
var addjzOrg,deletejzOrg;
var temp_org,clickOrgId = "";

function CurentTime(){ 
    var now = new Date();
    var year = now.getFullYear();       //年
    var month = now.getMonth() + 1;     //月
    var day = now.getDate();            //日
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day;
    return(clock); 
} 
/**
 * 扩展校验框架，登录名唯一校验。
 */
$.extend($.fn.validatebox.defaults.rules, {
	checkLoginName : {
		validator : function(value, param) {
			//有id值，表示目前是修改操作。如果输入框中的字典编码没有修改，校验通过
			if ($("input[name=id]").val()) {
				var oldLoginName = $("#oldLoginName").val();
				if (value == oldLoginName) {
					return true;
				}
			}
			var resp = $.ajax({
				url : "user/isLoginNameExist.zb",
				dataType : "json",
				data : {
					loginName : value
				},
				async : false,
				cache : false,
				type : "post"
			}).responseText;
			return resp != "true";
		},
		message : "登录名已经存在"
	}
});







/**
 * 添加兼职机构
 */
addjzOrg = function(){
	var temp = temp_org.clone(true);
	var table=$("#jzjg");
	table.append(temp);
	var orgInput=table.find('tr:last').find('input:eq(0)');
	var roleInput=table.find('tr:last').find('input:eq(1)');
	orgInput.combotree({  
        url:'organ/getUserOrganTree.zb?orgType=1',
		required:true,
		idFiled: 'id',
		width:130,
		customAttr: {
			dataModel: 'simpleData',
			textField: 'text',
			parentField: 'parentId'
        },
		onLoadSuccess:function(){
	    	var tree=orgInput.combotree('tree');
	    	tree.tree('collapseAll');
	    	var node=tree.tree('getRoot');
	    	tree.tree('expand',node.target);
	    },
    });  
    roleInput.combotree({
    	url: 'role/getRoleTree.zb?organId=${organId}',
		customAttr:{
            dataModel: 'simpleData',
            textField: 'text',
            parentField: 'parentId'
    	},
    	idFiled: 'id',
		width:150,
		editable:false,
		multiple:true,
		onLoadSuccess:formatTree,
		cascadeCheck:false,
		onBeforeCheck:function(node, checked){
			return node.isLeaf=='1';
		}
    });
};
/**
 * 删除兼职机构
 */
deletejzOrg = function(obj){
$(obj).parent().parent().remove();
}


/**
 * javaScript去除字符串中间空格
 */
function ignoreSpaces(string) {
    var temp = "";
    string = '' + string;
    splitstring = string.split(" "); //双引号之间是个空格；
    for (i = 0; i < splitstring.length; i++)
        temp += splitstring[i];
    return temp;
};
/*日期比较*/
function checkDate(startTime,endTime){
   var aStart=startTime.split('-'); //转成成数组，分别为年，月，日，下同
   var aEnd=endTime.split('-');
   var startDate = aStart[0]+"/" + aStart[1]+ "/" + aStart[2];
   var endDate = aEnd[0] + "/" + aEnd[1] + "/" + aEnd[2];
   if (startDate > endDate) {
    return false;
   }
   return true;
}

/**
 * 保存用户信息
 */
function saveUser(opt){
	//$("input[name=loginName]").val(ignoreSpaces($("input[name=loginName]").val()));
	//$("input[name=fullname]").val(ignoreSpaces($("input[name=fullname]").val()));
// 	if($("input[name=loginName]").val().indexOf(" ")>-1){
// 		$.messager.alert("提示","登录账号中不能存在空格!","info");	
// 		return;
// 	}
	//if(!(/^[\u0391-\uFFE5\w]+$/.test($("input[name=loginName]").val()))){
	//	$.messager.alert("提示","登录账号只允许汉字、英文字母、数字及下划线!","info");	
	//	return;
	//}
	$("input[name=ip]").val(ignoreSpaces($("input[name=ip]").val()));
	var startTime =$("input[name=birthday]").val();
	if (startTime!=''){
		if (!checkDate(startTime,CurentTime())){
			$.messager.alert("提示","出生日期不能大于当前时间!","info");	
			return;
		}
	}
	
	//兼职机构重复判断
	var checkjzjg = "";
	var ssjgFlag= 0 ;
	$('.temp_org').each(function(){
		var jzjg = $(this).find("input[name=jzOrg]").val();
		var ssjg = $("input[name=organId]").val();
		if(jzjg&&ssjg&&jzjg==ssjg){
			ssjgFlag++;
		}
		checkjzjg +=jzjg+",";
 	});
 	if(ssjgFlag!=0){
 		$.messager.alert("提示","兼职机构不能和所属机构相同","info");
			return;
 	}
 	if(checkjzjg.length>1){
 		checkjzjg = checkjzjg.substring(0,checkjzjg.length-1);
 		var ary = checkjzjg.split(",");
 		var flag = 0;
		for(var i=0;i<ary.length;i++) {  
			 for(var j=i+1;j<ary.length;j++) {  
				 if(ary[i]==ary[j]){
				 	flag ++;
				 	break;
				 }
			 }
		}
		if(flag !=0){
			$.messager.alert("提示","兼职机构不能相同","info");
			return;
		}
 	}
 	
	var jzInfos = "";
	$('.temp_org').each(function(){
		var jzInfo = "";
		//机构
		jzInfo+=$(this).find("input[name=jzOrg]").val()+"~";
		//角色
		var roles = "";
		$(this).find("input[name=jzRole]").each(function(){
			roles+=$(this).val()+",";
		});
		if(roles.length>0){
			roles = roles.substring(0,roles.length-1);
		}
		jzInfo+=roles+"~";
		//职位
		jzInfo+=$(this).find("input[name=jzzw]").val().trim()+"~";
		//是否领导
		if($(this).find("input[name=isleader]").attr("checked")){
			jzInfo+="true";
		}else{
			jzInfo+="false";
		}
		jzInfos+=jzInfo+"`";
	});
	if(jzInfos.length>0){
		jzInfos = jzInfos.substring(0,jzInfos.length-1);
	}
	//return;
	var url;
	var opt = $("#opt").val();
	if(optStatus=="edit"){
		url = "user/update.zb?jzjgs="+jzInfos;
	}else{
		url = "user/save.zb?jzjgs="+jzInfos;
	}
	var $form = $("#form");
	var $dialog = $("#dlg");
	$form.form("submit",{
		url: url,
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
				$("#dg").datagrid("reload");
				$dialog.dialog("close");
				$.noty.closeAll();
				var n = noty({text: "操作成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误","操作失败","error");
			}
		}
	});
}


//获取行号
function getRowIndex(target){
	var index = $(target).closest('tr.datagrid-row').find('td:first').find('input').val();
	return index;
}
var optStatus;
/**
 * 弹出新增窗口
 */
function openAddDialog(){
	optStatus = "insert";
	$('.temp_org').remove();
	$('input[name=loginName]').attr('readOnly',false);
	$('#dlg').dialog({title:'新增',iconCls:'icon-add'});
	$('#opt').val('insert');
	$('#userId_').val('');
	$('#dlg').dialog('open');
	$('#form').form('reset');
	if(clickOrgId){
		$('#org').combotree("setValue",clickOrgId);
		
	}
}

/**
 * 弹出编辑窗口，并加载要编辑的数据
 */
function openEditDialog(id,index){
	if(index){
		$('#dg').datagrid("selectRow",index);
	}
	optStatus = "edit";
	$(".temp_org").remove();
	$("input[name=loginName]").attr("readOnly",true);
	$('#opt').val("edit");
	$("#dlg").dialog({
		title:"修改",
		iconCls:"icon-edit"
	});
	$('#dlg').dialog('open');//弹出对话框
	$('#form').form('reset');//清空表单数据
	$("#userId_").val("");
	$.post("user/getUserById.zb",{userId:id},function(data){
		if(data.success){
			$("#form").form("load",data.extData.user);
			$("#oldLoginName").val(data.extData.user.loginName); 
			var roleIds = data.extData.roleType;
			if(roleIds){
				var arrayObj = roleIds.split(',');
				$("#roles").combotree('setValues', arrayObj);
			}
			var jzjgs = data.extData.list;
			for(var i = 0 ;i<jzjgs.length;i++){
				//-------------------------------------------------------/
				var temp = temp_org.clone(true);
				var table=$("#jzjg");
				table.append(temp);
				var orgInput=table.find('tr:last').find('input:eq(0)');
				var roleInput=table.find('tr:last').find('input:eq(1)');
				var zwInput=table.find('tr:last').find('input:eq(2)');
				var leaderleInput=table.find('tr:last').find('input:eq(3)');
				orgInput.combotree({  
			        url:'organ/getUserOrganTree.zb?orgType=1',
					required:true,
					idFiled: 'id',
					width:130,
					customAttr: {
						dataModel: 'simpleData',
						textField: 'text',
						parentField: 'parentId'
			        }
			    }); 
			    orgInput.combotree("setValue",jzjgs[i].organId);
			    roleInput.combotree({
			    	url: 'role/getRoleTree.zb?organId=${organId}',
					customAttr:{
			            dataModel: 'simpleData',
			            textField: 'text',
			            parentField: 'parentId'
			    	},
			    	idFiled: 'id',
					width:150,
					editable:false,
					multiple:true,
					onLoadSuccess:formatTree,
					cascadeCheck:false,
					onBeforeCheck:function(node, checked){
						return node.isLeaf=='1';
					}
			    });
			    if(jzjgs[i].jzRoles){
					var roles = jzjgs[i].jzRoles.split(",");
					roleInput.combotree('setValues',roles);
				}
				zwInput.val(jzjgs[i].position);
				if(jzjgs[i].isleader=='1'){
					leaderleInput.attr("checked",true);
				}else{
					leaderleInput.attr("checked",false);
				}
				//-------------------------------------------------------/
			}
		}else{
			$.messager.alert("错误","加载时出现系统错误!","error");			
		}
	},"json");
	
}


/**
 * 删除一行数据
 */
function deleteRow(id,index){
	if(index){
		$('#dg').datagrid("selectRow",index);
	}
	$.messager.confirm("提示", "您确认要删除吗?", function(r){
		if (!r){
			return;
		}
		$.messager.progress({
			title:"提示",
			text:"数据处理中，请稍后...."
		});
		$.post("user/delete.zb",{userId:id},function(data){
			if(data.success){
				var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("错误","删除数据时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	});
}

/**
 * 批量删除数据
 */
function deleteRows(){
	var ids = [];
    var indexs = [];
	var rows = $('#dg').datagrid('getSelections');
    if(rows.length==0){
    	noty({text: "请选择数据进行删除!",type:"warning",layout:"topCenter",timeout:1500});
    	return;
    }
    //获取datagrid选中行
    for (var i = 0; i < rows.length; i++) {
         //获取自定义table 的中的checkbox值
         ids.push(rows[i].id);
         var index = $("#dg").datagrid("getRowIndex",rows[i]);
         indexs.push(index);
    }
    //执行删除
    $.messager.confirm('提示','确认删除所选信息吗?',function(r){
	    if (r){
	    	$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
	        $.ajax({
				url: 'user/delete.zb',
				type: 'post',
				data: "userId="+ids.join(','),
				dataType:"json",
				success:  function(data){
					if(data.success){
						var n = noty({text: "操作成功!",type:"success",layout:"topCenter",timeout:1500});
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("错误","删除数据时出现系统错误!","error");
					}
					$.messager.progress("close")
				}
			});
	    }
	});
}

/**
密码初始化
*/
var initpsw = function(){
	var ids = [];
	var rows = $('#dg').datagrid('getSelections');
    if(rows.length==0){
    	noty({text: "请选择用户进行密码初始化!",type:"warning",layout:"topCenter",timeout:1500});
    	return;
    }
    //获取datagrid选中行
    for (var i = 0; i < rows.length; i++) {
         //获取自定义table 的中的checkbox值
         ids.push(rows[i].id);
    }
    //执行删除
    $.messager.confirm('提示','您确定要初始化所选用户的密码吗?',function(r){
	    if (r){
	    	$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});
	        $.ajax({
				url: 'user/initpsw.zb',
				type: 'post',
				data: "userId="+ids.join(','),
				dataType:"json",
				success:  function(data){
					if(data.success){
						var n = noty({text: "密码初始化成功!",type:"success",layout:"topCenter",timeout:1500});
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("错误","删除数据时出现系统错误!","error");
					}
					$.messager.progress("close")
				}
			});
	    }
	});
}
 
var formatter=function(value,row,index){
	var p = "'"+row.id+"','"+index+"'";
    var s =  " <a class=\"icon-edit2\" href=\"javascript:void(0);\" title=\"编辑\" onclick=\"openEditDialog("+p+")\"></a>";
    s+=" <a class=\"icon-del2\" href=\"javascript:void(0);\" title=\"删除\" onclick=\"deleteRow("+p+")\"></a>";
    return s;
}

function enableFmt(val,row){
	switch (val) {
	case "1":
		return "启用";
	case "0":
		return "停用";	
	default:
		return "未知";
	}
}

//搜索
var searchGrid=function(){
	$('#dg').datagrid('load', {
	    name: $('#name').val()
	});
}
$(function(){

	/*设置dialog显示事件:
		1,清空表单数据.
		2,使第一个校验错误的文本获取焦点,实现关闭dialog的时候隐藏错误信息
		3,dialog关闭时不需清空表单,否则错误信息会重新显示
	*/
	$("#dlg").dialog({
		onOpen:function(){
			$(this).dialog('body').find('form').form('reset');//清空表单数据
			$(this).dialog('body').find('.validatebox-invalid:first').focus();
		}
	});
	
	//全局变量，用于兼职机构添加
	temp_org = $("#temp").find("tr");
	//用户查询grid初始化
	$("#dg").datagrid({
	    //url:"user/findUserByOranAndName.zb",
	    idField: "id",
	    pagination:true,
		pageSize:20,
		toolbar: "#tb",
		height:$(this).height(),
		rownumbers : true,//行数
	    fit:true,
		columns:[[
	    	{halign:"center",field:"id",title:"ID",checkbox:true},
	    	{halign:"left",field:"loginName",title:"登录账号",width:100},
	        {halign:"left",field:"fullname",title:"姓名",width:100},
	        {halign:"left",field:"sex",title:"性别",width:100,formatter:function(value,rowData, rowIndex){
				if(value==1) return "男";
				else if(value==0) return "女";
				else return value;
			}},
	        {halign:"left",field:"birthday",title:"出生日期",width:100},
	        {halign:"left",field:"position",title:"职务",width:100},
	        {halign:"left",field:"tel",title:"电话",width:100},
	        {halign:"left",field:"mobile",title:"手机",width:100},
	        {halign:"left",field:"email",title:"email",width:100},
	        {halign:"left",field:"enable",title:"是否停用",width:100,align:"left",formatter:enableFmt},
	        {halign:"left",field:"iditem",title:"操作",width:80,checkbox:false,formatter:formatter,align:"center"},
	    ]]
	});
});

/**
 * 根据组织机构ID，得到下面的的用户
 */
function loadUserByOrganId(node){
	var param = {};
	if(node.id != "0"){
		param.organId = node.id;
	}
	$("#dg").datagrid("clearChecked");
	$("#dg").datagrid({url:"user/findUserByOranAndName.zb",queryParams:param});
	clickOrgId = node.id;
}


function doSearch(){
	var treeNode = $("#tt").tree("getSelected");
	var param = {};
	if(treeNode){
		param.organId = treeNode.id;
	}
	var username = $("#name").val();
	var tel = $("#tel").val();
	param.name = username;
	param.mobile = tel;
	$("#dg").datagrid("clearChecked");
	$("#dg").datagrid("load",param);
}

function onOrganLoadSuccess(){
	$("#tt").tree('collapseAll');
	var node=$("#tt").tree('getRoot');
	$("#tt").tree('expand',node.target);
}

//格式化角色树
function formatTree(node, data){
	var t=$(this);
	for(var i=0;i<data.length;i++){
		formatNode(data[i],t);
	}
}
function formatNode(nodeData,t){
	var iconCls="";
	if(nodeData.isLeaf=='1'){
		iconCls="roleNode";
	}else{
		iconCls="organNode";
	}
	//var t=$('#roles').combotree('tree');
	var node=t.tree('find',nodeData.id);
	t.tree('update', {
		target: node.target,
		iconCls:iconCls
	});
	var childs=nodeData.children;
	if(childs){
		for(var i=0;i<childs.length;i++){
			formatNode(childs[i],t);
		}
	}
}
</script>
<style type="text/css">
.icon-edit2 {
	background: url("images/icons/pencil.png") no-repeat center;
	width: 20px;
	height: 20px;
	display: block;
	float: left;
	margin: 0px 5px 0px 5px;
	cursor: pointer;
}

.icon-del2 {
	background: url("images/icons/delete.gif") no-repeat center;
	width: 20px;
	height: 20px;
	display: block;
	float: left;
	margin: 0px 5px 0px 0px;
	cursor: pointer;
}
</style>
</head>
<body class="easyui-layout" data-options="fit:true">
	<!--left-->
	<div
		data-options="region:'west',border:false,title:'组织机构',collapsible:false"
		style="width: 215px;">
		<!-- 组织机构树 -->
		<ul id="tt" class="easyui-tree"
			data-options="
			url: 'organ/getUserOrganTree.zb?orgType=1',
			customAttr: {
				dataModel: 'simpleData',
				textField: 'text',
				parentField: 'parentId',
				attributes: ['parentId'],
	        },
			idFiled: 'id',
			onClick: loadUserByOrganId,
			onLoadSuccess:onOrganLoadSuccess
		"></ul>
	</div>
	<!--right-->
	<div data-options="region:'center',title:'用户列表'">
		<!-- 按钮栏 -->
		<div id="tb" style="height: auto">
			<div style="margin-left: 8px">
				姓名：<input type="text" id="name" name="name"
					style="margin-right: 10px" /> 手机：<input type="text" id="tel"
					name="mobile" /> <a onclick="doSearch()" class="easyui-linkbutton"
					data-options="
						iconCls:'icon-search',
						plain:true
					">查询</a>
			</div>
			<a class="easyui-linkbutton" onclick="openAddDialog()"
				data-options="
			iconCls:'icon-add',
			plain:true
		">新增</a> <a
				class="easyui-linkbutton" onclick="deleteRows()"
				data-options="
			iconCls:'icon-del',
			plain:true
		">删除</a> <a
				class="easyui-linkbutton" onclick="initpsw()"
				data-options="
			iconCls:'icon-lock',
			plain:true
		">密码初始化</a>
		</div>
		<!-- 数据表格 -->
		<table id="dg"></table>

		<!-- ------------------------------------------------------------------------- -->
		<!-- 弹出窗口 -->
		<div style="display: none;">
			<div id="dlg" class="easyui-dialog" style="padding-top: 10px"
				data-options="
			title:'新增',
			width: 580,
	    	height: 400,
	    	closed: true,
	    	cache: false,
	    	modal: true,
	    	buttons: '#dlgbtn',
	    	onClose: function () {
                //解决弹出窗口关闭后，验证消息还显示在最上面
                setTimeout(function(){
                	$('.validatebox-tip').remove();
                },500);
            }
		">
				<form id="form" action="" method="post">
					<input id="opt" type="hidden"> <input name="id"
						type="hidden" id="userId_" /> <input id="oldLoginName"
						type="hidden" />
					<table style="margin: 0 auto;">
						<tr>
							<td>姓名：</td>
							<td><input type="text" name="fullname"
								data-options="required:true,validType:['length[0,30]','commonChar']"
								class="easyui-validatebox" /></td>
							<td>性别：</td>
							<td><input type="radio" name="sex" value="1" checked />男 <input
								type="radio" name="sex" value="0" />女</td>
						</tr>
						<tr>
							<td>登录账号：</td>
							<td><input type="text" name="loginName"
								data-options="required:true,validType:['length[3,30]','checkLoginName']"
								class="easyui-validatebox" /></td>
							<td>是否启用：</td>
							<td><input type="radio" name="enable" value="1"
								checked="checked" />是 <input type="radio" name="enable"
								value="0" />否</td>
						</tr>
						<tr>
							<td>机器IP：</td>
							<td><input type="text" name="ip"
								data-options="validType:'length[0,15]'"
								class="easyui-validatebox" /></td>
							<td>是否领导：</td>
							<td><input type="radio" name="leader" value="1" />是 <input
								type="radio" name="leader" value="0" checked="checked" />否</td>
						</tr>
						<tr>
							<td>失效日期：</td>
							<td><input type="text" name="expirationDatetime"
								class="easyui-validatebox easyui-datebox"
								data-options="validType:'checkDate',width:149" /></td>
							<td>是否保密：</td>
							<td><input type="radio" name="secret" value="1" />是 <input
								type="radio" name="secret" value="0" checked="checked" />否</td>
						</tr>
						<tr>
							<td>email：</td>
							<td><input type="text" name="email"
								class="easyui-validatebox"
								data-options="
							validType:'email'
						" /></td>
							<td>出生日期：</td>
							<td><input type="text" name="birthday"
								class="easyui-validatebox easyui-datebox"
								data-options="validType:'checkDate',width:149" /></td>
						</tr>
						<tr>
							<td>电话：</td>
							<td><input type="text" name="tel" class="easyui-validatebox"
								data-options="
							validType:'checkPhone'
						" /></td>
							<td>手机：</td>
							<td><input type="text" name="mobile"
								class="easyui-validatebox"
								data-options="
							validType:['positiveInt','fixLength[11]']
						" />
							</td>
						</tr>
						<tr>
							<td>职务：</td>
							<td><input type="text" name="position"
								class="easyui-validatebox" /></td>
							<td>岗位：</td>
							<td><input type="text" name="post"
								class="easyui-validatebox" /></td>
						</tr>
						<tr>

							<td>所属机构：</td>
							<td><input id="org" class="easyui-combotree" name="organId"
								style="width: 130px;"
								data-options="
							url:'organ/getUserOrganTree.zb?orgType=1',
							required:true,
							customAttr: {
								dataModel: 'simpleData',
								textField: 'text',
								parentField: 'parentId'
					        },
					        onLoadSuccess:function(){
						    	var tree=$('#org').combotree('tree');
						    	tree.tree('collapseAll');
						    	var node=tree.tree('getRoot');
						    	tree.tree('expand',node.target);
						    },
					        idFiled: 'id'
					       
							
						">
							</td>
							<td>所属角色：</td>
							<td><input name="roleType" id="roles"
								class="easyui-combotree"
								data-options="
								url: 'role/getRoleTree.zb?organId=${organId}',
								customAttr:{
						            dataModel: 'simpleData',
						            textField: 'text',
						            parentField: 'parentId'
					        	},
					        	idFiled: 'id',
								width:150,
								editable:false,
								multiple:true,
								onLoadSuccess:formatTree,
								cascadeCheck:false,
								onBeforeCheck:function(node, checked){
									return node.isLeaf=='1';
								}
								
							" />
							</td>
						</tr>
						<tr>
							<td>备注：</td>
							<td colspan="3"><textarea name="remark"
									class="easyui-validatebox" style="width: 332px; height: 70px"
									data-options="
							validType:'length[0,200]'
						"></textarea>
							</td>
						</tr>
					</table>
					<!-- 兼职机构数据表格 -->
					<div id="tb2"
						style="height: auto; wigth: 420px; padding-left: 20px; margin-bottom: 20px;">
						<div style="margin-top: 20px; margin-left: 12px;">
							兼职机构 <a class="easyui-linkbutton" onclick="addjzOrg()"
								data-options="
					iconCls:'icon-add',
					plain:true
				">添加</a>
						</div>
						<div style="color: #95B8E7">---------------------------------------------------------------------------------------------------</div>
						<table id="jzjg" align="center" style="margin-left: 10px">
							<tr>
								<td width="130">兼职机构</td>
								<td width="130">所属角色</td>
								<td width="130">职务</td>
								<td width="70">是否领导</td>
								<td>操作</td>
							</tr>
						</table>
					</div>
				</form>
				<div id="dlgbtn">
					<a class="easyui-linkbutton" onclick="saveUser()"
						data-options="iconCls:'icon-ok'">确定</a> <a
						class="easyui-linkbutton" onclick="$('#dlg').dialog('close');"
						data-options="iconCls:'icon-cancel'">取消</a>
				</div>
			</div>
		</div>
		<div style="display: none;">
			<table id="temp">
				<tr class="temp_org">
					<td><input type="text" name="jzOrg" /></td>
					<td><input type="text" name="jzRole" /></td>
					<td><input type="text" name="jzzw" /></td>
					<td><input type="checkbox" name="isleader"
						style="margin-left: 20px" /></td>
					<td><a title="删除" class="easyui-linkbutton"
						onClick="deletejzOrg(this)"
						data-options="
					iconCls:'icon-del',
					plain:true
				"></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
