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
<br><div class="container">
<%
	String stdt="",endt="",ccode="",patid="";
	String bkptype = request.getParameter("bkptype");

	if(bkptype.equals("bydate"))               //' bydate form is submitted
	{
		stdt = request.getParameter("styy")+"/"+request.getParameter("stmm")+"/"+request.getParameter("stdd");
		endt = request.getParameter("upyy")+"/"+request.getParameter("upmm")+"/"+request.getParameter("updd");
		ccode = request.getParameter("ccode");
	}
	else
	{
		patid = request.getParameter("patid");
		ccode = request.getParameter("ccode");
	}
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	String output=rcajob.backupRcords(bkptype,patid,ccode,stdt,endt);
	out.println(output);
	//String output1=output.replaceAll("HREF='backupinterface.jsp'","class='form-control btn btn-warning' HREF='backupinterface.jsp' ");
	//out.println(output1);

%>
</div>
</body>
</html>

