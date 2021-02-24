<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%@include file="..//gblinfo.jsp" %>
<HTML>
<head>   
	<title>File Uploading</title>
	<link rel="stylesheet" type="text/css" href="ckp.jsp">
<%
	String docid;
	MyWebFunctions thisObj = new MyWebFunctions();
	docid=request.getParameter("docid");
	
%>
<SCRIPT LANGUAGE="JavaScript" SRC="dkp.jsp">
var putdate,putmonth;
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function setvalues() {
	document.imgld.desc.value = document.imgld.type.value + " File";
}

function MM_displayStatusMsg(msgStr) { //v1.0
  status=msgStr;
  document.MM_returnValue = true;
}




//-->
</SCRIPT>
</head>
<BODY>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0  bgcolor="#00ffff" Width=100% Align=Left>
<TR><TD><BLOCKQUOTE>

<BR><CENTER><U><FONT SIZE="+2" COLOR=#9B004E>Upload Doctor Signature</FONT></U></CENTER><BR>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="../servlet/uploadsign" name="imgld">
  <TABLE  border=0>
   <tr>
   <td Align='Right' Width=200> Path of the file for uploading: </TD>
   <TD Width=10></TD>
   <TD><INPUT TYPE=file NAME=userfile size=53 onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')" onMouseOut="MM_displayStatusMsg(' ')" ></TD>
   </TR>
	
<INPUT TYPE="hidden" name="docid" value="<%=docid%>">

<INPUT TYPE="hidden" name="gbldbjdbcDriver" value="<%=gbldbjdbcDriver%>">
	<INPUT TYPE="hidden" name="gbldbURL" value="<%=gbldbURL%>" >
	<INPUT TYPE="hidden" name="gbldbusername" value="<%=gbldbusername%>" >
	<INPUT TYPE="hidden" name="gbldbpasswd" value="<%=gbldbpasswd%>" >
	<INPUT TYPE="hidden" name="gblDataDir" value="<%=gblDataDir%>" >
	<INPUT TYPE="hidden" name="gblTelemediK" value="<%=gblTelemediK%>" >

	</TD>
	</TR>
	</TABLE>
	
	<BR>
	<BR>
	<center><input type="submit" value="Upload"  style="background-color: '#FFE0C1'; color: '#000000'; font-weight:BOLD; "></CENTER>

</FORM>
</BLOCKQUOTE>
</TD></TR>
</TABLE>

</body>
</HTML>
