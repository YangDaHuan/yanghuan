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
<title>dashboard</title>
<jsp:include page="../common.jsp"></jsp:include>
<meta content="text/html; charset=utf-8" http-equiv="content-type">
<meta name="description" content="Freewall demo filter" />
<meta name="keywords"
	content="javascript, dynamic, grid, layout, jquery plugin, fit zone" />

<!-- Saiku CSS -->
<link rel="stylesheet" href="olap/css/saiku/src/styles.css"
	type="text/css">

<script type="text/javascript" src="js/freewall.js"></script>

<script type="text/javascript" src="js/dashboard.js"></script>
<!-- echarts -->
<script src="js/echarts/echarts-all.js"></script>
<style type="text/css">
.layout {
	padding: 15px;
}

.filter-items {
	padding: 10px 0px;
}

.filter-items a {
	display: inline-block;
	margin: 0px 5px 5px 0px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div>
		<label style="font: italic small-caps 10pt serif;">选择仪表板：</label><input
			id="dashboardId" class="easyui-combobox" name="dashboardId"
			data-options="valueField:'id',textField:'name',onChange:function(newValue,oldValue){solidbi.dashboardId=newValue;solidbi.openDashboard();}" />

	</div>
	<div class="layout">
		<div id="filterItems" class="filter-items"></div>
		<div id="freewall" class="free-wall"></div>
	</div>



	<script type="text/javascript">
			
			$(function() {
				solidbi.filterItems="#filterItems";
				solidbi.biwall="#freewall";
				solidbi.edit=false;
				solidbi.user="<%=userName%>";
				$.post("/saiku/rest/saiku/session", {"username":"<%=userName%>","password":"<%=password%>"}, function(data) {
					$.get("/saiku/rest/saiku/session", {}, function(data) {
						if (data.username="<%=userName%>") {
						$.post("dashboard/getDashboardList.zb",{},
								function(result, status) {
									if(result.length>0){//操作成功
										$("#dashboardId").combobox("loadData",result);
										$("#dashboardId").combobox("select",result[0].id);
									}							
									
								},
								"json"
							); 
	
						} else {
							$.messager.alert("错误", "自动登录时出现系统错误!", "error");
						}
						$.messager.progress("close");
					}, "json");
				}, "xml");
				
				
				
				
			});
			
			
		</script>

</body>
</html>
