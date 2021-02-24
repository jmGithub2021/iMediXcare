<%@page contentType="text/html" import= "imedix.rcUserInfo"%>
<%
	String rgno="";
	rgno = request.getParameter("rgno");
	rcUserInfo ru = new rcUserInfo(request.getRealPath("/"));
	out.println(ru.existRgno(rgno));
%>