<%@page contentType="text/html" import="imedix.rcAdminJobs,imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<html>
<body>
<%
	String stdt="",endt="",ccode="",patid="";
	String patids = request.getParameter("patids");
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	String output=rcajob.deleteBackupRcords(patids);
	out.println("<BR><BR><CENTER><FONT SIZE='+2' COLOR='blue'>Sucessfully Done</FONT></CENTER>");
%>
</body>
</html>
