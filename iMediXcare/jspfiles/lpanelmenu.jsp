<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<!--	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->



<style type="text/css">

body{
	margin: 0;
	padding: 0;
}

.glossymenu{
margin: 0;
padding: 0;
//width: 170px; /*width of menu*/
border: 1px solid #9A9A9A;
border-bottom-width: 0;
}

.glossymenu a.menuitem{
background: black url(../images/glossyback.gif) repeat-x bottom left;
font: bold 13px "Tahoma", "Trebuchet MS", Verdana, Helvetica, sans-serif;
color: white;
display: block;
//position: relative; /*To help in the anchoring of the ".statusicon" icon image*/
width: auto;
//padding: 4px 0;
//padding-left: 10px;
text-decoration: none;
}

.glossymenu.menuitem:active{
	color: Yellow;
}

.glossymenu a.menuitem .statusicon{ /*CSS for icon image that gets dynamically added to headers*/
position: absolute;
top: 5px;
right: 5px;
border: none;
}

.glossymenu a.menuitem:hover{
	background-image: url(../images/glossyback2.gif);
}

.glossymenu div.submenu a{ /*DIV that contains each sub menu*/
	background: white;
}

.glossymenu div.submenu ul{ /*UL of each sub menu*/
	list-style-type: none;
	margin: 0;
	padding: 0;
	color: black;
}

.glossymenu div.submenu ul li a{
	font-size:+20;
	border-bottom: 1px  solid blue;
	color: black;
}

.glossymenu div.submenu ul li a{
	display: block;
	//font: normal 12px "Tahoma","Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
	color: black;
	text-decoration: none;
//	padding: 2px 0;
//	padding-left: 10px;
}


.glossymenu div.submenu .radio {
	display: block;
	//font: normal 12px "Tahoma","Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
	color: blue;
	text-decoration: none;
//	padding: 2px 0;
//	padding-left: 10px;
	background: #C7EBFA;
}

.glossymenu div.submenu ul li a:hover{
	background: #DFDCCB;
	color: red;
}

</style>






<script type="text/javascript" src="../includes/jquery.min.js"></script>
<script language="javascript" src="../includes/ajaxcall.js"></script>
<script type="text/javascript" src="../includes/display.js"></script>
<script type="text/javascript" src="../includes/ddaccordion.js">

/***********************************************
* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
* This notice must stay intact for legal use
***********************************************/

</script>


<script type="text/javascript">


ddaccordion.init({
	headerclass: "submenuheader", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: false, //persist state of opened contents within browser session?
	toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["suffix", "<img src='../images/plus.gif' class='statusicon' />", "<img src='../images/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "normal", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})
/*
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
*/


function clearPanel(linka1){
//var linka=document.getElementsByTagName("a")[1].getAttribute("value");
//alert(linka1);
var linkalp = linka1.match("lpanelmenu.jsp");
if(linkalp=="lpanelmenu.jsp")
//document.getElementById("lpanel").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
{
var loadUrl = "./" + linka1;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#sub_form").html(ajax_load).load(loadUrl);
		$("#sub_form").css("min-height","100%");
		$("#sub_form").css("max-height","100%");
		
}
else{
document.getElementById("sub_form").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
}
}
</script>



</head>
<Body>
<div class="container-fluid">
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
	//String str,str1;
	//str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	//str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ //username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";

%>

<div class="row">
<div class="col-sm-3">

<div class="glossymenu">
<ul class="nav nav-pills nav-stacked">
	<%
		layout LayoutMenu = new layout(request.getRealPath("/"));
		String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"left","1");
		String menu1=menu.replaceAll("<a","<li><a");
		String menu2=menu1.replaceAll("</a>","</a></li>");
		
		String part1 = menu2.replaceAll("target=\"content2\"","");
String part2=part1.replaceAll("href","value");
String part3=part2.replaceAll("'header2'","this.getAttribute('value')");
		out.println(part3);
	%>
</ul>
</div>
</div>		<!-- "col-sm-3" -->

<div class="col-sm-9">
<div id="sub_form"></div>
</div>		<!-- "col-sm-9" -->

</div>		<!-- "row" -->
</div>		<!-- "container" -->
</Body>
</HTML>
