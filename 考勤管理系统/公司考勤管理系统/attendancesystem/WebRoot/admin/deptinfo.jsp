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
<%CommDAO dao = new CommDAO(); 
HashMap map = (HashMap)session.getAttribute("admin");
HashMap deptm = dao.select("select * from dept where id="+map.get("dept")).get(0);
%>
<form action="/attendancesystem/attendancesystem?ac=lddeptedit" name="f1" method="post" onsubmit="return checkk()">
<input type="hidden" id="id" name="id" value="<%=deptm.get("id") %>" >
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onMouseOver="changeto()"  onmouseout="changeback()">
      <tr>
        <td height="31" align="center" bgcolor="#FFFFFF" class="STYLE19" colspan="2"><label><strong>部门信息</strong></label></td>
        </tr>
      <tr>
      	<td  align="center" bgcolor="#FFFFFF" class="STYLE19">部门名称</td>
        <td   bgcolor="#FFFFFF" class="STYLE19"><%=deptm.get("deptname") %></td>
      </tr>
      <tr>
      	<td  align="center" bgcolor="#FFFFFF" class="STYLE19">部门职责</td>
        <td   bgcolor="#FFFFFF" class="STYLE19">
        <input type="text" id="deptzz" name="deptzz" size="40" value="<%=deptm.get("deptzz") %>"/></td>
      </tr>
      <tr>
      	<td  align="center" bgcolor="#FFFFFF" class="STYLE19">部门地址</td>
        <td   bgcolor="#FFFFFF" class="STYLE19">
        <input type="text" id="deptaddr" name="deptaddr" size="40" value="<%=deptm.get("deptaddr") %>"/></td>
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
    
   if(f1.deptinfo.value=="")
   {
   alert("请输入部门信息");
   return false;
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
location.replace("/attendancesystem/admin/deptinfo.jsp");
<%}%>
</script>


