<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<HEAD>
<STYLE>
TABLE { Border: 1;
		font: Tahoma;
		color: RED;
}
A:HOVER {
		color:RED;
		background-color: YELLOW;
}
</STYLE>
</HEAD>

<BODY onLoad="document.getElementById('siteLoader').style.display = 'none';">
<div id='siteLoader'>
	 <H3><CENTER><BR>
	 	 <FONT COLOR="#00CCCC">......Please Wait......</FONT><BR><BR>
		 <IMG SRC="../images/loading.gif" WIDTH="100" HEIGHT="20" BORDER="0" ALT="" bordercolor=RED><BR>
	 </CENTER>
	 </H3>
</div>

<center>
<TABLE BORDER=1>
<TR><TD>Large File Upload Tool</TD></TR>
<TR><TD>

<%	
	cook cookx=new cook();
	projinfo pinfo = new projinfo(request.getRealPath("/"));
	String user  = cookx.getCookieValue("userid", request.getCookies ());
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String pid = cookx.getCookieValue("patid", request.getCookies());
out.println("PATH : "+pinfo);
out.println("PATH : "+user);
out.println("PATH : "+ccode);
%>

<!-- <APPLET CODE="mainform" codebase="./" archive="lrgfilesplitter.jar"  MAYSCRIPT WIDTH=540 HEIGHT=240>
   	<param name='patid' value="<%=pid%>">
	<param name='usr' value="<%=user%>">
	 <param name="urifn" value="largefileupload">
 </APPLET>
-->
</TD>
</TR>
<TR><TD><!-- If you are Running this Applet for first-time, Save this <a href="../reqsoft/.java.policy" style="text-decoration:none">file</A> in your HOME driectory<br> -->You may need latest jre. Install it from <a href="../reqsoft/jre16.exe" style="text-decoration:none">this location</a>.
</TD></TR>

</TABLE>
</center>
</BODY>
</HTML>
