<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcDataEntryFrm,imedix.rcAdminJobs,imedix.rcCentreInfo,imedix.dataobj,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>


<style>
a.list-group-item{background-color:	#D8D8D8  ;color:#0033FF ; font-weight:bold;}

div.panel-heading.sk{color:#FF6666;}


</style>

</HEAD>

<%
int cen_no=0,regque_no=0,usr_no=0;
	cook cookx = new cook();
	String ccode= cookx.getCookieValue("center", request.getCookies ());

	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	rcAdminJobs rcAjob = new rcAdminJobs(request.getRealPath("/"));
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

try {
		Object res=cinfo.getAllCentreInfo();
		if(res instanceof String){ cen_no=0; }
		else{
			Vector Vtmp = (Vector)res;
			cen_no=Vtmp.size();
		}
	}
catch(Exception e){out.println(e.toString());}


try {
		Object res=rcAjob.viewRegUsers();
		if(res instanceof String){ regque_no=0; }
		else{
			Vector Vtmp = (Vector)res;
			regque_no=Vtmp.size();
		}
	}
catch(Exception e){out.println(e.toString());}

try {
	String cond="active='Y' ";
		Object res=uinfo.getValues("name,uid,designation,emailid,phone,dis,rg_no,type,active,center,available,referral",cond);
		if(res instanceof String){ usr_no=0; }
		else{
			Vector Vtmp = (Vector)res;
			usr_no=Vtmp.size();
		}
	}
catch(Exception e){out.println(e.toString());}

	int tag=0,restr_no=0;
	String resdir=rcAjob.getAllBackupDirs("backup");
	String[] subdir=resdir.split("#");
	if (resdir.equalsIgnoreCase("None")){restr_no=0;}
	else {restr_no=subdir.length;}

%>
<BODY bgcolor="white">
<div class="container">
<div class="row">
<div class="col-sm-2">
</div>		<!-- "col-sm-3" -->
<div class="col-sm-8">
	
	<div class="panel panel-info">


		<div class="panel-heading sk"><h4><strong>Administrator Responsibilities :</strong></h4>





	</div>
		<div class="list-group">
		<%
		if(ccode.equals("XXXX")){
			%>
			<a href="showcenter.jsp" class="list-group-item">Center Management<span class="badge"><%=cen_no%></span>
			</a>
			<%
		}else{
			%>
			<a href="editcenter2.jsp" class="list-group-item">Connected Centers<span class="badge"><%=cen_no%></span>
			</a>
			<%
			}
			%>

			<a href="showregque.jsp" class="list-group-item">Registration Queue<span class="badge"><%=regque_no%></span></a>
			<a href="showusers.jsp" class="list-group-item">Show Users<span class="badge"><%=usr_no%></span></a>
			<a href="accountActive.jsp" class="list-group-item">Activate/Deactivate Users</a>
			<a href="patCreateLogin.jsp" class="list-group-item">Create Patient Login<span class="badge">0</span></a>
			<a href="druglist_manage.jsp" class="list-group-item">Manage Drug List</a>
			<a href="departments.jsp" class="list-group-item">Manage Departments</a>
			<!--<a href="backupinterface.jsp" class="list-group-item">Backup Utility</a>
			<a href="restoreinterface.jsp" class="list-group-item">Restore Utility<span class="badge"><%=restr_no%></span></a>
			<a href="../imedix-stat/showstat.jsp" class="list-group-item">iMediX Statistics</a>-->
			<!--<a href="../imedix-stat-adv/yearrange.jsp" class="list-group-item">iMediX Advanced Statistics</a>-->
			<!--<a href="admcommunication.jsp" class="list-group-item">Email/SMS to Users</a>

			

			<a href="pacsResultlist.jsp" class="list-group-item">Get PACS Result</a>-->
			<% if(ccode.equals("XXXX")){
				%>
			<a href ="viewlog.jsp" class="list-group-item">View Log</a>
			<% } %>
		</div>
	</div>
</div>		<!-- "col-sm-6" -->
<div class="col-sm-2">
</div>		<!-- "col-sm-3" -->

</div>		<!-- "row" -->
</div>		<!-- "container" -->

</BODY>
</HTML>
