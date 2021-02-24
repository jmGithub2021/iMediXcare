<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*, java.io.OutputStream,imedix.cook,imedix.myDate,java.util.*,java.io.*,java.awt.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String iSql = "",ID="",mime="",ty="",dt="",dt1="",mtype="",rc="",isl="",msl="";
	//rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	//OutputStream os = response.getOutputStream();

	//try {
		
		ID=request.getParameter("id");
		isl=request.getParameter("ser");
		ty=request.getParameter("type");
		dt1=request.getParameter("dt");

		//dt=dt1.substring(6)+"/"+dt1.substring(3,5)+"/"+dt1.substring(0,2);

	/*	byte[] fileArray = null;
		mime=ddinfo.GetImageCon_type(ID,dt1,ty,isl);
		fileArray =ddinfo.GetImage(ID,dt1,ty,isl);
		response.setContentType(mime);

		os.write(fileArray,0,fileArray.length);
		os.flush();
		os.close();

	}catch(Exception e) {
		os.write(e.toString().getBytes());
	}*/
//	out.println("<img src='displayimg.jsp?id="+ID+"&ser="+isl+"&type="+ty+"&dt="+dt1+"'>");
	
	
%>


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
	
	Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
	Srv =Srv+"/iMediX/";
	
	Image srcImg;	
imgsrc = Srv+"/jspfiles/displayimg.jsp?id="+ID+"&ser="+isl+"&type="+ty+"&dt="+dt1;

	//imgsrc = request.getRealPath("/")+"/jspfiles/anatomyimages/"+fn+".jpg";
	//out.println("real path : "+imgsrc);
	srcImg = Toolkit.getDefaultToolkit().getImage(imgsrc);

 	Frame frame = new Frame();
	MediaTracker mt = new MediaTracker(frame);
	mt.addImage(srcImg,0);
	try 
	{
		mt.waitForAll();
	}
	catch(InterruptedException e) 
	{
		out.println(e);
	}
	int wd = srcImg.getWidth(frame);
	int ht = srcImg.getHeight(frame);
	//out.println("wd: "+wd+" ht: "+ht);
%>

<html>
<head><title>Mark Patch</title></head>
<style>
body{background-image:url("../images/txture5.jpg")}


</style>
<link href="offlineskinpatch.css"></link>

<script type="text/javascript">

var canvas, ctx, points="", flag = false,
    prevX = 0,
    currX = 0,
    prevY = 0,
    currY = 0,
    dot_flag = false;

var x = "Red",
    y = 2;
    
function init() {
    canvas = document.getElementById('can');
    temp_canvas=document.getElementById('canvas');
    ctx = canvas.getContext("2d");
   canvas.width=document.getElementById("img1").width;
   canvas.height=document.getElementById("img1").height;
   temp_canvas.width=document.getElementById("img1").width;
   temp_canvas.height=document.getElementById("img1").height;
   // w = canvas.width;
   // h = canvas.height;

  
   
canvas.style.backgroundImage='url("<%=imgsrc%>")';
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
   // sessionStorage.removeItem('imgs');	
    //tested Ok
    document.getElementById("point").value=points; 
   var wd=document.getElementById("img1").width;
var ht=document.getElementById("img1").height;
document.getElementById("ht").value=ht;
document.getElementById("wd").value=wd;
if(ht>600||wd>600)
{
document.getElementById("save-btn").disabled=true;
alert("Image size should less than 600");
window.history.back();
}

 var c = document.getElementById("canvas");
    var ctx = c.getContext("2d");
    var img11 = document.getElementById("img1");
    ctx.drawImage(img11,0,0);
var dataURL=c.toDataURL();
var dataString=dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
document.getElementById("imgdata").value=dataString;

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
        prevX = currX;
        prevY = currY;
        currX = e.clientX - canvas.offsetLeft;
        currY = e.clientY - canvas.offsetTop;
 
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
            currX = e.clientX - canvas.offsetLeft;
            currY = e.clientY - canvas.offsetTop;
             draw();
             points=points + prevX.toString() + "," + prevY.toString()+ ","+currX.toString() + "," + currY.toString()+ "-";  
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
		//else alert("TEST");
		else
	{
	return false;
	}
	}
	
	}

}
</script>

<body onload="init()">


<form onsubmit="return pointcheck()" action="savepatchfrm.jsp" method="POST">  
<%
	String location = Srv+"servlet/savepatch";
	String par="&"+pid+"&"+fn +"&"+ edt+"&"+frmtyp+"&";
	
	out.println("<input  hidden type=text name=dxn id=dxn value=\"" + par + "\">");
	out.println("<input  hidden type=text name=loc id=loc value=\"" + location + "\">");
	out.println("<input  hidden type=text name=isl id=isl value=\""+isl+ "\">");
	out.println("<input  hidden type=text name=dt1 id=dt1 value=\""+dt1+ "\">");
%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label id="label">Color choose : </label><input type="color" name="color1"  id="colorid" alt="Your Browser no supporting" />
<textarea  maxlength="30" id="img_desc" placeholder="Image Description" name="img_desc"></textarea>
<input hidden type="text" name="pont" id="point" value=""/>
<input  hidden type="text" name="ht" id="ht" value=""/>
<input hidden  type="text" name="wd" id="wd" value=""/>
<input hidden  type="text" name="imgdata" id="imgdata" value=""/>
<td><input hidden  type="text" name="getcolor" id="sndcolor" value=""/>
<input id="save-btn" type="submit" value="Save" />
<input type="button" onclick="erase()" value="Clear" />
</form>


<canvas onmouseover="selectedcolor()" onmouseout="save()" id="can" style="border:1px solid #000000;cursor:crosshair"; ></canvas>

<img hidden src='<%=Srv+"/jspfiles/displayimg.jsp?id="+ID+"&ser="+isl+"&type="+ty+"&dt="+dt1%>' id="img1">
<canvas hidden id="canvas" style="border:1px solid"><canvas>

</body>

</html>

