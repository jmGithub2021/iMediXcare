<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String postedby = "",confid="",patid="";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {

		postedby=request.getParameter("postedby").trim();
		patid=request.getParameter("patid").trim();
		confid=request.getParameter("confid").trim();
		String output=onlComm.updateConfStatus(postedby,patid,confid);
		out.println(output);

	}catch(Exception e) {
		out.println("nomsg");
	}
%>