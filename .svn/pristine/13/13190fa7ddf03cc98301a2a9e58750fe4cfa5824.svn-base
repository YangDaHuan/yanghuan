(function($){
	// 全局系统对象
    window['jqueryUtil'] = {};
    
  /**
	 * IE检测
	 */
	jqueryUtil.isLessThanIe8 = function() {
		return ($.support.msie && $.support.version < 8);
	};
	/**
	 * 序列化表单到json对象
	 */
	jqueryUtil.serializeObject = function(form) {
		// console.dir(form.serializeArray());
		var o = {};
		$.each(form.serializeArray(), function(index) {
			if (o[this['name']]) {
				o[this['name']] = o[this['name']] + "," + (this['value']==''?' ':this['value']);
			} else {
				o[this['name']] = this['value']==''?' ':this['value'];
			}
		});
		// console.dir(o);
		return o;
	};
	
	/**
	 * 切换皮肤
	 */
	jqueryUtil.chgSkin=function(selectId,cookiesColor){
        	 docchgskin(document,selectId,cookiesColor);
            $("iframe").each(function (){   
                var dc=this.contentWindow.document;
                docchgskin(dc,selectId,cookiesColor);
            });
            function docchgskin(dc,selectId,cookiesColor){
						removejscssfile(dc,"themes/"+cookiesColor+"/easyui.css", "css");
                        createLink(dc,"themes/"+selectId+"/easyui.css");
        	}
            function createLink(dc,url){
		    	var urls = url.replace(/[,]\s*$/ig,"").split(",");
		    	var links = [];
		    	for( var i = 0; i < urls.length; i++ ){
			    links[i] = dc.createElement("link");
			    links[i].rel = "stylesheet";
			    links[i].href = urls[i];
			    dc.getElementsByTagName("head")[0].appendChild(links[i]);
		     	}
	    	}
            function removejscssfile(dc,filename, filetype){
	            var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none"
	            var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none"
	            var allsuspects=dc.getElementsByTagName(targetelement)
	            for (var i=allsuspects.length; i>=0; i--)
	            {
	                if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1)
	                allsuspects[i].parentNode.removeChild(allsuspects[i])
	            }
        	}  
        };
	
      /**
		 * 高级查询
		 */
        jqueryUtil.gradeSearch=function($dg,formId,url) {
			$("<div/>").dialog({
				href : url,
				modal : true,
				title : '高级查询',
				top : 120,
				width : 480,
				buttons : [ {
					text : '增加一行',
					iconCls : 'icon-add',
					handler : function() {
						var currObj = $(this).closest('.panel').find('table');
						currObj.find('tr:last').clone().appendTo(currObj);
						currObj.find('tr:last a').show();
					}
				}, {
					text : '确定',
					iconCls : 'icon-ok',
					handler : function() {
						$dg.datagrid('reload',jqueryUtil.serializeObject($(formId)));
					}
				}, {
					text : '取消',
					iconCls : 'icon-cancel',
					handler : function() {
						$(this).closest('.window-body').dialog('destroy');
					}
				} ],
				onClose : function() {
					$(this).dialog('destroy');
				}
			});
		};
    
	/**
	 * 取消easyui默认开启的parser 在页面加载之前，先开启一个进度条 然后在页面所有easyui组件渲染完毕后，关闭进度条
	 * 
	 * @requires jQuery,EasyUI
	 */
	$.parser.auto = false;
	$(function() {
		$.messager.progress({
			text : '加载中....',
			interval : 100
		});
		$.parser.parse(window.document);
		window.setTimeout(function() {
			$.messager.progress('close');
			if (self != parent) {
				window.setTimeout(function() {
					try {
						parent.$.messager.progress('close');
					} catch (e) {
					}
				}, 500);
			}
		}, 1);
		$.parser.auto = true;
	});
	
	/**
	 * 定义图标样式的数组
	 */
	$.iconData = [ {
		value : '',
		text : '默认'
	},{
		value : 'icon-adds',
		text : 'icon-adds'
	}
	,{
		value : 'icon-ok',
		text : 'icon-ok'
	},{
		value : 'icon-edit',
		text : 'icon-edit'
	} ,{
		value : 'icon-tip',
		text : 'icon-tip'
	},{
		value : 'icon-back',
		text : 'icon-back'
	},{
		value : 'icon-remove',
		text : 'icon-remove'
	},{
		value : 'icon-undo',
		text : 'icon-undo'
	},{
		value : 'icon-cancel',
		text : 'icon-cancel'
	}
	,{
		value : 'icon-save',
		text : 'icon-save'
	}
	,{
		value : 'icon-config',
		text : 'icon-config'
	},{
		value : 'icon-comp',
		text : 'icon-comp'
	},{
		value : 'icon-sys',
		text : 'icon-sys'
	},{
		value : 'icon-db',
		text : 'icon-db'
	},{
		value : 'icon-pro',
		text : 'icon-pro'
	},{
		value : 'icon-role',
		text : 'icon-role'
	},{
		value : 'icon-end',
		text : 'icon-end'
	},{
		value : 'icon-bug',
		text : 'icon-bug'
	},{
		value : 'icon-badd',
		text : 'icon-badd'
	},{
		value : 'icon-bedit',
		text : 'icon-bedit'
	},{
		value : 'icon-bdel',
		text : 'icon-bdel'
	},{
		value : 'icon-item',
		text : 'icon-item'
	},{
		value : 'icon-excel',
		text : 'icon-excel'
	},{
		value : 'icon-auto',
		text : 'icon-auto'
	},{
		value : 'icon-time',
		text : 'icon-time'
	}
	];
    
})(jQuery)
// ========================================


/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 */
$.fn.panel.defaults.onBeforeDestroy = function() {
	var frame = $('iframe', this);
	try {
		if (frame.length > 0) {
			for ( var i = 0; i < frame.length; i++) {
				frame[i].contentWindow.document.write('');
				frame[i].contentWindow.close();
			}
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	} catch (e) {
	}
};

/**
 * 使panel和datagrid在加载时提示
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.fn.panel.defaults.loadingMessage = '加载中....';
$.fn.datagrid.defaults.loadMsg = '加载中....';

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 通用错误提示
 * 
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 */
var easyuiErrorFunction = function(XMLHttpRequest) {
	$.messager.progress('close');
	try{
		if($("#__syserr").length==0){
			$("body").append("<div id='__syserr'></div>");
		}
		
		$('#__syserr').dialog({
			title: '错误',
			width: 500,
			height: 400,
			resizable : true,
			content: XMLHttpRequest.responseText
 		});
		//var emsg = XMLHttpRequest.responseText.substring(XMLHttpRequest.responseText.indexOf('错误描述'),XMLHttpRequest.responseText.indexOf('错误信息'));
		 //$.messager.alert('错误',emsg);
	}catch(ex){
		 $.messager.alert('错误',XMLHttpRequest.responseText+'');
	}
};
$.fn.datagrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.treegrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.tree.defaults.onLoadError = easyuiErrorFunction;
$.fn.combogrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.combobox.defaults.onLoadError = easyuiErrorFunction;
$.fn.form.defaults.onLoadError = easyuiErrorFunction;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			if (!fildOption.hidden) {
				$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			} else {
				$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			}
		}
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var field = $(item.target).attr('field');
				if (item.iconCls == 'icon-ok') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-empty'
					});
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-ok'
					});
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展validatebox，添加验证两次密码功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	eqPwd : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致！'
	}
});




/**
 * 扩展树表格级联选择（点击checkbox才生效）： 自定义两个属性： cascadeCheck ：普通级联（不包括未加载的子节点）
 * deepCascadeCheck ：深度级联（包括未加载的子节点）
 */
$.extend($.fn.treegrid.defaults,{
	onLoadSuccess : function() {
		var target = $(this);
		var opts = $.data(this, "treegrid").options;
		var panel = $(this).datagrid("getPanel");
		var gridBody = panel.find("div.datagrid-body");
		var idField = opts.idField;// 这里的idField其实就是API里方法的id参数
		gridBody.find("div.datagrid-cell-check input[type=checkbox]").unbind(".treegrid").click(function(e){
			if(opts.singleSelect) return;// 单选不管
			if(opts.cascadeCheck||opts.deepCascadeCheck){
				var id=$(this).parent().parent().parent().attr("node-id");
				var status = false;
				if($(this).attr("checked")){
					target.treegrid('select',id);
					status = true;
				}else{
					target.treegrid('unselect',id);
				}
				// 级联选择父节点
				selectParent(target,id,idField,status);
				selectChildren(target,id,idField,opts.deepCascadeCheck,status);
			}
			e.stopPropagation();// 停止事件传播
		});
	}
});

/**
 * 扩展树表格级联勾选方法：
 * 
 * @param {Object}
 *            container
 * @param {Object}
 *            options
 * @return {TypeName}
 */
$.extend($.fn.treegrid.methods,{
	/**
	 * 级联选择
	 * 
	 * @param {Object}
	 *            target
	 * @param {Object}
	 *            param param包括两个参数: id:勾选的节点ID deepCascade:是否深度级联
	 * @return {TypeName}
	 */
	cascadeCheck : function(target,param){
		var opts = $.data(target[0], "treegrid").options;
		if(opts.singleSelect)
			return;
		var idField = opts.idField;// 这里的idField其实就是API里方法的id参数
		var status = false;// 用来标记当前节点的状态，true:勾选，false:未勾选
		var selectNodes = $(target).treegrid('getSelections');// 获取当前选中项
		for(var i=0;i<selectNodes.length;i++){
			if(selectNodes[i][idField]==param.id)
				status = true;
		}
		// 级联选择父节点
		selectParent(target,param.id,idField,status);
		selectChildren(target,param.id,idField,param.deepCascade,status);
	}
});


/**
 * 级联选择父节点
 * 
 * @param {Object}
 *            target
 * @param {Object}
 *            id 节点ID
 * @param {Object}
 *            status 节点状态，true:勾选，false:未勾选
 * @return {TypeName}
 */
function selectParent(target,id,idField,status){
	var parent = target.treegrid('getParent',id);
	if(parent){
		var parentId = parent[idField];
		if(status)
			target.treegrid('select',parentId);
		else
			target.treegrid('unselect',id);
		selectParent(target,parentId,idField,status);
	}
}

/**
 * 级联选择子节点
 * 
 * @param {Object}
 *            target
 * @param {Object}
 *            id 节点ID
 * @param {Object}
 *            deepCascade 是否深度级联
 * @param {Object}
 *            status 节点状态，true:勾选，false:未勾选
 * @return {TypeName}
 */
function selectChildren(target,id,idField,deepCascade,status){
	// 深度级联时先展开节点
	if(status&&deepCascade)
		target.treegrid('expand',id);
	// 根据ID获取下层孩子节点
	var children = target.treegrid('getChildren',id);
	for(var i=0;i<children.length;i++){
		var childId = children[i][idField];
		if(status)
			target.treegrid('select',childId);
		else
			target.treegrid('unselect',childId);
		selectChildren(target,childId,idField,deepCascade,status);// 递归选择子节点
	}
}

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展treegrid，使其支持平滑数据格式
 */
$.fn.treegrid.defaults.loadFilter = function(data, parentId) {
	var opt = $(this).data().treegrid.options;
	var idFiled, textFiled, parentField;
	if (opt.parentField) {
		idFiled = opt.idFiled || 'id';
		textFiled = opt.textFiled || 'text';
		parentField = opt.parentField;
		var i, l, treeData = [], tmpMap = [];
		for (i = 0, l = data.length; i < l; i++) {
			tmpMap[data[i][idFiled]] = data[i];
		}
		for (i = 0, l = data.length; i < l; i++) {
			if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
				if (!tmpMap[data[i][parentField]]['children'])
					tmpMap[data[i][parentField]]['children'] = [];
				data[i]['text'] = data[i][textFiled];
				tmpMap[data[i][parentField]]['children'].push(data[i]);
			} else {
				data[i]['text'] = data[i][textFiled];
				treeData.push(data[i]);
			}
		}
		return treeData;
	}
	return data;
};

// 自定义loadFilter的实现
$.fn.tree.defaults.loadFilter = function (data, parent) {
	var opt = $(this).data().tree.options;
	var idFiled,
	textFiled,
	parentField;
	if (opt.parentField) {
		idFiled = opt.idFiled || 'id';
		textFiled = opt.textFiled || 'text';
		parentField = opt.parentField;
		var i,l,treeData = [],
		tmpMap = [];
		for (i = 0, l = data.length; i < l; i++) {
			tmpMap[data[i][idFiled]] = data[i];
		}
		for (i = 0, l = data.length; i < l; i++) {
			if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
				if (!tmpMap[data[i][parentField]]['children'])
					tmpMap[data[i][parentField]]['children'] = [];
				data[i]['text'] = data[i][textFiled];
				tmpMap[data[i][parentField]]['children'].push(data[i]);
			} else {
				data[i]['text'] = data[i][textFiled];
				treeData.push(data[i]);
			}
		}
		return treeData;
	}
	return data;
};
/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展combotree，使其支持平滑数据格式
 */
$.fn.combotree.defaults.loadFilter = $.fn.tree.defaults.loadFilter;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 防止panel/window/dialog组件超出浏览器边界
 * @param left
 * @param top
 */
var easyuiPanelOnMove = function(left, top) {
	var l = left;
	var t = top;
	if (l < 1) {
		l = 1;
	}
	if (t < 1) {
		t = 1;
	}
	var width = parseInt($(this).parent().css('width')) + 14;
	var height = parseInt($(this).parent().css('height')) + 14;
	var right = l + width;
	var buttom = t + height;
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	if (right > browserWidth) {
		l = browserWidth - width;
	}
	if (buttom > browserHeight) {
		t = browserHeight - height;
	}
	$(this).parent().css({/* 修正面板位置 */
		left : l,
		top : t
	});
};
$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
$.fn.window.defaults.onMove = easyuiPanelOnMove;
$.fn.panel.defaults.onMove = easyuiPanelOnMove;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI,jQuery cookie plugin
 * 
 * 更换EasyUI主题的方法
 * 
 * @param themeName
 *            主题名称
 */
changeTheme = function(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('#easyuiTheme').attr('href', href);
		}
	}

	$.cookie('easyuiThemeName', themeName, {
		expires : 7
	});
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 将form表单元素的值序列化成对象
 * 
 * @returns object
 */
serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};

/**
 * @author 孙宇
 * 
 * 增加formatString功能
 * 
 * 使用方法：formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};

/**
 * @author 孙宇
 * 
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 改变jQuery的AJAX默认属性和方法
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		$.messager.progress('close');
		$.messager.alert('错误', XMLHttpRequest.responseText);
	}
});
//tip
function tip(msg){
	$.messager.show({
		title:"提示",
		msg:msg,
		showType:"slide",
		style:{
			right:"",
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:""
		},
		closable:false
	});
}


/***************************************************************
 * 扩展easyui，支持my97日历控件。
 * 默认的用法和easyui的原生插件是一样的，可以通过class实例化，也可以通过代码实例化
 * 1、	<input  class="easyui-my97" type="text">
 * 2、	<input  id="my97" type="text" name="">
 *		$('#my97').my97(options);
 *	至于options属性和事件，这是完全和my91自身的一样，没有新增也没有减少
 */

(function($) {
	$.fn.my97 = function(options, params) {
		if (typeof options == "string") {
			return $.fn.my97.methods[options](this, params);
		}
		options = options || {};
		if (!WdatePicker) {
			alert("未引入My97js包！");
			return;
		}
		return this.each(function() {
			var data = $.data(this, "my97");
			var newOptions;
			if (data) {
				newOptions = $.extend(data.options, options);
				data.opts = newOptions;
			} else {
				newOptions = $.extend({}, $.fn.my97.defaults, $.fn.my97
						.parseOptions(this), options);
				$.data(this, "my97", {
					options : newOptions
				});
			}
			$(this).addClass('Wdate').click(function() {
				WdatePicker(newOptions);
			});
		});
	};

	$.fn.my97.methods = {
		setValue : function(target, params) {
			target.val(params);
		},
		getValue : function(target) {
			return target.val();
		},
		clearValue : function(target) {
			target.val('');
		}
	};

	$.fn.my97.parseOptions = function(target) {
		return $.extend({}, $.parser.parseOptions(target, [ "el", "vel",
				"weekMethod", "lang", "skin", "dateFmt", "realDateFmt",
				"realTimeFmt", "realFullFmt", "minDate", "maxDate",
				"startDate", {
					doubleCalendar : "boolean",
					enableKeyboard : "boolean",
					enableInputMask : "boolean",
					autoUpdateOnChanged : "boolean",
					firstDayOfWeek : "number",
					isShowWeek : "boolean",
					highLineWeekDay : "boolean",
					isShowClear : "boolean",
					isShowToday : "boolean",
					isShowOthers : "boolean",
					readOnly : "boolean",
					errDealMode : "boolean",
					autoPickDate : "boolean",
					qsEnabled : "boolean",
					autoShowQS : "boolean",
					opposite : "boolean"
				} ]));
	};
	$.fn.my97.defaults = {
		dateFmt : 'yyyy-MM-dd HH:mm:ss'
	};
	$.parser.plugins.push('my97');
})(jQuery);



/************************************校验扩展************************************/
/*@author Zhangcy
 * 需要传递两个参数的唯一性验证(比如修改时的唯一性验证)
 * @param value是验证所在的value
 * @unique[信息名称,url,name,第二个参数]
 第二个参数为动态执行的json脚本
 * */
$.extend($.fn.validatebox.defaults.rules,{
	unique:{
		validator:function(value,param){
			var result;
			var json={};
			var name=param[2];
			json[name]=value;
			var json2=eval("("+param[3]+")");
			$.extend(json,json2);
			jQuery.ajax({
				type:"POST",
				async:false,//不同步
				url:encodeURI(param[1]),
				data:json,
				success:function(data){
					result = data;
				}
			});
			return result;//true:正确,false显示message
		},
		message:"{0}已存在"
	},
	//最小长度
	minLength: { 
		validator: function(value, param){ 
		return value.length >= param[0]; 
		}, 
		message: '请至少输入{0}个字符.' 
	} ,
	//固定长度
	fixLength: { 
		validator: function(value, param){ 
			return value.length == param[0]; 
		}, 
		message: '请输入{0}个字符.' 
	} ,
	alpha : {
		validator : function(value, param) {
			if (value) {
				return /^[a-zA-Z\u00A1-\uFFFF]*$/.test(value);
			} else {
				return true;
			}
		},
		message : '只能输入字母.'
	},
	alphanum : {
		validator : function(value, param) {
			if (value) {
				return /^([a-zA-Z\u00A1-\uFFFF0-9])*$/.test(value);
			} else {
				return true;
			}
		},
		message : '只能输入字母和数字.'
	},
	positiveInt : {
		validator : function(value, param) {
			if (value) {
				return /^[0-9]*[1-9][0-9]*$/.test(value);
			} else {
				return true;
			}
		},
		message : '只能输入正整数.'
	},
	chsNoSymbol : {
		validator : function(value, param) {
			return /^[\u4E00-\u9FA5]+$/.test(value);
		},
		message : '只能输入中文'
	},
	chs : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5]+$/.test(value);
		},
		message : '请输入汉字'
	},
	zip : {
		validator : function(value, param) {
			return /^[1-9]\d{5}$/.test(value);
		},
		message : '邮政编码不存在'
	},
	qq : {
		validator : function(value, param) {
			return /^[1-9]\d{4,10}$/.test(value);
		},
		message : 'QQ号码不正确'
	},
	mobile : {
		validator : function(value, param) {
			return /^[1][358][0-9]{9}$/.test(value);
		},
		message : '手机号码不正确'
	},
	checkPhone : {
		validator : function(value, param) {
			var ev = value;
			var regu = /^(\d{7,13}|\d{3,5}-\d{7,8})(\-\d{1,4})?$/;
			var re = new RegExp(regu);
			if (!re.test(ev)) {
				return false;
			}
			return true;
		},
		message : "电话格式不正确"
	},
	checkDate : {
		validator : function(value, param) {
			var ev = value;
			var regu=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/;
			var re = new RegExp(regu);
			if (!re.test(ev)) {
				return false;
			}
			return true;
		},
		message : "时间格式不正确"
	},
	commonChar : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message : '只允许汉字、英文字母、数字及下划线。'
	},
	loginName : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message : '登录名称只允许汉字、英文字母、数字及下划线。'
	},
	safepass : {
		validator : function(value, param) {
			return safePassword(value);
		},
		message : '密码由字母和数字组成，至少6位'
	},
	equalTo : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '两次输入的字符不一至'
	},
	number : {
		validator : function(value, param) {
			return /^\d+$/.test(value);
		},
		message : '请输入数字'
	},
	idcard : {
		validator : function(value, param) {
			return idCard(value);
		},
		message : '请输入正确的身份证号码'
	},
	email : {
		validator : function(value, param) {
			if ((value.length > 128) || (value.length < 6)) {
				return false;
			}
		    var format = /^[A-Za-z0-9+]+[A-Za-z0-9\.\_\-+]*@([A-Za-z0-9\-]+\.)+[A-Za-z0-9]+$/;
		    if (!value.match(format)) {
		        return false;
		    }
		    return true;
		},
		message : '请输入正确的邮件地址'
	}
});


$.extend($.fn.validatebox.defaults.rules, {
    radio: {
         validator: function (value, param) {
            var input= param[0], ok = false;
            $('input[name="' + input + '"]').each(function () { 
                if (this.checked) { ok = true; return false; }
            });
            return ok
        },
        message: '请选择一项'
    },
    checkbox: {
         validator: function (value, param) {
            var input = param[0];
            var checkNum = 0;
            $('input[name="' + input + '"]').each(function () { 
                if (this.checked) checkNum++;
            });
            return checkNum >= param[1] && checkNum <= param[2];
        },
        message: '请选择{1}-{2}项'
    }
});




/* 密码由字母和数字组成，至少6位 */
var safePassword = function(value) {
	return !(/^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/
			.test(value));
}

var idCard = function(value) {
	if (value.length == 18 && 18 != value.length)
		return false;
	var number = value.toLowerCase();
	var d, sum = 0, v = '10x98765432', w = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7,
			9, 10, 5, 8, 4, 2 ], a = '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
	var re = number
			.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/);
	if (re == null || a.indexOf(re[1]) < 0)
		return false;
	if (re[2].length == 9) {
		number = number.substr(0, 6) + '19' + number.substr(6);
		d = [ '19' + re[4], re[5], re[6] ].join('-');
	} else
		d = [ re[9], re[10], re[11] ].join('-');
	if (!isDateTime.call(d, 'yyyy-MM-dd'))
		return false;
	for ( var i = 0; i < 17; i++)
		sum += number.charAt(i) * w[i];
	return (re[2].length == 9 || number.charAt(17) == v.charAt(sum % 11));
}

var isDateTime = function(format, reObj) {
	format = format || 'yyyy-MM-dd';
	var input = this, o = {}, d = new Date();
	var f1 = format.split(/[^a-z]+/gi), f2 = input.split(/\D+/g), f3 = format
			.split(/[a-z]+/gi), f4 = input.split(/\d+/g);
	var len = f1.length, len1 = f3.length;
	if (len != f2.length || len1 != f4.length)
		return false;
	for ( var i = 0; i < len1; i++)
		if (f3[i] != f4[i])
			return false;
	for ( var i = 0; i < len; i++)
		o[f1[i]] = f2[i];
	o.yyyy = s(o.yyyy, o.yy, d.getFullYear(), 9999, 4);
	o.MM = s(o.MM, o.M, d.getMonth() + 1, 12);
	o.dd = s(o.dd, o.d, d.getDate(), 31);
	o.hh = s(o.hh, o.h, d.getHours(), 24);
	o.mm = s(o.mm, o.m, d.getMinutes());
	o.ss = s(o.ss, o.s, d.getSeconds());
	o.ms = s(o.ms, o.ms, d.getMilliseconds(), 999, 3);
	if (o.yyyy + o.MM + o.dd + o.hh + o.mm + o.ss + o.ms < 0)
		return false;
	if (o.yyyy < 100)
		o.yyyy += (o.yyyy > 30 ? 1900 : 2000);
	d = new Date(o.yyyy, o.MM - 1, o.dd, o.hh, o.mm, o.ss, o.ms);
	var reVal = d.getFullYear() == o.yyyy && d.getMonth() + 1 == o.MM
			&& d.getDate() == o.dd && d.getHours() == o.hh
			&& d.getMinutes() == o.mm && d.getSeconds() == o.ss
			&& d.getMilliseconds() == o.ms;
	return reVal && reObj ? d : reVal;
	function s(s1, s2, s3, s4, s5) {
		s4 = s4 || 60, s5 = s5 || 2;
		var reVal = s3;
		if (s1 != undefined && s1 != '' || !isNaN(s1))
			reVal = s1 * 1;
		if (s2 != undefined && s2 != '' && !isNaN(s2))
			reVal = s2 * 1;
		return (reVal == s1 && s1.length != s5 || reVal > s4) ? -10000 : reVal;
	}
};