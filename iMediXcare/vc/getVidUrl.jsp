<%@page contentType="text/html" import="imedix.dataobj,imedix.layout,java.io.*,imedix.cook,imedix.rcVideoConference, java.util.*,imedix.projinfo" %>
<%
	/** Same file will be there in two places (vc folder and jspfiles folder)***/
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	String vidServerUrl=(String)(pinfo.vidServerUrl);
	out.println (vidServerUrl);
%>