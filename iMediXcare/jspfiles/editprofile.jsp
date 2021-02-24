<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.dataobj,imedix.projinfo,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page import="java.io.UnsupportedEncodingException,java.security.MessageDigest,java.security.NoSuchAlgorithmException" %>
<%@page import="java.util.logging.Level,java.util.logging.Logger,org.apache.commons.codec.digest.DigestUtils" %>

<%	
	Random rnd = new Random();
    MessageDigest md = MessageDigest.getInstance("MD5"); 
	
	String rgno = "";
	cook cookx = new cook();
	String uid = cookx.getCookieValue("userid",request.getCookies());
	String epas = "" ;
	String enam = "" ;
	String eadd = "" ;
	String emil = "" ;
	String epho = "" ;
	String eqln = "" ;
	String edes = "" ;
	String phverif = "N";
	String emverif = "N";
	String type="";
	
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	Object res=uinfo.getuserinfo(uid);
		
	try {
	
	if(res instanceof String){
		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
		return;
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0) {
			dataobj objusr = (dataobj) tmp.get(0);
			epas=objusr.getValue("pwd");
			enam=objusr.getValue("name");
			eadd=objusr.getValue("address");
			emil=objusr.getValue("emailid");
			epho=objusr.getValue("phone");
			eqln=objusr.getValue("qualification");
			edes=objusr.getValue("designation");
			phverif=objusr.getValue("verifphone");
			emverif=objusr.getValue("verifemail");
			type=objusr.getValue("type");
		}
	 }

	}catch (Exception e) {
			out.println(" Error <B>"+e+"</B>");		
	}
	//out.println (emverif + phverif);
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
<html>

<style>
span.input-group-addon{color:blue;min-width: 150px;}
</style>
<HEAD>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
	<script src="../bootstrap/jquery.md5.min.js"></script>

<TITLE> Edit User </TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
//function actnow( actionfile,  conttype)
function actnow()
{
	var flag,opwd;
	opwd=document.profile.oldpwd.value;
	if(opwd.length==0)
	{
		//alert("Existing Password field is mandatory");
		//document.profile.oldpwd.focus();
		//return false;
	}
	flag = checknum(document.profile.phone.value);
	if (flag == false)
	{
		return false;
	}
	
}
function blurEM()
{
	var em="<%=emil %>";
	var Nem=$('#emailid');
	if(em!=Nem)
	{
		$('#verifyemailstatus').val('N');
	}
}
function blurPH()
{
	var em="<%=epho %>";
	var Nem=$('#phone');
	if(em!=Nem)
	{
		$('#verifyphonestatus').val('N');
	}
	
}
function checknum(phn)
{
	var validcodechr = ' 0123456789';
	x = phn;
    while (x.substring(0,1) == ' ') x = x.substring(1);  //this loop will strip off leading blanks
	//if (x.length == 0){ alert("Blank Phone Number Not Allowed"); return false;}
	for (var i = 0; i < phn.length; i++) {
       var chr = phn.substring(i,i+1);
       if (validcodechr.indexOf(chr) == -1)
          { 	alert ("Characters and Special Character not allowed in Phone Number");
				 return false;
		  }
    }

	return true;
}
var isPHONE = function validatePhone(phone) {
	    const re = /^\d{10}$/;
	    return re.test(String(phone));
	};
function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if(!regex.test(email)) {
    return false;
  }else{
    return true;
  }
}
$(document).ready(function(){
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
		//if (mobile.length==10 || mobile.length==12) {
			if(!isPHONE(mobile)){
			$.post( "SendSMS.jsp", {mobileno: mobile, messageid:"M004"}, function( data ) {
				data = data.trim();
				if (data=="Error:Session") {
					alert("An error has been found during OTP generation.");
					location.reload();
				}
				else {
					$('.submitbtn').attr('readonly', true);
					$('.submitbtn').prop('disabled', true);
					alert(data+"\nPlease Type 6-Digit OTP received on mobile ["+mobile+"], in Yellow Box");
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
});
//-->
function goBack()
{
	//console.log(document.referrer);
	//window.location.href=window.location.href;
	window.parent.location=document.referrer;
	
}
</SCRIPT>
</HEAD>

<body BGColor="#FAF5F5" background="../images/txture.jpg">
	
<div class="container">
<div class="row">
<div class="col-sm-8 col-sm-offset-2">
<div class="well" style="min-width: 750px;">
<center><FONT SIZE="+2" COLOR="FIREBRICK">Edit <%=uid%>'s Details </font></center>
	<A class="btn" onClick="goBack()" Style="color:white;float:right; background:#337ab7; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A>
<FORM METHOD=GET Name=profile ACTION="saveeditusr.jsp" onSubmit="return actnow();">
<center><h5 style="color:blue">USER ID &emsp;&emsp;&emsp;&emsp;<strong><%=uid %></strong></h5>  </center>
<INPUT class="form-control" TYPE="hidden" NAME="uid" Value = "<%=uid %>" />
<div class = "input-group ">
         <span class = "input-group-addon"  >Current Password?</span>
		<INPUT class="form-control" TYPE="password" NAME="oldpwd" style="min-width:200px;" MAXLENGTH=40 SIZE=44 placeholder="Enter Existing Password" required /> 
 </div><br>

<div class = "input-group ">
         <span class = "input-group-addon"  >New Password?</span>
		<INPUT class="form-control" TYPE="password" NAME="pwd" style="min-width:200px;" MAXLENGTH=40 SIZE=44 placeholder="Enter New Password (blank if nochange)"/>  
 </div><br>

<div class = "input-group ">
         <span class = "input-group-addon"  >Full Name</span>
         <INPUT class="form-control" TYPE="text" NAME="name" style="min-width:200px;" MAXLENGTH=25 Size=24 VALUE="<%=enam %>" />
</div><br>

<div class = "input-group">
         <span class = "input-group-addon" >Address</span>
         <INPUT class="form-control" TYPE="text" NAME="address" style="min-width:200px;" MAXLENGTH=30 Size=24 VALUE="<%=eadd %>" />
</div><br>

<div class = "input-group">
         <span class = "input-group-addon" >Qualification</span>
         <INPUT class="form-control" TYPE="text" NAME="qualification" style="min-width:200px;" MAXLENGTH=30 Size=24 VALUE="<%=eqln %>" />
</div><br>

<div class = "input-group">
         <span class = "input-group-addon">Designation</span>
         <INPUT class="form-control" TYPE="text" NAME="designation" style="min-width:200px;" MAXLENGTH=30 Size=24 VALUE="<%=edes %>" />
</div><br>

<div class = "input-group">
         <span class = "input-group-addon">Email ID</span>
<span style="display:flex">
         <INPUT class="form-control" TYPE="text" NAME="emailid"  ID="emailid" style="min-width:200px;" placeholder="Email ID" MAXLENGTH=40 Size=24 VALUE="<%=emil %>" style="border-radius: 0; width:100%;" onblur="blurEM()" />
		<input class="form-control" type="text" name="vem" placeholder="otp-em" id="vem" style="min-width:70px;"  size=8 maxlength=6 style="border-radius: 0; width:35%; background-color: #faa;color: #a90909;"/>
<input id="verifyemailstatus"  name="verifyemailstatus" type=hidden readonly value="<%=emverif %>">
</span>
<span class="input-group-addon verifyEmail" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deleteEmail" style="cursor: pointer;">Remove</span>
</div><br>

<div class="input-group">
 <span class = "input-group-addon" >Phone No</span>
<span style="display:flex">
<input class="form-control" type="text" id ="phone" name="phone" maxlength="11" style="min-width:200px;" placeholder="Phone Number"  style="border-radius: 0; width:100%;"  VALUE="<%=epho %>" onblur="blurPH()">
<input class="form-control" type="text" name="vph" placeholder="otp-ph" style="min-width:70px;" id="vph" size=8 maxlength=6  style="border-radius: 0; width:35%;  background-color: #ffa;color: #a90909;" />
<input id="verifyphonestatus"  name="verifyphonestatus" type=hidden readonly  value="<%=phverif %>">
</span>
<span class="input-group-addon verifyPh" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deletePhone" style="cursor: pointer;">Remove</span>
</div>
<br>
<INPUT class="form-control btn-primary" TYPE="submit" Value="Modify">
</form>
</div>		<!-- "well" -->
</div>		<!-- "col-sm-6" -->
<div class="col-sm-3"></div>
</div>		<!-- "row" -->
</div>		<!-- "container" -->
</body>

</html>

