<%@page contentType="text/html" import="imedix.rcPatqueueInfo,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
cook cookx = new cook();
String ccode= cookx.getCookieValue("center", request.getCookies ());
%>
<HTML>
<HEAD>



<TITLE>THE OLD PATIENT's FORM....
</TITLE>
<Style>
SELECT {
	font: courier
	}

</Style>

<SCRIPT LANGUAGE="JavaScript">
<!--
function SetVal()
{
	//alert(document.old.idMore.options[document.old.idMore.selectedIndex].value);
	document.old.id.value = document.old.idMore.options[document.old.idMore.selectedIndex].value;
}
//-->
</SCRIPT>
</HEAD>
<BODY background="../images/txture.jpg"><CENTER>
<div>
<FORM  role="form" ACTION="oldpatid.jsp" method=get name=old>
<br><CENTER><FONT SIZE="5pt" COLOR="#333399"><B>Add or Modify old Patient's Data</B></FONT></CENTER>
<br><br>
<TABLE class="table well">
  <INPUT class="form-control" TYPE="hidden" name="frmnam" value="oldpat">
  <TR>
    <TD ><h3><strong>Enter Patient ID:</strong></h3> <BR>
	<INPUT class="form-control" name="id" placeholder="Patient Id; Ex: EXTR2912150003">
    </TD>
	
  </TR>
<BR>
<TR><TD><br><input class="form-control btn-primary" type="submit" value="Submit"><br>
  <input class="form-control btn-primary" type="reset" value="Reset" >
  </p>
</td>  </tr>
</TABLE></FORM></div>
<BR>
<!--<b><font color="#FF0000" size="4"><a href="localpatientsearch.jsp?cb=oldpat"> Search and Add to Patient Queue</a></font></b>-->

</CENTER>
</BODY>
</HTML>
