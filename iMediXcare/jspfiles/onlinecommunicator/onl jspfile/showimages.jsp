<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String postedby = "",confid="",patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		patid=request.getParameter("patid").trim();		
		String output=onlComm.getImgListForApplet(patid);
		out.println(output);
	}catch(Exception e) {
		out.println("nomsg");
	}
%>
