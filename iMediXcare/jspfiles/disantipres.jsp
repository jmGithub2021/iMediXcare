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

		

%>


<HTML>
<HEAD>
<TITLE>Prescription</TITLE>

<style>
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
<BODY BGColor=#FFFFFF background="../images/txture.jpg">
<Form name="frm">

<TABLE Border=0 Width=100%>
<TR>

<TD>
<A HREF="#" onclick = 'PrintDoc();' Border=0 Style='color:RED; font-weight:Bold; text-decoration:none '>
<IMG SRC="../images/printer.gif" WIDTH="22" HEIGHT="22" BORDER=0 ALT="PrintThis">Print this Document</A></TD>
</TR>

<!-- </TABLE>
<HR size=2>
 -->
 <%
	
	boolean found=false;
	//String pval="";

	String ty = request.getParameter("ty").toLowerCase();
	String id = request.getParameter("id");
	String dt = request.getParameter("dt");

	//String dat = dt.substring(0,2)+dt.substring(3,5)+dt.substring(6,10);
	//dt = myDate.getFomateDate("ymd",true,dat);

	String sl = request.getParameter("sl");
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
	String utype="";
	utype = cookx.getCookieValue("usertype", request.getCookies ());
	String selfrm,thisfrm;
	int hasthisfrm=0;
	selfrm = cookx.getCookieValue("selfrm", request.getCookies ());
	thisfrm = frmname;
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
					out.println("<SELECT NAME=abc onChange='showselected();'>"); //showselected(abc.value);
					out.println("<option></option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						pdt = datatemp.getValue("date");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						sn=datatemp.getValue("serno");
						//if(sn.length()<2)  sn= "0" + sn; 
						out.println("<option value='id="+id+"&ty="+ty+"&sl="+sn+"&dt="+pdt+"' >"+ty+"-"+sn+"</option>");
					}
					out.println("</SELECT></TD></TR></form></TABLE><HR Size=3  Color=RED>");
				}
				else out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

			}
			if(tag==1) out.println("</TR></form></TABLE><HR Size=3  Color=RED>");
		
%>

<CENTER>
<TABLE Width=100% Border=0>
<TR>
<TD>
<center>

<FONT SIZE="5pt" COLOR="MAROON"><%= hosname %></FONT>


</center>
</TD>
</TR>
<TABLE>
</CENTER>
<BR>
<CENTER>
<TABLE Width=100% Border=0>
<TR>
	<TD Width=100% Align=Left><B><U><FONT  COLOR="brown">Patient Details</FONT></U></B></TD>

</TR>
<TR>
	<TD Width=100%>
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
	Name&nbsp;:&nbsp;<B><%=patnam%></B>&nbsp;&nbsp;&nbsp;ID&nbsp;:&nbsp;<B><%=id%></B><BR>
	AGE&nbsp;:&nbsp;<B><%=astr%></B>
	SEX&nbsp;:&nbsp;<B><%=sx%></B></TD>

</TR>
<TR>
	<TD Width=70%><B><U><FONT  COLOR="Brown">Prescribed By</FONT></U></B></TD>

</TR>
<TR>
	<TD Width=70%>
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
	<B><%=docname %>,&nbsp;(<%=dreg_no %>)</B>
	<BR>
	Phone&nbsp;:&nbsp;<B><%=docphone%></B>
	Email&nbsp;:&nbsp;<B><%=docmail%></B>
	Qualification&nbsp;:&nbsp;<B><%=docqlt%></B>
	</TD>
</TR>
</TABLE>
<BR>
<%

if (ty.equalsIgnoreCase("k00")) {
	out.println(ddinfo.getAntiTuberculosisSummary(id,0,dt,sl));
}else if (ty.equalsIgnoreCase("k01")) {
	out.println(ddinfo.getCTXSummary(id,0,dt,sl));
}else if (ty.equalsIgnoreCase("k02")) {
	out.println(ddinfo.getAntiretroviralPrescription(id,dt,sl));
}
	
%>

<BR><BR>
<TABLE Width=100% border=0>
<TR>	

<TD width=40% Align=Left><B><U><FONT  COLOR="Brown">Entry Date</FONT></U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;
	<%= myDate.mysql2ind(dt) %></B></TD>
	<TD Width=60% Align=Right><B><%out.println(docname.toUpperCase());
	%><BR></B> Computer Generated Documents need not be Signed
	</TD>
</TR>
</TABLE>
</CENTER>
