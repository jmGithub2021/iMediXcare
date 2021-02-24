<%@page contentType="text/html" import="telem.*,imedix.rcDisplayData,imedix.dataobj,imedix.cook, imedix.myDate,java.util.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
		String ext="",imgdirname="",imgnam="",isl="",itype="",fname="",mtype="",marname="",msl="";
		String imgname="",ccode="",usr="",patid="",pdt="",dt1="",dt="",rcode="",sn="",dat="";

		mtype=request.getParameter("mtype");
		//out.println("mtype="+mtype);
/*
  if(mtype.equals("nommark")){
		patid=request.getParameter("id");
		isl=request.getParameter("ser");
		ty=request.getParameter("type");
		endt=request.getParameter("dt");
		endt=endt.substring(6)+"/"+endt.substring(3,5)+"/"+endt.substring(0,2);
		imgname=ty+"-"+isl+"#";
	}

	if(mtype.equals("mark")){
		patid=request.getParameter("id");
		isl=request.getParameter("ser");
		msl=request.getParameter("mser");
		ty=request.getParameter("type");
		rcode=request.getParameter("rcode");
		endt=request.getParameter("dt");
		endt=endt.substring(6)+"/"+endt.substring(3,5)+"/"+endt.substring(0,2);
		marname=ty+"-"+isl+"-"+msl+"#";
		}
*/
	Object res=null;
	Vector alldata=null;
	int tag=0;
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	ccode = cookx.getCookieValue("center", request.getCookies ());
	usr = cookx.getCookieValue("userid", request.getCookies());
	patid=request.getParameter("id");
	itype=request.getParameter("type");
	isl=request.getParameter("ser");
	dat=request.getParameter("dt");

	if(mtype.equals("nomark")) imgname=itype+"-"+isl+"#";

	if(mtype.equalsIgnoreCase("mark"))
	{	msl=request.getParameter("mser");
		rcode=request.getParameter("rcode");
		marname=itype+"-"+isl+"-"+msl+"#";
	}

	String Node=patid.substring(0,3).toLowerCase();
	dt=dat.substring(6)+"/"+dat.substring(3,5)+"/"+dat.substring(0,2);
	String fdt =dat.replaceAll("/","");
	alldata= (Vector)ddinfo.getImgdetailsOtherimgMarkimg(mtype,patid,itype,dt,isl,msl,rcode);
		
			try
			{
				if(mtype.equals("nomark"));
				{
					byte [] _blob =ddinfo.GetImage(patid,dt,itype,isl);
					imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/"+patid+"/";;
					//imgdirname = gblDataDir +"//"+ccode.toLowerCase()+"//"+pid.toLowerCase()+"//images";
					fname=patid+fdt+itype+isl+".dcm";
					fname=fname.toLowerCase();
					imgnam = imgdirname+fname;

					File fdir = new File(imgdirname);
					if(!fdir.exists()){
						boolean yes1 = fdir.mkdirs();
					}

					File fimg = new File(imgnam);
					if(!fimg.exists())
					{
						RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
						raf.write(_blob);
						raf.close();
					}
				
				} //end of if (mtype.equals("mark"))

				if(mtype.equals("mark"))
				{
					byte [] _blob =ddinfo.getRImage(patid,dt,itype,msl,isl,rcode);
					imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/refimages/"+patid+"/";
					fname=patid+fdt+itype+isl+msl+".dcm";
					fname=fname.toLowerCase();
					imgnam = imgdirname+fname;

					//imgdirname = gblDataDir +"//"+ccode.toLowerCase()+"//"+pid.toLowerCase()+"//images//refimages";
					//imgnam = imgdirname+"//"+pid.toLowerCase()+dt+ty.toLowerCase()+isl+msl+"."+ext;
					//fname=pid.toLowerCase()+dt+ty.toLowerCase()+isl+msl+"."+ext;

					File fdir = new File(imgdirname);
					if(!fdir.exists())
					{
					boolean yes1 = fdir.mkdirs();
					}
					File fimg = new File(imgnam);
					if(!fimg.exists())
					{
					RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
					raf.write(_blob);
					raf.close();
					}
				} // end of if(mtype.equals("mark"))
				
				DicomDecoder ddobj=new DicomDecoder(imgdirname,fname);
				
					
			}catch(Exception e){
				out.println("Error in getbinary data : "+e.toString());
			}
%>
<html>
<head>
<title>Image Effects</title>
<style>
A { text-decoration: None;
	color: BLUE;
	font-weight: BOLD;
};
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
function showselected(val)
{
//var val=document.frm.abc.value;
var tar;
tar="showdicom.jsp?"+val;
//alert(tar);
window.location=tar;

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
	//alert(getCookie("selmark"));
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
	//alert(getCookie("selmark"));
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
	//alert(newval)
	//alert(getCookie("selimg"));
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
	//alert(getCookie("selimg"));
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
</SCRIPT>
</head>

<BODY>
<TABLE Border=0 Width=700>

<TR><Form name=frm><TD><FONT SIZE="3pt" COLOR="RED">
<%



	boolean found=false;
	//String refcode="",remcode="";

	boolean ref=true;
	String usrtyp="";
	usrtyp = cookx.getCookieValue("usertype", request.getCookies());
	usrtyp = usrtyp.trim();

	
	out.println("<B>[</B>&nbsp;<A Href=javascript:location.reload()>Refresh</A>&nbsp;");


	if (usrtyp.equalsIgnoreCase("doc")  && mtype.equalsIgnoreCase("nomark") ) {
		out.println("<B>|</B> <A Href=\'markdicomimg.jsp?patid="+patid+"&type="+itype+"&isl="+isl+"&dt="+dat+"/'><B>|</B>&nbsp; Dicom Marking</A>&nbsp;<B>]</B><BR>");
	}
	else {
		out.println("<B>]</B></BR>");
	}

			//telemedicin req
			//String utype="";
			//utype = thisObj.getCookieValue("type", request.getCookies ());
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
			{ }

			}

			out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			if(found == true)
			{
			out.println(" checked");
			}
			out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT>");
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

			out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			if(found == true)
			{
			out.println(" checked");
			}
			out.println(" onClick='setvaluemark(seltele.checked);'> Select for Teleconsultation</FONT>");

		} // end of if(mtype.equals("mark")



try
		{
			res = (Object)alldata.get(0);
			if(res instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>1 ) {
					for(int i=1;i<10;i++) out.println("&nbsp;");
					out.println("<FONT SIZE='-1' COLOR='#0080C0'>View Marked Images : </FONT>");
					out.println("<SELECT NAME=imgmark onChange='showselected(imgmark.value);'>"); 
					out.println("<option></option>");

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String refcode=datatemp.getValue("ref_code");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String msln=datatemp.getValue("serno");
						sn=isl;
						if(sn.length()<2)  sn= "0" + sn; 

						out.println("<Option Value='mtype=mark&id="+patid+"&type="+itype+"&ser="+isl+"&dt="+dt1+"&mser="+msln+"&rcode="+refcode+"' >"+itype+"-"+sn+"-"+msl+"</Option>");
					}
					out.println("</SELECT>");  
				 }
				
			  } // else

			// for original images
			res = (Object)alldata.get(1);
			if(res instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>1 ) {
					for(int i=1;i<10;i++) out.println("&nbsp;");
					out.println("<FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT>");
					out.println("<SELECT NAME=imgsh onChange='showselected(imgsh.value);'>"); //showselected(abc.value);
					out.println("<option></option>");

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						//patpicurl = RSet.getString("PATPICURL");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String sl=datatemp.getValue("serno");
						sn=sl;
						if(sn.length()<2)  sn= "0" + sn; 
						out.println("<Option Value='mtype=nomark&id="+patid+"&type="+itype+"&ser="+sl+"&dt="+dt1+"' >"+itype+"-"+sn+"</Option>");

					}
					out.println("</SELECT>");
				 }
				
			  } // else		
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

%>
<HR Color=PINK>
</FONT></TD>
</Form></TR>
<TR><TD colspan=2>
<%

   String sqlQuery, id="", imgdesc="", labname="",docname="",fpath="";
	String data="",hdata="";
	int ind=0;
   	String Str="";
  	String hed="",ss="";

		try {
		FileInputStream hfin = new FileInputStream(imgdirname+"/DicomHeader.txt");
		do{
			ind= hfin.read();
			if((char) ind != '\n') Str = Str + (char) ind;
		else {
		        hed+=Str+"<BR>";
				Str="";
			}
		}while(ind != -1);

		 for(int i=0;i<hed.length();i++)
		{
			if(!hed.substring(i,i+1).equals("\'"))
			{
				ss+=hed.substring(i,i+1);
			}
		}
	}catch(Exception e) {
		out.println("error.."+e.getMessage());
		data = e.toString();
	}
	
%>
<TABLE Border=0 Width=100%>
<TR>
	<TD VAlign="TOP" Align="left" Width=10%>

	 <A HREF="#" OnClick="javascript:writetoLyr('contentLYR', '<%=ss%>');">
	<IMG SRC="../images/pen.jpg" WIDTH="40" HEIGHT="40" BORDER=0 ALT="">

 	</A>
	</TD><TD>

	<%

	if(mtype.equalsIgnoreCase("nomark"))
	{
		fpath="/temp/"+usr+"/images/"+patid+"/"+fname;
		out.println("<img src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".bmp"+" width=512 height=512 >");
	}

	if(mtype.equalsIgnoreCase("mark"))
	{
		fpath="/temp/"+usr+"/images/refimages/"+patid+"/"+fname;
		out.println("<img src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".jpg"+" width=512 height=512 >");
	}

	%>
</TD></TR>
</TABLE>
</TD>
</TR></TABLE>
 <div id="contentLYR" style="position:absolute;  z-index:1; width: 250px; left: 20px; top: 100px; height: 80px; background: #CCFF99; visibility:hidden; ">
 </div>

</body>
</html>
