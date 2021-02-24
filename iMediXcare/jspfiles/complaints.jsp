<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",dat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	//out.println(id);
%>

<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
   <br> <div class='container-fluid'>
<table class="table table-hover" style='border:1px solid #00AA00'>
<tr style='background-color:#D7FFD7'>
	<th>Date</th><th>Chief Complaint</th><th>Duration</th>
</tr>
	<%
	try{
		Object res=rcDd.getComplaintSummary(id,0);
		if(res instanceof String) out.println(res);
		else{
			Vector Vtmp = (Vector)res;
			if(Vtmp.size()>0){
				for(int j=0;j<Vtmp.size();j++){
					dataobj datatemp = (dataobj) Vtmp.get(j);
					String pdt = datatemp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					for (int i = 0; i < 3; i++){
						String tempcomp=datatemp.getValue(i * 3);
						if(tempcomp.equals("")) continue;
						String tempdur = datatemp.getValue(i*3 + 1)+ " "+datatemp.getValue(i*3 + 2);
						out.println("<tr>");
						out.println("<td align='center' nowrap>"+ dt +"</td>");
						out.println("<td align='left'>" + tempcomp + "</td>");
						out.println("<td align='left'>" + tempdur + "</td>");
						out.println("</tr>");

					}	
				}

			}else{
				out.println("<tr style='background-color:#FFFFFF'><td align='center' colspan='3'>No Complaint Recorded</td></tr>");
			}
		}
	}catch(Exception e){
		out.println("Exception : "+e);
	}
	%>
	</table>
	</div>		<!-- "container-fluid" -->
</body>
</html>
