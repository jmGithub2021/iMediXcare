<%@page contentType="text/html" import="imedix.rcUserInfo,imedix.rcCentreInfo, imedix.dataobj, imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*" %>

<%@ include file="..//includes/chkcook.jsp" %>
<%
cook cookx = new cook();
String id = cookx.getCookieValue("patid", request.getCookies());
%>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<title>Set Appointment Date</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/chdateformat.js">
</script>

<script Language="JavaScript">
function chcur(adt)
{
var cur=new Date();
var apdt=new Date();
var appdt=document.frmapp.editdate.value;

var dd1=appdt.substring(0,2);
apdt.setDate(dd1);
var mm1=appdt.substring(3,5);
apdt.setMonth(mm1-1);
var yy1=appdt.substring(6,10);
apdt.setFullYear(yy1);
//alert(apdt);
if (apdt < cur)
{
alert("The Given Date should be greater then Current Date");
return false;
} 
return true;
}


function chformat(app)
{
var bool1=isDate(app,'dd/mm/yyyy');
if(bool1==false)
{
alert("Invalid Date Format, Please type valid date in (dd/mm/yyyy) format");
return false;
}
return true;
}

function chdt()
{
var dt=document.frmapp.editdate.value;
if(!chformat(dt))
{ return false; }

if(!chcur(dt))
{ return false; } 
return true;
} 

</script>

<style>
.table{
	background-color:#F0FFF0;
	}
</style>

</head>
<body background="../images/txture5.jpg">

<div class="container-fluid">

<BR><BR><CENTER><font color=ROYALBLUE size=+2> Edit Appointment Date </font></CENTER><BR><BR>
</FONT>

<div class="row">

<div class="col-lg-3 col-sm-2"></div>

<div class="col-lg-6 col-sm-8">
<FORM METHOD=POST NAME="frmapp" ACTION="editappsave.jsp" onSubmit='return chdt();' >
<div class="table-responsive">
<TABLE class="table" border="2" bordercolor="DARKGREEN">
    <tr>
      <td ><B>PatID</B></td>
      <td ><%=id%>&nbsp;</td>
    </tr>
<TR>
	<TD ><B>Edit Date</B></TD>
	<TD>
	<INPUT TYPE="hidden" NAME="pat_id" Value="<%=id%>">
	<INPUT class="form-control" TYPE="text" NAME="editdate" placeholder="dd/mm/yyyy"></TD>
</TR>
</TABLE>
<center><INPUT class="btn btn-default" TYPE="submit" Value="Update"></center>
</FORM>
</div>		<!-- "table-responsive" -->

</div>		<!-- "col-lg-6 col-sm-8" -->

<div class="col-lg-3 col-sm-2"></div>

</div>		<!-- "row" -->

</div>		<!-- "container-fluid" -->
</body>
</html>
