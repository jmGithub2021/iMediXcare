<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",cdat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	String patdis=cookx.getCookieValue("patdis", request.getCookies());
	String ty = request.getParameter("ty");
	String fsl=request.getParameter("sl");
	String dt1 = request.getParameter("dt");	
	if(ty==null) ty="";
	cdat = myDate.getCurrentDateMySql();
%>

<html >
<head >

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<title> Prescription </title>

<SCRIPT LANGUAGE="JavaScript">
	
	function PrintDoc(text){
	text=document
	print(text)
	}

	function showselected()
	{
	var val=document.frm.abc.value;
	var tar;
	tar="medication.jsp?"+val;
	//alert(tar);
	window.location=tar;

}
</script>
<link rel="stylesheet" type="text/css" href="../style/style2.css">
</head >
<body>
<div class="container-fluid">
<TABLE class='tablea table'>
<TR>
	<TD><A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
		<IMG class="img-responsive" SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >&nbsp;Print this Document&nbsp;</A>
	</TD>
</TR>
</TABLE>

<TABLE width=100%>
<TR>
	
	 
<%
	try{
		String output="";
		out.println("<TD><center><span style='color:red;font-weight:bold' align=center> Medicines</span></center><br>");
		output=rcDd.getGenPrescriptionforMedication(id,"","");
		String output1=output.replaceAll("<table","<table class='table'");
		out.println(output1);


		out.println("</TD></tr>");
		out.println("<tr><TD valign='top'><center><span style='color:red;font-weight:bold' align=center>Drug Allergy</span></center><br>");
		String output2=rcDd.getDrugAllergySummary(id).replaceAll("<table","<table class='table'");
		out.println(output2+ "</TD>");

	}catch(Exception e){
		out.println(e);
	}
%>
</TR>
</TABLE>

</div>
</body>
</html >
