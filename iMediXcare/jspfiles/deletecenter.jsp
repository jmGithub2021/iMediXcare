<%@page language="java"  import= "imedix.rcCentreInfo,imedix.cook,imedix.dataobj,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String ccode =request.getParameter("cntcode");

	cook cookx = new cook();
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());

	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);

	try{
		rcCentreInfo rcCinfo = new rcCentreInfo(request.getRealPath("/"));

	int ans = rcCinfo.deleteCentreInfo(ccode,obj);
	if(ans==1){
			response.sendRedirect("showcenter.jsp");
	 }else{
			//response.sendRedirect(".....jsp");
			out.println("Error");
	 }
	out.println("<br>"+ ans);
	}catch(Exception e){
		out.println( e.toString());
	}
%>