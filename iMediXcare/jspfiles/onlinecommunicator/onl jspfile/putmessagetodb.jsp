<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String postedby = "",postedto="",message="",status="",patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		postedby=request.getParameter("postedby").trim();
		postedto = postedby;
		message=request.getParameter("msg").trim();
		status = "N";
		patid=request.getParameter("patid").trim();
		String output=onlComm.putMessage(postedby,postedto,message,status,patid);
		out.println(output);
		//out.flush();
	}catch(Exception e) {
		out.println("NO");
	}
	
%>