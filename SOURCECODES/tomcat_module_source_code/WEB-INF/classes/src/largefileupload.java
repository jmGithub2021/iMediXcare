package imedixservlets;

import javax.servlet.*;
import imedix.cook;
import imedix.myDate;
import imedix.dataobj;
import imedix.rcDataEntryFrm;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;


public class largefileupload extends HttpServlet {
	String pid="", ftype="", desc="", lname="", doc_name="", cdate="", currdate="", ext="",ext1="",stream="";
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setHeader("Cache-Control","no-cache");
		res.setHeader("Pragma","no-cache");
		
		
		
	cook cookx = new cook();
		try{
			dataobj obj = new dataobj();	
			rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));
		/*	String para,s;
			
				StringBuffer stringbuffer = new StringBuffer();
				BufferedReader bufferedreader = req.getReader();

				while((s = bufferedreader.readLine()) != null) 
				{
					if(stringbuffer.length() > 0) stringbuffer.append('\n');
	            	stringbuffer.append(s);
				}
	        
				bufferedreader.close();
				para = stringbuffer.toString();
				
				stream = req.getParameter("stream");*/
				
		try{		
		Enumeration paramNames = req.getParameterNames();
		while(paramNames.hasMoreElements()) {
			String paramName = (String)paramNames.nextElement();
			System.out.println("PARAM NAME : "+paramName);
			stream = req.getParameter(paramName);
							
	   }
		}
		catch(Exception ex){System.out.println(ex.toString());};	
				
				System.out.println("VALUE : "+stream);
				String as[] = stream.split("&");
				pid=as[0];
				ftype=as[1];
				desc=as[2];
				lname=as[3];
				doc_name=as[4];
				currdate=as[5];
				cdate=as[6];
				ext=as[7];
				ext = "."+ext;
				//ext1=as[8];
				
	
			String UPLOAD_DIRECTORY = req.getRealPath("/data/"+pid+"/");	
			String oFileName=pid+cdate+"new"+ext;
			String nFileName=pid+cdate+ftype+"new"+ext;			
			File oldFile=new File(UPLOAD_DIRECTORY+"/"+oFileName);
			File newFile=new File(UPLOAD_DIRECTORY+"/"+nFileName);
			oldFile.renameTo(newFile);	
	
				
				obj.add("pat_id",pid);
				obj.add("type",ftype);
				if(ftype.equalsIgnoreCase("DOC") || ftype.equalsIgnoreCase("SND") || ftype.equalsIgnoreCase("TEG")){
					obj.add("docdesc",desc);
				}else if(ftype.equalsIgnoreCase("MOV")){
					obj.add("movdesc",desc);
				}else{
					obj.add("imgdesc",desc);
				}				
				
				obj.add("lab_name",lname);	
				obj.add("doc_name",doc_name);
				obj.add("testdate",cdate);
				obj.add("entrydate",cdate);
				
							
				obj.add("con_type","LRGFILE");

	
				String ext1=ext.substring(1);
				obj.add("ext",ext1);
				
				PrintWriter printwriter = res.getWriter();
				printwriter.println(obj);
				int ans=rcdef.UploadHttp(obj,null);
				System.out.println(pid+" : "+ftype+" : "+desc+" : "+lname+" : "+doc_name+" : "+cdate);
				if(ans>=0){
					String mFilePath = req.getRealPath("/data/"+pid+"/");
					String mFileName=pid+cdate+ftype+"new"+ext;
					String mFileName1=pid+cdate+ ftype +Integer.toString(ans)+ext;
					
					System.out.println(mFileName);
					System.out.println(mFileName1);
					File fn1 = new File (mFilePath+"/"+mFileName);
					File fn2 = new File (mFilePath+"/"+mFileName1);
					
					System.out.println("="+Integer.toString(ans)+"=");
					fn1.renameTo(fn2);	
				}  				
			}


	 ////////////// ===================== ////////////////////////	
	 
			
			
	  
	  	
	  	
 	catch (Exception e){ 
 		System.out.print("largefilepload Exception :"+ e.toString());
 	}	
}

}
