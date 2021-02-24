<%@page contentType="text/html" import= "imedix.rcimedixstat,imedix.rcCentreInfo,imedix.cook,imedix.dataobj, imedix.myDate,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<HTML>
<% 
  	cook cookx = new cook();
	rcimedixstat rcStat=new rcimedixstat(request.getRealPath("/"));
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String uid = cookx.getCookieValue("userid", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	String sccode=request.getParameter("sccode");
	if(sccode==null) sccode=ccode;
	if(sccode.equals("")) sccode=ccode;
	rcStat.delAllGraphImg(uid);
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
	function showselected(){
		var val=document.stat.center.value;
		var tar;
		tar="showstat.jsp?sccode="+val;
		//alert(tar);
		window.location=tar;
}

$.ajaxSetup ({
		cache: false
	});	
	function s_kundu(fileName) {
		var loadUrl = "./" + fileName;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#chart_tab").html(ajax_load).load(loadUrl);
		$("#chart_tab").css("min-height","100%");
		$("#chart_tab").css("max-height","100%");
	
	}

function dflt(fileName) {
		var loadUrl = "./" + fileName;
		var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#chart_tab").html(ajax_load).load(loadUrl);
		$("#chart_tab").css("min-height","100%");
		$("#chart_tab").css("max-height","100%");
	
	}

</script>



</head>

<body onload="dflt('w.html')">
<br><div class="container-fluid">
<div class="row">
<form NAME='stat'>
<div class="input-group">
<span class="input-group-addon" style="background-color:#FFCC99"><strong>Select Center : </strong></span>
 <select class="form-control" name="center" onchange='showselected();' style="color:blue">
	 
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
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
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

<ul class="nav nav-tabs">
    <li><a href="#" value="gendertype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Gender Type</a></li>
    <li><a href="#" value="diseasetype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Disease Type</a></li>
    <li><a href="#" value="agetype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Age Type</a></li>
    <li><a href="#" value="formtype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Form Type</a></li>
	<li><a href="#" value="imagetype.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Image Type</a></li>
	<li><a href="#" value="imagevspat.jsp?sccode=<%=sccode%>&chart=bar" onclick="s_kundu(this.getAttribute('value'))" style="background-color:#003300;color:white;font-weight:bold">Image/Patient</a></li>
  </ul>

<div class="col-sm-12" id="chart_tab">

</div>		<!-- "col-sm-12" -->
</div>		<!-- "row" -->
</div>		<!-- "container-fluid" -->
</body>
</html>
