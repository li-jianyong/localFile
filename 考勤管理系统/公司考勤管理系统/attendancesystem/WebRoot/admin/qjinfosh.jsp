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
<%

 String hql = "select * from qjinfo where 1=1 ";
        String url = "/attendancesystem/admin/qjinfosh.jsp?1=1";
         String key = request.getParameter("key")==null?"":request.getParameter("key");
         String key1 = request.getParameter("key1")==null?"":request.getParameter("key1");
         String key2 = request.getParameter("key2")==null?"":request.getParameter("key2");
         String f = request.getParameter("f");
         if(f==null)
         {
         key = Info.getUTFStr(key);
         }
         
         if(!key.equals(""))
         {
         hql+=" and (qjdate >='"+key+"' )";
         url+="&key="+key;
         }
         if(!key1.equals(""))
         {
         hql+=" and (qjdate <='"+key1+"' )";
         url+="&key1="+key1;
         }
         if(!key2.equals(""))
         {
         hql+=" and (empid ='"+key2+"' )";
         url+="&key2="+key2;
         }
         hql+=" order by id desc";
 %>
<form action="qjinfosh.jsp?f=f" name="f1" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="24" bgcolor="#353c44"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="6%" height="19" valign="bottom"><img src="images/tb.gif" width="14" height="14" /></td>
                <td width="94%" valign="bottom"><span class="STYLE1"> 请假管理</span></td>
              </tr>
            </table></td>
            <td><div align="right">
            <span onclick="add();" class="STYLE1" style="cursor: hand"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            
            <script language="javascript">
            function add()
            {
            pop("qjadd.jsp","添加请假信息",600,253);
            }
            
             function update(no)
            {
            pop("qjedit.jsp?id="+no,"修改请假信息",600,253);
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
        <td height="30" colspan="7" align="left" bgcolor="#FFFFFF" class="STYLE19">请输入相关信息:
          <input name="key" style="height: 12px" type="text" size="30" value="<%=key %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
          -<input name="key1" style="height: 12px" type="text" size="30" value="<%=key1 %>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
           <script type="text/javascript" src="/attendancesystem/commfiles/js/calendar/WdatePicker.js"></script>
           人员:<select id="key2" name="key2">
           	<option value="">请选择</option>
           	<% CommDAO dao = new CommDAO();
           	ArrayList<HashMap> l = (ArrayList<HashMap>)dao.select("select * from sysuser where delstatus='0' and role not in ('管理员') and status='在岗' "); 
           	for(HashMap lm:l){%>
           	<option value="<%=lm.get("id") %>" <%if(lm.get("id").equals(key2)){out.print("selected==selected");} %>><%=lm.get("realname") %></option>
           	<%} %>
           </select>
          <input type="button" style="height: 20px"  onclick="f1.submit();" name="Submit" value="查询" />
          </td>
        </tr>
      
      
      <tr>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">请假人</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">请假开始日期</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">请假结束日期</td>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">请假天数</td>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">原因</td>
        <td height="30" align="center" bgcolor="d3eaef" class="STYLE10">审核状态</td>
        <td  height="30" align="center" bgcolor="d3eaef" class="STYLE10">操作</td>
      </tr>
      
      
      
   <%
      String tgid = request.getParameter("tgid");
      if(tgid!=null)
      {
      dao.commOper("update   qjinfo set status='通过' where id="+tgid);
      }
      String jjid = request.getParameter("jjid");
      if(jjid!=null)
      {
      dao.commOper("update   qjinfo set status='拒绝' where id="+jjid);
      }
    
         
        PageManager pageManager = PageManager.getPage(url,10, request);
	    pageManager.doList(hql);
	    PageManager bean= (PageManager)request.getAttribute("page");
	    ArrayList<HashMap> nlist=(ArrayList)bean.getCollection();
	    for(HashMap m :nlist)
	    {
	    	HashMap mm = dao.select("select * from sysuser where id="+m.get("empid")).get(0);
         %>
      <tr>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=mm.get("realname") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("qjdate") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("etime") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("qjnum") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("reason") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19"><%=m.get("status") %></td>
        <td height="30" align="center" bgcolor="#FFFFFF" class="STYLE19">
        <%if(m.get("status").equals("待审核")){ %>
        <a href="qjinfosh.jsp?tgid=<%=m.get("id") %>">通过</a>
        |
        <a href="qjinfosh.jsp?jjid=<%=m.get("id") %>">拒绝</a>
        </td>
        <%} %>
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
</form>
</body>
</html>
