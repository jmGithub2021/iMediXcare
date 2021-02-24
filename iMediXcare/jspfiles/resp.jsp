<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*,imedix.rcGenOperations" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id,dat="",cen="";
	rcGenOperations phivde = new rcGenOperations(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	cen = cookx.getCookieValue("center",request.getCookies());
	//out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + id + "</B></FONT><BR>");
	dat = myDate.getCurrentDate("dmy",false);
	
%>


<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


<title>Genotype</title>
<link rel="stylesheet" type="text/css" href="../style/style2.css">

<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.jsp">
	var putdate,putmonth;
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">

function ShowHide(id)
{
	var el=document.getElementById(id);
	if (el.style.display=="none")
		el.style.display="block";
	else 		el.style.display="none";

}

function datentry(){
endt=new Date();
dd=endt.getDate();
mm=endt.getMonth()+1;
if(dd<10)
  putdate=('0'+dd.toString())
else
  putdate=dd.toString()

if(mm<10)
  putmonth=('0'+mm.toString())
else
  putmonth=mm.toString()
yy=endt.getYear();
if(yy >= 2000)
  {
    yy = yy;
  }
  else if(yy >= 100)
  {
    yy += 1900;
  }

document.a19.entrydate.value=putdate+putmonth+yy.toString()
}

</SCRIPT>

<script>
$(document).ready(function(){
    $('[data-toggle="popover"]').popover({ 
    title:"Kyphosis",
    content:"<INPUT name='kyphosis' TYPE='checkbox' style='position:absolute;display:none;' value='' / checked><INPUT TYPE='checkbox' NAME='kyphosis' value='Present' /><LABEL> Present</LABEL>",
	html:true,
}); 
});
</script>

<style>
form{background-color:#E2E6E5;}
table tr{background-color:#D7DCDB;}

input[type="radio"], input[type="checkbox"]{
	width: 22px;
	margin:auto;
    height: 20px;
	}
	label{padding:0 10px;}
</style>

</HEAD>
<BODY onload='datentry();'>

<div class="container-fluid">

<FORM role="form" METHOD="post" ACTION="../jspfiles/savefrm.jsp" name="a19">
<INPUT TYPE="hidden" name="frmnam" value="a19" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">

<CENTER>
<LABEL><FONT size="5" Color="red"><STRONG>Respiratory System</STRONG></FONT></LABEL></CENTER>







<FONT COLOR="Green" size="4"><STRONG>Observations</STRONG></FONT>
<div class="table-responsive">
<TABLE class="table  table-bordered table-hover">
<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Effort</SPAN></LABEL></TD>
<TD><INPUT name="effort" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked>
<INPUT TYPE="checkbox" NAME="effort" value="Accessory muscles" /><LABEL>Accessory<BR>&nbsp&nbsp&nbsp muscles</LABEL></TD>
<TD><INPUT TYPE="checkbox" NAME="effort" value ="Intercostal recession" /><LABEL>Intercostal<BR>&nbsp&nbsp&nbsp recession</LABEL>
<INPUT TYPE="radio" name="effort"  style="position:absolute;display:none;" value="" / checked>
</TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Scoliosis</SPAN></LABEL></TD>
<TD><INPUT TYPE="radio" NAME="scoliosis" VALUE="Right"><LABEL>Right</LABEL></TD>
<TD><INPUT TYPE="radio" NAME="scoliosis" VALUE="Left"><LABEL>Left</LABEL>
<a class="pull-right" href="#" data-toggle="popover" data-placement="top" >Kyphosis</a>
<INPUT TYPE="radio" name="scoliosis"  style="position:absolute;display:none;" value="" / checked></TD> 
<!--<TD><LABEL><SPAN style="color : #6633FF;">Kyphosis</SPAN></LABEL></TD>
<TD><INPUT name="kyphosis" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="kyphosis" value="Present" /><LABEL>Present</LABEL></TD>-->
</TR>
<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Flattening</SPAN></LABEL></TD>
<TD><INPUT TYPE="radio" NAME="flat" VALUE="Right"><LABEL>Right</LABEL></TD>
<TD><INPUT TYPE="radio" NAME="flat" VALUE="Left"><LABEL>Left</LABEL>
<INPUT TYPE="radio" name="flat"  style="position:absolute;display:none;" value="" / checked>
</TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Expansion asymmetry</SPAN></LABEL></TD>
<TD><INPUT TYPE="radio" NAME="expand" VALUE="Right"><LABEL>Right</LABEL></TD>
<TD><INPUT TYPE="radio" NAME="expand" VALUE="Left" ><LABEL>Left</LABEL>
<INPUT TYPE="radio" name="expand"  style="position:absolute;display:none;" value="" / checked>
</TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Mediastinal Shift</SPAN></LABEL></TD>
<TD><INPUT TYPE="radio" NAME="shift" VALUE="Right"><LABEL>Right</LABEL></TD>
<TD><INPUT TYPE="radio" NAME="shift" VALUE="Left"><LABEL>Left</LABEL>
<INPUT TYPE="radio" name="shift"  style="position:absolute;display:none;" value="" / checked>
</TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Tenderness</SPAN></LABEL></TD>
<TD><INPUT name="tender" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="tender" VALUE="Right"><LABEL>Right</LABEL></TD>
<TD><INPUT TYPE="checkbox" NAME="tender" VALUE="Left"><LABEL>Left</LABEL></TD>
</TR>
</TABLE>
</div>		<!-- "table-responsive" -->



<div class="row"><center><FONT COLOR="Green" size="4"><STRONG>Findings .1.</STRONG></FONT></center>
<div class="col-sm-6">

<div class="input-group">
<span class="input-group-addon">Percussion Note</span>
<%=phivde.genSelectBox("note","note1", "").replaceAll("STYLE","class='form-control'") %>
</div>

<div class="input-group">
<span class="input-group-addon">Adventitious Sound</span>
<%=phivde.genSelectBox("extrasound_resp","extra1", "").replaceAll("STYLE","class='form-control'") %>
</div>

<div class="input-group">
<span class="input-group-addon">Region <BR/>Multiple Choice </span>
<%=phivde.genSelectBox("resp_area","loc1", "").replaceAll("STYLE","class='form-control'") %>
</div>

</div>		<!-- "col-sm-6" -->

<div class="col-sm-6">

<div class="input-group">
<span class="input-group-addon">Breath Sound</span>
<%=phivde.genSelectBox("breathsound","sound1", "").replaceAll("STYLE","class='form-control'") %>
</div><br/>

<div class="input-group">
<span class="input-group-addon">Vocal Resonance</span>
 <%=phivde.genSelectBox("vr","vr1", "").replaceAll("STYLE","class='form-control'") %> 
</div>

</div>		<!-- "col-sm-6" -->
</div>		<!-- "row" -->


<P onclick="ShowHide('respmore');"><strong>Click here for More Respiratory auscultation/percussion observations</strong></P>

<FIELDSET id="respmore" style='display:none'>

<div class="row"><center><FONT COLOR="Green" size="4"><STRONG>Findings .2.</STRONG></FONT></center>
<div class="col-sm-6">

<div class="input-group">
<span class="input-group-addon">Percussion Note</span>
<%=phivde.genSelectBox("note","note1", "").replaceAll("STYLE","class='form-control'") %>
</div>

<div class="input-group">
<span class="input-group-addon">Adventitious Sound</span>
<%=phivde.genSelectBox("extrasound_resp","extra1", "").replaceAll("STYLE","class='form-control'") %>
</div>

<div class="input-group">
<span class="input-group-addon">Region <BR/>Multiple Choice </span>
<%=phivde.genSelectBox("resp_area","loc1", "").replaceAll("STYLE","class='form-control'") %>
</div>

</div>		<!-- "col-sm-6" -->

<div class="col-sm-6">

<div class="input-group">
<span class="input-group-addon">Breath Sound</span>
<%=phivde.genSelectBox("breathsound","sound1", "").replaceAll("STYLE","class='form-control'") %>
</div><br/>

<div class="input-group">
<span class="input-group-addon">Vocal Resonance</span>
 <%=phivde.genSelectBox("vr","vr1", "").replaceAll("STYLE","class='form-control'") %> 
</div>

</div>		<!-- "col-sm-6" -->
</div>		<!-- "row" -->

</FIELDSET>


<INPUT type=hidden name=entrydate>
<div class="table-responsive">
<table class="table">
<tr><td>
<div class="input-group">
<span class="input-group-addon">Test date</span>
<INPUT class="form-control" NAME="testdate"  value=<%=dat%> size=8 maxlength=8></INPUT>
</div>		<!-- "input-group" -->
</td>
<td>
<INPUT class="btn btn-default" TYPE="submit" value="submit" onclick="return testdt(document.a19.testdate.value,'<%=dat%>')" />
</td></tr>
</table>
</div>		<!-- "table-responsive" -->
</FORM>

</div>		<!-- "container-fluid" -->
</body>
</html>
