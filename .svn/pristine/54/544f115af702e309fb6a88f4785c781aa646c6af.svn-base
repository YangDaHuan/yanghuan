var addRecord,editIndex,removeRecord, loadStart,updateVer,impRecord,saveImp;
var saveForm, showDsd, saveDs, publishForm, delForm, addForm, loadForm, unPublishForm, copyForm, updateForm, settingForm;
var curDsIndex = 0, initDictTree, initFormInfo;
var initDictTreeState = false;
var loadDictItem;
var loadRelForm;
var fieldTypeData = [
 	{id:'text',text:'文本框'},
	{id:'select',text:'选择框'},
	{id:'hidden',text:'隐藏框'},
	{id:'password',text:'密码框'},
	{id:'radio',text:'单项选择框'},
	{id:'checkbox',text:'多项选择框'},
	{id:'textarea',text:'文本区'},
	{id:'date',text:'日期组合框'},
	{id:'datetime',text:'时间组合框'},
	{id:'email', text: '电子邮件框'},
	{id:'fileUpload', text: '文件上传框'}
];
$(document.body).ready(function(){
	addRecord = function(grid, fields){
		endEdit(grid);
		$('#'+grid).datagrid('appendRow',fields?fields:{
			allowAdd : 1,
			allowUpdate : 1
		});
		editIndex = $('#'+grid).datagrid('getRows').length-1;
        $('#'+grid).datagrid('selectRow', editIndex)
                .datagrid('beginEdit', editIndex);
	};
	removeRecord = function(index){
		var grid = "formGrid";		
		if(index==2) grid = "dsGrid";
		var sels = $("#"+grid).datagrid("getSelections");
		for(var i=0; i<sels.length; i++){
			$('#'+grid).datagrid('deleteRow', $("#"+grid).datagrid("getRowIndex",sels[i]));
		}
	};
	impRecord = function(index){
		$('#impd').dialog('open');
		$("#commFieldGrid").datagrid('reload');
	};
	saveImp = function(){
		var sels = $("#commFieldGrid").datagrid("getSelections");
		for(var i=0; i<sels.length; i++){
			$('#formGrid').datagrid('appendRow', sels[i]);
		}
		$('#impd').dialog('close');
	};
	$('#formGrid').datagrid({
		onSelect:function(rowIndex, rowData){		
			endEdit("formGrid");			
			$('#formGrid').datagrid('beginEdit', rowIndex);			
		}
	});	
	$('#dsGrid').datagrid({
		onSelect:function(rowIndex, rowData){
			endEdit("dsGrid");
			$('#dsGrid').datagrid('beginEdit', rowIndex);
		}
	});	
	$(".btn-url").click(function(){
		var url = $("#urlAddress").val();
		if(url.indexOf("http://")==-1) url = "http://"+url;
		$("#formView iframe").attr("src", url);
	});
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
	//保存表单信息
	saveForm = function(){
		var no = $("#formInfo").find("input[name=no]").val();
		if($.trim(no)=='') {alert("编码不能为空"); return;}
		$(document.body).mask({
			maskMsg : "数据正在保存，请稍候..."
		});		
		var form = {
			id : $("#formInfo").find("input[name=id]").val(),
			no : $("#formInfo").find("input[name=no]").val(),
			name : $("#formInfo").find("input[name=name]").val(),
			table : $("#formInfo").find("input[name=table]").val(),
			remark: $("#formInfo").find("textarea[name=remark]").val(),
			tempType: $("#formInfo").find("select[name=tempType]").val(),
			moduleId: $("#moduleId").combotree("getValue"),
			actionAdd : $("#formInfo").find("input[name=actionAdd]").attr("checked")?1:0,
			actionUpdate : $("#formInfo").find("input[name=actionUpdate]").attr("checked")?1:0,
			actionDel : $("#formInfo").find("input[name=actionDel]").attr("checked")?1:0,
			actionImp : $("#formInfo").find("input[name=actionImp]").attr("checked")?1:0,
			actionExp : $("#formInfo").find("input[name=actionExp]").attr("checked")?1:0
		};
		var fields = new Array();
		$('#formGrid').datagrid('acceptChanges');
		var data = $("#formGrid").datagrid("getData");
		var rows = data.rows;
		var x = 0;
		for(var i=0; i<data.total; i++){
			if(rows.type=='') continue;
			fields[x++] = rows[i];
		}
		form.fields = fields;
		form.fieldCount = i;
		$.post("dfcode/save.zb",form, function(res){
			$(document.body).mask("hide");
			if(res.success){
				$.messager.alert('自定义表单',"表单保存成功",'info');
				$("#formInfo input[name=id]").val(res.extData);
				var url = "df/index.zb?fid="+res.extData;
                $("#urlAddress").val(viewBasicPath+url);
                $("#formView iframe").attr("src", url);
                $('#tt').tabs('enableTab', 2);
                $("#publishForm").linkbutton('enable');
                $("#unPublishForm").linkbutton('disable');
                $("#formTree").tree("reload");
			}else{
				 $.messager.alert('自定义表单',res.msg,'error');
			}
		}, 'json');
	};	
	
	//发布表单
	publishForm = function(){
		var id = $("#formInfo input[name=id]").val();
		var name = $("#formInfo input[name=name]").val();
		$.messager.confirm('自定义表单', "表单一旦发布，将无法再修改，确定要发布“"+name+"”表单吗？", function(r){
	        if (r){
	        	$(document.body).mask({
					maskMsg : "正在发布表单，请稍候..."
				});
	        	$.post("dfcode/publish.zb",{id:id}, function(res){
	        		$(document.body).mask("hide");
					if(res.success){
						$.messager.alert('自定义表单',"表单发布成功，您可以在“表单预览”选项卡中查看访问方式和相关界面效果",'info');
						var url = "df/index.zb?fid="+res.extData;
	                    $("#urlAddress").val(viewBasicPath+url);
	                    $("#formView iframe").attr("src", url);
	                    $("#tt").tabs("select",2);
	                    $("#formTree").tree("reload");
	                    $('#saveForm').linkbutton('disable');
	                    $("#loadForm").linkbutton('disable');
						$("#publishForm").linkbutton('disable');	
						$("#unPublishForm").linkbutton('enable');
					}else{
						 $.messager.alert('自定义表单',res.msg,'error');
					}
				}, 'json');
	        }
	    });		
	};
	//删除表单
	delForm = function(){
		var id = $("#formInfo input[name=id]").val();
		var name = $("#formInfo input[name=name]").val();
		$.messager.confirm('自定义表单', "一旦删除，表单对应的信息和表数据都将被删除，确定要删除“"+name+"”表单吗？", function(r){
	        if (r){
	        	$(document.body).mask({
					maskMsg : "正在删除数据，请稍候..."
				});
	        	$.post("dfcode/delete.zb",{id:id}, function(res){
	        		$(document.body).mask("hide");
					if(res.success){
						$.messager.alert('自定义表单',"表单删除成功",'info');	
						$("#formTree").tree("reload");
						addForm();
					}else{
						 $.messager.alert('自定义表单',res.msg,'error');
					}
				}, 'json');
	        }
	    });		
	};
	
	showDsd = function(index){		
		var dsType = $('#formGrid').datagrid('getRows')[index].dsType;
		var dsValue = $('#formGrid').datagrid('getRows')[index].dsValue;
		$(".ds-info").hide();
		if(dsType==1){ //自定义
			$("#dsd input:radio[value=1]").prop("checked", true);
			var rows = new Array();
			if(dsValue&&dsValue!=''){
				var dvs = dsValue.split("|");
				for(var i=0; i<dvs.length; i++){
					rows[i] = {
						dsValue : dvs[i].split(",")[0],
						dsText : dvs[i].split(",")[1]
					};
				}
			}
			$('#dsGrid').datagrid('loadData',{total:rows.length,rows:rows});
			$("#dsBasic").show();
		}else if(dsType==2){//字典			
			$("#dsd input:radio[value=2]").prop("checked", true);			
			$("#dictItemId").val(dsValue);
			$("#dictItemVal").val($('#formGrid').datagrid('getRows')[index].dsUrlId);
			if(!initDictTreeState) initDictTree();
			loadDictItem(dsValue);
			$("#dsDict").show();
		}else if(dsType==3){//关联表单
			$("#dsd input:radio[value=3]").prop("checked", true);
			$("#dsUrlForm select[name=dsValue]").val($('#formGrid').datagrid('getRows')[index].dsValue);
			loadRelField($('#formGrid').datagrid('getRows')[index].dsValue, $('#formGrid').datagrid('getRows')[index].dsUrlId, $('#formGrid').datagrid('getRows')[index].dsUrlText);			
			$("#dsUrl").show();								
		}else{
			$("#dsGrid").datagrid("loadData",[]);
			//默认为第一个选中状态
			$("#dsd input:radio[value=1]").prop("checked", true);
			$("#dsBasic").show();
		}
		$("#dsd").dialog("open");		
		curDsIndex = index;		
	};	
	
	saveDs = function(){
		var dsType = $("#dsd input:radio:checked").val();
		if(dsType==1){ //基本
			$('#dsGrid').datagrid('acceptChanges');
			var data = $("#dsGrid").datagrid("getData");
			var rows = data.rows;
			var dsValue = "";
			for(var i=0; i<data.total; i++){
				if(rows[i].dsValue==''&&rows[i].dsText=='') continue;
				else if(rows[i].dsValue!=''&&rows[i].dsText==''){
					dsValue += rows[i].dsValue+","+rows[i].dsValue+"|";
				}else if(rows[i].dsValue==''&&rows[i].dsText!=''){
					dsValue += rows[i].dsText+","+rows[i].dsText+"|";
				}else{
					dsValue += rows[i].dsValue+","+rows[i].dsText+"|";
				}
			}
			if(dsValue.length>0) dsValue = dsValue.substring(0, dsValue.length-1);
			$("#formGrid").datagrid("updateRow",{
				index : curDsIndex,
				row : {
					dsType: dsType,
					dsValue: dsValue
				}
			});
		}else if(dsType==2){//字典
			var dsValue = $("#dictItemId").val();
			if(dsValue==''){
				$.messager.alert('自定义表单','请选择字典','error');
			}else{
				$("#formGrid").datagrid("updateRow",{
				index : curDsIndex,
				row : {
					dsType: dsType,
					dsValue: dsValue,
					dsUrlId: $("#dictItemVal").val()
				}
			});
			}
		}else if(dsType==3){ //URL
			var dsValue = $("#dsUrlForm select[name=dsValue]").val();
			var dsUrlId = $("#dsUrlForm select[name=dsUrlId]").val();
			var dsUrlText = $("#dsUrlForm select[name=dsUrlText]").val();
			if(dsValue=='') dsUrlId = "";
			if(dsValue=='') dsUrlText = "";
			$("#formGrid").datagrid("updateRow",{
				index : curDsIndex,
				row : {
					dsType: dsType,
					dsValue: dsValue,
					dsUrlId: dsUrlId,
					dsUrlText: dsUrlText
				}
			});
		}
		$("#dsd").dialog("close");
	}
	
	$(".ds-type").click(function(){
		var value = $(this).val();
		$(".ds-info").hide();
		if(value==1) $("#dsBasic").show();
		if(value==2) {
			if(!initDictTreeState) initDictTree();
			$("#dsDict").show();			
		}
		if(value==3) $("#dsUrl").show();
	});
	/**
	 * 字典树点击事件
	 */
	function treeOnClick(node) {
		parentDictId = node.id;
		if (node.attributes.dictType == "1") {//如果点击的是具体字典节点，加载字典数据
			$("#dictItemId").val(node.id);
			$("#dictItemVal").val(node.dictCode+"  "+node.dictName);
			loadDictItem(node.id);
			dictIdQuery = node.id;
			editIndex = undefined;
		}
	};
	initDictTree = function(){
		$('#dictTree').tree({
	        url: 'dict/dictTree.zb?root=true',
	        customAttr: {
				dataModel: 'simpleData',
				textField: 'dictName',
				parentField: 'parentId',
				attributes: ['id','dictType','parentId']
	        },
	        onClick: function(node){
	            treeOnClick(node);
	        }
	    });
	    initDictTreeState = true;
	};	
	//初始化表单信息
	initFormInfo = function(id){
		$(document.body).mask({
			maskMsg : "数据加载中，请稍候..."
		});
		$("#formGrid").datagrid("loadData",[]);
		loadRelForm(id);//加载关联表单
		$.ajax({
			url : "dfcode/init.zb?id=" + id,
			type: 'POST',
			cache: false,
			dataType: 'json',
			success: function(res){
				for(var o in res){
					if(o=='remark'){
						$("#formInfo textarea").val(res[o]);
					}else if(o=='tempType'){
						$("#formInfo select").val(res[o]);
					}else if(o=='moduleId'){
						$("#moduleId").combotree("setValue",res[o]);
					}else if(o=='fields'){
						for(var i=0; i<res[o].length; i++){
							addRecord("formGrid", res[o][i]);
						}
					}else if(o.indexOf('action')>-1){
						$("#formInfo").find("input[name="+o+"]").attr("checked", res[o]==1);						
					}else{
						$("#formInfo input[name="+o+"]").val(res[o]);						
					}
				}
				$(document.body).mask("hide");
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert("初始化表单失败"+errorThrown);
				$(document.body).mask("hide");
			}
		});
	};
	//加载字典项
	loadDictItem = function(dictId){
		$.ajax({
			url : "dict/getDictItemByDictId.zb?dictId=" + dictId,
			type: 'POST',
			cache: false,
			dataType: 'json',
			success: function(res){
				$("#dictItemOpt").empty();
				if(res.success){
					var rows = res.rows;
					for(var i=0; i<rows.length; i++){
						$("#dictItemOpt").append("<option value='"+rows[i].id+"'>"+"["+rows[i].itemCode+"]&nbsp;&nbsp;"+rows[i].itemName+"</option>");
					}
				}
			}
		});
	};
	$('#formTree').tree({
		onClick: function(node){
			if(node.leaf) {				
				initFormInfo(node.id);
				$('#tt').tabs('select', 0);
				$('#tt').tabs('enableTab', 2);				
				var url = "df/index.zb?fid="+node.id;
                $("#urlAddress").val(viewBasicPath+url);
                $("#formView iframe").attr("src", url);
                $('#delForm').linkbutton('enable');
				if(node.publish){
					$('#saveForm').linkbutton('disable');	
					$("#loadForm").linkbutton('disable');
					$("#publishForm").linkbutton('disable');
					$("#unPublishForm").linkbutton('enable');
				}else{
					$('#saveForm').linkbutton('enable');
					$("#loadForm").linkbutton('enable');
					$("#publishForm").linkbutton('enable');
					$("#unPublishForm").linkbutton('disable');
				}
			}
		}
	});	
	
	addForm = function(){
		$("#formInfo").clearForm();		
		$("#formInfo").find("input[name=actionAdd]").attr("checked", true);
		$("#formInfo").find("input[name=actionUpdate]").attr("checked", true);
		$("#formInfo").find("input[name=actionDel]").attr("checked", true);
		$("#moduleId").combotree("setValue","");
		$("#formGrid").datagrid("loadData",[]);
		$("#urlAddress").val("");
		$("#formInfo input[name=id]").val("");
        $("#formView iframe").attr("src", "");
		$('#tt').tabs('select', 0);		
		$('#tt').tabs('disableTab', 2);        
		
		$('#saveForm').linkbutton('enable');
		$("#loadForm").linkbutton('enable');
		$('#delForm').linkbutton('disable');
		$("#publishForm").linkbutton('disable');	
		$("#unPublishForm").linkbutton('disable');
		
		loadRelForm();//加载关联表单
	};
	
	//载入表单
	loadForm = function(){		
		$('#loaddlg').dialog('open');
		$('#loadFormSources').combobox('reload', 'dfcode/listForLoad.zb')
	};
	//开始加载表单数据
	loadStart = function(){		
		var formId = $('#loadFormSources').combobox("getValue");
		if(typeof(formId)=='undefined'||formId==null||formId==''){
			alert("请选择来源表单");
			return;
		}		
		$('#loaddlg').dialog('close');
		$.messager.progress({
			text: '正在载入表单信息，请稍候...'
		}); 
		$("#formGrid").datagrid("loadData",[]);
		$.ajax({
			url : "dfcode/init.zb?id=" + formId,
			type: 'POST',
			cache: false,
			dataType: 'json',
			success: function(res){
				for(var o in res){
					if(o=='remark'){
						$("#formInfo textarea").val(res[o]);
					}else if(o=='tempType'){
						$("#formInfo select").val(res[o]);
					}else if(o=='moduleId'){
						$("#moduleId").combotree("setValue",res[o]);
					}else if(o=='fields'){
						for(var i=0; i<res[o].length; i++){
							addRecord("formGrid", res[o][i]);
						}
					}else if(o=='id'){}else if(o.indexOf('action')>-1){
						$("#formInfo").find("input[name="+o+"]").attr("checked", res[o]==1);						
					}else{
						$("#formInfo input[name="+o+"]").val(res[o]);						
					}
				}
				$.messager.progress('close');
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){
				alert("复制表单失败"+errorThrown);
				$.messager.progress('close');
			}
		});
	};
	//取消发布
	unPublishForm = function(){
		var id = $("#formInfo input[name=id]").val();
		var name = $("#formInfo input[name=name]").val();
		$.messager.confirm('自定义表单', "表单一旦取消发布，所有信息和相关表数据都将被删除，确定要取消发布“"+name+"”表单吗？", function(r){
	        if (r){
	        	$(document.body).mask({
					maskMsg : "正在取消发布表单，请稍候..."
				});
	        	$.post("dfcode/unpublish.zb",{id:id}, function(res){
	        		$(document.body).mask("hide");
					if(res.success){
						$.messager.alert('自定义表单',"表单发布取消成功，您可以在“"+res.msg+"”表中查看历史数据",'info');
						var url = "df/index.zb?fid="+res.extData;
	                    $("#urlAddress").val(viewBasicPath+url);
	                    $("#formView iframe").attr("src", url);
	                    $("#tt").tabs("select",0);
	                    $("#formTree").tree("reload");
	                    $('#saveForm').linkbutton('enable');
	                    $("#loadForm").linkbutton('enable');
						$("#publishForm").linkbutton('enable');
						$("#unPublishForm").linkbutton('disable');
					}else{
						 $.messager.alert('自定义表单',res.msg,'error');
					}
				}, 'json');
	        }
	    });		
	};
	//复制表单	
	copyForm = function(){		
		$('#copydlg').dialog('open');
		$('#copyFormSources').combobox('reload', 'dfcode/listForLoad.zb')
	};
	//开始复制表单
	copyStart = function(){		
		var formId = $('#copyFormSources').combobox("getValue");
		var no = $("#copydlg form input[name=no]").val();
		if(typeof(formId)=='undefined'||formId==null||formId==''){
			alert("请选择来源表单");
			return;
		}
		if(typeof(no)=='undefined'||no==null||no==''){
			alert("请输入新表单编码");
			return;
		}
		$('#copydlg').dialog('close');
		$.messager.progress({
			text: '正在复制表单信息，请稍候...'
		}); 
		$('#copydlg form').ajaxSubmit({
			dataType: 'json',
			success: function(res){
				$.messager.progress('close');
				if(res.success){
					$.messager.alert('自定义表单',"表单复制成功",'info');
					initFormInfo(res.extData);
					$('#tt').tabs('select', 0);
					$('#tt').tabs('enableTab', 2);				
					$("#formTree").tree("reload");
					var url = "df/index.zb?fid="+res.extData;
	                $("#urlAddress").val(viewBasicPath+url);
	                $("#formView iframe").attr("src", url);
	                $('#delForm').linkbutton('enable');
					$('#saveForm').linkbutton('enable');
					$("#loadForm").linkbutton('enable');
					$("#publishForm").linkbutton('enable');
					$("#unPublishForm").linkbutton('disable');					
				}else{
					 $.messager.alert('自定义表单',res.msg,'error');
				}
			}
		});
	};
	//加载关联表单选项	
	loadRelForm = function(id){
		$.post('dfcode/getForms.zb',{id: id}, function(res){
			var obj = $("#dsUrlForm select[name=dsValue]");
			obj.empty();
			var data = eval('('+res+')');
			obj.append("<option value=''>请选择</option>");
			for(var i=0; i<data.length; i++){
				obj.append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
			}
			$("#dsUrlForm select[name=dsUrlId]").empty();
			$("#dsUrlForm select[name=dsUrlText]").empty();
		});
	};
	$("#dsUrlForm select[name=dsValue]").change(function(){
		loadRelField($(this).val());
	});
	//加载关联字段
	loadRelField = function(id, value, text){
		$.post('dfcode/getFields.zb',{id: id}, function(res){
			var obj = $("#dsUrlForm select[name=dsUrlId]");
			var objText = $("#dsUrlForm select[name=dsUrlText]");
			obj.empty();objText.empty();
			var data = eval('('+res+')');
			for(var i=0; i<data.length; i++){
				obj.append("<option value='"+data[i].id+"' "+(value==data[i].id?'selected':'')+">【"+data[i].no+"】"+data[i].name+"</option>");
				objText.append("<option value='"+data[i].id+"' "+(text==data[i].id?'selected':'')+">【"+data[i].no+"】"+data[i].name+"</option>");
			}
		});
	};
	
	//版本检查
	updateForm = function(){
		$.messager.progress({
			text: '正在检查更新，请稍候...'
		}); 
		$.post("dfcode/update/check.zb",{}, function(res){
			res = eval('('+res+')');
			$.messager.progress('close');
			if(res.success){				
				var state = res.total;
				if(state==0){
					$.messager.alert('自定义表单','系统版本已是最新','info');	
				}else if(state>0){
					updateVer();
				}else{
					$.messager.alert('自定义表单','数据库版本比系统版本不匹配，请联系管理员','info');
				}
			}else{
				$.messager.alert('自定义表单',res.msg,'error');	
			}
		});
	};
	
	updateVer = function(){
		$.messager.confirm('自定义表单', '检测到新版本，是否更新？', function(r){
			if (r){
				$.messager.progress({
					text: '正在更新系统，请稍候...'
				}); 
				$.post("dfcode/update.zb",{ver:dbUpdate},function(res){
					res = eval('('+res+')');
					$.messager.progress('close');					
					if(res.success){
						$.messager.progress({
							text: '系统升级成功。正在重载页面...'
						});
						window.location.reload();						
					}else{
						if(res.msg&&res.msg!=''){
							$.messager.alert('自定义表单',res.msg,'error');
						}else{
							$.messager.alert('自定义表单','系统升级失败，请联系管理员。','error');	
						}						
					}
				});
			}
		});	
	};
	//系统属性配置
	settingForm = function(){
		$('#settingd').dialog({   
		    title: '系统设置',   
		    width: $(document.body).width() * 0.9,   
		    height: $(document.body).height() * 0.9,   
		    closed: false,   
		    cache: false, 
		    modal: true  
		});   
		$('#settingd').dialog('refresh', 'df/setting.jsp');  
	};
	
	//默认为新建表单
	addForm();
	
	//执行版本自动检测程序
	if(dbUpdate!='1'){
		updateVer();
	}
});