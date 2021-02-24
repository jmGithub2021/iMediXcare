<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.cook,imedix.myDate, java.util.*,java.io.*, javax.swing.ImageIcon,java.awt.*" %>
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
	String dt="",isl="",itype="",dat="",endt="";
	int iwd =111;
	int iht =111;
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

	try{

		
		String fdt =endt.replaceAll("/","");
		String imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/"+pid+"/";
			
		fname=pid+fdt+itype+isl+"." + ext;
		fname=fname.toLowerCase();
		String imgnam = imgdirname+fname;
		File fdir = new File(imgdirname);
		if(!fdir.exists()){
				boolean yes1 = fdir.mkdirs();
		}

		String cnttype = ddinfo.GetImageCon_type(pid,dat,itype,isl);

		if(cnttype.equalsIgnoreCase("LRGFILE")){
			String fn=pid+fdt+itype+isl+"."+ext;
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

		
  		if(iwd < 270) iht = iht+30*3;
		else if (iwd>=270 && iwd<390) iht = iht+30*2;
		else iht = iht+30;
		 
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
	out.println("<APPLET CODE='offlinemarkimg' codebase='./marking/' archive='markimage.jar'  MAYSCRIPT Width="+iwd+" Height="+iht+" >");

	//out.println("<Applet CodeBase='./marking/' Code='offlinemarkimg.class'  Width="+iwd+" Height="+iht+">");	
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
