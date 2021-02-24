<%@page contentType="text/html" import="imedix.cook" %>
<%@ page errorPage="error.jsp" %> 
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<HEAD>
<STYLE>
 
 body {
	margin-top:8px;
	background-image:url("../images/top.jpg");
	}

a
	{ color: #330000;
	  text-decoration: none;
	  font-weight: bold;
	  font-size: 70%;
	  font-family: tahoma;
	}
a:hover
	{
		color: #FF0000;
		text-decoration: none;
		font-weight: bold;
		font-size: 70%;
		font-family: tahoma;
	}

.td1{
		background-image:url("../images/tablebg1.jpg");
	}

</STYLE>
<script type="text/javascript">
function writetoLyr(id, message) {
	if (document.getElementById(id).style.visibility=="visible") {
		document.getElementById(id).style.visibility="hidden";
	}
	else {
		document.getElementById(id).style.visibility="visible";
	}

	document.getElementById(id).innerHTML = message;
}
function HideLyr() {
	document.contentLYR.style.visibility="hidden";
}
function show(msg) {
	document.getElementById(msg).style.visibility="visible";
}

function delete_cookie ( cookie_name )
{
  var cookie_date = new Date ( );  // current date & time
  cookie_date.setTime ( cookie_date.getTime() - 1 );
  document.cookie = cookie_name += "=; expires=" + cookie_date.toGMTString();
}



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
	//alert(getCookie("node")); 
	//alert("hello");
}

function cookupdate1()
{	
	
	var preval;
	
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
	//alert(getCookie("node")); 
	//alert("hello");
}
function selremote1()
{

cookupdate1();
//alert(val);
//window.top.location.reload();
//document.location.reload();
//parent.top.location.reload();
//var tar;
//tar="telebrowse.jsp?"+val;
//alert(tar);
//window.location=tar;

}
function selremote2()
{

cookupdate2();

//document.location.reload();

}
function selremote3()
{
delete_cookie("node");

delete_cookie("currem");
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



</script>

</HEAD>
<BODY BGColor="#9FBCB8" >
<%	

	String ccode="",cname;
	String path = request.getRealPath("/");
	cook cookx = new cook();
	ccode = cookx.getCookieValue("center", request.getCookies ());
	cname = cookx.getCookieValue("centername", request.getCookies ());

	String username="",islocal="";
	username = cookx.getCookieValue("username", request.getCookies ());	
	islocal = cookx.getCookieValue("node", request.getCookies ());
	String str,str1;

	str = "<FONT COLOR=BLUE size='2' face='Verdana'><b>"+ username.toUpperCase() +"&nbsp;</b></FONT><FONT COLOR=BLUE> Logged on </FONT>";
	str = str +  "<FONT COLOR='BLUE'>"+ new java.util.Date().toLocaleString() + "</FONT>";
	str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT><br>";

%>
	<TABLE Border=0 align=center Cellpadding=0 Cellspacing=0>
	<TR>
		<TD colspan=23>
		<CENTER>
	<%
		out.println(str1);
		out.println(str);
	%>	</CENTER>
	</TD>
	</TR>

<TR  height="20px">
	<!-- <TD BGColor="#330000"><FONT SIZE="" COLOR="#330000">%%</FONT></TD> -->
	
	
	<TD BGColor="#330000"  class=td1><A HREF=oldpat.jsp target=bot >&nbsp;Data Entry </A></TD>
	<TD BGColor="#330000"  class=td1><Font size=+1 ><B>&nbsp;|&nbsp;</B></Font></TD>
	<TD BGColor="#330000"  class=td1><A HREF=browse.jsp target=bot onClick='selremote2()' >Local Patient List</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>

	<TD BGColor="#330000" class=td1><A HREF=telebrowse.jsp?rccode=<%=ccode%> target=bot onClick='selremote1()'>Tele Patient List</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF=searchpatient.jsp  target=bot>Search Patient</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>

	<TD BGColor="#330000" class=td1>
		<A href="#" onClick="window.open('showonlineconf.jsp','mywindow','width=940,height=400')">Online Communicator</a>
	
	</A></TD>

	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF=hl7parser.jsp  target=bot>HL7 Parser </A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF=editprofile.jsp  target=bot>Edit Profile</A></TD>
	<TD BGColor="#330000" class=td1><B><Font size=+1 >&nbsp;|&nbsp;</Font></B></TD>
	<TD BGColor="#330000" class=td1><A HREF="logout.jsp" target="_parent" onClick='selremote3()' >Logout&nbsp;&nbsp;</A></TD>
	<!-- <TD BGColor="#330000"><FONT SIZE="" COLOR="#330000">%%</FONT></TD>-->
	

</TR>
</TABLE>
<!-- <div id="contentLYR" style="position:absolute; visibility:show; z-index:1; width: 650px; left: 253px; top: 25px; background: #330000;  ">
 </div> -->
 </BODY>
 </HTML>
