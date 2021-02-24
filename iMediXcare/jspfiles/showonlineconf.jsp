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
<TR><TD>Online Communication Tool</TD></TR>
<TR><TD>

<%	
	cook cookx=new cook();
	projinfo pinfo = new projinfo(request.getRealPath("/"));
	String user  = cookx.getCookieValue("userid", request.getCookies ());
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String jsid = cookx.getCookieValue("JSESSIONID", request.getCookies ());
	

//out.println("<img src='displayimg.jsp?id="+patid+"&ser="+isl+"&type="+itype+"&dt="+dat+"'>");
//<param name='imagesd' value=''>
//<param name='imagesv' value=''>
//

%>
 <APPLET CODE="onlineconf3" codebase="./onlinecommunicator/" archive="onlineconf3.jar"  MAYSCRIPT WIDTH=900 HEIGHT=300>
   	<param name='patid' value='NoPat'>
	<param name='usrid' value="<%=user%>">
	<param name='centerid' value="<%=ccode%>">
	<param name='pid' value="<%=sid%>">
	<param name='telemedhomefld' value="<%=pinfo.gbltelemedix%>">

	<param name='msghome' value="servlet">
	<param name='imgurl' value="jspfiles/displayimg.jsp">
	<param name='aimghome' value="jspfiles/anatomyimages">
	<param name='aimgs' value="bre.jpg#lar.jpg#lun.jpg#ora.jpg#skp.jpg#thy.jpg#tsv.jpg#uto.jpg">
	<param name='urlext' value="servlet">
 </APPLET>

</TD>
</TR>
<TR><TD>If you are Running this Applet for first-time, Save this <a href="onlinecommunicator/.java.policy" style="text-decoration:none">file</A> in your HOME driectory<br>You may also need latest jre. Install it from <a href="onlinecommunicator/jre16.exe" style="text-decoration:none">this location</a>.
</TD></TR>
</TABLE>
</center>
</BODY>
</HTML>
