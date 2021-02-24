<%@page language="java"%>
<%@ include file="..\\gblinfo.jsp" %>
<%
	String id;
	MyWebFunctions thisObj = new MyWebFunctions();
	id = thisObj.getCookieValue("patid", request.getCookies());
	out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + id + "</B></FONT><BR>");
%>

<HTML>
<HEAD>

<TITLE> New Document </TITLE>

<STYLE>
<!--
A			{color:#6600CC;text-decoration:none; font-family:Tahoma; font-weight:Bold}
A:hover		{color:#FF0099;text-decoration:none; font-family:Tahoma; font-weight:Bold}
//-->
</STYLE>

<style>
<!--
#foldheader{cursor:hand ; font-color="red"-weight: ;
list-style-image:url(fold.gif)}
#foldinglist{list-style-image:url(list.gif)}
//-->
</style>
<script language="JavaScript">
<!--

var head="display:''"
img1=new Image()
img1.src="fold.gif"
img2=new Image()
img2.src="open.gif"

function change(){
   if(!document.all)
      return
   if (event.srcElement.id=="foldheader") {
      var srcIndex = event.srcElement.sourceIndex
      var nested = document.all[srcIndex+1]
      if (nested.style.display=="none") {
         nested.style.display=''
         event.srcElement.style.listStyleImage="url(open.gif)"
      }
      else {
         nested.style.display="none"
         event.srcElement.style.listStyleImage="url(fold.gif)"
      }
   }
}

document.onclick=change

//-->
</script>
</HEAD>
<BODY bgcolor="#FFCCCC" >
<TABLE>
<TR>
	<TD><a href=concent.jsp TARGET=right>Give Consent</a></TD>
</TR>
<TR>
	<TD><a href=t01.jsp TARGET=right>General Exam.</a></TD>
</TR>
<TR>
	<TD><a href=t02.jsp TARGET=right>Emergency </a></TD>
</TR>
<TR>
	<TD><a href=../jspfiles/offlineskinpatch.jsp?image=<%=gblImages%>/skinpatch.jpg TARGET=right>Mark SkinPatch </a></TD>
</TR>
</Table>
<TABLE Border=1 Width=180> 
<TR BGColor="#99CCFF">
	<TD><A HREF="history.jsp"><B>History</B><!-- <IMG SRC="history.jpg" Border=0 Height=20 Width=75> --></A></TD>
	<TD><A HREF="physical.jsp"><B>Physical</B><!-- <IMG SRC="Physical.jpg" Border=0  Height=20 Width=75> --></A></TD>
</TR>
<TR BGColor="#99CCFF">
	<TD><A HREF="invest.jsp"><B>Investigation</B><!-- <IMG SRC="investigation.jpg" Border=0 Height=20 Width=75> --></A></TD>
	<TD><A HREF="diagnosis.jsp"><B>Diagnosis</B><!-- <IMG SRC="diagnosis.jpg" Border=0 Height=20 Width=75> --></A></TD>
</TR>
</TABLE>
<HR COLOR=RED WIDTH=180 Align=Left><B><FONT  COLOR="#FF00FF">
 		
 			<li><a href='delimages.jsp?id=<%=id%>&frm=i00'Target=right>Blood R/E</a></li>
			<li><a href='s01.jsp'Target=right>Blood C/S</a></li>
			<li><a href='delimages.jsp?id=<%=id%>&frm=i02'Target=right>CBC</a></li>
			<li><a href='s03.jsp'Target=right>Urine R/E</a></li>
			<li><a href='s04.jsp'Target=right>Urine C/S</a> </li>
			<li><a href='s05.jsp'Target=right>Stool R/E</a></li>
			<li><a href='s06.jsp'Target=right>Stool C/S</a></li>
			<li><a href='delimages.jsp?id=<%=id%>&frm=i07'Target=right>Special report</a></li>
			<li><a href='imageload.jsp'Target=right>Upload File</a></li>
			<!--<li><a href="applet/ftpload.jsp" Target=right>FTP Upload File</a></li> 
			<li><a href="applet/testftpload.jsp" Target=right>TEST FTP Upload
			<li><a href="Download.jsp" Target=right>FTP Upload File</a></li>
			<li><a href="ftpupload.jsp" Target=right>FTP Upload File</a></li>
			 File</a></li> -->
			<li><a href="ftpupload.jsp" Target=right>FTP Upload File</a></li>
			<li id="foldheader">Blood Biochemistry</li>
			<ul id="foldinglist" style="display:none">
				<li><a href='s08.jsp' Target=right>Sugar</a></li>
				<li><a href='s09.jsp' Target=right>Kidney</a></li>
				<li><a href='s10.jsp' Target=right>Lipid</a></li>
				<li><a href='s11.jsp' Target=right>Liver</a> </li>
				<li><a href='s12.jsp' Target=right>Enzyme</a> </li>
				<li><a href='s13.jsp' Target=right>Electrolyte </a></li> 
				<li><a href='s14.jsp' Target=right>Pancreas </a> </li>
				<li><a href='s15.jsp' Target=right>Serological</a></li>
			</ul>

			<li id="foldheader">Special test</li>
			<ul id="foldinglist" style="display:none">
 			<li><a href='delimages.jsp?id=<%=id%>&frm=i16'Target=right>Abnormal cells</a> </li>
				<li><a href='s17.jsp'Target=right>Coagulation</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i18'Target=right>Bone marrow</a> </li>
				<li><a href='s19.jsp'Target=right>Urine chemistry</a> </li>
				<li><a href='s20.jsp'Target=right>Obstetric Urine</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i21'Target=right>Obstetric ultrasound</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i22'Target=right>X-Ray</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i23'Target=right>Urinary Tract Imaging</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i24'Target=right>CVS Imaging</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i25'Target=right>Abdominal / Pelvic scan</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i26'Target=right>CT scan</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i27'Target=right>MRI</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i28'Target=right>ECG</a> </li>
				<li><a href='delimages.jsp?id=<%=id%>&frm=i29'Target=right>Electrophysiology</a> </li>
				


				<li><a href='s28.jsp'Target=right>CSF(LP)</a> </li>
				<li><a href='s29.jsp'Target=right>Histopathology</a> </li>
			</UL>
</B></FONT>
</TABLE>

</BODY>
</HTML>
