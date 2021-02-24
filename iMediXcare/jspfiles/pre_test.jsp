<%@page contentType="text/html"  import="imedix.rcCentreInfo,imedix.rcUserInfo,imedix.rcDataEntryFrm, imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	String dat="";
	String mon="",da="";
	String present_status="";
	String   usertype="doc", docid="",currpatqtype="",ty="";
	present_status="YES";

	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));

	String id = cookx.getCookieValue("patid", request.getCookies());
	//docid = request.getParameter("docid");

	docid = cookx.getCookieValue("userid", request.getCookies ());

	currpatqtype = cookx.getCookieValue("currpatqtype", request.getCookies ());
	//out.println("Node="+isnodal);

	if(currpatqtype.equalsIgnoreCase("local")) ty="pre"; 
	else ty="prs"; 

	String qr="",sx="",ag="",ages="",astr="";
    String nam="";

	Object res=ddinfo.DisplayMed(id,"","");
	dataobj datatemp=null;
	//qr="select * from med where PAT_ID='"+id+"' and ENTRYDATE='"+dt+"' and SERNO='"+sl+"'";

	if(res instanceof String){
		out.println("Error:" + res +"<br>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			datatemp = (dataobj) tmp.get(0);
			nam=datatemp.getValue("pre") +". " + datatemp.getValue("pat_name")+" " +datatemp.getValue("m_name")+" " +datatemp.getValue("l_name") ; 
			ag = datatemp.getValue("age");
			sx = datatemp.getValue("sex");

		 }
	}
	

			

	String patage[]=ag.split(",",3);
	
    if(patage.length>1){

		if(!patage[2].equals("")) astr=patage[2].trim()+" days";
		if(!patage[1].equals("")) astr=patage[1].trim()+" months "+astr;
		if(!patage[0].equals("")) astr=patage[0].trim()+" years "+astr;
	}else astr="Unknown";

	if(sx.equalsIgnoreCase("F"))
	{
		sx = "Female";
	}
	if(sx.equalsIgnoreCase("M"))
	{
		sx = "MALE";
	}
	if(sx.equalsIgnoreCase("O"))
	{
		sx = "Other";
	}
	
	String objdoc="", a="", n="", e="", r="",p="",c_nam="",c_ph="",q="",rg_no="";

	//qr="select * from LOGIN where lower(trim(UID)) = '"+ docid +"' ";
	
	res=uinfo.getuserinfo(docid);
	
	if(res instanceof String){
		out.println("Error:" + res +"<br>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			datatemp = (dataobj) tmp.get(0);			
			a = datatemp.getValue("address");
			n = datatemp.getValue("name");
			e=datatemp.getValue("emailid");
			r=datatemp.getValue("rg_no");
			p=datatemp.getValue("phone");
			q=datatemp.getValue("qualification");
		 }
	}

	c_nam=cookx.getCookieValue("center", request.getCookies ());

/*
	 res=cinfo.getLCentreInfo();
	if(res instanceof String){
		out.println("Error:" + res +"<br>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			datatemp = (dataobj) tmp.get(0);			
			c_nam=datatemp.getValue("code");
			c_ph=datatemp.getValue("phone");
		 }
	}
*/


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
 
 <META content="text/html; charset=windows-1252" http-equiv=Content-Type>
<link rel="stylesheet" type="text/css" href="../style/style1.css">

<SCRIPT LANGUAGE="JavaScript" SRC="../includes/chdateformat.js"></script>

<script language="JavaScript">
function datentry(){

document.<%=ty%>.diagnosis.focus();



/*currdate=new Date()
newdate=currdate.getDate()
newmonth=currdate.getMonth()+1
if(newdate<10)
  putdate=('0'+newdate.toString())
else
  putdate=newdate.toString()

if(newmonth<10)
  putmonth=('0'+newmonth.toString())
else
  putmonth=newmonth.toString()
document.pre.apptdate.value=putdate+putmonth+currdate.getYear().toString()

*/

}

function chcur(adt)
{
var cur=new Date();
var apdt=new Date();
var appdt=document.<%=ty%>.apptdate.value;
//alert(appdt);

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
var dt=document.<%=ty%>.apptdate.value;
if(!chformat(dt))
{ return false; }

if(!chcur(dt))
{ return false; } 
return true;
} 

function checkval()
{
	var ret;
	ret=chdt();
	if (ret == false) return false;

	ret = checkdiag(document.<%=ty%>.diagnosis.value)
	if (ret == false)  {document.<%=ty%>.diagnosis.select(); return false;}

	ret = checkdiet(document.<%=ty%>.diet.value);
	if (ret == false)  {document.<%=ty%>.diet.select(); return false;}

	ret = checkadvice(document.<%=ty%>.advice.value);
	if (ret == false)  {document.<%=ty%>.advice.select(); return false;}
	
	
return true;	
}

function checkdiag(val)
{
	if (val.length > 7500) {alert ("Diagnosis Field can contain upto 7500 characters"); return false;}
	x = val;
    while (x.substring(0,1) == ' ')  x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Diagnosis Field Blank Not Allowed"); return false;}
	return true;
}

function checkdiet(val)
{
	if (val.length > 7500) {alert ("Diet Field can contain upto 7500 characters"); return false;}
	x = val;
    while (x.substring(0,1) == ' ')  x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Diet Field Blank Not Allowed"); return false;}
	return true;
}

function checkadvice(val)
{
	if (val.length > 7500) {alert ("Advice Field can contain upto 7500 characters"); return false;}
	return true;
}

</script>

<BODY onload='datentry();' bgcolor="WHITE">
<Form name=<%=ty%> METHOD=get ACTION="submitpres.jsp" onsubmit="return checkval();">

<input type="hidden" name="frmnam" value="<%=ty%>">

<%if(present_status.equals("YES")) { //whether patient details will be shown or not
%>
<B><FONT SIZE="" COLOR="#330099">Patient Name : </FONT><%=nam%> (<%=id%>)<BR><FONT SIZE="" COLOR="#330099">Sex : </FONT><%=sx%><FONT SIZE="" COLOR="#330099">Age : </FONT><%=astr%>(approx.)</B>
<% } else {%>
<B><FONT SIZE="" COLOR="#330099">Patient ID : </FONT><%=id%><BR><FONT SIZE="" COLOR="#330099">Sex : </FONT><%=sx%><FONT SIZE="" COLOR="#330099">Age : </FONT><%=astr%></B>
<%}%>
 <br>
<FONT SIZE="" COLOR="#330099"><B>Referred by: </FONT><%=n%></B>(<B><%=q%></B>)
 <BR>
<INPUT type=hidden name=pat_id value="<%=id.trim()%>">


<TABLE class="table" style="background-color:#99CCFF;color=DARKBLUE">
<TR>
	<TD>Diagnosis : </TD>
	<TD><TEXTAREA class="form-control" NAME="diagnosis" ROWS="2" COLS="80"></TEXTAREA></TD>
</TR>
<TR>
	<TD>Diet : </TD>
	<TD><INPUT class="form-control" NAME="diet"></TD>
</TR>
<TR>
	<TD>Activity : </TD>
	<TD >
	<SELECT class="form-control" name="activity">
	<OPTION selected>Normally active</OPTION> 
	<OPTION>Taking rest at home</OPTION> 
    <OPTION>Taking complete bed rest</OPTION></SELECT> 
    </TD>
</TR>
<TR>
	<TD>Other Advice : </TD>
	<TD><TEXTAREA class="form-control" NAME="advice" ROWS="2" COLS="80"></TEXTAREA></TD>
</TR>

<!-- <TR>
	<TD>Course Of Medicine : </TD>
 <TD><A HREF="drug.asp" onclick="NewWindow('drug.asp','drugs','900','350','yes','center'); return false" onfocus='this.blur()'>DETAILS</A></TD> 
	 <TD><A HREF="drug.asp" target=bot1>DETAILS</A></TD>-->


</TR> 
<TR >
	<TD>Next Appointment Date : </TD>
<TD ><INPUT class="form-control" name=apptdate size=10 maxlength=10 placeholder="dd/mm/yyyy" ></TD>
	

</TR>
<!-- <tr>
	<td></td>
	<TD Width=150 align="center" valign="right">
		<%
		//out.println("<img Src='\ShowSign.Asp?ID=" + docid +"' Alt = 'Signature of ("+ n + ")' height=57 width=150>");
		%>
		</TD>       

</tr>
 --></TABLE>

 <INPUT TYPE="hidden" NAME="cnam" value ="<%=c_nam%>">
<INPUT TYPE="hidden" NAME="drgno" value ="<%=r%>">

 <CENTER><input class="btn btn-default" type="submit" value="Submit" 
  style="background-color: rgb(0,0,128); font-family: serif; color: WHITE; font-weight:BOLD; ">
  <input class="btn btn-default" type="reset" value="Reset"
  style="background-color: rgb(0,0,128); font-family: serif; color: WHITE; font-weight:BOLD; ">
</CENTER></form>

<!-- <A HREF="showpatdata.jsp?id=<%=id%>&usr=doc" target=bot >Back</A>
 --></BODY></HTML>

