<%@page language="java"  import= "imedix.rcGenOperations,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
var ip11,ip22,ip33,ip44 ;

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



function checkcname(nam)
{
	x = nam;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	//while (x.substring(x.length-1,x.length) == ' ') x = x.substring(0,x.length-1); to strip traling blanks
	if (x.length == 0){ alert("Blank Center Name Not Allowed"); return false;}
	else if (x.length > 50){ alert("Center Name should not be more than 50 charracters"); return false;}
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

	ret = checkcname(document.frmCenter.name.value);
	if (ret == false)  {document.frmCenter.name.select(); return false;}

	ret = checkftpusr(document.frmCenter.ftp_user.value);
	if (ret == false)  {document.frmCenter.ftp_user.select(); return false;}

	ret = checkftppwd(document.frmCenter.ftp_pwd.value);
	if (ret == false)  {document.frmCenter.ftp_pwd.select(); return false;}

	ret = checkphone(document.frmCenter.phone.value);
	if (ret == false)  {document.frmCenter.phone.select(); return false;}

	ret = verifyIP(document.frmCenter.ipaddress.value);
	if (ret == false)  {document.frmCenter.ipaddress.select(); return false;}



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

</SCRIPT>

</HEAD>
<BODY background="../images/txture.jpg" >
   <button type="button" onclick="javacript:location.reload()" class="close" data-dismiss="modal">&times;</button>



<%
	///////


String eccode="",ecname="",ecphone="",ecipaddress="",ecftpip="",ecftpusr="",ectype="";
eccode=request.getParameter("cntcode").trim();
	///////
	cook cookx = new cook();
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));

	try {
		String ccode, ctype;
		Object res=cinfo.getRCentreInfo(eccode);

		if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
		else{
			Vector Vtmp = (Vector)res;
			for(int i=0;i<Vtmp.size();i++){
				dataobj datatemp = (dataobj) Vtmp.get(i);
				ccode = datatemp.getValue("code");

					ecname=datatemp.getValue("name").trim();
					ecphone=datatemp.getValue("phone").trim();
					ecipaddress=datatemp.getValue("ipaddress").trim();
					ecftpip=datatemp.getValue("ftpip").trim();
					ecftpusr=datatemp.getValue("ftp_uname").trim();
					ectype=datatemp.getValue("centertype").trim();


			} // end for
		}// end else


	}catch (Exception e) {
			out.println("SQL Error found <B>"+e+"</B>");
	}


%>

<center><h4 style="COLOR:RED">Edit Center</h4> </center>

<FORM role="form" METHOD="POST" ACTION="saveeditcenter.jsp" Name=frmCenter onsubmit="return checkval();">
<TABLE class="table ">
<TR BGColor="#330000">
	<TD> <FONT COLOR="YELLOW"><B> Code</B></FONT></TD>
	<TD> <FONT COLOR="YELLOW"><B> Name </B></FONT></TD>
	<TD> <FONT COLOR="YELLOW"><B> Phone </B></FONT></TD>

	<!-- <TD> <FONT COLOR="YELLOW"><B> IP Address </B></FONT></TD>
	<TD> <FONT COLOR="YELLOW"><B> FTP IP Address </B></FONT></TD>
	<TD> <FONT COLOR="YELLOW"><B> FTP User </B></FONT></TD>
	<TD> <FONT COLOR="YELLOW"><B> FTP Pwd </B></FONT></TD> -->

	<!-- <TD> <FONT COLOR="YELLOW"><B> &nbsp;&nbsp;Action </B></FONT></TD> -->
</TR>

<TR BGColor="#330000">
	<TD><INPUT class="form-control" TYPE="text" NAME="code" Value="<%=eccode %>" readonly ></TD>
	<TD><INPUT class="form-control" TYPE="text" NAME="name" Value="<%=ecname %>" Size=50></TD>
	<TD><INPUT class="form-control" TYPE="text" NAME="phone" Value="<%=ecphone %>" Size=10>


	<INPUT TYPE="hidden" NAME="ipaddress" MaxLength=15 Value="<%=ecipaddress%>" Size=15>
	<INPUT TYPE="hidden" NAME="ftpip" MaxLength=15 Value="<%=ecftpip%>" Size=15>
	<INPUT TYPE="hidden" NAME="ftp_uname" MaxLength=30 Value="<%=ecftpusr %>" Size=10>
	<INPUT TYPE="hidden" NAME="ftp_pwd" MaxLength=30 Size=10>
	<INPUT TYPE="hidden" NAME="centertype" value="<%=ectype %>">
	</TD>
</TD>

</TR>
</TABLE>


<BR>
<TABLE class="table ">
	<TR BGColor="#CCFFFF"><TD>
		<CENTER><B><font color='#3300FF'>Select Referred Hospital</font></B></CENTER>
	</TD><TR>

<TR><TD>
	<TABLE class="table table-hover">
	<TR>

		<%
		String refed_all=rcGen.getAnySingleValue("referhospitals","referred","code='"+eccode+"'");
		if(refed_all==null) refed_all="";
			try {
			int cnt=1;
			Object res=cinfo.getAllCentreInfo();
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String occode = temp.getValue("code").trim();
				String cname = temp.getValue("name").trim();
				if(cnt>3){
					out.println ("</TR><TR>");
					cnt=0;
				}
				cnt++;
				if(refed_all.indexOf(occode)>-1){
					out.println("<TD><INPUT type=checkbox name='Referred' Value='"+occode.trim()+"' checked>");
				}else{
					out.println("<TD><INPUT type=checkbox name='Referred' Value='"+occode.trim()+"'>");
				}
				out.println ("&nbsp;"+cname.trim()+"</TD>");

			}

		}
		catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");
		}
		%>

	</TR>
	</TABLE>
</TD></TR>

<TR BGColor="#CCFFFF"><TD>
	<CENTER><B><font color='#3300FF'>Select Referring Hospital</font></B></CENTER>
</TD><TR>

<TR><TD>

	<TABLE class="table table-hover">
	<TR>

		<%
			String refing_all=rcGen.getAnySingleValue("referhospitals","referring","code='"+eccode+"'");
			if(refing_all==null) refing_all="";
			try {
			int cnt=1;
			Object res=cinfo.getAllCentreInfo();
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String occode = temp.getValue("code").trim();
				String cname = temp.getValue("name").trim();
				if(cnt>3){
					out.println ("</TR><TR>");
					cnt=0;
				}
				cnt++;
				if(refing_all.indexOf(occode)>-1)
					out.println("<TD><INPUT type=checkbox name='Referring' Value='"+occode.trim()+"' checked>");
				else out.println("<TD><INPUT type=checkbox name='Referring' Value='"+occode.trim()+"'>");

				out.println ("&nbsp;"+cname.trim()+"</TD>");


			}

		}
		catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");
		}
		%>

		</TD>
	</TR>
	</TABLE>

</TD></TR>


	<TR>
		<TD align='center'>
			<INPUT class="form-control btn-primary" TYPE="submit" Value="Save">
			<INPUT TYPE="hidden" NAME="actiontype" value="UP">
		</TD>
	</TR>


</TABLE>


</FORM>
</BODY>
<HTML>
