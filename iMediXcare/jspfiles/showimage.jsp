<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj ,imedix.cook, java.util.*,java.io.*,javax.crypto.*,imedix.Crypto, java.net.URLEncoder, java.nio.charset.StandardCharsets" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
		String cnttype="",ext="";

		String imgname="",mtype="",marname="",ccode ="";
		cook cookx = new cook();
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));

		ccode = cookx.getCookieValue("center", request.getCookies ());

		mtype=request.getParameter("mtype");
		
		//out.println("mtype :"+mtype);

		if(mtype.equals("nomark"))
		{
		imgname=request.getParameter("type");
		imgname=imgname+"-"+request.getParameter("ser")+"#";
		}
		if(mtype.equals("mark"))
		{
		marname=request.getParameter("type");
		marname=marname+"-"+request.getParameter("ser")+"-";
		marname=marname+request.getParameter("mser")+"#";
		}
	
	    SecretKey key = getSecretKey(session);
			String encodedKey = Base64.getEncoder().encodeToString(key.getEncoded());	    
	    Crypto crypto = new Crypto(key);
		//out.println("imgname: "+imgname);
%>

<html>
<head>


<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<title>Image Effects</title>
<style>
A { text-decoration: None;
	color: BLUE;
	font-weight: BOLD;
};
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--

function PrintDoc(text){
text=document
print(text)
}

function showselected(val)
{

//var val=document.frm.abc.value;
	var tar;
	tar="showimage.jsp?"+val;
	//alert(tar);
	//window.location=tar;
	var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
	$("body").html(ajax_load).load(encodeURI(tar));
}

function setvaluemark(val)
{	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ marname + "'");%> 
	prevalue=getCookie("selmark");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selmark="+prevalue;

	alert(getCookie("selmark"));

	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ marname + "'");%> 
	prevalue=getCookie("selmark");
	document.cookie="selmark="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selmark="+nval;

	alert(getCookie("selmark"));
	
	}
}




function setvalue(val)
{	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ imgname + "'");%> 
	prevalue=getCookie("selimg");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selimg="+prevalue;
	alert(getCookie("selimg"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ imgname + "'");%> 
	prevalue=getCookie("selimg");
	document.cookie="selimg="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selimg="+nval;
	alert(getCookie("selimg"));	
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

function writetoLyr(id, message)
{
	
	if (document.getElementById(id).style.visibility=="visible") {
		document.getElementById(id).style.visibility="hidden";
	}
	else {
		document.getElementById(id).style.visibility="visible";
	}
	document.getElementById(id).innerHTML = message;
}
//-->


$(document).ready(function(){
	$(".imgmark").change(function(){
		var tar="showimage.jsp?"+$(this).val();
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		var flag = 0;
		$(".report-sheet").html(ajax_load).load(encodeURI(tar),function( response, status, xhr ) {
			var flag = 1;
			//alert("f0 : "+flag);
		});
		if(flag==0)
			showselected($(this).val());
		//alert("f1 : "+flag);	
	});
});
</SCRIPT>

<style>
.table{
	margin-bottom:0px;
	}
</style>

</head>
<BODY>

<div class="container-fluid">

<TABLE class="table" >
<TR>
	<TD><A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >&nbsp;Print this Document&nbsp;</A>
</TD>

<%	
	boolean found=false;
	String patid="",itype="",pdt="",dt1="",isl="",msl="",rcode="",sn="",dat="";
	boolean ref=true;

	Object res=null;
	Vector alldata=null;
	int tag=0;
	String usrtyp="";
	usrtyp = cookx.getCookieValue("usertype", request.getCookies ());
	usrtyp = usrtyp.trim();
	String Node = cookx.getCookieValue("node", request.getCookies ());
	
	patid=request.getParameter("id");
	itype=request.getParameter("type").toUpperCase();
	isl=request.getParameter("ser");
	dat=request.getParameter("dt");
	
	String sel_sn=request.getParameter("sn");
	String msel_sn=request.getParameter("msn");

	if(mtype.equalsIgnoreCase("mark"))
	{	msl=request.getParameter("mser");
		rcode=request.getParameter("rcode");
	}
	out.println("<td Align=Right><FONT SIZE = 3 COLOR= blue ><b>ID:&nbsp;"+patid+ "</b></FONT></TD></TR></table>");

%>







<TABLE class="table table-bordered" style="background-color:#EEF6F5">
<TR><Form name=frm><TD><FONT SIZE="3pt" COLOR="RED">

<%
	 //mark image
   // other image
   // 1st details

	String datmdy = dat.substring(8,10)+"/"+dat.substring(5,7)+"/"+dat.substring(0,4);
	String datmdyPath = dat.substring(8,10)+dat.substring(5,7)+dat.substring(0,4);

	alldata= (Vector)ddinfo.getImgdetailsOtherimgMarkimg(mtype,patid,itype,dat,isl,msl,rcode);
		
	if(Node.trim().length() == 0) {
		 ref=false;
		 Node = cookx.getCookieValue("center", request.getCookies ());
	}
	



/////////////////////////////////////////////////



   
   String sqlQuery, id="", ty="",imgdesc="", labname="",docname="",remcode="";
   String data="<B>UnderConstruction</B>"; 
   try
   {
   res = (Object)alldata.get(2);
   if(res instanceof String){ tag=1;}
   else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);
		imgdesc =datatemp.getValue("imgdesc");
		labname = datatemp.getValue("lab_name");
		docname = datatemp.getValue("doc_name");
		
		cnttype= datatemp.getValue("con_type");

		ext=datatemp.getValue("ext");

		data = "<div class='table-responsive'><TABLE class='table well'>";
		data = data + "<TR><TD>Description</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+imgdesc+"</B></TD>";
		data = data + "<TD width='20' > </TD>";

		data = data + "<TD>Lab Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+labname+"</B></TD></TR>";

		data = data + "<TR><TD>Doctor Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+docname+"</B></TD>";

		data = data + "<TD width='20'></TD>";

		data = data + "<TD>Date of Test</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+dat.substring(8,10)+"-"+dat.substring(5,7)+"-"+dat.substring(0,4)+"</B></TD></TR>";

		if(mtype.equalsIgnoreCase("mark")){	
			remcode=datatemp.getValue("ref_code");
			data = data + "<TR ><TD>Remote Center Code</TD>";
			data = data + "<TD><B>:</B></TD><TD><B>"+remcode.toUpperCase()+"</B></TD></TR>";
			data = data + "</TABLE></div>";
		}else{
			data = data + "</TABLE></div>";
		}
      }
	} catch(Exception e) {
		out.println("error.."+e.getMessage());
		data = e.toString();
	}
	


////////////////////////////////////////////////////








	out.println("<B>[</B>&nbsp;<A Href=javascript:location.reload()>Refresh</A>&nbsp;");
	if (usrtyp.equalsIgnoreCase("doc") && mtype.equalsIgnoreCase("nomark") && !cnttype.equalsIgnoreCase("LRGFILE")) {
		out.println("<B>|</B> <A Href=\'offlinemodified_sk.jsp?id="+patid+"&type="+itype+"&ser="+isl+"&dt="+dat+"&ext="+ext+"' ><B>|</B>&nbsp; Offline Marking</A>&nbsp;<B>]</B>&nbsp;&nbsp;");
	} else {
		out.println("<B>]</B>&nbsp;&nbsp;");
	}
	

			if(mtype.equals("nomark"))
			{
			String selimg,thisimg;
			int hasthisimg=0;
			selimg = cookx.getCookieValue("selimg", request.getCookies ());
			thisimg = imgname;
			if(!selimg.equals(""))
			{
			try
			{
			String str[]=selimg.split("#");
			for(int k=0;k<str.length;k++)
			{
				if(thisimg.equals(str[k]+"#"))
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
			{  }
			}

			//out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");

			//if(found == true)
			//{
			//	out.println(" checked");
			//}
			//out.println("onClick='setvalue(seltele.checked);'>Select for Teleconsultation</FONT> ");
			
			
			} // end of if(mtype.equals("nomark")

			if(mtype.equals("mark"))
			{
			String selmark,thismark;
			int hasthismark=0;
			selmark = cookx.getCookieValue("selmark", request.getCookies ());
			thismark = marname;
			if(!selmark.equals(""))
			{
			try
			{
			String str[]=selmark.split("#");
			for(int k=0;k<str.length;k++)
			{
				if(thismark.equals(str[k]+"#"))
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

			//out.println(" onClick='setvaluemark(seltele.checked);'> Select for Teleconsultation</FONT>");

			} // end of if(mtype.equals("mark")


		try
		{
			res = (Object)alldata.get(0);
			if(res instanceof String){ 
				//out.println("View Marked Images :" +res);
				tag=1;
				}
			else{
				Vector Vtmp = (Vector)res;
				//out.println("View Marked Size :" +Vtmp.size());

				if(Vtmp.size()>0 ) {
					for(int i=1;i<4;i++) out.println("&nbsp;");
					out.println("<div class='input-group'><span class='input-group-addon'><FONT SIZE='-1' COLOR='#0080C0'>View Marked Images : </FONT></span>");
					out.println("<SELECT class='form-control imgmark' NAME=imgmark >"); 
				
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String refcode=datatemp.getValue("ref_code");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String msln=datatemp.getValue("serno");
						String isl1=isl;
						if(isl1.length()<2)  isl1= "0" + isl; 
						if(i<9)  sn = "0" + i; 
						String opsel="";				
						if(sn.equals(msel_sn)) opsel="Selected";

							if(i==0){
								out.println("<Option Value='mtype=mark&id="+patid+"&type="+itype+"&ser="+isl+"&dt="+pdt+"&mser="+msln+"&rcode="+refcode+"&sn="+sel_sn+"&msn="+sn+"' " + opsel +">Select</Option>");
							}

						out.println("<Option Value='mtype=mark&id="+patid+"&type="+itype+"&ser="+isl+"&dt="+pdt+"&mser="+msln+"&rcode="+refcode+"&sn="+sel_sn+"&msn="+sn+"' " + opsel +">"+itype+"-"+isl1+"-"+sn+"</Option>");
					}
					out.println("</SELECT></div>");  
				 }
				
			  } // else

			// for original images
			res = (Object)alldata.get(1);
			if(res instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
					for(int i=1;i<4;i++) out.println("&nbsp;");
					out.println("<div class='input-group'><span class='input-group-addon'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT></span>");
					out.println("<SELECT class='form-control' NAME=imgsh onChange='showselected($(this).val())'>"); //showselected(abc.value);
					//out.println("<option></option>");
					sn="";

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						//patpicurl = RSet.getString("PATPICURL");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String sl=datatemp.getValue("serno");
						//sn=sl;					
						if(i<9)  sn = "0" + i; 
						if(sel_sn.length()<2)  sel_sn = "0" + sel_sn; 

						String opsel="";

						out.println("sel_sn : "+sel_sn);

						if(sn.equals(sel_sn)) opsel="Selected";

						out.println("<Option Value='mtype=nomark&id="+patid+"&type="+itype+ "&ser="+sl+"&dt="+pdt+"&sn="+sn+"' " + opsel +">"+itype+"-"+sn+"</Option>");

					}

					out.println("</SELECT></div>");
				 }
				
			  } // else		
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

%>
</FONT></TD>
</Form></TR>
</TABLE>



<center>
	<%=data%>


	<TABLE Border=1>
	<TR><TD>		
<%

if(mtype.equalsIgnoreCase("nomark")){

	if(cnttype.equalsIgnoreCase("LRGFILE")){
		
		//dat=datmdy.replaceAll("/","");
		//dat=datmdy.replaceAll("-","");
		dat=datmdyPath;
		//itype=itype.toLowerCase();
		String fn=patid+dat+itype+isl+"."+ext;
		//out.println(fn);
		String dePath = "/data/"+patid+"/"+fn;
		String path = crypto.encrypt(dePath);
		String fpath="getFile.jsp?file="+URLEncoder.encode(path, StandardCharsets.UTF_8);
		out.println("<img class='img-responsive' src='"+fpath+"'>");
		}
	else
		out.println("<a href='zoomimage.jsp?src=displayimg.jsp?id="+patid+"&ser="+isl+"&type="+itype+"&mser="+msl+"&dt="+dat+"&rcode="+rcode+"' target='_blank'><img class='img-responsive' src='displayimg.jsp?id="+patid+"&ser="+isl+"&type="+itype+"&dt="+dat+"'></a>");
		//out.println("id="+patid+"&ser="+isl+"&type="+itype+"&dt="+dat);
}

if(mtype.equalsIgnoreCase("mark")){ 
		out.println("<img class='img-responsive' src='displaymarkimg.jsp?id="+patid+"&ser="+isl+"&type="+itype+"&mser="+msl+"&dt="+dat+"&rcode="+rcode+"'>");
	//out.println(" marking id="+patid+"&ser="+isl+"&type="+itype+"&mser="+msl+"&dt="+dat+"&rcode="+rcode);
}

%>

</TD></TR>
</TABLE>
</center>


</div>		<!-- "container-fluid" -->

</body>
</html>
