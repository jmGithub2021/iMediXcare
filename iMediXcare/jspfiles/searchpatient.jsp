<%@page contentType="text/html"%> 
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>

<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>

<body bgcolor="white">
<div class="container-fluid">
<div class="row">
<div class="col-sm-2"></div>
<div class="col-sm-8"><br>
<div class="well">
<center><font color=sapia size=+2>Search Patient </font>
<img class="img-responsive" src="../images/divider2.gif" width="505" height="25"></br>
<a class="btn btn-info btn-block" href="localpatientsearch.jsp"><h4>Local Patient</h4></a></br>
<A class="btn btn-info btn-block" href="telepatientsearch.jsp"><h4>Tele Patient</h4></A></center>
</div>		<!-- "well" -->
<center><img class="img-responsive" src="../images/telemedicine.gif" width="180" height="176" /></center>


</div>		<!-- "col-sm-8" -->
<div class="col-sm-2"></div>
</div>		<!-- "row" -->
</div>		<!-- "container" -->

</BODY>
</HTML>
