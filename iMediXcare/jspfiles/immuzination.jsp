<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
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

<title>Immuzination</title>
<link rel="stylesheet" type="text/css" href="../style/style2.css">
</head>
<body>
<div class="container">
<%
	String id="",dat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	try{
		out.println("<center><h3>Immuzination</h4></center>");
		String output=rcDd.getImmuzinationData(id);
		String output1=output.replaceAll("<table","<table class='table table-bordered'");
		out.println("<div class='table-responsive'>");
		out.println(output1);
		out.println("</div>");
	}catch(Exception e){
		out.println(e);
	}
%>
</div>
</body>
</html>
