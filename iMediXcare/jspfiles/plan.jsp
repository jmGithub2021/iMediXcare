<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<html>
<head>
<title>PLAN</title>
<link rel="stylesheet" type="text/css" href="../style/style2.css">
</head>
<body>
<%
	String id="",dat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	try{
		out.println("<center><FONT SIZE='5pt' COLOR='#3300CC'><B>PLAN</B></FONT></center>");
		String output=rcDd.getPlanRecord(id);
		out.println(output);
	}catch(Exception e){
		out.println(e);
	}
%>

</body>
</html>