<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>导入对象</title>
<link rel="stylesheet" href="image/emx_nav_left.css" type="text/css" />

<script type="text/javascript">
/*
 * 点击“导入”按钮
*/
function onImport()
{
	var path = document.getElementById("path").value;
	if( "" == path )
	{
		alert("请选择文件！");
		document.getElementById("path").focus();
		return ;
	}
	var pwd = document.getElementById("pwd").value;
	//if( "" == pwd )
	//{
	//	alert("请输入密码！");
	//	document.getElementById("pwd").focus();
	//	return ;
	//}
	document.getElementById("opt").value = "NeedImport";
//	var keyusage = document.getElementById("KeyUsage").value;
//window.returnValue = path + ';' + pwd ;//+ ';' + keyusage;
	window.close();
}
/*
 * 点击“取消”按钮
*/
function onCancel()
{
	document.getElementById("opt").value = "CancelImport";
	window.close();
}
/*
 * 点击“关闭”按钮
*/
function onClose()
{
	if(document.getElementById("opt").value == "NeedImport" )
	{		
		window.returnValue = document.getElementById("path").value + ';' + document.getElementById("pwd").value ;
	}		
	else
		window.returnValue = "";
	window.close();
}
/*
 * 检查所选文件类型
*/
function checkFileExt(ext)
{
	var fileExt = ext.toUpperCase();
	if( "PFX" == fileExt || "P12" == fileExt )
	{
		document.getElementById("pwd").disabled = "";
		document.getElementById("pwd").focus();
		document.getElementById("import").disabled = "";
	}
	else if( "P7B" == fileExt || "CER" == fileExt || "CRT" == fileExt)
	{
		document.getElementById("pwd").disabled = 1;
		document.getElementById("pwd").value = "111111";
		document.getElementById("import").disabled = "";
	}
	else
	{
		alert("无效的文件类型！");
		document.getElementById("pwd").disabled = 1;
		document.getElementById("import").disabled = 1;
		document.getElementById("path").focus();
	}
}
function onSubmit()
{
	if(event.keyCode!=13) return;
	onImport();
}

</script>
</head>

<body onbeforeunload="onClose()" onkeydown="javascript:if(event.keyCode==13) return   event.srcElement.tagName=='TEXTAREA'">
<!--<div id="pagecell2_div">-->
<div id="pagecell2_div" >
	<fieldset>
	<legend>导入证书</legend>
	<form>
		<h3>&nbsp;&nbsp;证书路径：</h3><input type="file" id="path" onkeydown="if(event.keyCode==13)this.click();" onpropertychange="checkFileExt(value.replace(/.+\./,''))" />
		<h3>&nbsp;&nbsp;证书密码：</h3><input type="password" id="pwd" size="32" onkeydown="onSubmit()" disabled /><br></br>
		<!--<h3>&nbsp;&nbsp;证书用途：</h3>
		<input type="radio" name="KeyUsage" value="exchange" checked >密钥交换(用于加密/解密及其他)
		<br>
		<input type="radio" name="KeyUsage" value="sign">签名(只用于签名/验证)
		<br><br>-->
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="import" type="button" id="import" value=" 导入 " onclick="onImport()" disabled />&nbsp;&nbsp;
		<input name="cancel" type="button" value=" 取消 " onclick="onCancel()" />
		<input name="opt" type="hidden" id="opt" value=""/>
	</form>
	</fieldset>
</div>
</body>
</html>
