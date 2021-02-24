package imedixservlets;

import imedix.dataobj;
import imedix.projinfo;
import imedix.myDate;
import imedix.rcUserInfo;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;


public class saveregusers extends HttpServlet {	
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   res.setContentType("text/html");
		try{
		dataobj obj = new dataobj();	
				
		rcUserInfo rcuinfo = new rcUserInfo(req.getRealPath("/"));
		projinfo proj=new projinfo(req.getRealPath("/"));
		
		String UploadPath=req.getRealPath("//")+"/temp/";
		MultipartRequest multi = new MultipartRequest(req,UploadPath);	
		Enumeration files = multi.getFileNames();		//Returns the names of all the uploaded files as an Enumeration of Strings
		Enumeration param = multi.getParameterNames();	//Returns the names of all the parameters as an Enumeration of Strings.
		
		String userid="";
		userid=multi.getParameter("uid");
		String utype=multi.getParameter("type");
		
		obj.add("uid",multi.getParameter("uid"));
		obj.add("pwd",multi.getParameter("pwd"));
		obj.add("name",multi.getParameter("name"));
		obj.add("type",multi.getParameter("type"));
		obj.add("phone",multi.getParameter("phone"));
		obj.add("address",multi.getParameter("address"));
		obj.add("emailid",multi.getParameter("emailid"));
		obj.add("qualification",multi.getParameter("qualification"));
		obj.add("designation",multi.getParameter("designation"));
		obj.add("dis",multi.getParameter("dis"));
		obj.add("crtdate",myDate.getCurrentDate("dmy",false));
		obj.add("center",proj.gblcentercode);
		obj.add("active","P");
		
	
	//	System.out.println("rg_no: " + multi.getParameter("rg_no"));		
	//	while (files.hasMoreElements()) {
		int ans =0;
			if(utype.equalsIgnoreCase("doc")){
				obj.add("rg_no",multi.getParameter("rg_no"));
				
				String name = (String)files.nextElement();	//read the 1st value of files (Enumeration variable)		
				String filename = multi.getFilesystemName(name);			
				File f = multi.getFile(name);
				
				//System.out.println("name: " + name+"<BR>");			
				//System.out.println("filename: " + filename+"<BR>");			
				//System.out.println("type: " + ctype+"<BR>Ext : " + ext+"<BR>");	
			
									
				byte b[] = new byte[ (int) f.length()];
				InputStream is = new FileInputStream(f);
				is.read(b);
				is.close();
				System.out.println(f.length());
				ans = rcuinfo.InsertRegUsers(obj,b);
				boolean r=f.delete();
			
			}else{
				ans = rcuinfo.InsertRegUsers(obj,null);
			}	
			
			if(ans==1){
				res.sendRedirect("../jspfiles/regdone.jsp?id="+userid);
		 	}else{
				res.sendRedirect("../jspfiles/regfail.jsp");
			}	
   //  }
     	
 }catch (Exception e){ 
 	System.out.print("uploadfilehttp Exception :"+ e.toString());
 	res.sendRedirect("../jspfiles/regfail.jsp");
 }	

}

}
