<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	String patid = cookx.getCookieValue("patid", request.getCookies());
	String dat = myDate.getCurrentDate("dmy",false);
	String patdis = cookx.getCookieValue("patdis", request.getCookies());
	String formname = request.getParameter("formname");
	String tempstr ="";

	if(formname.equalsIgnoreCase("a24")) tempstr = rcDd.getSocioEcoStatusRecord(patid);
	else if(formname.equalsIgnoreCase("a25")) tempstr = rcDd.getSupportSystemRecord(patid);
	else if(formname.equalsIgnoreCase("a26")) tempstr = rcDd.getARTRecord(patid);
	else if(formname.equalsIgnoreCase("a27")) tempstr = rcDd.getHIVExposedRecord(patid);
	else if(formname.equalsIgnoreCase("a28")) tempstr = rcDd.getAdherenceRecord(patid);
	else if(formname.equalsIgnoreCase("a29")) tempstr = rcDd.getSocialHistoryRecord(patid);

%>
<html>
	<head>
    <title>Counsel</title>
	</head>
<body>
    <form id="counsel">
    <div><%=tempstr %></div>
    </form>
</body>
</html>

