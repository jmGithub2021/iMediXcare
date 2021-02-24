<%@page contentType="text/html" import="imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<HTML>
<HEAD>

<center><TITLE> Registration Form </TITLE></center>
<SCRIPT language="JavaScript" type="text/javascript">

	function chk()
	{
		if(document.frmreg.type.value != "doc" )
		{
			document.frmreg.doc_regno.disabled = true
			document.frmreg.dis.disabled = true
			//document.frmreg.sign.disabled = true
		}
		else
		{
			document.frmreg.doc_regno.disabled = false
			document.frmreg.dis.disabled = false
			//document.frmreg.sign.disabled = false
		}

	}
///

function validate()
		{
			var na, msg=0;
			var ret;
			var tmp; var tnum;
			if (document.frmreg.uid.value.length == 0) { msg=1; na="uid"; }
			if (document.frmreg.name.value.length == 0) { msg=1; na="name"; }
			if (document.frmreg.phone.value.length == 0) { msg=1; na="phone"; }
			if (document.frmreg.address.value.length == 0) { msg=1; na="address"; }
			if (document.frmreg.pwd.value.length == 0) { msg=1; na="pwd"; }
			if (document.frmreg.cpwd.value.length == 0) { msg=1; na="cpwd"; }

			if (msg == 1)
			{
				window.alert ("Do not Leave the Field(s) Empty ");
				return false;
			}

			ret = checkphone(document.frmreg.phone.value);
			if (ret == false)  {document.frmreg.phone.select(); return false;}

			if (document.frmreg.pwd.value != document.frmreg.cpwd.value)
				{
					window.alert ("Password MisMatch,  Please Re-type it");

					document.frmreg.pwd.focus();
					return false;
				}

			if (document.frmreg.type.value == "doc" && document.frmreg.rg_no.value.length == 0)
			{
					window.alert ("Doctors must provide Registration Number");

					document.frmreg.rg_no.focus();
					return false;
			}

			//if (document.frmreg.type.value == "doc" && document.frmreg.sign.value.length == 0)
			//	{
			//		window.alert ("Provide the name of Signature file");

			//		document.frmreg.sign.focus();
					//document.add.sign.value = "C:\Telemed\Bin\Blank.Jpg"
			//		return false;
			//	}

			if(document.frmreg.type.value == "doc")
			{
				//check the pattern of registration number
				// the format is : <2 charecter State Code><1 digit type of activity oh health care professional>.<dot as delimiter><6 digit registration no. from state of graduation>
				// example : KAP.019184 [ka - karnataka; P: physician; 019184 - registration no. with karnataka medical council
				if(document.frmreg.rg_no.value.length < 10)
				{
					window.alert ("**Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");
					return false;
					document.frmreg.rg_no.focus();
					return false;
				}
				if(document.frmreg.rg_no.value.substring (3,4) != ".")
				{
					//alert(document.add.rgn.value.substring (3,4));
					window.alert (" !! Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");

					document.frmreg.rg_no.focus();
					return false;
				}
				for(i=0;i<3;i++)
				{
					tmp=document.frmreg.rg_no.value.substring (i,i+1);
					if ((tmp >= 'a' && tmp <= 'z') || (tmp >= 'A' && tmp <= 'Z') ) continue;
					else
					{
						window.alert ("Provide Registration Number in correct format is : SST.6 digit Registration Number");

						document.frmreg.rg_no.focus();
						return false;
					}
				}

			}
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

////

	function validatefield(chk)
	{
	var e = document.frmreg.uid.value;
	if (e == "")
	{
		 alert("Login Id can't be left blank ");
		 return false;
	}

////

	}
	function validatepass(chk)
	{

		var p1 = document.frmreg.pwd.value;
		var c1 = document.frmreg.cpwd.value;
		if (p1 != c1)
		{
			 alert("The Given password does not Match, Please Reenter Password");
		}
	}

	function setsign()
	{
		if (document.getElementById("type").value != "doc") {
//			window.alert (document.getElementById("type").value);

			document.getElementById("dis").disabled = true;
			document.getElementById("doc_regno").disabled = true;
			//document.getElementById("sign").disabled = true;
		}
		else {
			document.getElementById("dis").disabled = false;
			document.getElementById("doc_regno").disabled = false;
			//document.getElementById("sign").disabled = false;
		}


	}


</SCRIPT>

</HEAD>

<BODY BGColor="#FFFFFF" onload="chk(); document.frmreg.uid.focus();">
<center><H3>Registration Form </H3>
<hr width=100% >
<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="../servlet/saveregusers" NAME="frmreg">
<TABLE>
<TR>
	<TD>Login ID</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="uid" MAXLENGTH=15 onBlur='validatefield()' ></TD>
</TR>
<TR>
<TD> </TD>
<TD> </TD>
<TD><Font size=-2 color=brown><B>(Six Character or more)</B></Font></TD>
</TR>
<TR>
	<TD>PassWord</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="password" NAME="pwd" MAXLENGTH=15 ></TD>
</TR>
<TR>
<TD> </TD>
<TD> </TD>
<TD><Font size=-2 color=brown><B>(Six Character or more)</B></Font></TD>
</TR>
<TR>
	<TD>Confirm password</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="password" NAME="cpwd" MAXLENGTH=15 onBlur='validatepass()'></TD>
</TR>
<TR>
	<TD>Name</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="name" MAXLENGTH=25></TD>
</TR>

<TR>
	<TD>Address</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="address" MAXLENGTH=30></TD>
</TR>
<TR>
	<TD>EmailID</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="emailid" MAXLENGTH=30></TD>
</TR>
<TR>
	<TD>Phone</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="phone" MAXLENGTH=15></TD>
</TR>
<TR>
	<TD>Qualification</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="qualification" MAXLENGTH=30></TD>
</TR>
<TR>
	<TD>Designation</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="designation" MAXLENGTH=30></TD>
</TR>


<TR>
	<TD>Hospital Name</TD>
	<TD>:</TD>
	<TD><SELECT NAME="center">

	<%
		try
		{
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
					} // end for
			}// end else
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

	  %>
	  </SELECT>
	</TD>
</TR>





<TR>
	<TD>User Type</TD>
	<TD>:</TD>
	<TD><SELECT NAME="type" Size=1 OnClick='chk()'>
		<Option Value="adm">Administrator</Option>
		<Option Value="doc">Doctors</Option>
		<Option Value="con">Counselor</Option>
		<Option Value="usr">Data Enry Operator</Option>
		</SELECT>
	</TD>
</TR>
<!-- onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')"
 -->
 <!-- <TR>
   <td> Path of the file for uploading: </TD>
   <TD></TD>
   <TD><INPUT TYPE=file NAME="sign" size=30>
   </TD><TD><Font size=-2 color=brown><B>(doctors only)</B></Font></TD>
   </TR> -->

<TR>
	<TD>Disease Type</TD>
	<TD>:</TD>
	<TD><SELECT name="dis" >
	<%
	try{
		rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
		Object depts = ddinfom.getDepartments(ccode);
		Vector deptsV = (Vector)depts;
		String options = "";
		for(int i=0;i<deptsV.size();i++){
			dataobj obj = (dataobj)deptsV.get(i);
			options += "<option value='"+obj.getValue("department_name")+"'>"+obj.getValue("department_name")+"</option>";
		}
	/*FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
	int i;
	String strn1="";
	do{
		i = fin.read();
		if((char) i != '\n')
			strn1 = strn1 + (char) i;
		else {
				strn1 = strn1.replaceAll("\n","");
			strn1 = strn1.replaceAll("\r","");
			out.println("<option value='" + strn1 + "'>" + strn1 + "</Option>");
			strn1="";
		}
	}while(i != -1);
	fin.close();*/
	out.println(options);
}catch(Exception e){
	System.out.println(e.toString());
}
	/*
	FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
	int i;
	String str="";
	do{
		i = fin.read();
		if((char) i != '\n')
			str = str + (char) i;
		else {
			out.println("<option value='" + str + "'>" + str + "</Option>");
			str="";
		}
	}while(i != -1);

	fin.close();*/
	%>
</SELECT>
</TD><TD><Font size=-2 color=brown><B>(doctors only)</B></Font></TD>
</TR>
<TR>
	<TD>Regn No</TD>
	<TD>:</TD>
	<TD><INPUT TYPE="text" NAME="doc_regno" MAXLENGTH=30></TD>
	<TD><Font size=-2 color=brown><B>(doctors only)</B></Font></TD>
</TR>
<TR>
	<TD colspan=3 align=center><INPUT TYPE="reset" Value="Reset">
	<INPUT TYPE="submit" Value="Submit" onclick="return validate()" ></TD>
</TR>
</TABLE>

</FORM>
<hr width=100% >
</center>
</BODY>
</HTML>
