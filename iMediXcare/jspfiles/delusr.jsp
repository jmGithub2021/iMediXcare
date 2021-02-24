<%@page language="java"  import= "imedix.rcUserInfo,imedix.dataobj,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%	
	String rgno = request.getParameter("rgno");
	String list=request.getParameter("list");
	String uid = request.getParameter("suid");

	cook cookx = new cook();
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);

	rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
	int ans = rcuinfo.deleteUser(uid,obj);
	if(ans==1){
		if(list==null)
			response.sendRedirect("showusers.jsp");
		else 
			response.sendRedirect("showregque.jsp");
	}else{
		out.println("Error");
	}

%>
