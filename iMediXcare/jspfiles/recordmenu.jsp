<%@page language="java" import="imedix.rcItemlistInfo,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",dat="";

	rcItemlistInfo rcIlist = new rcItemlistInfo(request.getRealPath("/"));

	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	String tempstr=rcIlist.getVisitWiseInfo(id);
	
	String tempstr1=tempstr.replaceAll("Target=content2","onclick=clearPanel(encodeURI(this.getAttribute('value')))");
	tempstr1=tempstr1.replaceAll("target=content2","onclick=clearPanel(encodeURI(this.getAttribute('value')))");
	String tempstr2 = tempstr1.replaceAll("HREF","href='#' value");
	tempstr2 = tempstr2.replaceAll("Href","href='#' value");
%>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<script>
/*function clearPanel(linka1){
//var linka=document.getElementsByTagName("a")[1].getAttribute("value");
//alert(linka1);
var linkalp = linka1.match("lpanelmenu.jsp");
if(linkalp=="lpanelmenu.jsp")
//document.getElementById("lpanel").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
{
var loadUrl = "./" + linka1;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#nav_rpanel").html(ajax_load).load(loadUrl);
		$("#nav_rpanel").css("min-height","100%");
		$("#nav_rpanel").css("max-height","100%");
		
}
else{
document.getElementById("nav_rpanel").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
}
}*/
</script>

</head>


<body>
<div class="container-fluid">
    <div id="nav_rpanel"><%= tempstr2 %></div>
  </div>
</body>

</html>
