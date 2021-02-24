<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<html>
<HEAD>

<script language="javascript">

function clearPanel()
{
    if (this.name == "header2")
    {
        this.parent.leftpanel.document.body.innerHTML = "";
        this.parent.rightpanel.document.body.innerHTML = "";
        this.parent.content2.document.body.innerHTML = "";
    }
    else if (this.name == "leftpanel")
    {
        this.parent.rightpanel.document.body.innerHTML = "";
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

<STYLE>

body { 
	margin-top:8px;	
	/*background-image:url(../images/tablebg1.jpg);*/
	background:#DBF7CA;
	}
a
	{ 
	  color: #3300CC;
	  text-decoration: none;
	  font-weight: bold;
	  font-size: 10pt;
	  font-family: tahoma;
	  background-image:url(../images/gradient_36.gif);
	  display: block;
	  text-align: left;
	  padding-top: 5px;
	  padding-bottom: 5px;
	  padding-left: 10px;
	  font-weight:bold;
	 text-decoration:none;
	 border-width:1px 0px;
	/* border-width:1px 1px 1px 1px;*/
	 border-style:solid;
	 border-color:#66cc00;

	}
a:hover
	{
		color: #FF0000;
		text-decoration: none;
		font-weight: bold;
		font-size: 10pt;
		font-family: tahoma;
		background:url(../images/center_tile_green.gif);
	}

a.active{
	color: #FF0000;
	background:url(../images/center_tile_blue.gif);
}

a:focus {
	color: #FF0000;
	background:url(../images/center_tile_blue.gif);
}

.td1{
	font-size: 10pt;
	background-image:url(../images/gradient_36.gif;
}
	
	

</STYLE>
<HEAD>
<Body>
<% 	
	//cook cookx = new cook();
	//String userid = cookx.getCookieValue("userid", request.getCookies());
	//String username = cookx.getCookieValue("username", request.getCookies());
	//String usertype = cookx.getCookieValue("usertype", request.getCookies());
	//String distype= cookx.getCookieValue("distype", request.getCookies());
	//String tmpid = request.getParameter("templateid");
	//String menuid = request.getParameter("menuid");

	//String ccode = cookx.getCookieValue("center", request.getCookies ());
	//String cname = cookx.getCookieValue("centername", request.getCookies ());
//	out.println(usertype+"<br>"+tmpid+"<br>"+menuid);
	//String str,str1;
	//str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	//str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ //username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";
%>

	<%
		//layout LayoutMenu = new layout(request.getRealPath("/"));
		//String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid);
		//out.println(menu);
	%>

  <div id='nav_rpanel'></div>

</Body>
</HTML>