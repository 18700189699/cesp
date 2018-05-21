<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<OBJECT classid="clsid:F97C817C-0E0F-4BFB-B8DB-36438A1DE479"
	id="Com11Attribute" name="Com11Attribute"></OBJECT>
<!-- FtCom11Token -->
<OBJECT classid="clsid:B40AD154-5022-47C3-935D-0926951B64B0"
	id="Com11Token" name="Com11Token"></OBJECT>
<!-- FtCom11Slot -->
<OBJECT classid="clsid:A22FB3C3-8D22-4A52-8F0F-6855BBBAE5A0"
	id="Com11Slot" name="Com11Slot"></OBJECT>
<!-- FtCom11If -->
<OBJECT classid="clsid:A5F1473C-3BAF-4098-885A-9DD332433FD5"
	id="Com11If" name="Com11If"></OBJECT>

<script type="text/javascript">

var time = 3000;
var numofitems = 7;
var g_data;
String.prototype.Trim = function()
{
	return this.replace(/(^\s*)|(\s*$)/g, "");
}


/*
 * 当卡插入时
*/
function WhenKeyInsert(slotID)
{
	alert(slotID+"号卡被插入");
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
	showSlotList(0);
}
/*
 * 当卡拔出时
*/
function WhenKeyRemove(slotID)
{
	alert(slotID+"号卡被拔出！");
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
	Com11If.WhenKeyRemove = "WhenKeyRemove";
	Com11If.WhenKeyInsert = "WhenKeyInsert";
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
 * 获取槽列表
*/
function showSlotList(flag)
{
	//pageCtrl_div层 
	document.getElementById("pageCtrl_div").innerHTML = "";
	document.getElementById("pageCtrl_div").innerHTML += "<input type='text' id='validSlotCount' name='validSlotCount' value='0' >";
	document.getElementById("pageCtrl_div").innerHTML += "<input type='text' id='currentSlotID' name='currentSlotID' value='0' >";

	//查询所有已插入卡的槽列表
	var currentSlotID = 0;				//当前操作的智能卡ID
	var slotList = Com11If.GetSlotList();
	if( null != slotList )
	{
		//修改槽列表显示信息
		document.getElementById("slotLinks_div").style.display = "";
		
		//将获取到的槽列表转换成数组，存储到全局变量g_slotIDs中
		var slotIDs = new VBArray( slotList ).toArray();
		var slotCount = slotIDs.length;	//已插入的智能卡数量
		var slotID = 0;
		//画槽信息隐藏域
		for( var i=0; i<slotCount; i++ )
		{
			slotID = slotIDs[i];
			//pageCtrl_div层 type='text' 
			document.getElementById("pageCtrl_div").innerHTML += "<input type='text' id='validSlotID_" + i + "' name='validSlotID_" + i + "' value='0' >";
			//pageDetailCtrl_div层
			if( null == document.getElementById('isLogin_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='type' id='isLogin_" + slotID + "' name='isLogin_" + slotID + "' value='0' >";
			}
			else if( 1 == flag )
			{
				document.getElementById("isLogin_"+slotID).value = 0;
			}
			if( null == document.getElementById('maxPINLen_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='text' id='maxPINLen_" + slotID + "' name='maxPINLen_" + slotID + "' value='0' >";
			}
			else if( 1 == flag )
			{
				document.getElementById("maxPINLen_"+slotID).value = 0;
			}
			if( null == document.getElementById('minPINLen_'+slotID) )
			{
				document.getElementById("pageDetailCtrl_div").innerHTML += "<input type='text' id='minPINLen_" + slotID + "' name='minPINLen_" + slotID + "' value='0' >";
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
				}
			}
			document.getElementById("currentSlotID").value = currentSlotID;
		}
		
	}
}

</script>
</head>
<body onload="javascript:Init(); showSlotList(1);"
	onmousemove="closesubnav(event);">
	<!-- pagecell1_div层 -->
	<div id="pagecell1_div">

		<!-- pageName_div层 -->
		<div id="pageName_div"></div>
		<!-- end pageName_div -->
		<!-- pageNav_div层 -->
		<!-- 页面状态控制层   重要-->
		<div id="pageCtrl_div"></div>
		<!-- end pageCtrl_div -->
		<div id="pageDetailCtrl_div"></div>
		<!-- end pageDetailCtrl_div -->
		<div id="pageNav_div">

			<!-- slotLinks_div层   重要-->
			<div id="slotLinks_div" class="slotLinks" style="display: none;">

			</div>
			<!-- end slotLinks_div -->
			<div id="optionLinks_div">
				<a href="#">用户状态</a>
				<div id="userStatus_div" style="display:block"></div>
				<!-- end userStatus_div -->
			</div>
			<!-- end pageNav_div -->
		</div>
		<!--end pagecell1-->
</body>
</html>
