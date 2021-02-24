<%@page language="java"  import= "imedix.rcUserInfo,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<body><BR><BR><BR><BR><BR><BR>

<%
	cook cookx = new cook();
	rcUserInfo rcui = new rcUserInfo(request.getRealPath("/"));
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String uid=request.getParameter("rg_no");
	String hosnam=request.getParameter("rhoscod");
	boolean flag=rcui.sendDoctor(uid,hosnam);

	if(flag){
        out.println("<Font size=5 color=green><center>Doctor information has been send successfully</center></font>");
          
	} else{

         out.println("<Font size=5 color=green><center>Error.....<Br> System is not connected Try Again</center></font>");
     }
%>

</body>
</html> 
