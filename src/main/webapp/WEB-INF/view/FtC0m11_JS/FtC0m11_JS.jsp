﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- DW6 -->
<head>
<!-- Copyright 2005 Macromedia, Inc. All rights reserved. -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EnterSafe PKI 管理工具</title>
<link rel="stylesheet" href="image/emx_nav_left.css" type="text/css" />
<!-- Codebase="/../Debug/FtCom11.dll#Version=1,0,8,1231\" -->
<!-- FtCom11Attribute -->
<OBJECT classid="clsid:F97C817C-0E0F-4BFB-B8DB-36438A1DE479" id="Com11Attribute" name="Com11Attribute" ></OBJECT>
<!-- FtCom11Token -->
<OBJECT classid="clsid:B40AD154-5022-47C3-935D-0926951B64B0" id="Com11Token" name="Com11Token" ></OBJECT>
<!-- FtCom11Slot -->
<OBJECT classid="clsid:A22FB3C3-8D22-4A52-8F0F-6855BBBAE5A0" id="Com11Slot" name="Com11Slot" ></OBJECT>
<!-- FtCom11If -->
<OBJECT classid="clsid:A5F1473C-3BAF-4098-885A-9DD332433FD5" id="Com11If" name="Com11If" ></OBJECT>

<script type="text/javascript">

var time = 3000;
var numofitems = 7;
var g_data;
String.prototype.Trim = function()
{
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
//menu constructor
function menu(allitems,thisitem,startstate){ 
  callname= "gl"+thisitem;
  divname="subglobal"+thisitem;  
  this.numberofmenuitems = allitems;
  this.caller = document.getElementById(callname);
  this.thediv = document.getElementById(divname);
//  this.thediv.style.visibility = startstate;
}

//menu methods
function ehandler(event,theobj){
  for (var i=1; i<= theobj.numberofmenuitems; i++){
    var shutdiv =eval( "menuitem"+i+".thediv");
    shutdiv.style.visibility="hidden";
  }
  theobj.thediv.style.visibility="visible";
}
				
function closesubnav(event){
/*
  if ((event.clientY <48)||(event.clientY > 107)){
    for (var i=1; i<= numofitems; i++){
      var shutdiv =eval('menuitem'+i+'.thediv');
      shutdiv.style.visibility='hidden';
    }
  }
*/
}

/*
 * 当卡插入时
*/
function WhenKeyInsert(slotID)
{
//	alert(slotID+"号卡被插入");
	document.getElementById("currentSlotID").value = slotID;
	//pageDetailCtrl_div层
	if( null == document.getElementById('isLogin_'+slotID) )
	{
		document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='isLogin_" + slotID + "' name='isLogin_" + slotID + "' value='0' >";
	}
	if( null == document.getElementById('maxPINLen_'+slotID) )
	{
		document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='maxPINLen_" + slotID + "' name='maxPINLen_" + slotID + "' value='0' >";
	}
	if( null == document.getElementById('minPINLen_'+slotID) )
	{
		document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='minPINLen_" + slotID + "' name='minPINLen_" + slotID + "' value='0' >";
	}
	//userStatus_div层
	if( null == document.getElementById('loginStatus_'+slotID) )
	{
		document.getElementById("userStatus_div").innerHTML += "<input id='loginStatus_" + slotID + "' name='loginStatus_" + slotID + "' value='' readonly='1'>";
	}
	else
	{
		document.getElementById("userStatus_div").style.display = '';
		document.getElementById('loginStatus_'+slotID).style.display = '';
		document.getElementById("loginStatus_"+slotID).value = 0;
	}
	
	showSlotList(0);
}
/*
 * 当卡拔出时
*/
function WhenKeyRemove(slotID)
{
//	alert(slotID+"号卡被拔出！");
	document.getElementById("login_div").style.display = "none";
	
	document.getElementById('isLogin_'+slotID).value = 0;
	document.getElementById('maxPINLen_'+slotID).value = 0;
	document.getElementById('minPINLen_'+slotID).value = 0;
	document.getElementById('loginStatus_'+slotID).value = '';
	document.getElementById('loginStatus_'+slotID).style.display = 'none';
	
	showSlotList(0);
}
/*
 * 初始化：设置卡插拔事件相应的JS函数名称
*/
function Init()
{
	//判断浏览器类型
	if(navigator.userAgent.indexOf("MSIE")>0)
	{
		//login_div层PIN码检查
		document.getElementById('PIN').attachEvent("onpropertychange", CheckPINLength);
		//modifyUPIN_div层PIN码检查
		document.getElementById('old_uPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('new_uPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('verify_uPIN').attachEvent("onpropertychange", CheckPINLength);
		//modifyOPIN_div层PIN码检查
		document.getElementById('old_oPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('new_oPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('verify_oPIN').attachEvent("onpropertychange", CheckPINLength);
		//unblockToken_div层PIN码检查
		document.getElementById('oPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('set_uPIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('verifyset_uPIN').attachEvent("onpropertychange", CheckPINLength);
		//initToken_div层PIN码检查
		document.getElementById('os_PIN').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('new_uPIN_').attachEvent("onpropertychange", CheckPINLength);
		document.getElementById('verify_uPIN_').attachEvent("onpropertychange", CheckPINLength);
		
		//modifyTN_div层TN检查
		document.getElementById('new_TN').attachEvent("onpropertychange", CheckTNLength);
		//initToken_div层TN检查
		document.getElementById('label').attachEvent("onpropertychange", CheckTNLength);
	}
	else if(navigator.userAgent.indexOf("Firefox")>0)
	{
		//login_div层PIN码检查
		document.getElementById('PIN').addEventListener("input", CheckPINLength, false);
		//modifyUPIN_div层PIN码检查
		document.getElementById('old_uPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('new_uPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('verify_uPIN').addEventListener("input", CheckPINLength, false);
		//modifyOPIN_div层PIN码检查
		document.getElementById('old_oPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('new_oPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('verify_oPIN').addEventListener("input", CheckPINLength, false);
		//unblockToken_div层PIN码检查
		document.getElementById('oPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('set_uPIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('verifyset_uPIN').addEventListener("input", CheckPINLength, false);
		//initToken_div层PIN码检查
		document.getElementById('os_PIN').addEventListener("input", CheckPINLength, false);
		document.getElementById('new_uPIN_').addEventListener("input", CheckPINLength, false);
		document.getElementById('verify_uPIN_').addEventListener("input", CheckPINLength, false);

		//modifyTN_div层TN检查
		document.getElementById('new_TN').addEventListener("input", CheckTNLength, false);
		//initToken_div层TN检查
		document.getElementById('label').addEventListener("input", CheckTNLength, false);
	}

	Com11If.WhenKeyRemove = "WhenKeyRemove";
	Com11If.WhenKeyInsert = "WhenKeyInsert";
}
/*
 * 点击用户登录的“槽列表”
*/
function LoginSelectSlot()
{
	var currentSlotID = document.getElementById("login_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("login").disabled = 1;
	
	//判断选择的卡是否已经登录
	if( 1 == document.getElementById("isLogin_" + currentSlotID).value )
	{
		document.getElementById("PIN").disabled = 1;
	}
	else
	{
		document.getElementById("PIN").disabled = 0;
		document.getElementById("PIN").focus();
	}
}
/*
 * 点击“用户登录”
*/
function Login()
{
	//清空表单元素
	document.getElementById("PIN").value = "";
	document.getElementById("PIN").disabled = 1;
	document.getElementById("login").disabled = 1;
	
	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}

	if( "" == document.getElementById("login_div").style.display )
	{
		document.getElementById("login_div").style.display = "none";
	}
	else
	{
		document.getElementById("login_div").style.display = "";
		/*
		//遍历卡的登录状态
		var validSlotCount = document.getElementById("validSlotCount").value;
		for( var i=0; i<validSlotCount; i++ )
		{
			var slotID = document.getElementById("validSlotID_" + i).value;
			if( 0 == document.getElementById("isLogin_"+slotID).value )
			{
				document.getElementById("PIN").disabled = 0;
				document.getElementById("PIN").focus();
				break;
			}
			else
			{
				document.getElementById("PIN").disabled = 1;
				break;
			}
		}
		*/
		var slotID = document.getElementById("login_slotSel").value;
		if( 0 == document.getElementById("isLogin_"+slotID).value )
		{
			document.getElementById("PIN").disabled = 0;
			document.getElementById("PIN").focus();
		}
	}
}
/*
 * 检查PIN码长度
*/
function CheckPINLength(v)
{
	var elementID = event.srcElement.id;

	var currentSlotID = document.getElementById("currentSlotID").value;
	var maxPINLen = document.getElementById("maxPINLen_" + currentSlotID).value;
	var minPINLen = document.getElementById("minPINLen_" + currentSlotID).value;

	var val = document.getElementById(elementID).value;
	//login_div层PIN码检查
	if( "PIN" == elementID )
	{
		if( val.length <= maxPINLen && val.length >= minPINLen )
		{
			document.getElementById("login").disabled = 0;
		}
		else
		{
			document.getElementById("login").disabled = 1;
		}
	}
	//modifyUPIN_div层PIN码检查
	else if( "old_uPIN" == elementID || "new_uPIN" == elementID || "verify_uPIN" == elementID )
	{
		if( val.length <= maxPINLen && val.length >= minPINLen )
		{
			document.getElementById("modifyUPIN").disabled = 0;
		}
		else
		{
			document.getElementById("modifyUPIN").disabled = 1;
		}
	}
	//modifyOPIN_div层PIN码检查
	else if( "old_oPIN" == elementID || "new_oPIN" == elementID || "verify_oPIN" == elementID )
	{
		if( val.length <= maxPINLen && val.length >= minPINLen )
		{
			document.getElementById("modifyOPIN").disabled = 0;
		}
		else
		{
			document.getElementById("modifyOPIN").disabled = 1;
		}
	}
	//unblockToken_div层PIN码检查
	else if( "oPIN" == elementID || "set_uPIN" == elementID || "verifyset_uPIN" == elementID )
	{
		if( val.length <= maxPINLen && val.length >= minPINLen )
		{
			document.getElementById("unblockToken").disabled = 0;
		}
		else
		{
			document.getElementById("unblockToken").disabled = 1;
		}
	}
	//initToken_div层PIN码检查
	else if( "os_PIN" == elementID || "new_uPIN_" == elementID || "verify_uPIN_" == elementID )
	{
		if( val.length <= maxPINLen && val.length >= minPINLen )
		{
			document.getElementById("initToken").disabled = 0;
		}
		else
		{
			document.getElementById("initToken").disabled = 1;
		}
	}
}
/*
 * 点击修改用户PIN码的“槽列表”
*/
function ModifyUPINSelectSlot()
{
	var currentSlotID = document.getElementById("modifyUPIN_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("modifyUPIN").disabled = 1;
}
/*
 * 点击“修改用户PIN码”
*/
function ModifyUPIN()
{
	//清空表单元素
	document.getElementById("old_uPIN").value = "";
	document.getElementById("new_uPIN").value = "";
	document.getElementById("verify_uPIN").value = "";

	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}
	else
	{
		if( "" == document.getElementById("modifyUPIN_div").style.display )
		{
			document.getElementById("modifyUPIN_div").style.display = "none";
		}
		else
		{
			document.getElementById("modifyUPIN_div").style.display = "";
			document.getElementById("old_uPIN").focus();
		}
	}
}
/*
 * 点击修改令牌名称的“槽列表”
*/
function ModifyTNSelectSlot()
{
	var currentSlotID = document.getElementById("modifyTN_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("modifyTN").disabled = 1;
}
/*
 * 检查Token名称长度
*/
function CheckTNLength(v)
{
	var elementID = event.srcElement.id;

	var val = document.getElementById(elementID).value;
	//initToken_div层TN检查
	if( "label" == elementID )
	{
		if( val.length <= 32 && 0 != val.Trim().length )
		{
			document.getElementById("initToken").disabled = 0;
		}
		else
		{
			document.getElementById("initToken").disabled = 1;
		}
	}
	//modifyTN_div层TN检查
	else if( "new_TN" == elementID )
	{
		if( val.length <= 32 && 0 != val.Trim().length )
		{
			document.getElementById("modifyTN").disabled = 0;
		}
		else
		{
			document.getElementById("modifyTN").disabled = 1;
		}
	}
}
/*
 * 点击“修改令牌名称”
*/
function ModifyTN()
{
	//清空表单元素
	document.getElementById("new_TN").value = "";

	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}
	else
	{
		if( "" == document.getElementById("modifyTN_div").style.display )
		{
			document.getElementById("modifyTN_div").style.display = "none";
		}
		else
		{
			document.getElementById("modifyTN_div").style.display = "";
			document.getElementById("new_TN").focus();
		}
	}		
}
/*
 * 点击修改管理员PIN码的“槽列表”
*/
function ModifyOPINSelectSlot()
{
	var currentSlotID = document.getElementById("ModifyOPIN_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("modifyOPIN").disabled = 1;
}
/*
 * 点击“修改管理员PIN码”
*/
function ModifyOPIN()
{
	//清空表单元素
	document.getElementById("old_oPIN").value = "";
	document.getElementById("new_oPIN").value = "";
	document.getElementById("verify_oPIN").value = "";

	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}
	else
	{
		if( "" == document.getElementById("modifyOPIN_div").style.display )
		{
			document.getElementById("modifyOPIN_div").style.display = "none";
		}
		else
		{
			document.getElementById("modifyOPIN_div").style.display = "";
			document.getElementById("old_oPIN").focus();
		}
	}
}
/*
 * 点击解锁令牌的“槽列表”
*/
function UnblockTokenSelectSlot()
{
	var currentSlotID = document.getElementById("UnblockToken_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("unblockToken").disabled = 1;
}
/*
 * 点击“令牌解锁”
*/
function UnblockToken()
{
	//清空表单元素
	document.getElementById("oPIN").value = "";
	document.getElementById("set_uPIN").value = "";
	document.getElementById("verifyset_uPIN").value = "";

	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}
	else
	{
		if( "" == document.getElementById("unblockToken_div").style.display )
		{
			document.getElementById("unblockToken_div").style.display = "none";
		}
		else
		{
			document.getElementById("unblockToken_div").style.display = "";
			document.getElementById("oPIN").focus();
		}
	}
}
/*
 * 点击初始化令牌的“槽列表”
*/
function InitTokenSelectSlot()
{
	var currentSlotID = document.getElementById("initToken_slotSel").value;
	document.getElementById("currentSlotID").value = currentSlotID;
	document.getElementById("initToken").disabled = 1;
}
/*
 * 点击“初始化令牌”
*/
function InitToken()
{
	//清空表单元素
	document.getElementById("os_PIN").value = "";
	document.getElementById("os_PIN").disabled = 1;
	document.getElementById("label").value = "";
	document.getElementById("label").disabled = 1;
	document.getElementById("new_uPIN_").value = "";
	document.getElementById("new_uPIN_").disabled = 1;
	document.getElementById("verify_uPIN_").value = "";
	document.getElementById("verify_uPIN_").disabled = 1;

	//检查卡是否插入
	if( 0 == document.getElementById("validSlotCount").value )
	{
		alert("请插入卡！");
		return ;
	}
	else
	{
		if( "" == document.getElementById("initToken_div").style.display )
		{
			document.getElementById("initToken_div").style.display = "none";
		}
		else
		{
			document.getElementById("initToken_div").style.display = "";
			document.getElementById("os_PIN").disabled = 0;
			document.getElementById("os_PIN").focus();
			document.getElementById("label").disabled = 0;
			document.getElementById("new_uPIN_").disabled = 0;
			document.getElementById("verify_uPIN_").disabled = 0;
		}
	}		
}
/*
 * 用户登录
*/
function onLogin()
{
	//检查是否输入PIN码
	var PIN = document.getElementById("PIN").value;
	if( "" ==  PIN)
	{
		alert("请输入PIN码！");
		document.getElementById("PIN").focus();
	}
	else
	{
		//登录
		var slotID = document.getElementById("login_slotSel").value;
		document.getElementById("currentSlotID").value = slotID;
		var desc = document.getElementById("loginStatus_" + slotID).value;
		var ret = Com11If.Login( slotID, PIN );
		if( false == ret )
		{
			var count = Com11If.GetPINTryCounter( slotID, 1);
			if( 0 == count)
			{
				alert("卡已经死锁！");
			}
			else if(0xFFFF == count)
			{
			    alert("Token异常！请重新插拔后重试！");
			}
			else
				alert("登录失败，你还有 "+count+"次机会！");
			document.getElementById("PIN").value = "";
			document.getElementById("PIN").focus();
			document.getElementById("isLogin_" + slotID).value = 0;
			//修改用户状态显示
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
		}
		else
		{
			alert("登录成功！");
			document.getElementById("isLogin_" + slotID).value = 1;
			//修改用户状态显示（已登录）
			document.getElementById("login_div").style.display = "none";
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽已登录";
			showObjectList(slotID);
		}
	}
}
/*
 * 修改用户PIN码
*/
function onModifyUPIN()
{
	var slotID = document.getElementById("modifyUPIN_slotSel").value;
	document.getElementById("currentSlotID").value = slotID;
	var maxPINLen = document.getElementById("maxPINLen_" + slotID).value;
	var minPINLen = document.getElementById("minPINLen_" + slotID).value;
	var desc = document.getElementById("loginStatus_" + slotID).value;
	
	var old_uPIN = document.getElementById("old_uPIN").value;
	var new_uPIN = document.getElementById("new_uPIN").value;
	var verify_uPIN = document.getElementById("verify_uPIN").value;
	if( "" == old_uPIN )
	{
		alert("请输入用户PIN码！");
		document.getElementById("old_uPIN").focus();
	}	
	else if( "" == new_uPIN || document.getElementById("new_uPIN").value.length > maxPINLen || document.getElementById("new_uPIN").value.length < minPINLen)
	{
		alert("请输入新的用户PIN码！" + "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("new_uPIN").value = "";
		document.getElementById("verify_uPIN").value = "";
		document.getElementById("new_uPIN").focus();
	}
	else if( "" == verify_uPIN )
	{
		alert("请确认用户PIN码！" + "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("verify_uPIN").value = "";
		document.getElementById("verify_uPIN").focus();
	}
	else if( new_uPIN != verify_uPIN )
	{
		alert("用户PIN码不一致，请重新输入！");
		document.getElementById("new_uPIN").value = "";
		document.getElementById("verify_uPIN").value = "";
		document.getElementById("new_uPIN").focus();
	}
	else
	{
		//修改用户PIN码
		var desc = document.getElementById("loginStatus_" + slotID).value;
		ret = Com11If.ModifyUPIN( slotID, old_uPIN, new_uPIN );
		if( false == ret )
		{
			var count = Com11If.GetPINTryCounter( slotID, 1);
			if( 0 == count)
			{
				alert("卡已经死锁！");
			}
			else if(0xFFFF == count)
			{
			    alert("Token异常！请重新插拔后重试！");
			}
			else
				alert("修改用户PIN码失败！原PIN码错误，你还有"+count+"次机会！");
			document.getElementById("isLogin_" + slotID).value = 0;
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
			document.getElementById("old_uPIN").value = "";
			document.getElementById("new_uPIN").value = "";
			document.getElementById("verify_uPIN").value = "";
			document.getElementById("old_uPIN").focus();
		}
		else
		{
			alert("修改用户PIN码成功！");
			document.getElementById("isLogin_" + slotID).value = 1;
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽已登录";
			document.getElementById("modifyUPIN_div").style.display = "none";
		}
		showObjectList(slotID);
	}
}
/*
 * 修改令牌名称
*/
function onModifyTN()
{
	var label = document.getElementById("new_TN").value;
	
	if( "" == label || document.getElementById("new_TN").value.length>32)
	{
		alert("请输入新的令牌名称！(最大32字符,不能以空格结尾)");
		document.getElementById("new_TN").focus();
	}
	else
	{
		//修改令牌名称
		var slotID = document.getElementById("modifyTN_slotSel").value;
		document.getElementById("currentSlotID").value = slotID;
		ret = Com11If.ChangeTokenName(slotID, label);
		if( true == ret )
		{
			alert("修改令牌名称成功！");
			document.getElementById("modifyTN_div").style.display = "none";
			showTokenInfo(slotID);		
		}
		else
		{
			alert("修改令牌名称失败！");
			document.getElementById("new_TN").value = "";
			document.getElementById("new_TN").focus();
		}
	}
}
/*
 * 修改管理员PIN码
*/
function onModifyOPIN()
{
	var slotID = document.getElementById("modifyOPIN_slotSel").value;
	document.getElementById("currentSlotID").value = slotID;
	var maxPINLen = document.getElementById("maxPINLen_" + slotID).value;
	var minPINLen = document.getElementById("minPINLen_" + slotID).value;
	var desc = document.getElementById("loginStatus_" + slotID).value;

	var old_oPIN = document.getElementById("old_oPIN").value;
	var new_oPIN = document.getElementById("new_oPIN").value;
	var verify_oPIN = document.getElementById("verify_oPIN").value;
	
	if( "" == old_oPIN )
	{
		alert("请输入管理员PIN码！");
		document.getElementById("old_oPIN").focus();
	}
	else if( "" == new_oPIN || document.getElementById("new_oPIN").value.length > maxPINLen || document.getElementById("new_oPIN").value.length < minPINLen )
	{
		alert("请输入新的管理员PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("new_oPIN").value = "";
		document.getElementById("verify_oPIN").value = "";
		document.getElementById("new_oPIN").focus();
	}
	else if( "" == verify_oPIN )
	{
		alert("请确认管理员PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("verify_oPIN").value = "";
		document.getElementById("verify_oPIN").focus();
	}
	else if( new_oPIN != verify_oPIN )
	{
		alert("管理员PIN码不一致，请重新输入！");
		document.getElementById("new_oPIN").value = "";
		document.getElementById("verify_oPIN").value = "";
		document.getElementById("new_oPIN").focus();
	}
	else
	{
		//修改管理员PIN码	
		var desc = document.getElementById("loginStatus_" + slotID).value;
		ret = Com11If.ModifyOPIN( slotID, old_oPIN, new_oPIN );
		if( false == ret )
		{
			var count = Com11If.GetPINTryCounter( slotID, 0 );
			if( 0 == count)
			{
				alert("卡已经死锁！");
			}
			else if(0xFFFF == count)
			{
			    alert("Token异常！请重新插拔后重试！");
			}
			else
			{
				alert("修改管理员PIN码失败！原管理员PIN码错误，你还有"+count+"次机会！");
			}
			document.getElementById("isLogin_" + slotID).value = 0;
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
			document.getElementById("old_oPIN").value = "";
			document.getElementById("new_oPIN").value = "";
			document.getElementById("verify_oPIN").value = "";
			document.getElementById("old_oPIN").focus();
		}
		else
		{
			alert("修改管理员PIN码成功！");
			document.getElementById("isLogin_" + slotID).value = 0;
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
			document.getElementById("modifyOPIN_div").style.display = "none";
		}
		showObjectList(slotID);
	}
}
/*
 * 解锁令牌
*/
function onUnblockToken()
{
	var slotID = document.getElementById("unblockToken_slotSel").value;
	document.getElementById("currentSlotID").value = slotID;
	var maxPINLen = document.getElementById("maxPINLen_" + slotID).value;
	var minPINLen = document.getElementById("minPINLen_" + slotID).value;
	var desc = document.getElementById("loginStatus_" + slotID).value;

	var oPIN = document.getElementById("oPIN").value;
	var set_uPIN = document.getElementById("set_uPIN").value;
	var verifyset_uPIN = document.getElementById("verifyset_uPIN").value;
	if( "" == oPIN )
	{
		alert("请输入管理员PIN码！");
		document.getElementById("oPIN").focus();
	}
	else if( "" == set_uPIN || document.getElementById("set_uPIN").value.length > maxPINLen || document.getElementById("set_uPIN").value.length < minPINLen)
	{
		alert("请输入新的用户PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("set_uPIN").value = "";
		document.getElementById("verifyset_uPIN").value = "";
		document.getElementById("set_uPIN").focus();
	}
	else if( "" == verifyset_uPIN )
	{
		alert("请确认用户PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("verifyset_uPIN").value = "";
		document.getElementById("verifyset_uPIN").focus();
	}
	else if( set_uPIN != verifyset_uPIN )
	{
		alert("用户PIN码不一致，请重新输入！");
		document.getElementById("set_uPIN").value = "";
		document.getElementById("verifyset_uPIN").value = "";
		document.getElementById("set_uPIN").focus();
	}
	else
	{
		//解锁令牌
		var desc = document.getElementById("loginStatus_" + slotID).value;
		var slotID = document.getElementById("unblockToken_slotSel").value;
		ret = Com11If.UnblockToken( slotID, oPIN, set_uPIN );
		if( true == ret )
		{
			alert("令牌解锁成功！");
			document.getElementById("unblockToken_div").style.display = "none";
			//修改用户状态显示（未登录）
			document.getElementById("login_div").style.display = "none";
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
			showSlotList(0);
		}
		else
		{
		    var count = Com11If.GetPINTryCounter( slotID, 0 );
		    if(0 == ret &&0 == count )
			{
				alert("管理员PIN码已死锁！");
			}
			else if(0xFFFF == ret)
			{
				alert("无法执行此操作。");
			}
			else if(0xFFFE == ret)
			{
				alert("您的管理员PIN码被锁定了!");
			}
			else if(0xFFFD == ret)
			{
				alert("您还有最后一次机会输入您的管理员PIN码,假如再次输入错误，您的令牌将被锁住!");
			}
			else
			{
				alert("对不起，您输入的管理员PIN码无法通过验证，请重新输入！剩余验证次数为" + count + "次。");
			}
			document.getElementById("oPIN").value = "";
			document.getElementById("set_uPIN").value = "";
			document.getElementById("verifyset_uPIN").value = "";
			document.getElementById("oPIN").focus();
		}
		//修改显示页面的用户状态（未登录）
		document.getElementById("isLogin_"+slotID).value = 0;
		document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";
	}
}
/*
 * 初始化令牌
*/
function onInitToken()
{
	var slotID = document.getElementById("initToken_slotSel").value;
	document.getElementById("currentSlotID").value = slotID;
	
	var osPIN = document.getElementById("os_PIN").value;
	var newPIN = document.getElementById("new_uPIN_").value;
	var verifyPIN = document.getElementById("verify_uPIN_").value;
	var label = document.getElementById("label").value;
	
	var maxPINLen = document.getElementById("maxPINLen_" + slotID).value;
	var minPINLen = document.getElementById("minPINLen_" + slotID).value;
	
	if( "" == osPIN)
	{
		alert("请输入管理员PIN码！");
		document.getElementById("os_PIN").focus();
	}
	else if( "" == label || document.getElementById("label").value.length>32)
	{
		alert("请输入令牌标签！(最大32字符,不能以空格结尾)");
		document.getElementById("label").value = "";
		document.getElementById("label").focus();
	}
	else if( "" == newPIN || document.getElementById("new_uPIN_").value.length > maxPINLen || document.getElementById("new_uPIN_").value.length < minPINLen)
	{
		alert("请输入新的用户PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("new_uPIN_").value = "";
		document.getElementById("verify_uPIN_").value = "";
		document.getElementById("new_uPIN_").focus();
	}
	else if( "" == verifyPIN || document.getElementById("verify_uPIN_").value.length > maxPINLen || document.getElementById("verify_uPIN_").value.length < minPINLen)
	{
		alert("请确认新用户PIN码！"+ "(" + minPINLen + "-" + maxPINLen +"字符" +")" );
		document.getElementById("verify_uPIN_").value = "";
		document.getElementById("verify_uPIN_").focus();
	}
	else if( newPIN != verifyPIN )
	{
		alert("PIN码不一致，请重新输入！");
		document.getElementById("new_uPIN_").value = "";
		document.getElementById("verify_uPIN_").value = "";
		document.getElementById("new_uPIN_").focus();
	}
	else
	{
		//初始化令牌
		var ret = Com11If.InitToken( slotID, osPIN, newPIN, label );
		if( true == ret )
		{
			var ret = Com11If.Login( slotID, newPIN );
			if( false == ret )
			{
				alert("初始化令牌成功，但用户登陆失败！");
			}
			else
			{
				alert("初始化令牌成功！");
				document.getElementById("initToken_div").style.display = "none";
				//修改显示页面的用户状态（已登录）
				document.getElementById("isLogin_" + slotID).value = 1;
				var desc = document.getElementById("loginStatus_" + slotID).value;
				document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽已登录";
			}
		}
		else
		{
			var count = Com11If.GetPINTryCounter( slotID, 0 );
		    if(0 == ret &&0 == count )
			{
				alert("管理员PIN码已死锁！");
			}
			else if(0xFFFF == ret)
			{
				alert("无法执行此操作。");
			}
			else if(0xFFFE == ret)
			{
				alert("您的管理员PIN码被锁定了!");
			}
			else if(0xFFFD == ret)
			{
				alert("您还有最后一次机会输入您的管理员PIN码,假如再次输入错误，您的令牌将被锁住!");
			}
			else
			{
				alert("对不起，您输入的管理员PIN码无法通过验证，请重新输入！剩余验证次数为" + count + "次。");
			}
			document.getElementById("os_PIN").value = "";
			document.getElementById("new_uPIN_").value = "";
			document.getElementById("verify_uPIN_").value = "";
			document.getElementById("os_PIN").focus();
			document.getElementById("isLogin_" + slotID).value = 0;
			var desc = document.getElementById("loginStatus_" + slotID).value;
			document.getElementById("loginStatus_" + slotID).value = desc.substring(0, desc.indexOf("槽")) + "槽未登录";		
		}
	}
	
	showObjectList(slotID);
}
/*
 * 清除页面显示
*/
function clearShow()
{
	document.getElementById("noneInfo_div").style.display = "none";
	document.getElementById("navigation_div").style.display = "none";
	
	//清除槽列表层
	clearSlotLinksDiv();
	//清除槽信息层
	clearSlotInfoDiv();
	//清除令牌信息层
	clearTokenInfoDiv();
	//清除对象列表层
	clearObjectListDiv();
	//清除对象信息层
	clearObjectInfoDiv();
	//清除槽下拉列表
	clearSlotSel();
}
/*
 * 清除槽列表层
*/
function clearSlotLinksDiv()
{
	//清除内容
	document.getElementById("slotlabel").innerHTML = "";
	document.getElementById("slotLinks_div").innerHTML = "";
	
	//清除显示
	document.getElementById("slotLinks_div").style.display = "none";
}
/*
 * 清除槽信息层
*/
function clearSlotInfoDiv()
{
	//清除内容
	document.getElementById("slotInfo_div").innerHTML = "";
	
	//清除显示
	document.getElementById("slotInfo_div").style.display = "none";
}
/*
 * 清除令牌信息层
*/
function clearTokenInfoDiv()
{
	//清除内容
	document.getElementById("Token_Title").innerHTML = "";
	document.getElementById("Token_Label").innerHTML = "";
	document.getElementById("Token_ManufacturerID").innerHTML = "";
	document.getElementById("Token_Model").innerHTML = "";
	document.getElementById("Token_SerialNumber").innerHTML = "";
	document.getElementById("Token_Flags").innerHTML = "";
	document.getElementById("Token_MaxSessionCount").innerHTML = "";
	document.getElementById("Token_SessionCount").innerHTML = "";
	document.getElementById("Token_MaxRwSessionCount").innerHTML = "";
	document.getElementById("Token_RwSessionCount").innerHTML = "";
	document.getElementById("Token_MaxPinLen").innerHTML = "";
	document.getElementById("Token_MinPinLen").innerHTML = "";
	document.getElementById("Token_TotalPublicMemory").innerHTML = "";
	document.getElementById("Token_FreePublicMemory").innerHTML = "";
	document.getElementById("Token_TotalPrivateMemory").innerHTML = "";
	document.getElementById("Token_FreePrivateMemory").innerHTML = "";
	document.getElementById("Token_HardwareVersion").innerHTML = "";
	document.getElementById("Token_FirmwareVersion").innerHTML = "";
	
	//清除显示
	document.getElementById("tokenInfo_div").style.display = "none";
}
/*
 * 清除对象列表层
*/
function clearObjectListDiv()
{
	//清除显示
	document.getElementById("objectList_div").style.display = "none";
}
/*
 * 清除对象信息层
*/
function clearObjectInfoDiv()
{
	//清除内容
	document.getElementById("attri_len_0").innerHTML = "";
	document.getElementById("attri_len_1").innerHTML = "";
	document.getElementById("attri_len_2").innerHTML = "";
	document.getElementById("attri_len_3").innerHTML = "";
	document.getElementById("attri_len_10").innerHTML = "";
	document.getElementById("attri_len_80").innerHTML = "";
	document.getElementById("attri_len_82").innerHTML = "";
	document.getElementById("attri_len_86").innerHTML = "";
	document.getElementById("attri_len_100").innerHTML = "";
	document.getElementById("attri_len_101").innerHTML = "";
	document.getElementById("attri_len_102").innerHTML = "";
	document.getElementById("attri_len_103").innerHTML = "";
	document.getElementById("attri_len_104").innerHTML = "";
	document.getElementById("attri_len_105").innerHTML = "";
	document.getElementById("attri_len_106").innerHTML = "";
	document.getElementById("attri_len_107").innerHTML = "";
	document.getElementById("attri_len_108").innerHTML = "";
	document.getElementById("attri_len_109").innerHTML = "";
	document.getElementById("attri_len_10A").innerHTML = "";
	document.getElementById("attri_len_10B").innerHTML = "";
	document.getElementById("attri_len_10C").innerHTML = "";
	document.getElementById("attri_len_110").innerHTML = "";
	document.getElementById("attri_len_111").innerHTML = "";
	document.getElementById("attri_len_120").innerHTML = "";
	document.getElementById("attri_len_121").innerHTML = "";
	document.getElementById("attri_len_122").innerHTML = "";
	document.getElementById("attri_len_123").innerHTML = "";
	document.getElementById("attri_len_124").innerHTML = "";
	document.getElementById("attri_len_125").innerHTML = "";
	document.getElementById("attri_len_126").innerHTML = "";
	document.getElementById("attri_len_127").innerHTML = "";
	document.getElementById("attri_len_128").innerHTML = "";
	document.getElementById("attri_len_162").innerHTML = "";
	document.getElementById("attri_len_163").innerHTML = "";
	document.getElementById("attri_len_164").innerHTML = "";
	document.getElementById("attri_len_165").innerHTML = "";
	document.getElementById("attri_len_170").innerHTML = "";
	document.getElementById("attri_len_80455053").innerHTML = "";
	document.getElementById("attri_len_11").innerHTML = "";
	
	document.getElementById("valuearea_0").value = "";
	document.getElementById("valuearea_1").value = "";
	document.getElementById("valuearea_2").value = "";
	document.getElementById("valuearea_3").value = "";
	document.getElementById("valuearea_10").value = "";
	document.getElementById("valuearea_80").value = "";
	document.getElementById("valuearea_82").value = "";
	document.getElementById("valuearea_86").value = "";
	document.getElementById("valuearea_100").value = "";
	document.getElementById("valuearea_101").value = "";
	document.getElementById("valuearea_102").value = "";
	document.getElementById("valuearea_103").value = "";
	document.getElementById("valuearea_104").value = "";
	document.getElementById("valuearea_105").value = "";
	document.getElementById("valuearea_106").value = "";
	document.getElementById("valuearea_107").value = "";
	document.getElementById("valuearea_108").value = "";
	document.getElementById("valuearea_109").value = "";
	document.getElementById("valuearea_10A").value = "";
	document.getElementById("valuearea_10B").value = "";
	document.getElementById("valuearea_10C").value = "";
	document.getElementById("valuearea_110").value = "";
	document.getElementById("valuearea_111").value = "";
	document.getElementById("valuearea_120").value = "";
	document.getElementById("valuearea_121").value = "";
	document.getElementById("valuearea_122").value = "";
	document.getElementById("valuearea_123").value = "";
	document.getElementById("valuearea_124").value = "";
	document.getElementById("valuearea_125").value = "";
	document.getElementById("valuearea_126").value = "";
	document.getElementById("valuearea_127").value = "";
	document.getElementById("valuearea_128").value = "";
	document.getElementById("valuearea_162").value = "";
	document.getElementById("valuearea_163").value = "";
	document.getElementById("valuearea_164").value = "";
	document.getElementById("valuearea_165").value = "";
	document.getElementById("valuearea_170").value = "";
	document.getElementById("valuearea_80455053").value = "";
	document.getElementById("valuearea_11").value = "";
	
	//清除显示
	document.getElementById("objectInfo_div").style.display = "none";
}
/*
 * 清除槽下拉列表
*/
function clearSlotSel()
{
	//清空“用户登录”的槽下拉列表
	var i=0;
	while(( i=document.getElementById("login_slotSel").options.length)>0)
  		document.getElementById("login_slotSel").options.remove(0);
	//清空“修改用户PIN码”的槽下拉列表
	i=0;
	while(( i=document.getElementById("modifyUPIN_slotSel").options.length)>0)
  		document.getElementById("modifyUPIN_slotSel").options.remove(0);
	//清空“修改令牌名称”的槽下拉列表
	i=0;
	while(( i=document.getElementById("modifyTN_slotSel").options.length)>0)
  		document.getElementById("modifyTN_slotSel").options.remove(0);
	//清空“修改管理员PIN码”的槽下拉列表
	i=0;
	while(( i=document.getElementById("modifyOPIN_slotSel").options.length)>0)
  		document.getElementById("modifyOPIN_slotSel").options.remove(0);
	//清空“令牌解锁”的槽下拉列表
	i=0;
	while(( i=document.getElementById("unblockToken_slotSel").options.length)>0)
  		document.getElementById("unblockToken_slotSel").options.remove(0);
	//清空“初始化令牌”的槽下拉列表
	i=0;
	while(( i=document.getElementById("initToken_slotSel").options.length)>0)
  		document.getElementById("initToken_slotSel").options.remove(0);
}
/*
 * 获取槽列表
*/
function showSlotList(flag)
{
	clearShow();

	//pageCtrl_div层 
	document.getElementById("pageCtrl_div").innerHTML = "";
	document.getElementById("pageCtrl_div").innerHTML += "<input type='hidden' id='validSlotCount' name='validSlotCount' value='0' >";
	document.getElementById("pageCtrl_div").innerHTML += "<input type='hidden' id='currentSlotID' name='currentSlotID' value='0' >";

	//查询所有已插入卡的槽列表
	var currentSlotID = 0;				//当前操作的智能卡ID
	var slotList = Com11If.GetSlotList();
	if( null != slotList )
	{
		//修改槽列表显示信息
		document.getElementById("slotLinks_div").style.display = "";
		document.getElementById("slotlabel").innerHTML = "已插入卡的槽列表";
		
		//将获取到的槽列表转换成数组，存储到全局变量g_slotIDs中
		var slotIDs = new VBArray( slotList ).toArray();
		var slotCount = slotIDs.length;	//已插入的智能卡数量
		var slotID = 0;
		//画槽信息隐藏域
		for( var i=0; i<slotCount; i++ )
		{
			slotID = slotIDs[i];
			//pageCtrl_div层 type='hidden' 
			document.getElementById("pageCtrl_div").innerHTML += "<input type='hidden' id='validSlotID_" + i + "' name='validSlotID_" + i + "' value='0' >";
			//pageDetailCtrl_div层
			if( null == document.getElementById('isLogin_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='isLogin_" + slotID + "' name='isLogin_" + slotID + "' value='0' >";
			}
			else if( 1 == flag )
			{
				document.getElementById("isLogin_"+slotID).value = 0;
			}
			if( null == document.getElementById('maxPINLen_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='maxPINLen_" + slotID + "' name='maxPINLen_" + slotID + "' value='0' >";
			}
			else if( 1 == flag )
			{
				document.getElementById("maxPINLen_"+slotID).value = 0;
			}
			if( null == document.getElementById('minPINLen_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='hidden' id='minPINLen_" + slotID + "' name='minPINLen_" + slotID + "' value='0' >";
			}
			else if( 1 == flag )
			{
				document.getElementById("minPINLen_"+slotID).value = 0;
			}
			//userStatus_div层
			if( null == document.getElementById('loginStatus_'+slotID) )
			{
				document.getElementById("userStatus_div").innerHTML += "<input id='loginStatus_" + slotID + "' name='loginStatus_" + slotID + "' value='' readonly='1'>";
			}
			else if( 1 == flag )
			{
				document.getElementById("loginStatus_"+slotID).value = 0;
			}
		}

		//将槽列表信息存入隐藏域
		document.getElementById("validSlotCount").value = slotCount;
		
		if( slotCount > 0 )
		{
			//遍历卡的当前状态，选第一个已插入的卡为当前卡
			for( var i=0; i<slotCount; i++ )
			{
				slotID = slotIDs[i];
				
				if( 0 == i )
				{
					currentSlotID = slotID;
				}

				//将槽列表信息存入隐藏域
				var tokenInfo = Com11If.GetTokenInfo(slotID);
				if( tokenInfo )
				{
					document.getElementById("validSlotID_" + i ).value = slotID;
					document.getElementById("maxPINLen_" + slotID).value = tokenInfo.GetMaxPinLen();
					document.getElementById("minPINLen_" + slotID).value = tokenInfo.GetMinPinLen();
				}
				
				//获取槽信息
				var slotInfo = Com11If.GetSlotInfo(slotID);
				if( slotInfo )
				{
					if( 1 == document.getElementById('isLogin_'+slotID).value )
					{
						document.getElementById("loginStatus_" + slotID).value = slotInfo.GetSlotDescription().replace(/[ ]/g,"") + "  槽已登录";
					}
					else
					{
						document.getElementById("loginStatus_" + slotID).value = slotInfo.GetSlotDescription().replace(/[ ]/g,"") + "  槽未登录";
					}

					//初始化槽列表
					document.getElementById("slotLinks_div").innerHTML += "<a id='slotDesc_"+slotID+"' style='display:none;' href='#' onclick='showTokenInfo("+slotID+")' ></a>";
					document.getElementById("slotLinks_div").innerHTML += "<a id='slotData_"+slotID+"' style='display:none;' href='#' onclick='showObjectList("+slotID+")'></a>";
					document.getElementById("slotDesc_"+slotID).style.display = "";
					document.getElementById("slotDesc_"+slotID).innerHTML = slotInfo.GetSlotDescription();
					document.getElementById("slotData_"+slotID).style.display = "";
					document.getElementById("slotData_"+slotID).innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;Data";

					//初始化槽下拉列表
					var slotDescription = slotInfo.GetSlotDescription();
					//初始化“用户登录”的槽下拉列表
					var login_objectItem = new Option(slotDescription, slotID);
					document.getElementById("login_slotSel").options.add(login_objectItem);
					//初始化“修改用户PIN码”的槽下拉列表
					var modifyUPIN_objectItem = new Option(slotDescription, slotID);
					document.getElementById("modifyUPIN_slotSel").options.add(modifyUPIN_objectItem);
					//初始化“修改令牌名称”的槽下拉列表
					var modifyTN_objectItem = new Option(slotDescription, slotID);
					document.getElementById("modifyTN_slotSel").options.add(modifyTN_objectItem);
					//初始化“修改管理员PIN码”的槽下拉列表
					var modifyOPIN_objectItem = new Option(slotDescription, slotID);
					document.getElementById("modifyOPIN_slotSel").options.add(modifyOPIN_objectItem);
					//初始化“令牌解锁”的槽下拉列表
					var unblockToken_objectItem = new Option(slotDescription, slotID);
					document.getElementById("unblockToken_slotSel").options.add(unblockToken_objectItem);
					//初始化“初始化令牌”的槽下拉列表
					var initToken_objectItem = new Option(slotDescription, slotID);
					document.getElementById("initToken_slotSel").options.add(initToken_objectItem);

					document.getElementById("navigation_div").style.display = "";
					
					document.getElementById("slotLinks_div").style.display = "";
				}
			}
			document.getElementById("currentSlotID").value = currentSlotID;
		}
		showSlotInfo();
	}
	else
	{
		document.getElementById("slotLinks_div").style.display = "none";
		document.getElementById("slotlabel").innerHTML = "当前无卡！";
		
		document.getElementById("noneInfo_div").style.display = "";
		document.getElementById("slotLinks_div").style.display = "none";
		document.getElementById("userStatus_div").style.display = "none";		
		document.getElementById("login_div").style.display = "none";		
		document.getElementById("navigation_div").style.display = "none";
		document.getElementById("modifyUPIN_div").style.display = "none";
		document.getElementById("modifyTN_div").style.display = "none";
		document.getElementById("modifyOPIN_div").style.display = "none";
		document.getElementById("unblockToken_div").style.display = "none";
		document.getElementById("initToken_div").style.display = "none";
	}
}
/*
 * 显示槽信息
*/
function showSlotInfo()
{
	var nRet = 0;
	var validSlotCount = document.getElementById("validSlotCount").value;
	var slotInfoDivObj = document.getElementById("slotInfo_div");
	slotInfoDivObj.style.display = "";
	slotInfoDivObj.innerHTML = "";
	
	for( var i=0; i<validSlotCount; i++ )
	{
		var slotID = document.getElementById("validSlotID_" + i).value;
		var slotInfo = Com11If.GetSlotInfo(slotID);
		if( slotInfo )
		{
			//画slotInfo_div层
			slotInfoDivObj.innerHTML += "<h2><a href='#' id='Slot_Title_" + i + "' onclick=showTokenInfo(" + slotID + ");></a></h2>";
			slotInfoDivObj.innerHTML += "<code id='Slot_Description_" + i + "'></code>";
			slotInfoDivObj.innerHTML += "<code id='Slot_ManufacturerID_" + i + "'></code>";
			slotInfoDivObj.innerHTML += "<code id='Slot_Flags_" + i + "'></code>";
			slotInfoDivObj.innerHTML += "<code id='Slot_HardwareVersion_" + i + "'></code>";
			slotInfoDivObj.innerHTML += "<code id='Slot_FirmwareVersion_" + i + "'></code>";
			
			//填内容
			document.getElementById("Slot_Title_" + i).innerHTML = slotInfo.GetSlotDescription() + "槽信息";
			document.getElementById("Slot_Description_" + i).innerHTML = "<pre>描述 [SlotDescription]			" + slotInfo.GetSlotDescription() + "</pre>";
			document.getElementById("Slot_ManufacturerID_" + i).innerHTML = "<pre>厂商ID [ManufacturerID]			" + slotInfo.GetManufacturerID() + "</pre>";
			document.getElementById("Slot_Flags_" + i).innerHTML = "<pre>标记 [Flags]				" + slotInfo.GetFlags() + "</pre>";
			document.getElementById("Slot_HardwareVersion_" + i).innerHTML = "<pre>硬件版本 [HardwareVersion]		" + slotInfo.GetHardwareVersion() + "</pre>";
			document.getElementById("Slot_FirmwareVersion_" + i).innerHTML = "<pre>固件版本 [FirmwareVersion]		" + slotInfo.GetFirmwareVersion() + "</pre>";
		}
	}
}
/*
 * 显示令牌信息
*/
function showTokenInfo(slotID)
{
	clearSlotInfoDiv();
	clearTokenInfoDiv();
	clearObjectListDiv();
	clearObjectInfoDiv();
	
	document.getElementById("currentSlotID").value = slotID;
	
	document.getElementById("slotLinks_div").style.display = "";
	document.getElementById("slotDesc_"+slotID).style.display = "";
	document.getElementById("slotData_"+slotID).style.display = "";
	
	document.getElementById("navigation_div").style.display = "";
	document.getElementById("tokenInfo_div").style.display = "";

	var tokenInfo = Com11If.GetTokenInfo(slotID);
	if( tokenInfo )
	{
		document.getElementById("Token_Title").innerHTML = tokenInfo.GetLabel() + " 令牌信息";
		document.getElementById("Token_Label").innerHTML = tokenInfo.GetLabel();
		document.getElementById("Token_ManufacturerID").innerHTML = tokenInfo.GetManufacturerID();
		document.getElementById("Token_Model").innerHTML = tokenInfo.GetModel();
		document.getElementById("Token_SerialNumber").innerHTML = tokenInfo.GetSerialNumber();
		document.getElementById("Token_Flags").innerHTML = tokenInfo.GetFlags();
		document.getElementById("Token_MaxSessionCount").innerHTML = tokenInfo.GetMaxSessionCount();
		document.getElementById("Token_SessionCount").innerHTML = tokenInfo.GetSessionCount();
		document.getElementById("Token_MaxRwSessionCount").innerHTML = tokenInfo.GetMaxRwSessionCount();
		document.getElementById("Token_RwSessionCount").innerHTML = tokenInfo.GetRwSessionCount();
		document.getElementById("Token_MaxPinLen").innerHTML = tokenInfo.GetMaxPinLen();
		document.getElementById("Token_MinPinLen").innerHTML = tokenInfo.GetMinPinLen();
		document.getElementById("Token_TotalPublicMemory").innerHTML = tokenInfo.GetTotalPublicMemory();
		document.getElementById("Token_FreePublicMemory").innerHTML = tokenInfo.GetFreePublicMemory();
		document.getElementById("Token_TotalPrivateMemory").innerHTML = tokenInfo.GetTotalPrivateMemory();
		document.getElementById("Token_FreePrivateMemory").innerHTML = tokenInfo.GetFreePrivateMemory();
		document.getElementById("Token_HardwareVersion").innerHTML = tokenInfo.GetHardwareVersion();
		document.getElementById("Token_FirmwareVersion").innerHTML = tokenInfo.GetFirmwareVersion();
	}
}

/*
 * 获取对象ID
*/
function getObjectID(attributes)
{
	var strObjectID = "";
	var n = attributes.GetItemCount();
	for( var i=0; i<n; i++ )
	{
		var vb_attri = null;
		vb_attri = new VBArray( attributes.GetAttributeValue(i) );
		
		if( vb_attri )
		{
			var attri_value = vb_attri.toArray();
			var strAttType = attributes.GetAttributeType(i);
	     	var unAttType;
	     	unAttType = strAttType>>>0; //转换成无符号整数
			switch(unAttType)
			{
			case 0x00000000:		//CKA_CLASS
				break;
			case 0x00000001:		//CKA_TOKEN
				break;
			case 0x00000002:		//CKA_PRIVATE
				break;
			case 0x00000003:		//CKA_LABEL
				break;
			case 0x00000010:		//CKA_APPLICATION
				break;
			case 0x00000011:		//CKA_VALUE
				break;
			case 0x00000080:		//CKA_CERTIFICATE_TYPE
				break;
			case 0x00000081:		//CKA_ISSUER
				break;
			case 0x00000082:		//CKA_SERIAL_NUMBER
				break;
			case 0x00000100:		//CKA_KEY_TYPE
				break;
			case 0x00000101:		//CKA_SUBJECT
				break;
			case 0x00000102:		//CKA_ID
				//strObjectID = showAttributeValueInString(attri_value);
				break;
			case 0x00000103:		//CKA_SENSITIVE
				break;
			case 0x00000104:		//CKA_ENCRYPT
				break;
			case 0x00000105:		//CKA_DECRYPT
				break;
			case 0x00000106:		//CKA_WRAP
				break;
			case 0x00000107:		//CKA_UNWRAP
				break;
			case 0x00000108:		//CKA_SIGN
				break;
			case 0x00000109:		//CKA_SIGN_RECOVER
				break;
			case 0x0000010A:		//CKA_VERIFY
				break;
			case 0x0000010B:		//CKA_VERIFY_RECOVER
				break;
			case 0x0000010C:		//CKA_DERIVE
				break;
			case 0x00000110:		//CKA_START_DATE
				break;
			case 0x00000111:		//CKA_END_DATE
				break;
			case 0x00000120:		//CKA_MODULUS
				break;
			case 0x00000121:		//CKA_MODULUS_BITS
				break;
			case 0x00000122:		//CKA_PUBLIC_EXPONENT
				break;
			case 0x00000123:		//CKA_PRIVATE_EXPONENT
				break;
			case 0x00000124:		//CKA_PRIME_1
				break;
			case 0x00000125:		//CKA_PRIME_2
				break;
			case 0x00000126:		//CKA_EXPONENT_1
				break;
			case 0x00000127:		//CKA_EXPONENT_2
				break;
			case 0x00000128:		//CKA_COEFFICIENT
				break;
			case 0x00000162:		//CKA_EXTRACTABLE
				break;
			case 0x00000163:		//CKA_LOCAL
				break;
			case 0x00000164:		//CKA_NEVER_EXTRACTABLE
				break;
			case 0x00000165:		//CKA_ALWAYS_SENSITIVE
				break;
			case 0x00000170:		//CKA_MODIFIABLE
				break;
			case 0x80455053:		//CKA_CONTAINER_NAME
			    strObjectID = showAttributeValueInString(attri_value);
				break;
			default:
				break;
			}
		}
	}
	
	return strObjectID;
}
/*
 * 显示令牌对象列表
*/
function showObjectList(slotID)
{
	g_data = slotID;
	clearSlotInfoDiv();
	clearTokenInfoDiv();
	clearObjectListDiv();
	clearObjectInfoDiv();

	document.getElementById("slotLinks_div").style.display = "";
//	document.getElementById("slotDesc_"+slotID).style.display = "";
//	document.getElementById("slotData_"+slotID).style.display = "";
	
	document.getElementById("navigation_div").style.display = "";
	
	document.getElementById("objectList_div").style.display = "";
	
	document.getElementById("objectList_div").innerHTML = "";
	document.getElementById("objectList_div").innerHTML += "<h3> 对象列表 </h3><br>";
	
	document.getElementById("currentSlotID").value = slotID;

	// 保存当前数据对象的句柄 
	document.getElementById("objectList_div").innerHTML += "<input type='hidden' value='' id='hObjSelected' />";
	document.getElementById("objectList_div").innerHTML += "<table border='1'>";
	//cellpadding='1' cellspacing='1' summary='' width='50%'
	//连接
	var h = Com11If.OpenSession(slotID);
	var objects = null;
	//查找数据对象(CKO_DATA)
	objects = Com11If.EnumObject( slotID, 0, 0 );
	if( null != objects )
	{
//		document.getElementById("CKO_DATA").style.display = "";
		document.getElementById("objectList_div").innerHTML += "<tr valign='top' id='CKO_DATA'>";
		document.getElementById("objectList_div").innerHTML += "<td class='storyLeft'>数据对象 [CKO_DATA]</td>";
		var objs = new VBArray( objects ).toArray();
		for( var i=0; i<objs.length; i++ )
		{
			var attributes = Com11If.GetObjectAttribute( slotID, 0, objs[i] );
			document.getElementById("objectList_div").innerHTML += "<h1>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#'onclick='selectObj(" + objs[i] + ")' ondblclick='showObjectInfo(0, " + objs[i] + ")'>" + getObjectID(attributes) + "</a></h1>";
		}
		document.getElementById("objectList_div").innerHTML += "</tr>";
		document.getElementById("objectList_div").innerHTML += "<br>";
	}
	//查找证书对象(CKO_CERTIFICATE)class='storyLeft'
	objects = Com11If.EnumObject( slotID, 1, 0 );
	if( null != objects )
	{
//		document.getElementById("CKO_CERTIFICATE").style.display = "";
		document.getElementById("objectList_div").innerHTML += "<tr valign='top' id='CKO_CERTIFICATE'>";
		document.getElementById("objectList_div").innerHTML += "<td class='storyLeft'><h2>证书对象 [CKO_CERTIFICATE]</h2></td>";
		var objs = new VBArray( objects ).toArray();
		for( var i=0; i<objs.length; i++ )
		{
		document.getElementById("objectList_div").innerHTML += "<tr valign='top'>";
			var attributes = Com11If.GetObjectAttribute( slotID, 1, objs[i] );//objs[i]是对象句柄
			document.getElementById("objectList_div").innerHTML += "<h1>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#'onclick='selectObj(" + objs[i] + ")' ondblclick='showObjectInfo(1, " + objs[i] + ")'>" + getObjectID(attributes) + "</a></h1>";
		}
		document.getElementById("objectList_div").innerHTML += "<tr>";
		document.getElementById("objectList_div").innerHTML += "<br>";
	}
	//查找公钥对象(CKO_PUBLIC_KEY)
	objects = Com11If.EnumObject( slotID, 2, 0 );
	if( null != objects )
	{
//		document.getElementById("CKO_PUBLIC_KEY").style.display = "";
		document.getElementById("objectList_div").innerHTML += "<tr valign='top' id='CKO_PUBLIC_KEY'>";
		document.getElementById("objectList_div").innerHTML += "<td class='storyLeft'><h2>公钥对象 [CKO_PUBLIC_KEY]</h2></td>";
		var objs = new VBArray( objects ).toArray();
		for( var i=0; i<objs.length; i++ )
		{
			var attributes = Com11If.GetObjectAttribute( slotID, 2, objs[i] );
			document.getElementById("objectList_div").innerHTML += "<h1>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#'onclick='selectObj(" + objs[i] + ")' ondblclick='showObjectInfo(2, " + objs[i] + ")'>" + getObjectID(attributes) + "</a></h1>";
		}
		document.getElementById("objectList_div").innerHTML += "</tr>";
		document.getElementById("objectList_div").innerHTML += "<br>";
	}
	//查找私钥对象(CKO_PRIVATE_KEY)
	if( 1 == document.getElementById("isLogin_" + slotID).value )
	{
		objects = Com11If.EnumObject( slotID, 3, 1 );
		if( null != objects )
		{
//			document.getElementById("CKO_PRIVATE_KEY").style.display = "";
			document.getElementById("objectList_div").innerHTML += "<tr valign='top' style='display:none' id='CKO_PRIVATE_KEY'>";
			document.getElementById("objectList_div").innerHTML += "<td class='storyLeft'><h2>私钥对象 [CKO_PRIVATE_KEY]</h2></td>";
			var objs = new VBArray( objects ).toArray();
			for( var i=0; i<objs.length; i++ )
			{
				var attributes = Com11If.GetObjectAttribute( slotID, 3, objs[i] );
				document.getElementById("objectList_div").innerHTML += "<h1>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='selectObj(" + objs[i] + ")' ondblclick='showObjectInfo(3, " + objs[i] + ")'>" + getObjectID(attributes) + "</a></h1>";
			}
			document.getElementById("objectList_div").innerHTML += "</tr>";
			document.getElementById("objectList_div").innerHTML += "<br>";
		}
	}
	document.getElementById("objectList_div").innerHTML += "</table>";
	
	document.getElementById("objectList_div").innerHTML += "<input type='button' value=' 导入 ' id='importObj' onclick='importObjects()' disabled >&nbsp;&nbsp;&nbsp;&nbsp;";
	document.getElementById("objectList_div").innerHTML += "<input type='button' value=' 删除 ' id='deleteObj' onclick='onDeleteObject()' disabled >";
//依登录状态遍历
	if( 1 == document.getElementById("isLogin_" + slotID).value )
	{
		document.getElementById("importObj").disabled = false;
		document.getElementById("deleteObj").disabled = true;
	}
}
/*
 * 单击某对象
*/
function selectObj(hobj)
{
	var currentSlotID = document.getElementById("currentSlotID").value;
	//alert(currentSlotID);
	if( 1 == document.getElementById("isLogin_" + currentSlotID).value )
	{
		document.getElementById("importObj").disabled = false;
		document.getElementById("deleteObj").disabled = false;
	}
	else
	{
		document.getElementById("deleteObj").disabled = true;
	}
	document.getElementById("hObj").value = hobj;
//	document.getElementById("deleteObj").disabled = true;
}

/*
 * 点击“删除”按钮
*/
function onDeleteObject()
{
	//var slotID = document.getElementById("currentSlotID").value;
	var slotID = g_data;
	//alert(slotID);
	var bln = window.confirm("是否要删除所选择的对象？");
	if(true == bln)
	{
		var hobj = document.getElementById("hObj").value;
		Com11If.DeleteTokenObject(slotID, parseInt(hobj));
		showObjectList(slotID);
	}
}
/*
 * 单击“导入”按钮
*/
function importObjects()
{
//	window.open('importObject.html', 'importObjPage', 'height=160,width=250,top=250,left=250,toolbar=no, //titlebar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no, depended=yes alwaysRaised=yes');
//dialogTop=250; dialogLeft=250;
	var rv = false;
	//var currentSlotID = document.getElementById("currentSlotID").value;
	var currentSlotID = g_data;
	//alert(currentSlotID);
	var str = window.showModalDialog('importObject.html', '', 'dialogHeight=190px; dialogWidth=270px; toolbar=no; titlebar=no; help=no; scrollbars=no; resizable=no; status=no;');
	if( "" != str)
	{
//		alert("str =" + str);
		var path = str.split(";")[0];
		var pwd = str.split(";")[1];
		var keyusage = str.split(";")[2];
		if( "exchange" == keyusage )
		{
			rv = Com11If.ImportObjects(currentSlotID, path, pwd);
		}
		else
		{
			rv = Com11If.ImportObjects(currentSlotID, path, pwd);
		}
			
		if( false == rv )
			alert("导入证书失败！");
		else
			alert("导入证书成功！");
			
		showObjectList(currentSlotID);
	}
}
/*
 * 显示令牌对象信息
*/
function showObjectInfo(objtype, hobj)
{
	var slotID = document.getElementById("currentSlotID").value;
	
	clearSlotInfoDiv();
	clearTokenInfoDiv();
	clearObjectListDiv();
	clearObjectInfoDiv();
	
	document.getElementById("slotLinks_div").style.display = "";
	document.getElementById("navigation_div").style.display = "";
	document.getElementById("objectInfo_div").style.display = "";
	document.getElementById("hObj").value = hobj;
//	clearAttributeShow();
	
	var objects = "";
	var obj = "";
	var attributes;


	attributes = Com11If.GetObjectAttribute( slotID, objtype, hobj );
	if( null != attributes )
	{
		showAttributeList(attributes);
	}
	if( 1 == objtype )
	{
		document.getElementById("CertViewer").style.display = "";
	}
	else
	{
		document.getElementById("CertViewer").style.display = "none";
	}
}
/*
 * 显示对象属性列表
*/
function showAttributeList(attributes)
{
	clearAttributeListShow();

	var n = attributes.GetItemCount();

/*	if( n > 0 )
		document.getElementById("valuearea").style.display = "";
	else
		document.getElementById("valuearea").style.display = "none";
*/
	for( var i=0; i<n; i++ )
	{
		var vb_attri = null;
		vb_attri = new VBArray( attributes.GetAttributeValue(i) );
		
		if( vb_attri )
		{
			var attri_value = vb_attri.toArray();
			switch(attributes.GetAttributeType(i))
			{
			case 0x00000000:		//CKA_CLASS 
				document.getElementById("cka_0").style.display = "";
				document.getElementById("attri_len_0").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_0").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000001:		//CKA_TOKEN
				document.getElementById("cka_1").style.display = "";
				document.getElementById("attri_len_1").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_1").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000002:		//CKA_PRIVATE
				document.getElementById("cka_2").style.display = "";
				document.getElementById("attri_len_2").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_2").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000003:		//CKA_LABEL
				document.getElementById("cka_3").style.display = "";
				document.getElementById("attri_len_3").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_3").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000010:		//CKA_APPLICATION
				document.getElementById("cka_10").style.display = "";
				document.getElementById("attri_len_10").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_10").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000011:		//CKA_VALUE
				document.getElementById("cka_11").style.display = "";
				document.getElementById("attri_len_11").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_11").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000080:		//CKA_CERTIFICATE_TYPE
				document.getElementById("cka_80").style.display = "";
				document.getElementById("attri_len_80").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_80").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000081:		//CKA_ISSUER
				document.getElementById("cka_81").style.display = "";
				document.getElementById("attri_len_81").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_81").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000082:		//CKA_SERIAL_NUMBER
				document.getElementById("cka_82").style.display = "";
				document.getElementById("attri_len_82").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_82").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000086:		//CKA_TRUSTED
				document.getElementById("cka_86").style.display = "";
				document.getElementById("attri_len_86").innerHTML = parseInt(Attibute[2],16);
				document.getElementById("valuearea_86").value = showAttributeValue(Attibute[3]);	
				break;
			case 0x00000100:		//CKA_KEY_TYPE
				document.getElementById("cka_100").style.display = "";
				document.getElementById("attri_len_100").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_100").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000101:		//CKA_SUBJECT
				document.getElementById("cka_101").style.display = "";
				document.getElementById("attri_len_101").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_101").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000102:		//CKA_ID
				document.getElementById("cka_102").style.display = "";
				document.getElementById("attri_len_102").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_102").value = showAttributeValueInHex(attri_value);
				document.getElementById("obj_title").innerHTML = "对象信息 " + getObjectID(attributes);
				break;
			case 0x00000103:		//CKA_SENSITIVE
				document.getElementById("cka_103").style.display = "";
				document.getElementById("attri_len_103").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_103").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000104:		//CKA_ENCRYPT
				document.getElementById("cka_104").style.display = "";
				document.getElementById("attri_len_104").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_104").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000105:		//CKA_DECRYPT
				document.getElementById("cka_105").style.display = "";
				document.getElementById("attri_len_105").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_105").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000106:		//CKA_WRAP
				document.getElementById("cka_106").style.display = "";
				document.getElementById("attri_len_106").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_106").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000107:		//CKA_UNWRAP
				document.getElementById("cka_107").style.display = "";
				document.getElementById("attri_len_107").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_107").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000108:		//CKA_SIGN
				document.getElementById("cka_108").style.display = "";
				document.getElementById("attri_len_108").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_108").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000109:		//CKA_SIGN_RECOVER
				document.getElementById("cka_109").style.display = "";
				document.getElementById("attri_len_109").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_109").value = showAttributeValueInHex(attri_value);
				break;
			case 0x0000010A:		//CKA_VERIFY
				document.getElementById("cka_10A").style.display = "";
				document.getElementById("attri_len_10A").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_10A").value = showAttributeValueInHex(attri_value);
				break;
			case 0x0000010B:		//CKA_VERIFY_RECOVER
				document.getElementById("cka_10B").style.display = "";
				document.getElementById("attri_len_10B").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_10B").value = showAttributeValueInHex(attri_value);
				break;
			case 0x0000010C:		//CKA_DERIVE
				document.getElementById("cka_10C").style.display = "";
				document.getElementById("attri_len_10C").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_10C").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000110:		//CKA_START_DATE
				document.getElementById("cka_110").style.display = "";
				document.getElementById("attri_len_110").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_110").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000111:		//CKA_END_DATE
				document.getElementById("cka_111").style.display = "";
				document.getElementById("attri_len_111").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_111").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000120:		//CKA_MODULUS
				document.getElementById("cka_120").style.display = "";
				document.getElementById("attri_len_120").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_120").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000121:		//CKA_MODULUS_BITS
				document.getElementById("cka_121").style.display = "";
				document.getElementById("attri_len_121").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_121").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000122:		//CKA_PUBLIC_EXPONENT
				document.getElementById("cka_122").style.display = "";
				document.getElementById("attri_len_122").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_122").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000123:		//CKA_PRIVATE_EXPONENT
				document.getElementById("cka_123").style.display = "";
				document.getElementById("attri_len_123").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_123").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000124:		//CKA_PRIME_1
				document.getElementById("cka_124").style.display = "";
				document.getElementById("attri_len_124").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_124").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000125:		//CKA_PRIME_2
				document.getElementById("cka_125").style.display = "";
				document.getElementById("attri_len_125").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_125").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000126:		//CKA_EXPONENT_1
				document.getElementById("cka_126").style.display = "";
				document.getElementById("attri_len_126").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_126").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000127:		//CKA_EXPONENT_2
				document.getElementById("cka_127").style.display = "";
				document.getElementById("attri_len_127").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_127").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000128:		//CKA_COEFFICIENT
				document.getElementById("cka_128").style.display = "";
				document.getElementById("attri_len_128").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_128").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000162:		//CKA_EXTRACTABLE
				document.getElementById("cka_162").style.display = "";
				document.getElementById("attri_len_162").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_162").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000163:		//CKA_LOCAL
				document.getElementById("cka_163").style.display = "";
				document.getElementById("attri_len_163").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_163").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000164:		//CKA_NEVER_EXTRACTABLE
				document.getElementById("cka_164").style.display = "";
				document.getElementById("attri_len_164").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_164").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000165:		//CKA_ALWAYS_SENSITIVE
				document.getElementById("cka_165").style.display = "";
				document.getElementById("attri_len_165").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_165").value = showAttributeValueInHex(attri_value);
				break;
			case 0x00000170:		//CKA_MODIFIABLE
				document.getElementById("cka_170").style.display = "";
				document.getElementById("attri_len_170").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_170").value = showAttributeValueInHex(attri_value);
				break;
			case 0x80455053:		//CKA_CONTAINER_NAME
				document.getElementById("cka_80455053").style.display = "";
				document.getElementById("attri_len_80455053").innerHTML = attributes.GetAttributeLength(i);
				document.getElementById("valuearea_80455053").value = showAttributeValueInHex(attri_value);
			default:
				break;
			}
		}
	}
}
/*
 * 清除令牌对象属性列表显示
*/
function clearAttributeListShow()
{
	//清除属性列表
	document.getElementById("cka_0").style.display = "none";
	document.getElementById("cka_1").style.display = "none";
	document.getElementById("cka_2").style.display = "none";
	document.getElementById("cka_3").style.display = "none";
	document.getElementById("cka_10").style.display = "none";
	document.getElementById("cka_11").style.display = "none";
	document.getElementById("cka_80").style.display = "none";
	document.getElementById("cka_82").style.display = "none";
	document.getElementById("cka_86").style.display = "none";
	
	document.getElementById("cka_100").style.display = "none";
	document.getElementById("cka_101").style.display = "none";
	document.getElementById("cka_102").style.display = "none";
	document.getElementById("cka_103").style.display = "none";
	document.getElementById("cka_104").style.display = "none";
	document.getElementById("cka_105").style.display = "none";
	document.getElementById("cka_106").style.display = "none";
	document.getElementById("cka_107").style.display = "none";
	document.getElementById("cka_108").style.display = "none";
	document.getElementById("cka_109").style.display = "none";
	document.getElementById("cka_10A").style.display = "none";
	document.getElementById("cka_10B").style.display = "none";
	document.getElementById("cka_10C").style.display = "none";
	document.getElementById("cka_110").style.display = "none";
	document.getElementById("cka_111").style.display = "none";
	
	document.getElementById("cka_120").style.display = "none";
	document.getElementById("cka_121").style.display = "none";
	document.getElementById("cka_122").style.display = "none";
	document.getElementById("cka_123").style.display = "none";
	document.getElementById("cka_124").style.display = "none";
	document.getElementById("cka_125").style.display = "none";
	document.getElementById("cka_126").style.display = "none";
	document.getElementById("cka_127").style.display = "none";
	document.getElementById("cka_128").style.display = "none";
	
	document.getElementById("cka_162").style.display = "none";
	document.getElementById("cka_163").style.display = "none";
	document.getElementById("cka_164").style.display = "none";
	document.getElementById("cka_165").style.display = "none";
	document.getElementById("cka_170").style.display = "none";
	document.getElementById("cka_80455053").style.display = "none";
}
/*
 * 清除令牌对象属性值显示
*/
function clearAttributeValueShow()
{
	//清除属性值
	document.getElementById("valuearea_0").style.display = "none";
	document.getElementById("valuearea_1").style.display = "none";
	document.getElementById("valuearea_2").style.display = "none";
	document.getElementById("valuearea_3").style.display = "none";
	
	document.getElementById("valuearea_10").style.display = "none";
	document.getElementById("valuearea_11").style.display = "none";
	document.getElementById("valuearea_80").style.display = "none";
	document.getElementById("valuearea_81").style.display = "none";
	document.getElementById("valuearea_82").style.display = "none";
	document.getElementById("valuearea_86").style.display = "none";
	document.getElementById("valuearea_100").style.display = "none";
	document.getElementById("valuearea_101").style.display = "none";
	document.getElementById("valuearea_102").style.display = "none";
	document.getElementById("valuearea_103").style.display = "none";
	document.getElementById("valuearea_104").style.display = "none";
	document.getElementById("valuearea_105").style.display = "none";
	document.getElementById("valuearea_106").style.display = "none";
	document.getElementById("valuearea_107").style.display = "none";
	document.getElementById("valuearea_108").style.display = "none";
	document.getElementById("valuearea_109").style.display = "none";
	document.getElementById("valuearea_10A").style.display = "none";
	document.getElementById("valuearea_10B").style.display = "none";
	document.getElementById("valuearea_10C").style.display = "none";
	document.getElementById("valuearea_110").style.display = "none";
	document.getElementById("valuearea_111").style.display = "none";
	
	document.getElementById("valuearea_120").style.display = "none";
	document.getElementById("valuearea_121").style.display = "none";
	document.getElementById("valuearea_122").style.display = "none";
	document.getElementById("valuearea_123").style.display = "none";
	document.getElementById("valuearea_124").style.display = "none";
	document.getElementById("valuearea_125").style.display = "none";
	document.getElementById("valuearea_126").style.display = "none";
	document.getElementById("valuearea_127").style.display = "none";
	document.getElementById("valuearea_128").style.display = "none";
	
	document.getElementById("valuearea_162").style.display = "none";
	document.getElementById("valuearea_163").style.display = "none";
	document.getElementById("valuearea_164").style.display = "none";
	document.getElementById("valuearea_165").style.display = "none";
	document.getElementById("valuearea_170").style.display = "none";
	document.getElementById("valuearea_80455053").style.display = "none";
}
/*
 * 显示令牌对象属性值
*/
function showAttributeValueInHex(val)
{
	clearAttributeValueShow();
	
	var attri_val = "";
	for( var i=0; i<val.length; i++ )
	{
		attri_val += val[i].toString(16);
		attri_val += " ";
	}
	return attri_val;
//	document.getElementById("valuearea_"+attr_id).style.display = "";
}

function showAttributeValueInString(val)
{
	var attri_val = "";
	var attri_val_length = val.length;
	var j = 16;
	if(attri_val_length<16)
	{
		j = attri_val_length;	
	}
	for( var i=0; i<j; i++ )
	{
//		attri_val += String.fromCharCode(val[i]);		//以ASCII显示
		attri_val += val[i].toString(16).toUpperCase();	//以16进制字符串显示
		if( i!= 0 && 0 == i%4 )
			attri_val += '-';
	}
	return attri_val;
}
/*
 * 显示对象属性值
*/
function showAttribute(cka)
{
	clearAttributeValueShow();
	
	document.getElementById("valuearea_"+cka).style.display = "";
}
/*
 * 点击“显示系统证书查看器”按钮
*/
function onCertViewer()
{
	var slotID = document.getElementById("currentSlotID").value;
	var hobj = document.getElementById("hObj").value;
	Com11If.ViewCert(slotID, parseInt(hobj));
}

</script>
</head>
<body onload="javascript:Init(); showSlotList(1);" onmousemove="closesubnav(event);">
<div class="skipLinks">skip to: <a href="#content_div">page content</a> | <a href="#pageNav_div">links on this page</a> | <a href="#globalNav">site navigation</a> | <a href="#siteInfo">footer (site information)</a> </div>
<!-- end masthead -->
<!-- pagecell1_div层 -->
<div id="pagecell1_div">
  <img alt="" src="image/tl_curve_white.gif" height="6" width="6" id="tl" />
  <img alt="" src="image/tr_curve_white.gif" height="6" width="6" id="tr" />
  <!-- pageName_div层 -->
  <div id="pageName_div">
    <h2 align="center">欢迎使用EnterSafe PKI 管理工具</h2>
    <img alt="small logo" src="./image/logo.gif" height="32" width="103"/>
  </div><!-- end pageName_div -->
  <!-- pageNav_div层 -->
		<!-- 页面状态控制层 -->
  		<div id="pageCtrl_div">
			<!-- 所有内容均为隐藏域，用以保存槽及智能卡的状态，在遍历槽列表时动态画出
			有效的智能卡数量
  			<input type='hidden' id="validSlotCount" name="validSlotCount" value='0' >
			有效的智能卡槽ID（可为多个，X起始值为0，最大值为validSlotCount）
			<input type='hidden' id='validSlotID_X' name='validSlotID_X' value='0' >
			-->
  		</div><!-- end pageCtrl_div -->
		<div id="pageDetailCtrl_div">
			<!-- 所有内容均为隐藏域，用以保存槽及智能卡的状态
			各智能卡的登录状态（可为多个，X为某validSlotID_X的值，1－已登录；0－未登录）
			<input type='hidden' id='isLogin_X' name='isLogin_X' value='0' >
			各智能卡的PIN码长度最大值（可为多个，X为某validSlotID_X的值）		
			<input type='hidden' id='maxPINLen_X' name='maxPINLen_X' value='0' >
			各智能卡的PIN码长度最小值（可为多个，X为某validSlotID_X的值）
			<input type='hidden' id='minPINLen_X' name='minPINLen_X' value='0' >;
			-->
  		</div><!-- end pageDetailCtrl_div -->
  <div id="pageNav_div">
    <h5 id="slotlabel"></h5>
	<!-- slotLinks_div层 --> 
	<div id="slotLinks_div"class="slotLinks" style="display:none;">
	<!--
	  <a id="slotDesc_1" style="display:none;" href="#" onclick="showTokenInfo(1)" ></a>
	  	<a id="slotData_1" style="display:none;" href="#" onclick="showObjectList(1)" ><ul><li> Data </li></ul></a>
	  <a id="slotDesc_2" style="display:none;" href="#" onclick="showTokenInfo(2)" ></a>
	  	<a id="slotData_2" style="display:none;" href="#" onclick="showObjectList(2)" ><ul><li> Data </li></ul></a>
	-->
	</div><!-- end slotLinks_div -->
    <div id="optionLinks_div" >
	<a href="#" >用户状态</a>
	<div id="userStatus_div" style="display:block">
		<!-- 显示用户状态
		用户登录状态（可为多个，X为某validSlotID_X的值，显示“X槽已登录”或“X槽未登录”）
		<input id='loginStatus_X' name='loginStatus_X' value='' readonly='1'>
		-->
	</div><!-- end userStatus_div -->
	  <!-- 用户登录层 -->
	  <a href="#" id="in" onclick="Login()">用户登录</a>
		<input type="text" id="islogin_1" disabled style="display:none" >
		<input type="text" id="islogin_2" disabled style="display:none" >
    	<div id="login_div" style="display:none">
		  请选择：
		  <select id="login_slotSel" name="login_slotSel" style="width:153px " onchange="LoginSelectSlot()" >
		  </select><br><!-- onpropertychange= "CheckPINLength(this.value)" -->
	  	  PIN: <input type="password" size=14 id="PIN" disabled /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="login" onclick="onLogin()" value="确定" disabled />
	  	</div><!-- end login_div -->
	  <!-- 用户修改PIN码层 -->
	  <a href="#" onclick="ModifyUPIN()" >修改用户PIN码</a>
    	<div id="modifyUPIN_div" style="display:none">
		  请选择：
		  <select id="modifyUPIN_slotSel" name="modifyUPIN_slotSel" style="width:153px " onchange="ModifyUPINSelectSlot()" >
		  </select><br>
	  	  旧PIN码:&nbsp;&nbsp;&nbsp;<input type="password" size=6 id="old_uPIN" /><br>
	  	  新PIN码:&nbsp;&nbsp;&nbsp;<input type="password" size=6 id="new_uPIN" /><br>
	  	  确认PIN码: <input type="password" size=6 id="verify_uPIN" /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="modifyUPIN" onclick="onModifyUPIN()" value="确定" disabled />
	  	</div><!-- end modifyUPIN_div -->
	  <!-- 修改令牌名称层 -->
	  <a href="#" onclick="ModifyTN()" >修改令牌名称</a>
    	<div id="modifyTN_div" style="display:none">
		  请选择：
		  <select id="modifyTN_slotSel" name="modifyTN_slotSel" style="width:153px " onchange="ModifyTNSelectSlot()" >
		  </select><br><!-- onpropertychange= "CheckTNLength(this.value)" -->
	  	  新令牌名称:&nbsp;&nbsp;&nbsp;<input type="text" size=20 id="new_TN" /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="modifyTN" onclick="onModifyTN()" value="确定" disabled />
	  	</div><!-- end modifyTN_div -->
	  <!-- -->
	  <a href="#"></a>
	  <!-- 管理员修改PIN码层 -->
	  <a href="#" onclick="ModifyOPIN()" >修改管理员PIN码</a>
    	<div id="modifyOPIN_div" style="display:none">
		  请选择：
		  <select id="modifyOPIN_slotSel" name="modifyOPIN_slotSel" style="width:153px " onchange="ModifyOPINSelectSlot()" >
		  </select><br>
	  	  旧PIN码:&nbsp;&nbsp;&nbsp;<input type="password" size=6 id="old_oPIN" /><br>
	  	  新PIN码:&nbsp;&nbsp;&nbsp;<input type="password" size=6 id="new_oPIN" /><br>
	  	  确认PIN码: <input type="password" size=6 id="verify_oPIN" /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="modifyOPIN" onclick="onModifyOPIN()" value="确定" disabled />
	  	</div><!-- end modifyOPIN_div -->
	  <!-- 解锁令牌层 -->
	  <a href="#" onclick="UnblockToken()" >令牌解锁</a>
    	<div id="unblockToken_div" style="display:none">
		  请选择：
		  <select id="unblockToken_slotSel" name="unblockToken_slotSel" style="width:153px " onchange="UnblockTokenSelectSlot()" >
		  </select><br>
	  	  管理员PIN码:&nbsp;<input type="password" size=4 id="oPIN" /><br>
	  	  新用户PIN码:&nbsp;<input type="password" size=4 id="set_uPIN" /><br>
	  	  确认用户PIN码:<input type="password" size=3 id="verifyset_uPIN" /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="unblockToken" onclick="onUnblockToken()" value="确定" disabled />
	  	</div><!-- end unblockToken_div -->
	  <!-- 初始化令牌层 -->
	  <a href="#" onclick="InitToken()" >初始化令牌</a>
    	<div id="initToken_div" style="display:none">
		  请选择：
		  <select id="initToken_slotSel" name="initToken_slotSel" style="width:153px " onchange="InitTokenSelectSlot()" >
		  </select><br>
	  	  管理员PIN码:<input type="password" size=5 id="os_PIN" /><br>
	  	  令牌标签:&nbsp;&nbsp;&nbsp;<input type="text" size=6 id="label" /><br>
		  新PIN码：&nbsp;&nbsp;<input type="password" size=6 id="new_uPIN_" /><br>
	  	  确认PIN码: <input type="password" size=6 id="verify_uPIN_" /><br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" id="initToken" onclick="onInitToken()" value="确定" disabled />
	  	</div><!-- end initToken_div -->
    </div><!-- end optionLinks_div -->
  </div><!-- end pageNav_div -->
  <div id="content_div">
  	<!-- 导航条 -->
  	<div style="display:block" id="navigation_div" class="navigation">
		<a href="#" onclick=showSlotList(0);> 槽信息 </a> /
		令牌信息 /
		对象列表 /
		对象信息
	</div><!-- end navigation_div -->
  	<!-- 无信息显示 -->
  	<div style="display:none" id="noneInfo_div" class="info">
		<h3> no information </h3>
	</div><!-- end noneInfo_div -->
	<!-- 槽信息显示 -->
	<div style="display:none" id="slotInfo_div" class="info">
	</div><!-- end slotInfo_div -->
	
	<!-- 槽1信息显示 -->
    <div  style="display:none" id="slotInfo_div1" class="info">
		<h3><a href="#" id="Slot_Title_1" onclick=showTokenInfo(1);></a></h3><br>
      <table width="70%" cellpadding="0" cellspacing="0" summary="">
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">描述 [SlotDescription]</a></p></td>
          <td><p id="Slot_Description_1"> </p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">厂商ID [ManufacturerID]</a></p></td>
          <td><p id="Slot_ManufacturerID_1"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">标记 [Flags]</a></p></td>
          <td><p id="Slot_Flags_1"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">硬件版本 [HardwareVersion]</a></p></td>
          <td><p id="Slot_HardwareVersion_1"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">固件版本 [FirmwareVersion]</a></p></td>
          <td><p id="Slot_FirmwareVersion_1"></p></td>
        </tr>
      </table>
    </div><!-- end slotInfo_div1 -->
	<!-- 槽2信息显示 -->
    <div  style="display:none" id="slotInfo_div2" class="info">
		<h3><a href="#" id="Slot_Title_2" onclick=showTokenInfo(2);></a></h3><br>
      <table width="70%" cellpadding="0" cellspacing="0" summary="">
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">描述 [SlotDescription]</a></p></td>
          <td><p id="Slot_Description_2"> </p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">厂商ID [ManufacturerID]</a></p></td>
          <td><p id="Slot_ManufacturerID_2"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">标记 [Flags]</a></p></td>
          <td><p id="Slot_Flags_2"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">硬件版本 [HardwareVersion]</a></p></td>
          <td><p id="Slot_HardwareVersion_2"></p></td>
        </tr>
        <tr valign="top">
          <td class="storyLeft"><p> <a href="#" class="capsule">固件版本 [FirmwareVersion]</a></p></td>
          <td><p id="Slot_FirmwareVersion_2"></p></td>
        </tr>
      </table>
    </div><!-- end slotInfo_div2 -->
	<!-- 令牌信息显示 -->
    <div  style="display:none" id="tokenInfo_div" class="info">
		<h3><a href="#" id="Token_Title" ></a></h3><br>
      <table width="70%" cellpadding="0" cellspacing="0" summary="">
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">标签 [Label]</a></p></td>
          <td><p id="Token_Label"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">厂商ID [ManufacturerID]</a></p></td>
          <td><p id="Token_ManufacturerID"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">型号 [Model]</a></p></td>
          <td><p id="Token_Model"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">序列号 [SerialNumber]</a></p></td>
          <td><p id="Token_SerialNumber"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">标记 [Flags]</a></p></td>
          <td><p id="Token_Flags"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">会话最大数量 [MaxSessionCount]</a></p></td>
          <td><p id="Token_MaxSessionCount"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">实际会话数量 [SessionCount]</a></p></td>
          <td><p id="Token_SessionCount"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">读写会话最大数量 [MaxRwSessionCount]</a></p></td>
          <td><p id="Token_MaxRwSessionCount"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">实际读写会话数量 [RwSessionCount]</a></p></td>
          <td><p id="Token_RwSessionCount"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">最大PIN码位数 [MaxPinLen]</a></p></td>
          <td><p id="Token_MaxPinLen"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">最小PIN码位数 [MinPinLen]</a></p></td>
          <td><p id="Token_MinPinLen"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">公共数据区总空间 [TotalPublicMemory]</a></p></td>
          <td><p id="Token_TotalPublicMemory"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">公共数据区剩余空间 [FreePublicMemory]</a></p></td>
          <td><p id="Token_FreePublicMemory"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">私有数据区总空间 [TotalPrivateMemory]</a></p></td>
          <td><p id="Token_TotalPrivateMemory"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">私有数据区剩余空间 [FreePrivateMemory]</a></p></td>
          <td><p id="Token_FreePrivateMemory"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">硬件版本 [HardwareVersion]</a></p></td>
          <td><p id="Token_HardwareVersion"></p></td>
        </tr>
        <tr valign="top">
          <td class="infoLeft"><p> <a href="#" class="capsule">固件版本 [FirmwareVersion]</a></p></td>
          <td><p id="Token_FirmwareVersion"></p></td>
        </tr>
      </table>
    </div><!-- end tokenInfo_div -->
	<!-- 令牌对象列表显示 -->
    <div style="display:none" id="objectList_div" class="info">
<!--		<h3> 对象列表 </h3><br>
      <table width="50%" cellpadding="0" cellspacing="0" summary="">
        <tr valign="top" style="display:none" id="CKO_DATA">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showObjectInfo(0)">数据对象 [CKO_DATA]</a></p></td>
        </tr>
        <tr valign="top" style="display:none" id="CKO_CERTIFICATE">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showObjectInfo(1)">证书对象 [CKO_CERTIFICATE]</a></p></td>
        </tr>
        <tr valign="top" style="display:none" id="CKO_PUBLIC_KEY">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showObjectInfo(2)">公钥对象 [CKO_PUBLIC_KEY]</a></p></td>
        </tr>
        <tr valign="top" style="display:none" id="CKO_PRIVATE_KEY">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showObjectInfo(3)">私钥对象 [CKO_PRIVATE_KEY]</a></p></td>
        </tr>
      </table>-->
    </div><!-- end objectList_div -->
	<!-- 令牌对象信息显示 -->
    <div style="display:none" id="objectInfo_div" class="info">
		<h3 id="obj_title"> Object Info </h3><br>
		<!-- 保存当前数据对象的句柄 -->
		<input type="hidden" id="hObj" value="" />
      <table width="50%" cellpadding="0" cellspacing="0" summary="">
        <tr valign="top" style="display:none" id="cka_0">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('0')">[CKA_CLASS]</a></p></td>
          <td><p id="attri_len_0"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_1">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('1')">[CKA_TOKEN]</a></p></td>
          <td><p id="attri_len_1"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_2">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('2')">[CKA_PRIVATE]</a></p></td>
          <td><p id="attri_len_2"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_3">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('3')">[CKA_LABEL]</a></p></td>
          <td><p id="attri_len_3"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_10">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('10')">[CKA_APPLICATION]</a></p></td>
          <td><p id="attri_len_10"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_80">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('80')">[CKA_CERTIFICATE_TYPE]</a></p></td>
          <td><p id="attri_len_80"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_81">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('81')">[CKA_ISSUER]</a></p></td>
          <td><p id="attri_len_81"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_82">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('82')">[CKA_SERIAL_NUMBER]</a></p></td>
          <td><p id="attri_len_82"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_86">
          <td class="storyLeft"><p> <a href="#" class="capsule" onClick="showAttribute('86')">[CKA_TRUSTED]</a></p></td>
          <td><p id="attri_len_86"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_100">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('100')">[CKA_KEY_TYPE]</a></p></td>
          <td><p id="attri_len_100"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_101">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('101')">[CKA_SUBJECT]</a></p></td>
          <td><p id="attri_len_101"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_102">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('102')">[CKA_ID]</a></p></td>
          <td><p id="attri_len_102"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_103">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('103')">[CKA_SENSITIVE]</a></p></td>
          <td><p id="attri_len_103"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_104">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('104')">[CKA_ENCRYPT]</a></p></td>
          <td><p id="attri_len_104"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_105">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('105')">[CKA_DECRYPT]</a></p></td>
          <td><p id="attri_len_105"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_106">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('106')">[CKA_WRAP]</a></p></td>
          <td><p id="attri_len_106"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_107">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('107')">[CKA_UNWRAP]</a></p></td>
          <td><p id="attri_len_107"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_108">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('108')">[CKA_SIGN]</a></p></td>
          <td><p id="attri_len_108"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_109">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('109')">[CKA_SIGN_RECOVER]</a></p></td>
          <td><p id="attri_len_109"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_10A">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('10A')">[CKA_VERIFY]</a></p></td>
          <td><p id="attri_len_10A"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_10B">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('10B')">[CKA_VERIFY_RECOVER]</a></p></td>
          <td><p id="attri_len_10B"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_10C">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('10C')">[CKA_DERIVE]</a></p></td>
          <td><p id="attri_len_10C"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_110">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('110')">[CKA_START_DATE]</a></p></td>
          <td><p id="attri_len_110"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_111">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('111')">[CKA_END_DATE]</a></p></td>
          <td><p id="attri_len_111"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_120">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('120')">[CKA_MODULUS]</a></p></td>
          <td><p id="attri_len_120"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_121">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('121')">[CKA_MODULUS_BITS]</a></p></td>
          <td><p id="attri_len_121"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_122">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('122')">[CKA_PUBLIC_EXPONENT]</a></p></td>
          <td><p id="attri_len_122"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_123">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('123')">[CKA_PRIVATE_EXPONENT]</a></p></td>
          <td><p id="attri_len_123"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_124">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('124')">[CKA_PRIME_1]</a></p></td>
          <td><p id="attri_len_124"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_125">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('125')">[CKA_PRIME_2]</a></p></td>
          <td><p id="attri_len_125"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_126">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('126')">[CKA_EXPONENT_1]</a></p></td>
          <td><p id="attri_len_126"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_127">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('127')">[CKA_EXPONENT_2]</a></p></td>
          <td><p id="attri_len_127"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_128">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('128')">[CKA_COEFFICIENT]</a></p></td>
          <td><p id="attri_len_128"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_162">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('162')">[CKA_EXTRACTABLE]</a></p></td>
          <td><p id="attri_len_162"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_163">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('163')">[CKA_LOCAL]</a></p></td>
          <td><p id="attri_len_163"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_164">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('164')">[CKA_NEVER_EXTRACTABLE]</a></p></td>
          <td><p id="attri_len_164"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_165">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('165')">[CKA_ALWAYS_SENSITIVE]</a></p></td>
          <td><p id="attri_len_165"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_170">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('170')">[CKA_MODIFIABLE]</a></p></td>
          <td><p id="attri_len_170"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_80455053">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('80455053')">[CKA_CONTAINER_NAME]</a></p></td>
          <td><p id="attri_len_80455053"></p></td>
        </tr>
        <tr valign="top" style="display:none" id="cka_11">
          <td class="storyLeft"><p> <a href="#" class="capsule" onclick="showAttribute('11')">[CKA_VALUE]</a></p></td>
          <td><p id="attri_len_11"></p></td>
        </tr>
      </table>
	  <input id="CertViewer" type="button" style="display:none" value="显示系统证书查看器" onclick="onCertViewer()">
	  <br>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_0" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_1" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_2" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_3" ></textarea>
	
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_10" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_11" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_80" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_81" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_82" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_86" ></textarea>
	  
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_100" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_101" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_102" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_103" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_104" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_105" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_106" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_107" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_108" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_109" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_10A" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_10B" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_10C" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_110" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_111" ></textarea>
	  
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_120" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_121" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_122" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_123" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_124" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_125" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_126" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_127" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_128" ></textarea>
	  
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_162" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_163" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_164" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_165" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_170" ></textarea>
	  <textarea rows="10" cols="65" style="display:none;" runat="server" id="valuearea_80455053" ></textarea>
    </div><!-- end objectInfo_div -->
  </div><!-- end content_div -->
  <div id="siteInfo">
  	<img src=".\image\logo.gif" width="51" height="16" /> <a href="http://www.ftsafe.com.cn/">About Us</a> | <a href="http://www.ftsafe.com.cn/company/sitemap.php">Site Map</a> | <a href="http://www.ftsafe.com.cn/company/legal.php">Privacy Policy</a> | <a href="http://www.ftsafe.com.cn/company/contact.php">Contact Us</a> | &copy; 2005-2012, Feitian Technologies Co.,Ltd.
  </div><!-- end siteInfo -->
</div><!--end pagecell1-->
</body>
</html>
