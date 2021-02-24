<%@page language="java" import="imedix.cook,java.util.*" %>
<HTML>
<HEAD>
<link rel="stylesheet" href="../style/menu.css" type="text/css"/>
<TITLE> DATA ENTRY MENUS </TITLE>
</HEAD>
<BODY >

<TABLE border=0 class='tableba' width =222>
<TR><TD>
<%
	String id;
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	out.print("&nbsp;<FONT SIZE = 2 COLOR='#FF0000'><B>Patient ID&nbsp;:&nbsp;" + id + "</B></FONT><BR>");
%>
</TD></TR>
<TR>
	<TD>
 <ul>
	<li ><a href=../forms/concent.jsp TARGET=right>Give Consent</a></li>
	<li ><a href=../forms/t01.jsp TARGET=right>General Exam.</a></li>
	<li ><a href=../forms/t02.jsp TARGET=right>Emergency</a></li>
	<li ><a href=../jspfiles/anatomylist.jsp TARGET=right>Mark SkinPatch</a></li>
	<li ><a href='../forms/imageload.jsp' Target=right>Upload File</a></li>

	<!-- <ul>
		<li ><A HREF="../forms/history.jsp"><B>History</B></a></li>
		<li ><A HREF="../forms/physical.jsp"><B>Physical</B></a></li>
		<li ><A HREF="../forms/invest.jsp"><B>Investigation</B></a></li>
		<li ><A HREF="../forms/diagnosis.jsp"><B>Diagnosis</B></a></li> 
	</ul>  -->
</ul> 
</TD></TR><TR><TD>
<div>
<table class="table1" border=0>
	<tr><td class="td1">
		<A HREF="../forms/history.jsp" TARGET="menubot"><B>History</B></a>
	</td><td class="td1">
		<A HREF="../forms/physical.jsp" TARGET=menubot><B>Physical</B></a>
	</td></tr>
	<tr><td class="td1">
		<A HREF="../forms/invest.jsp" TARGET=menubot><B>Investigation</B></a>
	</td><td class="td1">
		<A HREF="../forms/diagnosis.jsp" TARGET=menubot><B>Diagnosis</B></a>
	</td></tr>
</table>
</div>
</TD></TR>
<!-- <TR><TD>
<HR COLOR=RED WIDTH=100% Align=Left>
</TD></TR>
 -->
 </TABLE>
</BODY>
</HTML>
