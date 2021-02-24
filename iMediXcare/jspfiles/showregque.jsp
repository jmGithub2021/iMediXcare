<%@page contentType="text/html"  import= "imedix.rcAdminJobs,imedix.dataobj,java.util.*"%> 
<%@ include file="..//includes/chkcook.jsp" %>
<html>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<SCRIPT language="JavaScript" type="text/javascript">
	function CheckAll(chk)
	{
	for (var i=0;i < document.forms[0].elements.length;i++)
	{
	var e = document.forms[0].elements[i];
	if (e.type == "checkbox")
		{
		 e.checked = chk.checked;
		}
	}
	}
</SCRIPT>
</HEAD>
<body background="../images/txture.jpg">
	<TABLE class="table" width=90% border=0 Cellpadding=0 Cellspacing=0>
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>APPROVAL OF PENDING REGISTRATION</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
	</TABLE>
<div class="container">
<div class="row">
<div class="col-sm-1"></div>		<!-- "col-sm-1" -->
<div class="col-sm-10">
<!--<TABLE class="table">
<TR>
	<TD><Font Size='5' color=#3300FF> <B>Registration Queue</B> </Font></TD>
	<TD align='right'><A class="btn btn-default" HREF="javascript:history.go(-1)" Style="color:yellow; size:10px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
</TR>
</TABLE>-->

<FORM role="form" METHOD="GET" ACTION="regupdate.jsp ">
<div class="input-group">
<span class="input-group-addon">
<INPUT class="form-control" TYPE="checkbox" NAME="all" OnClick='CheckAll(this);' style="width:30%" > Select All Users</span>
<span class="input-group-addon"><INPUT class="form-control btn-info" TYPE="submit" name="allupdate" value="Update"></span>
</div>		<!-- "input-group" -->
<div class="table-responsive">
<TABLE class="table">
	<TR BGColor="#330099">
		<TD> <FONT COLOR="WHITE"><B>SrNo</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B>Accept</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> UID</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Name</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B>E-Mail</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B> Qualification</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B>Designation</B></FONT></TD>
		<TD> <FONT COLOR="WHITE"><B>Action</B></FONT></TD>
	</TR>

<%
	String rgno="",suid="",chkName="";
	boolean t=true;
	try{
	rcAdminJobs rcAjob = new rcAdminJobs(request.getRealPath("/"));
	Object res=rcAjob.viewRegUsers();
	if(res instanceof String){
		out.println( "res :"+ res);
	}else{
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			rgno = temp.getValue("reg_no");
			suid = temp.getValue("uid");
			if (t==true) { 
				out.println("<TR BGColor=#F7DDFF>");
				t=false;
			}else { 
				out.println("<TR BGColor=#DDF0FF>");
				t=true;
			}
			out.println("<TD><B>"+(i+1)+"</B></TD>"); 
			chkName = "CC" + Integer.toString((i+1));
			out.println("<TD><INPUT class='form-control input-sm' TYPE=checkbox NAME="+chkName+" Value='"+suid+"'></TD>");
			out.println ("<TD>" + temp.getValue("uid") + "</TD>");
			out.println ("<TD>" + temp.getValue("name")  + "</TD>");
			out.println ("<TD>" + temp.getValue("emailid")  + "</TD>");
			out.println ("<TD>" + temp.getValue("qualification")  + "</TD>");
			out.println ("<TD>" + temp.getValue("designation") + "</TD>");
			out.println("<TD VAlign=center><FONT COLOR=RED><B><CENTER><A HREF=delusr.jsp?suid="+suid+"&list=plist Style='text-decoration:none; color: RED'>x</A></CENTER></B></FONT></TD>");
		}
	 }
	}catch(Exception e){
		System.out.println(e.toString());
	}

%>

</FORM>
</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-10" -->
<div class="col-sm-1"></div>		<!-- "col-sm-1" -->
</div>		<!-- "row" -->
</div>		<!-- "contailer" -->
</body>
</html>
