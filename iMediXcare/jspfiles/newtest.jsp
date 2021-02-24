<%@page contentType="text/html" import="imedix.rcnewUtils,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*" %>
<HTML>
<HEAD>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/jquery.dataTables.min.js"></script>
	<script src="../bootstrap/dataTables.bootstrap.min.js"></script>
	
</HEAD>

<BODY background="../images/txture.jpg">
<BR><BR><BR><BR><BR>
<center>
<font color=#2C432D>
<h2>
	<div class="col-md-10">
	<table class="table table-bordered table-striped" name="patbl" id="patbl">
	<thead>
	<tr><td>#</td><td>ID</td><td>Disease</td></tr>
	</thead>
	<tbody>
	<%
	/*
	String ccode="",cname;
	String path = request.getRealPath("/");
	cook cookx = new cook();
	ccode = cookx.getCookieValue("center", request.getCookies ());
	cname = cookx.getCookieValue("centername", request.getCookies ());
	cname = cname.substring(0,cname.lastIndexOf(" "));
	String str= "<I>WELCOME TO "+cname+" Telemedicine <br> Online Center </I>";
	out.println(str.toUpperCase());
	*/
	rcnewUtils rcnu=new rcnewUtils(request.getRealPath("/"));
		
	String str1 = rcnu.getHWString("d durga prasad");
	Object res="";
	res=rcnu.getTelePatQ("ASDH");	
	
	Vector tmp = (Vector)res;
	for(int i=0;i<tmp.size();i++) 
	{
		dataobj record = (dataobj) tmp.get(i);
		out.println ( "<tr><td>"+ i + "</td><td>" + record.getValue("pat_id") + "</td><td>" + record.getValue("discategory") + "</td></tr>");
	}
	%>
	</tbody>
	<tfoot>
	<tr><td>#</td><td>ID</td><td>Disease</td></tr>
	</tfoot>
	</table>
	</div>
	<%
	//out.println("Test: " + str1);
	%>
</h2>
</body>
<SCRIPT language="JavaScript" type="text/javascript">
$(document).ready(function() {
		$("#patbl").dataTable({
			 "lengthMenu": [[5,10,-1], [5,10,"All"]],
			 "info":     false
		});
	});
</SCRIPT>

