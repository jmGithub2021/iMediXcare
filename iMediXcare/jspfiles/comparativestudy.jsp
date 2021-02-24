<%@page language="java" import="imedix.rcGenOperations,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	rcGenOperations rcGenOp = new rcGenOperations(request.getRealPath("/"));
	cook cookx = new cook();
	String pid = cookx.getCookieValue("patid", request.getCookies());
	String repid = request.getParameter("rid");
	String dat = myDate.getCurrentDateMySql();
	//out.println(pid);
	//out.println(repid);
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
</head>
<body>
<div class="container">
<div class="row">
<div class="col-sm-12">
<%
	try{
		String output=rcGenOp.compStudy(pid,repid);
		String output1=output.replaceAll("<table","<div class='table-responsive'><table class='table table-bordered table-hover'");
		String output2=output1.replaceAll("/table>","/table></div>");
		String output3=output2.replaceAll("size ='5'","size=+5");
		out.println(output2);
	}catch(Exception e){
		out.println(e);
	}
%>

</div>		<!-- "col-sm-12" -->
</div>		<!-- "row" -->
</div>		<!-- "container" -->
</body>
</html>
