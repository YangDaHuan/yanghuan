<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="common.jsp" />
<link rel="stylesheet" type="text/css"
	href="themes/default/jquery-ui.css">
<script type="text/javascript">
$(function(){
	//左侧菜单点选事件
	$('#accordion').find('span').hide();
	$('#accordion').find('a').click(function(){
		$('#accordion').find('a').removeClass('selected').removeClass('ui-state-active');
		$('#accordion').find('span').hide();
		$(this).addClass('selected').addClass('ui-state-active');
		$(this).find('span').show();
	});
	$('#accordion').find('a:first').addClass('selected').addClass('ui-state-active').find('span').show();
	var url = $('#accordion').find('a:first').attr("href");
	$("#iframe").attr("src",url);	
});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',border:true" style="width: 215px;">
		<!--左侧-->
		<div id="accordion" class="j-panel-body"
			style="height: 100%; overflow: hidden;">
			<ul class="ui-accordion">
				<c:forEach items="${moduleList}" var="module">
					<li><a href="${module.url}" target="right_iframe"
						class="ui-state-default ui-accordion-header"> <span
							class="ui-accordion-header-icon ui-icon ui-icon-plus"></span>
							${module.moduleName}
					</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<!--right-->
	<div data-options="region:'center',border:false"
		style="overflow: hidden;">
		<iframe id="iframe" src="" name="right_iframe" class="iframeApp"
			frameborder="0" SCROLLING="no" marginwidth="0" marginheight="0"
			style="width: 100%; height: 100%; overflow: hidden;"></iframe>
	</div>
</body>
</html>
