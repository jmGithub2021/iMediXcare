<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook, java.util.*,java.io.*, javax.crypto.*,imedix.Crypto, java.net.URLEncoder, java.nio.charset.StandardCharsets" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%  
	String movname,id="",ty="",sl="",ccode="",usr="",fname="",endt="",ext="",imgdirname="",imgnam="" ;
	
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));

    SecretKey key = getSecretKey(session);
		String encodedKey = Base64.getEncoder().encodeToString(key.getEncoded());	    
    Crypto crypto = new Crypto(key);

	ccode = cookx.getCookieValue("center", request.getCookies ());
	usr = cookx.getCookieValue("userid", request.getCookies());

	movname=request.getParameter("ty");
	movname=movname+"-"+request.getParameter("sl")+"#";
	//out.println("movname: "+movname);
	id=request.getParameter("id");
	ty=request.getParameter("ty");
	sl=request.getParameter("sl");
	String dt = request.getParameter("dt");
	
	//endt=dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);
	endt=dt;
	String fdt = dt.substring(8,10)+dt.substring(5,7)+dt.substring(0,4);

	//'	String imgdirname="",imgnam="";
	//String url = request.getParameter("url").toLowerCase(); 
	//String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + gblTelemediK+url;
	 String con_type=ddinfo.getMovieCon_type(id,endt,ty,sl);
	 //out.println("con_type: "+con_type);
	 try
			{
				ext=ddinfo.getMovieExt(id,endt,ty,sl);
				if(!con_type.equalsIgnoreCase("LRGFILE")){

					byte [] _blob =ddinfo.getMovie(id,endt,ty,sl);
					
					imgdirname=request.getRealPath("//")+"/temp/"+usr+"/mov/";
					fname=id+fdt+ty+sl+"."+ext;
					fname=fname.toLowerCase();
					imgnam = imgdirname+fname;
					
					File fdir = new File(imgdirname);
					if(!fdir.exists())
					{
						boolean yes1 = fdir.mkdirs();
					}

					File fimg = new File(imgnam);
					if(!fimg.exists())
					{
						RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
						raf.write(_blob);
						raf.close();
					}
				}

			}catch(Exception e)
			{
				out.println("Error in getbinary data : "+e.toString());
			}
	

		String fpath="/temp/"+usr+"/mov/"+fname;



%>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
function setvalue(val)
{	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ movname + "'");%> 
	prevalue=getCookie("selmov");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selmov="+prevalue;
	alert(getCookie("selmov"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ movname + "'");%> 
	prevalue=getCookie("selmov");
	document.cookie="selmov="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selmov="+nval;
	//alert(getCookie("selmov"));	
	}
}

function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }
function showselected(val)
{
var tar;
tar="viewmovie.jsp?"+val;
alert(tar);
window.location=tar;

}

//-->
</SCRIPT>
</HEAD>
<BODY>
<BR>
<FORM name="movfrm">
<CENTER><FONT COLOR="#660066"><B>Movie can be viewed only after sucessfull download<BR>from your Server :
<%
out.print(" [<B><FONT COLOR='#FF99CC'>"+request.getServerName() + ":" + request.getServerPort()+"</FONT></B>]<BR>");
		boolean found=false;
			

			String Qr1="",Qr="",patmovurl="",pdt="",dt1="";
			//telemedicin req
			String utype="";
			utype = cookx.getCookieValue("type", request.getCookies ());
			//if(utype.equals("adm"))
			//{
			String selmov,thismov;
			int hasthismov=0;
			selmov = cookx.getCookieValue("selmov", request.getCookies ());
			thismov = movname;
			if(!selmov.equals(""))
			{
			try
			{
			String str[]=selmov.split("#");
			for(int k=0;k<str.length;k++)
			{
				if(thismov.equals(str[k]+"#"))
				{
				found = true;
				break;
				}
				else
				{
				found=false;
				}
			} //end of for loop
			} catch(ArrayIndexOutOfBoundsException e1)
			{ }
 
			}

			//out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			//if(found == true)
			//{
			//out.println(" checked");
			//}
			//out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT>");


String movpath="";

if(con_type.equalsIgnoreCase("LRGFILE")){
	//ty=ty.toLowerCase();
	 String fn=id+fdt+ty+sl+"."+ext;
	 movpath="/data/"+id+"/"+fn; 
}else{
	 movpath="/"+fpath; //"displaymovie.jsp?id="+id+"&ty="+ty+"&sl="+sl+"&dt="+dt;
}
		String path = crypto.encrypt(movpath);
		movpath = "getFile.jsp?file="+URLEncoder.encode(path, StandardCharsets.UTF_8);	
%>
<HR Color=pink>
<BR><!--<EMBED SRC="<%=movpath%>" AUTOSTART="true" LOOP='true' >-->

<video width="400" controls>
  <source SRC="<%=movpath%>" type="video/mp4">
  <source SRC="<%=movpath%>" type="video/ogg">
  Your browser does not support HTML5 video.
</video>
 <CENTER>
</FORM>
</BODY>
</HTML>
