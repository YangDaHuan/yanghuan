<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tld/btp.tld" prefix="btp"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>审计日志详细信息</title>
<jsp:include page="../common.jsp" />
<style>
fieldset {
	margin: 5px;
	padding: 5px;
}

legend {
	font-size: 14px;
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="main">
		<fieldset>
			<legend> 日志信息 </legend>
			<div class="c_content">
				<table border="0" cellpadding="1" cellspacing="1" align="center"
					style="float: left">
					<tr style="height: 30px">
						<td>操作人：</td>
						<td>${auditLogInfo.fullName}</td>
					</tr>
					<tr style="height: 20px">
						<td>操作时间：</td>
						<td><fmt:formatDate value="${auditLogInfo.createTime}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr style="height: 30px">
						<td>ip地址：</td>
						<td>${auditLogInfo.ipAddress}</td>
					</tr>
					<tr style="height: 20px">
						<td>操作模块：</td>
						<td>${auditLogInfo.moduleName}</td>
					</tr>
					<tr style="height: 20px">
						<td>业务id：</td>
						<td>${auditLogInfo.serviceId}</td>
					</tr>
					<tr style="height: 20px">
						<td>操作标识：</td>
						<td><c:choose>
								<c:when test="${auditLogInfo.opFlag==1}">
												新增
											</c:when>
								<c:when test="${auditLogInfo.opFlag==2}">
												修改
											</c:when>
								<c:when test="${auditLogInfo.opFlag==3}">
												删除
											</c:when>
								<c:when test="${auditLogInfo.opFlag==4}">
												查询
											</c:when>
							</c:choose></td>
					</tr>
					<tr style="height: 20px">
						<td>描述：</td>
						<td>${auditLogInfo.description}</td>
					</tr>
				</table>

			</div>
		</fieldset>

		<c:if test="${!empty auditLogInfo.auditLogInfoExtList}">
			<fieldset>
				<legend> 字段信息 </legend>
				<div class="c_content">
					<table style="text-align: center; width: 100%;">
						<thead>
							<th align="center">
							<td>字段名</td>
							<td>新值</td>
							<td>旧值</td>
						</thead>
						<c:forEach items="${auditLogInfo.auditLogInfoExtList}" var="info">
							<tr>
								<td></td>
								<td>${info.name}</td>
								<td>${info.value}</td>
								<td>${info.oldValue}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</fieldset>
		</c:if>
	</div>
</body>
</html>
