package onlinegc;

import imedix.dataobj;
import imedix.cook;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;


  
public class getconfmessage extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	response.setContentType("text/plain"); 
 	
 	//PrintWriter  out = new PrintWriter(response.getOutputStream());
 	
 	PrintWriter  out = new PrintWriter(response.getWriter());
 	 	
//	out = response.getWriter();

	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		String postedto=request.getParameter("postedto").trim();
		String output=onlComm.getMessage(postedto);
		if(output.equals("")) output="nomsg";
		//out.println(output);
		out.write(output);
		System.out.println("Servlet getMessage :"+output);	
		
	}catch(Exception e) {
		//out.println("nomsg");
		out.write("nomsg");
	}
	
	//out.flush();
	out.close();
	
		
 	}
 }
 	