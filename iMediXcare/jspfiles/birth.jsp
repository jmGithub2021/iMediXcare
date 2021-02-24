<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*,imedix.rcGenOperations" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id,dat="",cen="";
	String output="";

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
	<script src="../bootstrap/js/bootstrap.js"></script>

<title>Birth History</title>
<link rel="stylesheet" type="text/css" href="../style/style2.css">
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.jsp">
var putdate,putmonth,putyear;
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
function datentry(){
dateentry();
document.a22.entrydate.value=putdate+putmonth+putyear;
}


</SCRIPT>

<style>

input[type="radio"], input[type="checkbox"]{
	width: 30px;
    float: right;
    margin: 0;
    height: 25px;
	}

</style>

</HEAD>
<BODY onload='datentry();'>

<div class="container">

<FORM role="form" METHOD="post" ACTION="../jspfiles/savefrm.jsp" name="a22">
<INPUT TYPE="hidden" name="frmnam" value="a22" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">

<CENTER>

<TABLE align=center class='tableb table'>
<TR><TD>

<FIELDSET >
<LEGEND><FONT COLOR="Green"><STRONG>Birth History</STRONG></FONT></LEGEND>
<TABLE align=center class="table table-bordered">
<TR>

<TD><LABEL><SPAN style="color : #6633FF;">Gestation</SPAN></LABEL></TD>
<TD> <%=phivde.genSelectBox("Gestation", "term", "").replaceAll("STYLE","class='form-control'")%></TD>
</tr>
<tr>
<TD><LABEL><SPAN style="color : #6633FF;">Delivery</SPAN></LABEL></TD>
<TD><%=phivde.genSelectBox("delivery", "delivery", "").replaceAll("STYLE","class='form-control'")%></TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Birth Weight</SPAN></LABEL></TD>
<TD><INPUT class="form-control" NAME="weight" placeholder=" gms" maxlength=5 onblur='if (checkint(this.value) == false) {this.select();}'/></TD>
</TR>
</TABLE>
</FIELDSET>

<FIELDSET >
<LEGEND><FONT COLOR="Green" ><STRONG>Maternal PMTCT</STRONG></FONT></LEGEND>
<TABLE align=center class="table table-bordered">
<TR>
<TD><LABEL><SPAN style="color : #6633FF;">Antenatal</SPAN></LABEL></TD>
<TD> <%=phivde.genSelectBox("pmtct_ante", "mat_ante", "").replaceAll("STYLE","class='form-control'")%></TD>
</tr>
<tr>
<TD><LABEL><SPAN style="color : #6633FF;">Duration</SPAN></LABEL></TD>
<TD> <%=phivde.genSelectBox("pmtct_ante_duration", "mat_duration", "").replaceAll("STYLE","class='form-control'")%></TD>
</TR>

<TR>
<TD><LABEL><SPAN style="color : #6633FF;">IntraPartum</SPAN></LABEL></TD>
<TD> <%=phivde.genSelectBox("pmtct_intra", "mat_partum", "").replaceAll("STYLE","class='form-control'")%></TD>
</TR>
</TABLE>
</FIELDSET>

<FIELDSET>
<LEGEND><FONT COLOR="Green" ><STRONG>Neonatal PMTCT</STRONG></FONT></LEGEND>
<TABLE align=center class="table">
<TR>
<TD><LABEL style="color : #6633FF;">Single Dose NVP</LABEL></TD><TD><INPUT name="dose" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked>
<INPUT class="form-control input-sm" TYPE="checkbox" NAME="dose" value="Yes"></TD>
</TR>
<TR>
<TD><LABEL style="color : #6633FF;">Neonatal ARV</LABEL></TD>
<TD><LABEL>Zidovudine</LABEL><INPUT class="form-control input-sm" TYPE="radio" NAME="arv" value="Zidovudine"/></TD>
<TD><LABEL>ZDV + 3TC </LABEL><INPUT class="form-control input-sm" TYPE="radio" NAME="arv" value="ZDV + 3TC "/>
<INPUT TYPE="radio" name="arv"  style="position:absolute;display:none;" value="" /checked></TD>
</TR>
<TR>
<TD><LABEL style="color : #6633FF;">Duration</LABEL></TD>
<TD><LABEL>One Week</LABEL><INPUT class="form-control input-sm" TYPE="radio" NAME="duration" value="One Week"/></TD>
<TD><LABEL>Two Week</LABEL><INPUT class="form-control input-sm" TYPE="radio" NAME="duration" value="Two Week"/>
<INPUT TYPE="radio" name="duration"  style="position:absolute;display:none;" value="" / checked></TD>
 
<TD><INPUT type=hidden name=entrydate></TD>
</TR>
</TABLE>
</FIELDSET><br>
<TABLE align=center class="table">
<TR>
<TD>
<div class="input-group">
<span class="input-group-addon">Test date</span>
<INPUT class="form-control" NAME="testdate"  value=<%=dat%> maxlength=8></INPUT>
</div>		<!-- "input-group" -->
</TD>
<TD><INPUT class="btn btn-primary" TYPE="submit" value="submit" onclick="return testdt(document.a22.testdate.value,'<%=dat%>')" /></TD>
</TR>
</TABLE>
</TD>
</TR>
</TABLE>
</form>


</div>		<!-- "container" -->
</body>
</html>
