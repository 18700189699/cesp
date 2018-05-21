<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统管理员</title>
<script type="text/javascript">
	$().click(function(){
		$.ajax({
	        async : bAsync,
	        type  : 'post',
	        url   :serverAddress  + "/user",
	        data  : {"postData":dataJsonStr,
	               "postUserName":window.sessionStorage.ux_curLoginName,
	               "postUserHandle":window.sessionStorage.ux_userHandle},
	        error : function(jsonString)
	        {
	            var errJsonObj = jsonString;
	            if(typeof jsonString == "string")
	            {
	                errJsonObj  = JSON.parse(jsonString);
	            }
	            errJsonObj.rstcode = "error";
	            callbackFunc(JSON.stringify(errJsonObj));
	        },
	        success : function(jsonString)
	        {
	            var jsonObj = JSON.parse(jsonString);
	            if(jsonObj.rstcode == "error_refuse")
	            {
	                if(window.sessionStorage.ux_curLoginPwdExpired != "pwdExpired")
	                {
	                    var topFrameWin = top.document.getElementById("topFrame").contentWindow;
	                    topFrameWin.gotoLogin();
	                }
	            }
	            callbackFunc(jsonString);
	        }
	    });
	})
	
	$(function(){
		$('#send').click(function(){
			$.ajax({
				type: "GET",
				url: "test.json",
				data: {username:$("#username").val(), content:$("#content").val()},
				dataType: "json",
				success: function(data){
				$('#resText').empty(); //清空resText里面的所有内容
				var html = '';
				$.each(data, function(commentIndex, comment){
				html += '<div class="comment"><h6>' + comment['username']
				+ ':</h6><p class="para"' + comment['content']
				+ '</p></div>';
				});
				$('#resText').html(html);
				}
			});
		});
	});

</script>
</head>
<body>
	系统管理员页面
</body>
</html>