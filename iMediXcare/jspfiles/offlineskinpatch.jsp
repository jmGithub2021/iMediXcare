<%@page contentType="text/html" import="imedix.cook,imedix.myDate,java.util.*,java.io.*,java.awt.*" %>
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
	String imgsrc, img, ij,Srv,test;
	String  parimg1,parimg2, Source;
	cook cookx = new cook();

	String ccode="",us="",pid="",edt="",fn="";

	ccode = cookx.getCookieValue("center", request.getCookies()); // get the center code from cookie
	us = cookx.getCookieValue("userid", request.getCookies());
	pid = cookx.getCookieValue("patid", request.getCookies());
	
	edt=myDate.getCurrentDate("dmy",false);

	fn = request.getParameter( "type" );
	String frmtyp = request.getParameter( "frmtyp" );
	if(frmtyp==null) frmtyp="SKP";
	if(frmtyp.equals("")) frmtyp="SKP";
	
	//Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
	//Srv =Srv+"/iMediX/";
	
	Image srcImg;	
	imgsrc = request.getRealPath("/")+"/jspfiles/anatomyimages/"+fn+".jpg";
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
	int iwd = wd;

	int iht = ht+65;

	//out.println("iwd: "+iwd+" iht: "+iht);
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
	//parimg1 = "<param name='home'  value='"+Srv+ "' >";
	parimg2 = "<param name='patid'  value='"+pid+ "' >";

	out.println("<APPLET CODE='offlineskinpatch' codebase='./marking/' archive='markpatch.jar'  MAYSCRIPT Width="+iwd+" Height="+iht+" >");

	//out.println("<Applet CodeBase='./marking/' Code='offlineskinpatch.class' Width="+iwd+" Height="+iht+" >");
	//out.println(parimg1);
	out.println(parimg2);

	out.println("<param name='usr' value='"+us+"'>");
	out.println("<param name='tdate' value='"+edt+"'>");
	out.println("<param name='skptyp' value='"+fn+"'>");
	out.println("<param name='frmtyp' value='"+frmtyp+"'>");
	out.println("</Applet>"); 
%>
</Center></TD>
</TR>
<%
if(!frmtyp.equalsIgnoreCase("SKP")){
	out.println("<TR><TD align='center'>");	
	out.println("<A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' BORDER='1' ></A>");	
	out.println("</TD></TR>");	
}
%>
</TABLE>
</body>
</html>
