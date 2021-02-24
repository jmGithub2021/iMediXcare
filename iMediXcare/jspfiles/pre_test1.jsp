<%@page contentType="text/html"  import="imedix.rcCentreInfo,imedix.rcUserInfo,imedix.rcDataEntryFrm, imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	String dat="";
	String mon="",da="";
	String present_status="";
	String  userid="", usertype="doc", docid="",isnodal="",ty="";
	present_status="YES";

	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));

	String id = cookx.getCookieValue("patid", request.getCookies());
	userid = request.getParameter("docid");
	isnodal = cookx.getCookieValue("node", request.getCookies ());
	//out.println("Node="+isnodal);

	if(isnodal.length() == 0) ty="pre"; 
	else ty="prs"; 
	
	docid = request.getParameter("docid");

	if(docid.equals("")) docid = cookx.getCookieValue("userid", request.getCookies ());

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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- <link rel="stylesheet" type="text/css" href="ckp.asp">
 --><META content="text/html; charset=windows-1252" http-equiv=Content-Type>

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

function chkdt(dat,today) { 
var retval;
var mm,dd,yy,t,yr; 
var d,m,y;

//today = putdate+putmonth+currdate.getYear().toString();

if (dat.length == 0)
	return true;

dd=dat.substring(0,2); 
mm=dat.substring(2,4); 
yy=dat.substring(4,8);

d=today.substring(0,2); 
m=today.substring(2,4); 
y=today.substring(4,8);

if ( yy < y)
	{ alert("Back date not allowed"); return false; }
else 
{	if (yy == y && mm < m) 
	{ alert("Back date not allowed"); return false; }
	else
	{
		if (yy == y && mm == m && dd < d)
		{ alert("Back date not allowed"); return false; }
	}
}


for(i=0;i<8;i++){
	t = dat.substring(i,i+1);
	if (t >= '0' && t <= '9')
		continue;
	else
		alert ("No characters or Special Characters Allowed ");
		return false;
	}
if (dd < 1 || dd > 31) { window.alert('Day must range from 1 to 31. Date Format DDMMYYYY'); return false; } 
if (mm < 1 || mm > 12) { window.alert('Month must range from 1 to 12. Date Format DDMMYYYY'); return false; }  
else
{
switch (mm)
{
case "02":
yr=yy%4;
  if(dd==29&&yr!=0){window.alert('This Year is not a leap year'); return false;}
  if(dd>29) {window.alert('February have not more than 29 days except leap year'); return false;}
case "04":
if(dd==31){window.alert('In April Date 31 is not present'); return false;}
case "06":
if(dd==31){window.alert('In June Date 31 is not present'); return false;}
case "09":
if(dd==31){window.alert('In September Date 31 is not present'); return false;}
case "11":
if(dd==31){window.alert('In November Date 31 is not present'); return false;}
}
}


if (yy < 1931 || yy > 2030) { window.alert('year must range from 1931 to 2030. Date Format DDMMYYYY'); return false;
} 
}

function checkval()
{
	var ret;
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
<B><FONT SIZE="" COLOR="#330099">Patient Name : </FONT>&nbsp;&nbsp;&nbsp;<%=nam%> (<%=id%>)<BR><FONT SIZE="" COLOR="#330099">Sex : </FONT>&nbsp;<%=sx%>&nbsp;&nbsp;<FONT SIZE="" COLOR="#330099">Age : </FONT>&nbsp;<%=astr%>&nbsp;(approx.)</B>
<% } else {%>
<B><FONT SIZE="" COLOR="#330099">Patient ID : </FONT>&nbsp;&nbsp;&nbsp;<%=id%><BR><FONT SIZE="" COLOR="#330099">Sex : </FONT>&nbsp;<%=sx%>&nbsp;&nbsp;<FONT SIZE="" COLOR="#330099">Age : </FONT>&nbsp;<%=astr%>&nbsp;</B>
<%}%>
 <br>
<FONT SIZE="" COLOR="#330099"><B>Referred by: </FONT>&nbsp;<%=n%></B>&nbsp;(<B>&nbsp;<%=q%>&nbsp;</B>)
 <BR>
<INPUT type=hidden name=pat_id value="<%=id.trim()%>">
<BR><BR>
<table border=0 width="90%" style="background-color:#99CCFF" >
<tr><td>
<TABLE width="90%" cellspacing=5 border=0 style="background-color:#99CCFF;color=DARKBLUE">
<TR>
	<TD>Diagnosis : </TD>
	<TD><TEXTAREA NAME="diagnosis" ROWS="5" COLS="30"></TEXTAREA></TD>
</TR>
<TR>
	<TD>Diet : </TD>
	<TD><INPUT NAME="diet"></TD>
</TR>
<TR>
	<TD>Activity : </TD>
	<TD colSpan=2>
	<SELECT name=activity>
	<OPTION selected>Normally active</OPTION> 
	<OPTION>Taking rest at home</OPTION> 
    <OPTION>Taking complete bed rest</OPTION></SELECT> 
    </TD>
</TR>
<TR>
	<TD>Other Advice : </TD>
	<TD><TEXTAREA NAME="advice" ROWS="3" COLS="30"></TEXTAREA></TD>
</TR>

<!-- <TR>
	<TD>Course Of Medicine : </TD>
 <TD><A HREF="drug.asp" onclick="NewWindow('drug.asp','drugs','900','350','yes','center'); return false" onfocus='this.blur()'>DETAILS</A></TD> 
	 <TD><A HREF="drug.asp" target=bot1>DETAILS</A></TD>-->


</TR> 
<TR >
	<TD>Next Appointment Date : </TD>
<TD width="1%">

	<!-- 	<INPUT name=apptdate size=8 maxlength=8 onBlur="if (chkdt(document.<%=ty%>.apptdate.value,'<%=dat%>') == false){ document.<%=ty%>.apptdate.select();}" >(ddmmyyyy) -->

	<INPUT name=apptdate size=8 maxlength=8 onBlur="if (chkdt(document.<%=ty%>.apptdate.value,'<%=dat%>') == false){ document.<%=ty%>.apptdate.select();}" >(ddmmyyyy)
</TD>
	

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
</TD></TR></TABLE><br>
 <INPUT TYPE="hidden" NAME="cnam" value ="<%=c_nam%>">
<INPUT TYPE="hidden" NAME="drgno" value ="<%=r%>">

 <CENTER><input type="submit" value="Submit" 
  style="background-color: rgb(0,0,128); font-family: serif; color: WHITE; font-weight:BOLD; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="reset" value="Reset"
  style="background-color: rgb(0,0,128); font-family: serif; color: WHITE; font-weight:BOLD; ">
</CENTER></form>

<A HREF="showpatdata.jsp?id=<%=id%>&usr=doc" target=bot >Back</A>
</BODY></HTML>

