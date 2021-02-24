<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<html>
<HEAD>
<link rel="stylesheet" type="text/css" href="../style/tabmenu.css" />
	<LINK REL="SHORTCUT ICON" HREF="../images/icon1.ico"> 
<STYLE>

body { 
	margin-top:0px;	
	background-image:url('../images/bg11.jpg');
	
	
}

</STYLE>

</HEAD>
<Body>

<script language="javascript">

function clearPanel()
{
    if (this.name == "header2")
    {
        this.parent.leftpanel.document.body.innerHTML = "";
        //this.parent.rightpanel.document.body.innerHTML = "";
        this.parent.content2.document.body.innerHTML = "";
    }
    else if (this.name == "leftpanel")
    {
        //this.parent.rightpanel.document.body.innerHTML = "";
        this.parent.content2.document.body.innerHTML = "";
    }
    else if (this.name == "content2")
    {}
    else if (this.name == "rightpanel")
    {
        this.parent.content2.document.body.innerHTML = "";
    }
    else
    {}
}

</script>

<table border =0 width=100%  cellpadding='1' cellspacing='0'>
	<tr>
		<td width=90px align=left> 
			<table cellspacing=0 border=0 cellpadding=0 >
				<tr><td><img src="../images/logo2.jpg" height=58 width=96><td></tr>
			</table>
		</td>
		<td align=center>

<% 	
	cook cookx = new cook();
	String userid = cookx.getCookieValue("userid", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
	String distype= cookx.getCookieValue("distype", request.getCookies());
	String tmpid = request.getParameter("templateid");
	String menuid = request.getParameter("menuid");

	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	//out.println(usertype+"<br>"+tmpid+"<br>"+menuid);
	String str,str1;

	str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";
%>

		<%
			out.println(str1);
			out.println(str);
			out.println("<a href='headermenu_sk.jsp?templateid=1&menuid=head1' Style='color:red' target='_blank'>Mobile support developing</a>");
		%>	<BR>


	<%
		layout LayoutMenu = new layout(request.getRealPath("/"));
		String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"top","1"); // authorization point
		// adm,1,head1,top,1
		out.println(menu);
	%>
 
	</td>
</tr>
</table>

</Body>
</HTML>
