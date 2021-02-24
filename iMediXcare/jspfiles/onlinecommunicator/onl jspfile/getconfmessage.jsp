<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String postedto="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		postedto=request.getParameter("postedto").trim();
		
		String output=onlComm.getMessage(postedto);
		if(output.equals("")) output="nomsg";
		out.println(output);
		//out.flush();
	}catch(Exception e) {
		out.println("nomsg");
	}
%>