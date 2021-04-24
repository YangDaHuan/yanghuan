<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page
	import="org.apache.shiro.SecurityUtils,com.solidextend.sys.security.UserDetails"%>
<%
UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
String userName=userDetails.getLoginName();
String password=userDetails.getPassword();
%>
<!DOCTYPE html>
<html>
<head>
<title>dashboar</title>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
<meta name="description" content="Freewall demo filter" />
<meta name="keywords"
	content="javascript, dynamic, grid, layout, jquery plugin, fit zone" />

<link rel="stylesheet" type="text/css"
	href="../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="../css/zTreeStyle/zTreeStyle.css">

<!-- Saiku CSS -->
<link rel="stylesheet" href="./css/saiku/src/styles.css" type="text/css">

<script type="text/javascript" src="../js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/freewall.js"></script>
<!-- echarts -->
<script src="./js/echarts/echarts-all.js"></script>
<style type="text/css">
.layout {
	padding: 15px;
}

.free-wall {
	
}

.filter-items {
	padding: 10px 0px;
}

.filter-label {
	display: inline-block;
	margin: 0px 5px 5px 0px;
	padding: 10px;
	cursor: pointer;
	background: rgb(205, 149, 12);
}

.filter-label.active, .filter-label:hover {
	background: rgb(238, 180, 34);
}
</style>
</head>
<body>
	<div id="cc" class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',title:'resource',split:true"
			style="width: 200px;">
			<ul id="tree" class="ztree" style="width: 230px; overflow: auto;"></ul>
		</div>
		<div
			data-options="region:'center',title:'dashboard',tools:'#dashboard-buttons'">
			<div class="datagrid-toolbar">
				<a onclick="solidbi.addWidget(true);" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-open'">打开</a> <a
					onclick="$('#newDashboardDlg').dialog('open');"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-add'">新建仪表板</a> <a
					onclick="solidbi.addWidget(true);" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-add'">添加窗格</a> <a
					onclick="$('#saveDashboardDlg').dialog('open');('#dashboardName').textbox('setValue',solidbi.dashboardName);"
					class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-save'">保存</a> <a
					onclick="solidbi.addWidget(true);" class="easyui-linkbutton"
					data-options="plain:true,iconCls:'icon-del'">删除</a>
			</div>
			<div class="layout">
				<div id="filterItems" class="filter-items"></div>
				<div id="freewall" class="free-wall"></div>
			</div>

		</div>

	</div>


	<script type="text/javascript">
			function saveDashboard(name){
				var id=solidbi.dashboardId;
				solidbi.dashboardName=name;
				var widgets=solidbi.dashboard;
				$.post("dashboard/saveDashboard.zb",{id:id,name:name,widgets:widgets},
						function(result, status) {
							if(result.success){//操作成功
								$.noty.closeAll();
								var n = noty({text: "保存成功",type:"success",layout:"topCenter",timeout:1000});
							}else{//保存失败
								$.messager.alert("错误","保存数据时出现系统错误!","error");
							}							
							
						},
						"json"
					);
					
			}

			var solidbi	= {
				filterItems:null,
				biWall:null,
				freewall:null,
				widgetPrefix:"窗格",
				widgetIdPrefix:"widget_",
				widgetWidth:400,
				widgetHeight:300,
				widgetMaxId:0,
				dashboard:[],
				dashboardName:null,
				dashboardId:null,
				showEcharts:function(div,chartType,data){
					for(var i=0;i<data.series.length;i++){
						data.series[i]['type']=chartType;
					}
					var myChart = echarts.init(document.getElementById(div));
					var option = {
						title : {
							text: data.title,
							subtext: data.subtitle
						},
						tooltip : {
							trigger: 'axis'
						},
						legend: {
							data:data.legend
						},
						calculable : true,
						xAxis : [
							{
								type : 'category',
								data : data.category
							}
						],
						yAxis : [
							{
								type : 'value'
							}
						],
						series : data.series
					};
											
					myChart.setOption(option);
				},
				process_chartdata:function(args,type) {
					var data = {};
					data.legend=[];
					data.category=[];
					data.series=[];
					
					data.resultset = [];
					data.metadata = [];
					data.height = 0;
					data.width = 0;

			        if (typeof args == "undefined") {
			            return;
			        }
	
			        // Check to see if there is data
			        if (args == null || (args.cellset && args.cellset.length === 0)) {
			            return ;
			        }
	
			        var cellset = args.cellset;
			        if (cellset && cellset.length > 0) {
					/* DEBUGGING
					var start = new Date().getTime();
					this.call_time = start;
					$(this.el).prepend(" | chart process");
					*/
			            var lowest_level = 0;
			            var data_start = 0;
			            for (var row = 0; data_start == 0 && row < cellset.length; row++) {
			                    data.metadata = [];
			                    for (var field = 0; field < cellset[row].length; field++) {
			                        var firstHeader = [];
	
			                        while (cellset[row][field].type == "COLUMN_HEADER" && cellset[row][field].value == "null") {
			                            row++;
			                        }
			                        if (cellset[row][field].type == "ROW_HEADER_HEADER") {
	
			                            while(cellset[row][field].type == "ROW_HEADER_HEADER") {
			                                firstHeader.push(cellset[row][field].value);
			                                field++;
			                            }
	
			                            data.metadata.push({
			                                colIndex: 0,
			                                colType: "String",
			                                colName: firstHeader.join('/')
			                            });    
			                            lowest_level = field - 1;
			                        }
			                        if (cellset[row][field].type == "COLUMN_HEADER" && cellset[row][field].value != "null") {
			                            var lowest_col_header = 0;
			                            var colheader = [];
			                            while(lowest_col_header <= row) {
			                                colheader.push(cellset[lowest_col_header][field].value);
			                                lowest_col_header++;
			                            }
			                            data.metadata.push({
			                                colIndex: field - lowest_level + 1,
			                                colType: "Numeric",
			                                colName: colheader.join('/')
			                            });
										data.category.push(colheader.join('/'));
										
	
			                            data_start = row+1;
			                        }
			                    }
			            }
			            var labelsSet = {};
			            for (var row = data_start; row < cellset.length; row++) {
			            if (cellset[row][0].value !== "") {
			                    var record = [];
								var serie ={};
								serie.data=[];
			                    data.width = cellset[row].length - lowest_level + 1;
			                    var label = "";
			                    for (var labelCol = lowest_level; labelCol >= 0; labelCol--) {
			                        var lastKnownUpperLevelRow = row;
			                        while(cellset[lastKnownUpperLevelRow] && cellset[lastKnownUpperLevelRow][labelCol].value === 'null') {
			                            --lastKnownUpperLevelRow;
			                        }
			                        if(cellset[lastKnownUpperLevelRow]) {
			                            if (label == "") {
			                                label = cellset[lastKnownUpperLevelRow][labelCol].value;
			                            } else {
			                                label = cellset[lastKnownUpperLevelRow][labelCol].value + " / " + label;
			                            }
			                        }
			                    }
			                    if(label in labelsSet) {
			                        labelsSet[label] = labelsSet[label]+1;
			                        label = label + ' [' + (labelsSet[label] + 1) + ']';
			                    } else {
			                        labelsSet[label] = 0;
			                    }
			                    record.push(label);
								data.legend.push(label);
								serie.name=label;
			                    for (var col = lowest_level + 1; col < cellset[row].length; col++) {
			                        var cell = cellset[row][col];
			                        var value = cell.value || 0;
			                        // check if the resultset contains the raw value, if not try to parse the given value
			                        var raw = cell.properties.raw;
			                        if (raw && raw !== "null") {
			                            value = parseFloat(raw);
			                        } else if (typeof(cell.value) !== "number" && parseFloat(cell.value.replace(/[^a-zA-Z 0-9.]+/g,''))) {
			                            value = parseFloat(cell.value.replace(/[^a-zA-Z 0-9.]+/g,''));
			                        }
			                        record.push(value);
									serie.data.push(value);
			                    }
			                    data.resultset.push(record);
								data.series.push(serie);
			                }
			            }
			            data.height = data.resultset.length;
			        }
					return data;
			    },
				executeQuery:function(file,widgetId,type){
					var url = '<%=userName%>/repository2/resource/?type=saiku';
					$.get(
						"/saiku/rest/saiku/" + url,
						{file : file},
						function(data, status) {
							var xml = data;
							//çæuuidé£ä¸ªä¸²
							var uuid = 'xxxxxxxx-xxxx-xxxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, 
								function (c) {
									var r = Math.random() * 16 | 0,
									v = c == 'x' ? r : (r & 0x3 | 0x8);
									return v.toString(16);
								}).toUpperCase();
							//æ°å»ºæ¥è¯¢
							var postUrl = '<%=userName%>/query/' + uuid;
							$.post(
								"/saiku/rest/saiku/" + postUrl,
								{
									xml : xml
								},
								function(data, status){
									//æ§è¡æ¥è¯¢
									var url = '<%=userName%>/query/' + uuid + '/result/flattened?limit=0';
									$.get(
										"/saiku/rest/saiku/" + url,
										{},
										function(data, status) {

											if(type=="table"){
												var html=solidbi.process_htmlData(data);
												$("#"+widgetId).html(html);
											}else{
												var chartData=solidbi.process_chartdata(data,type);
												solidbi.showEcharts(widgetId,type,chartData);
											}
											
										},
										"json"
									);
									
								},
								"json"
							);
						},
						"text"
					);
					
				},
				createDashboard : function(widgetCount){
					this.widgetMaxId=0;
					this.dashboard=[];
					for(var i=0;i<widgetCount;i++){
						this.addWidget(false);
					}
					this.initDashboard();
				},
				addWidget:function(refresh){
					var widget={id:null,name:null,group:null,source:null,type:null,width:this.widgetWidth,height:this.widgetHeight};
					var newId=this.getNewId();
					widget.id=this.widgetIdPrefix+newId;
					widget.name=this.widgetPrefix+newId;
					widget.group=widget.name;
					this.dashboard.push(widget);
					if(refresh){
						this.initDashboard();	
					}
				},
				removeWidget:function(widgetId){
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widgetId){
							solidbi.dashboard.splice(i,1);
							this.initDashboard();
							return;
						}
					}
					
				},
				forwardWidget:function(widgetId){
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widgetId){
							if(i>0){
								solidbi.dashboard[i] = solidbi.dashboard.splice(i-1, 1, solidbi.dashboard[i])[0];
							}
							 
							this.initDashboard();
							return;
						}
					}
					
				},
				getNewId:function(){
					this.widgetMaxId++;
					return this.widgetMaxId;
				},
				initDashboard:function(){
					$(this.filterItems).empty();
					$(this.biwall).empty();
					var widgetCount=this.dashboard.length;
					var groups=[];
					var filterHtml="<a class='easyui-linkbutton' data-options=\"iconCls:'icon-filter' ,onClick:function(){solidbi.freewall.unFilter();}\">全部</a>";
					//$(this.filterItems).append(filterAllItem);

					for(var i=0;i<widgetCount;i++){
						var widget=$("<div class='widget'></div>");
						widget.css("width",this.dashboard[i].width);
						widget.css("height",this.dashboard[i].height);
						//widget.css("border","0.05cm groove pink");
						widget.addClass(this.dashboard[i].group);

						var content=$("<div class='easyui-panel' data-options=\"tools:[{iconCls:'icon-back',handler:function(){solidbi.forwardWidget('"+this.dashboard[i].id+"');}},{iconCls:'icon-edit',handler:function(){solidbi.configWidget('"+this.dashboard[i].id+"');}},{iconCls:'icon-no',handler:function(){solidbi.removeWidget('"+this.dashboard[i].id+"');}}]\"></div>");
						content.css("width",this.dashboard[i].width-5);
						content.css("height",this.dashboard[i].height-5);
						content.attr("id",this.dashboard[i].id);
						content.attr("title",this.dashboard[i].name);
						
						widget.append(content);
						
						$(this.biwall).append(widget);
						$.parser.parse(widget);
						if(this.dashboard[i].source!=null&&this.dashboard[i].source!=""){
							solidbi.executeQuery(this.dashboard[i].source,this.dashboard[i].id,this.dashboard[i].type);
						}
						if($.inArray(this.dashboard[i].group, groups)==-1){
							groups.push(this.dashboard[i].group);
							var filterHtml=filterHtml+"&nbsp;&nbsp;<a href='#' class='easyui-linkbutton' data-options=\"iconCls:'icon-filter',onClick:function(){ solidbi.freewall.filter('."+this.dashboard[i].group+"');}\">"+this.dashboard[i].group+"</a>";
							//$(this.filterItems).append(filterItem);
						}
					}
					$(this.filterItems).html(filterHtml);
					$.parser.parse(this.filterItems);
					var wall= new Freewall(this.biwall);
					wall.reset({
						selector: '.widget',
						animate: true,
						cellW: 10,
						cellH: 10,
						fixSize: 0,
						onResize: function() {
							wall.refresh();
						}
					});
					$(".filter-label").click(function() {
						$(".filter-label").removeClass("active");
						var filter = $(this).addClass('active').data('filter');
						if (filter) {
							wall.filter(filter);
						} else {
							wall.unFilter();
						}
					});

					wall.fitWidth();
					solidbi.freewall=wall;
				},
				configWidget:function(widgetId){
					$("#widgetConfigDlg").dialog("open");
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widgetId){
							$("#widgetConfigForm").form("load",solidbi.dashboard[i]);
							return;
						}
					}
					
					
				},
				saveWidgetConfig:function(dialog,form){
					var widget=this.serializeJson(form);
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widget.id){
							solidbi.dashboard[i]=widget;
							break;
						}
					}
					$(dialog).dialog(close);
					this.initDashboard();
				},
				serializeJson:function(form){
					var formObj=$(form);
					var serializeObj={};  
					var array=formObj.serializeArray();  
					$(array).each(function(){  
						if(serializeObj[this.name]){  
							if($.isArray(serializeObj[this.name])){  
								serializeObj[this.name].push(this.value);  
							}else{  
								serializeObj[this.name]=[serializeObj[this.name],this.value];  
							}  
						}else{  
							serializeObj[this.name]=this.value;   
						}  
					});  
					return serializeObj;  
				},
				cancelForm:function(dialog,form){
					$(form).form("reset");
					$(dialog).dialog("close");
				},
				process_htmlData:function(arg) {
					var data=arg.cellset;
					var contents = "";
					var table = data ? data : [];
					var colSpan;
					var colValue;
					var isHeaderLowestLvl;
					var isBody = false;
					var firstColumn;
					var isLastColumn, isLastRow;
					var nextHeader;
					var processedRowHeader = false;
					var lowestRowLvl = 0;
					var rowGroups = [];

					for (var row = 0; row < table.length; row++) {
						colSpan = 1;
						colValue = "";
						isHeaderLowestLvl = false;
						isLastColumn = false;
						isLastRow = false;
						headerStarted = false;

						contents += "<tr>";
						
						for (var col = 0; col < table[row].length; col++) {
							var header = data[row][col];

							// If the cell is a column header and is null (top left of table)
							if (header.type === "COLUMN_HEADER" && header.value === "null" && (firstColumn == null || col < firstColumn)) {
								contents += '<th class="all_null"><div>&nbsp;</div></th>';
							} // If the cell is a column header and isn't null (column header of table)
							else if (header.type === "COLUMN_HEADER") {
								if (firstColumn == null) {
									firstColumn = col;
								}
								if (table[row].length == col+1)
									isLastColumn = true;
								else
									nextHeader = data[row][col+1];


								if (isLastColumn) {
									// Last column in a row....
									contents += '<th class="col" style="text-align: center;" colspan="' + colSpan + '" title="' + header.value + '"><div rel="' + row + ":" + col +'">' + header.value + '</div></th>';
								} else {
									// All the rest...
									var groupChange = (col > 1 && row > 1 && !isHeaderLowestLvl && col > firstColumn) ?
										data[row-1][col+1].value != data[row-1][col].value
										: false;
									var maxColspan = colSpan > 999 ? true : false;
									if (header.value != nextHeader.value || isHeaderLowestLvl || groupChange || maxColspan) {
										if (header.value == "null") {
											contents += '<th class="col_null" colspan="' + colSpan + '"><div>&nbsp;</div></th>';
										} else {
											contents += '<th class="col" style="text-align: center;" colspan="' + (colSpan == 0 ? 1 : colSpan) + '" title="' + header.value + '"><div rel="' + row + ":" + col +'">' + header.value + '</div></th>';
										}
										colSpan = 1;
									} else {
										colSpan++;
									}
								}
							} // If the cell is a row header and is null (grouped row header)
							else if (header.type === "ROW_HEADER" && header.value === "null") {
								contents += '<th class="row_null"><div>&nbsp;</div></th>';
							} // If the cell is a row header and isn't null (last row header)
							else if (header.type === "ROW_HEADER") {
								if (lowestRowLvl == col)
									isHeaderLowestLvl = true;
								else
									nextHeader = data[row][col+1];

								var previousRow = data[row - 1];

								var same = !isHeaderLowestLvl && (col == 0 || previousRow[col-1].value == data[row][col-1].value) && header.value === previousRow[col].value;
								var value = (same ? "<div>&nbsp;</div>" : '<div rel="' + row + ":" + col +'">' + header.value + '</div>');
								var cssclass = (same ? "row_null" : "row");
								var colspan = 0;

								if (!isHeaderLowestLvl && (typeof nextHeader == "undefined" || nextHeader.value === "null")) {
									colspan = 1;
									var group = header.properties.dimension;
									var level = header.properties.level;
									var groupWidth = (group in rowGroups ? rowGroups[group].length - rowGroups[group].indexOf(level) : 1);
									for (var k = col + 1; colspan < groupWidth && k <= (lowestRowLvl+1) && data[row][k] !== "null"; k++) {
										colspan = k - col;
									}
									col = col + colspan -1;
								}
								contents += '<th class="' + cssclass + '" ' + (colspan > 0 ? ' colspan="' + colspan + '"' : "") + '>' + value + '</th>';
							}
							else if (header.type === "ROW_HEADER_HEADER") {
								contents += '<th class="row_header"><div>' + header.value + '</div></th>';
								isHeaderLowestLvl = true;
								processedRowHeader = true;
								lowestRowLvl = col;
								if (header.properties.hasOwnProperty("dimension")) {
									var group = header.properties.dimension;
									if (!(group in rowGroups)) {
										rowGroups[group] = [];
									}
									rowGroups[group].push(header.properties.level);
								}
							} // If the cell is a normal data cell
							else if (header.type === "DATA_CELL") {
								var color = "";
								var val = header.value;
								var arrow = "";
								if (header.properties.hasOwnProperty('image')) {
									var img_height = header.properties.hasOwnProperty('image_height') ? " height='" + header.properties.image_height + "'" : "";
									var img_width = header.properties.hasOwnProperty('image_width') ? " width='" + header.properties.image_width + "'" : "";
									val = "<img " + img_height + " " + img_width + " style='padding-left: 5px' src='" + header.properties.image + "' border='0'>";
								}

								if (header.properties.hasOwnProperty('style')) {
									color = " style='background-color: " + header.properties.style + "' ";
								}
								if (header.properties.hasOwnProperty('link')) {
									val = "<a target='__blank' href='" + header.properties.link + "'>" + val + "</a>";
								}
								if (header.properties.hasOwnProperty('arrow')) {
									arrow = "<img height='10' width='10' style='padding-left: 5px' src='/images/arrow-" + header.properties.arrow + ".gif' border='0'>";
								}

								contents += '<td class="data" ' + color + '><div alt="' + header.properties.raw + '" rel="' + header.properties.position + '">' + val + arrow + '</div></td>';
							}
						}
						contents += "</tr>";
						
					}
					var table="<div class='workspace_results'><table>"+contents+"</table></div>";
					return table;
				}
			
			};
			$(function() {
				var setting = {
					view: {
						selectedMulti: false
					},
					edit: {
						enable: true,
						showRemoveBtn: false,
						showRenameBtn: false
					},
					data:{
						key:{
							children:"repoObjects",
							name:"name"
						}
					},
					callback: {
						onDrop: function(event, treeId, treeNodes, targetNode, moveType){
							for(var i=0;i<solidbi.dashboard.length;i++){
								if(solidbi.dashboard[i].id==event.target.id){
									solidbi.dashboard[i].source=treeNodes[0].path;
									solidbi.dashboard[i].type="bar";
								}
							}
							solidbi.executeQuery(treeNodes[0].path,event.target.id,"bar");
							
							
						}
					}
				};
				
				$.post("/saiku/rest/saiku/session", {"username":"<%=userName%>","password":"<%=password%>"}, function(data) {
					if (data) {
						$.get("/saiku/rest/saiku/admin/repository2/", {"type":"saiku"}, function(data) {
							if (data) {
								$.fn.zTree.init($("#tree"), setting, data);

							} else {
								$.messager.alert("错误", "查询saiku资源时出现系统错误!", "error");
							}
							$.messager.progress("close");
						}, "json");
	
					} else {
						$.messager.alert("错误", "自动登录时出现系统错误!", "error");
					}
					$.messager.progress("close");
				}, "xml");
					
				
				
				
				solidbi.filterItems="#filterItems";
				solidbi.biwall="#freewall";
				
				
			});
			
			
		</script>
	<div id="widgetConfigDlg" class="easyui-dialog" title="配置窗体"
		style="width: 400px; height: 300px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#dlg-buttons'">
		<form id="widgetConfigForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 10px 0 10px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>名称:</td>
					<td><input name="name" class="easyui-textbox"
						data-options="required:true" style="width: 200px"></td>
				</tr>
				<tr>
					<td>组名:</td>
					<td><input name="group" class="easyui-textbox"
						data-options="required:true" style="width: 200px"></td>
				</tr>
				<tr>
					<td>类型:</td>
					<td><select name="type" class="easyui-combobox"
						style="width: 200px;">
							<option value="table">表格</option>
							<option value="bar">柱状图</option>
							<option value="line">折线图</option>

					</select></td>
				</tr>
				<tr>
					<td>宽度:</td>
					<td><input name="width" class="easyui-numberspinner"
						style="width: 100px;" required="required"
						data-options="min:100,max:1000,increment:50,editable:false">
					</td>
				</tr>
				<tr>
					<td>高度:</td>
					<td><input name="height" class="easyui-numberspinner"
						style="width: 100px;" required="required"
						data-options="min:100,max:1000,increment:50,editable:false">
					</td>
				</tr>
			</table>
		</form>
		<div id="dlg-buttons">
			<a
				onclick="solidbi.saveWidgetConfig('#widgetConfigDlg','#widgetConfigForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#widgetConfigDlg','#widgetConfigForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="newDashboardDlg" class="easyui-dialog" title="新建仪表板"
		style="width: 250px; height: 120px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#dashboardDlg-buttons'">
		<form id="newDashboardForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 1px 0 1px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>窗格数:</td>
					<td><input id="widgetCount" name="widgetCount"
						class="easyui-numberspinner" style="width: 100px;"
						required="required"
						data-options="min:1,max:20,increment:1,editable:false"></td>
				</tr>
			</table>
		</form>
		<div id="dashboardDlg-buttons">
			<a
				onclick="solidbi.createDashboard($('#widgetCount').numberspinner('getValue'));solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
	<div id="saveDashboardDlg" class="easyui-dialog" title="保存仪表板"
		style="width: 250px; height: 120px;"
		data-options="iconCls:'icon-save',closed:true,modal:true,buttons:'#dashboardDlg-buttons'">
		<form id="saveDashboardForm">
			<input type="hidden" name="id" /> <input type="hidden" name="source" />
			<table
				style="padding: 1px 0 1px 20px; border-collapse: separate; border-spacing: 10px;">
				<tr>
					<td>名称:</td>
					<td><input id="dashboardName" name="dashboardName"
						class="easyui-textbox" style="width: 200px;"
						data-options="required:true"></td>
				</tr>
			</table>
		</form>
		<div id="dashboardDlg-buttons">
			<a
				onclick="saveDashboard($('#dashboardName').textbox('getValue'));solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a> <a
				onclick="solidbi.cancelForm('#newDashboardDlg','#newDashboardForm');"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
	</div>
</body>
</html>
