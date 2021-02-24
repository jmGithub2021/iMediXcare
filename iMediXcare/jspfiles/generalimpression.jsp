<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<title>generalImpression</title>
<SCRIPT LANGUAGE="JavaScript">
	<!-- Begin
	function PrintDoc(text){
	text=document
	print(text)
}
</script>

</head>
<body>
<div class="container">
<%
	String id="",dat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	try{
		String output=rcDd.getImpression(id);
		String output1=output.replaceAll("<TABLE","<table class='table'");
		String output2=output1.replaceAll("&nbsp;","");
		String output3=output2.replaceAll("<A","<a class='btn btn-primary'");
		out.println(output3);
	}catch(Exception e){
		out.println(e);
	}
%>
</div>		<!-- "container" -->
</body>
</html>
