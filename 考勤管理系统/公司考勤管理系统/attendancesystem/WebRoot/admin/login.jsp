<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>宝铭公司员工考勤管理系统</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow:hidden;
}
.STYLE3 {font-size: 12px; color: #adc9d9; }
-->
</style></head>

<body>
<form action="/attendancesystem/attendancesystem?ac=login" name="f1" method="post">
<table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#1075b1">&nbsp;</td>
  </tr>
  <tr>
    <td height="608" background="/attendancesystem/admin/images/login_03.gif"><table width="847" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="264" background="/attendancesystem/admin/images/login_04.gif">&nbsp;</td>
      </tr>
      <tr>
        <td height="84"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="381" height="84" background="/attendancesystem/admin/images/login_06.gif">&nbsp;</td>
            <td width="162" valign="middle" background="/attendancesystem/admin/images/login_07.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="44" height="30" align="left" valign="middle"><div align="right"><span class="STYLE3">用户</span></div></td>
                <td width="10" height="30" align="left" valign="middle">&nbsp;</td>
                <td width="114" height="30" align="left" valign="middle">
                  <div align="left">
                    <input type="text" name="uname" id="textfield" style="width:100px; height:17px; background-color:#87adbf; border:solid 1px #153966; font-size:12px; color:#283439; ">
                  </div></td>
              </tr>
              <tr>
                <td height="30" align="left" valign="middle"><div align="right"><span class="STYLE3">密码</span></div></td>
                <td width="10" height="30" align="left" valign="middle">&nbsp;</td>
                <td height="30" align="left" valign="middle"><input type="password" name="upass" id="textfield2" style="width:100px; height:17px; background-color:#87adbf; border:solid 1px #153966; font-size:12px; color:#283439; "></td>
              </tr>
            </table></td>
            <td width="26"><img src="/attendancesystem/admin/images/login_08.gif" width="26" height="84"></td>
            <td width="67" background="/attendancesystem/admin/images/login_09.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25"><div align="center"><img onclick="f1.submit();" src="/attendancesystem/admin/images/dl.gif" width="57" height="20"></div></td>
              </tr>
              
            </table></td>
            <td width="211" background="/attendancesystem/admin/images/login_10.gif">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="206" background="/attendancesystem/admin/images/login_11.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="#152753">&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
<script type="text/javascript">

 <%
String error = (String)request.getAttribute("error");
if(error!=null)
{
 %>
 alert("用户名或密码错误");
 <%}%>
 </script>


