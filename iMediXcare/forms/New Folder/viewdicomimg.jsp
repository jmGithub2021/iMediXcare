<%@page contentType="text/html" %>
<%@ include file="..//gblinfo.jsp" %>
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
	MyWebFunctions thisObj = new MyWebFunctions();
	String ccode="",us="",pid="";
	
	String str="",dt="",ext="",imgdir="",imgpath="",patid="",sl="",ty="",endt="";
	patid=request.getParameter("patid");
	sl=request.getParameter("sl");
	ty=request.getParameter("ty");
	endt=request.getParameter("dt");
	//endt=endt.substring(6)+"/"+endt.substring(3,5)+"/"+endt.substring(0,2);
	int e = 0,s=0;
	ccode = thisObj.getCookieValue("center", request.getCookies()); // get the center code from cookie
	us = thisObj.getCookieValue("user", request.getCookies());
	pid = thisObj.getCookieValue("patid", request.getCookies());
	imgdir=request.getParameter( "image" );
	imgdir=imgdir.substring(0,imgdir.lastIndexOf("."))+".jpg";
	imgpath=request.getParameter( "image" );
	imgpath=imgpath.substring(0,imgpath.length()-1);
			StringBuffer result = new StringBuffer();
			
			while((e=imgpath.indexOf("//",s))>=0)
			{
			result.append(imgpath.substring(s, e));
            		result.append("/");
			s = e+2;
			}
	result.append(imgpath.substring(imgpath.lastIndexOf("/")+1));
	imgpath=result.toString();
	
	imgpath=request.getRealPath("/")+imgpath.substring(1,imgpath.lastIndexOf("."));
	//imgpath=gblFTPRoot.substring(0,gblFTPRoot.lastIndexOf("/"))+"/"+us+imgpath.substring(0,imgpath.lastIndexOf("."));
	//out.println("imgpath:"+imgpath+".bmp");	

	try
        {            
            Runtime rt = Runtime.getRuntime();
		
          
Process proc = rt.exec(gblJsp+"/shellscripts/convertjpg.sh "+imgpath+".bmp"+" "+imgpath+".jpg");
            
        } catch (Throwable t)
          {
           out.println("Error in Shell Script : "+ t.toString());
          } 


	test =  request.getContextPath();
	//imgsrc =  request.getContextPath() + imgdir;
	//imgsrc =  gblFTPRoot.substring(0,gblFTPRoot.lastIndexOf("/"))+"/"+us + imgdir;
	
	img = imgdir;
	Source = imgdir;
	//img  = Source;
	
	int i, st=38;
	Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
	ij = Srv + gblTelemediK + "/jspfiles/";
	//ij = Srv + request.getContextPath() + "/jspfiles/";
	

	


	Image srcImg;	
	imgsrc = request.getRealPath("//")+Source.substring(1);
	
	
	
	
	srcImg = Toolkit.getDefaultToolkit().getImage(imgsrc);
	
	//out.println("imgsrc :"+imgsrc);


	//out.println("real path :"+imgsrc);
	//srcImg = Toolkit.getDefaultToolkit().getImage(imgsrc);
        
	Frame frame = new Frame();
	MediaTracker mt = new MediaTracker(frame);
	mt.addImage(srcImg,0);
	try 
	{
		mt.waitForID(0);
	}
	catch(InterruptedException e1) 
	{
	out.println("Error in loading image:"+e1.toString());
	}
	int wd = srcImg.getWidth(frame);
	int ht = srcImg.getHeight(frame);
	
	int iwd = wd;
	int iht = ht+20;
	//out.println("iwd: "+wd+"   iht: "+ht);
	//out.println("img :- "+Srv+gblTelemediK+"/"+ img.substring(1,img.length()));
%>
<TABLE Border=0 Width=800>
<TR><TD><FONT SIZE="3pt" COLOR="RED"><B>
<%
 // out.println(img);
  out.println("<B>[</B>&nbsp;<A Href=javascript:location.reload()>Refresh</A>&nbsp;<B>|</B>&nbsp;");
  /* out.println("<A Href=\'showimage.jsp?image="+img+"\'>Normal</A>&nbsp;<B>|</B>&nbsp;");
  out.println("<A Href=\'showzimage.jsp?image="+img+"\'>Zooming</A>&nbsp;<B>|</B>&nbsp;");
  out.println("<A Href=\'showcimage.jsp?image="+img+"\'> Colored</A>&nbsp;<B>]</B>&nbsp;");
  out.println("<A Href=\'offline.jsp?image="+img+"\'> Off-line Marking</A>&nbsp;<B>]</B>"); */

%>

</B></FONT>
<HR Color=PINK>
</TD><!-- <TD><FONT SIZE="+3" COLOR="GREEN"><B>Other Features</B></FONT></TD> --></TR>
<TR><TD>
<Center>
<%	//parimg = "<param name='image'  value='"+Srv+request.getContextPath()+"/"+ img.substring(1)+ "' >";
	parimg1 = "<param name='image'  value='"+Srv+gblTelemediK+"/"+ img.substring(1,img.length())+ "' >";
	parimg2 = "<param name='filepath'  value='"+imgsrc.substring(0,imgsrc.length())+ "' >";
	
	//out.println("<Applet CodeBase='"+ij+"' Code='dicomviewernew.class'  Width="+iwd+" Height="+iht+" >");
	 out.println("<Applet CodeBase='"+ij+"' Code='dicommark.class'  Width="+iwd+" Height="+iht+" >");
	out.println(parimg1);
	out.println(parimg2);
	out.println("<param name='ccode' value='"+ccode+"'>");
	out.println("<param name='pid' value='"+pid+"'>");
	out.println("<param name='us' value='"+us+"'>");
	out.println("</Applet>"); 

%>
</Center></TD>

</TR></TABLE>
</body>
</html>
