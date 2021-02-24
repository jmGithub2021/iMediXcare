<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.cook,imedix.myDate, java.util.*,java.io.*,javax.swing.ImageIcon,java.awt.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<!-- @Surajit Kundu -->
<%
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));


	String ccode="",usr="",pid="",url;
	
	String dt="",ext="",isl="",itype="",endt="",dat;
	pid=request.getParameter("patid");
	isl=request.getParameter("isl");
	itype=request.getParameter("type");
	dat=request.getParameter("dt");
	endt=dat.substring(8,10)+"/"+dat.substring(5,7)+"/"+dat.substring(0,4);

	String fdt =endt.replaceAll("/","");

	usr = cookx.getCookieValue("userid", request.getCookies());
	ccode = cookx.getCookieValue("center", request.getCookies()); 
	
	String imgdirname=request.getRealPath("/")+"/temp/"+usr+"/images/"+pid+"/";
	String fname=pid+fdt+itype+isl+".jpg";
	//out.println(imgdirname+fname+" isl : "+endt+"\n");
	//out.println(request.getQueryString());

	String path=imgdirname+fname;
	//fname=fname.toLowerCase();
	String imgnam = imgdirname+fname;
	int iwd =111;
	int iht =111;

	try{
		ImageIcon imageIcon = new ImageIcon(imgnam);
		iwd = imageIcon.getIconWidth();
		iht = imageIcon.getIconHeight();
		if(iwd < 270) iht = iht+30*3;
		else if (iwd>=270 && iwd<390) iht = iht+30*2;
		else iht = iht+30;

		//out.println(imgnam);
		//out.println("iwd:" +iwd +" iht:"+iht);
	}catch(Exception e)
	{
		System.out.println("Error in getbinary data : "+e.toString());
	}

url = "http://" + request.getServerName() + ":" + request.getServerPort();
	url =url+"/iMediX/";

		
%>








<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
<title>Mark Patch</title></head>
<style>
body{background-image:url("../images/txture5.jpg")}
</style>
<link href="offlineskinpatch.css"></link>

<script type="text/javascript">

var canvas, ctx, points="", flag = false, dht, dwt, ht, wd;
    prvX = 0,
    canX = 0,
    prvY = 0,
    canY = 0,
    dot_flag = false;

var x = "Red",
    y = 2;
    
function init() {
    canvas = document.getElementById('can');
    ctx = canvas.getContext("2d");
  
  
	try{
	   canvas.style.backgroundImage='url(../temp/<%=usr%>/images/<%=pid%>/<%=pid+fdt+itype+isl%>.jpg)';
	   ht=document.getElementById("dicomimg").height;
		wd=document.getElementById("dicomimg").width;  
		document.getElementById("ht").value=ht;
		document.getElementById("wd").value=wd;
		canvas.height=ht;
		canvas.width=wd;
		canvas.addEventListener("mousemove", function (e) {
			findxy('move', e)
		}, false);
		canvas.addEventListener("mousedown", function (e) {
			findxy('down', e)
		}, false);
		canvas.addEventListener("mouseup", function (e) {
			findxy('up', e)
		}, false);
		canvas.addEventListener("mouseout", function (e) {
			findxy('out', e)
		}, false);
		canvas.addEventListener("touchstart",  function (e) {
			findxy('down', e)
		}, false);
		canvas.addEventListener("touchmove",  function (e) {
			findxy('move', e)
		}, true);
		canvas.addEventListener("touchend",  function (e) {
			findxy('up', e)
		}, false);
	}catch(err){console.log(err);}
    
}

function draw() {
    ctx.beginPath();
    ctx.moveTo(prvX, prvY);
    ctx.lineTo(canX, canY);
    ctx.strokeStyle = x;
    ctx.lineWidth = y;
    ctx.stroke();
    ctx.closePath();
}
function save() {
 
    document.getElementById("point").value=points; 
  if(points==null || points=="")  document.getElementById('colorid').disabled=false;
  else  document.getElementById('colorid').disabled=true;
}

function selectedcolor()
{
var	col=document.getElementById("colorid").value;
x=col;
document.getElementById("sndcolor").value=x;
 //alert(document.getElementById("colorid").value);
}

function erase() {
    var m = confirm("Want to clear");
    if (m) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        points="";
         document.getElementById("point").value=""; 
         if(points==null || points=="")  document.getElementById('colorid').disabled=false;
		 else  document.getElementById('colorid').disabled=true;
    }
}

function findxy(res, e) {
    if (res == 'down') {
        prvX = canX;
        prvY = canY;
if ('ontouchstart' in window) {
        
        canX = e.targetTouches[0].pageX - can.offsetLeft;
        canY = e.targetTouches[0].pageY - can.offsetTop;

} 
else{
        canX = e.clientX - canvas.offsetLeft;
        canY = e.clientY - canvas.offsetTop;
} 
 
        flag = true;
        dot_flag = true;
        if (dot_flag) {
            ctx.beginPath();
            ctx.fillStyle = x;
            ctx.fillRect(canX, canY, 2, 2);
            ctx.closePath();
            dot_flag = false;
            //testesd ok
           
        }
    }
    if (res == 'up' || res == "out") {
		
        flag = false;
    }
    if (res == 'move') {
        if (flag) {
            prvX = canX;
            prvY = canY;
if ('ontouchstart' in window) {
        
        canX = e.targetTouches[0].pageX - can.offsetLeft;
        canY = e.targetTouches[0].pageY - can.offsetTop;

} 
else{
        canX = e.clientX - canvas.offsetLeft;
        canY = e.clientY - canvas.offsetTop;
} 
             draw();
             points=points + parseInt(prvX.toString()) + "," + parseInt(prvY.toString())+ ","+parseInt(canX.toString()) + "," + parseInt(canY.toString())+ "#";  
        }
    } 
}
/*
function pointcheck()
{
	if(points=="" || points==null)
	{
	//alert("Blank image");
	return false;
	}
	else
	{	
		var imgdesc=document.getElementById("img_desc").value;
		if(imgdesc==""||imgdesc==null)
		{
			var imd=confirm("Image description is blank ");
			if(imd==true){
			 imgdesc=null;
			document.getElementById("img_desc").innerHTML="No description";
			return true;	
		}
		//else alert("TEST");
		else
	{
	return false;
	}
	}
	
	}

}*/
</script>

<body onload="init()">

<div class="container-fluid"> 

<center><canvas  class="img-responsive" ontouchstart="selectedcolor()" onmouseover="selectedcolor()" ontouchend="save()" onmouseout="save()" id="can" style="border:1px solid #000000;cursor:crosshair"; ></canvas>

<form  action="savepatchfrmdicom.jsp" method="POST">  
<%
/*
	url=getDocumentBase().toString();	//http://10.5.25.94:5050/iMediX/jspfiles/markdicomimg.jsp?patid=EXTR1906150000&type=DCM&isl=1&dt=2015-07-09%2020:22:50.0	
	String spturl[] =url.split("\\?"); //http://10.5.25.94:5050/iMediX/jspfiles/markdicomimg.jsp?patid=EXTR1906150000&type=DCM&isl=1&dt=2015-07-09%2020:22:50.0
	url=spturl[0]; //http://10.5.25.94:5050/iMediX/
	prms=spturl[1];//patid=EXTR1906150000&type=DCM&isl=1&dt=2015-07-09%2020:22:50.
 * */

String prms=request.getQueryString();
String par=prms+"&ccode="+ccode+"&uid="+usr;
String Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
	Srv =Srv+"/iMediX/";
	String location = Srv+"servlet/dicommarkservlet";
	//String par="&"+pid+"&"+fn +"&"+ edt+"&"+frmtyp+"&";
	
	out.println("<input  hidden type=text name=dxn id=dxn value=\"" + par + "\">");
	out.println("<input  hidden type=text name=loc id=loc value=\"" + location + "\">");
	//out.println("<input  hidden type=text name=isl id=isl value=\""+isl+ "\">");
	//out.println("<input  hidden type=text name=dt1 id=dt1 value=\""+dt1+ "\">");
%>

<div class="row">

<div class="col-lg-3 col-sm-2"></div>

<div class="col-lg-6 col-sm-8 well">
<br/><div class="input-group">
<input class="form-control" type="color" value="#ff00ff"  name="color1"  id="colorid" alt="Your Browser no supporting"  data-toggle="tooltip" title="Choose Color" />
<span class="input-group-btn"><input class="btn btn-warning" type="button" onclick="erase()" value="Clear" /></span>
</div>		<!-- "input-group" -->


<!--<textarea  maxlength="30" id="img_desc" placeholder="Image Description" name="img_desc"></textarea>-->
<input  type="hidden" name="pont" id="point" value=""/>
<input   type="hidden" name="ht" id="ht" value=""/>
<input   type="hidden" name="wd" id="wd" value=""/>
<td><input   type="hidden" name="getcolor" id="sndcolor" value=""/>

<br/><center><input class="btn btn-primary" type="submit" value="Save" /></center>
</div>		<!-- "col-lg-6 col-sm-8" -->

<div class="col-lg-3 col-sm-2"></div>

</div>		<!-- "row" -->

</form>

<img hidden  src="../temp/<%=usr%>/images/<%=pid%>/<%=pid+fdt+itype+isl%>.jpg" id="dicomimg" />

</center>

</div>		<!-- "container-fluid" -->
</body>

</html>
