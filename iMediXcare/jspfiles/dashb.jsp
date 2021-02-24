<%@page contentType="text/html" import="imedix.Decryptcenter,imedix.rcCentreInfo,imedix.cook,imedix.rcdpStats,java.util.*,imedix.dataobj,com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonPrimitive" %>
<%@page errorPage="error.jsp" %>
<%@include file="..//includes/chkcook.jsp" %>
<!-- bgcolor=#C8DCE1 -->

<!--
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link href="../bootstrap/css/jquery-ui.css" rel="stylesheet">

<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
-->
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/jquery-ui.js"></script>


<style>
.dp1,.dp2,.hcenter {
	font-size:12px;
	font-weight: 'bold'
	font-family: sans;
}
</style>
<%
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	//cname = cname.substring(0,cname.lastIndexOf(" "));
	String str= "<I>Online Telemedicine Center </I><br><b>"+cname + "</b>";
	//out.println(str.toUpperCase());
	//String ccode="",cname;
	String path = request.getRealPath("/");
		rcdpStats dpStats = new rcdpStats(request.getRealPath("/"));

%>
	<script type="text/javascript">

	  function drawPieChart(gtitle, gobject, gdata) {

			var data_1 = google.visualization.arrayToDataTable( jQuery.parseJSON(gdata) );
			console.log(data_1);
			var options = { title: gtitle};
			var chart = new google.visualization.PieChart(document.getElementById( gobject ));
			chart.draw(data_1, options);
	  }
	  function drawLineChart(gtitle, gobject, gdata) {

			var data_1 = google.visualization.arrayToDataTable( jQuery.parseJSON(gdata) );
			console.log(data_1);
			var options = { title: gtitle};
			var chart = new google.visualization.LineChart(document.getElementById( gobject ));
			chart.draw(data_1, options);
	  }
	  function drawBarChart(gtitle, gobject, gdata) {

			var data_1 = google.visualization.arrayToDataTable( jQuery.parseJSON(gdata) );
			console.log(data_1);
			var options = { title: gtitle};
			var chart = new google.visualization.ColumnChart(document.getElementById( gobject ));
			chart.draw(data_1, options);
	  }

      $(document).ready(function(){

		//$('.hcenter').val('<%=ccode%>');
		//$('.hcenter').val('VBCR019');
		//$('.dp1').val('2020-01-01');
		//$('.dp2').val('2025-12-31');
		//$('.hcenter').prop("readonly", false);


 		$('.datepicker').datepicker( {
       	 	changeMonth: true,
        	changeYear: true,
        	showButtonPanel: true,
        	dateFormat: 'yy-mm-dd'
    	});





	   $(document).on("click", "#actn", function() {
		  var vcent = $("#hcenterf").val();
		  var vstart = $("#dp1f").val();
		  var vto = $("#dp2f").val();
			console.log(vcent+","+vstart+","+vto);
		  $(".panel-footer").html("<h3  class='panel-title'><b>Dates:</b> "+vstart+" <b>to</b> "+vto+" <b>Center:</b>"+vcent+"</h3>");

		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-cent-refby.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
				console.log(data);
				drawPieChart('ReferedBy Patients', 'patcentrefby', data);
		  });
		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-cent-refto.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
				console.log(data);
				drawPieChart('ReferedTo Patients', 'patcentrefto', data);
		  });

		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-cent.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
				console.log(data);
				drawBarChart('Centerwise Patients', 'patcent', data);
		  });

		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-dis.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
				console.log(data);
				drawBarChart('Disease Category Chart', 'pdisclass', data);
		  });
		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-age.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
				console.log(data);
				drawBarChart('Patients Age Group', 'pagegroup', data);
		  });
		  $.post( "<%=request.getContextPath()%>/jspfiles/wdash-gen.jsp", {start:vstart,to:vto,cent:vcent}, function(data) {
					//alert(data);
					console.log(data);
					//$('#start').html(data);
					drawPieChart('Patients Gender', 'pgender', data);
		  });
	  });

	 google.charts.load('current', {'packages':['corechart']});
	 google.charts.setOnLoadCallback(function(){
			$("#actn").trigger( "click" );
	 }); // google call back

	});
    </script>
<HTML>
<BODY >
<center>
<br>
<div class="row">
  <div class="col-md-10 col-md-offset-1 well">
<h2>An overview of iMediXcare System</h2>
<div class="form-group well well-small col-xs-12">
  <div class="col-xs-2">
    <label for="dp1">From</label>
    <input class='dp1 datepicker form-control' size=8  value='2010-01-01' id="dp1f" name="dp1f">
  </div>
  <div class="col-xs-2">
    <label for="dp2">To</label>
    <input class='dp2 datepicker  form-control' size=8 value='2025-12-31' id="dp2f" name="dp2f">
  </div>
  <div class="col-xs-6">
    <label for="hcenter">Center Name</label>
 <%
    Decryptcenter imc = new Decryptcenter();
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
	String curCCode="";
	if(ccode.equals("XXXX"))
	{
	out.println ("<SELECT class='form-control' NAME=hcenterf ID=hcenterf WIDTH='330' STYLE='width: 330' >");

	out.println("<Option Value='XXXX' Selected>All Centers</Option>");
	try {
		Object res=rcci.getAllCentreInfo();
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String occode = temp.getValue("code").trim();
			String cname0 = temp.getValue("name").trim() ;
			String visibility = temp.getValue("visibility").trim();

			String expdate = imc.decryptLicString(  temp.getValue("expdate") );
			java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
			java.util.Date today = new java.util.Date();
			long timeDiff = expDate.getTime() - today.getTime();
			long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
			String validity = "";
			if (daysDiff<15) validity = " [ only " + daysDiff + " day(s) left ] " ;
			else validity = "";

			if(curCCode.equals("XXXX")) curCCode=occode;
			if (visibility.equalsIgnoreCase("Y")) {
				if(occode.equals(curCCode))
					out.println ("<Option Value='"+occode.trim()+"' selected>("+occode.trim() +")&nbsp;"+cname0.trim()+validity+"</OPTION>");
				else
					out.println ("<Option Value='"+occode.trim()+"'>("+occode.trim() +")&nbsp;"+cname0.trim()+validity+"</OPTION>");
			}
		}// end for

	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");
	}
	out.println ("</SELECT>");
	}
	else
	{
		out.println ("<SELECT class='form-control' NAME=hcenterf ID=hcenterf WIDTH='330' STYLE='width: 330' >");

		//out.println("<Option Value='XXXX' Selected>All Centers</Option>");
		try {
			Object res=rcci.getAllCentreInfo();
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String occode = temp.getValue("code").trim();
				String cname0 = temp.getValue("name").trim() ;
				String visibility = temp.getValue("visibility").trim();

				String expdate = imc.decryptLicString(  temp.getValue("expdate") );
				java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
				java.util.Date today = new java.util.Date();
				long timeDiff = expDate.getTime() - today.getTime();
				long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
				String validity = "";
				if (daysDiff<15) validity = " [ only " + daysDiff + " day(s) left ] " ;
				else validity = "";

			/*	if(curCCode.equals("XXXX")) curCCode=occode;
				if (visibility.equalsIgnoreCase("Y")) {
					if(occode.equals(curCCode))
						out.println ("<Option Value='"+occode.trim()+"' selected>("+occode.trim() +")&nbsp;"+cname0.trim()+validity+"</OPTION>");
					else
						out.println ("<Option Value='"+occode.trim()+"'>("+occode.trim() +")&nbsp;"+cname0.trim()+validity+"</OPTION>");
			*/
			if (visibility.equalsIgnoreCase("Y") && ccode.equals(occode.trim())) {
					out.println ("<Option Value='"+occode.trim()+"' selected>("+occode.trim() +")&nbsp;"+cname0.trim()+validity+"</OPTION>");
			}
				}
			}// end for


		catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");
		}
		out.println ("</SELECT>");



	}
%>
   </div>
  <div class="col-xs-2">
    <label for="actn">Action</label>
   <input class='btn btn-md btn-info form-control' value='Refresh'  id="actn" name="actn">
  </div>

  <p align = 'justify'>
   <br><br>
<font color=#080868>
	This is an interactive dash board. Change the parameters to update the visualization.
</font>
</p>
</div> <!-- col-md-12 -->
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
		    <div class="panel-heading">
		        <h3 class="panel-title">Gender Chart</h3>
		    </div>
		    <div class = "panel-body" id="pgender"></div>
		    <div class="panel-footer">
		       <h3 class="panel-title">Gender Chart</h3>
		    </div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
		    <div class="panel-heading">
		        <h3 class="panel-title">Age-Group Chart</h3>
		    </div>
		    <div class = "panel-body" id="pagegroup"></div>
		    <div class="panel-footer">
		        <h3 class="panel-title">Age-Group Chart</h3>
		    </div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
			<div class="panel-heading">
				<h3 class="panel-title">Disease Chart</h3>
			</div>
			<div class = "panel-body" id="pdisclass"></div>
			<div class="panel-footer">
			  <h3 class="panel-title">Disease Chart</h3>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
			<div class="panel-heading">
				<h3 class="panel-title">Centerwise Patients</h3>
			</div>
			<div class = "panel-body" id="patcent"></div>
			<div class="panel-footer">
			   <h3 class="panel-title">Centerwise Patients</h3>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
			<div class="panel-heading">
				<h3 class="panel-title">Patients ReferredTo</h3>
			</div>
			<div class = "panel-body" id="patcentrefto"></div>
			<div class="panel-footer">
			   <h3 class="panel-title">Patients ReferredTo</h3>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-primary" style="width:400px;">
			<div class="panel-heading">
				<h3 class="panel-title">Patients ReferredBy</h3>
			</div>
			<div class = "panel-body" id="patcentrefby"></div>
			<div class="panel-footer">
			   <h3 class="panel-title">Patients ReferredBy</h3>
			</div>
		</div>
	</div>
</div>
</div> <!-- row -->
</center>
</BODY>
</HTML>
