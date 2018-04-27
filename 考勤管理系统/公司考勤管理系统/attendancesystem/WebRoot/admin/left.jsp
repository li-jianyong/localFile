<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE3 {
	font-size: 12px;
	color: #435255;
}
.STYLE4 {font-size: 12px}
.STYLE5 {font-size: 12px; font-weight: bold; }
-->
</style></head>
<script language=javascript>
function show(no)
{
for(var i=1;i<20;i++)
{
var a = document.getElementById(no+"@"+i);
if(a==null)
{
continue;
}
if(a.style.display=="")
{
a.style.display="none";
}else{
a.style.display="";
}
}

}
</script>
<body>

  <%
    HashMap map = (HashMap)session.getAttribute("admin");
    if(map.get("role").equals("管理员"))
    {
    %>
<table width="147"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr  onClick="show('2')"  style="cursor:hand">
    <td height="23" background="images/main_34.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9%">&nbsp;</td>
        <td width="83%"><div align="center" class="STYLE5">基础信息管理</div></td>
        <td width="8%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td valign="top"><div align="center">
  
    
    	<table width="82%" border="0" id="2@1"   align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('notice.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">公告管理</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
     
    
     <table width="82%" border="0" id="2@2"   align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td onClick="go('sysuser.jsp')" height="23" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">公司人员管理</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
      
      
      <table width="82%" border="0" id="2@3"   align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td onClick="go('dept.jsp')" height="23" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">部门管理</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
      
      <table width="82%" border="0" id="2@4"   align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td onClick="go('zw.jsp')" height="23" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">职位管理</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
  

  </div></td></tr>
  
  
   <tr  onClick="show('1')"  style="cursor:hand">
    <td height="23" background="images/main_34.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9%">&nbsp;</td>
        <td width="83%"><div align="center" class="STYLE5">事务管理</div></td>
        <td width="8%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><div align="center">
     <table width="82%" border="0" id="1@1"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('kqrecordAll.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">考勤记录</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      

      

      
      <table width="82%" border="0" id="1@2"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('kqtj.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">考勤统计</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
     
  
     <table width="82%" border="0" id="1@3"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('qjinfosh.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">请假管理</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
		<table width="82%" border="0" id="1@4"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('chat.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">互动交流</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>


  <tr  onClick="show('3')"  style="cursor:hand">
    <td height="23" background="images/main_34.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9%">&nbsp;</td>
        <td width="83%"><div align="center" class="STYLE5">个人信息</div></td>
        <td width="8%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><div align="center">
     	     <table width="82%" border="0" id="3@1"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('myinfo.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">个人信息编辑</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
      
	  
  </div></td></tr>
  
  <%} %>
  
  
  

  
  <%if(!map.get("role").equals("管理员")){ %>


    <table width="147"  border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr  onClick="show('2')"  style="cursor:hand">
	    <td height="23" background="images/main_34.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="9%">&nbsp;</td>
	        <td width="83%"><div align="center" class="STYLE5">员工功能</div></td>
	        <td width="8%">&nbsp;</td>
	      </tr>
	    </table></td>
	  </tr>
	  <tr>
	    <td valign="top"><div align="center">
	    
      
      	    <table width="82%" border="0" id="2@1"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
	              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                  <tr>
	                    <td height="23" onClick="go('notice.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">公告</td>
	                  </tr>
	              </table></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table>
      
	    <table width="82%" border="0" id="2@2"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
	              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                  <tr>
	                    <td height="23" onClick="go('dk.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">考勤打卡</td>
	                  </tr>
	              </table></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table>
	      
	          <table width="82%" border="0" id="2@3"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
	              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                  <tr>
	                    <td height="23" onClick="go('kqrecord.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">考勤记录</td>
	                  </tr>
	              </table></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table>

	      
	        <table width="82%" border="0" id="2@5"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('qjinfo.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">请假申请</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
      
      <table width="82%" border="0" id="2@6"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="23" onClick="go('chat.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">互动交流</td>
                  </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
      </table>
	      
	     	<table width="82%" border="0" id="2@7"  style="display: none"  align="center" cellpadding="0" cellspacing="0">
	        <tr>
	          <td height="38"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td width="33" height="28"><img src="images/main_46.gif" width="28" height="28"></td>
	              <td width="99"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	                  <tr>
	                    <td height="23" onClick="go('myinfo.jsp')" class="STYLE4" style="cursor:hand" onMouseOver="this.style.backgroundImage='url(images/tab_bg.gif)';this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#adb9c2'; "onmouseout="this.style.backgroundImage='url()';this.style.borderStyle='none'">个人信息编辑</td>
	                  </tr>
	              </table></td>
	            </tr>
	          </table></td>
	        </tr>
	      </table>
	  
	  </div></td></tr>
  <%} %>
  
  
</table>
</body>
</html>
<script language="javascript">
        function go(purl)
        {
        parent.document.getElementsByTagName("iframe")[1].src=(purl);
        }
        </script>
