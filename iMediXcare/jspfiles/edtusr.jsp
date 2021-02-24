<%@page language="java"  import= "imedix.rcUserInfo,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%	
	cook cookx = new cook();
	String rgno = request.getParameter("rgno");
	String uid = request.getParameter("suid");
	String epas = "" ;
	String enam = "" ;
	String eadd = "" ;
	String emil = "" ;
	String epho = "" ;
	String eqln = "" ;
	String edes = "" ;
	
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	Object res=uinfo.getuserinfo(uid);
		
	try {
	
	if(res instanceof String){
		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
		return;
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0) {
			dataobj objusr = (dataobj) tmp.get(0);
			epas=objusr.getValue("pwd");
			enam=objusr.getValue("name");
			eadd=objusr.getValue("address");
			emil=objusr.getValue("emailid");
			epho=objusr.getValue("phone");
			eqln=objusr.getValue("qualification");
			edes=objusr.getValue("designation");

		}
	 }

	}catch (Exception e) {
			out.println(" Error <B>"+e+"</B>");		
	}

	String userid =cookx.getCookieValue("userid", request.getCookies());
%>

<HTML>
<HEAD>
<TITLE> Edit User </TITLE>


<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
//function actnow( actionfile,  conttype)
function actnow()
{
	var flag,opwd;
	opwd=document.profile.oldpwd.value;
	if(opwd.length==0)
	{
		alert("Existing Password field is mandatory");
		document.profile.oldpwd.focus();
		return false;
	}
	flag = checknum(document.profile.phone.value);
	if (flag == false)
	{
		return false;
		//if (document.images) 
		//{
		//	document.profile.action= actionfile;
		//	document.profile.encoding = conttype;
		//}
	}
	//else return false;
	//return true;
}

function checknum(phn)
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


//-->
</SCRIPT>
</HEAD>


<BODY BGColor="#FAF5F5">

<div class="container-fluid">
<center><h4 style="COLOR:FIREBRICK">Edit <strong><%=uid%></strong>'s Details </h4></center><BR><BR>
<FORM role="form" METHOD="GET" Name=profile ACTION="saveeditusr.jsp" onSubmit="return actnow();">

<div class="input-group">
<span class="input-group-addon" style="color:Blue">User ID : </span>
	<span class="input-group-addon"><B style="color:#FF6600"><%=uid %></B><INPUT TYPE="hidden" NAME="uid" Value = "<%=uid %>"> </span>
</div>		<!-- "input-group" -->
<%if(!userid.equals("admin")){%>
<INPUT class="form-control" TYPE="password" NAME="oldpwd" MAXLENGTH=10 placeholder="Existing Password" />
<%}%>

<INPUT class="form-control" TYPE="password" NAME="pwd" MAXLENGTH=10 placeholder="New Password" >

<div class="input-group">
<span class="input-group-addon" style="color:Blue">Full Name</span>
	<INPUT class="form-control" TYPE="text" NAME="name" MAXLENGTH=25 VALUE="<%=enam %>">
</div>		<!-- "input-group" -->	

<div class="input-group">
	<span class="input-group-addon" style="color:Blue">Address</span>
	<INPUT class="form-control" TYPE="text" NAME="address" MAXLENGTH=30 VALUE="<%=eadd %>" />
</div>		<!-- "input-group" -->

<div class="input-group">
	<span class="input-group-addon" style="color:Blue">Phone Number</span>
	<INPUT class="form-control" TYPE="text" NAME="phone" MAXLENGTH=15 Size=24 VALUE="<%=epho %>" />
</div>		<!-- "input-group" -->

<div class="input-group">
	<span class="input-group-addon" style="color:Blue">Qualification</span>
	<INPUT class="form-control" TYPE="text" NAME="qualification" MAXLENGTH=30 Size=24 VALUE="<%=eqln %>" />
</div>		<!-- "input-group" -->

<div class="input-group">
	<span class="input-group-addon" style="color:Blue">Designation</span>
	<INPUT class="form-control" TYPE="text" NAME="designation" MAXLENGTH=30 Size=24 VALUE="<%=edes %>" />
</div>		<!-- "input-group" -->

<div class="input-group">
	<span class="input-group-addon" style="color:Blue">EmailID</span>
	<INPUT class="form-control" TYPE="text" NAME="emailid" MAXLENGTH=30 Size=24 VALUE="<%=emil %>" />	
</div>		<!-- "input-group-addon" -->

<INPUT class="form-control btn btn-primary" TYPE="submit" Value="Modify"></TD>

</FORM>





<br><div class="modal-footer">
          <button class="btn btn-warning" type="button" onclick="javacript:location.reload()" data-dismiss="modal">Close</button>
        </div>

</div>		<!-- "container-fluid" -->
</BODY>
</HTML>
