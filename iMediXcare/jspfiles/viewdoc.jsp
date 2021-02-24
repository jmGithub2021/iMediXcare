<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook, java.util.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<% 

	String docname,Node="";
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	
	docname=request.getParameter("ty");
	docname=docname+"-"+request.getParameter("sl")+"#";
	
	String id = request.getParameter("id");
	String dt = request.getParameter("dt");

	//dt=dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);

	String ty = request.getParameter("ty");
	String sl = request.getParameter("sl");

%>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
function setvalue(val)
{	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ docname + "'");%> 
	prevalue=getCookie("seldoc");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="seldoc="+prevalue;
	alert(getCookie("seldoc"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ docname + "'");%> 
	prevalue=getCookie("seldoc");
	document.cookie="seldoc="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="seldoc="+nval;
	alert(getCookie("seldoc"));	
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

function showselected(val)
{
var tar;
tar="viewdoc.jsp?"+val;
alert(tar);
window.location=tar;
}

//-->
</SCRIPT>
</HEAD>
<BODY>
<TABLE Border=0 BorderColor=#3333CC Cellspacing=0 Cellpadding=3 Width=800>
<TR>
<TD><FORM NAME=frmdoc>
<%
			boolean found=false;
			String Qr1="",Qr="",pdt="",dt1="";
			//telemedicin req
			String utype = cookx.getCookieValue("usertype", request.getCookies ());
			//if(utype.equals("adm"))
			//{
			String seldoc,thisdoc;
			int hasthisdoc=0;
			seldoc = cookx.getCookieValue("seldoc", request.getCookies ());
			thisdoc = docname;
			if(!seldoc.equals(""))
			{
			try
			{
			String str[]=seldoc.split("#");
			for(int k=0;k<str.length;k++)
			{
				if(thisdoc.equals(str[k]+"#"))
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
			
			//out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			//if(found == true)
			//{
			//out.println(" checked");
			//}
			//out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT>");

%>
<BR><HR Color=PINK>

<%
	
    String imgdesc="", labname="",docnm="",remcode="";
    String data="<B>UnderConstruction</B>"; 

   try
   {
	 Vector alldata=(Vector)ddinfo.getDocumentdetailsOthers(id,dt,ty,sl);
	 Object res =(Object)alldata.get(0);

   if(res instanceof String){ data=res.toString();}
   else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);
		imgdesc =datatemp.getValue("docdesc");
		labname = datatemp.getValue("lab_name");
		docnm = datatemp.getValue("doc_name");
		String tstdat=datatemp.getValue("testdate");
		data = "<TABLE BORDER=0 aling=center width='100%'>";
		data = data + "<TR><TD width='20%'>Description</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+imgdesc+"</B></TD>";
		data = data + "<TD width='25' > </TD>";
		data = data + "<TD width='20%'>Lab Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+labname+"</B></TD></TR>";

		data = data + "<TR><TD >Doctor Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+docnm+"</B></TD>";
		data = data + "<TD width='25' > </TD>";
		data = data + "<TD>Date of Test</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+tstdat.substring(8,10)+"-"+tstdat.substring(5,7)+"-"+tstdat.substring(0,4)+"</B></TD></TR>";

		
		data = data + "</TABLE>";
		
      }
	} catch(Exception e) {
		out.println("error.."+e);
		data = e.toString();
	}

	out.println(data);
%>
<HR Color=PINK>
</FORM>
</TD>
</TR>
<TR>
	<TD></TD><TD>
</TR>

</TABLE>
</BODY>
</HTML>
