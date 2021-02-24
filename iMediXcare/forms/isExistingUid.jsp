<%@page contentType="text/html" import= "imedix.rcUserInfo"%>
<%
	String uid="";
	uid = request.getParameter("uid");
	rcUserInfo ru = new rcUserInfo(request.getRealPath("/"));
	out.println(ru.existUid(uid));
%>