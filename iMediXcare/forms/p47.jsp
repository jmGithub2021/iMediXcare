<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id,dat="",cen="";
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	cen = cookx.getCookieValue("center",request.getCookies());
	//out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + id + "</B></FONT><BR>");
	dat = myDate.getCurrentDate("dmy",false);
%>
<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<!--
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
   -->
	<TITLE>Vital Signs</TITLE>
<!--<link rel="stylesheet" type="text/css" href="../style/style2.css">-->
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.js">
var putdate,putmonth,putyear;
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
	function datentry(){
		dateentry();
		document.p47.entrydate.value=putdate+putmonth+putyear;
	}
	$(document).ready(function(){
		$(".bloodpres").keyup(function(){
			//console.log($("#systolic").val()+"-"+$("#diastolic").val());
			//$("#bldpres").val($("#diastolic").val()+"-"+$("#systolic").val());
			$("#bldpres").val($("#systolic").val()+"/"+$("#diastolic").val());
		});	
	});

	$("form.p47").submit(function(e){
	var url="../jspfiles/savefrm.jsp";
	//var formData = new FormData($("#newPres"));		 
	e.preventDefault();
	$.ajax({
		   type: "POST",
		   url: url,
		   data: $(".add-vtsign form").serialize(), 
		   success: function(data)
		   {
				alert("Done");
				$('#add_vtsign').modal('toggle');
				$(".modal-backdrop").remove();
				var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
				$(".main-body").html(ajax_load).load("patientAlldata.jsp?id=<%=id%>");			
		   },
		   error:function(erro)
		   {
				alert("Write a new Prescription");
			}
		 });
 
	});
</SCRIPT>

<style>
.vt-sign .input-group-addon{
	color:blue;
	font-weight:bold;
	min-width:150px;
	text-align:left;
	}
	#bldpres{display:hidden;}
	.bld-span{text-align:center !important;}
</style>

</HEAD>
<BODY onload='datentry();'>
<div class="container-fluid">
<H3>Vital Signs</H3>
<div class="row">
<div class="col-sm-1"></div>
<div class="col-sm-10 vt-sign">
<FORM class="p47" role="form" METHOD="post" ACTION="../jspfiles/savefrm.jsp" name="p47">
<INPUT TYPE="hidden" name="frmnam" value="p47" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">
<div class="input-group">
<span class="input-group-addon">Temperature</span>
<INPUT class="form-control" style="min-width:100px;" NAME=temperature maxlength=3 oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; required></INPUT>
<span class="input-group-addon">&#8457;</span>
</div>		<!-- "input-group" -->

<div class="input-group">
<span class="input-group-addon">Respiratory Rate</span>
<INPUT class="form-control" style="min-width:100px;" NAME=resprate maxlength=3  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; ></INPUT>
<span class="input-group-addon">/minute</span>
</div>		<!-- "input-group" -->

<div class="input-group">
<span class="input-group-addon">Pulse</span>
<INPUT class="form-control" style="min-width:100px;" NAME=pulse maxlength=3  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; ></INPUT>
<span class="input-group-addon">/minute</span>
</div>		<!-- "input-group" -->

<div class="input-group">
<span class="input-group-addon">Blood Pressure</span>
<input class="form-control bloodpres" style="min-width:100px;" name="systolic" id="systolic" placeholder="Systolic" maxlength=3  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; />
<span class="input-group-addon " style="min-width:0%;">-</span>
<input class="form-control bloodpres" style="min-width:100px;" name="diastolic" id="diastolic" placeholder="Diastolic" maxlength=3  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; />
<INPUT class="form-control" id="bldpres" style="min-width:100px;" NAME="bldpres" maxlength=50 type="hidden" />
</div>		<!-- "input-group" -->

<div class="input-group">
<span class="input-group-addon">Pulse Oximeter</span>
<INPUT class="form-control" NAME=pulox maxlength=3 style="min-width:100px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')"; ></INPUT>
<span class="input-group-addon">%</span>
</div>		<!-- "input-group" -->

<div class="input-group">
<span class="input-group-addon" >Test Date</span>
<INPUT class="form-control" id="testdate" style="min-width:100px;" NAME="testdate"  value=<%=dat%> maxlength=8 placeholder="Test Date"></INPUT>

</div>		<!-- "input-group" -->

<br><center><INPUT class="btn btn-default" type="submit" value="Submit" onclick="return testdt(document.P47.testdate.value,'<%=dat%>')" style="background-color:#B2D0CB; color: #000000; font-weight:BOLD; "></center>
		<INPUT type=hidden name=entrydate></INPUT>
		<!--<INPUT type="submit" value="Submit" onclick="return testdt(document.P47.testdate.value,'<%=dat%>')" style="background-color: '#D3CEC9'; color: '#000000'; font-weight:BOLD; ">
		 <INPUT type="reset" value="Reset" style="background-color: '#D3CEC9'; color: '#000000'; font-weight:BOLD; ">-->

</form>
</div>		<!-- "col-sm-10" -->

<div class="col-sm-1"></div>

</div>		<!-- "container" -->
</body>
</html>
