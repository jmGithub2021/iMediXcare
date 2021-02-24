<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj,imedix.myDate,org.json.simple.*,org.json.simple.parser.*,imedix.rcCentreInfo,imedix.cook,java.util.*,java.io.*,imedix.rcDataEntryFrm" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
String test_id = "",studyUID = "", patId = "";
if(request.getMethod().equalsIgnoreCase("POST") && request.getParameter("studyUID") !=null){
rcDataEntryFrm rcdf = new rcDataEntryFrm(request.getRealPath("/"));

	test_id = request.getParameter("upTestId");
	studyUID = request.getParameter("studyUID");

if(rcdf.modifyTestId(test_id,studyUID))
	out.println("Updated!");
else
	out.println("Not Updated!");
}

%>
