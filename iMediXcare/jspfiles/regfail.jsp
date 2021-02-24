<%@page language="java"%>
<HTML>
<BODY bgcolor="#FFDECE">
<BR><BR><BR><BR><BR><BR>

<BR>
<!--<CENTER><FONT SIZE="+3" COLOR="#FF6699"><B>Please try for another ID</B><br>Probable Reason:-->
<CENTER><FONT SIZE="+3" COLOR="#FF6699"><B>Please try for another ID</B>
<%
String verifStatus =String.valueOf(session.getAttribute("verifStatus"));
//out.println (verifStatus);
%>
</FONT><BR><BR>
<!--<FONT SIZE="+1" ><A HREF="adduser.jsp"><U>Retry</U></A></FONT>-->
<FONT SIZE="+1" ><A HREF="showusers.jsp"><U>Retry</U></A></FONT>
</CENTER>
</BODY>
</HTML>
