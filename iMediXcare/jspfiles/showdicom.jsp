<%@page contentType="text/html" import="telem.*,imedix.rcDisplayData,imedix.dataobj,imedix.cook, imedix.myDate,java.util.*,java.io.*, org.apache.commons.io.FileUtils" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
		String ext="",imgdirname="",imgnam="",isl="",itype="",fname="",mtype="",marname="",msl="";
		String imgname="",ccode="",usr="",patid="",pdt="",dt1="",dt="",rcode="",sn="",dat="";
		
		mtype=request.getParameter("mtype");
		//out.println("mtype="+mtype);

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

	
	//dt=dat.substring(6)+"/"+dat.substring(3,5)+"/"+dat.substring(0,2);
	dt=dat;

	String fdt =dat.substring(8,10)+ dat.substring(5,7)+ dat.substring(0,4) ; // .replaceAll("-",""); 2008/12/90

	//out.println(fdt);

	alldata= (Vector)ddinfo.getImgdetailsOtherimgMarkimg(mtype,patid,itype,dt,isl,msl,rcode);
	
   Object res11 = (Object)alldata.get(2);
   String extension = ".dcm";
   if(res11 instanceof String){ tag=1;}
   else{
		Vector Vtmp = (Vector)res11;
		dataobj datatemp = (dataobj) Vtmp.get(0);
		extension = datatemp.getValue("ext");
		}	
	try{				
		
		if(mtype.equals("nomark"));
		{
			String cont_type=ddinfo.GetImageCon_type(patid,dt,itype,isl);

			imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/"+patid+"/";;
			//imgdirname = gblDataDir +"//"+ccode.toLowerCase()+"//"+pid.toLowerCase()+"//images";
			fname=patid+fdt+itype+isl+"."+extension;
			//fname=fname.toLowerCase();
			imgnam = imgdirname+fname;

			File fdir = new File(imgdirname);
			if(!fdir.exists()){
				boolean yes1 = fdir.mkdirs();
			}


			if(cont_type.equalsIgnoreCase("LRGFILE")){
				String srcimgdire=request.getRealPath("//")+"/data/"+patid+"/";
				String srcfname=patid+fdt+itype+isl+"."+extension;
				
				//myDate.copyfile(srcimgdire+srcfname,imgnam);
				FileUtils.copyFile(new File(srcimgdire+srcfname),new File(imgnam));

			}else{
				byte [] _blob =ddinfo.GetImage(patid,dt,itype,isl);
				File fimg = new File(imgnam);
				if(!fimg.exists())
				{
					RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
					raf.write(_blob);
					raf.close();
				}
			}
		} //end of if (mtype.equals("nomark"))



		if(mtype.equals("mark"))
		{
			byte [] _blob =ddinfo.getRImage(patid,dt,itype,msl,isl,rcode);
			imgdirname=request.getRealPath("//")+"/temp/"+usr+"/images/refimages/"+patid+"/";
			fname=patid+fdt+itype+isl+msl+".dcm";
			//fname=fname.toLowerCase();
			imgnam = imgdirname+fname;
			//out.println("surajit : "+imgdirname+fname);
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

		try{
			
			//out.println("<br>"+imgdirname);
			//out.println("<br>"+fname);

			DicomDecoder ddobj=new DicomDecoder(imgdirname,fname);

		} catch (Exception e){
			   out.println("Error DicomDecoder : "+ e.toString());
		}
				String sbmp = imgnam.substring(0, imgnam.lastIndexOf(".")) + ".bmp";
				String sjpg = imgnam.substring(0, imgnam.lastIndexOf(".")) + ".jpg";
				//out.println("sbmp: " + sbmp);
				//out.println("sjpg: " + sjpg);
				
				
				File f1=new File(sbmp);
				if(f1.exists()){
					//out.println(sbmp);
					//out.println(sjpg);
					Runtime rt = Runtime.getRuntime();
					String osname=System.getProperty("os.name");
				//	out.println("osname :"+osname+"<BR>");

					try{
						if(osname.startsWith("W") || osname.startsWith("w")){
							String as[] = new String[3];
							as[0] = request.getRealPath("/")+"jspfiles/shellscripts/cjpeg.exe";
							as[1] = "\"" + sbmp + "\"";
							as[2] = "\"" + sjpg + "\"";
							Process proc = rt.exec(as);
							int x=proc.waitFor();
						}else if(osname.startsWith("L") || osname.startsWith("l")){

	Process proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/convertjpg.sh "+sbmp+" "+sjpg);
							int x=proc.waitFor();
						}

					} catch (Throwable t){
						   out.println("Error in Shell Script : "+ t.toString());
					}
			 } // end if f1
				
			}catch(Exception e){
				      //StringWriter sw = new StringWriter();
					  //PrintWriter pw = new PrintWriter(sw);
                      //e.printStackTrace(pw);
                      //out.println(sw.toString().toUpperCase());
					//out.println("surajit : "+imgdirname+fname);
				//e.printStackTrace(out);
				//out.println("Error in getbinary data : "+e.toString());
			}
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

<div class="container-fluid">


<div class="row">
<div class="col-sm-4 ">
<A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >Print this Document</A>
</div>		<!-- "col-sm-4" -->
<div class="col-sm-4"></div>
<div class="col-sm-4">
<FONT SIZE = 3 COLOR= blue ><b>ID:&nbsp;<%=patid%> </b></FONT>
</div>		<!-- "col-sm-4" -->
</div>		<!-- "row" -->


<TABLE class="table table-bordered" style="background:#CBF7FE;">
<TR><Form name=frm><TD><FONT SIZE="3pt" COLOR="RED">
<%



	boolean found=false;
	//String refcode="",remcode="";

	boolean ref=true;
	String usrtyp="";
	usrtyp = cookx.getCookieValue("usertype", request.getCookies());
	usrtyp = usrtyp.trim();

	
	out.println("<B>[</B>&nbsp;<A class='btn btn-default btn sm' Href=javascript:location.reload()>Refresh</A>&nbsp;");


	if (usrtyp.equalsIgnoreCase("doc")  && mtype.equalsIgnoreCase("nomark") ) {
		out.println("<B>|</B> &nbsp;<B>|</B>&nbsp;<A class='btn btn-info' Href=\'markdicomimgmodified.jsp?patid="+patid+"&type="+itype+"&isl="+isl+"&dt="+dat+"'> <b>Dicom Marking</b></A>&nbsp;<B>]</B>&nbsp;&nbsp;");
	}
	else {
		out.println("<B>]</B>&nbsp;&nbsp;");
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

			//out.println("<FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
				//if(found == true)
				//{
				//out.println(" checked");
				//}
				//out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT>");
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



try{
			res = (Object)alldata.get(0);
			if(res instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
					for(int i=1;i<3;i++) out.println("&nbsp;");
					out.println("<div class='input-group'><span class='input-group-addon'><FONT SIZE='-1' COLOR='#0080C0'>View Marked Images : </FONT></span>");
					out.println("<SELECT class='form-control' NAME=imgmark onChange='showselected(imgmark.value);'>"); 
					out.println("<option></option>");

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String refcode=datatemp.getValue("ref_code");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String msln=datatemp.getValue("serno");
						sn=isl;
						if(sn.length()<2)  sn= "0" + sn; 

						out.println("<Option Value='mtype=mark&id="+patid+"&type="+itype+"&ser="+isl+"&dt="+pdt+"&mser="+msln+"&rcode="+refcode+"' >"+itype+"-"+sn+"-"+msln+"</Option>");
					}
					out.println("</SELECT></div>");  
				 }

			  } // else

			// for original images
			res = (Object)alldata.get(1);
			if(res instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>1 ) {
					for(int i=1;i<3;i++) out.println("&nbsp;");
					out.println("<div class='input-group'><span class='input-group-addon'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT></span>");
					out.println("<SELECT class='form-control' NAME=imgsh onChange='showselected(imgsh.value);'>"); //showselected(abc.value);
					out.println("<option></option>");

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						//patpicurl = RSet.getString("PATPICURL");
						pdt = datatemp.getValue("entrydate");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String sl=datatemp.getValue("serno");
						sn=sl;
						if(sn.length()<2)  sn= "0" + sn; 
						out.println("<Option Value='mtype=nomark&id="+patid+"&type="+itype+"&ser="+sl+"&dt="+pdt+"' >"+itype+"-"+sn+"</Option>");
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
<HR Color=PINK>


<% 
   
   String ty="",imgdesc="", labname="",docname="",remcode="";
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
		String tstdat=datatemp.getValue("testdate");
		docname = datatemp.getValue("doc_name");
		data = "<div class='table-responsive'><TABLE class='table table-bordered'>";
		data = data + "<TR><TD>Description</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+imgdesc+"</B></TD>";
		data = data + "<TD width='20' > </TD>";
		data = data + "<TD>Lab Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+labname+"</B></TD></TR>";

		data = data + "<TR><TD>Doctor Name</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+docname+"</B></TD>";
		data = data + "<TD width='20' > </TD>";
		data = data + "<TD>Date of Test</TD>";
		data = data + "<TD><B>:</B></TD><TD><B>"+tstdat.substring(8,10)+"-"+tstdat.substring(5,7)+"-"+tstdat.substring(0,4)+"</B></TD></TR>";

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
	
%>
<center>
	
	<%=data%>
	<HR Color=PINK>
 </center>
<%

  	data="";
	String hdata="",fpath="";
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

<TABLE Border=0>
<TR><TD>

<TABLE Border=0 Width=100%>
<TR>
	<td Width='80'>

	</td>
	<TD VAlign="TOP" Align="left" Width=10%>
	 <A HREF="#" OnClick="javascript:writetoLyr('contentLYR', '<%=ss%>');">
	<IMG SRC="../images/pen.jpg" WIDTH="40" HEIGHT="40" BORDER=0 ALT="">

 	</A>
	</TD>
	<TD>
	<%

	if(mtype.equalsIgnoreCase("nomark"))
	{
		fpath="/temp/"+usr+"/images/"+patid+"/"+fname;
		//out.println("<img src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".jpg"+" width=512 height=512 >");
		out.println("<img class='img-responsive img-thumbnail' src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".jpg"+" >");
	}

	if(mtype.equalsIgnoreCase("mark"))
	{
		fpath="/temp/"+usr+"/images/refimages/"+patid+"/"+fname;
		//out.println("<img src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".jpg"+" width=512 height=512 >");
		out.println("<img  class='img-responsive img-thumbnail' src=.."+fpath.substring(0,fpath.lastIndexOf('.'))+".jpg"+" >");
	}

	%>
</TD></TR>
</TABLE>
</TABLE>

 <div id="contentLYR" style="position:absolute;  z-index:1; left: 135px; top: 190px; background: #DCE9F0; visibility:hidden; ">
 </div>

</div>		<!-- "container-fluid" -->

</body>
</html>
