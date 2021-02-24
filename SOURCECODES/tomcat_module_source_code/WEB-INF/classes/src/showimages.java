package onlinegc;

import imedix.dataobj;
import imedix.cook;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;


  
public class showimages extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	
	PrintWriter  out;
	out = response.getWriter();
	
	String patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	
	try {
		patid=request.getParameter("patid").trim();		
		String output=onlComm.getImgListForApplet(patid);
		out.println(output);
	}catch(Exception e) {
		out.println("@@sep@@");
	}
	
		//out.flush();
		out.close();
 	}
 }
 	