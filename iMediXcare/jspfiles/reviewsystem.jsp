<%@page language="java" import="imedix.rcGenOperations,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	rcGenOperations rcGenOp = new rcGenOperations(request.getRealPath("/"));
	cook cookx = new cook();
	String pid = cookx.getCookieValue("patid", request.getCookies());
	String dat = myDate.getCurrentDateMySql();
%>

<html >
<head >
<link rel="stylesheet" type="text/css" href="../style/style2.css">
</head>
<body>

<%
	try{
		String output=rcGenOp.reviewSystem(pid);
		out.println(output);
	}catch(Exception e){
		out.println(e);
	}
%>
</body>
</html>