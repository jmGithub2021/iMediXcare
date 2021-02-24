<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.cook,imedix.myDate, java.util.*,java.io.*,javax.swing.ImageIcon,java.awt.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<head>
<title>Image Effects</title>
<style>
A { text-decoration: None;
	color: BLUE;
	font-weight: BOLD;
}
</style>
</head>

<%
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));


	String ccode="",usr="",pid="";
	String dt="",ext="",isl="",itype="",endt="",dat;
	pid=request.getParameter("patid");
	isl=request.getParameter("isl");
	itype=request.getParameter("type");
	dat=request.getParameter("dt");
	endt=dat.substring(8,10)+"/"+dat.substring(5,7)+"/"+dat.substring(0,4);

	String fdt =endt.replaceAll("/","");

	usr = cookx.getCookieValue("userid", request.getCookies());
	ccode = cookx.getCookieValue("center", request.getCookies()); 
	
	String imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/"+pid+"/";;
	String fname=pid+fdt+itype+isl+".jpg";

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

%>
<TABLE Border=0 Width=800>
<TR><TD><FONT SIZE="3pt" COLOR="RED"><B>
<%
	
  out.println("<B>[</B>&nbsp;<A Href=javascript:location.reload()>Refresh</A>&nbsp;<B>|</B>&nbsp;");
%>

</B></FONT>
<HR Color=PINK>
</TD><!-- <TD><FONT SIZE="+3" COLOR="GREEN"><B>Other Features</B></FONT></TD> --></TR>
<TR><TD>
<Center>
<%	
	out.println("<APPLET CODE='offlinemarkdicom' codebase='./marking/' archive='markdicom.jar'  MAYSCRIPT Width="+iwd+" Height="+iht+" >");

	//out.println("<Applet CodeBase='./marking/' Code='offlinemarkdicom.class'  Width="+iwd+" Height="+iht+">");	
	
	out.println("<Param name='uid' value='"+usr+"'>");
	out.println("<Param name='ccode' value='"+ccode+"'>");
	out.println("<Param name='fname' value='"+fname+"'>");
	out.println("<Param name='pid' value='"+pid+"'>");

	out.println("</Applet>");	

%>
</Center></TD>

</TR></TABLE>
</body>
</html>

