<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook, java.util.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<% 	
	String sndname,Node="",ccode="",endt="",usr="",fname="",fpath="";
	
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	
	ccode = cookx.getCookieValue("center", request.getCookies ());
	usr = cookx.getCookieValue("userid", request.getCookies());
	
	sndname=request.getParameter("ty");
	sndname=sndname+"-"+request.getParameter("sl")+"#";
	
	String id = request.getParameter("id");
	String ty = request.getParameter("ty");
	String sl = request.getParameter("sl");
	String dt = request.getParameter("dt");
	String imgdirname="",imgnam="";
	//endt=dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);
	endt=dt;
	String fdt = dt.substring(8,10)+dt.substring(5,7)+dt.substring(0,4);
				
			try
			{
				byte [] _blob =ddinfo.getDocument(id,endt,ty,sl);
				String ext =ddinfo.getDocumentExt(id,endt,ty,sl);
				if(_blob==null)
				{
				imgdirname=request.getRealPath("//")+"/data"+id+"/";
				fname=id+fdt+ty+sl+"."+ext;
				fpath="/data/"+id+"/"+fname;
				}
				else{
				imgdirname=request.getRealPath("//")+"/temp/"+usr+"/docs/";
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
				fpath="/temp/"+usr+"/docs/"+fname;
			}
			
			}catch(Exception e)
			{
				out.println("Error in getbinary data : "+e.toString());
			}
	
	

	//String fullPath = "http://" + request.getServerName() + ":" + request.getServerPort() + "/iMediX/" +fpath;
	

//out.println(fullPath);
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
	newval = <%out.println("'"+ sndname + "'");%> 
	prevalue=getCookie("selsnd");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selsnd="+prevalue;
	alert(getCookie("selsnd"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ sndname + "'");%> 
	prevalue=getCookie("selsnd");
	document.cookie="selsnd="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selsnd="+nval;
	//alert(getCookie("selsnd"));	
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
tar="playsound.jsp?"+val;
//alert(tar);
window.location=tar;

}

//-->
</SCRIPT>
</HEAD>
<BODY background="../images/txture.jpg">
<TABLE Border=0 BorderColor=#3333CC Cellspacing=0 Cellpadding=3 Width=700>
<TR>
<TD><FORM NAME=frmsnd>
<%
			boolean found=false;
			String Qr1="",Qr="",patpicurl="",pdt="",dt1="";
			//telemedicin req
			String utype="";
			utype = cookx.getCookieValue("usertype", request.getCookies ());
			//if(utype.equals("adm"))
			//{
			String selsnd,thissnd;
			int hasthissnd=0;
			selsnd = cookx.getCookieValue("selsnd", request.getCookies ());
			thissnd = sndname;
			if(!selsnd.equals(""))
			{
			try
			{
			String str[]=selsnd.split("#");
			for(int k=0;k<str.length;k++)
			{
				if(thissnd.equals(str[k]+"#"))
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



	//out.println ("id = " + id + "<BR>" );
	//out.println ("dt = " + dt + "<BR>" );
	//out.println ("ty = " + ty + "<BR>" );
	//out.println ("sl = " + sl + "<BR>" );
%>

</FORM></TD>
</TR>
<TR>
<TD><HR Color=PINK></TD>
</TR>
<TR>
	<TD><Center><!--<EMBED SRC="..<%=fpath%>" width=500 height=100  loop=1></Center>-->
	<audio controls>
  <source src="..<%=fpath%>" type="audio/ogg">
  <source src="..<%=fpath%>" type="audio/mpeg">
Your browser does not support the audio element.
</audio>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>
