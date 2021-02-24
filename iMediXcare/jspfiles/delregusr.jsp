<%@page language="java"  import= "imedix.rcUserInfo, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%	
	String uid = request.getParameter("id");
	rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
	int ans = rcuinfo.deleteUser(uid);
	if(ans==1){
		response.sendRedirect("showusers.jsp");
	}else{
		out.println("Error");
	}

%>
