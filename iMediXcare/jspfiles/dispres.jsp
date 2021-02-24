<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*"%>

<%@ include file="..//includes/chkcook.jsp" %>
<%
		cook cookx = new cook();
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
		
		rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
		rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));

		String frmname,islocal="";
		frmname=request.getParameter("ty");
		frmname=frmname+"-"+request.getParameter("sl")+"#";
		islocal=cookx.getCookieValue("node", request.getCookies ());
%>

<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<TITLE>Prescription</TITLE>

<style>

table.table:hover{
	background-color:white;
	color:#0B677D;
	}


A { text-decoration: None;
	color: BLACK;
	font-weight: BOLD;
};

</style>
<SCRIPT LANGUAGE="JavaScript">
<!--
function PrintDoc(text)
{
	text = document;
	print(text);
}

function showselected()
{
var val=document.frm.abc.value;
var tar;
tar="writevaltext.jsp?"+val;
//alert(tar);
window.location=tar;

}

function setvalue(val)
{
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ frmname + "'");%>
	prevalue=getCookie("selfrm");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selfrm="+prevalue;
	//alert(getCookie("selfrm"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ frmname + "'");%>
	prevalue=getCookie("selfrm");
	document.cookie="selfrm="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selfrm="+nval;
	//alert(getCookie("selfrm"));
	}
}

function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }



//-->
</SCRIPT>
</HEAD>
<BODY >

<div class="container-fluid">

<Form name="frm">

<TABLE class="table table-bordered">
<TR>

<TD colspan=2>
<A HREF="#" onclick = 'PrintDoc();' Border=0 Style='color:RED; font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="../images/printer.gif" WIDTH="22" HEIGHT="22" BORDER=0 ALT="PrintThis">Print this Document</A></TD>
</TR>


 <%
	
	boolean found=false;
	//String pval="";

	String ty="",id="",dt="",sl="";

	//String dat = dt.substring(0,2)+dt.substring(3,5)+dt.substring(6,10);
	//dt = myDate.getFomateDate("ymd",true,dat);


	
	try{
		ty = request.getParameter("ty").toLowerCase();
		id = request.getParameter("id");
		dt = request.getParameter("dt");
		sl = request.getParameter("sl");
		//out.println(ty+" : "+id+" : "+dt+" : "+sl );
		}catch(Exception ex){out.println(ex.toString());}
	
	
	
	Vector Vres;

	Vres = (Vector) ddinfo.getAttachmentAndOtherFrm(id,ty,sl,dt); //// we get the OtherFrm (vector index=1)

///
	String pdt="",dt1="",phoscode="",dreg_no="";

	dataobj objpre=null;
	Object res=ddinfo.DisplayFrm(ty,id,dt,sl);
	
	if(res instanceof String){
		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
		return;
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0) {
			objpre = (dataobj) tmp.get(0);
			phoscode=objpre.getValue("name_hos");
			dreg_no=objpre.getValue("docrg_no");
		}
	}

	String hosname=cinfo.getHosName(phoscode);
	Object resu=uinfo.getValues("name,phone,emailid,qualification"," rg_no like '"+dreg_no+"%'" );
	Object resmed=ddinfo.DisplayMed(id,"","");

		//if(islocal.length()==0)
		//{
		//telemedicin req
			String utype="";
			utype = cookx.getCookieValue("usertype", request.getCookies ());
			
			String selfrm,thisfrm;
			int hasthisfrm=0;
			selfrm = cookx.getCookieValue("selfrm", request.getCookies ());
			thisfrm = frmname;

		//	out.println("selfrm: "+selfrm);

			if(!selfrm.equals(""))
			{
				try
				{
					String str[]=selfrm.split("#");
					for(int k=0;k<str.length;k++)
					{
						if(thisfrm.equals(str[k]+"#"))
						{
						found = true;
						break;
						}
						else
						{
						found=false;
						}
					} //end of for loop
				} catch(ArrayIndexOutOfBoundsException e1)
				{ }

			}

			out.println("<tr><td><FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			if(found == true)
			{
				out.println(" checked");
			}
				out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT></td>");

	//}
///////////////////////



		int tag=0;
			Object Objtmp = Vres.get(1);
			if(Objtmp instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)Objtmp;
				if(Vtmp.size()>1 ) {
					String sn;
					out.println("<td Align='Right'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT>");
					out.println("<SELECT class='btn btn-default' NAME=abc onChange='showselected();'>"); //showselected(abc.value);
					out.println("<option></option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						pdt = datatemp.getValue("date");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						sn=datatemp.getValue("serno");
						//if(sn.length()<2)  sn= "0" + sn; 
						out.println("<option value='id="+id+"&ty="+ty+"&sl="+sn+"&dt="+pdt+"' >"+ty+"-"+sn+"</option>");
					}
					out.println("</SELECT></TD></TR></form></TABLE>");
				}
				else out.println("</TR></form></TABLE>");

			}
			if(tag==1) out.println("</TR></form></TABLE>");
		
%>

<CENTER>


<FONT SIZE="5pt" COLOR="MAROON"><%= hosname %></FONT>
</center>




<div class="row">
<div class="col-sm-6 ">

<B><U><FONT  COLOR="brown">Patient Details</FONT></U></B>

<TABLE class="table table-bordered">
<TR>
	<TD >
		<% // Reading Patient Values
		String patnam = "", sx="",ag="",astr="";
		try {
			
			if(resmed instanceof String){
				out.println("<br><center><h1> Data Not Available </h1></center>");
				out.println("<br><center><h1> " +  resmed+ "</h1></center>");
			}
			else{
				Vector tmp = (Vector)resmed;
				if(tmp.size()>0) {
					dataobj datatemp = (dataobj) tmp.get(0);
						patnam=datatemp.getValue("pre") +". " + datatemp.getValue("pat_name")+" " +datatemp.getValue("m_name")+" " +datatemp.getValue("l_name") ; 
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


		}
		catch (Exception e)
		{
		out.println("<BR>"+e);
		}


	%>
	
	Name:</td><td><B><%=patnam%></B></td></tr>
	<tr><td>ID:</td><td><B><%=id%></B></td></tr>
	<tr><td>AGE:</td><td><B><%=astr%></B></td></tr>
	<tr><td>SEX:</td><td><B><%=sx%></B></TD>

</TR>
</TABLE>

</div>		<!-- "col-sm-6" -->






<div class="col-sm-6 ">
<B><U><FONT  COLOR="Brown">Prescribed By</FONT></U></B>

<TABLE class="table table-bordered">

<TR>
	<TD colspan=2>
	<%
		String docname="",docqlt="",rgno="",docphone="",docmail="";
		
		try {
					
			
			if(resu instanceof String){
				out.println("<br><center><h1> Data Not Available </h1></center>");
				out.println("<br><center><h1> " +  resu+ "</h1></center>");
			}
			else{
				Vector tmp = (Vector)resu;
				if(tmp.size()>0) {
					dataobj datatemp = (dataobj) tmp.get(0);
						docname=datatemp.getValue("name");
						docphone = datatemp.getValue("phone");
						docmail = datatemp.getValue("emailid");
						docqlt = datatemp.getValue("qualification");
					}
			}
			
			if(docname=="") docname="< Plz Import Doctor >";
			else docname=docname.toUpperCase();
  		}
		catch (Exception e)
		{
		out.println("<BR>"+e);
		}

	%>
	<B><%=docname %>,&nbsp;(<%=dreg_no %>)</B></td></tr>
	<tr><td>Phone:</td><td><B><%=docphone%></B></td></tr>
	<tr><td>Email:</td><td><B><%=docmail%></B></td></tr>
	<tr><td>Qualification:</td><td><B><%=docqlt%></B>
	</TD>
</TR>
</TABLE>

</div>		<!-- "col-sm-6" -->
</div>		<!-- "row" -->




<div class="row">
<div class="col-sm-6 ">
<TABLE class="table table-bordered">
<TR>
	<TD><B><U><FONT  COLOR="Brown">Diagnosis</FONT></U></td>
	<td><%=objpre.getValue("diagnosis") %></B></TD></tr>
	<tr><TD><B><U><FONT  COLOR="Brown">Advice </FONT></U></td>
	<td><%=objpre.getValue("advice") %></B></TD>
</TR>

</TABLE>

</div>		<!-- "col-sm-6" -->

<div class="col-sm-6 ">
<TABLE class="table table-bordered">
<TR>
	<TD><B><U><FONT  COLOR="Brown">Diet</FONT></U></td>
	
	<td><%=objpre.getValue("diet") %></B></TD></tr>
	
	<tr><TD><B><U><FONT  COLOR="Brown">Activity </FONT></U></td>
	<td><%=objpre.getValue("activity") %></B></TD>

</TR>

</TABLE>
</div>		<!-- "col-sm-6" -->
</div>		<!-- "row" -->




<B><U><FONT  COLOR="Brown">Drugs Prescribed:</FONT></U></b>



<div class="table-responsive">
<%	 String A, B, C, D, E;
	A = objpre.getValue("drugs");

if(!A.equals("null") && !A.equals(""))
{
	
out.println("<TABLE class='table table-hover table-bordered' style='border-collapse: collapse; border-left-width: 0; border-right-width: 0; border-bottom-style: solid; border-bottom-width: 1; padding: 0' border=1 >");

out.println("<TR>");
out.println("<TD Width='20%' style='border-left-width: 0;  border-right-width: 0; border-top-color: #111111; border-top-width: 1'><B><FONT  COLOR='Blue'>Drugs</FONT></B></TD>");

out.println("<TD Width='20%' style='border-left-width: 0;  border-right-width: 0; border-top: 1px solid #111111;'><B><FONT  COLOR='Blue'>Quantity</FONT></B></TD>");

out.println("<TD Width='20%' style=' border-left-width: 0;  border-right-width: 0; border-top: 1px solid #111111;'><B><FONT  COLOR='Blue'>Dose</FONT></B></TD>");
out.println("<TD Width='20%' style=' border-left-width: 0;  border-right-width: 0; border-top: 1px solid #111111;'><B><FONT  COLOR='Blue'>Duration</FONT></B></TD>");
out.println("<TD Width='20%' style=' border-left-width: 0;  border-right-width: 0; border-top: 1px solid #111111;'><B><FONT  COLOR='Blue'>Comments</FONT></B></TD>");

out.println("</TR>");

	B = objpre.getValue("quantity");
	C = objpre.getValue("dose");
	D = objpre.getValue("duration");
	E = objpre.getValue("comments");

	String aa[]=A.split("!");
	String bb[]=B.split("!");
	String cc[]=C.split("!");
	String dd[]=D.split("!");
	String ee[]=E.split("!");

	int xx=aa.length;

	//out.println("A="+xx+" dd="+dd.length+" E="+ee.length);
	//	A=A+"!";
	//	B=B+"!";
	//	C=C+"!";
	//	D=D+"!";
	//	E=E+"!";
		//}

	/*A = A.replace('!', ' ');
	B = B.replace('!', ' ');
	C = C.replace('!', ' ');
	D = D.replace('!', ' ');
	E = E.replace('!', ' '); */

	StringTokenizer stA = new StringTokenizer(A, "!");
	StringTokenizer stB = new StringTokenizer(B, "!");
	StringTokenizer stC = new StringTokenizer(C, "!");
	StringTokenizer stD = new StringTokenizer(D, "!");
	StringTokenizer stE = new StringTokenizer(E, "!");

int ii=0;
String comee="";


 while (stA.hasMoreTokens()) {

		out.println("<TR>");
		out.println("<TD Width='20%' style='border-left: medium none #111111; border-right-style: none; border-right-width: medium; border-top-style: solid; border-top-width: 1'><B><FONT  COLOR=black>"+ stA.nextToken() + "</FONT></B></TD>");

	if(ii<bb.length)
	comee=bb[ii];
 	else comee="-";

		out.println("<TD Width='20%' style='border-left: medium none #111111; border-right-style: none; border-right-width: medium; border-top-style: solid; border-top-width: 1'><B><FONT  COLOR=black>"+ comee + "</FONT></B></TD>");


	if(ii<cc.length)
	comee=cc[ii];
 	else comee="-";

		out.println("<TD Width='20%' style='border-left: medium none #111111; border-right-style: none; border-right-width: medium; border-top-style: solid; border-top-width: 1'><B><FONT  COLOR=black>"+ comee + "</FONT></B></TD>");

 if(ii<dd.length)
	comee=dd[ii];
 else comee="-";

		out.println("<TD Width='20%' style='border-left: medium none #111111; border-right-style: none; border-right-width: medium; border-top-style: solid; border-top-width: 1'><B><FONT  COLOR=black>"+ comee + "</FONT></B></TD>");


 if(ii<ee.length)
 	comee=ee[ii];
 else comee="-";

	out.println("<TD Width='20%' style='border-left: medium none #111111; border-right-style: none; border-right-width: medium; border-top-style: solid; border-top-width: 1'><B><FONT  COLOR=black>"+comee + "</FONT></B></TD>");

   out.println("</TR>");

	ii++;
	}

	}


	String appdt=objpre.getValue("apptdate");
	
	if(appdt.length()==0) appdt="";
	else appdt= appdt.substring(8,10)+"/"+appdt.substring(5,7)+"/"+appdt.substring(0,4);
	String edt=objpre.getValue("entrydate");
	edt= edt.substring(8,10)+"/"+edt.substring(5,7)+"/"+edt.substring(0,4);

%>
</TABLE>
</div>		<!-- "table-responsive" -->


<TABLE class="table ">
<TR>	<TD  Align=Left><B><U><FONT  COLOR="Brown">Appointment Date</FONT></U>&nbsp;:&nbsp;
	<%= appdt %></B><BR><B><U><FONT  COLOR="Brown">Entry Date</FONT></U>
	<%= edt %></B></TD>
	<TD Align=Right><B><%out.println(docname.toUpperCase());
	%><BR></B> Computer Generated Documents need not be Signed
	</TD>
</TR>
</TABLE>
</CENTER>
</div>		<!-- "container-fluid" -->
</body>
</html>

