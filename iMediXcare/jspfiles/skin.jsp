 <!--  dataGeneralLocation = dataentryform.dataforGeneral("lesion_loc", "location", "loc", utype); -->
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

document.a18.entrydate.value=putdate+putmonth+yy.toString()
}

</SCRIPT>

<style>
table tr td{background-color:#F0F4F4;}
table tr td:hover{background-color:#E6ECEB;}
</style>

</HEAD>
<BODY onload='datentry();'>


<FORM role="form" METHOD="post" ACTION="../jspfiles/savefrm.jsp" name="a18">
<INPUT TYPE="hidden" name="frmnam" value="a18" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">

<FIELDSET class='tableb'>
	<LEGEND><FONT size="4" Color="red"><STRONG>Skin Mucosa Examination</STRONG></FONT></LEGEND>
	<TABLE align=center class="table">
	<TR><TD>
	<TABLE class="table">
	<TR>
	<TD><LABEL><SPAN style="color : #6633FF;">Lesion<BR>(multiple choice)</SPAN></LABEL></TD>
<TD> <%=phivde.genSelectBox("lesion","lesion", "multiple").replaceAll("STYLE","class='form-control'") %> </TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Features<BR>(multiple choice)</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("lesion_feature","feature", "multiple").replaceAll("STYLE","class='form-control'") %> </TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Color</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("lesion_color","les_color", "").replaceAll("STYLE","class='form-control'") %></TD>
</TR>
<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Shape</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("lesion_shape","les_shape", "").replaceAll("STYLE","class='form-control'") %></TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Distribution</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("lesion_distribution","distribution", "").replaceAll("STYLE","class='form-control'") %></TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">General Location</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("lesion_loc","location", "").replaceAll("STYLE","class='form-control'") %></TD>
</TR>
</TABLE>
</TD></TR>
<TR><TD>
<TABLE class="table" align=center>
<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Description of the<BR> sites of lesion</SPAN></LABEL></TD>
<TD><TEXTAREA class="form-control" NAME="site" ROWS="5" COLS="45"></TEXTAREA></TD>
<TD><INPUT type=hidden name=entrydate></TD>
</TR>
</TABLE>

<TABLE class="table table-bordered" align=center>
<TR>
	<TD>
	<div class="input-group">
	<span class="input-group-addon">Test date</span>
	<INPUT class="form-control" NAME="testdate"  value=<%=dat%> maxlength=8></INPUT>
	</div>		<!-- "input-group" -->
	</TD>
	<TD><INPUT class="form-control btn btn-primary" TYPE="submit" value="submit" onclick="return testdt(document.a18.testdate.value,'<%=dat%>')" />
</TD></TR>
</TABLE>
</TD></TR>
</TABLE>
</FIELDSET>
</FORM>


</body>
</html>
