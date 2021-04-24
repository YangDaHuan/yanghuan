<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.raqsoft.report.usermodel.*"%>
<%@ page import="com.raqsoft.report.view.*"%>
<%@ page import="com.raqsoft.input.tag.*"%>
<%@ taglib uri="/WEB-INF/raqsoftInput.tld" prefix="raqsoft"%>
<%@ taglib uri="/WEB-INF/raqsoftReport.tld" prefix="report"%>
<%
	if(request.getProtocol().compareTo("HTTP/1.1")==0 ) response.setHeader("Cache-Control","no-cache");
	else response.setHeader("Pragma","no-cache");
	request.setCharacterEncoding( "UTF-8" );
	String appmap = request.getContextPath();
	String input = request.getParameter( "sht" );
	//保证报表名称的完整性
	int iTmp = 0;
	if( (iTmp = input.lastIndexOf(".sht")) <= 0 ){
		iTmp = input.length();
		input = input + ".sht";
	}

	String reportFileHome=Context.getInitCtx().getMainDir();
	String param=new String();
	Enumeration paramNames = request.getParameterNames();
	if(paramNames!=null){
		while(paramNames.hasMoreElements()){
			String paramName = (String) paramNames.nextElement();
			String paramValue=request.getParameter(paramName);
			if(paramValue!=null){
				//把参数拼成name=value;name2=value2;.....的形式
				param+=paramName+"="+paramValue+";";
			}
		}
	}
	//System.out.println("params : " + param.toString());
	String noDfx = request.getParameter( "noDfx" );
	if( noDfx == null ) noDfx = "";
	String dataFile = request.getParameter( "dataFile" );
	if( dataFile == null || dataFile.length() == 0 ) {
		dataFile = "";
	}
	String fileType = request.getParameter( "fileType" );
	if (fileType == null || fileType.length() == 0) {
		//if (dataFile.indexOf(".json"))
		fileType = "json";
	}
	
	
	String sgid = InputTag.getInputId();
	String resultPage = "queryInput.jsp?sht=" + URLEncoder.encode( input, "UTF-8" ) + "&noDfx="+noDfx+"&dataFile=" + URLEncoder.encode( dataFile, "UTF-8" ) + "&fileType=" + fileType+"&sgid="+sgid;

	//以下代码是检测这个报表是否有相应的参数模板
	String paramFile = input.substring( 0, iTmp ) + "_arg.rpx";
	InputStream pis = null;
	try {
		pis = new FileInputStream( application.getRealPath( reportFileHome + "/" + paramFile ) );
	}catch( Throwable t ) {}
	if( pis == null ) {
		pis = application.getResourceAsStream( reportFileHome + "/" + paramFile );
	}
	if( pis == null ) {
		try {
			pis = new FileInputStream( reportFileHome + "/" + paramFile );
		}catch( Throwable t ) {}
	}
%>

<html>
<head>
<meta name="viewport" content="initial-scale=1" />
<title>润乾填报表</title>
</head>
<link rel="stylesheet" type="text/css"
	href="<%=appmap%><%=ReportConfig.raqsoftDir%>/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=appmap%><%=ReportConfig.raqsoftDir%>/easyui/themes/icon.css">
<script type="text/javascript"
	src="<%=appmap%><%=ReportConfig.raqsoftDir%>/easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=appmap%><%=ReportConfig.raqsoftDir%>/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=appmap%><%=ReportConfig.raqsoftDir%>/easyui/locale/easyui-lang-zh_CN.js"></script>

<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0
	style="background: #F1F4F7"
	onload="try{parent.hideLoading()}catch(e){}">
	<div id=mengban
		style="background-color: white; position: absolute; z-index: 999; width: 100%; height: 100%">
		<table width=100% height=100%>
			<tr>
				<td width=100% style="text-align: center; vertical-align: middle"><img
					src="../raqsoft/images/loading.gif"><br>正在加载......</td>
			</tr>
		</table>
	</div>
	<div id=reportArea class="easyui-layout" data-options="fit:true"
		style="display: none; width: 100%; height: 100%">
		<div data-options="region:'north',border:false"
			style="height: 30px; overflow: hidden">
			<jsp:include page="inputtoolbar.jsp" flush="false">
				<jsp:param name="sgid" value="<%=sgid %>"></jsp:param>
			</jsp:include>
		</div>
		<div data-options="region:'center',border:false">
			<div class="easyui-layout" data-options="fit:true">
				<%	//如果参数模板存在，则显示参数模板
		if( pis != null ) {
		%>
				<div data-options="region:'north',border:false">
					<center>
						<table id=param_tbl>
							<tr>
								<td><report:param name="form1"
										paramFileName="<%=paramFile%>" needSubmit="no"
										params="<%=param.toString()%>"
										hiddenParams="<%=param.toString()%>"
										resultPage="<%=resultPage%>" resultContainer="reportContainer"
										needImportEasyui="no" /></td>
								<td style="padding-left: 15px"><a
									href="javascript:_submit( form1 )" class="easyui-linkbutton"
									style="vertical-align: middle; padding: 0px 8px;">查询</a></td>
							</tr>
						</table>
					</center>
				</div>
				<% }%>
				<div id=reportContainer data-options="region:'center',border:false"
					style="text-align: center">
					<raqsoft:input id="<%=sgid %>" src="<%=input%>" paramMode="i"
						params="<%=param.toString()%>" excel="io" needImportEasyui="no"
						width="100%" height="100%" tabLocation="bottom" noDfx="<%=noDfx%>"
						file="<%=dataFile%>" fileType="<%=fileType%>" outerDim="id"
						exceptionPage="reportJsp/myError2.jsp" />
				</div>
			</div>
		</div>
		<script language="javascript">
	document.getElementById( "mengban" ).style.display = "none";
	document.getElementById( "reportArea" ).style.display = "";
</script>
</body>
</html>
