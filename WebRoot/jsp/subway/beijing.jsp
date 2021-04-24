<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp" />
<link type="text/css" rel="stylesheet" href="js/subway/jquery.range.css" />
<script src="js/subway/twaver.js"></script>
<script src="js/subway/Util.js"></script>
<script src="js/subway/subway.js"></script>
<script src="js/subway/jquery.range.js"></script>
<script type="text/javascript">
var timeID,timeArray=['02:00','02:30','03:00','03:30','04:00','04:30','05:00','05:30','06:00','06:30','07:00','07:30','08:00','08:30','09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00','22:30','23:00','23:30','次日00:00','次日00:30','次日01:00','次日01:30','次日02:00'];
var stationData,duanmianData,limitData;

function getScale(array,step){
			var newArray = new Array();
			for(var i=0;i<array.length;i++){
				if(i%step==0){
					newArray.push(array[i]);
				}
			}
			return newArray;
	 }
$(function(){
	
	$('.single-slider').jRange({
		    from:0,
		    to:48,
		    step: 1,
			scale:getScale(timeArray,2),
		    format: function(value,type){
				return timeArray[value]},
		    width:1200,
			theme:'theme-green',
		    showLabels: false,
			ondragend :function (value){
					//$('#timeShow').val(timeArray[value]);
					drawMap(timeArray[value]);

				},
			onbarclicked:function (value){
					//$('#timeShow').val(timeArray[value]);
					drawMap(timeArray[value]);

				},
		    snap: true
		});

	twaver.AlarmSeverity.GREEN = twaver.AlarmSeverity.add(-1,'Green','G',"#00FF00");
	

	Util.init();
    //registerObj();
    Util.registerImage();					
    initNetwork();
    //initTable();
    initLegend();
    initNode(); 
    drawMap();
	
		 
		  
	});	

function getData(all,time){
		var datetime='2017-01-18 '+time+':00';
		var data= new Array();
		if(all==null)return data;
			for(var i=0;i<all.length;i++){
				if(all[i].sectionBegin==datetime){
					data.push(all[i]);
				}
			}
			return data;
		}
function getDateStr(myDate){
var year=myDate.getFullYear(); //获取完整的年份(4位,1970-????)
var month=myDate.getMonth()+1; //获取当前月份(0-11,0代表1月)
var day=myDate.getDate(); //获取当前日(1-31)
return year+'-'+month+'-'+day;
}
function drawMap(time){
var myDate = new Date();//获取系统当前时间
var hour=myDate.getHours(); //获取当前小时数(0-23)
var minute=myDate.getMinutes(); //获取当前分钟数(0-59)
$.ajax({   
       type: "post",   
       url: "subway/findByAttrBizStationFluxDatetransfer.zb",   
       async:false,
       data:{'datetransferFrom':getDateStr(myDate)},
       dataType: "json",   
       success: function (data) {   
                        if(data.success){
							if(data.extData.length>0){
								//根据日期字符串转换成日期 
								var regEx = new RegExp("\\-","gi"); 
								dependedVal=data.extData[0].datetransferTo.replace(regEx,"/"); 
								milliseconds=Date.parse(dependedVal); 
								myDate.setTime(milliseconds);
							}else{
								myDate.setTime(myDate.getTime()-7*24*60*60*1000);
							
							}
							}else{
								$.messager.alert("错误","查询时出现系统错误!","error");
							}
							
                  },   
       error: function (XMLHttpRequest, textStatus, errorThrown) {   
                                         $.messager.alert("错误","查询时出现系统错误!","error");
               }   
 });  
 

var theDate=getDateStr(myDate);
myDate.setTime(myDate.getTime()+24*60*60*1000);
var theDat1e=getDateStr(myDate);

myDate.setTime(myDate.getTime()+6*24*60*60*1000);
var theDate2=getDateStr(myDate);
	if(time==null||time==undefined){
		if(minute<30){
			minute='00';
		}else{
			minute='30';
		}
		if(hour<10){
			hour='0'+hour;
		}
		time = hour+':'+minute;
		var value=timeArray.indexOf(time)
		$('.single-slider').jRange('setValue',value+"");
	}
	var datetime=theDate+' '+time+':00';
	var datetime2=theDate2+' '+time+':00';
	if(time.length>5){
		time=time.replace('次日','');
		datetime=theDate1+' '+time+':00';
	}else{
		datetime=theDate+' '+time+':00';
		datetime2=theDate2+' '+time+':00';
	}
	$.post("subway/findByAttrBizStationFluxSection.zb",{'settlementDate':theDate,'sectionTime':datetime},function(data){
			if(data.success){
				duanmian=data.extData;
				for(var i=0;i<duanmian.length;i++){
					var id=duanmian[i].stationNameBegin+"->"+duanmian[i].stationNameEnd;
					var n = box.getDataById(id);
					//告警设置
					var random = duanmian[i].sectionFluxNum;
                    if (random >= 6000 ) {
                        n.setStyle('link.color','#FF0000');
                    }else
					if (random <= 6000 && random > 3000) {
                       n.setStyle('link.color','#FFFF00');
                    }else {
                        n.setStyle('link.color','#00FF00');
                    }
				}
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	$.post("subway/findByAttrBizStationFluxLimitWeb.zb",{'isenable':1},function(data1){
	if(data1.success){
		limitData=data1.extData[0];
		$.post("subway/getStationInfo.zb",{'settlementDate':theDate2,'sectionTime':datetime2},function(data){
			if(data.success){
				stationData=new Array();
				keliu=data.extData;
				for(var i=0;i<keliu.length;i++){
				var n = box.getDataById(keliu[i].stationName);
				if(n==null||n==undefined)continue;
				var random = keliu[i].stationEntry;
               	n.setClient("stationEntry",keliu[i].stationEntry);
				n.setClient("stationExit",keliu[i].stationExit);
				n.setClient("sectionBegin",keliu[i].sectionBegin);
				n.setClient("sectionEnd",keliu[i].sectionEnd);
				n.setClient('transferList',keliu[i].transfor);
				var transforNumber=0;
				for(var j=0;j<keliu[i].transfor.length;j++){
					transforNumber+=keliu[i].transfor[j].transforNum;
				}
				stationData.push({'stationName':keliu[i].stationName,
					'stationEntry':keliu[i].stationEntry,
					'stationEntryCardinal':keliu[i].stationEntryCardinal,
					'stationExit':keliu[i].stationExit,
					'stationExitCardinal':keliu[i].stationExitCardinal,
					'stationTransfor':transforNumber,
					'stationTransforCardinal':keliu[i].stationTransforCardinal
					});
					
					
				}
				setAlarm();
			}else{
				$.messager.alert("错误","查询时出现系统错误!","error");
			}
			$.messager.progress("close");
		},"json");
	}
  },"json");
	
}
function setAlarm(){
	var entry=$('#entryCheck').is(':checked');
	var exit=$('#exitCheck').is(':checked');
	var transfor=$('#transforCheck').is(':checked');
			
	for(var i=0;i<stationData.length;i++){
		var n = box.getDataById(stationData[i].stationName);
					//告警设置
					var alarmBox=box.getAlarmBox();
					var severityValue;
					var passengerflow=0;
					var limitsafevalue=0;
					var limitwarnvalue=0;
					var limitalarmvalue=0;
					
					if(entry){
						passengerflow+=stationData[i].stationEntry;
						limitsafevalue+=stationData[i].stationEntryCardinal*limitData.stationEntrySafe/100;
						limitwarnvalue+=stationData[i].stationEntryCardinal*limitData.stationEntryWarn/100;
						limitalarmvalue+=stationData[i].stationEntryCardinal*limitData.stationEntryAlarm/100;
					}
					if(exit){
						passengerflow+=stationData[i].stationExit;
						limitsafevalue+=stationData[i].stationExitCardinal*limitData.stationExitSafe/100;
						limitwarnvalue+=stationData[i].stationExitCardinal*limitData.stationExitWarn/100;
						limitalarmvalue+=stationData[i].stationExitCardinal*limitData.stationExitAlarm/100;
					}
					if(transfor){
						passengerflow+=stationData[i].stationTransfor;
						limitsafevalue+=stationData[i].stationTransforCardinal*limitData.stationTransforSafe/100;
						limitwarnvalue+=stationData[i].stationTransforCardinal*limitData.stationTransforWarn/100;
						limitalarmvalue+=stationData[i].stationTransforCardinal*limitData.stationTransforAlarm/100;
					} 
					
					console.log('站点：'+stationData[i].stationName);
					console.log('客流：'+passengerflow);
					console.log('正常：'+limitsafevalue);
					console.log('警示：'+limitwarnvalue);
					console.log('告警：'+limitalarmvalue);
					
					if (passengerflow > limitwarnvalue ) {
                        severityValue=twaver.AlarmSeverity.CRITICAL;
						if(passengerflow > limitwarnvalue+(limitalarmvalue-limitwarnvalue)/3*2 ){
							n.setImage('station1');
						}else
							if(passengerflow > limitwarnvalue+(limitalarmvalue-limitwarnvalue)/3*1){
							n.setImage('station2');
						}else{
							n.setImage('station3');
						}
                    }else
					if (passengerflow > limitsafevalue) {
                        severityValue=twaver.AlarmSeverity.MINOR;
						if(passengerflow > limitsafevalue+(limitwarnvalue-limitsafevalue)/3*2){
							n.setImage('station4');
						}else
							if(passengerflow > limitsafevalue+(limitwarnvalue-limitsafevalue)/3*1){
							n.setImage('station5');
						}else{
							n.setImage('station6');
						}
						
                    }else {
                        severityValue=twaver.AlarmSeverity.GREEN;
						if(passengerflow > limitsafevalue+limitsafevalue/3*2){
							n.setImage('station7');
						}else
							if(passengerflow > limitsafevalue+limitsafevalue/3*1){
							n.setImage('station8');
						}else{
							n.setImage('station');
						}
                    }
					var alarm = alarmBox.getDataById("alarm" + n.getId());
					if(alarm){
						alarm.setAlarmSeverity(severityValue);
					}else{
						alarm=new twaver.Alarm("alarm" + n.getId(), n.getId(), severityValue);
						
						alarm.setAcked(true);
						alarmBox.add(alarm);
					}
		}	
}

$(document).ready(function() {
	$('#button1').click(function() {
		$('#tb1').toggle(1000);
	});
	$('#button2').click(function() {
		$('#tb1').hide(1000);
	});
	$('#button2').click(function() {
		$('#tb2').toggle(1000);
	});
	$('#button1').click(function() {
		$('#tb2').hide(1000);
	});
})
</script>
</head>
<body>
<div id="toolbar" style="position:absolute;left:100px;top:1050px;width:1024px;height:50px">
		<table>
		<tr height=50>
			<td width="60" height="30" valign="bottom" align="left"><!--input id="runBt" type="button" value="播放"/--></td>
			<td colspan="2"><input type="hidden" value="" class="single-slider none">
		</td></tr>
		<tr><td></td>
		<td style="color:#FFFFFF" width="150px">
			<input  id="entryCheck" checked="checked" type=checkbox onclick="setAlarm()" />进站
		<input id="exitCheck"  type=checkbox checked="checked" onclick="setAlarm()" />出站
		<input id="transforCheck"  type=checkbox checked="checked" onclick="setAlarm()" />换乘</td>

			<td align="left" height="30">
				<a id="button1" style="color:#FFFFFF;font-size: 10px; text-align: center;" >TOP10</a>&nbsp;&nbsp;
				<a id="button2" style="color:#FFFFFF;font-size: 10px;  text-align: center;" >进出站量</a>
			</td>
		</tr>
		</table>
			<div id="tb1" style="display:none; background-color: white;height:260px;width:300px; float: right;">
				<iframe id='1' src='<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() %>/solidbi/reportJsp/indexReport.jsp?rpx=subway/top10.rpx' style='border: 0px' height='260' width='300' scrolling='no' allowTransparency="true" frameborder='0'></iframe>
			</div>
			<div id="tb2" style="display:none; background-color: white;height:260px;width:500px; float: right;">
				<iframe id='2' src='<%=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() %>/solidbi/reportJsp/indexReport.jsp?rpx=subway/jinchuzhan.rpx' style='border: 0px' height='260' width='500' scrolling='no' allowTransparency="true" frameborder='0'></iframe>
			</div>
	</div>	
    
</body>
</html>