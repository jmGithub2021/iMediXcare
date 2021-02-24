<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<html>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/media_q.css">
	<link rel="stylesheet" href="../bootstrap/jquery.jqplot.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/jquery.jqplot.min.js"></script>

<style>
.dropdown-menu-lpanel{
	position: absolute;
    top: 100%;
    left: 0;
    z-index: 1000;
    display: none;
    float: left;
    min-width: 160px;
    padding: 5px 0;
    font-size: 14px;
    text-align: left;
    list-style: none;
    background-color: #fff;
    -webkit-background-clip: padding-box;
    background-clip: padding-box;
    border: 1px solid #ccc;
    border: 1px solid rgba(0, 0, 0, .15);
    border-radius: 4px;
    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
    box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
}    
.dropdown-menu-lpanel > li > a {
    display: block;
    padding: 3px 20px;
    clear: both;
    font-weight: normal;
    line-height: 1.42857143;
    color: #333;
    white-space: nowrap;
    text-decoration: none;    
}
.dropdown-menu-lpanel > li > a:hover{background:#444;color:#fff;}
li:hover > .dropdown-menu-lpanel{
	display:block;
}
</style>

<script language="javascript">

/*function clearPanel()
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
</script>


<SCRIPT LANGUAGE="JavaScript">
<!--
var digits=new Array();
for (var i=0;i<10;i++){
  digits[i]=new Image();
  digits[i].src="../clockimg/"+i+".png";
}
iper=new Image(); icol=new Image();
iper.src="../clockimg/period.png";
icol.src="../clockimg/colon.png";
// -->

function clearPanel(linka1){
//var linka=document.getElementsByTagName("a")[1].getAttribute("value");

var linkalp = linka1.match("lpanelmenu.jsp");
var linkahm=linka1.match("welcome.jsp");
if(linkalp=="lpanelmenu.jsp"){
	document.getElementById("sub_form").innerHTML= null;
document.getElementById("home_frame").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
  
//document.getElementById("home_frame").innerHTML= null;

}
else if(linkahm=="welcome.jsp"){
	document.getElementById("home_frame").innerHTML= "<object class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
	document.getElementById("sub_form").innerHTML= null;
	}
else
{
document.getElementById("sub_form").innerHTML= "<object  class='responsive obj' type='text/html' data="+linka1+" style='width:100%; height:100%;'> </object>";
//document.getElementById("lpanel").innerHTML= null;
document.getElementById("home_frame").innerHTML=null;
}
}
</SCRIPT>

<STYLE>

</STYLE>
<HEAD>

<Body onload="clearPanel('totalsummary.jsp?templateid=1&menuid=null')">
<% 	
	cook cookx = new cook();
	
	String patid = cookx.getCookieValue("patid", request.getCookies());
	String patname=cookx.getCookieValue("patname", request.getCookies());
	String patagem=cookx.getCookieValue("patagem", request.getCookies());
	String PatAgeYMD = cookx.getCookieValue("PatAgeYMD", request.getCookies());

	String currCCode = cookx.getCookieValue("currpatqcenter", request.getCookies());
	String currCType = cookx.getCookieValue("currpatqtype", request.getCookies());

	String userid = cookx.getCookieValue("userid", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
	String distype= cookx.getCookieValue("distype", request.getCookies());
	String tmpid = request.getParameter("templateid");
	String menuid = request.getParameter("menuid");
	layout LayoutMenu = new layout(request.getRealPath("/"));
	String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"top","1");
	String[] parts = menu.split("</a>");
String part="";
int par_len=parts.length;
for(int i=0;i<parts.length;i++){
part+="<li>"+parts[i]+"</a></li>"; 
}
String part1 = part.replaceAll("target=\"content2\"","data-target=\"#navbarCollapse\" data-toggle=\"collapse\"");
String part2=part1.replaceAll("href","style='color:	#99CCFF' value");
String part3=part2.replaceAll("'header2'","this.getAttribute('value')");


		
		/*Left menu */
			layout l_LayoutMenu = new layout(request.getRealPath("/"));
			String lmenu=l_LayoutMenu.getMainMenu(usertype,"3","lpanel6","left","1");
			String lmenu1=lmenu.replaceAll("<a","<li><a");
			String lmenu2=lmenu1.replaceAll("</a>","</a></li>");

			String lpart1 = lmenu2.replaceAll("target=\"content2\"","");
			String lpart2=lpart1.replaceAll("href","value");
			String lpart3=lpart2.replaceAll("'header2'","");
			String lpart4=lpart3.replaceAll("onclick","");
			//out.println("<ul class='dropdown-menu aa'>"+lpart3+"</ul>");
		/* Left Menu */
%>

<script>
	$(document).ready(function(){
		$(".lpanel6").parent("li").append('<ul class="dropdown-menu-lpanel"><%=lpart4%></ul>');
		$(".menuitem").click(function(){
			//alert($(this).attr("value"));
			clearPanel("'"+$(this).attr('value')+"'");
			});
	});
</script>


<div class="container-fluid col-sm-12">
    <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle"  >
                <span class="sr-only">sk</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
          <!--  <a value="welcome.jsp?templateid=1&menuid=null" class="navbar-brand" onclick="clearPanel(this.getAttribute('value'))"data-toggle="tooltip" title="<%=PatAgeYMD%>">-->
            <a value="totalsummary.jsp?templateid=1&menuid=null" class="navbar-brand" onclick="clearPanel(this.getAttribute('value'))"data-toggle="tooltip" title="<%=PatAgeYMD%>" />
            <%=patname%>
            </a>
        </div>
        <!-- Collection of nav links, forms, and other content for toggling -->
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav pull-right">
                 
                 <%= part3%>
                <% if(currCType.equals("local"))
			//out.println("<li><A HREF='../jspfiles/browse.jsp?curCCode="+currCCode+"'  >Back To Pat Q </A></li>");
			out.println("<li><A HREF='../jspfiles/index1.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+patid+"'  >Back </A></li>");
	//else	out.println("<li><A HREF='../jspfiles/telebrowse.jsp?rccode="+currCCode+"'  >Back To Pat Q </A></li>");
	else	out.println("<li><A HREF='../jspfiles/index1.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+patid+"'  >Back</A></li>");
	%>
            </ul>
        </div>
    </nav>  


<br><br><br><div class="row"  >

<div class="col-sm-12" id="sub_form" ></div>

</div>

<div class="row" >
<div class="col-sm-12" id="home_frame"></div>
</div>		<!-- "row #home_frame" -->


</div> <!-- "container-fluid" -->



<SCRIPT LANGUAGE="JavaScript">
<!--
/*
function rc(){
  var n=new Date();
  var h=n.getHours();
  var m=n.getMinutes();
  var s=n.getSeconds();
  var f=""+((h<10)?"0"+h:h)+((m<10)?"0"+m:m)+((s<10)?"0"+s:s);
  for (var i=f.length-1;i>=0;i--) {
    if (f.substring(i,i+1)!=l.substring(i,i+1)) {
      eval("document.jd_"+i+".src=digits[f.substring(i,i+1)].src");
    }
  }
  l=f;
  setTimeout("rc()",1010-n.getMilliseconds());
}
var l="xxxxxxxx";
rc();
* */
// -->
</SCRIPT>

</Body>



</html>
