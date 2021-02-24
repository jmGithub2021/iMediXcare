<%@page contentType="text/html" import= "imedix.rcUserInfo"%>
<%
	String emailid="";
	emailid = request.getParameter("emailid");
	rcUserInfo ru = new rcUserInfo(request.getRealPath("/"));
	out.println(ru.existEmail(emailid));
%>