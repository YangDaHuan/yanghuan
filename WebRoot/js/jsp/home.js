//个人设置
var temp_sex;

var changeSex = function(obj){
	if($(obj).val()==temp_sex){
		$(obj).attr("checked",false);
		temp_sex = "";
	}else{
		temp_sex = $(obj).val();
	}
}

var psnSetting=function(){
	$("#psnDlg").dialog("open");
	$("#psnForm").form("reset");
	var url = "user/getCurrentUser.zb";
	$.post(url,function(data){
		if(data){
			$("#psnForm").form("load",data);	
			temp_sex = $("#psnForm").find("input[name=sex]:checked").val();
		}else{
			$.messager.alert("错误","加载时出现系统错误!","error");			
		}
	},"json");
	
}
//密码设置
var pwdSetting=function(){
	$("#pwdDlg").dialog("open");
	$("#pwdForm").form("reset");
}
/**
* 下拉菜单
*/
var dropDownMenu=function(){
	$(".topmenu li").each(function(){
		if($(this).find("li").length==0){
			$(this).find(".menu-sublist").remove();
		}
	});
	$(".topmenu li").hover(
		function () {
			$(this).find(".menu-sublist").slideDown(100);
		},
		function () {
			$(this).find(".menu-sublist").slideUp(100);
		}
	); 
}
/**
 * 保存用户信息
 */
function savePsn(){
	$("#psnForm").form("submit",{
		//提交前验证
		onSubmit:function(){
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});	
			var isValid = $(this).form("validate");
			if (!isValid) {
				$.messager.progress("close");
			}
			return isValid;
		},
		//提交成功
		success:function(result){
			result = $.parseJSON(result);
			$.messager.progress("close");
			if(result.success){//保存成功					
				$.noty.closeAll();
				var n = noty({text: "保存成功",type:"success",layout:"topCenter",timeout:1000});
				$("#psnDlg").dialog("close");
				var fullname = $("input[name=fullname]").val();
				$("#fullname").html(fullname);
			}else{//保存失败
				$.messager.alert("错误","保存数据时出现系统错误!","error");
			}
		}
	});
}
//修改密码
var savePwd = function(){
var password = $("#password").val();
var password2 = $("#password2").val();
if(password!=password2){
	$.messager.alert("提示","新密码与确认密码不一致！","info");
	return;
}
	var url = "user/savePwd.zb";
	var $form = $("#pwdForm");
	var $dialog = $("#pwdDlg");
	$form.form("submit",{
		url: url,
		//提交前验证
		onSubmit:function(){
			$.messager.progress({
				title:"提示",
				text:"数据处理中，请稍后...."
			});	
			var isValid = $(this).form("validate");
			if (!isValid) {
				$.messager.progress("close");
			}
			return isValid;
		},
		//提交成功
		success:function(result){
			result = $.parseJSON(result);
			$.messager.progress("close");
			if(result.success){//保存成功
				$form.form("reset");
				$dialog.dialog("close");
				$.noty.closeAll();
				var n = noty({text: "保存成功",type:"success",layout:"topCenter",timeout:1000});
			}else{//保存失败
				$.messager.alert("错误",result.msg,"error");
			}
		}
	});
}
//退出
function logout(){
	$.messager.confirm("提示", "您确认要退出系统吗?", function(r){
		if (!r){
			return;
		}
		//window.location = "logout.zb";
		$.post("logout.zb",{},function(res){
			window.location = "login.zb";
		},"json");
	});
}