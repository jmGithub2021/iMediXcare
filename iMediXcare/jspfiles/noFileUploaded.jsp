<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj, imedix.rcUserInfo,imedix.cook,java.util.*, imedix.myDate" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	projinfo pinfo = new projinfo(request.getRealPath("/"));
	//int fileLimit = Integer.parseInt(pinfo.gblPageRow);
	cook cookx=new cook();
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
	String userid = cookx.getCookieValue("userid", request.getCookies());
	rcUserInfo rc = new rcUserInfo(request.getRealPath("/"));
	int fileno = Integer.parseInt(rc.fileUploadLimit(7,userid));
	//out.println("N"+Integer.parseInt(rc.fileUploadLimit(7,userid))+usertype);
	if(usertype.equalsIgnoreCase("PAT"))
		out.print(fileno);
	else
		out.print("0");
%>
