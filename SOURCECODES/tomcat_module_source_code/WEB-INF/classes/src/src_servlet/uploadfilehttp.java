package imedixservlets;

import imedix.dataobj;
import imedix.rcDataEntryFrm;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;


public class uploadfilehttp extends HttpServlet {	
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   res.setContentType("text/html");
		try{
		dataobj obj = new dataobj();	
		String usr="";
		Cookie[] cook = req.getCookies();
		
			for(int i = 0; i < cook.length; i++) 
			{	
				if( cook[i].getName().equals("userid") )
				{
				  usr=cook[i].getValue();
				 
				}
			}

		rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));	
		String UploadPath=req.getRealPath("//")+"/temp/"+usr+"/";

		MultipartRequest multi = new MultipartRequest(req,UploadPath,52428800);	//6291456
						
		Enumeration files = multi.getFileNames();		//Returns the names of all the uploaded files as an Enumeration of Strings
		Enumeration param = multi.getParameterNames();	//Returns the names of all the parameters as an Enumeration of Strings.
		String nam="";

		String id,ccode,newfile="",ftype,tabnam="",qr,sl="",namf="";
		String desfile="",sqlQuery="";
		int nu=0;
		//id = multi.getParameter("id").toLowerCase().trim();
		obj.add("pat_id",multi.getParameter("pat_id"));
		//ccode = id.substring(0,3).toLowerCase();
		//ftype = multi.getParameter("type");

		obj.add("type",multi.getParameter("type"));
		obj.add("imgdesc",multi.getParameter("imgdesc"));
		obj.add("lab_name",multi.getParameter("lab_name"));
		obj.add("doc_name",multi.getParameter("doc_name"));
		obj.add("testdate",multi.getParameter("testdate"));
		obj.add("entrydate",multi.getParameter("entrydate"));
				
		while (files.hasMoreElements()) {
			String name = (String)files.nextElement();	//read the 1st value of files (Enumeration variable)		
			String filename = multi.getFilesystemName(name);			
			String ctype = multi.getContentType(name);			
			String ext = filename.substring(filename.indexOf(".")+1);

			ext=ext.toLowerCase();
			obj.add("con_type",ctype);
			obj.add("ext",ext);

			File f = multi.getFile(name);
			
			//System.out.println("name: " + name+"<BR>");			
			//System.out.println("filename: " + filename+"<BR>");			
			//System.out.println("type: " + ctype+"<BR>Ext : " + ext+"<BR>");	
			
			
			if(f.exists())
			{
				obj.add("size",Integer.toString((int)f.length()));		
				InputStream is = new FileInputStream(f);
				byte b[] = new byte[ (int) f.length()];
				is.read(b);
				is.close();
				
				System.out.println(f.length());
				int ans=rcdef.UploadHttp(obj,b);
				boolean r=f.delete();
				
			}
						
     }
 		
 }catch (Exception e){ 
 	System.out.print("uploadfilehttp Exception :"+ e.toString());
 }	

		res.sendRedirect(".."+"/jspfiles/showlist.jsp");
}

}
