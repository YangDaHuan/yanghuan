var solidbi	= {
				edit:true,
				user:"admin",
				filterItems:null,
				biWall:null,
				freewall:null,
				widgetIdPrefix:"widget_",
				widgetWidth:400,
				widgetHeight:300,
				dashboard:[],
				dashboardName:null,
				dashboardId:null,
				clean:function(){
					this.widgetMaxId=0;
					this.dashboard=[];
					this.dashboardName=null;
					this.dashboardId=null;
					this.initDashboard();
				},
				showEcharts:function(div,chartType,data,file){
					var myChart = echarts.init(document.getElementById(div));
					var option = this.process_chartOption(data,chartType);
					myChart.setOption(option);
					myChart.on('click', function (params) {
					    // 控制台打印数据的名称
						//alert(file);
						$("#menuList li",parent.parent.document).removeClass("active");
						$("#000773062f00437cba9f6390432170cd",parent.parent.document).addClass("active");
						var id='000773062f00437cba9f6390432170cd';
						var url='olap/index.jsp';
							$('.tab-body-child',parent.parent.document).hide();
							if($("#"+id+"-main",parent.parent.document).length==0){
								var iframe='<iframe name="frame_000773062f00437cba9f6390432170cd" src="'+url+'" frameborder="0" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" style="width:100%;height:100%;"></iframe>';
								$('#tab-body',parent.parent.document).append("<div id='"+id+"-main' class='tab-body-child'>"+iframe+"</div>");
								$("iframe[name*='frame_000773062f00437cba9f6390432170cd'",parent.parent.document).load(function(){   
									parent.parent.frame_000773062f00437cba9f6390432170cd.openQuery(file);
									$("#"+id+"-main",parent.parent.document).show();  
							    }); 
							}else{
								parent.parent.frame_000773062f00437cba9f6390432170cd.openQuery(file);
								$("#"+id+"-main",parent.parent.document).show(); 
							}
							
							
							
						//window.open("olap/index.jsp?saikuPath="+file);
					});
				},
				process_chartOption:function(args,type,mapType){
					
					var option={};
					var data = this.process_data(args);
					if(typeof(mapType)=="undefined")mapType="china";
					var option={};
					if(type=="bar"||type=="line"){
						option.legend={data:[]};
						option.xAxis = [{type : 'category',data : []}];
						option.yAxis = [{type : 'value'}];
						option.series=[];
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:type,data:[]};
							if(data.metadata[col].colType=="Numeric"){
								option.legend.data.push(data.metadata[col].colName);
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
						
							for(var row=0;row<data.resultset.length;row++){
								if(data_start){
									serie.data.push(data.resultset[row][col]);
								}else{
									option.xAxis[0].data.push(data.resultset[row][col]);
								}
							}
							if(data_start){
								option.series.push(serie);
							}
							
						}
						

					}else
					if(type=="area"){
						option.legend={data:[]};
						option.xAxis = [{type : 'category',boundaryGap : false,data : []}];
						option.yAxis = [{type : 'value'}];
						option.tooltip={trigger:'axis'};
						
						option.calculable = true;
						option.series=[];
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:"line",stack:'堆积',itemStyle: {normal: {areaStyle: {type: 'default'}}},data:[]};
							if(data.metadata[col].colType=="Numeric"){
								option.legend.data.push(data.metadata[col].colName);
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
						
							for(var row=0;row<data.resultset.length;row++){
								if(data_start){
									serie.data.push(data.resultset[row][col]);
								}else{
									option.xAxis[0].data.push(data.resultset[row][col]);
								}
							}
							if(data_start){
								option.series.push(serie);
							}
							
						}
				                      
						
					}else
					if(type=="pie"){
						var legendData=[];
						var series=[];
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:'pie',data:[],itemStyle:{ 
				                            normal:{ 
				                                label:{ 
				                                   show: false, 
				                                   formatter: '{b} : {c} ({d}%)' 
				                                }, 
				                                labelLine :{show:false}
				                            } 
				                        },radius : ["20%","60%"],
									center: ['50%', '60%'],
									};
							if(data.metadata[col].colType=="Numeric"){
								
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
							
							for(var row=0;row<data.resultset.length;row++){
								if(data_start){
									var pieData={};
									pieData.name=legendData[row];
									pieData.value=data.resultset[row][col];
									serie.data.push(pieData);
								}else{
									legendData.push(data.resultset[row][col]);
								}
							}
							if(data_start){
								series.push(serie);
								break;
							}
							
							
						}
						option = {
							 title : {
								text: series[0].name,
								x:'center'
							},
							tooltip : {
								trigger: 'item',
								formatter: "{a} <br/>{b} : {c} ({d}%)"
							},
							legend: {
								orient : 'vertical',
								x : 'left',
								data:legendData
							},
							calculable : true,
							series : series
						};  
						
					}else
					if(type=="radar"){
						var legendData=[];
						var indicator=[];
						var series=[];
						series[0]={type:'radar',data:[]};
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:type,data:[]};
							if(data.metadata[col].colType=="Numeric"){
								legendData.push(data.metadata[col].colName);

								series[0].data.push({name:data.metadata[col].colName,value:[]});
								data_start=true;
							}
							
							for(var row=0;row<data.resultset.length;row++){
								if(data_start){
									series[0].data[series[0].data.length-1].value.push(data.resultset[row][col]);
									if(indicator[row].max==null || data.resultset[row][col]>indicator[row].max){
										indicator[row].max=data.resultset[row][col];
									}
								}else{
									indicator.push({text : data.resultset[row][col],max:null});
								}
							}
							
							
						}
						option = {
							tooltip : {
								trigger: 'axis'
							},
							legend: {
								orient : 'vertical',
								x : 'right',
								y : 'bottom',
								data:legendData
							},
							polar : [
							   {
								   indicator :indicator
								}
							],
							calculable : true,
							series : series
						};
											
					}else
					if(type=="scatter"){
						if(data.resultset.length<2){
							alert('散点图至少需要2行数据');
							return null;
						}
						option.legend={data:[]};
						option.xAxis = [{type : 'value',splitNumber:4,scale:true}];
						option.yAxis = [{type : 'value',scale:true}];
						option.tooltip = {
							trigger: 'axis',
							showDelay : 0,
							axisPointer:{
								type : 'cross',
								lineStyle: {
									type : 'dashed',
									width : 1
								}
							}
						};
						
						option.series=[];
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:'scatter',data:[],symbolSize:8,tooltip : {
										trigger: 'item',
										formatter : function (params) {
											if (params.value.length > 1) {
												return params.seriesName + ' :<br/>'
												   +data.resultset[0][0]+" : "+ params.value[0] + '<br/>'
												   +data.resultset[1][0]+" : "+ params.value[1];
											}
										}
									}};
							if(data.metadata[col].colType=="Numeric"){
								option.legend.data.push(data.metadata[col].colName);
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
							if(data_start){
								var d1=[];
								d1.push(data.resultset[0][col]);
								d1.push(data.resultset[1][col]);
								serie.data.push(d1);
								option.series.push(serie);
							}
							
						}

						
						
					}else
					if(type=="bubble"){
				         if(data.resultset.length<3){
							alert('气泡图至少需要3行数据');
							return null;
						}
						var legendData=[];
						var series=[];
						var maxsymbolSize;
						for(var col=0;col<data.metadata.length;col++){
							if(data.metadata[col].colType=="Numeric"){
								if(typeof(maxsymbolSize)=="undefined"){ 
									maxsymbolSize=data.resultset[2][col];
								}
								 if(data.resultset[2][col] > maxsymbolSize){
										maxsymbolSize=data.resultset[2][col];
								 }
							}
						}
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:'scatter',data:[],symbol: 'circle',
										symbolSize: function (value){
											
											return value[2]/maxsymbolSize*20;
										},tooltip : {
										trigger: 'item',
										formatter : function (params) {
											if (params.value.length > 1) {
												return params.seriesName + ' :<br/>'
												   +data.resultset[0][0]+" : "+ params.value[0] + '<br/>'
												   +data.resultset[1][0]+" : "+ params.value[1] + '<br/>'
												   +data.resultset[2][0]+" : "+ params.value[2];
											}
										}
									}
									};
							if(data.metadata[col].colType=="Numeric"){
								legendData.push(data.metadata[col].colName);
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
							if(data_start){
								var d1=[];
								d1.push(data.resultset[0][col]);
								d1.push(data.resultset[1][col]);
								d1.push(data.resultset[2][col]);
								serie.data.push(d1);
								series.push(serie);
							}
							
						}
						
						option = {
							tooltip : {
								trigger: 'axis',
								showDelay : 0,
								axisPointer:{
									type : 'cross',
									lineStyle: {
										type : 'dashed',
										width : 1
									}
								}
							},
							legend: {
								data:legendData
							},
							xAxis : [
								{
									type : 'value',
									splitNumber: 4,
									scale: true
								}
							],
							yAxis : [
								{
									type : 'value',
									splitNumber: 4,
									scale: true
								}
							],
							series : series
						};
				                             
						
					}else
					if(type=="map"){
						var legendData=[];
						var maxValue=null;
						var minValue=null;
						var citys=[];
						var series=[];
						for(var col=0;col<data.metadata.length;col++){
							var data_start=false;
							var serie={type:'map',mapType: mapType,
				            roam: false,
				            itemStyle:{
				                normal:{label:{show:true}},
				                emphasis:{label:{show:true}}
				            },data:[]};
							if(data.metadata[col].colType=="Numeric"){
								legendData.push(data.metadata[col].colName);
								serie.name=data.metadata[col].colName;
								data_start=true;
							}
							var cityValue=0;
							for(var row=0;row<data.resultset.length;row++){
								if(data_start){
									serie.data.push({name:citys[row],value:data.resultset[row][col]});
									cityValue=cityValue+data.resultset[row][col];
								}else{
									citys.push(data.resultset[row][col]);
								}
							}
							if(maxValue==null||maxValue<cityValue){
								maxValue=cityValue;
							}
							if(minValue==null||minValue>cityValue){
								minValue=cityValue;
							}

							if(data_start){
								series.push(serie);
							}
							
						}
						option = {
				    tooltip : {
				        trigger: 'item'
				    },
				    legend: {
				        orient: 'vertical',
				        x:'left',
				        data:legendData
				    },
				    dataRange: {
				        min: minValue,
				        max: maxValue,
				        x: 'left',
				        y: 'bottom',
				        text:['高','低'],           // 文本，默认为数值文本
				        calculable : true
				    },
				    series : series
				};
				                    
					
					}
					return option;

				},
				process_data:function(args) {
					var data = {};
					
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
							}
						}
						data.height = data.resultset.length;
					}
					return data;
				},
				executeQuery:function(file,widgetId,type){
					var _this=this;
					var url = this.user+'/repository2/resource/?type=saiku';
					$.get(
						"/saiku/rest/saiku/" + url,
						{file : file},
						function(data, status) {
							var xml = data;
							var uuid = 'xxxxxxxx-xxxx-xxxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, 
								function (c) {
									var r = Math.random() * 16 | 0,
									v = c == 'x' ? r : (r & 0x3 | 0x8);
									return v.toString(16);
								}).toUpperCase();
							var postUrl = _this.user+'/query/' + uuid;
							$.post(
								"/saiku/rest/saiku/" + postUrl,
								{
									xml : xml
								},
								function(data, status){
									//æ§è¡æ¥è¯¢
									var url = _this.user+'/query/' + uuid + '/result/flattened?limit=0';
									$.get(
										"/saiku/rest/saiku/" + url,
										{},
										function(data, status) {

											if(type=="table"){
												var html=_this.process_htmlData(data);
												$("#"+widgetId).html(html);
											}else{
												_this.showEcharts(widgetId,type,data,file);
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
					this.clean();
					var ids=this.getNewId(this.widgetIdPrefix,widgetCount);
					for(var i=0;i<widgetCount;i++){
						this.addWidget(false,ids[i]);
					}
					this.initDashboard();
				},
				addWidget:function(refresh,id){
					if(this.freewall==null||typeof this.freewall=="undefined"){
						alert("请新建仪表板后添加窗格");
						return;
					}
					if(id==null||typeof(id)=='undefinded')id=this.getNewId(this.widgetIdPrefix,1);
					var widget={id:null,name:null,groupName:null,source:null,type:null,width:this.widgetWidth,height:this.widgetHeight};
					widget.id=id;
					widget.name=id;
					widget.groupName=id;
					this.dashboard.push(widget);
					if(refresh){
						this.initWidget(widget)
						this.initFilterItems();
						this.freewall.refresh();	
					}
				},
				removeWidget:function(widgetId){
					var _this=this;
					$.messager.confirm("提示", "您确认要删除吗?",
							function(r) {
								if (!r) {
									return;
								}
								for(var i=0;i<_this.dashboard.length;i++){
									if(_this.dashboard[i].id==widgetId){
										$("#"+_this.dashboard[i].id).parents(".widget").remove();
										_this.dashboard.splice(i,1);
										_this.initFilterItems();
										_this.freewall.refresh();
										return;
									}
								}
					});
					
				},
				forwardWidget:function(widgetId){
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widgetId){
							if(i>0){
								var id=this.dashboard[i].id;
								var forwardId=this.dashboard[i-1].id;
								var widget=$("#"+id).parents(".widget");
								var forwardWidget=$("#"+forwardId).parents(".widget");
								widget.insertBefore(forwardWidget);
								this.dashboard[i] = this.dashboard.splice(i-1, 1, this.dashboard[i])[0];
								this.initFilterItems();
								this.freewall.refresh();
								
							}
							 
							return;
						}
					}
					
				},
				getNewId:function(prefix,count){
					var ids=[];
					for(var i=0;i<10000;i++){
						if($("#"+prefix+i).length < 1 ){
							ids.push(prefix+i);
							if(ids.length==count){
								return ids;
							}
						}
					}
				},
				openDashboard:function(){
					var _this=this;
					$.post("dashboard/getDashboardById.zb",{id:_this.dashboardId},
							function(result, status) {
								_this.dashboardName=result.name;
								_this.dashboard=result.widgets;
								_this.initDashboard();
							},
							"json"
						); 
				},
				deleteDashboard:function(){
					var _this=this;
					$.messager.confirm("提示", "您确认要删除吗?",
							function(r) {
								if (!r) {
									return;
								}
								
								$.post("dashboard/deleteDashboard.zb",{id:_this.dashboardId},
										function(result, status) {
											if(result.success){//操作成功
												_this.clean();
												$.noty.closeAll();
												var n = noty({text: "删除成功",type:"success",layout:"topCenter",timeout:1000});
											}else{//保存失败
												$.messager.alert("错误","删除数据时出现系统错误!","error");
											}							
											
										},
										"json"
									); 
								
							});
					
						
				},
				initWidget:function(widgetConfig){
					var _this=this;
					var widget;
					if($("#"+widgetConfig.id).length > 0 ){
						widget=$("#"+widgetConfig.id).parents(".widget");
					}else{
						widget=$("<div class='widget'></div>");
						
						var tools=[];
						
						
							
							tools.push({
								iconCls:'icon-back',
								handler:function(){
									_this.forwardWidget(widgetConfig.id);
								}});
							tools.push({
								iconCls:'icon-edit',
								handler:function(){
									_this.configWidget(widgetConfig.id);
								}});
							tools.push({
									iconCls:'icon-no',
									handler:function(){
										_this.removeWidget(widgetConfig.id);
									}
							});
							
							
						
						
						var content=$("<div class='easyui-panel' data-options=\"\"></div>");
						content.attr("id",widgetConfig.id);
						widget.append(content);
						
						$(_this.biwall).append(widget);
						$.parser.parse(widget);	
					}
					//widget.css("width",widgetConfig.width);
					widget.attr("data-width",widgetConfig.width);
					
					//widget.css("height",widgetConfig.height);
					widget.attr("data-height",widgetConfig.height);
					widget.removeClass();
					widget.addClass("widget "+widgetConfig.groupName);
					
					if(_this.edit){
						$("#"+widgetConfig.id).panel({"width":widgetConfig.width-5,"height":widgetConfig.height-5,"title":widgetConfig.name,"tools":tools});	
						
					}else{
						$("#"+widgetConfig.id).panel({"width":widgetConfig.width-5,"height":widgetConfig.height-5,"title":widgetConfig.name});
						
					}
					


					if(widgetConfig.source!=null&&widgetConfig.source!=""&&widgetConfig.source!="null"){
						_this.executeQuery(widgetConfig.source,widgetConfig.id,widgetConfig.type);
					}
					
				},
				initFilterItems:function(){
					var _this=this;
					$(_this.filterItems).empty();
					var filterAllItem=$("<a class='easyui-linkbutton' data-options=\"iconCls:'icon-filter'\">全部</a>");
					$(this.filterItems).append(filterAllItem);
					$.parser.parse(this.filterItems); 
					$(filterAllItem).linkbutton({    
						onClick : function(){_this.freewall.unFilter();}  
					}); 

					var groups=[]
					var widgetCount=this.dashboard.length;
					for(var i=0;i<widgetCount;i++){
						(function(i){
							if($.inArray(_this.dashboard[i].groupName, groups)==-1){
								groups.push(_this.dashboard[i].groupName);
								var filterItem=$("<a class='easyui-linkbutton' data-options=\"iconCls:'icon-filter'\">"+_this.dashboard[i].groupName+"</a>");
								$(_this.filterItems).append(filterItem);
								$.parser.parse(_this.filterItems);
								$(filterItem).linkbutton({    
									onClick : function(){
										//alert(_this.dashboard[i].groupName);
										_this.freewall.filter('.'+_this.dashboard[i].groupName);
										return false;}  
								});
							}
						})(i)
						 
					}

				},
				initDashboard:function(){
					var _this=this;
					$(this.biwall).empty();
					var widgetCount=this.dashboard.length;
					
					 


					for(var i=0;i<widgetCount;i++){
						(function(i){
							_this.initWidget(_this.dashboard[i]);
						})(i)
					}
					_this.initFilterItems();
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
					

					wall.fitWidth();
					this.freewall=wall;
				},
				configWidget:function(widgetId){
					$("#widgetConfigDlg").dialog("open");
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widgetId){
							$("#widgetConfigForm").form("load",this.dashboard[i]);
							return;
						}
					}
					
					
				},
				saveWidgetConfig:function(dialog,form){
					var widget=this.serializeJson(form);
					for(var i=0;i<this.dashboard.length;i++){
						if(this.dashboard[i].id==widget.id){
							this.dashboard[i]=widget;
							break;
						}
					}
					$(dialog).dialog(close);
					this.initWidget(widget);
					this.initFilterItems();
					this.freewall.refresh();
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
			
			