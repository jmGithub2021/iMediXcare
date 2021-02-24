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


public class uploadlog extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
	
	res.setContentType("text/plain");
	
	try{
     String dirName = req.getRealPath("//")+"/temp/";
     System.out.println(">>dirName >>>"+dirName);
      
      File fn=new File(dirName);
      if(!fn.exists()){
      	fn.mkdirs();
      }
     
     Enumeration enames = req.getHeaderNames();
	   while (enames.hasMoreElements()) {
	      String name = (String) enames.nextElement();
	      String value = req.getHeader(name);
	      System.out.println(name + " = " + value);
	   }
   
      MultipartRequest multi = new MultipartRequest(req, dirName, 50*1024*1024); // 50MB
            
      System.out.println("Params:"); 
     
	  Enumeration params = multi.getParameterNames();
      while (params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String value = multi.getParameter(name);
			System.out.println(name + " = " + value);
      }
            
      Enumeration files = multi.getFileNames();
      
      while (files.hasMoreElements()) {
       
		String name = (String)files.nextElement();
        String filename = multi.getFilesystemName(name);
        String type = multi.getContentType(name);
        
        File f = multi.getFile(name);
        
        System.out.println("name: " + name);
        System.out.println("filename: " + filename);
        System.out.println("type: " + type);
        
        if (f != null) {
          System.out.println("f.toString(): " + f.toString());
          System.out.println("f.getName(): " + f.getName());
          System.out.println("f.exists(): " + f.exists());
          System.out.println("f.length(): " + f.length());
        }
        
      }	  	
 	}catch (Exception e){ 
 		System.out.print("uploadlog Exception :"+ e.toString());
 	}	
  }

}