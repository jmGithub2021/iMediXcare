<%@page contentType="text/html" import="imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*" %>
<%@page import="java.io.UnsupportedEncodingException,java.security.MessageDigest,java.security.NoSuchAlgorithmException" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<% Random rnd = new Random(); 
   MessageDigest md = MessageDigest.getInstance("MD5"); 

%>
<%!
public  String md5Java(String message){
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(message.getBytes("UTF-8"));
           
            //converting byte array to Hexadecimal String
           StringBuilder sb = new StringBuilder(2*hash.length);
           for(byte b : hash){
               sb.append(String.format("%02x", b&0xff));
           }
          
           digest = sb.toString();
          
        } catch (UnsupportedEncodingException ex) {
            //Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
           // Logger.getLogger(StringReplace.class.getName()).log(Level.SEVERE, null, ex);
        }
        return digest;
}
%>
<HTML>

<HEAD>
<center><TITLE> Doctor Registration Form </TITLE></center>
<style>
.MsoNormal{background-color:#DDDDFF}
.sk_strng{background-color:#CCCCFF}
.txterror {
	background-color: #ecd2cf !important;
	color: red !important;
}
.txtsuccess {
	background-color: #c1fdb6 !important;
	color: green !important;
}
</style>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
	<link rel="stylesheet" href="../bootstrap/css/captcha.css" />	
	<script src="../bootstrap/captcha.js"></script>
	<script src="../bootstrap/jquery.md5.min.js"></script>
<SCRIPT language="JavaScript" type="text/javascript">

$(document).ready(function(){
    $('[data-toggle="popover"]').popover();   
	$("#uid").focus();
	$("#type").val("doc").trigger('click');
	$(document).on("click", "#type", function(){
		$("#type").val("doc");
		if($("#type").val() != "doc" )
		{
			$("#doc_regno").prop('disabled', true);
			$("#dis").prop('disabled', true);
		}
		else
		{
			$("#doc_regno").prop('disabled', false);
			$("#dis").prop('disabled', false);
		}
	});
	
	//////// Verification
	
	$(".verifyUid").click(function(){
		//alert("Hello");
		let uid = $("#uid").val();
		//if ( uid.length <= 3) return;
		$.post("../forms/isExistingUid.jsp?uid="+uid, function(data){
			if(data>=1){
				console.log("This uid ("+$("#uid").val()+") is already exist");
				$(".verifyUid").html('Retry!!');
				$('#uid').removeClass('txtsuccess');
				$("#uid").addClass('txterror');
				return false;				
			}
			else {
				console.log("This uid ("+$("#uid").val()+") is available. You can continue.");
				$(".verifyUid").html('Available!!');
				$('#uid').removeClass('txterror');
				$("#uid").addClass('txtsuccess');
			}			
		});
	});	
	
	$("#doc_regno").keyup(function(){
		let rgno = $("#doc_regno").val();
		if ( rgno.length < 10) return;
		let em = "";
		$.post("../forms/isExistingRgno.jsp?rgno="+rgno, function(data){
			if(data>=1){
				alert("This rg_no ("+$("#doc_regno").val()+") is already exist");
				$("#doc_regno").css({'border': 'px solid #f00 !important','color': 'red  !important','font-weight': 'bold  !important'});
				return false;				
			}	
			else {
				//alert("This uid ("+$("#doc_regno").val()+") is available. You can continue.");
				//$("#uid").css({'border': '1px solid #0f0  !important','color': 'red  !important','font-weight': 'bold  !important'});
			}
		});	
	});	
	
	$("#emailid").keyup(function(){
		let email = $(this).val();
		if ( email.length <= 9) return;
		if(IsEmail($(this).val())){
			let em = "";
			$.post("../forms/isExistingEmail.jsp?emailid="+$(this).val(), function(data){
				em = data;
				if(data>=1){
					alert("This emailid ("+$("#emailid").val()+") is already exist");
					$("#emailid").val("");
					return false;				
				}	
			});

		}		
	});	

	$(document).on("click",".verifyEmail",function(){
		<%
			int number2 = rnd.nextInt(999999);
			String emOtp =  String.format("%06d", number2);
			session.setAttribute("emOtp",emOtp); 
		%>
		var emailid=$("#emailid").val();
		if (emailid=="" && emailid.length==0) return;
		//alert (emailid);
		if(IsEmail(emailid)){
			$.post( "SendEmail.jsp", {email: emailid, messageid:"OTP"}, function( data ) {
				data = data.trim();
				if (data=="Error:Session") {
					alert("An error has been found during OTP generation.");
					location.reload();
				}
				else {
					$('.submitbtn').attr('readonly', true);
					$('.submitbtn').prop('disabled', true);
					alert("Please Type 6-Digit OTP received on EMAIL ["+emailid+"], in Red Box");
				}
			});
		}
		else {
			alert("Your EmailID is in incorrect format!!");
		}
	});
	
	$("#vem").keyup(function(){
		var otp = $(this).val();
		$('#verifyemailstatus').val('N');
		if ( otp.length == 6) {
			var otpenc = $.MD5($(this).val());
			var verifOtp = '<%= md5Java(emOtp)%>';
			console.log("otp:" + otp);
			console.log("otpenc:" + otpenc);
			console.log("verifOpt:" + verifOtp);
			if (otpenc == verifOtp) {
				alert ("Email Verified and locked!!");
				$('#emailid').attr('readonly', true);
				$('#emailid').addClass('input-disabled');
				$('.submitbtn').attr('readonly', false);
				$('.submitbtn').prop('disabled', false);
				$('#verifyemailstatus').val('Y');
				$.post( "securefld.jsp", {fld: $('#emailid').val(), fldstat:$('#verifyemailstatus').val(),fldtype:'E'}, function( data ) {});
			}
			else {
				$('.submitbtn').attr('readonly', true);
				$('.submitbtn').prop('disabled', true);
				$('#verifyemailstatus').val('N');
			}
		}
	});

	$("#phone").keyup(function(){
		let emd ="";
		let phl = $(this).val();
		if ( phl.length <= 10) return;
		$.post("../forms/isExistingPhone.jsp?phone="+$(this).val(), function(data){
			emd = data.trim();
			if(data>=1){
				alert("This PhoneNo ("+$("#phone").val()+") is already exists");
				$("#phone").val("");
				return false;				
			}	
		});	
	});	
	
	$(document).on("click",".verifyPh",function(){
		<%
		int number1 = rnd.nextInt(999999);
		String phOtp =  String.format("%06d", number1);
		session.setAttribute("phOtp",phOtp);  
		%>
		var mobile=$("#phone").val().trim();
		if (mobile=="" && mobile.length==0) return;
		if (mobile.length==10 || mobile.length==12) {
			$.post( "SendSMS.jsp", {mobileno: mobile, messageid:"M004"}, function( data ) {	
				data = data.trim();
				if (data=="Error:Session") {
					alert("An error has been found during OTP generation.");
					location.reload();
				}
				else {
					$('.submitbtn').attr('readonly', true);
					$('.submitbtn').prop('disabled', true);
					alert(data + "\nPlease Type 6-Digit OTP received on your mobile ["+mobile+"], in Yellow Box");
				}
			});
		}
		else {
			alert("Your mobile no is in incorrect format!!");
		}
	});
	
	$("#vph").keyup(function(){
		var otp = $(this).val();
		$('#verifyphonestatus').val('N');
		if ( otp.length == 6) {
			var otpenc = $.MD5($(this).val());
			var verifOtp = '<%= md5Java(phOtp) %>';
			console.log("otp:" + otp);
			console.log("otpenc:" + otpenc);
			console.log("verifOpt:" + verifOtp);
			if (otpenc == verifOtp) {
				alert ("Mobile Verified and locked!!");
				$('#phone').attr('readonly', true);
				$('#phone').addClass('input-disabled');
				$('.submitbtn').attr('readonly', false);
				$('.submitbtn').prop('disabled', false);
				$('#verifyphonestatus').val('Y');
				$.post( "securefld.jsp", {fld: $('#phone').val(), fldstat:$('#verifyphonestatus').val(),fldtype:'M'}, function( data ) {});
			}
			else {
				$('.submitbtn').attr('readonly', true);
				$('.submitbtn').prop('disabled', true);
				$('#verifyphonestatus').val('N');
			}
		}
	});

	$(".deletePhone").bind("click",function(){
		var r = confirm("Your Phone will not be saved? Are you sure?");
		if (r == true) {
		  $("#phone").val("");
		  $('#phone').attr('readonly', false);
		  $('#phone').removeClass('input-disabled');
		  $('.submitbtn').attr('readonly', false);
		  $('.submitbtn').prop('disabled', false);
		  $('#verifyphonestatus').val('N');
		  $('#vph').val('');
		} 
	});
	
	$(".deleteEmail").bind("click",function(){
		var r = confirm("Your EmailID will not be saved? Are you sure?");
		if (r == true) {
		  $("#emailid").val("");
		  $('#emailid').attr('readonly', false);
		  $('#emailid').removeClass('input-disabled');
		  $('.submitbtn').attr('readonly', false);
		  $('.submitbtn').prop('disabled', false);
		  $('#verifyemailstatus').val('N');
		  $('#vem').val('');
		} 
	});
	////////////// Verification
});
function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if(!regex.test(email)) {
    return false;
  }else{
    return true;
  }
}

function validate()
		{
			var na, msg=0;
			var ret;
			var tmp; var tnum;
			
			if (frmreg.d2.checked == false) 
			{
	    			alert ('You didn\'t agree with Disclaimer and/or Terms & Conditions!');
	    			return false;
			}

			if ($("#uid").val().length == 0) { msg=1; na="LoginID"; }
			else if ($("#pwd").val().length == 0) { msg=1; na="Password"; }
			else if ($("#cpwd").val().length == 0) { msg=1; na="Confirm Password"; }
			else if ($("#name").val().length == 0) { msg=1; na="User Name"; }
			else if ($("#address").val().length == 0) { msg=1; na="Address"; }
			//else if ($("#phone").val().length == 0) { msg=1; na="Phone"; }
			//else if ($("#emailid").val().length == 0) { msg=1; na="EmaiID"; }
			else if ($("#center").val() == "NIL") { msg=1; na="CenterID"; }
			else if ($("#dis").val() == "NIL") { msg=1; na="DisciplineID"; }
			else {}
						
			if (msg == 1)
			{
				window.alert ("Do not Leave the Field(s) Empty! Currently ["+na+"] is blank!!");
				return false;
			}
			
			
			if  ( ($("#phone").val().length == 0) && ($("#emailid").val().length == 0) ) {
				window.alert ("Atleast Phone/EmailID must be entered!! Currently both are blank!!");
				return false;
			}
			if  ( ($("#phone").val().length != 0) && ($("#vph").val().length == 0) ) {
				window.alert ("Phone No must be verified and its OTP must be entered!!");
				return false;
			}
			if  ( ($("#emailid").val().length != 0) && ($("#vem").val().length == 0) ) {
				window.alert ("EmailID No must be verified and its OTP must be entered!!");
				return false;
			}
			/*
			ret = checkphone($("#phone.value);
			if (ret == false)  {$("#phone.select(); return false;}
			*/	
			if ($("#pwd").val() != $("#cpwd").val())
				{
					window.alert ("Password MisMatch,  Please Re-type it");
					$("#pwd").focus();
					return false;
				}
			//alert ($("#type").val());
			if ($("#type").val() == "doc" && $("#doc_regno").val().length == 0) 
			{
					window.alert ("Doctors must provide Registration Number");
					$("#doc_regno").focus();
					return false;
			}

			if($("#type").val() == "doc")
			{
				if($("#doc_regno").val().length < 10)
				{
					window.alert ("**Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");
					return false;
					$("#doc_regno").focus();
					return false;
				}
				if($("#doc_regno").val().substring (3,4) != ".") 
				{
					//alert(document.add.rgn.value.substring (3,4));
					window.alert (" !! Provide Valid Registration Number. The correct format is : SST.6 digit Registration Number \n [ SS : Two digit State Code \n T : Health Care Practitioner Type ]");
					
					$("#doc_regno").focus();
					return false;
				}
				for(i=0;i<3;i++) 
				{ 
					tmp=$("#doc_regno").val().substring (i,i+1); 
					if ((tmp >= 'a' && tmp <= 'z') || (tmp >= 'A' && tmp <= 'Z') ) continue;
					else 
					{ 
						window.alert ("Provide Registration Number in correct format is : SST.6 digit Registration Number");
						
						$("#doc_regno").focus();
						return false;
					} 
				}
				
			}
		return true;	
		}




function checkphone(phn)
		{
			var validcodechr = ' 0123456789';
			x = phn;
			while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
			if (x.length == 0){ alert("Blank Phone Number Not Allowed"); return false;}

			for (var i = 0; i < phn.length; i++) {
			var chr = phn.substring(i,i+1);
			if (validcodechr.indexOf(chr) == -1)
				{ 	alert ("Characters and Special Character not allowed in Phone Number");
						return false;
				}
			}

			return true;
		}

function checkAgreement(theForm) {
	$('#d1').is(":checked")
	if ( $('#d1').is(":checked") == false && $('#d2').is(":checked") == false) 
	{
	    alert ('You didn\'t agree with Disclaimer and/or Terms &amp; Conditions!');
	    return false;
	} else { 	
	    return true;
	}
}

</SCRIPT>
	
	
</HEAD>

<BODY bgcolor="#8C917A" background="../images/bg1.jpg" >
<div class="container-fluid">
<div class="row">
<div class="col-sm-6 col-sm-offset-3"><br>
<div class="well">
<center><h3>Doctor Registration Form</h3></center>
<form role="form" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="../servlet/saveregusers" NAME="frmreg">
<div class="input-group">
<span class="input-group-addon" style="color:red">* Login ID</span>
<input type="text" class="form-control" NAME="uid" id="uid" MAXLENGTH=15 placeholder="(*) Enter Login Id" Required />
<span class="input-group-addon verifyUid" style="cursor: pointer;">Check Availability</span>
</div><br>
<div class="input-group">
<span class="input-group-addon" style="color:red">* Password</span>
<input type="password" class="form-control" NAME="pwd" id="pwd" MAXLENGTH=30 placeholder="(*) Password" Required/></div><br>
<div class="input-group">
<span class="input-group-addon" style="color:red">* Confirm Password</span>
<input type="password" class="form-control" NAME="cpwd" id="cpwd" MAXLENGTH=30 placeholder="(*) Confirm Password" Required /></div><br>
<div class="input-group">
<span class="input-group-addon" style="color:red">* Full Name</span>
<input type="text" class="form-control" NAME="name" id="name" MAXLENGTH=50 placeholder="(*) Full Name" Required/></div><br>
<div class="input-group">
<span class="input-group-addon" style="color:red">* Address / Hospital</span>
<input type="text" class="form-control" NAME="address" id="address" MAXLENGTH=250 placeholder="(*) Address" Required/></div><br>


<div class="input-group" >
<span class="input-group-addon" style="color:red">* EmailID</span>
<span style="display:flex">
<input class="form-control" type="email" name="emailid" placeholder="Enter Email ID" id="emailid"  style="border-radius: 0; width:100%;" />
<input class="form-control" type="text" name="vem" placeholder="otp-em" id="vem"  size=8 maxlength=6 style="border-radius: 0; width:35%; background-color: #faa;color: #a90909;"/>
<input id="verifyemailstatus"  name="verifyemailstatus" type=hidden readonly value="N">
</span>
<span class="input-group-addon verifyEmail" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deleteEmail" style="cursor: pointer;">Remove</span>
</div>
<br>
<div class="input-group">
<span class="input-group-addon" style="color:red">* Phone</span>
<span style="display:flex">
<input class="form-control" type="text" id ="phone" name="phone" maxlength="11" placeholder="Phone Number"  style="border-radius: 0; width:100%;" >
<input class="form-control" type="text" name="vph" placeholder="otp-ph" id="vph" size=8 maxlength=6  style="border-radius: 0; width:35%;  background-color: #ffa;color: #a90909;" />
<input id="verifyphonestatus"  name="verifyphonestatus" type=hidden readonly  value="N">
</span>
<span class="input-group-addon verifyPh" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deletePhone" style="cursor: pointer;">Remove</span>
</div>
<br>
<div class="input-group">
<span class="input-group-addon" style="color:black">* Qualification</span>
<input type="text" class="form-control" NAME="qualification" MAXLENGTH=25 placeholder="Qualification" />
</div><br>

<div class="input-group">
<span class="input-group-addon" style="color:black">* Designation</span>
<input type="text" class="form-control" NAME="designation" MAXLENGTH=50 placeholder="Designation" Value='doctor' readonly/></div><br>

<div class="input-group">
<span class="input-group-addon" style="color:red">* Hospital @WBhealth</span>
<SELECT NAME="center" ID="center" class="form-control" ReadOnly>
	<%
		try
		{
			String hcode="";
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						hcode = datatemp.getValue("code");
						if ( hcode.equalsIgnoreCase("VBCR019")) {
							out.println("<option value="+datatemp.getValue("code")+" selected >"+datatemp.getValue("name")+"</option><br>");
						}
					} // end for
			}// end else
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

	  %>
</SELECT></div><br>	

<div class="input-group">
<span class="input-group-addon" style="color:red">* User Type</span>

<SELECT class="form-control" NAME="type" ID="type" Size=1>
		<Option Value="doc">Doctors</Option>
		<!--<Option Value="con">Counselor</Option>
		<Option Value="usr">Data Enry Operator</Option> -->
</SELECT>
</div>
<br>

<div class="input-group">
<span class="input-group-addon" style="color:red">* Expertise</span>
<SELECT class="form-control" name="dis" id="dis">
<Option Value="NIL">--Select Discipline--</Option>
	<%
	try{
		rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
		Object depts = ddinfom.getDepartments(ccode);
		Vector deptsV = (Vector)depts;
		String options = "";
		for(int i=0;i<deptsV.size();i++){
			dataobj obj = (dataobj)deptsV.get(i);
			options += "<option value='"+obj.getValue("department_name")+"'>"+obj.getValue("department_name")+"</option>";
		}
	/*FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
	int i;
	String strn1="";
	do{
		i = fin.read();
		if((char) i != '\n')
			strn1 = strn1 + (char) i;
		else {
				strn1 = strn1.replaceAll("\n","");
			strn1 = strn1.replaceAll("\r","");
			out.println("<option value='" + strn1 + "'>" + strn1 + "</Option>");
			strn1="";
		}
	}while(i != -1);
	fin.close();*/
	out.println(options);
}catch(Exception e){
	System.out.println(e.toString());
}
	/*
	FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
	int i;
	String str="";
	do{
		i = fin.read();
		if((char) i != '\n')
			str = str + (char) i;
		else {
			String truncated = str.replaceAll("\\p{Cntrl}", ""); 
			out.println("<option value='" + truncated + "'>" + truncated + "</Option>");
			str="";
		}
	}while(i != -1);

	fin.close();*/
	%>
</SELECT></div><br>	
<div class="input-group">
<span class="input-group-addon" style="color:red">* Registration Number</span>
<input type="text" class="form-control" NAME="doc_regno" id="doc_regno" MAXLENGTH=10 placeholder="Regn no" />
</div></br>
<input type="checkbox" name="d2" id="d2"><a href="#" data-toggle="popover" title="Terms & Conditions: " data-content="Please contact Administrator of iMediX @ Sastha Bhaban, Kolkata">Terms & Conditions</a>&nbsp;&nbsp;<span style="color:red">(*) mark is mandatory field.</span><br>

<div class="captchaField">
<span id="SuccessMessage" class="success">Thanks! , The Captcha Is Correct!</span>
<input type="text" id="UserCaptchaCode" class="CaptchaTxtField" placeholder='Enter Captcha - Case Sensitive' required>
<span id="WrongCaptchaError" class="error"></span>
<div class='CaptchaWrap'>
  <div id="CaptchaImageCode" class="CaptchaTxtField">
	<canvas id="CapCode" class="capcode" width="300" height="80"></canvas>
  </div> 
  <input type="button" class="ReloadBtn" onclick='CreateCaptcha();'>
</div>
</div>

<br/><INPUT class="form-control btn-primary" TYPE="submit" Value="Submit" onclick="return validate()" >
</form>
</div>	<!-- "well" -->

<br><br><a href="http://imedix.wbhealth.gov.in/iMediX/" style="text-decoration: none"><h3><strong>HOME</strong></h3></a> 
</div>	<!-- "col-sm-5" -->

</div><!-- "row" -->
</div><!-- "container-fluid" -->
</BODY>
</HTML>
