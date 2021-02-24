

package onlinegc;

import imedix.dataobj;
import imedix.cook;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;


  
public class join4conf extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	
	PrintWriter  out;
	out = response.getWriter();
	
	String postedby = "",postedtos="",message="",status="",patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {

		postedby=request.getParameter("postedby").trim();
		patid=request.getParameter("patid").trim();
		postedtos=request.getParameter("postedtos").trim();

		String output=onlComm.joinForConf(postedby,patid,postedtos);
		out.println(output);

	}catch(Exception e) {
		out.println("nomsg");
	}
	//out.flush();
	out.close();
	
		
 	}
 }
 	