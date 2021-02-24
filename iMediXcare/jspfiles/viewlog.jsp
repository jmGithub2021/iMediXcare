<%@page contentType="text/html"  import= "imedix.rcUserInfo,imedix.rcAdminJobs,imedix.dataobj,imedix.cook,java.util.*, java.text.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
String sysLog = "",setDate="";
Date cur_date = new Date();
SimpleDateFormat dde = new SimpleDateFormat("dd/MM/yyyy");
String today = dde.format(cur_date);
setDate = today;	

rcAdminJobs rcAjob = new rcAdminJobs(request.getRealPath("/"));

if(request.getMethod().equalsIgnoreCase("POST") && request.getParameter("viewSysLog") !=null){
	setDate = request.getParameter("logDate");
	sysLog = rcAjob.readSytemLog(setDate.replaceAll("/",""));
}
%>
<html>
<head>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
</head>

<script>
$(document).ready(function(){
	$(function () {
    var startDate = new Date("21/10/1995"),
        endDate = new Date("<%=today%>");
		$('#log-datepicker').datetimepicker({
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 4,
			keyboardNavigation: 1,
			minView: 2,
			forceParse: 0,
			startDate: startDate,
			endDate: endDate,
			setDate: endDate
		});
	});
});
</script>

<BODY background="../images/txture.jpg" >
	<div class="container-fluid">
	
	<TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
	<TR>
		<TD><Font Size='5' color=#3300FF> <B>VIEW LOG</B> </Font></TD>
		<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
	</TR>
	</TABLE>
		<div class="container-fluid">
			
			<div class="row">
				<div class="col-sm-1"></div>
				<div class="col-sm-9">
					<form method="POST">
						<div id="log-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="dd/MM/yyyy" type="text" name="logDate" value="<%=setDate%>" class="form-control logCaln" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
						</div>
				</div>
				<div class="col-sm-1">
					<input class="btn btn-info" type="submit" name="viewSysLog" value="View System Log" />
				</div>
				</form>
				<div class="col-sm-1"></div>
			</div>
			
			<div class="row">
				<div class="col-sm-12 dispSysLog">
				<%=sysLog%>
				</div>
			</div>
		</div>
	</body>	
</html>
