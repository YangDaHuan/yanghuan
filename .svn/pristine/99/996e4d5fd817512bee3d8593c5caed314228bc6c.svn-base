<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'testFun.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<br>
	<br>
	<br>
	<table align="center" vaign="middle">
		<%
    	Enumeration<String> pNames=request.getParameterNames();
    	while(pNames.hasMoreElements()){
    		String name = pNames.nextElement();
    		String value = request.getParameter(name);
    		out.print("<tr><td>"+name+":</td><td>"+value+"</td></tr>");
    	}
    %>
	</table>
</body>
</html>
