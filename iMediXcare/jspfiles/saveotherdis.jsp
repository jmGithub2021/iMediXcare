<%@page language="java"  import= "imedix.rcGenOperations,imedix.dataobj,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));

	String docid = request.getParameter("docid");
	String othdis = request.getParameter("othdis");
	othdis = othdis.replaceAll("\n","");
        othdis = othdis.replaceAll("\r","");
	dataobj obj = new dataobj();
	obj.add("tname","othdis");
	obj.add("rg_no",docid);
	obj.add("dis",othdis);
	
	int ans=rcGen.saveAnyInfo(obj);
	if(ans==1){
		response.sendRedirect("otherdis.jsp?uid="+docid);		
	 }else{
		out.println("Error");
	 }

%>