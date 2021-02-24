<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcGenOperations,imedix.rcPatqueueInfo, imedix.rcUserInfo,imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<% 	
	cook cookx = new cook();
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	
	String patid="", hospid="", docid="";
	
	patid = request.getParameter("patid");
	hospid = request.getParameter("hospid");
	docid = request.getParameter("docid");
	
	
	dataobj obj = new dataobj();
	obj.add("patid",patid);
	obj.add("hospid",hospid);
	obj.add("docid",docid);
	
	out.println (obj.toString());
%>
