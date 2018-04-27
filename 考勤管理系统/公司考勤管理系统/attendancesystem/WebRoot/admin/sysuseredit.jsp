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
<form action="/attendancesystem/attendancesystem?ac=useredit" name="f1" method="post" enctype="multipart/form-data" onsubmit="return checkk()">
<input type="hidden" id="id" name="id" value="<%=id %>" >
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onMouseOver="changeto()"  onmouseout="changeback()">
      
      <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">登录名</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><%=userm.get("uname") %></td>
         <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">密码</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        <input name="upass" type="password" id="upass" size="10" value="<%=userm.get("upass") %>"/>*
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">姓名</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        <input name="realname" type="text" id="realname" size="10" value="<%=userm.get("realname") %>"/>*</label></td>
        </tr>
        
        <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">性别</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        <select id="sex" name="sex">
        	<option value="">请选择</option>
        	<option value="男" <%if(userm.get("sex").equals("男")){out.print("selected==selected");} %>>男</option>
        	<option value="女" <%if(userm.get("sex").equals("女")){out.print("selected==selected");} %>>女</option>
        </select>*
        </label></td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">年龄</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        <input name="age" type="text" id="age" size="10" value="<%=userm.get("age") %>"/>
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">生日</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        <input name="birth" type="text" id="birth" value="<%=userm.get("birth") %>" size="10" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly==true/>*</label></td>
        <script type="text/javascript" src="/attendancesystem/commfiles/js/calendar/WdatePicker.js"></script>
        </tr>
        
        <tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">学历</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        <select id="xl" name="xl">
        	<option value="">请选择</option>
        	<option value="小学" <%if(userm.get("xl").equals("小学")){out.print("selected==selected");} %>>小学</option>
        	<option value="初中" <%if(userm.get("xl").equals("初中")){out.print("selected==selected");} %>>初中</option>
        	<option value="高中" <%if(userm.get("xl").equals("高中")){out.print("selected==selected");} %>>高中</option>
        	<option value="大专" <%if(userm.get("xl").equals("大专")){out.print("selected==selected");} %>>大专</option>
        	<option value="本科" <%if(userm.get("xl").equals("本科")){out.print("selected==selected");} %>>本科</option>
        	<option value="研究生" <%if(userm.get("xl").equals("研究生")){out.print("selected==selected");} %>>研究生</option>
        	<option value="博士" <%if(userm.get("xl").equals("博士")){out.print("selected==selected");} %>>博士</option>
        </select>*
        </label></td>
         <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">身份证号</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19" colspan="3">
        <input name="idcard" type="text" id="idcard" size="25" value="<%=userm.get("idcard") %>"/>*
        </td>
        </tr>
		<tr>
			<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">照片</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        		<input name="filename" type="file" id="filename" size="10" />*</label></td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">籍贯</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        <input name="jg" type="text" id="jg" size="10" value="<%=userm.get("jg") %>" />
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">政治面貌</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19"><label>
        <select id="zzmm" name="zzmm">
        	<option value="">请选择</option>
        	<option value="团员" <%if(userm.get("zzmm").equals("团员")){out.print("selected==selected");} %>>团员</option>
        	<option value="党员" <%if(userm.get("zzmm").equals("党员")){out.print("selected==selected");} %>>党员</option>
        	<option value="无党人士" <%if(userm.get("zzmm").equals("无党人士")){out.print("selected==selected");} %>>无党人士</option>
        </select>*</label></td>
		</tr>
	   <tr>
	   		<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">电话</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        	<input name="tel" type="text" id="tel" size="10" value="<%=userm.get("tel") %>" />
        	</td>
        	<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">部门</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        		<select id="dept" name="dept">
        			<option value="">请选择</option>
        			<%ArrayList<HashMap> deptlist = (ArrayList<HashMap>)dao.select("select * from dept "); 
        			for(HashMap m:deptlist){
        			%>
        			<option value="<%=m.get("id") %>" <%if(userm.get("dept").equals(m.get("id"))){out.print("selected==selected");} %>><%=m.get("deptname") %></option>
        			<%} %>
        		</select>
        	</td>
        	<td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">职位</td>
        	<td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        		<select id="zw" name="zw">
        			<option value="">请选择</option>
        			<%ArrayList<HashMap> zwlist = (ArrayList<HashMap>)dao.select("select * from zw "); 
        			for(HashMap m:zwlist){
        			%>
        			<option value="<%=m.get("id") %>" <%if(userm.get("zw").equals(m.get("id"))){out.print("selected==selected");} %>><%=m.get("zwname") %></option>
        			<%} %>
        		</select>
        	</td>
	   </tr>
	   
		<tr>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">民族</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19">
        <input name="mz" type="text" id="mz" size="10" value="<%=userm.get("mz") %>"  />
        </td>
        <td width="10%" height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">用户权限</td>
        <td  height="30" align="left" bgcolor="#FFFFFF" class="STYLE19" colspan="3"><label>
        <select id="role" name="role">
        	<option value="">请选择</option>
        	<option value="员工" <%if(userm.get("role").equals("员工")){out.print("selected==selected");} %>>员工</option>
        	<option value="部门领导" <%if(userm.get("role").equals("部门领导")){out.print("selected==selected");} %>>部门领导</option>
        </select>*
        </label></td>
         
	   <tr>
        <td height="30" colspan="6" align="center" bgcolor="#FFFFFF" class=""><label>
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
   if(f1.upass.value=="")
   {
   alert("请输入新密码");
   return false;
   } if(f1.realname.value=="")
   {
   alert("请输入姓名");
   return false;
   }if(f1.birth.value=="")
   {
   alert("请输入生日");
   return false;
   }if(f1.idcard.value=="")
   {
   alert("请输入身份证号");
   return false;
   }if(f1.zzmm.value=="")
   {
   alert("请选择政治面貌");
   return false;
   }if(f1.dept.value=="")
   {
   alert("请选择部门");
   return false;
   }if(f1.zw.value=="")
   {
   alert("请选择职位");
   return false;
   }if(f1.role.value=="")
   {
   alert("请选择用户权限");
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
parent.location.replace("/attendancesystem/admin/sysuser.jsp");
<%}%>
</script>

