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

document.a20.entrydate.value=putdate+putmonth+yy.toString()
}

</SCRIPT>

<style>
form{background-color:#F0F4F4;}

input[type="radio"], input[type="checkbox"]{
	width: 20px;
	margin:auto;
    height: 18px;
	}
</style>

</HEAD>
<BODY onload='datentry();'>

<div class="container-fluid">

<FORM role="form" METHOD="post" ACTION="../jspfiles/savefrm.jsp" name="a20">
<INPUT TYPE="hidden" name="frmnam" value="a20" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">



 <CENTER><LABEL><FONT size="5" Color="red"><STRONG>Abdominal System</STRONG></FONT></LABEL></CENTER>
  
<div class="table-responsive">
    <TABLE class='tableb table table-hover' align=center cellpadding="5" cellspacing="5">
    <TR>
    <TD><LABEL style="color : #6633FF;">Abdo Fullness</LABEL><INPUT TYPE="checkbox" NAME="abdo" value="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Visible Veins</LABEL><INPUT TYPE="checkbox" NAME="veins" value="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Visible Pulsation</LABEL><INPUT TYPE="checkbox" NAME="pulsation" value ="Yes"></TD>
	</TR>
	<TR>
	<TD><LABEL style="color : #6633FF;">Tenderness</LABEL></TD>
	<TD colspan=2> <%=phivde.genSelectBox("tender_loc","tender_loc", "").replaceAll("STYLE","class='form-control'") %></TD>
</TR>
</TABLE>
</div>		<!-- "table-responsive" -->







	<LEGEND><FONT color="Green"><STRONG>Hepatomegaly</STRONG></FONT></LEGEND>
	<div class="table-responsive">
	<TABLE class='tableb table table-hover'>
	<TR>
	<TD>
	<div class="input-group">
	<SPAN class="input-group-addon" style="color : #cc0099;">Subcostal Length</SPAN>
	<%=phivde.genSelectBox("liver_length","liver_length","").replaceAll("STYLE","class='form-control'") %> 
	</div>		<!-- "input-group" -->
	
	</TD>
	<TD>
	<div class="input-group">
	<SPAN class="input-group-addon" style="color : #cc0099;">Upper Border</SPAN>
	<%=phivde.genSelectBox("liver_border","liver_border","").replaceAll("STYLE","class='form-control'") %> 
	</div>		<!-- "input-group" -->
	</TD>
	</TR>
	<TR>
	<TD><LABEL style="color : #6633FF;">Soft</LABEL><INPUT TYPE="radio" NAME="hepatomegaly" value="Soft"/></TD>
	<TD><LABEL style="color : #6633FF;">Firm</LABEL><INPUT TYPE="radio" NAME="hepatomegaly" value ="Firm"></TD>
	<TD ><LABEL style="color : #6633FF;">Hard</LABEL><INPUT TYPE="radio" NAME="hepatomegaly" value ="Hard">
	<INPUT TYPE="radio" name="hepatomegaly"  style="position:absolute;display:none;" value="" / checked></TD>
	</TR>
	<TR>
	<TD><LABEL style="color : #6633FF;">Nodular Surface</LABEL><INPUT TYPE="radio" NAME="hepa_surface" value ="Nodular Surface"/ ></TD>
	<TD><LABEL style="color : #6633FF;">Irregular Surface</LABEL><INPUT TYPE="radio" NAME="hepa_surface" value ="Irregular Surface">
	<INPUT TYPE="radio" name="hepa_surface"  style="position:absolute;display:none;" value="" / checked></TD>
	<TD ><LABEL style="color : #6633FF;">Tenderness</LABEL><INPUT name="hepa_tenderness" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="hepa_tenderness" value="Yes"></TD>
	</TR>
	</TABLE>
</div>		<!-- "table-responsive" -->


	<LEGEND><FONT color="Green"><STRONG>Splenomegaly</STRONG></FONT></LEGEND>
		<div class="table-responsive">
	<TABLE class='tableb table table-hover'>
	<TR>
		<TD><LABEL><SPAN style="color : #cc0099;">Subcostal Length</SPAN></LABEL></TD>
		<TD> <%=phivde.genSelectBox("spleen_length","spleen_length","").replaceAll("STYLE","class='form-control'") %> </TD>
		<TD><LABEL style="color : #6633FF;">Tenderness</LABEL><INPUT name="spln_tenderness" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="spln_tenderness"></TD>
	</TR>
	<TR>	
	    <TD><LABEL style="color : #6633FF;">Soft</LABEL><INPUT TYPE="radio" NAME="splenomegaly" value="Soft"/></TD>
	    <TD><LABEL style="color : #6633FF;">Firm</LABEL><INPUT TYPE="radio" NAME="splenomegaly" value ="Firm"/></TD>
	    <TD><LABEL style="color : #6633FF;">Hard</LABEL><INPUT TYPE="radio" NAME="splenomegaly" value ="Hard"/>
	    <INPUT TYPE="radio" name="splenomegaly"  style="position:absolute;display:none;" value="" / checked></TD>
	
	</TR>
	</TABLE>
</div>		<!-- "table-responsive" -->

<FIELDSET >
<div class="table-responsive">
	<TABLE class="table table-bordered">
	<TR>
	<TD><LABEL style="color : #6633FF;">Shifting Dullness</LABEL><INPUT name="dullness" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="dullness" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Fluid thrill</LABEL><INPUT name="fluid" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="fluid" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">No Bowelsound</LABEL><INPUT name="bowelsound" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="bowelsound" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Borborygmi</LABEL><INPUT name="borborygmi" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="borborygmi" value ="Yes"></TD>
	</TR>
    </TABLE>
    </div>		<!-- "table-responsive" -->
</FIELDSET>
<P onclick="ShowHide('abdolump');"><strong>click here to record observation of an abdomen lump</strong></P>

<div class="table-responsive">
<FIELDSET id='abdolump' style='display:none'>
	<LEGEND><FONT color="Green"><STRONG>Palpable Lump</STRONG></FONT></LEGEND>
	<TABLE class="table">
	<TR>	
	<TD><LABEL><SPAN style="color : #cc0099;">Longitudinal</SPAN></LABEL></TD>
	<TD> <%=phivde.genSelectBox("lump_length","lump_length","").replaceAll("STYLE","class='form-control'") %> </TD>
	
	<TD><LABEL><SPAN style="color : #cc0099;">Lateral Dimension </SPAN></LABEL></TD>
	<TD>  <%=phivde.genSelectBox("lump_width","lump_width","").replaceAll("STYLE","class='form-control'") %>  </TD>
	</TR>
	</TABLE>
	
	<TABLE class="table"> 
	<TR>
	<TD><LABEL style="color : #6633FF;">Soft</LABEL></TD><TD><INPUT TYPE="radio" NAME="palpable" value="Soft"></TD>
	<TD><LABEL style="color : #6633FF;">Firm</LABEL></TD><TD><INPUT TYPE="radio" NAME="palpable" value ="Firm"></TD>
	<TD><LABEL style="color : #6633FF;">Hard</LABEL></TD><TD><INPUT TYPE="radio" NAME="palpable" value ="Hard">
	<INPUT TYPE="radio" name="palpable"  style="position:absolute;display:none;" value="" / checked></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Tender Lump</LABEL></TD><TD><INPUT name="lump" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="lump" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Irregular Surface</LABEL></TD><TD><INPUT TYPE="radio" NAME="palp_surface" value="Irregular Surface"/></TD>
	<TD><LABEL style="color : #6633FF;">Smooth Surface</LABEL></TD><TD><INPUT TYPE="radio" NAME="palp_surface" value="Smooth Surface">
	<INPUT TYPE="radio" name="palp_surface"  style="position:absolute;display:none;" value="" / checked></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Abominal wall?</LABEL></TD><TD><INPUT name="abominal" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="abominal" value ="Yes"></TD>
   	<TD><LABEL style="color : #6633FF;">Peritoneal cavity ?</LABEL></TD><TD><INPUT name="cavity" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="cavity" value="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Can Get Above?</LABEL></TD><TD><INPUT name="above" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="above" value="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Can Get Below?</LABEL></TD><TD><INPUT name="below" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="below" value ="Yes"></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Fixed</LABEL></TD><TD><INPUT name="fixed" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="fixed" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Mobile</LABEL></TD><TD><INPUT name="mobile" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="mobile" value="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Bimanual palpable</LABEL></TD><TD><INPUT name="bimanual" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="bimanual" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Pulsatile</LABEL></TD><TD><INPUT name="pulsatile" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="pulsatile" value="Yes"></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Reducible</LABEL></TD><TD><INPUT name="reducible" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="reducible" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Fluctuant</LABEL></TD><TD><INPUT name="fluctuant" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="fluctuant" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Transillumination</LABEL></TD><TD><INPUT name="transillumination" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="transillumination" value ="Yes"></TD>
	</TR>
	
	<TR>
	<TD><LABEL><SPAN style="color : #cc0099;">Likely Organ of origin</SPAN></LABEL></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Left Kidney</LABEL></TD><TD><INPUT name="left_kidney" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="left_kidney" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Right Kidney</LABEL></TD><TD><INPUT name="right_kidney" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="right_kidney" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Gall Bladder</LABEL></TD><TD><INPUT name="gall_bladder" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="gall_bladder" value ="Yes"></TD>
	</TR>
	
	<TR>
	<TD><LABEL style="color : #6633FF;">Pancreas</LABEL></TD><TD><INPUT name="pancreas" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="pancreas" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Abdominal aorta</LABEL></TD><TD><INPUT name="aorta" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="aorta" value ="Yes"></TD>
	<TD><LABEL style="color : #6633FF;">Undefined</LABEL></TD><TD><INPUT name="undefined" TYPE="checkbox" style="position:absolute;display:none;" value="" / checked><INPUT TYPE="checkbox" NAME="undefined" value ="Yes"></TD>
	</TR>
	</TABLE>
	
	<TABLE>
	<TR>
		<TD><LABEL><SPAN style="color : #cc0099;">Location</SPAN></LABEL></TD>
		<TD> <%=phivde.genSelectBox("lump_loc","lump_loc","").replaceAll("STYLE","class='form-control'") %> </TD>

		<TD><INPUT type=hidden name=entrydate></TD>
    </TR>
	</TABLE>
	</FIELDSET>
	</div>		<!-- "table-responsive" -->
	
	
   <TABLE class="table">
	<TR>
	<TD>Test date</TD><TD><INPUT class="form-control" NAME="testdate"  value=<%=dat%> size=8 maxlength=8></INPUT></TD>&nbsp;&nbsp;&nbsp;&nbsp;
	<TD><INPUT class="form-control btn btn-primary" TYPE="submit" value="submit" onclick="return testdt(document.a20.testdate.value,'<%=dat%>')" /></TD>
	</TR>
  </TABLE>
	

    </form>
    
    </div>		<!-- "container-fluid" -->
</body>
</html>
