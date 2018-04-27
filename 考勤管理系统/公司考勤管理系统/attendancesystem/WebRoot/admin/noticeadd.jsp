<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
.STYLE19 {
	color: #344b50;
	font-size: 12px;
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


</head>

<body>
<form action="/attendancesystem/attendancesystem?ac=addnotice" name="f1" method="post" onsubmit="return checkk()">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onMouseOver="changeto()"  onmouseout="changeback()">
      <tr>
        <td height="31" align="center" bgcolor="#FFFFFF" class="STYLE19" colspan="2"><label><strong>请输入公告信息</strong></label></td>
        </tr>
      <tr>
      	<td height="15" align="center" bgcolor="#FFFFFF" class="STYLE19">标题</td>
        <td height="15"  bgcolor="#FFFFFF" class="STYLE19">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" id="title" name="title" size="40"/></td>
      </tr>
      <tr>
      	<td height="15" align="center" bgcolor="#FFFFFF" class="STYLE19">内容</td>
        <td height="15" align="center" bgcolor="#FFFFFF" class="STYLE19"><textarea name="content" cols="60" rows="5"></textarea></td>
      </tr>
	   <tr>
        <td height="30" align="center" bgcolor="#FFFFFF" class="" colspan="2"><label>
          <input type="submit" name="Submit"  value="提交信息" />&nbsp;&nbsp;&nbsp;
          <input type="reset" name="Submit2" value="重新填写" />
</label></td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
 <script type="text/javascript">
   function checkk()
   {
    if(f1.title.value=="")
   {
   alert("请输入标题");
   return false;
   }
   if(f1.content.value=="")
   {
   alert("请输入内容");
   return false;
   }
   }
   </script>
   
   <script language="javascript">
<%
String error = (String)request.getAttribute("error");
if(error!=null)
{
%>
alert("原密码错误");
<%}%>
</script>
<script language="javascript">
<%
String suc = (String)request.getAttribute("suc");
if(suc!=null)
{
%>
alert("操作成功");
parent.location.replace("/attendancesystem/admin/notice.jsp");
<%}%>
</script>

<script language="javascript">
<%
String ersuc = (String)request.getAttribute("ersuc");
if(ersuc!=null)
{
%>
alert("操作成功");
parent.location.replace("/attendancesystem/admin/notice.jsp");
<%}%>
</script>
