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
<%CommDAO dao = new CommDAO(); %>
<form action="sysuser.jsp?f=f" name="f1" method="post">
<!--startprint1-->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" bgcolor="#353c44"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="6%" height="19" valign="bottom"><img src="images/tb.gif" width="14" height="14" /></td>
                <td width="94%" valign="bottom"><span class="STYLE1"> 公司人员管理</span></td>
              </tr>
            </table></td>
            <td><div align="right"> 
             
            <span onclick="add()" class="STYLE1" style=""><img src="images/add.gif" width="10" height="10" />添加</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
             
             
            <script language="javascript">
            function preview(oper)       
{
if (oper < 10)
{
bdhtml=window.document.body.innerHTML;//获取当前页的html代码
sprnstr="<!--startprint"+oper+"-->";//设置打印开始区域
eprnstr="<!--endprint"+oper+"-->";//设置打印结束区域
prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html

prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
window.document.body.innerHTML=prnhtml;
window.print();
window.document.body.innerHTML=bdhtml;
} else {
window.print();
}
}
            function add()
            {
            pop("sysuseradd.jsp","添加用户",650,250);
            }
            
             function update(no)
            {
            pop("sysuseredit.jsp?id="+no,"修改用户",650,250);
            }
            function view(no)
            {
            pop("sysuserview.jsp?id="+no,"查看人员详情",650,250);
            }
            </script> 
             
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#a8c7ce" onmouseover="changeto()"  onmouseout="changeback()">
      
      <tr>
        <td height="30" colspan="11" align="left" bgcolor="#FFFFFF" class="STYLE19">按姓名或用户名查询:
          <label>
          <input name="key" style="height: 12px" type="text" size="30" />
          部门：
          <%ArrayList<HashMap> bmlist = (ArrayList<HashMap>)dao.select("select * from dept "); %>
          <select id="key2" name="key2">
          		<option value="">全部</option>
          		<%for(HashMap bm:bmlist){ %>
          		<option value="<%=bm.get("id") %>"><%=bm.get("deptname") %></option>
          		<%} %>
          </select>
          <input type="button" style="height: 20px"  onclick="f1.submit();" name="Submit" value="查询" />
          <input id="btnPrint" type="button" value="打印" onclick="javascript:window.print();" />
          </label></td>
        </tr>
      
      
      <tr>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">照片</td>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">登录名</td>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">姓名</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">性别</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">年龄</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">民族</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">电话</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">部门</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">职位</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">基本操作</td>
      </tr>
      
      
      <%

 String hql = "select * from sysuser where 1=1 and delstatus=0 and  role  not in ('管理员') ";
        String url = "/attendancesystem/admin/sysuser.jsp?1=1";
         String key = request.getParameter("key")==null?"":request.getParameter("key");
         String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
         String f = request.getParameter("f");
         if(f==null)
         {
         key = Info.getUTFStr(key);
         }
         
         if(!key.equals(""))
         {
         hql+=" and (realname like'%"+key+"%' or  uname like'%"+key+"%'  )";
         url+="&key="+key;
         }if(!key2.equals(""))
         {
             hql+=" and (dept = '"+key2+"' )";
             url+="&key2="+key2;
             }
         hql+=" order by id desc";
 %>
   <%
        
      String did = request.getParameter("did");
      if(did!=null)
      {
      dao.commOper("update sysuser set delstatus='1' where id="+did);
      }
    
         
        PageManager pageManager = PageManager.getPage(url,10, request);
	    pageManager.doList(hql);
	    PageManager bean= (PageManager)request.getAttribute("page");
	    ArrayList<HashMap> nlist=(ArrayList)bean.getCollection();
	    
	   
	    for(HashMap m :nlist)
	    {
         %>
      <tr>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><img width="60" height="80" src="/attendancesystem/upfile/<%=m.get("img") %>"  /> </td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("uname") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><a href="javascript:view(<%=m.get("id") %>)"><%=m.get("realname") %></a></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("sex") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("age") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("mz") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("tel") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">
        <%HashMap deptm = dao.select("select * from dept where id='"+m.get("dept")+"' ").get(0); %>
        <%=deptm.get("deptname") %>
        </td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">
        <%HashMap zwm = dao.select("select * from zw where id='"+m.get("zw")+"' ").get(0); %>
        <%=zwm.get("zwname") %>
        </td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">
        <a href="javascript:update('<%=m.get("id") %>')" class="STYLE19">编辑</a>&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <a href="sysuser.jsp?did=<%=m.get("id") %>" class="STYLE19" onclick="javascript:return ConfirmDel();">删除</a> 
        
        
        
        </td>
      </tr>
      <%} %>
         <script type="text/javascript">
		function ConfirmDel() {
		if (confirm("真的要删除吗？")){
				return true;
		}else{
			return false;
	}
	}
											</script>
      
      
      
    </table></td>
  </tr>
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" class="STYLE19">${page.info }</td>
        </tr>
    </table></td>
  </tr>
</table>
<!--endprint1-->
</form>
</body>
</html>
