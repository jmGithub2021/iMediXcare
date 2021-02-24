<%@page language="java"  import= "imedix.rcUserInfo, imedix.rcAdminJobs, imedix.rcCentreInfo, imedix.dataobj, imedix.cook, java.util.*, imedix.SMS,imedix.rcSmsApi, imedix.Email"%>
<%@ include file="..//includes/chkcook.jsp" %>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/toastr.css">		
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/index.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/toastr.js"></script>	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js?"+n></script>
	<style>
		div.emlStatus {
			display: block;
			width: 100%;
			text-align: left;
		}
		div.lblerror {
			margin: 2px;
			padding: 2px;
			font-size: 12px;
			background-color: #ff0000;
			text-align: left;
		}
		div.lblsuccess {
			margin: 2px;
			padding: 2px;
			font-size: 12px;
			background-color: #000ff0;
			text-align: left;
		}
		</style>
<script language='javascript'>
 $(document).ready(function(){
	
	var table = $(".datalist").DataTable({
		"scrollX": true,
		"rowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			console.log( aData[2] + " " + aData[4]);
			aData[2] = aData[2].trim();
			if (aData[2] != "Y") {
				$(nRow).find('td:eq(1)').css('color', 'Red');
				$(nRow).find('td:eq(2)').css('color', 'Red');
			} 
			else {
				$(nRow).find('td:eq(1)').css('color', 'Green');
				$(nRow).find('td:eq(2)').css('color', 'Green');
			} 
			aData[4] = aData[4].trim();
			if (aData[4] != "Y") {
				$(nRow).find('td:eq(3)').css('color', 'Red');
				$(nRow).find('td:eq(4)').css('color', 'Red');
			} 
			else  {
				$(nRow).find('td:eq(3)').css('color', 'Green');
				$(nRow).find('td:eq(4)').css('color', 'Green');
			} 
    	}
	});
	/*
	$(".inp-c").keydown(function(){
		let tb = $(".inp-c");
		let sr =  $(".inp-c").val();
		$(this).autocomplete({
			 minLength: 3,
			 source: "usrlist.jsp?sv="+sr,
			 select: function( event, ui ) {
				//console.log( "Selected: " + ui.item.value + " aka " + ui.item.id );
				$("#inp-c").val('');
				var selText =  ui.item.value;
				var aryCol = selText.split('|');
				var vem = aryCol[3];
				var vph = aryCol[4];
				//$('.datalist > tbody:last-child').append('<tr><td>'+aryCol[0]+'</td><td>'+aryCol[1]+'</td><td>'+aryCol[2]+'</td></tr>');
				table.row.add({0:aryCol[0],1:aryCol[1],2:aryCol[3],3:aryCol[2],4:aryCol[4]}).draw();
			 }
		});			
	});		
	*/
	$(".addDoctors").click(function(){
		$.post("grplist.jsp",{'sv':'doc'},function(data){
			var jsonAry = JSON.parse(data);
			for(i=0; i<jsonAry.length; i++) {
				var selText =  jsonAry[i];
				var aryCol = selText.split('|');
				table.row.add({0:aryCol[0],1:aryCol[1],2:aryCol[3],3:aryCol[2],4:aryCol[4]}).draw();
			}
		});
	});
	$(".addDEO").click(function(){
		$.post("grplist.jsp",{'sv':'usr'},function(data){
			var jsonAry = JSON.parse(data);
			for(i=0; i<jsonAry.length; i++) {
				var selText =  jsonAry[i];
				var aryCol = selText.split('|');
				table.row.add({0:aryCol[0],1:aryCol[1],2:aryCol[3],3:aryCol[2],4:aryCol[4]}).draw();
			}
		});
	});
	$(".addUsers").click(function(){
		$.post("grplist2.jsp",{'sv': $("#inp-c").val()},function(data){
			var jsonAry = JSON.parse(data);
			for(i=0; i<jsonAry.length; i++) {
				var selText =  jsonAry[i];
				var aryCol = selText.split('|');
				table.row.add({0:aryCol[0],1:aryCol[1],2:aryCol[3],3:aryCol[2],4:aryCol[4]}).draw();
			}
		});
	});

	 
	$(".remAll").click(function(){
		alert("This will clear table. You have to add records again");
		table.clear().draw();
	});
	$(".btnEmail").click(function(){
		$(".btnEmail").prop("disabled", true);
		event.preventDefault();  
        // On the click even,  
		$(".emlStatus").html("");
		var aryEmails = table.columns( 1 ).data().toArray();
		var aryEmailsVerif = table.columns( 2 ).data().toArray();
		var subject = $("#subj").val();
		var message = $("#msg").val();
		console.log (aryEmails);
		alert("Want to Send Email to "+aryEmails[0].length+" contacts?");
		let idx = 0;
		for (let email of aryEmails[0]) {
			let emailid = email.trim();
			let verifStatus = aryEmailsVerif[0][idx].trim();
			if( emailid!="" && emailid.length>0 && IsEmail(emailid) && verifStatus=="Y" ){
				var formData = new FormData($('#form')[0]); 
				formData.append('email', emailid);
				$.ajax({
					type: "POST",
					enctype: 'multipart/form-data',
					url: "GenEmail.jsp",
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					timeout: 600000,
					success: function (data) {
						data = data.trim();
						$(".emlStatus").append("<div class='lblsuccess'><b>"+idx+"</b>) " + emailid + "<br> St:" + data + "</div><br>");
						console.log (data);
						$(".btnEmail").prop("disabled", false);
					},
					error: function (e) {
						data = "Failed";
						$(".emlStatus").append("<div class='lblerror'><b>"+idx+"</b>) " + emailid + "<br> St:" + data + "</div><br>");
						console.log ("Something went wrong with Eail: " + emailid + " >> Error : " +e);
						$(".btnEmail").prop("disabled", false);
					}
				});
			} 
			else {
				data = "Failed";
				$(".emlStatus").append("<div class='lblerror'><b>"+idx+"</b>) " + emailid + "<br> St:" + data + "</div><br>");
				console.log ("Something went wrong with Eail: " + emailid);
				//idx++;
			}
			idx++;
		}
	});
	$(".btnSms").click(function(){
		$(".btnSms").prop("disabled", true);
		event.preventDefault();  
		$(".emlStatus").html("");
		var aryMobiles = table.columns( 3 ).data().toArray();
		var aryMobilesVerif = table.columns( 4 ).data().toArray();
		var subject = $("#subj").val();
		var message = $("#msg").val();
		console.log (aryMobiles);
		alert("Want to Send SMS to "+aryMobiles[0].length+" contacts?");
		let idx = 0;
		for (let mobile of aryMobiles[0]) {
			let mobileno = mobile.trim();
			let verifStatus = aryMobilesVerif[0][idx].trim();
			//verifStatus="Y";
			//mobileno = "01713161130";
			if( mobileno!="" && mobileno.length>0 && verifStatus=="Y" ){
				var formData = new FormData($('#form')[0]); 
				formData.append('mobile', mobileno);
				$.ajax({
					type: "POST",
					enctype: 'multipart/form-data',
					url: "GenSMS.jsp",
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					timeout: 600000,
					success: function (data) {
						data = data.trim();
						$(".emlStatus").append("<div class='lblsuccess'><b>"+idx+"</b>) " + mobileno + "<br> St:" + data + "</div><br>");
						console.log (data);
						$(".btnSms").prop("disabled", false);
					},
					error: function (e) {
						data = "Failed";
						$(".btnSms").append("<div class='lblerror'><b>"+idx+"</b>) " + mobileno + "<br> St:" + data + "</div><br>");
						console.log ("Something went wrong with Email: " + mobileno + " >> Error : " +e);
						$(".btnSms").prop("disabled", false);

					}
				});
			}
			else {
				data = "Failed";
				$(".emlStatus").append("<div class='lblerror'><b>"+idx+"</b>) " + mobileno + "<br> St:" + data + "</div><br>");
				console.log ("Something went wrong with SMS: " + mobileno);
			}
			idx++;
		}
		
	});
 });
 function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if(!regex.test(email)) {
    return false;
  }else{
    return true;
  }
}
</script>
</head>
<BODY background="../images/txture.jpg" >
	<div class="container-fluid">
	
	<TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
	<TR>
		<TD><Font Size='5' color=#3300FF> <B>EMAIL / SMS TO USERs</B> </Font></TD>
		<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
	</TR>
	</TABLE>
<%
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());
	String centercode = request.getParameter("centerid")==null?ccode:request.getParameter("centerid");

	//out.println (utyp + " " + usr);
	if (!utyp.equalsIgnoreCase("adm")) {
		out.println("This module is for Administrators only.");
		return;
	}
	Email email = new Email(request.getRealPath("/"));	
	rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
	SMS sms = new SMS(request.getRealPath("/"));
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
%>

<div class="container-fluid">
<div class="col-sm-10"> 
<div class="row  well well-lg"> 

	<div class="col-sm-12">
		<div class="input-group">
		<span class="input-group-addon">Type </span>
		<input class="form-control input-sm inp-c" size=15 maxlength=12 id="inp-c" name="inp-c" placeholder="Part of Name/Mobile/Email">
		<span class="input-group-addon addUsers" style="cursor: pointer;"> <i class="glyphicon glyphicon-search"></i> Search</span>
		<span class="input-group-addon addDoctors" style="cursor: pointer;"><i class="glyphicon glyphicon-plus"></i> Doctors</span>
		<span class="input-group-addon addDEO" style="cursor: pointer;"> <i class="glyphicon glyphicon-plus"></i> DEOs</span>
		<span class="input-group-addon remAll" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"></i> List </span>
		</div>
		<hr>
		<table class="table table-hovered table-bordered table-striped datalist nowrap">
		<thead><tr><td>Name</td><td>Email</td><td>VerifEmail</td><td>Phone</td><td>VerifPhone</td></tr></thead>
		<tbody></tbody>
		</table>
		<hr><b> Send Email/SMS to Selected Contacts</b><br><i style='color:Green'>Only Verified Email/SMS will receive communications</i><hr>

	</div>

	<div class="col-sm-8 message">
	<form method="post" id="form" enctype="multipart/form-data"> 
	<b>Subject of the Email (Not Applicable for SMS)</b>
	<input class="form-control" type=text Name=subj ID=subj Size=25 MaxLength=30>
	<!-- <b>Attachment of the Email (Not Applicable for SMS)</b>
	<input class="form-control" type="file" Name="attach" ID="attach">  -->
	<b>Message Body &amp; Dispatch</b>
	<textarea   class="form-control"  name=mesg id=mesg rows=5 cols=60></textarea>
	</form>
	<hr>
	<button class='btn btn-md btn-primary btnEmail'>Email</button> | <button class='btn btn-md btn-primary btnSms'>SMS</button>
	</div>
	<div class="col-sm-4">
		<div class='label label-default emlStatus'>
		</div>
	</div>	


</div>
</div>
</div>

</BODY>