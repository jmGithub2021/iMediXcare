<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook, java.util.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>


<%
	String patid="",sl="",typ="",endt="";
	patid=request.getParameter("patid");
	sl=request.getParameter("sl");
	typ=request.getParameter("ty");
	endt=request.getParameter("dt");

	//endt=endt.substring(6)+"/"+endt.substring(3,5)+"/"+endt.substring(0,2);
	
	String docname=typ+"-"+sl+"#";
	cook cookx = new cook();
	rcDisplayData rcall=new rcDisplayData(request.getRealPath("/"));
%>

<html>
<head>
<title>Image Effects</title>
<style>
A { text-decoration: None;
	font-weight: BOLD;
	color: #330099;
}
td{
	color: #330099;
	font-weight: BOLD;
}

</style>

<SCRIPT LANGUAGE="JavaScript">

function setvalue(val)
{	
	alert(val);

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
tar="showecg.jsp?"+val;
alert(tar);
window.location=tar;
}

function writetoLyr(id, message)
{
	alert(id+":"+message);
	//alert(document.getElementById(id).innerHTML);

	if (document.getElementById(id).style.visibility=="visible") {
		document.getElementById(id).style.visibility="hidden";
	}
	else {
		document.getElementById(id).style.visibility="visible";
	}
	document.getElementById(id).innerHTML = message;
}

</SCRIPT>

</head>


<%
	String labdtl="";
    String ty="",imgdesc="", labname="",docnm="",remcode="";
    String data="<B>UnderConstruction</B>"; 
    
	String edata=new String(rcall.getDocument(patid,endt,typ,sl));
   
   try
   {
	 Vector alldata=(Vector)rcall.getDocumentdetailsOthers(patid,endt,typ,sl);
	 Object res =(Object)alldata.get(0);

   if(res instanceof String){ data=res.toString();}
   else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);
		imgdesc =datatemp.getValue("imgdesc");
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

%>
<body bgcolor=#EFEFEF>
<center>
<TABLE width=100% border=1 bgcolor=#EFEFEF CELLSPACING=0 CELLPADDING=0>
<TR>
	<TD align='left'><FONT SIZE="5" COLOR="#FF0404">ECG Viewer</FONT>
	<%

		boolean found=false;
		String utype = cookx.getCookieValue("usertype", request.getCookies ());
		String seldoc,thisdoc;
		int hasthisdoc=0;
		seldoc = cookx.getCookieValue("seldoc", request.getCookies ());
		thisdoc = docname;
		if(!seldoc.equals(""))
		{
			try{
				String str[]=seldoc.split("#");
				for(int k=0;k<str.length;k++){
					if(thisdoc.equals(str[k]+"#")){
						found = true;
						break;
					}else{
						found=false;
					}
				} 
			} catch(ArrayIndexOutOfBoundsException e1){ }
		}

		//out.println("<FONT SIZE='-1' COLOR='#F1FEFE'><INPUT TYPE=checkbox NAME='seltele'");
		//if(found == true)out.println("checked");
		//out.println("onClick='setvalue(this.checked);'> Select for Teleconsultation</FONT>");
		
	%>
	<BR><%=patid%>
	</TD>

	<TD align='right'><%=data%></TD>
</TR>
</TABLE>

</center>

<%
	out.println("<Applet Codebase='./ecgviewer/' Code='ecgviewer.class' archive='ecgviewer.jar' Width= 760 Height=505 >");
	out.println("<param name='patid' value='"+patid+"'>");
	out.println("<param name='ecgdata' value='"+edata+"'>");
	out.println("</Applet>");

%>
</body>
</html>
