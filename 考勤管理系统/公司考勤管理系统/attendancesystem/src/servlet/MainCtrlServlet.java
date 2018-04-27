package servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;

import common.CommDAO;



import util.Info;


public class MainCtrlServlet extends HttpServlet {

	public MainCtrlServlet() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	this.doPost(request, response);
	}

		public void go(String url,HttpServletRequest request, HttpServletResponse response)
		{
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
		
		public void gor(String url,HttpServletRequest request, HttpServletResponse response)
		{
			try {
				response.sendRedirect(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		HashMap user = (HashMap)session.getAttribute("admin");
		HashMap vip = (HashMap)session.getAttribute("vip");
		String ac = request.getParameter("ac");
		if(ac==null)ac="";
		CommDAO dao = new CommDAO();
		String date = Info.getDateStr();
		String today = date.substring(0,10);
		String tomonth = date.substring(0,7);
		//登录
		if(ac.equals("login"))
		{
			    String uname = request.getParameter("uname");
			    String upass = request.getParameter("upass");
			    	String sql = "select * from sysuser where uname='"+uname+"' and upass='"+upass+"' and delstatus=0 and status='在岗' ";
			    	List<HashMap> list = dao.select(sql);
			    	if(list.size()==1)
			    	{
			    	session.setAttribute("admin", list.get(0));
			    	gor("/attendancesystem/admin/main.jsp", request, response);
			    	}else{
			    		request.setAttribute("error", "");
				    	go("/admin/login.jsp", request, response);
			    	}
		}
		
		
		
		//退出登录
		if(ac.equals("exit"))
		{
			   session.invalidate();    	
			   gor("/attendancesystem/welcome.jsp", request, response);    	
			    	
		}
		
		//修改密码
		if(ac.equals("uppass"))
		{
			    String oldpass = request.getParameter("oldpass");  
			    String upass = request.getParameter("upass");
			    if(!user.get("upass").equals(oldpass))
			    {
			    	request.setAttribute("error", "");
			    	go("/admin/uppass.jsp", request, response);
			    }else{
			    	String sql = "update sysuser set upass='"+upass+"' where id="+user.get("id");
			    	dao.commOper(sql);
			    	request.setAttribute("suc", "");
			    	go("/admin/uppass.jsp", request, response);
			    }
		}
		
		
		
		
		
		
		//用户添加
		if(ac.equals("adduser"))
		{
			    String uname = request.getParameter("uname");  
			    String utype = request.getParameter("utype");
			    
			    String csql = "select * from sysuser where uname='"+uname+"' and utype='"+utype+"'";
			    if(dao.select(csql).size()>0)
			    {
			    	request.setAttribute("error", "");
			    	go("/admin/adduser.jsp", request, response);
			    }else{
			    String upass = request.getParameter("upass");
			    String truename = request.getParameter("truename");
			    String phone = request.getParameter("phone");
			    String status = "0";
			  
			    String sql = "insert into sysuser(uname,upass,utype,truename,phone,status) values('"+uname+"','"+upass+"','"+utype+"','"+truename+"','"+phone+"','"+status+"')";
			    dao.commOper(sql);
			    
		    	request.setAttribute("suc", "");
		    	go("/admin/adduser.jsp", request, response);
			    }
		}
		

		
		//修改用户
		if(ac.equals("updateuser"))
		{
			    String id = request.getParameter("id");
			    String upass = request.getParameter("upass");
			    String truename = request.getParameter("truename");
			    String phone = request.getParameter("phone");
			    String utype = request.getParameter("utype");
			    String sql = "update sysuser set upass='"+upass+"',truename='"+truename+"',phone='"+phone+"',utype='"+utype+"' where id="+id;
			    System.out.println(sql);
			    dao.commOper(sql);
		    	request.setAttribute("suc", "");
		    	request.setAttribute("id", id);
		    	go("/admin/updateuser.jsp?id="+id, request, response);
			  
		    	
		}
		//用户修改自己信息
		if(ac.equals("updateuser1"))
		{
			    String id = request.getParameter("id");
			    String uname = request.getParameter("uname");  
			    String upass = request.getParameter("upass");
			    String truename = request.getParameter("truename");
			    String tel = request.getParameter("tel");
			    String sql = "update sysuser set uname='"+uname+"',upass='"+upass+"',truename='"+truename+"',phone='"+tel+"' where id="+id;
			    dao.commOper(sql);
			    
		    	request.setAttribute("suc", "");
		    	request.setAttribute("id", id);
		    	go("/xgxx.jsp?id="+id, request, response);
		}

	//添加公告
	if(ac.equals("addnotice"))
	{
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String savetime = Info.getDateStr();
	    String sql = "insert into notice (title,content,savetime) values('"+title+"','"+content+"','"+savetime+"')";
	    dao.commOper(sql);
    	request.setAttribute("suc", "");
    	go("/admin/noticeadd.jsp", request, response);
	}
	//更新公告
	if(ac.equals("upnotice"))
	{
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String savetime = Info.getDateStr();
	    String sql = "update notice set title='"+title+"' ,content='"+content+"' where id="+id+"";
	    dao.commOper(sql);
	    request.setAttribute("suc", "");
    	go("/admin/noticeedit.jsp?id="+id, request, response);
	}
	
	//添加部门
	if(ac.equals("deptadd"))
	{
		String deptname = request.getParameter("deptname");
		String deptzz = request.getParameter("deptzz");
		String deptaddr = request.getParameter("deptaddr");
	    String sql = "insert into dept (deptname,deptzz,deptaddr) values('"+deptname+"','"+deptzz+"','"+deptaddr+"')";
	    dao.commOper(sql);
    	request.setAttribute("suc", "");
    	go("/admin/deptadd.jsp", request, response);
	}
	//更新部门
	if(ac.equals("deptedit"))
	{
		String id = request.getParameter("id");
		String deptname = request.getParameter("deptname");
		String deptzz = request.getParameter("deptzz");
		String deptaddr = request.getParameter("deptaddr");
	    String sql = "update dept set deptname='"+deptname+"' ,deptzz='"+deptzz+"',deptaddr='"+deptaddr+"' where id="+id+"";
	    dao.commOper(sql);
	    request.setAttribute("suc", "");
    	go("/admin/deptedit.jsp?id="+id, request, response);
	}
	//部门领导编辑部门信息
	if(ac.equals("lddeptedit")){
		String id = request.getParameter("id");
		String deptname = request.getParameter("deptname");
		String deptzz = request.getParameter("deptzz");
		String deptaddr = request.getParameter("deptaddr");
	    String sql = "update dept set  deptzz='"+deptzz+"',deptaddr='"+deptaddr+"' where id="+id+"";
	    dao.commOper(sql);
	    request.setAttribute("suc", "");
    	go("/admin/deptinfo.jsp", request, response);
	}
	
	//添加职位
	if(ac.equals("zwadd"))
	{
		String zwname = request.getParameter("zwname");
		
	    String sql = "insert into zw (zwname) values('"+zwname+"')";
	    dao.commOper(sql);
    	request.setAttribute("suc", "");
    	go("/admin/zwadd.jsp", request, response);
	}
	//更新职位
	if(ac.equals("zwedit"))
	{
		String id = request.getParameter("id");
		String zwname = request.getParameter("zwname");
	    String sql = "update zw set zwname='"+zwname+"'  where id="+id+"";
	    dao.commOper(sql);
	    request.setAttribute("suc", "");
    	go("/admin/zwedit.jsp?id="+id, request, response);
	}
	//管理员添加用户
	if(ac.equals("useradd"))
	{
        try {
        	String uname="";
        	String upass = "";
        	String realname = "";
        	String sex = "";
        	String age = "";
        	String birth = "";
        	String xl = "";
        	String idcard = "";
        	String fileurl = "";
        	String jg = "";
        	String zzmm = "";
        	String tel = "";
        	String dept = "";
        	String zw = "";
        	String mz = "";
        	String role = "";
			
			request.setCharacterEncoding("utf-8");
			RequestContext  requestContext = new ServletRequestContext(request);
			if(FileUpload.isMultipartContent(requestContext)){

			   DiskFileItemFactory factory = new DiskFileItemFactory();
			   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
			   ServletFileUpload upload = new ServletFileUpload(factory);
			   upload.setSizeMax(100*1024*1024);
			   List items = new ArrayList();
			    
			     items = upload.parseRequest(request);
			     uname = ((FileItem) items.get(0)).getString();
			     uname = Info.getUTFStr(uname);
			     upass = ((FileItem) items.get(1)).getString();
			     upass = Info.getUTFStr(upass);
			     realname = ((FileItem) items.get(2)).getString();
			     realname = Info.getUTFStr(realname);
			     sex = ((FileItem) items.get(3)).getString();
			     sex = Info.getUTFStr(sex);
			     age = ((FileItem) items.get(4)).getString();
			     age = Info.getUTFStr(age);
			     birth = ((FileItem) items.get(5)).getString();
			     birth = Info.getUTFStr(birth);
			     xl = ((FileItem) items.get(6)).getString();
			     xl = Info.getUTFStr(xl);
			     idcard = ((FileItem) items.get(7)).getString();
			     idcard = Info.getUTFStr(idcard);
			     jg = ((FileItem) items.get(9)).getString();
			     jg = Info.getUTFStr(jg);
			     zzmm = ((FileItem) items.get(10)).getString();
			     zzmm = Info.getUTFStr(zzmm);
			     tel = ((FileItem) items.get(11)).getString();
			     tel = Info.getUTFStr(tel);
			     dept = ((FileItem) items.get(12)).getString();
			     dept = Info.getUTFStr(dept);
			     zw = ((FileItem) items.get(13)).getString();
			     zw = Info.getUTFStr(zw);
			     mz = ((FileItem) items.get(14)).getString();
			     mz = Info.getUTFStr(mz);
			     role = ((FileItem) items.get(15)).getString();
			     role = Info.getUTFStr(role);
		    FileItem fileItem = (FileItem) items.get(8);
		     if(fileItem.getName()!=null && fileItem.getSize()!=0){
		      File fullFile = new File(fileItem.getName());
		      fileurl = Info.generalFileName(fullFile.getName());
		      File newFile = new File(request.getRealPath("/upfile/")+"/" + fileurl);
		      try {
		       fileItem.write(newFile);
		      } catch (Exception e) {
		       e.printStackTrace();
		      }
		     }else{
		     }
		    }
		String sql = "select * from sysuser where uname='"+uname+"'";
		ArrayList list = (ArrayList)dao.select(sql);
		if(list.size()==0){
			String sql1 = "insert into sysuser (uname,upass,realname,sex,birth,age,xl,idcard,img,jg,zzmm,tel,dept,zw,role,delstatus,mz,status ) values" +
					"('"+uname+"','"+upass+"','"+realname+"','"+sex+"','"+birth+"','"+age+"','"+xl+"','"+idcard+"','"+fileurl+"'" +
							",'"+jg+"','"+zzmm+"','"+tel+"','"+dept+"','"+zw+"','"+role+"','0','"+mz+"','在岗')";
			dao.commOper(sql1);
			request.setAttribute("suc", "");
				go("/admin/sysuseradd.jsp", request, response);
		}else{
			request.setAttribute("error", "");
		     request.getRequestDispatcher("/admin/sysuseradd.jsp").forward(request, response);
		    
		}
		} catch (Exception e1) {
			e1.printStackTrace();
			request.setAttribute("error", "");
		     request.getRequestDispatcher("/admin/sysuseradd.jsp").forward(request, response);
		    }
	}
	
	
	//管理员修改用户
	if(ac.equals("useredit"))
	{
        try {
        	String id = "";
        	String upass = "";
        	String realname = "";
        	String sex = "";
        	String age = "";
        	String birth = "";
        	String xl = "";
        	String idcard = "";
        	String fileurl = "";
        	String jg = "";
        	String zzmm = "";
        	String tel = "";
        	String dept = "";
        	String zw = "";
        	String mz = "";
        	String role = "";
		request.setCharacterEncoding("utf-8");
		RequestContext  requestContext = new ServletRequestContext(request);
		if(FileUpload.isMultipartContent(requestContext)){

		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
		   ServletFileUpload upload = new ServletFileUpload(factory);
		   upload.setSizeMax(100*1024*1024);
		   List items = new ArrayList();
		    
		     items = upload.parseRequest(request);
		     id = ((FileItem) items.get(0)).getString();
		     id = Info.getUTFStr(id);
		     upass = ((FileItem) items.get(1)).getString();
		     upass = Info.getUTFStr(upass);
		     realname = ((FileItem) items.get(2)).getString();
		     realname = Info.getUTFStr(realname);
		     sex = ((FileItem) items.get(3)).getString();
		     sex = Info.getUTFStr(sex);
		     age = ((FileItem) items.get(4)).getString();
		     age = Info.getUTFStr(age);
		     birth = ((FileItem) items.get(5)).getString();
		     birth = Info.getUTFStr(birth);
		     xl = ((FileItem) items.get(6)).getString();
		     xl = Info.getUTFStr(xl);
		     idcard = ((FileItem) items.get(7)).getString();
		     idcard = Info.getUTFStr(idcard);
		     jg = ((FileItem) items.get(9)).getString();
		     jg = Info.getUTFStr(jg);
		     zzmm = ((FileItem) items.get(10)).getString();
		     zzmm = Info.getUTFStr(zzmm);
		     tel = ((FileItem) items.get(11)).getString();
		     tel = Info.getUTFStr(tel);
		     dept = ((FileItem) items.get(12)).getString();
		     dept = Info.getUTFStr(dept);
		     zw = ((FileItem) items.get(13)).getString();
		     zw = Info.getUTFStr(zw);
		     mz = ((FileItem) items.get(14)).getString();
		     mz = Info.getUTFStr(mz);
		     role = ((FileItem) items.get(15)).getString();
		     role = Info.getUTFStr(role);
		    FileItem fileItem = (FileItem) items.get(8);
		    HashMap map = dao.select("select * from sysuser where id="+id).get(0);
		    if(fileItem.getName()!=null && fileItem.getSize()!=0)
		    {
		    //Info.delPic(request.getRealPath("/upfile")+"/",map.get("fileurl").toString());
		    
		     if(fileItem.getName()!=null && fileItem.getSize()!=0){
		      File fullFile = new File(fileItem.getName());
		      fileurl = Info.generalFileName(fullFile.getName());
		      File newFile = new File(request.getRealPath("/upfile/")+"/" + fileurl);
		      try {
		       fileItem.write(newFile);
		      } catch (Exception e) {
		       e.printStackTrace();
		      }
		     }else{
		    	 fileurl = map.get("img").toString();
		     }
		    }
		}
		//uname,upass,realname,sex,birth,age,xl,idcard,img,jg,zzmm,tel,dept,zw,role,delstatus,mz
		String sql = "";
		if(!fileurl.equals("")){
			sql = "update sysuser set upass='"+upass+"',img='"+fileurl+"',realname='"+realname+"',sex='"+sex+"'" +
			",birth='"+birth+"',age='"+age+"',xl='"+xl+"',idcard='"+idcard+"',jg='"+jg+"',zzmm='"+zzmm+"',tel='"+tel+"'" +
					",dept='"+dept+"',zw='"+zw+"',role='"+role+"',mz='"+mz+"' where id="+id;
		}else{
			sql = "update sysuser set upass='"+upass+"',realname='"+realname+"',sex='"+sex+"'" +
			",birth='"+birth+"',age='"+age+"',xl='"+xl+"',idcard='"+idcard+"',jg='"+jg+"',zzmm='"+zzmm+"',tel='"+tel+"'" +
					",dept='"+dept+"',zw='"+zw+"',role='"+role+"',mz='"+mz+"' where id="+id;
		}
		
		dao.commOper(sql);
		request.setAttribute("suc", "");
		go("/admin/sysuseredit.jsp?id="+id, request, response);
		} catch (Exception e1) {
			e1.printStackTrace();
			request.setAttribute("error", "");
		     request.getRequestDispatcher("/admin/sysuseradd.jsp").forward(request, response);
		    }
	}
	//用户修改个人信息
	if(ac.equals("myinfoedit")){
		try {
        	String id = "";
        	String upass = "";
        	String realname = "";
        	String sex = "";
        	String age = "";
        	String birth = "";
        	String xl = "";
        	String idcard = "";
        	String fileurl = "";
        	String jg = "";
        	String zzmm = "";
        	String tel = "";
        	String dept = "";
        	String zw = "";
        	String mz = "";
        	String role = "";
		request.setCharacterEncoding("utf-8");
		RequestContext  requestContext = new ServletRequestContext(request);
		if(FileUpload.isMultipartContent(requestContext)){

		   DiskFileItemFactory factory = new DiskFileItemFactory();
		   factory.setRepository(new File(request.getRealPath("/upfile/")+"/"));
		   ServletFileUpload upload = new ServletFileUpload(factory);
		   upload.setSizeMax(100*1024*1024);
		   List items = new ArrayList();
		    
		     items = upload.parseRequest(request);
		     id = ((FileItem) items.get(0)).getString();
		     id = Info.getUTFStr(id);
		     upass = ((FileItem) items.get(1)).getString();
		     upass = Info.getUTFStr(upass);
		     realname = ((FileItem) items.get(2)).getString();
		     realname = Info.getUTFStr(realname);
		     sex = ((FileItem) items.get(3)).getString();
		     sex = Info.getUTFStr(sex);
		     age = ((FileItem) items.get(4)).getString();
		     age = Info.getUTFStr(age);
		     birth = ((FileItem) items.get(5)).getString();
		     birth = Info.getUTFStr(birth);
		     xl = ((FileItem) items.get(6)).getString();
		     xl = Info.getUTFStr(xl);
		     idcard = ((FileItem) items.get(7)).getString();
		     idcard = Info.getUTFStr(idcard);
		     jg = ((FileItem) items.get(9)).getString();
		     jg = Info.getUTFStr(jg);
		     zzmm = ((FileItem) items.get(10)).getString();
		     zzmm = Info.getUTFStr(zzmm);
		     tel = ((FileItem) items.get(11)).getString();
		     tel = Info.getUTFStr(tel);
		     mz = ((FileItem) items.get(12)).getString();
		     mz = Info.getUTFStr(mz);
		    FileItem fileItem = (FileItem) items.get(8);
		    HashMap map = dao.select("select * from sysuser where id="+id).get(0);
		    if(fileItem.getName()!=null && fileItem.getSize()!=0)
		    {
		    //Info.delPic(request.getRealPath("/upfile")+"/",map.get("fileurl").toString());
		    
		     if(fileItem.getName()!=null && fileItem.getSize()!=0){
		      File fullFile = new File(fileItem.getName());
		      fileurl = Info.generalFileName(fullFile.getName());
		      File newFile = new File(request.getRealPath("/upfile/")+"/" + fileurl);
		      try {
		       fileItem.write(newFile);
		      } catch (Exception e) {
		       e.printStackTrace();
		      }
		     }else{
		    	 fileurl = map.get("img").toString();
		     }
		    }
		}
		//uname,upass,realname,sex,birth,age,xl,idcard,img,jg,zzmm,tel,dept,zw,role,delstatus,mz
		String sql = "";
		if(!fileurl.equals("")){
			sql = "update sysuser set upass='"+upass+"',img='"+fileurl+"',realname='"+realname+"',sex='"+sex+"'" +
			",birth='"+birth+"',age='"+age+"',xl='"+xl+"',idcard='"+idcard+"',jg='"+jg+"',zzmm='"+zzmm+"',tel='"+tel+"'" +
					",mz='"+mz+"' where id="+id;
		}else{
			sql = "update sysuser set upass='"+upass+"',realname='"+realname+"',sex='"+sex+"'" +
			",birth='"+birth+"',age='"+age+"',xl='"+xl+"',idcard='"+idcard+"',jg='"+jg+"',zzmm='"+zzmm+"',tel='"+tel+"'" +
					",mz='"+mz+"' where id="+id;
		}
		
		dao.commOper(sql);
		request.setAttribute("suc", "");
		go("/admin/myinfo.jsp?id="+id, request, response);
		} catch (Exception e1) {
			e1.printStackTrace();
			request.setAttribute("error", "");
		     request.getRequestDispatcher("/admin/myinfo.jsp").forward(request, response);
		    }
	}
	
	
	
	
	
	
	
	
	//修改信息
	if(ac.equals("upinfo")){
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String fjs = request.getParameter("fjs");
		String ts = request.getParameter("ts");
		String sebei = request.getParameter("sebei");
		String zxqk = request.getParameter("zxqk");
		String sfdt = request.getParameter("sfdt");
		String fl = request.getParameter("fl");
		String mj = request.getParameter("mj");
		String price = request.getParameter("price");
		String addr = request.getParameter("addr");
		String lxr = request.getParameter("lxr");
		String tel = request.getParameter("tel");
		String remark = request.getParameter("remark");
		String filename = request.getParameter("filename");

		String sql = "update  info set title='"+title+"',fjs='"+fjs+"',ts='"+ts+"',sebei='"+sebei+"',zxqk='"+zxqk+"',sfdt='"+sfdt+"',fl='"+fl+"',mj='"+mj+"',price='"+price+"',addr='"+addr+"',lxr='"+lxr+"',tel='"+tel+"',remark='"+remark+"',filename='"+filename+"' where id="+id;
		dao.commOper(sql);
		request.setAttribute("suc", "");
		if(type.equals("1")){
			go("/admin/upcz.jsp", request, response);
		}if(type.equals("2")){
			go("/admin/upqz.jsp", request, response);
		}if(type.equals("3")){
			go("/admin/upcs.jsp", request, response);
		}if(type.equals("4")){
			go("/admin/upqg.jsp", request, response);
		}
	}
	
	//用户添加信息
	if(ac.equals("addinfo1")){
		
		String oper = vip.get("uname").toString();
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String fjs = request.getParameter("fjs");
		String ts = request.getParameter("ts");
		String sebei = request.getParameter("sebei");
		String zxqk = request.getParameter("zxqk");
		String sfdt = request.getParameter("sfdt");
		String fl = request.getParameter("fl");
		String mj = request.getParameter("mj");
		String price = request.getParameter("price");
		String addr = request.getParameter("addr");
		String lxr = request.getParameter("lxr");
		String tel = request.getParameter("tel");
		String remark = request.getParameter("remark");
		String savetime = Info.getDateStr();
		String status = "0";
		String filename = request.getParameter("filename");
		String sql = "insert into info (title,type,fjs,ts,sebei,zxqk,sfdt,fl,mj,price,addr,lxr,tel,savetime,status,remark,filename,oper) values ('"+title+"','"+type+"','"+fjs+"','"+ts+"','"+sebei+"','"+zxqk+"','"+sfdt+"','"+fl+"','"+mj+"','"+price+"','"+addr+"','"+lxr+"','"+tel+"','"+savetime+"','"+status+"','"+remark+"','"+filename+"','"+oper+"')";
		dao.commOper(sql);
		request.setAttribute("suc", "");
		
			go("/xxadd.jsp", request, response);
		
	}
	
	//用户修改信息
	if(ac.equals("upinfo1")){
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String fjs = request.getParameter("fjs");
		String ts = request.getParameter("ts");
		String sebei = request.getParameter("sebei");
		String zxqk = request.getParameter("zxqk");
		String sfdt = request.getParameter("sfdt");
		String fl = request.getParameter("fl");
		String mj = request.getParameter("mj");
		String price = request.getParameter("price");
		String addr = request.getParameter("addr");
		String lxr = request.getParameter("lxr");
		String tel = request.getParameter("tel");
		String remark = request.getParameter("remark");
		String filename = request.getParameter("filename");

		String sql = "update  info set title='"+title+"',fjs='"+fjs+"',ts='"+ts+"',sebei='"+sebei+"',zxqk='"+zxqk+"',sfdt='"+sfdt+"',fl='"+fl+"',mj='"+mj+"',price='"+price+"',addr='"+addr+"',lxr='"+lxr+"',tel='"+tel+"',remark='"+remark+"',filename='"+filename+"' where id="+id;
		dao.commOper(sql);
		request.setAttribute("suc", "");
		go("/xxup.jsp", request, response);
		
	}
	//上班打卡
	if(ac.equals("sbdk")){
		String recordrq = Info.getDateStr().substring(0,10);
		String stime = Info.getDateStr();
		String uid = user.get("id").toString();
		dao.commOper("insert into kqrecord (recordrq,stime,empid) values ('"+recordrq+"','"+stime+"','"+uid+"')");
		request.setAttribute("suc", "");
		go("/admin/dk.jsp", request, response);
	}
	//下班打卡
	if(ac.equals("xbdk")){
		String etime = Info.getDateStr();
		String id = request.getParameter("id");
		ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select("select * from kqrecord where id='"+id+"' ");
		if(list.size()>0){
			HashMap m = list.get(0);
			dao.commOper("update kqrecord set etime='"+etime+"',workhour="+Info.daysBetween(etime,m.get("stime").toString())+" where id="+id+" ");
			request.setAttribute("suc", "");
			go("/admin/dk.jsp", request, response);
		}else{
			request.setAttribute("no", "");
			go("/admin/dk.jsp", request, response);
		}
	}

	if(ac.equals("qjinfoadd")){
		String empid = request.getParameter("empid");
		String qjnum = request.getParameter("qjnum");
		String qjdate = request.getParameter("qjdate");
		String etime = request.getParameter("etime");
		String reason = request.getParameter("reason");
		dao.commOper("insert into qjinfo (empid,qjnum,qjdate,etime,reason,status) values " +
				"('"+empid+"','"+qjnum+"','"+qjdate+"','"+etime+"','"+reason+"','待审核') ");
		request.setAttribute("suc", "");
		go("/admin/qjadd.jsp", request, response);
	}
	
	if(ac.equals("qjinfoedit")){
		String id = request.getParameter("id");
		String qjnum = request.getParameter("qjnum");
		String qjdate = request.getParameter("qjdate");
		String etime = request.getParameter("etime");
		String reason = request.getParameter("reason");
		dao.commOper("update  qjinfo set qjnum='"+qjnum+"',qjdate='"+qjdate+"',etime='"+etime+"',reason='"+reason+"' where id="+id);
		request.setAttribute("suc", "");
		go("/admin/qjedit.jsp?id="+id, request, response);
	}
	
	if(ac.equals("jcinfoadd")){
		String empid = request.getParameter("empid");
		String fsdate = request.getParameter("fsdate");
		String type = request.getParameter("type");
		String reason = request.getParameter("reason");
		dao.commOper("insert into jcinfo (empid,fsdate,type,reason) values " +
				"('"+empid+"','"+fsdate+"','"+type+"','"+reason+"') ");
		request.setAttribute("suc", "");
		go("/admin/jcadd.jsp", request, response);
	}
	if(ac.equals("jcinfoedit")){
		String id = request.getParameter("id");
		String empid = request.getParameter("empid");
		String fsdate = request.getParameter("fsdate");
		String type = request.getParameter("type");
		String reason = request.getParameter("reason");
		dao.commOper("update  jcinfo set empid='"+empid+"',fsdate='"+fsdate+"',type='"+type+"',reason='"+reason+"' where id="+id);
		request.setAttribute("suc", "");
		go("/admin/jcedit.jsp?id="+id, request, response);
	}
	
	if(ac.equals("jbinfoadd")){
		String empid = request.getParameter("empid");
		String jbdate = request.getParameter("jbdate");
		String jbhour = request.getParameter("jbhour");
		String reason = request.getParameter("reason");
		dao.commOper("insert into jbinfo (empid,jbdate,jbhour,reason) values " +
				"('"+empid+"','"+jbdate+"','"+jbhour+"','"+reason+"') ");
		request.setAttribute("suc", "");
		go("/admin/jbadd.jsp", request, response);
	}
	if(ac.equals("jbinfoedit")){
		String id = request.getParameter("id");
		String empid = request.getParameter("empid");
		String jbdate = request.getParameter("jbdate");
		String jbhour = request.getParameter("jbhour");
		String reason = request.getParameter("reason");
		dao.commOper("update  jbinfo set empid='"+empid+"',jbdate='"+jbdate+"',jbhour='"+jbhour+"',reason='"+reason+"' where id="+id);
		request.setAttribute("suc", "");
		go("/admin/jbedit.jsp?id="+id, request, response);
	}
	if(ac.equals("chatadd")){
		String empid = user.get("id").toString();
		String content = request.getParameter("content");
		String savetime = Info.getDateStr();
		dao.commOper("insert into  chat (empid,content,savetime) values " +
				"('"+empid+"','"+content+"','"+savetime+"') ");
		request.setAttribute("suc", "");
		go("/admin/chatadd.jsp", request, response);
	}
	
	dao.close();
	out.flush();
	out.close();
}


	public void init() throws ServletException {
		// Put your code here
	}
	
	

}
