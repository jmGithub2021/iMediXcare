<%@page language="java" import="imedix.cook,java.util.*" %>
<HTML>
<HEAD>
<link rel="stylesheet" href="../style/menu.css" type="text/css" media="screen" />

<TITLE> DATA ENTRY MENUS </TITLE>
</HEAD>

<BODY>
<%
	String id;
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + id + "</B></FONT><BR>");
%>

 <ul class="cul">
	<li class="cli"><a href=../forms/concent.jsp TARGET=right>Give Consent</a></li>
	<li class="cli"><a href=../forms/t01.jsp TARGET=right>General Exam.</a></li>
	<li class="cli"><a href=../forms/t02.jsp TARGET=right>Emergency</a></li>
	<li class="cli"><a href=../jspfiles/offlineskinpatch.jsp?image=/images/skinpatch.jpg TARGET=right>Mark SkinPatch</a></li>
	<!-- <ul>
	<li ><A HREF="../forms/history.jsp"><B>History</B></a></li>
	<li ><A HREF="../forms/physical.jsp"><B>Physical</B></a></li>
	<li ><A HREF="../forms/invest.jsp"><B>Investigation</B></a></li>
	<li ><A HREF="../forms/diagnosis.jsp"><B>Diagnosis</B></a></li> 
	</ul> -->
</ul> 
<br>

<ul class="cul">
<table border=0>
	<tr><td>
		<A HREF="../forms/history.jsp"><B>History</B></a>
	</td><td>
		<A HREF="../forms/physical.jsp"><B>Physical</B></a>
	</td></tr>
	<tr><td>
		<A HREF="../forms/invest.jsp"><B>Investigation</B></a>
	</td><td>
		<A HREF="../forms/diagnosis.jsp"><B>Diagnosis</B></a>
	</td></tr>
</table>
</ul>

<HR COLOR=RED WIDTH=100% Align=Left>

<BR>
<b>
<FONT COLOR="#CC3300" Size=2>Rules to Enter Data:<BR><BR>
<BR>Limit Unstructured Data to 300 Characters<BR>
<BR>Avoid using Special characters such as #$@%'"&!
</FONT>
<b>
<BR><BR>
<FONT  COLOR="RED"><B>Click on the above Links to Enter Patient Data</B></FONT>
</BODY>
</HTML>
