
package onlinegc;

import imedix.dataobj;
import imedix.cook;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;


  
public class getconfuserlist extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	
	PrintWriter  out;
	out = response.getWriter();
	
	String postedby = "",patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		patid=request.getParameter("patid").trim();
		String output=onlComm.getConfUser(patid);
		out.println(output);
	}catch(Exception e) {
		out.println("none");
	}
	
	//out.flush();
	out.close();
	
		
 	}
 }
 	