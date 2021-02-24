<%@page contentType="text/html" import= "imedix.rcUserInfo"%>
<%
	String phone="";
	phone = request.getParameter("phone");
	rcUserInfo ru = new rcUserInfo(request.getRealPath("/"));
	out.println(ru.existPhone(phone));

%>
