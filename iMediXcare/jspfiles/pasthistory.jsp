<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	String pid = cookx.getCookieValue("patid", request.getCookies());
	String dat = myDate.getCurrentDate("dmy",false);
	String patdis = cookx.getCookieValue("patdis", request.getCookies());
	String tempstr = rcDd.getPastHistoryRecord(pid);
	
	String tempstr1=tempstr.replaceAll("<table","<table class='table table-bordered'");
%>
<html>
	<head>
	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
	
    <title>Past History</title>
	</head>
<body>
<div class="container-fluid">
    <form id="past_history" runat="server">
    <div><%=tempstr1 %></div>
    </form>
    
    </div>		<!-- "container-fluid" -->
</body>
</html>

