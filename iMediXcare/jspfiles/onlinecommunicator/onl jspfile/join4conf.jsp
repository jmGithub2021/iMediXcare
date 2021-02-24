<%@page contentType="text/html" import="imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
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
%>