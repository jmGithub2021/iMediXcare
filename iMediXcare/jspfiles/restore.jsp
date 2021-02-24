<%@page contentType="text/html" import="imedix.rcAdminJobs,imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<%
	String stdt="",endt="",ccode="",patid="";
	String bkpdir = request.getParameter("dirnam");
	try{
		rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
		String output= rcajob.restoreRcords(bkpdir);
		String pids[]=output.split("#");
		out.println("<br> <b>Restore the data of following patients</b><br>" );
		for(int i=0;i<pids.length;i++){
			out.println("<br>"+pids[i]);
		}
	}catch(Exception e){
		out.println("Err: "+e);
		e.printStackTrace();
		System.out.print(e);
	}
%>
</body>
</html>

