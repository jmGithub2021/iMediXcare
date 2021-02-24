<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<%
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());

	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	String us, ps;
	boolean found=false;;

	//rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	//rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	String sccode=request.getParameter("sccode");


	if(sccode==null) sccode=ccode;
	if(sccode.equals("")) sccode=ccode;
	String cond="active='Y' ";
	if(sccode.equals("XXXX")){
		cond+=" and center <> 'XXXX'  order by center,type,name";
	}else{
		cond+=" and center = '"+sccode+"'"+ " order by center,type,name";
	}
%>


<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


<SCRIPT LANGUAGE="JavaScript">
function sure()
{
	var temp;
	temp=window.confirm('To confirm deletion click ok, otherwise click cancel');
	//alert(temp);
	return temp;

}

	function showselected(val){
		var tar;
		tar="showusers.jsp?sccode="+val;
		//alert(tar);
		window.location=tar;
	}

	function getDeptSYSADMIN()
	{
		console.log($('#HOS').val());
		centercode=$('#HOS').val();
		$.get('listDepartments.jsp?ccode='+centercode, function(data,status){
			console.log(data);
			$('#dis').html(data);

		});

	}

</SCRIPT>

<style>
input[type=checkbox]{
    margin:0;
    height: 22px;
    width: 33px;
}
table tr:nth-child(odd) td {
    background-color: #B8C8DB;
    color: #104661;
}
table tr:nth-child(even) td {
    background-color: #B3D0EC;
    color: #456120;
}
</style>


</HEAD>
<body background="../images/txture.jpg">
	<TABLE class="table" width=90% border=0 Cellpadding=0 Cellspacing=0>
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>MANAGE USERS AND DOCTORS</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
	</TABLE>
<div class="container-fluid">
<br><br><div class="row">
<div class="col-sm-4">
<div class="input-group">
<span class="input-group-addon"  style="color:blue;font-weight:bold">System Users</span>

<button type="button" class=" form-control btn btn-info" data-toggle="modal" data-target="#myModal">Add New User</button>
</div>		<!-- "input-group" -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" ><center>Registration Form</center></h4>
        </div>
        <div class="modal-body">

<SCRIPT language="JavaScript" type="text/javascript">

	function toggleCheckBoxes(source, FieldName) {
		//$(".")
		if(!document.forms['frmuser']) return;
			var objCheckBoxes = document.forms['frmuser'].elements[FieldName];
			//alert(objCheckBoxes);
			if(!objCheckBoxes) return;

			var countCheckBoxes = objCheckBoxes.length;
			if(!countCheckBoxes) objCheckBoxes.checked = source.checked;
			else
				// set the check value for all check boxes
				for(var i = 0; i < countCheckBoxes; i++)
					objCheckBoxes[i].checked = source.checked;
	}


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
			console.log(document.frmreg.doc_regno.value);
			console.log(document.frmreg.dis.value);

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
			if(document.frmreg.emailid.value.length!=0)
			{
				if(!validateEmail(document.frmreg.emailid.value))
				{
					window.alert ("Please give correct Email ID !");
				}
			}

			if (document.frmreg.type.value == "doc" && document.frmreg.doc_regno.value.length == 0)
			{
					window.alert ("Please give Doctor's Registration Number");

					document.frmreg.doc_regno.focus();
					return false;
			}
			if (document.frmreg.type.value == "doc" && document.frmreg.dis.value == "NIL")
			{
					window.alert ("Please select Doctors Department");

					document.frmreg.dis.focus();
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
				if(document.frmreg.doc_regno.value.length < 10)
				{
					window.alert ("**Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");
					return false;
					document.frmreg.doc_regno.focus();
					return false;
				}
				if(document.frmreg.doc_regno.value.substring (3,4) != ".")
				{
					//alert(document.add.rgn.value.substring (3,4));
					window.alert (" !! Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");

					document.frmreg.doc_regno.focus();
					return false;
				}
				for(i=0;i<3;i++)
				{
					tmp=document.frmreg.doc_regno.value.substring (i,i+1);
					if ((tmp >= 'a' && tmp <= 'z') || (tmp >= 'A' && tmp <= 'Z') ) continue;
					else
					{
						window.alert (" !! Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");

						//window.alert ("Provide Registration Number in correct format is : SST.6 digit Registration Number");

						document.frmreg.doc_regno.focus();
						return false;
					}
				}

			}
		return true;
		}


		function validateEmail(email)
		{
			const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			return re.test(String(email).toLowerCase());
		}

		function checkphone(phn)
		{
			var validcodechr = ' 0123456789';
			x = phn;
			while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
			if (x.length == 0){ alert("Blank Phone Number Not Allowed"); return false;}
			if (x.length != 10){ alert("Check number of digits in Phone Number"); return false;}

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

<BODY onload="chk(); document.frmreg.uid.focus();">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="../servlet/saveregusers" NAME="frmreg">

<INPUT class="form-control" TYPE="text" NAME="uid" MAXLENGTH=15 onBlur='validatefield()' placeholder="Login ID (Six Character or more)" />
<INPUT class="form-control" TYPE="password" NAME="pwd" MAXLENGTH=15 placeholder="PassWord (Six Character or more)" />
<INPUT class="form-control" TYPE="password" NAME="cpwd" MAXLENGTH=15 onBlur='validatepass()' placeholder="Confirm password" />
<INPUT class="form-control" TYPE="text" NAME="name" MAXLENGTH=25 placeholder="Name" />
<INPUT class="form-control" TYPE="text" NAME="address" MAXLENGTH=30 placeholder="Address">
<INPUT class="form-control" TYPE="text" NAME="emailid" MAXLENGTH=40 placeholder="Enter EmailID" />
<INPUT class="form-control" TYPE="text" NAME="phone" MAXLENGTH=10 placeholder="Phone" />
<INPUT class="form-control" TYPE="text" NAME="qualification" MAXLENGTH=30 placeholder="Qualification" />
<INPUT class="form-control" TYPE="text" NAME="designation" MAXLENGTH=30 placeholder="Designation" />

<% if(ccode.equalsIgnoreCase("XXXX"))
{
	%>
<SELECT class="form-control" id="HOS"	NAME="center" data-toggle="tooltip" title="Select Hospital Name" onchange="getDeptSYSADMIN()">
<% }
	else { %>
		<SELECT class="form-control" NAME="center" data-toggle="tooltip" title="Select Hospital Name">
		<% } %>
		<option>Select Hospital</option>
	<%
		try
		{
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res;
			if(utyp.equals("adm") && ccode.equalsIgnoreCase("XXXX"))
				res=rcci.getAllCentreInfo();
			else
				res=rcci.getRCentreInfo(ccode);
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
<SELECT class="form-control" NAME="type" Size=1 OnClick='chk()' data-toggle="tooltip" title="User Type">
		<Option Value="adm">Administrator</Option>
		<Option Value="doc">Doctors</Option>
		<!--<Option Value="con">Counselor</Option>-->
		<Option Value="pOP">Pathology Technician</Option>
		<Option Value="usr">Data Enry Operator</Option>
		</SELECT>
<!-- onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')"
 -->
 <!-- <TR>
   <td> Path of the file for uploading: </TD>
   <TD></TD>
   <TD><INPUT TYPE=file NAME="sign" size=30>
   </TD><TD><Font size=-2 color=brown><B>(doctors only)</B></Font></TD>
   </TR> -->

<SELECT class="form-control" id="dis" name="dis" data-toggle="tooltip" title="Disease Type" >
	<%
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
	try{
		if(!ccode.equalsIgnoreCase("XXXX")){
		rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
		Object depts = ddinfom.getDepartments(ccode);
		Vector deptsV = (Vector)depts;
		String options = "";
		options += "<option value='NIL'>Select Department</option>";
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
	}
}catch(Exception e){
	System.out.println(e.toString());
}
	%>
</SELECT>
<INPUT class="form-control" TYPE="text" NAME="doc_regno" MAXLENGTH=30 placeholder="Regn No">
<INPUT class="form-control btn-primary" TYPE="submit" Value="Submit" onclick="return validate()" >

</FORM>
</center>
</BODY>
		</div>		<!-- "modal-body" -->
		<div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
        </div>
	  </div>		<!-- "modal-content" -->
	 </div>		<!-- "modal-dialog" -->
	</div>		<!-- "modal fade" -->
</div>		<!-- "col-sm-4" -->

<FORM role="form" METHOD="POST" ACTION="updateavl.jsp" Name="frmuser">
<div class="col-sm-4">
<INPUT class="form-control btn-success" TYPE="submit" Value="Update Availability">
</div>		<!-- "col-sm-4" -->
<div class="col-sm-4">
<div class="input-group">
<span class="input-group-addon" style="color:blue;font-weight:bold">Select Center :</span>
<select class="form-control" name="center" onchange='showselected(this.value);'>
<%
	out.println("<option value="+ccode+" 'selected'>"+cname+"</option><br>");
		try
		{
		 if(ccode.equals("XXXX")){
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
					for(int j=0;j<Vtmp.size();j++){
						dataobj datatemp = (dataobj) Vtmp.get(j);
						if(datatemp.getValue("code").equals(sccode)){
							out.println("<option value="+datatemp.getValue("code")+" selected>"+datatemp.getValue("name")+"</option><br>");
						}else{
							out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
						}
					} // end for
			}// end else
		  }
		}catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

%>
	 </select>
	</div>		<!-- "input-group" -->

</div>		<!-- "col-sm-4" -->
</div>		<!-- "row" -->

<div class="row">
<div class="col-sm-12">




<!-- <A HREF="adduser.jsp">	New User </A> -->
<br>
<div class="table-responsive">
<table class="table table-bordered">
<TR>
 <td colspan="2">
<A class=" form-control btn btn-default " role="button" HREF="javascript:history.go(-1)" Style="color:#FFFFFF; background:#339900; font-weight:bold;  text-decoration:none; ">BACK</A>
</TD>

<TD colspan="6" ><strong><Font> <CENTER><font color='red'>Administrator : Red </font>
<font color='darkgreen'>| Doctor : Green </font>
<font color='blue'>| Data Entry Operator : Blue </font><font color='black'>| Patients : Black</font></CENTER></strong></TD></tr>

	<TR BGColor="#330099">
		<TD> <FONT COLOR="WHITE"><B> <input type='checkbox' name='allAvl' id='allAvl' onclick='toggleCheckBoxes(this,"avl");'>Avl<hr style='padding:1px;margin:1px'><input type='checkbox' name='allRefl' id='allRefl'  onclick='toggleCheckBoxes(this,"rfl");'>Refl</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Name (UID)</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Designation </B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B>Email</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Phone </B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Center </B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Action </B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Class </B></FONT></TD>
	</TR>
<%
	String rgno, suid,typ;
	try {
Object res=uinfo.getValues("name,uid,designation,emailid,phone,dis,rg_no,type,active,center,available,referral",cond);
		if(res instanceof String){

		out.println("<br><center><h1> No User Available</h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			dataobj tmpData = (dataobj) tmp.get(0);
			String pvcenter=tmpData.getValue("center");

		for(int ii=0;ii<tmp.size();ii++){
			String color="RED";

			dataobj temp = (dataobj) tmp.get(ii);
			typ=temp.getValue("type");
			rgno = temp.getValue("rg_no");
			suid =temp.getValue("uid");

			if(typ.equals("adm")) color="RED";
			else if(typ.equals("doc")) color="DARKGREEN";
			else if(typ.equals("usr")) color="blue";
			else if(typ.equalsIgnoreCase("pat")) color="black";

			if(!pvcenter.equals(temp.getValue("center"))){
			//out.println ("<TR bgcolor='#330099'><td colspan=8>&nbsp;</td></tr>");
			%>
			<TR BGColor="#330099">
				<TD> <FONT COLOR="WHITE"><B> <input type='checkbox' name='allAvl' id='allAvl' onclick='toggleCheckBoxes(this,"avl");'>Avl<hr style='padding:1px;margin:1px'><input type='checkbox' name='allRefl' id='allRefl'  onclick='toggleCheckBoxes(this,"rfl");'>Refl</B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Name (UID)</B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Designation</B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Email</B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Phone</B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Center </B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Action </B></FONT></TD>
				<TD> <FONT COLOR="WHITE"><B>Class</B></FONT></TD>
			</TR>
			<%
			pvcenter=temp.getValue("center");
			}
			out.println ("<TR>");

			String avValue= temp.getValue("available").equals("Y") ? " checked" : "" ;
			String rfValue= temp.getValue("referral").equals("Y") ? " checked" : "" ;
			//out.println(temp.getValue("available"));
			//out.println("&nbsp;"+temp.getValue("referral"));

			if(typ.equals("doc")){
			 out.println("<td><input class='avl' type='checkbox' name='avl' value='" +temp.getValue("rg_no") + "'" + avValue  + "><input class='rfl' type='checkbox' name='rfl' value='" + temp.getValue("rg_no") + "'" +rfValue + "></td>");
			}else{
				out.println("<td></td>");
			}



			out.println ("<TD><font color='"+color+"'>" + temp.getValue("name") + "(<B>" + suid + "</B>)" + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("designation")  + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("emailid")  + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("phone")  + "</font></TD>");

			out.println ("<TD><font color='"+color+"'>"+temp.getValue("center")+"</font></TD>");


			out.println ("<TD><font color='"+color+"'></font>");
			out.println("<A HREF='edtusr.jsp?rgno="+rgno+"&suid="+suid+"' data-toggle='modal' data-target='#surajit_kundu'>Edit</A>");
			%>

			<div class="modal fade" id="surajit_kundu" role="dialog">
    <div class="modal-dialog ">
      <div class="modal-content">
        <div class="modal-body">


        </div>		<!-- "modal-body" -->
		</div>		<!-- "modal-content" -->
		</div>		<!-- "modal-dialog" -->
			<%
			if(!typ.equals("adm"))
			{
			out.println("<A onclick=' return sure();' HREF='delusr.jsp?rgno="+rgno+"&suid="+suid+"'>Del</A>");
			}
			out.println("</font></TD>");

			if(typ.equals("doc") && !suid.equalsIgnoreCase("N/A"))
			{
				out.println ("<TD><font color='"+color+"'><A HREF='otherdis.jsp?uid="+rgno+"'> Register</A>"+"</font></TD>");
			}
			else
			{
				out.println ("<TD><font color='"+color+"'>" + "Not Allow" + "</font></TD>");
			}

			out.println("</TR>");
		}

		}
	}


	}catch (Exception e) {
			out.println("SQL Error found <B>"+e+"</B>");
	}

%>
</TABLE>
</div>		<!-- "table-responsive" -->

</div>		<!-- "col-sm-12" -->
</div>		<!-- "row(inner)" -->
</form>
</div>		<!-- "container" -->
</body>
</html>
