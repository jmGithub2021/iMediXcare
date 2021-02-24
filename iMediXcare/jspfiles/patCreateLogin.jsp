<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());
	
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	
	
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


<script language="JavaScript">


</script>

<style>
input:invalid,
input:out-of-range {
    border-color:hsl(0, 50%, 50%);
    background:hsl(0, 50%, 90%);
}
</style>


</head>
<body background="../images/txture.jpg">
	<TABLE class="table" width=90% border=0 Cellpadding=0 Cellspacing=0>
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>CREATE ACCOUNT OF A PATIENT</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
	</TABLE>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="form-inline">
					<div class="form-group">
						<label for="patname">Patient's Name</label>
						<input type="text" class="form-control" id="patname" placeholder="Mr. X">
					</div>
					<div class="form-group">
						<button id="search-patient" class="btn btn-primary">Search Patient</button>
					</div>
				</div>
			</div>
			<div class="col-md-10" style="margin-top: 20px;">
				<form>
				<table class="table table-bordered table-stripped table-hover">
					<thead>
						<tr>
							<th>Patient's Name</th>
							<th>Patient ID</th>
							<th>EmailID</th>
							<th>MobileNo</th>
							<th>#</th>
						</tr>
					</thead>
					<tbody id="patients">

					</tbody>
				</table>
				</form>
			</div>
			<!--
			<div class="col-md-12">
				<div class="form-inline">
					<div class="form-group">
						<label for="patname">Online Requests Received</label>
					</div>
					<div class="form-group">
						<button class="btn btn-primary btnfetch" id="btnfetch" name="btnfetch">Refresh</button>
					</div>
				</div>
			</div>
			<div class="col-md-8 col-md-offset-2" style="margin-top: 20px;">
				<form>
				<table class="table table-bordered table-stripped table-hover">
					<thead>
						<tr>
							<th>Patient's Name</th>
							<th>Patient ID</th>
							<th>Send Email</th>
						</tr>
					</thead>
					<tbody id="patients_online">

					</tbody>
				</table>
				</form>
			</div>
		</div>
		-->
		
	</div>		
	<script type="text/javascript">
		$(document).ready(function() {

			$(document).on('click', 'button#search-patient', function(e){
				e.preventDefault();
				var patname = $('input#patname').val();
				if (patname=="") {
					alert("Please Enter a value for PatName");
					return;
				}
				var url = '<%=request.getContextPath()%>/jspfiles/patSearch.jsp';
				//console.log('url: '+url);
				$('#patients').html('');
				$.get(url, {patname: patname}, function(data){
					//console.log(data);
					var res = JSON.parse(data);
					if(res.count > 0){
						var tableContent = "";
						res.data.forEach(element => {
							//console.log(element)
							tableContent += "<tr>";
							tableContent += "<td>"+element['pat_name']+' '+element['m_name']+' '+element['l_name']+'</td>';
							tableContent += '<td>'+element['pat_id'] + '</td>';
								tableContent += '<td><input type="email" class="form-control emailid" id="email'+element['pat_id']+'"></div></td>';
							tableContent += '<td><input type="mobile" class="form-control mobile" id="mobile'+element['pat_id']+'"></div></td>';
							tableContent += '<td><a class="btn btn-md btn-info" title="Create Login for this patient" href="#" onClick="createLogin(\''+element['pat_id']+'\')"'+
								'>Submit</a></td>';

							tableContent += '</tr>';
						});
						$('#patients').html(tableContent);
					}
				});
			});

			$(document).on('click', 'button#btnfetch', function(e){
				e.preventDefault();
				var url = '<%=request.getContextPath()%>/jspfiles/patreqSearch.jsp';
				$('#patients_online').html('');
				$.get(url, {patname: ''}, function(data){
					var res = JSON.parse(data);
					console.log(res);
					if(res.count > 0){
						var tableContent = "";
						res.data.forEach(element => {
							//console.log(element)
							tableContent += "<tr>";
							tableContent += "<td>"+element['pat_name']+'</td>';
							tableContent += '<td>'+element['pat_id'];
							tableContent += '&nbsp;&nbsp;&nbsp;<a title="Create Login for this patient" href="#" onClick="createLogin(\''+element['pat_id']+'\')"'+
								'<span class="glyphicon glyphicon-search glyphicon-ok" aria-hidden="true"></span></a></td>';
							tableContent += '<td><input type="email" class="form-control emailid" id="email'+element['pat_id']+'" value="'+element['emailid']+'" ReadOnly></div></td>';
							tableContent += '</tr>';
						});
						$('#patients_online').html(tableContent);
					}
				});

			});



		$(document).on("keyup",".emailid",function(){
			if(IsEmail($(this).val())){
				let em = "";
				var id = "#"+$(this).attr("id");
				$.post("../forms/isExistingEmail.jsp?emailid="+$(this).val(), function(data){
					em = data;
					if(data>=1){
						alert("This emailid ("+$(id).val()+") is already exist");
						$(id).focus();
						$(id).val("");
						return false;				
					}	
				});
			}				
		});	

		$(document).on("keyup",".mobile",function(){
			let emd ="";
			let phl = $(this).val();
			var id = "#"+$(this).attr("id");
			if ( phl.length <= 9) return;
			$.post("../forms/isExistingPhone.jsp?phone="+$(this).val(), function(data){
				emd = data.trim();
				if(data>=1){
					alert("This PhoneNo ("+$(id).val()+") is already exists");
					$(id).focus();
					$(id).val("");
					return false;				
				}	
			});	
		});	

	});

		function createLogin(pat_id){
			event.preventDefault();
			// validate email
			var email = $('#email'+pat_id);
			var mobile = $('#mobile'+pat_id);
			if(email.val() != ''){
				if(IsEmail($(email).val())){
					let em=true;
					$.post("../forms/isExistingEmail.jsp?emailid="+$(email).val(), function(data){
						if(data>=1){
							alert("This emailid ("+$(email).val()+") is already exist");
							em=false;			
						}
						else{
							if(confirm('Do you reqlly want to create login for Patient ID: '+pat_id)){
								var url = '<%=request.getContextPath()%>/jspfiles/patCreateLoginProcess.jsp';
								$.get(url, {'pat_id': pat_id, 'email': email.val(), 'mobile': mobile.val()}, function(data){
									console.log("patCreateLoginProcess: " + data);
									var res = JSON.parse(data);
									if(res.status === 'success'){
										alert("User account created successfully");
									}else{
										alert("Could not create user account");
									}
									$('button#search-patient').click();
								});
							}						
						}
					});
					return em;
				}				
				else{
						alert("Enter a valid email address");
					}
			}
			else{
				if(confirm('You have not entered an Email-ID. Do you reqlly want to create login for Patient ID: '+pat_id+'?')){
					var url = '<%=request.getContextPath()%>/jspfiles/patCreateLoginProcess.jsp';
					$.get(url, {'pat_id': pat_id, 'email': email.val()}, function(data){
						//console.log(data);
						var res = JSON.parse(data);
						if(res.status === 'success'){
							alert("User account created successfully");
						}else{
							alert("Could not create user account");
						}
						$('button#search-patient').click();
					});
				}
			}
			
		}
		
		function IsEmail(email) {
		  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		  if(!regex.test(email)) {
			return false;
		  }else{
			return true;
		  }
		}		
	</script>
</body>
</html>
