<%@page contentType="text/html" import="imedix.cook" %>
<%@ page errorPage="error.jsp" %> 
<%@ include file="../includes/chkcook.jsp" %>
<HTML>
<HEAD>

<%df
String ccode="",cname;
String path = request.getRealPath("/");
cook cookx = new cook();
ccode = cookx.getCookieValue("center", request.getCookies ());
cname = cookx.getCookieValue("centername", request.getCookies ());
String osname=System.getProperty("os.name");
%>

<STYLE>
<%
if(osname.startsWith("L") || osname.startsWith("l")){
  out.println("body { margin-top:0px;	background-image:url('../images/top.jpg');}");
}else{
	out.println("body { margin-top:1px;	background-image:url('../images/top.jpg');}");
}

%>

a
	{ color: #330000;
	  text-decoration: none;
	  font-weight: bold;
	  font-size: 11;
	  font-family: tahoma;
	}
a:hover
	{
		color: #FF0000;
		text-decoration: none;
		font-weight: bold;
		font-size: 11;
		font-family: tahoma;
	}

	.td1{
		font-size: 11;
		background-image:url(../images/tablebg1.jpg);
	}
	

</STYLE>

</HEAD>

<script type="text/javascript">
function cookupdate2()
{
	var preval;
	var ch=(navigator.appName.indexOf("Microsoft") != -1);
	if(ch==true)
	{
		preval=getCookie("node");
		if(preval != null)
		{
		document.cookie="node=";
		}
	}
	else
	{
		preval=getCookie("node");
		if(preval.length != 0)
		{
		document.cookie="node=";
		}
	}
}


function cookupdate1()
{
	var preval,cncode;
	var ch=(navigator.appName.indexOf("Microsoft") != -1);
	if(ch==true)
	{
		preval=getCookie("node");
		if(preval == null)
		{
			document.cookie="node=remote";
		}

	}
	else
	{
		preval=getCookie("node");
		if(preval.length == 0)
		{
			document.cookie="node=remote";
		}
	}
}

function selremote1()
{

cookupdate1();
//document.location.reload();
}

function selremote2()
{
cookupdate2();
//document.location.reload();
}



function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }

function selremote3()
{
cookupdate2();
}

</script>

<BODY BGColor="#9FBCB8" > 
<%
//#E7E9FE
	String username="",islocal="";
	username = cookx.getCookieValue("username", request.getCookies ());	
	islocal = cookx.getCookieValue("node", request.getCookies ());
	String str,str1;
	str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";
	//str = str +  "<FONT COLOR='#330099'>"+ new java.util.Date().toLocaleString() + ")</FONT></b>";

%>
	<TABLE Border=0 align=right Cellpadding=0 Cellspacing=0>
	<TR>
		<TD colspan=23 >
		<CENTER>
	<%
		out.println(str1);
		out.println(str);
	%>	</CENTER>
	</TD>
	</TR>

	<TR  height="15px">
			<TD BGColor="#330000" class=td1><A HREF=showcenter.jsp  target=bot>&nbsp;Centers</A></TD>
		<TD BGColor="#330000" class=td1 ><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
		<TD BGColor="#330000" class=td1 ><A HREF=select.jsp target=bot>Patient Registration</A></TD>
		<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
		<TD BGColor="#330000" class=td1><A HREF=oldpat.jsp target=bot>Data Entry</A></TD>
		<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
		<TD BGColor="#330000" class=td1><A HREF=browse.jsp target=bot onClick='selremote2()'>Local Patient</A></TD>
		<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	

	
	<TD BGColor="#330000" class=td1><A HREF=telebrowse.jsp?rccode=<%=ccode%>  target=bot onClick='selremote1()'>&nbsp;Tele Patient</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF=searchpatient.jsp  target=bot>Search Patient</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	
	
	<TD BGColor="#330000" class=td1><A HREF=jobadmin.jsp  target=bot>Admin. Job</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	
	<TD BGColor="#330000" class=td1><A HREF=editprofile.jsp  target=bot>Edit Profile</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF=hl7parser.jsp  target=bot>HL7 Parser </A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	
	<TD BGColor="#330000" class=td1><A HREF=showusers.jsp target=bot>Show User</A></TD>
	
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF="logout.jsp" target="_parent" onClick='selremote3()'>Logout&nbsp;</A></TD>
	<TD >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>

</TR>
</TABLE>
	<!-- <hr color=blue width=100% /> -->

 </BODY>
 </HTML>
