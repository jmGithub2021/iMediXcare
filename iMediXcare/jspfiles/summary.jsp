<%@page contentType="text/html"  import="imedix.rcDisplayData,imedix.dataobj,imedix.rcCentreInfo,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


<TITLE> Summary </TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
function PrintDoc(text)
{
text = document
print(text)
}
//-->
</SCRIPT>

<style>
table.table tr:hover
{
background-color:#D3DDDF;	
}
</style>

</HEAD>
<link rel="stylesheet" type="text/css" href="../style/style2.css">


<BODY onLoad="document.getElementById('siteLoader').style.display = 'none';">
<div class="container-fluid">

<div class="row">
<div class="col-lg-8">
<div id='siteLoader'>
	 <H3><CENTER><BR>
	 	 <FONT COLOR="#00CCCC">......Please Wait......</FONT><BR><BR>
		 <IMG class="img-responsive" SRC="../images/loading.gif" WIDTH="100" HEIGHT="20" BORDER="0" ALT="" bordercolor=RED><BR>
	 </CENTER>
	 </H3>
</div>

<A HREF="#" onclick = 'PrintDoc();' Border=0 Style='color:RED; font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="../images/printer.gif" WIDTH="35" HEIGHT="33" BORDER=0 ALT="PrintThis">&nbsp;&nbsp;Print This Document
</A>
<%	
	String dt="", pdt="";
	cook cookx = new cook();
	//String id = request.getParameter("id");
	String id = cookx.getCookieValue("patid", request.getCookies ());
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	rcCentreInfo cnfo  = new rcCentreInfo(request.getRealPath("/"));
	String centerCode = cnfo.getCenterCode(id,"med");
	Vector alldata= (Vector)ddinfo.viewSummary(id,centerCode);  
	Object res=null;

	try{
	res = (Object)alldata.get(0);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{

		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);
%>
<CENTER>
<TABLE class="table">
<TR>
<TD Align=Center><B>
	<FONT SIZE="5pt" COLOR="#330099"> <%= datatemp.getValue("name")	%></FONT><BR>
	<FONT SIZE=2pt COLOR="">PHONE&nbsp;:&nbsp;<FONT SIZE=2pt COLOR=""> <%= datatemp.getValue("phone") %> </FONT></FONT></B>
</TD>
</TR>
<TR>
<TD Align=Center>
<FONT SIZE=5pt COLOR="#330099"><B>Patient's  List of Submitted Reports</FONT></B><BR>
<FONT COLOR="#330099"><B>
<% 
	}
	Date date = new Date();
    out.println("Report Generated on "+date.toString()+"<BR>");

	}catch(Exception e){
		out.println(" Error 1"+e.toString());
	}

%>
</B>
</Font>
</TD>
</TR>
</TABLE>
<TABLE class="table" BorderColor="BLUE">
<TR><TD>
<TABLE class="table">
<TR>
<TD><FONT SIZE="4px" COLOR="MAROON">Personal Data</FONT><BR></TD>
</TR>
<TR>
<TD>
<%	
	String mm="",dd="";
	int m=0,d=0;

	try 
	{
	   out.println("<TABLE class='table table-bordered table-hover'>");
		res = (Object)alldata.get(1);
		if(res instanceof String){ 
			out.println("Record Not Found :"+res + "<br>");
		}
		else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

			out.println("<TR><TD><B>Patient ID</B></TD><TD><B>:</B></TD><TD><B>" + id.toUpperCase() +"</B></TD></TR>");
			String name = datatemp.getValue("pre") +". " + datatemp.getValue("pat_name")+" " +datatemp.getValue("m_name")+" " +datatemp.getValue("l_name") ; 

			out.println("<TR><TD><B>Patient Name</B></TD><TD><B>:</B></TD><TD><B>" + name + "</B></TD></TR>");

			String dis = datatemp.getValue("class");
			if (dis==null) dis = "Not Known";
			out.println("<TR><TD><B>Disease Type</B></TD><TD><B>:</B></TD><TD><B>" + dis + "</B></TD></TR>");
			pdt = datatemp.getValue("entrydate");
			dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			out.println("<TR><TD><B>Registration Date</B></TD><TD><B>:</B></TD><TD><B>"+dt+" &nbsp;&nbsp;(DD-MM-YYYY)</B></TD></TR>");
			
			res = (Object)alldata.get(2);
			
			Vtmp = (Vector)res;
			datatemp = (dataobj) Vtmp.get(0);
			pdt = datatemp.getValue("appdate").trim();

			if(pdt.equals("")){
				out.println("<TR><TD><B>Appointment Date</B></TD><TD><B>:</B></TD><TD><B>----------- &nbsp;&nbsp;(DD-MM-YYYY)</B></TD></TR></TABLE>");
			}
			else{
			dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			out.println("<TR><TD><B>Appointment Date</B></TD><TD><B>:</B></TD><TD><B>"+dt+" &nbsp;&nbsp;(DD-MM-YYYY)</B></TD></TR></TABLE>");
			}

		}

	}
	catch(Exception e)
	{
		out.println(e.toString());
	}

%>
</TD>
</TR>
<TR>
<TD><FONT SIZE="4px" COLOR="MAROON">Medical Records</FONT><BR></TD>
</TR>
<TR>
<TD>
<% 
	out.println("<TABLE class='table table-bordered table-hover'>");

	res = (Object)alldata.get(3);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Forms</B></TD><TD> <B>:</B></TD><TD><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}
//------------
	res = (Object)alldata.get(4);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Prescriptions </B></TD><TD> <B>:</B></TD><TD><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}
//------------
	res = (Object)alldata.get(5);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Images</B></TD><TD> <B>:</B></TD><TD Width=300><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}

	//-------------
	res = (Object)alldata.get(6);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Referred Images</B></TD><TD> <B>:</B></TD><TD><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}

//-------------
	res = (Object)alldata.get(7);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Documents</B></TD><TD> <B>:</B></TD><TD><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}


//-------------
	res = (Object)alldata.get(8);
	if(res instanceof String){ 
		out.println("Record Not Found :"+res + "<br>");
	}
	else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);

		out.println("<TR><TD><B>Video</B></TD><TD> <B>:</B></TD><TD Width=300><B>" + datatemp.getValue("total") +"</B></TD></TR>");
	}

%>
</TD>
</TR>
</TABLE>
</TD></TR></TABLE>
</CENTER>
</div><!-- "col-lg-8" -->

</div>	<!-- "row" -->
</div>		<!-- "container-fluid" -->
</BODY>
</HTML>
