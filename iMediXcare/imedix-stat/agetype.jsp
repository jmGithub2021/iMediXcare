<%@page contentType="text/html" import= "imedix.rcCentreInfo,imedix.rcimedixstat,imedix.cook,imedix.dataobj, imedix.myDate ,java.util.*,java.io.*"%>
<HTML>
<%@ include file="..//includes/chkcook.jsp" %>

<% 
    cook cookx = new cook();
	rcimedixstat rcStat=new rcimedixstat(request.getRealPath("/"));
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String uid = cookx.getCookieValue("userid", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	String chart=request.getParameter("chart");
	String sccode=request.getParameter("sccode");
	if(sccode==null) sccode=ccode;
	if(sccode.equals("")) sccode=ccode;

	String tabRows=rcStat.getAgeData(sccode,uid);
	String barImgUrl="../temp/"+uid+"/statimg/agebar.gif";
	String pieImgUrl="../temp/"+uid+"/statimg/agepie.gif";

	String hosname="";
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
	if(sccode.equals("XXXX")) hosname="ALL Hospital ";
	else hosname=rcci.getHosName(sccode);

%>

<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" type="text/css" href="tabpage.css">-->
<script type="text/javascript" src="tabbed.js"></script>

<script type="text/javascript">
function PrintDoc(text){
	text=document
	print(text)
}
</script>

</head>

<body>
<div class="container-fluid">
<div class="row">
<div class="col-sm-6">
<ul class="nav nav-pills nav-justified">
    <li><a class="btn btn-default" href="#" value="agetype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#00FFFF;color:#707070"> Bar Chart</a></li>
    <li><a class="btn btn-default" href="#" value="agetype.jsp?sccode=<%=sccode%>&chart=pie" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#00FFFF;color:#707070"> Pie Chart</a></li>
    <li><a class="btn btn-default" href="#" value="agetype.jsp?sccode=<%=sccode%>&chart=all" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#00FFFF;color:#707070"> All Chart</a></li>
    <li><a class="btn btn-default" href="#" onClick='PrintDoc();' style="background-color:#00FFFF;color:#707070"> Print</a></li>
  </ul>

<TABLE class="table table-bordered" width=100%>
			 <TR bgcolor='#330099'>
				<TD width=10% ><B><FONT COLOR="white">SLNo</FONT></B></TD>
				<TD  ><B><FONT COLOR="white">Age Group</FONT></B></TD>
				<TD  width=30%><B><FONT COLOR="white">No of Patient</FONT></B></TD>
			 </TR>			 
			 <%=tabRows%>				 
</TABLE>
</div>		<!-- "col-sm-6" -->

<div class="col-sm-6">
<div class="well"><FONT COLOR="#3300CC"><B>Age Type Statistics of <%=hosname%></B></FONT>
	
	<TABLE class="table">
		<%
			if(chart.equals("bar") || chart.equals("all")){
		%>
			<TR >
				
				<TD valign='top'> <img class="img-responsive" src='<%=barImgUrl%>' usemap='#agebar' /></TD>
			</TR>
		<%
		  }
		  if(chart.equals("pie") || chart.equals("all")){
		%>
		<TR >
			<TD valign='top'> <img class="img-responsive" src='<%=pieImgUrl%>' usemap='#agepie' > </TD>  
		</TR>
		<%
		  }
		%>
	</TABLE>
	
</div>		<!-- "well" -->		
</div>		<!-- "col-sm-6" -->

</div>		<!-- "row" -->
</div>		<!-- "container-fluid" -->
</body>

</html>

