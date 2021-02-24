<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String postedby = "";
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		postedby=request.getParameter("postedby");
		String output=onlComm.disconnectUser(postedby);
		out.println(output);
	}catch(Exception e) {
		out.println("NO");
	}
%>