<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.cook,imedix.myDate, java.util.*,java.io.*, javax.swing.ImageIcon,java.awt.*" %>
<%@ include file="..//includes/chkcook.jsp" %>


<% 	
	String imgnam="",Srv="", imgsrc="",fn="";
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	String ccode="",usr="",pid="";
	String dt="",isl="",itype="",dat="",endt="";
	int iwd =111,wd=100;
	int iht =111,ht=100;
	String fname="";
	//id=NRSH1911070001&ser=0&type=BLD&dt=10/12/2007

	pid=request.getParameter("id");
	isl=request.getParameter("ser");
	itype=request.getParameter("type");
	dat=request.getParameter("dt");
	String ext=request.getParameter("ext");

	endt=dat.substring(8,10)+"/"+dat.substring(5,7)+"/"+dat.substring(0,4);

	ccode = cookx.getCookieValue("center", request.getCookies()); 
	usr = cookx.getCookieValue("userid", request.getCookies());

	Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
	Srv =Srv+"/iMediX/";

	try{

		
		String fdt =endt.replaceAll("/","");
		String imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/"+pid+"/";
			
		fname=pid+fdt+itype+isl+"." + ext;
		fname=fname.toLowerCase();
		imgnam = imgdirname+fname;
		File fdir = new File(imgdirname);
		if(!fdir.exists()){
				boolean yes1 = fdir.mkdirs();
		}

		String cnttype = ddinfo.GetImageCon_type(pid,dat,itype,isl);

		if(cnttype.equalsIgnoreCase("LRGFILE")){
				fn=pid+fdt+itype+isl+"."+ext;
			String fpath=request.getRealPath("//")+"/data/"+pid+"/"+fn;

			myDate.copyfile(fpath,imgnam);
			ImageIcon imageIcon = new ImageIcon(imgnam);
			iwd = imageIcon.getIconWidth();
			iht = imageIcon.getIconHeight();
		
		}else{
		
			byte[] fileArray =ddinfo.GetImage(pid,dat,itype,isl);
			//System.out.println(fileArray);
			ImageIcon imageIcon = new ImageIcon(fileArray);
			iwd = imageIcon.getIconWidth();
			iht = imageIcon.getIconHeight();
			File fimg = new File(imgnam);
			if(!fimg.exists())
			{
				RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
				raf.write(fileArray);
				raf.close();
			}

		}



/*	Image srcImg;	
	imgsrc = request.getRealPath("//")+"/temp/"+usr+"/images/"+pid+"/";
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
		wd = srcImg.getWidth(frame);
		ht = srcImg.getHeight(frame);
*/
		
  		//if(iwd < 270) iht = iht+30*3;
		//else if (iwd>=270 && iwd<390) iht = iht+30*2;
		//else iht = iht+30;
		 
	}catch(Exception e)
	{
		System.out.println("Error in getbinary data : "+e.toString());
	}

	
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
canvas#can{background-repeat:no-repeat; background-position: center; background-size: <%=iht%> <%=iwd%>; }

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
   	canvas.style.backgroundImage='url("/iMediX/temp/<%=usr%>/images/<%=pid%>/<%=fname%>")';
   
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

<body onload="init()">

<div class="container-fluid"> 

<center><canvas class="img-responsive" ontouchstart="selectedcolor()" onmouseover="selectedcolor()" ontouchend="save()" onmouseout="save()" id="can" width=<%=iwd%> height=<%=iht%> style="border:2px solid;cursor:crosshair" ></canvas></center>


<form onsubmit="return pointcheck()" action="saveimgmark.jsp" method="POST">
<%
	String location = Srv+"servlet/imgmarkservlet";
	String prms=request.getQueryString();
	//String par=prms+"&ccode="+ccode+"&uid="+uid+"&line="+lin+"&circle="+cir+"&rect="+rectan+"&fhand="+fhand+"&txt="+txt;
	String par=prms;
	
	out.println("<input type=hidden name=dxn id=dxn value=\"" + par + "\">");
	out.println("<input type=hidden name=loc id=loc value=\"" + location + "\">");
	

%>

<div class="row">

<div class="col-lg-3 col-sm-2"></div>

<div class="col-lg-6 col-sm-8 well">
<br/><div class="input-group">
<input class="form-control" type="color" name="color1" id="colorid"  data-toggle="tooltip" title="Choose Color" />
<span class="input-group-btn"><input class="btn btn-warning" type="button" onclick="erase()" value="Clear" /></span>
</div>		<!-- "input-group" -->

<!--<textarea  maxlength="30" id="img_desc" placeholder="Image Description" name="img_desc"></textarea>--></td>
<input  type="hidden" name="pont" id="point" value=""/>
<input  hidden type="text" name="getcolor" id="sndcolor" value=""/>

<br/><center><input class="btn btn-primary" type="submit" value="Save" /></center>
</div>		<!-- "col-lg-6 col-sm-8" -->

<div class="col-lg-3 col-sm-2"></div>

</div>		<!-- "row" -->

</form>

</div>		<!-- "container-fluid" -->
</body>
</html>

