<%@page language="java"  import= "imedix.rcGenOperations, imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter"%>
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
		<script src="../bootstrap/js/bootstrap-filestyle.min.js"></script>


<SCRIPT LANGUAGE="JavaScript">
var ip11,ip22,ip33,ip44 ;

function upperCase(obj){
	obj.value =obj.value.toUpperCase();
}

function verifyIP (IPvalue) {
var validChars = '.0123456789';
if (IPvalue.length == 0)
{
	alert ("Blank IP Not Allowed");
	return false;
}

if (IPvalue == "255.255.255.255")
{
	alert ("Invalid IP");
	return false;
}


//////////////
// only digits and dots will be allowed 
dots = 0;

    for (var i = 0; i < IPvalue.length; i++) {
       var chr = IPvalue.substring(i,i+1);
       if (validChars.indexOf(chr) == -1)
          { 	alert ("Characters and Special Character not allowed in IP");
				 return false;
		  }
       if (chr == '.') {
           dots++;
           eval('dot' + dots + ' = ' + i);
       }
    }
if (dots != 3)  //there must be only three dots
          { 	alert ("Invalid IP");
				 return false;
		  }
    
 // first and last position cannot be dot
	if (IPvalue.substring(0,1) == '.' || IPvalue.substring(IPvalue.length,IPvalue.length+1) == '.')
          { 	alert ("Invalid IP");
				 return false;
		  }

ip1 = IPvalue.substring(0,dot1);
    if (!ip1 || ip1 >255)
          { 	alert ("Invalid IP");
				 return false;
		  }
    ip2 = IPvalue.substring(dot1+1,dot2);
    if (!ip2 || ip2 >255)
          { 	alert ("Invalid IP");
				 return false;
		  }
    ip3 = IPvalue.substring(dot2+1,dot3);
    if (!ip3 || ip3 >255)
          { 	alert ("Invalid IP");
				 return false;
		  }
    ip4 = IPvalue.substring(dot3+1,IPvalue.length+1);
    if (!ip4 || ip4 >255)
          { 	alert ("Invalid IP");
				 return false;
		  }
	if(ip4 == 0) //last part of ip cannot be 0
          { 	alert ("Invalid IP");
				 return false;
		  }
    if (ip1 == 0 || ip2 == 0 || ip3 == 0 || ip4 == 0)  //ip cannot be 0.0.0.0
          { 	alert ("Invalid Machine IP");
				 return false;
		  }

/////////////
ip11=remzero(ip1,ip11);
ip22=remzero(ip2,ip22);
ip33=remzero(ip3,ip33);
ip44=remzero(ip4,ip44);

document.getElementById("ipaddress").value=ip11+"."+ip22+"."+ip33+"."+ip44

return true;
//return false;
}

function checkccode(cod)
{
	var validcodechr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	document.regc.code.value = document.regc.code.value.toUpperCase();
	cod = cod.toUpperCase();
	if ( cod.length == 0 ) 
	{ alert("Blank Center Code Not Allowed");return false;}
	if ( cod.length < 4 ) 
	{ alert("Center Code should be of 4 characters");return false;}
	
	for (var i = 0; i < cod.length; i++) {
       var chr = cod.substring(i,i+1);
       if (validcodechr.indexOf(chr) == -1)
          { 	alert ("Center Code should be Characters");
				 return false;
		  }
    }

	return true;
}

function checkcname(nam)
{
	x = nam;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Blank Center Name Not Allowed"); return false;}
	return true;
}
function checkftpusr(nam)
{
	x = nam;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Blank FTP User Name Not Allowed"); return false;}
	return true;
}
function checkftppwd(nam)
{
	x = nam;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Blank FTP Password Not Allowed"); return false;}
	return true;
}
function checkphone(phn)
{
	var validcodechr = ' 0123456789';
	x = phn;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	if (x.length == 0){ alert("Blank Phone Number Not Allowed"); return false;}

	for (var i = 0; i < phn.length; i++) {
       var chr = phn.substring(i,i+1);
       if (validcodechr.indexOf(chr) == -1)
          { 	alert ("Characters and Special Character not allowed in Phone Number");
				 return false;
		  }
    }

	return true;
}
function checkval()
{
	var ret;
	ret = checkccode(document.regc.code.value)
	if (ret == false)  {document.regc.code.select(); return false;}

	ret = checkcname(document.regc.name.value);
	if (ret == false)  {document.regc.name.select(); return false;}

	ret = checkftpusr(document.regc.ftp_User.value);
	if (ret == false)  {document.regc.ftp_User.select(); return false;}

	ret = checkftppwd(document.regc.ftp_pwd.value);
	if (ret == false)  {document.regc.ftp_pwd.select(); return false;}
	
	ret = checkphone(document.regc.phone.value);
	if (ret == false)  {document.regc.phone.select(); return false;}

	ret = verifyIP(document.regc.ipaddress.value);
	if (ret == false)  {document.regc.ipaddress.select(); return false;}
	
	
var ph=document.getElementById("phv").value;
if(ph=="."||ph.length<10||ph/1==ph)
{
return false;
}
return true;	
}
///// confirm deletion
function sure()
{
	var temp;
	temp=window.confirm('To confirm deletion click ok, otherwise click cancel');
	//alert(temp);
	return temp;
	
}

function remzero(ip,sip)
{
	if (ip < 10) 
	{
		//alert("less than 10");
		if(ip.length == 1) sip=ip;
		if(ip.length == 2) sip=ip.charAt(1);
		if(ip.length == 3) sip=ip.charAt(2);
	}
	else
		{
			if (ip>9 && ip < 100) 
			{
				if(ip.length == 2) {sip=ip; }
				if(ip.length == 3) {sip=ip.substring(1,3)}
			}
			else
				{ sip=ip; }
		}
	
	return sip;
}

function phonevalid()
{
var ph=document.getElementById("phv").value;
var ph1=ph*10;
if(ph=="."||ph.length<10||ph/1!=ph||ph.length>=11)
{
document.getElementById("phvd").style.color="#FF0000";
document.getElementById("phvd").innerHTML="Enter valid phone no";
}
else
{
document.getElementById("phvd").style.color="#00FF00";
document.getElementById("phvd").innerHTML="Valid !";
}
}
</script>
<script>
function fCheck(){
	var fname = document.getElementById("file").value;
	if(fname==null||fname==""){
	alert('Please attach .lic file');
   return false;
	}
	}

function extCheck(){
var filename = document.getElementById("file").value;
var valid_extensions = /(\.lic)$/i;   
if(valid_extensions.test(filename))
{ 
return true;
}
else
{
   alert('Invalid File');
   document.getElementById("file").value="";
   return false
}
}

function cofirmDel() {
    var x;
    if (confirm("Make sure no patient exists in this hospital. Do you really want to delete?") == true) {
        return true;
    } else {
        return false;
    }
    return false;
}

</script>

<style>
/*
table tr:nth-child(odd) td{
background-color:#ECF2E6;
color:#104661;
font-weight:bold;
}
table tr:nth-child(even) td{
	background-color:#F1F3F3;
	color:#456120;
}*/
</style>


</HEAD>
<BODY background="../images/txture.jpg" >
	<div class="container-fluid">
	
	<TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
	<TR>
		<TD><Font Size='5' color=#3300FF> <B>CENTER MANAGEMENT</B> </Font></TD>
		<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
	</TR>
	</TABLE>


<div class="container">
<br><div class="row">
<div class="col-sm-1">
</div>		<!-- "col-sm-1" -->
<div class="col-sm-10">
<center><span>List of Centers</span>

<button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#myModal">Add New Center</button>
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Add New Center<FONT COLOR="RED">(Upload .lic file)</FONT></h4>
        </div>
        <div class="modal-body">
		<%
			rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
			try {
			int cnt=1;
			Object res=cinfo.getAllCentreInfo();
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String occode = temp.getValue("code").trim();
				String cname = temp.getValue("name").trim();
				if(cnt>3){
					cnt=0;
				}
				cnt++;
			}

		}
		catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");		
		}
		%>			
			<%
			
			try {
			int cnt=1;
			Object res=cinfo.getAllCentreInfo();
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String occode = temp.getValue("code").trim();
				String cname = temp.getValue("name").trim();
				if(cnt>3){
					cnt=0;
				}
				cnt++;
			}

		}
		catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");		
		}
		%>



<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="centeraddconfirm.jsp" name="imgld" onsubmit="return fCheck()">


<div data-toggle="tooltip" data-placement="top" title="Path of the file for uploading"><input type="file" NAME="file" id="file" class="filestyle" onchange="extCheck()" data-buttonText="Choose File" data-buttonName="btn-primary" data-buttonBefore="true" data-icon="false" /></div>
	

	<BR>
	<center><input class="btn btn-primary" type="submit" value="Upload" onclick="return fCheck()"  style="background-color: '#FFE0C1'; color: '#000000'; font-weight:BOLD; font-style:oblique "></CENTER>

</FORM>
              
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>


<div class="table-responsive">
<table class="table table-condensed table-striped">
<thead>
<tr><th>ExpiresOn (DaysLeft)</th><th>Code</th><th>Name</th><th>Phone</th><th>Action</th></tr>
</thead>
<tbody>

<%

	cook cookx = new cook();
	Decryptcenter imc = new Decryptcenter();

	try {
		String ccode, ctype;
		Object res=cinfo.getAllCentreInfo();
		if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
		else{
			Vector Vtmp = (Vector)res;
			for(int i=0;i<Vtmp.size();i++){
				dataobj datatemp = (dataobj) Vtmp.get(i);
				ccode = datatemp.getValue("code");
				ctype =datatemp.getValue("centertype");
				if (ctype.toUpperCase().trim().equals("S")) {
					ctype = "Self";
				}
				else {
					ctype = "Remote";
				}
				
				String expdate = imc.decryptLicString(  datatemp.getValue("expdate") );
				java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
				java.util.Date today = new java.util.Date();
				long timeDiff = expDate.getTime() - today.getTime();
				long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
				String visibility = datatemp.getValue("visibility").trim();
				if (visibility.equalsIgnoreCase("Y")) {
					if (daysDiff<15) out.println ("<TR style='color:#F9B9AB'>");
					else out.println ("<TR style='color:#0A3C76'>");
					out.println ("<TD>" + (new java.text.SimpleDateFormat("MM-dd-yyyy").format(expDate)) + " (" + daysDiff +  ") </TD>");
					out.println ("<TD>" + datatemp.getValue("code") + "</TD>");
					out.println ("<TD>" + datatemp.getValue("name")  + "</TD>");
					//out.println ("<TD>&nbsp;&nbsp;" + datatemp.getValue("address")  + "&nbsp;&nbsp;</TD>");
					out.println ("<TD>" + datatemp.getValue("phone") + "</TD>");
					//out.println ("<TD>&nbsp;&nbsp;" + datatemp.getValue("ipaddress")  + "&nbsp;&nbsp;</TD>");
					//out.println ("<TD>&nbsp;&nbsp;" + ctype  + "&nbsp;&nbsp;</TD>");
					//out.println ("<TD ALIGN='Center'><A HREF='clientinfo.jsp?sip=" + datatemp.getValue("ipaddress")  +"' Style='text-decoration: none'><img src='../images/urbbul.gif' width=15 height=15 border=0> </A></TD>");
					out.println ("<TD>");
					out.println ("<A HREF='editcenter1.jsp?cntcode="+ccode+"' data-toggle='modal' data-target='#surajit' Style='text-decoration: none'>Edit</A>");
				}
			
%>			
			
			
			 <div class="modal fade"  id="surajit" role="dialog"  >
    <div class="modal-dialog modal-xs" >
      <div class="modal-content" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Edit Center</h4>
        </div>
        <div class="modal-body">
 
 

 
        
        </div>		<!-- "modal-body" -->
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
			
			
			
<%			
			if (ctype.equals("Self"))  out.println ("&nbsp;|&nbsp;<FONT  COLOR=RED>Del</FONT>");
			else
				out.println ("<A HREF='deletecenter.jsp?cntcode="+ccode+"' Style='text-decoration: none' onclick = 'return cofirmDel()'>Del</A>");
			

			out.println ("</TD>");
			out.println ("</TR>");


			} // end for
		}// end else

		
	}catch (Exception e) {
			out.println("SQL Error found <B>"+e+"</B>");		
	}
	
	
%>

</tbody>

</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-6" -->

<div class="col-sm-1">
<!--<center><A class="btn btn-warning" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">BACK</A></center>-->


</div>		<!-- "col-sm-1" -->

</div>		<!-- "row" -->
</div>		<!-- "container" -->
</BODY>


</HTML>
