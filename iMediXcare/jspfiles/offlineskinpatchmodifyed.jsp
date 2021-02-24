<%@page contentType="text/html" import="imedix.cook,imedix.myDate,java.util.*,java.io.*, javax.swing.ImageIcon" %>
<%@ include file="..//includes/chkcook.jsp" %>


<% 
//Surajit Kundu 25.08.2015
	
	String imgsrc, img, ij,Srv,test;
	String  parimg1,parimg2, Source;
	cook cookx = new cook();

	String ccode="", us="", pid="",edt="",fn="";

	ccode = cookx.getCookieValue("center", request.getCookies()); // get the center code from cookie
	us = cookx.getCookieValue("userid", request.getCookies());
	pid = cookx.getCookieValue("patid", request.getCookies());
	
	edt=myDate.getCurrentDate("dmy",false);

	fn = request.getParameter( "type" );
	String frmtyp = request.getParameter( "frmtyp" );
	if(frmtyp==null) frmtyp="SKP";
	if(frmtyp.equals("")) frmtyp="SKP";
	
	Srv = request.getScheme()+"://" + request.getServerName() + ":" + request.getServerPort();
	Srv =Srv+"/iMediX/";
	
	//Image srcImg;	
	imgsrc = request.getRealPath("/")+"/jspfiles/anatomyimages/"+fn+".jpg";
	//out.println("real path : "+imgsrc);


	ImageIcon imageIcon = new ImageIcon(imgsrc);
	int wd = imageIcon.getIconWidth();
	int ht = imageIcon.getIconHeight();
	
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
canvas#can{background-repeat:no-repeat; background-position: center; background-size: <%=ht%> <%=wd%>; }



</style>

<script type="text/javascript">


var	img_value=sessionStorage.getItem('imgs');

var canvas, ctx, points="", flag = false,
    prevX = 0,
    currX = 0,
    prevY = 0,
    currY = 0,
    dot_flag = false;

var x = "RED";
    y = 2;
    
function init() {
    canvas = document.getElementById('can');
    ctx = canvas.getContext("2d");
   	canvas.style.backgroundImage="url(anatomyimages/"+img_value+")";
   
    w = canvas.width;
    h = canvas.height;

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
}

function draw() {
    ctx.beginPath();
    ctx.moveTo(prevX, prevY);
    ctx.lineTo(currX, currY);
    ctx.strokeStyle = x;
    ctx.lineWidth = y;
    ctx.stroke();
    ctx.closePath();
}
function save() {
    sessionStorage.removeItem('imgs');	
    //tested Ok
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
        ctx.clearRect(0, 0, w, h);
        points="";
         document.getElementById("point").value=points; 
         if(points==null || points=="")  document.getElementById('colorid').disabled=false;
		 else  document.getElementById('colorid').disabled=true;
    }
}


function findxy(res, e) {
    if (res == 'down') {
        prevX = currX;
        prevY = currY;
if ('ontouchstart' in window) {
        
        currX = e.targetTouches[0].pageX - can.offsetLeft;
        currY = e.targetTouches[0].pageY - can.offsetTop;

} 
else{
        currX = e.clientX - canvas.offsetLeft;
        currY = e.clientY - canvas.offsetTop;
} 
 
        flag = true;
        dot_flag = true;
        if (dot_flag) {
            ctx.beginPath();
            ctx.fillStyle = x;
            ctx.fillRect(currX, currY, 2, 2);
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
            prevX = currX;
            prevY = currY;
if ('ontouchstart' in window) {
        
        currX = e.targetTouches[0].pageX - can.offsetLeft;
        currY = e.targetTouches[0].pageY - can.offsetTop;

} 
else{
        currX = e.clientX - canvas.offsetLeft;
        currY = e.clientY - canvas.offsetTop;
} 
             draw();
           points=points + parseInt(prevX.toString()) + "," + parseInt(prevY.toString())+ ","+parseInt(currX.toString()) + "," + parseInt(currY.toString())+ "-";    
        }
    } 
}

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
	else
	{
	return false;
	}
		}
		
	}

}


</script>

<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

<body onload="init()">

<div class="container-fluid">

<center><canvas class="img-responsive" ontouchstart="selectedcolor()" onmouseover="selectedcolor()" ontouchend="save()" onmouseout="save()" id="can" width=<%=wd%> height=<%=ht%> style="border:2px solid;cursor:crosshair" ></canvas></center>

<form onsubmit="return pointcheck()" action="savepatchfrm.jsp" method="POST">
<%
	String location = Srv+"servlet/savepatch";
	String par="&"+pid+"&"+fn +"&"+ edt+"&"+frmtyp+"&";
	
	out.println("<input  type=hidden name=dxn id=dxn value=\"" + par + "\">");
	out.println("<input  type=hidden name=loc id=loc value=\"" + location + "\">");
	

%>

<div class="row">

<div class="col-lg-3 col-sm-2"></div>

<div class="col-lg-6 col-sm-8">
<br/><div class="input-group">
<input class="form-control" type="color" name="color1" id="colorid"  data-toggle="tooltip" title="Choose Color" />
<span class="input-group-btn"><input class=" btn btn-warning" type="button" onclick="erase()" value="Clear" /></span>
</div>		<!-- "input-group" -->
	

<input  type="hidden" name="pont" id="point" value=""/>
<input hidden type="text" name="getcolor" id="sndcolor" value=""/>

<br/><div class="input-group">	
<textarea class="form-control"  maxlength="30" id="img_desc" placeholder="Image Description" name="img_desc"></textarea>

<span class="input-group-btn"><input class="btn btn-primary" type="submit" value="Save" /></span>
</div>
</div>		<!-- "col-lg-6 col-sm-8" -->

<div class="col-lg-3 col-sm-2"></div>

</div>		<!-- "row" -->

</form>

</div>		<!-- "container-fluid" -->

</body>
</html>

