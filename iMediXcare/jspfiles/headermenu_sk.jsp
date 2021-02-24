<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<html>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/toastr.css">	
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/toastr.js"></script>	
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/jquery.dataTables.min.js"></script>
	<script src="../bootstrap/dataTables.bootstrap.min.js"></script>

<!--<link rel="stylesheet" type="text/css" href="../style/tabmenu.css" />-->
	<LINK REL="SHORTCUT ICON" HREF="../images/icon1.ico"> 
<STYLE>
	table{
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: 0px 1px 2px 3px #ddd;
}
body { 
	margin-top:0px;	
	//background-image:url('../images/bg11.jpg');
}
nav.navbar.navbar-inverse.navbar-fixed-top{
	color:green;
	background-color:#d8d9f0;;
	border-color:#F0F0F0;
	font-weight:bold;
	}
button.navbar-toggle{background-color:#D0D0D0; border-color:#D0D0D0;}
li a:hover { 
    background-color:#c0caef !important;
    color: #31708f !important;
        border-radius: 4px;
}
li a{color:#2b405f !important;}
//.navbar-fixed-bottom .navbar-collapse, .navbar-fixed-top .navbar-collapse{max-height:400px !important;}

</STYLE>

</HEAD>

<script>
function home(fileName){
	var loadUrl = "./" + fileName;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(loadUrl);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
//document.getElementById("main_frame").innerHTML= "<object class='responsive obj' type='text/html' data='welcome.jsp' style='width:100%; height:100%;'>> </object>";
}

</script>



<Body onload="home('welcome.jsp?templateid=1&menuid=null')">


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
		layout LayoutMenu = new layout(request.getRealPath("/"));
		String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"top","1"); // authorization point
		// adm,1,head1,top,1
		//out.println(menu);
String[] parts = menu.split("</a>");
String part="";
int par_len=parts.length;
for(int i=0;i<parts.length;i++){
part+="<li>"+parts[i]+"</a></li>"; 
}
String part1 = part.replaceAll("target=\"content1\"","data-target=\"#navbarCollapse\" data-toggle=\"collapse\"");
String part2=part1.replaceAll("href","style='color:	#99CCFF' href='#' value");
String part3=part2.replaceAll("'header1'","this.getAttribute('value')");
//out.println("<script>console.log("+menu+")</script>");
//String part4=part3.insertAll("data-target=\"#navbarCollapse\" data-toggle=\"collapse\"");
%>

<script language="javascript">

$.ajaxSetup ({
		cache: false
	});	
	function clearPanel(fileName) {
		
		var patque=fileName.match("browse.jsp");
		var oldpat=fileName.match("oldpat.jsp");
		if(patque=="browse.jsp" || oldpat=="oldpat.jsp" || patque=="totalsummary.jsp"){
			var loadUrl = "./" + fileName;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(loadUrl);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
			}
		else{
		document.getElementById("main_frame").innerHTML= "<object class='responsive obj' type='text/html' data="+fileName+" style='width:100%; height:100%;'>> </object>";
		}
	}
</script>


<div class="container-fluid">
    <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle"  >
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#" value="welcome.jsp?templateid=1&menuid=null" class="navbar-brand" onclick="clearPanel(this.getAttribute('value'))">
            <img class="img-responsive" src="../images/imlogo.jpg"width=50/>
            </a>
        </div>
        <!-- Collection of nav links, forms, and other content for toggling -->
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav pull-right">
                 
                 <%= part3%>
                
            </ul>
        </div>
    </nav>  


<div class="row"><br><br>
<div class="col-lg-12" id="main_frame" ></div>
</div>

</div> <!-- "container" -->

</body>
</html>
