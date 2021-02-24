

package onlinegc;

import imedix.dataobj;
import imedix.cook;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;


public class deleteonlineuser extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	
	PrintWriter  out;
	out = response.getWriter();
	
	String postedby = "";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		postedby=request.getParameter("postedby");
		String output=onlComm.disconnectUser(postedby);
		out.println(output);
	}catch(Exception e) {
		out.println("NO");
	}
	
	//out.flush();
	out.close();
	
		
 	}
 }
 	