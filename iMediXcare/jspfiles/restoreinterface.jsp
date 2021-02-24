<%@page contentType="text/html" import="imedix.rcAdminJobs,imedix.rcCentreInfo, imedix.dataobj, imedix.cook,imedix.projinfo,java.util.*, java.net.*,java.text.*,java.io.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%	
	cook cookx = new cook();
	String ccode= cookx.getCookieValue("center", request.getCookies ());

	projinfo proj=new projinfo(request.getRealPath("/"));
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	/*
	try{	 
		
		 String localhost=request.getLocalName();
		 out.println("local host : "+request.getProtocol()+"<br>");
			 String localip=request.getRemoteAddr();
			 if(!localip.equalsIgnoreCase(proj.gblsip)) {
				 out.println("<center><FONT Size='+2' COLOR='#E80074'>Run This Utility on the Server</FONT></center>");
				 return;
				 }
	   	}
	   	catch(Exception e)
		{
		out.println(e);
		}
   */

   String resdir=rcajob.getAllBackupDirs("backup");
   String[] subdir=resdir.split("#");

   if (resdir.equalsIgnoreCase("None")){
	   out.println("<br><br><center><FONT Size='5' COLOR='#E80074'> No Backup Directory</FONT> </center>");
	   return;
   }
	%>

<HTML>
<HEAD> 
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
<TITLE>Data Archival</TITLE>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
</HEAD>

<BODY background="../images/txture.jpg" >
	<div class="container-fluid">
	
	<TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
	<TR>
		<TD><Font Size='5' color=#3300FF> <B>RESTORE UTILITY</B> </Font></TD>
		<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
	</TR>
	</TABLE>
<br><div class="container">
<!--<A class="btn btn-warning pull-right" HREF="jobadmin.jsp">Back</A><br>-->
<div class="row">
<div class="col-sm-2">
</div>		<!-- "col-sm-2" -->
<div class="col-sm-8">
<FORM METHOD=get ACTION="restore.jsp" name="frmrestore" >
<div class="input-group">
<span class="input-group-addon"><b>Choose Bakup Directory :</b></span>
</div>		<!-- "input-group" -->
<div class="input-group">
<SELECT class="form-control" NAME="dirnam" style="color:#980000;background-color:#FFFFCC; ">
				<%
					int tag=0; //display the name of the bakup dir
					boolean found=false;
					while(tag < subdir.length)
					{
					if(ccode.equals("XXXX")){
						out.println("<option value="+subdir[tag]+">"+subdir[tag]+"</option>");
						found=true;
					}else{
						if(subdir[tag].indexOf(ccode)>0){
							out.println("<option value="+subdir[tag]+">"+subdir[tag]+"</option>");
							found=true;
						}
						
					}
					tag=tag+1;
					} 
				%>
			</SELECT>
	<span class="input-group-btn">		
	<%
		if(found==true){
		%>
		<INPUT class="form-control btn btn-info" TYPE="submit" value="Submit" style="background-color: '#844242'; color: Blue; font-weight:BOLD; font-style:oblique " width=5></CENTER>
		</td>
		<%
		}else{
			out.println("<br><br><center><FONT COLOR='#E80074'> No Backup Directory</FONT> </center>");
		}
		%>
		</span>
</div>		<!-- "input-group" -->
</FORM>
</div>		<!-- "col-sm-8" -->
<div class="col-sm-2"></div>
</div>		<!-- "row" -->
</div>
</body>
</html>
