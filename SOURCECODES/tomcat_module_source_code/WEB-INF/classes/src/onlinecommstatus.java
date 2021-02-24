
package onlinegc;

import imedix.dataobj;
import imedix.cook;
import imedix.rcUserInfo;
import java.io.*;
import java.util.Date;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;


  
public class onlinecommstatus extends HttpServlet 
{ 
 public void doGet ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 
  		doPost(request,response);
	
 	}
 	
 public void doPost ( HttpServletRequest request,HttpServletResponse response )
 	throws ServletException,IOException{
 	
 	
	PrintWriter  out;
	out = response.getWriter();
	
	String uid = "",pwd="",patid="";
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		uid=request.getParameter("uid");
		pwd=request.getParameter("pwd");
		patid = request.getParameter("patid");

		Object res=uinfo.getuserinfo(uid,pwd);

		if(res instanceof String){
			out.println("Rejected");
		}else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0){
				String output=onlComm.setUserDetalis(uid,pwd,patid);
				out.println(output);
			}else{
				out.println("Rejected");
			}
		}
	}catch(Exception e) {
		out.println("Rejected");
	}
	
	//out.flush();	
	out.close();
	
 }
 
 }
 
 	
 	