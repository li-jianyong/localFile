<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="util.PageManager"%>
<%@page import="util.Info"%>
<%@page import="common.CommDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

<script language="javascript" src="../js/popup.js"></script>

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
<form action="dk.jsp?f=f" name="f1" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" bgcolor="#353c44"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="6%" height="19" valign="bottom"><img src="images/tb.gif" width="14" height="14" /></td>
                <td width="94%" valign="bottom"><span class="STYLE1"> 上/班打卡</span></td>
              </tr>
            </table></td>
            <td><div align="right">
            
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            
            <script language="javascript">
            function add()
            {
            pop("zwadd.jsp","添加职位",600,253);
            }
            
             function update(no)
            {
            pop("zwedit.jsp?id="+no,"修改职位",600,253);
            }
            
            
            </script>
            
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onmouseover="changeto()"  onmouseout="changeback()">
      
      <tr>
        <td height="50" width="50%" align="center" bgcolor="d3eaef" class="STYLE10" valign="middle">
        上班
        </td>
        <td height="50" width="50%" align="center" bgcolor="d3eaef" class="STYLE10" valign="middle">
        下班
        </td>
       </tr>
      
     <%CommDAO dao = new CommDAO();
     HashMap admin = (HashMap)session.getAttribute("admin");
     ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("select * from kqrecord where  empid='"+admin.get("id")+"' and recordrq='"+Info.getDateStr().substring(0,10)+"'");
     
     %>
      
      
      <tr>
        <td height="300" width="50%" align="center" bgcolor="d3eaef" class="STYLE10" valign="middle">
        <%if(list.size()==0){ %>
        <a href="/attendancesystem/attendancesystem?ac=sbdk">上班打卡</a>
        <%}else{ 
        HashMap map = list.get(0);
        %>
        <%=map.get("stime") %>
        <%} %>
        </td>
        <td height="300" align="center" bgcolor="d3eaef" class="STYLE10" valign="middle">
        <%if(list.size()==0){ %>
        	请先打上班卡
        <%}else{ 
        HashMap map = list.get(0);
        if(map.get("etime")==null){%>
        	<a href="/attendancesystem/attendancesystem?ac=xbdk&id=<%=map.get("id") %>">下班打卡</a>
        <%}else{%>
        <%=map.get("etime") %>
        <%} }%>
        </td>
      </tr>
      

      
         <script type="text/javascript">

											</script>
      
      
    </table></td>
  </tr>
  
</table>
</form>
<script language="javascript">
<%
String suc = (String)request.getAttribute("suc");
if(suc!=null)
{
%>
alert("操作成功");
location.replace("/attendancesystem/admin/dk.jsp");
<%}%>
</script>
</body>
</html>
