var cronEditor={
	cronExp:"* * * * * ? *",
	year:"*",
	week:"?",
	month:"*",
	day:"*",
	hour:"*",
	minute:"*",
	second:"*",

	selectYearType:function(newValue,oldValue){
		$("#cronYearRangeDiv").hide();
		$("#cronYearIntervalDiv").hide();
		$("#cronYearValueDiv").hide();
		switch(newValue){
			case "1":
				break;
			case "3":
				$("#cronYearRangeDiv").show();
				break;
			case "4":
				$("#cronYearIntervalDiv").show();
				break;
			case "5":
				$("#cronYearValueDiv").show();
				break;
		}
	},
	selectMonthType:function(newValue,oldValue){
		$("#cronMonthRangeDiv").hide();
		$("#cronMonthIntervalDiv").hide();
		$("#cronMonthValueDiv").hide();
		switch(newValue){
			case "1":
				break;
			case "3":
				$("#cronMonthRangeDiv").show();
				break;
			case "4":
				$("#cronMonthIntervalDiv").show();
				break;
			case "5":
				$("#cronMonthValueDiv").show();
				break;
		}
	},
	selectWeekType:function(newValue,oldValue){
		$("#cronWeekRangeDiv").hide();
		$("#cronWeekValueDiv").hide();
		$("#cronWeekNumberDiv").hide();
		$("#cronWeekLastDiv").hide();
		switch(newValue){
			case "1":
				$("#dayCronType").combobox("setValue","2");
				break;
			case "2":
				break;
			case "3":
				$("#dayCronType").combobox("setValue","2");
				$("#cronWeekRangeDiv").show();
				break;
			case "5":
				$("#dayCronType").combobox("setValue","2");
				$("#cronWeekValueDiv").show();
				break;
			case "6":
				$("#dayCronType").combobox("setValue","2");
				$("#cronWeekNumberDiv").show();
				break;
			case "7":
				$("#dayCronType").combobox("setValue","2");
				$("#cronWeekLastDiv").show();
				break;
		}
	},
	selectDayType:function(newValue,oldValue){
		$("#cronDayRangeDiv").hide();
		$("#cronDayIntervalDiv").hide();
		$("#cronDayValueDiv").hide();
		$("#cronDayWorkDiv").hide();
		switch(newValue){
			case "1":
				$("#weekCronType").combobox("setValue","2");
				break;
			case "2":
				break;
			case "3":
				$("#weekCronType").combobox("setValue","2");
				$("#cronDayRangeDiv").show();
				break;
			case "4":
				$("#weekCronType").combobox("setValue","2");
				$("#cronDayIntervalDiv").show();
				break;
			case "5":
				$("#weekCronType").combobox("setValue","2");
				$("#cronDayValueDiv").show();
				break;
			case "8":
				$("#weekCronType").combobox("setValue","2");
				$("#weekCronType").combobox("setValue","2");
				break;
			case "9":
				$("#weekCronType").combobox("setValue","2");
				$("#cronDayWorkDiv").show();
				break;
			case "10":
				$("#weekCronType").combobox("setValue","2");
				break;
		}
		
	},
	selectHourType:function(newValue,oldValue){
		$("#cronHourRangeDiv").hide();
		$("#cronHourIntervalDiv").hide();
		$("#cronHourValueDiv").hide();
		switch(newValue){
			case "1":
				break;
			case "3":
				$("#cronHourRangeDiv").show();
				break;
			case "4":
				$("#cronHourIntervalDiv").show();
				break;
			case "5":
				$("#cronHourValueDiv").show();
				break;
		}
	},
	selectMinuteType:function(newValue,oldValue){
		$("#cronMinuteRangeDiv").hide();
		$("#cronMinuteIntervalDiv").hide();
		$("#cronMinuteValueDiv").hide();
		switch(newValue){
			case "1":
				break;
			case "3":
				$("#cronMinuteRangeDiv").show();
				break;
			case "4":
				$("#cronMinuteIntervalDiv").show();
				break;
			case "5":
				$("#cronMinuteValueDiv").show();
				break;
		}
		
	},
	selectSecondType:function(newValue,oldValue){
		$("#cronSecondRangeDiv").hide();
		$("#cronSecondIntervalDiv").hide();
		$("#cronSecondValueDiv").hide();
		switch(newValue){
			case "1":
				break;
			case "3":
				$("#cronSecondRangeDiv").show();
				break;
			case "4":
				$("#cronSecondIntervalDiv").show();
				break;
			case "5":
				$("#cronSecondValueDiv").show();
				break;
		}
		
	},
	getCronExp:function(){
		var cronYearType=$("#yearCronType").combobox("getValue");
		switch(cronYearType){
			case "1":
				this.year="*";
				break;
			case "3":
				this.year=$("#cronYear_beginYear").numberspinner("getValue")+"-"+$("#cronYear_endYear").numberspinner("getValue");
				break;
			case "4":
				this.year=$("#cronYear_startYear").numberspinner("getValue")+"/"+$("#cronYear_countYear").numberspinner("getValue");
				break;
			case "5":
				this.year=$("#cronYear_value").combobox("getValues").join(",");
				break;
			default:
				this.year="*";
		}
		var cronMonthType=$("#monthCronType").combobox("getValue");
		switch(cronMonthType){
			case "1":
				this.month="*";
				break;
			case "3":
				this.month=$("#cronMonth_beginMonth").numberspinner("getValue")+"-"+$("#cronMonth_endMonth").numberspinner("getValue");
				break;
			case "4":
				this.month=$("#cronMonth_startMonth").numberspinner("getValue")+"/"+$("#cronMonth_countMonth").numberspinner("getValue");
				break;
			case "5":
				this.month=$("#cronMonth_value").combobox("getValues").join(",");
				break;
			default:
				this.month="*";
		}
		var cronWeekType=$("#weekCronType").combobox("getValue");
		switch(cronWeekType){
			case "1":
				this.week="*";
				break;
			case "2":
				this.week="?";
				break;
			case "3":
				this.week=$("#cronWeek_beginWeek").numberspinner("getValue")+"-"+$("#cronWeek_endWeek").numberspinner("getValue");
				break;
			case "5":
				this.week=$("#cronWeek_value").combobox("getValues").join(",");
				break;
			case "6":
				this.week=$("#cronWeek_numberValue").combobox("getValue")+"#"+$("#cronMonth_weekNumber").numberspinner("getValue");
				break;
			case "7":
				this.week=$("#cronWeek_lastValue").combobox("getValue")+"L";
				break;
			default:
				this.week="*";
		}
		var cronDayType=$("#dayCronType").combobox("getValue");
		switch(cronDayType){
			case "1":
				this.day="*";
				break;
			case "2":
				this.day="?";
				break;
			case "3":
				this.day=$("#cronDay_beginDay").numberspinner("getValue")+"-"+$("#cronDay_endDay").numberspinner("getValue");
				break;
			case "4":
				this.day=$("#cronDay_startDay").numberspinner("getValue")+"/"+$("#cronDay_countDay").numberspinner("getValue");
				break;
			case "5":
				this.day=$("#cronDay_value").combobox("getValues").join(",");;
				break;
			case "8":
				this.day="L";
				break;
			case "9":
				this.day=$("#cronDay_workDay").numberspinner("getValue")+"W";
				break;
			case "10":
				this.day="LW";
				break;
			default:
				this.day="*";
		}
		var cronHourType=$("#hourCronType").combobox("getValue");
		switch(cronHourType){
			case "1":
				this.hour="*";
				break;
			case "3":
				this.hour=$("#cronHour_beginHour").numberspinner("getValue")+"-"+$("#cronHour_endHour").numberspinner("getValue");
				break;
			case "4":
				this.hour=$("#cronHour_startHour").numberspinner("getValue")+"/"+$("#cronHour_countHour").numberspinner("getValue");
				break;
			case "5":
				this.hour=$("#cronHour_value").combobox("getValues").join(",");
				break;
			default:
				this.hour="*";
		}
		var cronMinuteType=$("#minuteCronType").combobox("getValue");
		switch(cronMinuteType){
			case "1":
				this.minute="*";
				break;
			case "3":
				this.minute=$("#cronMinute_beginMinute").numberspinner("getValue")+"-"+$("#cronMinute_endMinute").numberspinner("getValue");
				break;
			case "4":
				this.minute=$("#cronMinute_startMinute").numberspinner("getValue")+"/"+$("#cronMinute_countMinute").numberspinner("getValue");
				break;
			case "5":
				this.minute=$("#cronMinute_value").combobox("getValues").join(",");
				break;
			default:
				this.minute="*";
		}
		var cronSecondType=$("#secondCronType").combobox("getValue");
		switch(cronSecondType){
			case "1":
				this.second="*";
				break;
			case "3":
				this.second=$("#cronSecond_beginSecond").numberspinner("getValue")+"-"+$("#cronSecond_endSecond").numberspinner("getValue");
				break;
			case "4":
				this.second=$("#cronSecond_startSecond").numberspinner("getValue")+"/"+$("#cronSecond_countSecond").numberspinner("getValue");
				break;
			case "5":
				this.second=$("#cronSecond_value").combobox("getValues").join(",");
				break;
			default:
				this.second="*";
		}
		this.cronExp=this.second+" "+this.minute+" "+this.hour+" "+this.day+" "+this.month+" "+this.week+" "+this.year;
		
		return this.cronExp;
	},
	getCronType:function(exp){
		if(exp=="*"){
			return "1";
		}else
		if(exp=="?"){
			return "2";
		}else
		if(exp.indexOf("-")>-1){
			return "3";
		}else
		if(exp.indexOf("/")>-1){
			return "4";
		}else
		if(exp.indexOf("#")>-1){
			return "6";
		}else
		if(exp=="L"){
			return "8";
		}else
		if(exp.indexOf("L")>0){
			return "7";
		}else
		if(exp=="LW"){
			return "10";
		}else
		if(exp.indexOf("W")>0){
			return "9";
		}else
		{
			return "5";
		}
	},
	resolveCron:function(cronExp){
		var exps=cronExp.split(" ");
		if(exps.length<6)alert("cron表达式错误");
		this.year="*";
		if(exps[6]!=null)this.year=exps[6];

		this.month=exps[4];
		this.week=exps[5];
		this.day=exps[3];
		this.hour=exps[2];
		this.minute=exps[1];
		this.second=exps[0];
		
		var cronType=this.getCronType(this.year);
		$("#yearCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "3":
				var values=this.year.split("-");
				$("#cronYear_beginYear").numberspinner("setValue",values[0]);
				$("#cronYear_endYear").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.year.split("/");
				$("#cronYear_startYear").numberspinner("setValue",values[0]);
				$("#cronYear_countYear").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronYear_value").combobox("setValues",this.year.split(","));
				break;
		}
		cronType=this.getCronType(this.month);
		$("#monthCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "3":
				var values=this.month.split("-");
				$("#cronMonth_beginMonth").numberspinner("setValue",values[0]);
				$("#cronMonth_endMonth").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.month.split("/");
				$("#cronMonth_startMonth").numberspinner("setValue",values[0]);
				$("#cronMonth_countMonth").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronMonth_value").combobox("setValues",this.month.split(","));
				break;
			
		}
		cronType=this.getCronType(this.week);
		$("#weekCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "2":
				break;
			case "3":
				var values=this.week.split("-");
				$("#cronWeek_beginWeek").combobox("setValue",values[0]);
				$("#cronWeek_endWeek").combobox("setValue",values[1]);
				break;
			case "5":
				$("#cronWeek_value").combobox("setValues",this.week.split(","));
				break;
			case "6":
				var values=this.week.split("#");
				$("#cronWeek_numberValue").combobox("setValue",values[0]);
				$("#cronMonth_weekNumber").numberspinner("setValue",values[1]);
				break;
			case "7":
				var value=this.week.replace('L','');
				$("#cronWeek_lastValue").combobox("setValue",value);
				break;
		}
		cronType=this.getCronType(this.day);
		$("#dayCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "2":
				break;
			case "3":
				var values=this.day.split("-");
				$("#cronDay_beginDay").numberspinner("setValue",values[0]);
				$("#cronDay_endDay").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.day.split("/");
				$("#cronDay_startDay").numberspinner("setValue",values[0]);
				$("#cronDay_countDay").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronDay_value").combobox("setValues",this.day.split(","));
				break;
			case "8":
				break;
			case "9":
				var value=this.day.replace('W','');
				$("#cronDay_workDay").numberspinner("setValue",value);
				break;
			case "10":
				break;
		}
		cronType=this.getCronType(this.hour);
		$("#hourCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "3":
				var values=this.hour.split("-");
				$("#cronHour_beginHour").numberspinner("setValue",values[0]);
				$("#cronHour_endHour").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.hour.split("/");
				$("#cronHour_startHour").numberspinner("setValue",values[0]);
				$("#cronHour_countHour").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronHour_value").combobox("setValues",this.hour.split(","));
				break;
		}
		cronType=this.getCronType(this.minute);
		$("#minuteCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "3":
				var values=this.minute.split("-");
				$("#cronMinute_beginMinute").numberspinner("setValue",values[0]);
				$("#cronMinute_endMinute").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.minute.split("/");
				$("#cronMinute_startMinute").numberspinner("setValue",values[0]);
				$("#cronMinute_countMinute").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronMinute_value").combobox("setValues",this.minute.split(","));
				break;
		}
		cronType=this.getCronType(this.second);
		$("#secondCronType").combobox("setValue",cronType);
		switch(cronType){
			case "1":
				break;
			case "3":
				var values=this.second.split("-");
				$("#cronSecond_beginSecond").numberspinner("setValue",values[0]);
				$("#cronSecond_endSecond").numberspinner("setValue",values[1]);
				break;
			case "4":
				var values=this.second.split("/");
				$("#cronSecond_startSecond").numberspinner("setValue",values[0]);
				$("#cronSecond_countSecond").numberspinner("setValue",values[1]);
				break;
			case "5":
				$("#cronSecond_value").combobox("setValues",this.second.split(","));
				break;
		}
	}
}