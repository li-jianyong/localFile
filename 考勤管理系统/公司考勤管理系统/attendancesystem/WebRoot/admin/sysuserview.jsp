<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="common.CommDAO"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 3px;
	margin-top: 0px;
	margin-right: 3px;
	margin-bottom: 0px;
}
.STYLE1 {
	color: #e1e2e3;
	font-size: 12px;
}
.STYLE6 {color: #000000; font-size: 12; }
.STYLE10 {color: #000000; font-size: 12px; }
.STYLE19 {
	color: #344b50;
	font-size: 12px;
}
.STYLE21 {
	font-size: 12px;
	color: #3b6375;
}
.STYLE22 {
	font-size: 12px;
	color: #295568;
}
-->
</style>

<script>
var  highlightcolor='#d5f4fe';
//此处clickcolor只能用win系统颜色代码才能成功,如果用#xxxxxx的代码就不行,还没搞清楚为什么:(
var  clickcolor='#51b2f6';
function  changeto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[0].style.backgroundColor!=highlightcolor&&source.id!="nc"&&cs[0].style.backgroundColor!=clickcolor)
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=highlightcolor;
}
}

function  changeback(){
if  (event.fromElement.contains(event.toElement)||source.contains(event.toElement)||source.id=="nc")
return
if  (event.toElement!=source&&cs[0].style.backgroundColor!=clickcolor)
//source.style.backgroundColor=originalcolor
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}

function  clickto(){
source=event.srcElement;
if  (source.tagName=="TR"||source.tagName=="TABLE")
return;
while(source.tagName!="TD")
source=source.parentElement;
source=source.parentElement;
cs  =  source.children;
//alert(cs.length);
if  (cs[0].style.backgroundColor!=clickcolor&&source.id!="nc")
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor=clickcolor;
}
else
for(i=0;i<cs.length;i++){
	cs[i].style.backgroundColor="";
}
}
</script>

<script language="javascript" src="../js/ajax.js"></script>

</head>

<body >
<%CommDAO dao = new CommDAO();
String id = request.getParameter("id");
HashMap userm = dao.select("select * from sysuser where id="+id).get(0);
%>
<form action="/attendancesystem/attendancesystem?ac=useredit" name="f1" method="post" enctype="multipart/form-data">
<input type="hidden" id="id" name="id" value="<%=id %>" >
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onMouseOver="changeto()"  onmouseout="changeback()">
      
      <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">登录名</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("uname") %></td>
         <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">密码</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("upass") %>
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">姓名</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("realname") %></td>
        </tr>
        
        <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">性别</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("sex") %></td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">年龄</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("age") %></td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">生日</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("birth") %></td>
        </tr>
        
        <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">学历</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("xl") %></td>
         <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">身份证号</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19" colspan="3"><%=userm.get("idcard") %>
        </td>
        </tr>
		<tr>
			 <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">民族</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("mz") %>
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">籍贯</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("jg") %>
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">政治面貌</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("zzmm")%></td>
		</tr>
	   <tr>
	   		<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">电话</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("tel") %>
        	</td>
        	<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">部门</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        			<%HashMap deptm = dao.select("select * from dept where id="+userm.get("dept")).get(0); %>
        			<%=deptm.get("deptname") %>
        	</td>
        	<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">职位</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        		<%HashMap zwm = dao.select("select * from zw where id="+userm.get("zw")).get(0); %>
        			<%=zwm.get("zwname") %>
        	</td>
	   </tr>
	   
		<tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">民族</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("mz") %>
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">用户权限</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19" colspan="3"><%=userm.get("role")%></td>
	   
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
 <script type="text/javascript">
   function checkk()
   {
    if(f1.uname.value=="")
   {
   alert("请输入用户名");
   return;
   }
   if(f1.upass.value=="")
   {
   alert("请输入新密码");
   return;
   } if(f1.truename.value=="")
   {
   alert("请输入真实姓名");
   return;
   }
   
   }
   </script>

<script language="javascript">
<%
String suc = (String)request.getAttribute("suc");
if(suc!=null)
{
%>
alert("操作成功");
parent.location.replace("/attendancesystem/admin/sysuser.jsp");
<%}%>
</script>

