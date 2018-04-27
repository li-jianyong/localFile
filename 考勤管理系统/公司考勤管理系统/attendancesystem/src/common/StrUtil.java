// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   MD5.java

package common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class StrUtil {
	private static int idSequence=10000;
	
	public static String checkStr(Object obj) {
		if(obj==null){
			return "";
		}else{
			return obj.toString();
		}		
	}
	
	public synchronized static String generalSrid() {
		StringBuffer ret = new StringBuffer(20);		
		ret.append(StrUtil.getFormatDate("yyyyMMddHHmmss"));		
		idSequence++;
		if(idSequence>20000)
		  idSequence-=10000; 
		ret.append(String.valueOf(idSequence).substring(1));
		return ret.toString().substring(2);//
	}
	public static String generalFileName(String srcFileName) {
		try{
		   int index=srcFileName.lastIndexOf(".");
		   return StrUtil.generalSrid()+srcFileName.substring(index).toLowerCase();
		}catch(Exception e){
			return StrUtil.generalSrid();
		}
	}
	public static String parseOS(String agent) {
		
		String system="Other";
		if(agent.indexOf("Windows NT 5.2")!=-1) 
			system="Win2003";
		else if(agent.indexOf("Windows NT 5.1")!=-1) 
			system="WinXP";
		else if(agent.indexOf("Windows NT 5.0")!=-1) 
			system="Win2000";
		else if(agent.indexOf("Windows NT")!=-1) 
			system="WinNT";
		else if(agent.indexOf("Windows 9")!=-1) 
			system="Win9x";
		else if(agent.indexOf("unix")!=-1) 
			system="unix";
		else if(agent.indexOf("SunOS")!=-1) 
			system="SunOS";
		else if(agent.indexOf("BSD")!=-1) 
			system="BSD";
		else if(agent.indexOf("linux")!=-1) 
			system="linux";
		else if(agent.indexOf("Mac")!=-1) 
			system="Mac";
		else
			system = "Other";		
	    return system;
	}
	
	/**
	 * �???��???????��???????��?????�?�?�?
	 * 
	 * @param formatString
	 * �?�?yyyy(�?)-MM(???)-dd(???)-HH(???)-mm(???)-ss(�?)-SSS(�?�?)
	
	 * @return ??��?????�????�??????��??�?�?�?
	 */
	public static String getFormatDate(String formatString) {
		Date now =new Date(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat(formatString);
		String ret=sdf.format(now);
		return ret;
	}	
	/**
	 * @param ???
	 * @return �??????��??
	 */
	public static Date getCurrentDate() {
		Date now =new Date(System.currentTimeMillis());
		return now;
	}
	/**
	 * �???��??????????��??�?�?串转???为�?��?????
	 * 
	 * @param formatString
	 * �?�?yyyy(�?)-MM(???)-dd(???)-HH(???)-mm(???)-ss(�?)-SSS(�?�?)
	
	 * @return �?�?串转??��???????��?????
	 */
	public static Date formatDate(String dateString) {
		try {
			SimpleDateFormat sdf=new SimpleDateFormat();	
			Date date=sdf.parse(dateString);
			return date;
		} catch (ParseException e) {			
			return new Date();
		}		
	}
	
	public static int parseInt(String numberStr) {
		//Pattern pattern=Pattern.compile("[0-9]*");
		//Pattern pattern=Pattern.compile("^[\\-\\d][0-9]*[\\.]{0,1}[0-9]+$");
		if(numberStr==null)
			return 0;
		Pattern pattern=Pattern.compile("^[\\-]{0,1}[0-9]+$");
		Matcher matcher = pattern.matcher(numberStr);
		if(matcher.find()){
			return Integer.parseInt(numberStr);
		}else{
			return 0;
		}			
	}
	public static String nowdate(){
		 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
	      return df.format(new Date());// new Date()为获取当前系统时间
	}
   public static void main(String[] args) {
	  System.out.println(nowdate());

}
}
