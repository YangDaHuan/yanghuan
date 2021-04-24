<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日志管理</title>
<jsp:include page="../common.jsp" />
<script type="text/javascript">
$(document.body).ready(function(){

	
});
</script>
</head>
<body class="easyui-layout">
	<div region="center">
		<div id="tt" class="easyui-tabs" fit="true">
			<div title="审计日志" style="overflow: hidden">
				<iframe src="log/auditLogIndex.zb" width="100%" height="100%"
					frameborder="0"></iframe>
			</div>
			<div title="登录日志" style="overflow: hidden;">
				<iframe src="log/loginLogIndex.zb" width="100%" height="100%"
					frameborder="0"></iframe>
			</div>
			<div title="任务日志" style="overflow: hidden;">
				<iframe src="log/jobLogIndex.zb" width="100%" height="100%"
					frameborder="0"></iframe>
			</div>
		</div>
	</div>
</body>
</html>