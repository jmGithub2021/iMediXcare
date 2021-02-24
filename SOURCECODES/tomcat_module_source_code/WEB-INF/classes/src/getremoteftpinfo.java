
package imedixservlets;

import imedix.dataobj;
import imedix.rcGenOperations;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.io.*;



public class getremoteftpinfo extends HttpServlet
{
	
	public void init(ServletConfig config) throws ServletException {
    
    super.init(config);
	
	}
  
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
  
       	doPost(req,res);
       	
  }
  
  
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
  
  		System.out.println("getremoteftpinfo Call doPost");
  		String data="";
  		BufferedReader br = req.getReader();
  		PrintWriter prn = res.getWriter();
  			
  		try {
  		   	String line=br.readLine(); 
         	
         	line=line.trim();
         	dataobj obj = new dataobj();	
        	rcGenOperations rcgen = new rcGenOperations(req.getRealPath("/"));	
         	Object rs = rcgen.findRecords("center","ftpip,ftp_uname,ftp_pwd","code='"+line+"'");
            
            if(rs instanceof String){
            	data="Error";	
            }else{
            	Vector tmp = (Vector)rs;
            	obj=(dataobj) tmp.get(0);
            	data=obj.getValue("ftpip");
            	data=data+"#"+obj.getValue("ftp_uname");
            	data=data+"#"+obj.getValue("ftp_pwd");
            }
                        
         	         	
	   }catch (Exception e) {
		System.out.println("Exception : " + e);
		data="Error";	
	   }
	   
	   prn.println(data);
	   br.close();
	   prn.close(); 
	         	
  }

}
 