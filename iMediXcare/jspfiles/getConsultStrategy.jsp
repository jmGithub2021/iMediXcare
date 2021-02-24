<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcDataEntryFrm,imedix.rcAdminJobs,imedix.rcCentreInfo,imedix.dataobj,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
cook cookx = new cook();
String ccode= cookx.getCookieValue("center", request.getCookies ());
rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
String code=request.getParameter("code");
String strat=rcdef.findConsultStrategy(code);
int strategy=0;

if(strat.equalsIgnoreCase("admin"))
{
    strategy=1;
}
else if(strat.equalsIgnoreCase("random"))
{
    strategy=0;
}
out.println("<p>"+strategy+"</p>");
%>
