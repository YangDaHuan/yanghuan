<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'leftMenu.jsp' starting page</title>
<jsp:include page="jsp/common.jsp"></jsp:include>

<script type="text/javascript">
        $(document).ready(function () {
            $('li.button a').click(function (e) {
var dropDown = $(this).parent().next();
                $('.dropdown').not(dropDown).slideUp('slow');
                dropDown.slideToggle('slow');
                e.preventDefault();
            })

        });
</script>
</head>
<body style="text-align: center">
	<div id="main">
		<ul class="">
			<li class="menu">
				<ul>
					<li class="button"><a href="#" class="green">菜单一<span></span></a></li>
					<li class="dropdown">
						<ul>
							<li><a href="#">链接一</a></li>
							<li><a href="#">链接二</a></li>
							<li><a href="#">链接三</a></li>
							<li><a href="#">链接四</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li class="menu">
				<ul>
					<li class="button"><a href="#" class="orange">菜单二<span></span></a></li>
					<li class="dropdown">
						<ul>
							<li><a href="#">链接一</a></li>
							<li><a href="#">链接二</a></li>
							<li><a href="#">链接三</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li class="menu">
				<ul>
					<li class="button"><a href="#" class="blue">菜单三<span></span></a></li>
					<li class="dropdown">
						<ul>
							<li><a href="#">链接一</a></li>
							<li><a href="#">链接二</a></li>
							<li><a href="#">链接三</a></li>
							<li><a href="#">链接四</a></li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
		<div class="clear"></div>
	</div>

</body>
</html>
