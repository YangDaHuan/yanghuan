<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link type="text/css" href="css/style.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css" />

	<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/easyui-ext.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.extend.min.js"></script>

	<style type=text/css>
.nav {
	FONT: bold 9pt Tahoma;
	COLOR: #283e66;
	TEXT-DECORATION: none
}
</style>
	<title></title>
	<style type="text/css">
td {
	text-align: left;
}
</style>
	<script type="text/javascript">
var getParams=function(){
	var p='';
	$('.formnav').each(function(){
		var name=$(this).attr('name');
		var li=$(this).find('li[class=selected]');
		if(li.length==1){
			p+='&';
			p+=name+'='+li.attr('val');
		}else if(li.length>1){
			p+='&';
			var temp='';
			li.each(function(){
				temp+=$(this).attr('val')+',';
			});
			temp=temp.substring(0,temp.length-1);
			p+=name+'='+temp;
		}
	});
	return p;
}
$(function(){
		postForm();
});
function postForm()
{
	var datas = $("#reportForm").serialize();
	datas += getParams();
	//console.info(datas);
	postUrl(datas);
}

function postUrl(datas)
{
	//$(document).mask('正在统计数据，请稍候...');
	$.ajax(
	{
		url: 'reportIndex.zb',
		type: 'POST',
		cache: false,
		data: datas,
		dataType: 'json',
		success: function(res)
		{
			$("#reportDiv").html(res.reportHtml);
			if (res.reportHtml != "")
			{
				$('#displayDiv').show();
			}
			//$(document).unmask();
			// 如果父窗口该方法存在，则引用父窗口doSuccess方法
			if (parent.doSuccess)
			{
				parent.doSuccess(res,'${param.divId}','${param.model}');
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown)
		{
			JDialog.showMessageDialog('异常', '服务器出现异常，数据加载失败。', JDialog.ERROR);
			$(document).unmask();
		}
	});
}
</script>
</head>
<body>
	<div class="j-panel j-panel-radius j-panel-nohead" id=""
		style="padding: 5px; height: 96%;">
		<div class="j-panel-body" id="" style="height: 100%; overflow: auto;">
			<div id="print" class="btnBar">
				<ul class="left">
					<li>
						<ul class="fileOper">
							<li><a class="ICOhover"
								href="exportReport.zb?reportName=${param.reportName}&exportType=xls"><span
									title="导出excel" class="excel"></span></a></li>
							<li><a class="ICOhover"
								href="exportReport.zb?reportName=${param.reportName}&exportType=doc"><span
									title="导出word" class="word"></span></a></li>
							<li><a class="ICOhover"
								href="exportReport.zb?reportName=${param.reportName}&exportType=pdf"><span
									title="导出pdf" class="pdf"></span></a></li>
						</ul>
					</li>
				</ul>
				<c:if test="${isSub}">
					<div align="right">
						<a href="javascript:history.back();" class="btn"> <span
							class="btn-left"> <span class="btn-text icon-back">返回</span>
						</span>
						</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</c:if>
			</div>
			<c:if test="${!isSub}">
				<form id="reportForm">
					<input type="hidden" name="reportName" value="${param.reportName}" />
					<input type="hidden" name="levelCode" value="${param.levelCode}" />
					<input type="hidden" name="userName" value="${param.userName}" />
					<input type="hidden" name="mhoName" value="${param.mhoName}" />
					<fieldset class="j-fieldset">
						<legend id="fieldset-legend" class="j-fieldset-header">
							<div class="j-fieldset-header-text">查询条件</div>
						</legend>
						<div class="j-fieldset-body " id="fieldset-body">
							<table>
								<tr>
									<td class="noborder">
										<table>
											<tr>
												<c:forEach items="${paramList}" var="p">

													<c:choose>
														<c:when test='${p.propertiesMap["type"] == "text"}'>
															<td><label class="j-form-item-label">${p.description}：</label></td>
															<td><input type="text" class="easyui-textbox"
																name="${p.name}" value=${p.defaultValue }/></td>
														</c:when>
														<c:when test='${p.propertiesMap["type"] == "date"}'>
															<td><label class="j-form-item-label">${p.description}：</label></td>
															<td><input type="text" class="easyui-datebox"
																name="${p.name}" value=${p.defaultValue }/></td>
														</c:when>
														<c:otherwise>
															<c:if test="${p.jsonStr != null}">
																<td><label class="j-form-item-label">${p.description}：</label></td>
																<td id='${p.name}' class='jsonOptions'
																	json='${p.jsonStr}'
																	mult='${p.propertiesMap["multiple"]}'
																	defaultValue="${p.defaultValue}"
																	req='${p.propertiesMap["required"]}'></td>
															</c:if>
															<c:if test='${p.propertiesMap["json"] != null}'>
																<td><label class="j-form-item-label">${p.description}：</label></td>
																<td id='${p.name}' class='jsonOptions'
																	json='${p.propertiesMap["json"]}'
																	mult='${p.propertiesMap["multiple"]}'
																	defaultValue="${p.defaultValue}"
																	req='${p.propertiesMap["required"]}'></td>
															</c:if>
														</c:otherwise>
													</c:choose>

												</c:forEach>
											</tr>
										</table>
									</td>
									<td width="80" class="noborder" valign="bottom"><a
										id="btn" href="#" class="easyui-linkbutton"
										onclick="postForm();" data-options="iconCls:'icon-search'">查询</a>

									</td>
								</tr>
							</table>
						</div>
					</fieldset>
				</form>
			</c:if>
			<fieldset id="displayDiv" style="display: none">


				<div id="reportDiv"></div>
			</fieldset>
		</div>
	</div>
</body>
</html>

