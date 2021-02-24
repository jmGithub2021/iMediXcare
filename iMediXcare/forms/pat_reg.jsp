<%@page contentType="text/html" import="javax.servlet.*,imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*"%>
<%@page import="java.io.UnsupportedEncodingException,java.security.MessageDigest,java.security.NoSuchAlgorithmException" %>
<%@page import="java.util.logging.Level,java.util.logging.Logger,org.apache.commons.codec.digest.DigestUtils" %>

<%
    Random rnd = new Random();
    MessageDigest md = MessageDigest.getInstance("MD5"); 
	 
	//out.println ("phOtp:" + phOtp +" , emOtp:" + emOtp);
	
	cook cookx = new cook();
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	String  referring_doc,ccode="";
	ccode ="VBCR019";
	String dat = myDate.getCurrentDate("dmy",false);
	String doc_id=request.getParameter("doc_id");

	Date cur_date = new Date();
	SimpleDateFormat dde = new SimpleDateFormat("dd-MM-yyyy");
	String today = dde.format(cur_date);
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


public String stateList(HttpServletRequest request) throws IOException{
	String stateList = "";
	try{
		FileReader jsonContent = new FileReader(new File(request.getRealPath("/jsystem")+"/MDDS_demographic/statecode.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_state = nodes.size();
		for(int i=0;i<no_of_state;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			stateList += "<option value='"+jo.get("state_code").toString()+"'>"+jo.get("state_name").toString()+"</option>";
		}
	}catch(Exception ex){stateList=ex.toString();}
	return stateList;
}

public String appellationList(HttpServletRequest request) throws IOException{
	String appellationList = "";
	try{
		FileReader jsonContent = new FileReader(new File(request.getRealPath("/jsystem")+"/MDDS_demographic/appellation.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_state = nodes.size();
		for(int i=0;i<no_of_state;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			appellationList += "<option value='"+jo.get("appliation_code").toString()+"'>"+jo.get("values").toString()+"</option>";
		}
	}catch(Exception ex){appellationList=ex.toString();}
	return appellationList;
}

public String religionList(HttpServletRequest request) throws IOException{
	String religionList = "";
	try{
		FileReader jsonContent = new FileReader(new File(request.getRealPath("/jsystem")+"/MDDS_demographic/religion.json"));
		JSONObject jsobj = (JSONObject)new JSONParser().parse(jsonContent);
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_religion = nodes.size();
		for(int i=0;i<no_of_religion;i++){
		JSONObject jo = (JSONObject)nodes.get(i);
		religionList += "<option value='"+jo.get("religion_code").toString()+"'>"+jo.get("religion_values").toString()+"</option>";
		}
	}catch(Exception ex){religionList = ex.toString();}
	return religionList; 
}
public String districtList(HttpServletRequest request,int stateCode) throws IOException{
	String districtList = "";
	try{
		FileReader jsonContent = new FileReader(new File(request.getRealPath("/jsystem")+"/MDDS_demographic/districtcode.json"));
		JSONObject jsobj = (JSONObject)new JSONParser().parse(jsonContent);
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_district = nodes.size();
		for(int i=0;i<no_of_district;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			int state_code = Integer.valueOf(jo.get("state_code").toString()); 
			if(state_code==stateCode)
				districtList += "<option value='"+jo.get("district_code").toString()+"'>"+jo.get("district_name").toString()+"</option>";				
		}
		
	}catch(Exception ex){districtList = ex.toString();}

return districtList;
}
%>


<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<!--<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->

<title>Patient Registration</title>

	<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.js"> </SCRIPT>
	<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script2.js"> </SCRIPT>

	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/captcha.css" />	
	<SCRIPT LANGUAGE="JavaScript" SRC="../includes/chdateformat.js"></SCRIPT>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/captcha.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.md5.min.js"></script>
<style>
.notknown-dob{
    position: absolute;
    right: 0px;
    z-index: 9999;
    cursor: pointer;
    bottom: -15px;
    color: #0000ff;
    font-size: 12px;
}
.inline-flex{display:inline-flex}
.agegroup-name{width:100%}
.input-disabled{background-color:#EBEBE4;border:1px solid #ABADB3;padding:2px 1px;}

</style>	
	
<SCRIPT LANGUAGE="JavaScript">

function validateMedForm(){
	var appellation = "",firstName = "",middleName = "",lastName = "",fullName="",religion = "",marital_status = "",cast_category = "",sex = "",opd_no="",age="",diseasetype="",persidtype="",persidvalue="",address="",policestn="",phone="",city="",dist="",state="",country="",pinCode="",pat_person="",pat_relation="",pat_person_add="";
	var ageyy = "", agemm = "", agedd = "";
	var appellation_enum = {1:"Mr.",2:"Mrs.",3:"Ms.",4:"Shri.",11:"Dr.",12:"CA.",13:"Er.",14:"Prof."};
	var gender_enum = {"M":"Male","F":"Female","T":"Transgender"};
	var mobileNo_pattern = "[0]\-[0-9]{10}";

	appellation = $("#pre").val();
	firstName = $("#pat_name").val();
	middleName = $("input[name=m_name]").val();
	lastName = $("input[name=l_name]").val();
	fullName = firstName+" "+middleName+" "+lastName;
	religion = $("#rel").val();
	marital_status = $("#mar_st").val();
	caste_category = $("#caste_category").val();
	sex = $("input[name=sex]").val();
	opd_no = $("input[name=opdno]").val();
	diseasetype = $("input[name=class]").val();
	persidtype = $("input[name=persidtype]").val();
	persidvalue = $("input[name=persidvalue]").val();
	address = $("input[name=addline1]").val();
	policestn = $("input[name=policestn]").val();
	phone = $("input[name=phone]").val();
	city = $("input[name=city]").val();
	dist = $("#dist").val();
	state = $("#state").val();
	country = $("input[name=country]").val();
	pinCode = $("input[name=pin]").val();
	
	try{
		ageyy = $("#ageyy").val();
		agemm = $("#agemm").val();
		agedd = $("#agedd").val();
	}catch(err){
		ageyy = "";
		agemm = "";
		agedd = "";
		alert("Enter date of birth"+ageyy);
		}
	
	if(Number(appellation)>15 || typeof($("#pre").html())!="string" || appellation_enum[appellation]=="undefined"){
		alert("Appellation Invalid"+appellation);
		return false;
	}
	else if(firstName.length>30 || typeof(firstName) != "string"){
		alert("First Name is invalid");
		return false;
	}
	else if(fullName.length >99 || typeof(fullName) != "string"){
		alert("Full Name is invalid");
		return false;	
	}
	else if(isNaN(religion)){
		alert("Religion is Invalid");
		return false;
	}
	else if(isNaN(marital_status)){
		alert("Marital Status is Invalid");
		return false;		
	}
	else if(gender_enum[sex]=="undefined"){
		alert("Gender is not valid");
		return false;
	}
	else if(opd_no.length>24 ){
		alert("OPD number should not be blank or more than 24 character"+opd_no);
		return false;
	}
	else if(!IsEmail($("#emailid").val())){
		alert("Enter Email-ID");
		return false;
	}

	else if((ageyy.length ==0 && agemm.length == 0 && agedd.length ==0)||(isNaN(ageyy) || isNaN(agemm) || isNaN(agedd))){
		alert("Enter date of birth");
		return false;
	}
	/*else if(persidvalue.length>12 || persidvalue.length<5){
		alert("Identity number should be more then 4 character and not more than 12 character");
		return false;
	}*/	
	else if(dist.length>3 || isNaN(dist)){
		alert("District is Invalid");
		return false;
	}
	else if(state.length>2 || isNaN(state)){
		alert("Invalid State");
		return false;
	}
	/*else if(!mobileNo_pattern.test(phone)){
		alert("Mobile number is invalid");
		return false;
		}
	else if(phone.length != 10 || isNaN(phone)){
		alert("Mobile number is invalid");
		return false;
		}	*/	
	else{
		return CheckCaptcha();
		}	
	return false;	
	

}
function getDistrict(stateCode){
		var districtList = "<option value='dis' selected>Select District</option>";
		$.get('../jsystem/MDDS_demographic/districtcode.json',function(data){
			var obj = JSON.parse(JSON.stringify(data));
			//console.log("Data : "+JSON.stringify(data));
			var nodes_length = obj.nodes.length;
			//console.log(obj.nodes);
			for(var i=0;i<nodes_length;i++){
				if(obj.nodes[i].state_code==stateCode){
					districtList += "<option value='"+obj.nodes[i].district_code+"'>"+obj.nodes[i].district_name+"</option>";
				}
			}
			$("#dist").html(districtList);
		});	
}


$(document).ready(function(){
	
	$('.submitbtn').attr('readonly', true);
	$('.submitbtn').prop('disabled', true);
					
	$("option[value=19]").attr("selected","true");
	getDistrict($("#state").val());
	$("#state").change(function(e){
		var stateCode = $(this).val();
		getDistrict(stateCode);

	});
	
	$(".id_chkd").change(function(e){
	//$(this).parent().prepend($(this).prop("checked"));
	if($(this).prop("checked"))
		$(this).val("1");
	else
		$(this).val("0");
	
	
	});


$(function () {
	var startDateTo = new Date("10-01-1945"),
	endDateTo = new Date();
	$('#dob-datepicker').datetimepicker({
		viewMode: 'years',
		format:'dd-MM-yyyy',
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 4,
		keyboardNavigation: 1,
		minView: 2,
		forceParse: 0,
		startDate: startDateTo,
		endDate: endDateTo,
		setDate: endDateTo
	});	
});

	$(".notknown-dob").bind("click",function(){
		$("#dob-datepicker .dob").val("");
		$(".age-div").toggleClass("hidden",1000);
		$(".age-div").css("margin-top","15px");
		$(".age-div").css("pointer-events","auto");
	});
	function calculateAge(dob){ //"dob" format dd-MM-yyyy
		var ageDays = "",ageMonths = "",ageYears = "";
		var dob = dob;
		var today = "<%=today%>"; //"today" format dd-MM-yyyy
		var dobSplit = dob.split("-");
		var todaySplit = today.split("-");
		var dobDays = dobSplit[0];
		var dobMonths = dobSplit[1];
		var dobYears = dobSplit[2];
		var todayDays = todaySplit[0];
		var todayMonths = todaySplit[1];
		var todayYears = todaySplit[2];
		console.log(dob +" : "+today);
		if(todayDays < dobDays){
			todayDays = parseInt(todayDays) + 30;
			todayMonths = parseInt(todayMonths) - 1;
			ageDays = todayDays - dobDays;
		}
		else{
			ageDays = todayDays - dobDays;
		}
		if(todayMonths < dobMonths){
			todayMonths = parseInt(todayMonths)+12;
			todayYears = parseInt(todayYears)-1;
			ageMonths = todayMonths - dobMonths;
		}
		else{
			ageMonths = todayMonths-dobMonths;
		}
		if(todayYears < dobYears){
			
		}
		else{
			ageYears = todayYears-dobYears;
		}
		if(ageYears !=0 && !isNaN(ageYears))
			calculateAgeGroup(ageYears,"year");
		if(ageYears < 2 && !isNaN(ageMonths))
			calculateAgeGroup(ageMonths+12,"month");
		if(ageYears == 0 && ageMonths == 0 && !isNaN(ageDays))
			calculateAgeGroup(ageDays,"day");
			
	//	alert(dob +" : "+ageDays+"-"+ageMonths+"-"+ageYears);
		$(".age-div").css("margin-top","15px");
		$(".age-div").css("pointer-events","none");
		$(".age-div").removeClass("hidden");
		$("#ageyy").val(ageYears);
		$("#agemm").val(ageMonths);
		$("#agedd").val(ageDays);
	}
	function calculateAgeGroup(age,unit){
		$.get('../jsystem/age_group.json',function(data){
			var obj = JSON.parse(JSON.stringify(data));
			for(var i=0;i<obj.length;i++){
				if(obj[i].unit==unit && age >= obj[i].minage && age <= obj[i].maxage){
					$(".agegroup-name").html(obj[i].name);
					$(".agegroup-name").append("<input type='text' name='type' value='"+obj[i].agegroup+"' hidden/>");
				}
					else{
						console.log(obj[i].unit+" : "+obj[i].minage+" : "+obj[i].maxage+" : "+age+" : "+unit);
					}
			}
			console.log(JSON.stringify(data)+obj.length);
		});
	}
	$(".age-div input").bind('keyup keydown',function(){
		var ageYears = $("#ageyy").val();
		var ageMonths = $("#agemm").val();
		var ageDays = $("#agedd").val();
		if(ageYears=="") ageYears=0;
		if(ageMonths=="") ageMonths=0;
		if(ageDays=="") ageDays=0;
		
		if(ageYears >2 && !isNaN(ageYears))
			calculateAgeGroup(ageYears,"year");
		if(ageYears < 2 && ageYears > 0 && !isNaN(ageMonths)){
			calculateAgeGroup(parseInt(ageMonths)+12,"month");
			console.log("GGGG : "+ageYears);
		}
		if(ageYears == 0 && ageMonths == 0 && !isNaN(ageDays))
			calculateAgeGroup(ageDays,"day");	
			
	});
	
	$("#dob-datepicker").on("changeDate", function() {
		var dob = $(this).children(".dob").val();
		if(dob.length>=10)
		calculateAge(dob);
	});
	
	$("#emailid").keyup(function(){
		let email = $(this).val();
		if ( email.length <= 9) return;
		if(IsEmail($(this).val())){
			let em = "";
			$.post("isExistingEmail.jsp?emailid="+$(this).val(), function(data){
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
			$.post( "../jspfiles/SendEmail.jsp", {email: emailid, messageid:"OTP"}, function( data ) {
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
				$.post( "../jspfiles/securefld.jsp", {fld: $('#emailid').val(), fldstat:$('#verifyemailstatus').val(),fldtype:'E'}, function( data ) {
					console.log("Recv: " + data);
				});
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
		if ( phl.length <= 9) return;
		$.post("isExistingPhone.jsp?phone="+$(this).val(), function(data){
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
		if (mobile.length==10 ) {
			$.post( "../jspfiles/SendSMS.jsp", {mobileno: mobile, messageid:"M004"}, function( data ) {	
				data = data.trim();
				console.log(data);
				if (data=="Error:Session") {
					alert("An error has been found during OTP generation.");
					location.reload();
				}
				else {
					$('.submitbtn').attr('readonly', true);
					$('.submitbtn').prop('disabled', true);
					//alert(data + "\nPlease Type 6-Digit OTP received on your mobile ["+mobile+"], in Yellow Box");
					alert("\nPlease Type 6-Digit OTP received on your mobile ["+mobile+"], in Yellow Box");
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
				$.post( "../jspfiles/securefld.jsp", {fld: $('#phone').val(), fldstat:$('#verifyphonestatus').val(),fldtype:'M'}, function( data ) {
					console.log("Recv: " + data);
				});
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


function chkblnk(fieldname,Label){
	//alert(" chkblnk :" + fieldname);

	var fdval=document.getElementById(fieldname).value;
	
	//alert(fdval);

	var temp=fdval.toString();
	//alert(temp);
	//if(error==0)
	//{
	if(temp.length==0)
	{
		//error=1;
		document.getElementById(fieldname).focus();
		alert("The "+ Label +" field cannot be left blank");
		document.getElementById(fieldname).select();
		//error=0;
		return false;
	}
	//}
return true;
}


function putentrydate(cdt){

//alert ( "I am Here");

if(!chkblnk("pat_name","Name"))
{ return false; }

if(!checkdigit('phone','phone'))
{ return false; }

if(!checkdigit('pin','pin'))
{ return false; }

/*if(!chkblnk("pin","Pin Number"))
{ return false; }*/
//merge the agedd,agemm,ageyy to create the age field

document.getElementById("age1").value = document.med.ageyy.value +","+document.med.agemm.value +","+ document.med.agedd.value;

//alert(document.med.type.value);
//alert(document.med.ageyy.value + "ccc" + document.getElementById("age").value);

if(dropdown_chk()==true){
	return validateMedForm();
}
return false;


}


function chkpatdob(){

	if(document.med.dateofbirth.value=='')
	{
		alert("Enter Date of Birth");	
		return false;
	}
	return true;
}

function checkdigit(fdnam,label)
{
	var tnum,tmp,fdval;
	fdval = document.getElementById(fdnam).value
	//alert(fdval)
	for(i=0;i<fdval.length;i++)
	{
	 tmp=fdval.substring (i,i+1);
	tnum=parseInt(tmp);
	if (tnum>=0 && tnum<=9)
		continue;
	else {
		alert('Please enter Number in the '+label+' field');
		document.getElementById(fdnam).select();
		return false;
		}
	}
	return true;
}


function checkPositive(fdnam, num)
{
	var fdval;
	fdval = document.med.elements[num].value;
	if (parseInt(fdval) <= 0 ){
		alert(fdnam +" Entered is not a positive number");
		return false;
	}
	else 
	{ return true;}
}

function dropdown_chk(){
//alert("It's Working !");	
if(document.getElementById("pre").value=="pre"){
	alert("Prefix field is blank");
	return false;
	}
/*else if(document.getElementById("rel").value=="rel"){
	alert("Choose Patient Religion");
	return false;
	}	
else if(document.getElementById("mar_st").value=="Marital_status"){
	alert("Marital status Field is empty");
	return false;
	}
else if(document.getElementById("caste_category").value=="caste_category") {
	alert("Choose Caste Category");
	return false;
	}	*/
else if(document.getElementById("phy").value=='phy'){
	alert("choose Physician name");
	return false;
	}	
else if(document.getElementById("state").value=="state"){
	alert("Choose state");
	return false;
	}		

/*else if ( (document.getElementById("persidtype").value!="notstated") && 
	      (document.getElementById("persidvalue").value=="") ) {
	alert("Enter Personal Identity Number");
	return false;
}
*/
return true;
}
function IsEmail(email) {
  var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if(!regex.test(email)) {
    return false;
  }else{
    return true;
  }
}


</SCRIPT>

</head>

<body>
<div class="container-fluid"><br>

<div class="row 1">
<form METHOD="Get" ACTION="../jspfiles/savemed_nocookies.jsp" name="med" onSubmit="return putentrydate('<%=dat%>');">
<div class="col-sm-12">
<div class="row 1-1 well"><center><h4 style="color:blue"><b>PATIENT'S INFORMATION</b></h4></center>
<div class="col-sm-6 ">

<div class="input-group">
<span class="input-group-btn">
<select class="input-group btn btn-default" id="pre" name="pre" data-toggle="tooltip" data-placement="top" title="Prefix">
<%=appellationList(request)%>
</select>		<!-- "input-group-sm" -->
<s style="color:red;">*</s></span>		<!-- "input-group-addon" -->
<input type = "text" class = "form-control" ID="pat_name" name="pat_name" placeholder = "First Name" maxlength="45" required/>
</div>		<!-- "input-group" -->

<input type = "text" class = "form-control" name="m_name" placeholder = "Middle Name"  maxlength="45" />
<input type = "text" class = "form-control" name="l_name" placeholder = "Surname"  maxlength="45" required/>


<!--<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>-->
<select class="form-control" id="rel" NAME="religion" data-toggle="tooltip" data-placement="top" title="Religion">
			<option value="0">Choose Religion</option>
			<%=religionList(request)%>
</select>		<!-- "form-control" -->
<!--</div>-->		<!-- "input-group" -->

<!--<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>-->
<!--<select class="form-control" id="mar_st" NAME="m_status" data-toggle="tooltip" data-placement="top" title="Marital status" >
		<option value="Marital_status">Marital status</option>
		<option value=sing>Single
		<option value=mard>Married
		<option value=1mrd>First Marraige
		<option value=2mcw>2nd Marraige Concurrent Wife
		<option value=2mnw>2nd Marraige Non-Concurrent Wife
		<option value=b2mc>Beyond 2nd Marraige Concurrent Wife
		<option value=b2mn>Beyond 2nd Marraige Non-Concurrent Wife
		<option value=sepd>Separated
		<option value=dvcd>Divorced
		<option value=widd>Widowed
		<option value=ntst>Not Stated
</select>-->		<!-- "form-control" -->	
<select class="form-control" id="mar_st" NAME="m_status" data-toggle="tooltip" data-placement="top" title="Marital status" >
<option value="0">Marital status</option>
	<option value="1">Nevermarried</option>
	<option value="2">Currentlymarried</option>
	<option value="3">Widow/Widower</option>
	<option value="4">Divorced</option>
	<option value="5">Separted</option>
</select>
<!--</div>-->		<!-- "input-group" -->

<!--<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>-->
<select class="form-control" id="caste_category" NAME="caste_category" data-toggle="tooltip" data-placement="top" title="Marital status" >
		<option value="caste_category">Caste Category</option>
		<option value=general>General
		<option value=obc>OBC (Creamy Layer)
		<option value=obncl>OBC (Non Creamy Layer)
		<option value=sc>Schedule Caste
		<option value=st>Shedule Tribe
		<option value=notst>Not Stated
</select>		<!-- "form-control" -->	
<!--</div>-->		<!-- "input-group" -->

<Select class="form-control" id="sex"  NAME="sex" data-toggle="tooltip" data-placement="top" title="SEX"  >
			<option Value="M">Male</Option>
			<option Value="F">Female</Option>
			<option Value="O">Other</Option>
			<option Value="N">Not Stated</Option>
</Select>		<!-- "form-control" -->

<SELECT class="form-control btn-info" id="phy" name='referring_doctor' data-toggle="tooltip" data-placement="top" title="Select Physician" style="display:none" >
<%
			
		try{
			String name= rcui.getName(doc_id);
			
			out.println ("<Option Value='"+doc_id+"'>"+name+"&nbsp;&nbsp;</OPTION>");
		}catch(Exception e){
		}
%>
</SELECT>

</div>		<!-- "col-sm-6" -->
<div class="col-sm-6">

<!--<div class="input-group">
<span class="input-group-addon hidden-sm hidden-xs"><span style="color:red"> </span>Hospital OPD Identity</span>
<span class="input-group-addon hidden-lg hidden-md">OPD ID</span>
<input class="form-control" id="opd-ref" NAME="opdno" type="text" maxlength="20" placeholder="Medical book number" />
</div>-->

<div id="dob-datepicker" class="input-append date input-group" >
<span class="input-group-addon" style="color:red">*</span>
	<input data-format="dd-MM-yyyy" type="text" name="dateofbirth" value="" placeholder="Date of birth" class="form-control dob" readonly="true" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:0px" ></span>
<div class="notknown-dob">DOB not known?</div>
</div>		<!-- "input-group" -->

<div class="input-group inline-flex hidden age-div">
<INPUT class="form-control" ID="ageyy" NAME="ageyy" placeholder="Year" maxlength="3" max=120 min=0 /> 
<INPUT class="form-control" ID="agemm" NAME="agemm" placeholder="Month" maxlength="2" max=12 min=0 /> 
<INPUT class="form-control" ID="agedd" NAME="agedd" placeholder="Day" maxlength="2" max=31 min=0 /> 
<span class="input-group-addon agegroup-name"> </span>
<INPUT type="hidden" id="age1" NAME="age" value="age" >
</div>

<!--
<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>
<SELECT name=type class="form-control" id="age" onchange="adjust()"  data-toggle="tooltip" data-placement="top" title="Age group">
		<option value='' selected> Age group </option>
		<option value=U> Unknown </option>
		<option value=A > Adult </option>
		<option value=E> Teen </option>
		<option value=C> Child </option>
		<option value=T> Toddler </option>
		<option value=I> Infant </option>
		<option value=N> Neonate </option>
</select>		
</div>-->		<!-- "input-group" -->






<!--
<SELECT class="form-control" id="disease" name="class" data-toggle="tooltip" data-placement="top" title="Disease type" >
		<%
			try{
			FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
			int i;
			String str="";
			do{
				i = fin.read();
				if((char) i != '\n')
					str = str + (char) i;
				else {
					str = str.replaceAll("\n","");
					str = str.replaceAll("\r","");
					out.println("<option value='" + str + "'>" + str + "</Option>");
					str="";
				}
			}while(i != -1);
			fin.close();
		}catch(Exception e){
			System.out.println(e.toString());
		}
		%>
</SELECT>-->
		<!-- "form-control" -->
<!--<select class="form-control" id="race" NAME="race" data-toggle="tooltip" data-placement="top" title="Race" >

			<option>American Indian/Eskimo/Aleut</option>
			<option>Asian or Pacific Islander</option>
			<option>Black</option>
			<option>White</option>
			<option>Other</option>
			<option>Unknown/Not Stated</option> 
</select>	-->	<!-- "form-control" -->

<br>
<div class="input-group" >
<span class="input-group-addon" style="color:red">*</span>
<span style="display:flex">
<input class="form-control" type="email" name="email" placeholder="Enter Email ID" id="emailid"  style="border-radius: 0; width:100%;" />
<input class="form-control" type="text" name="vem" placeholder="otp-em" id="vem"  size=8 maxlength=6 style="border-radius: 0; width:35%; background-color: #faa;color: #a90909;"/>
<input id="verifyemailstatus"  name="verifyemailstatus" type=hidden readonly value="N">
</span>
<span class="input-group-addon verifyEmail" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deleteEmail" style="cursor: pointer;">Remove</span>
</div>
<br>
<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>
<span style="display:flex">
<input class="form-control" type="text" id ="phone" name="phone" maxlength="10" placeholder="Phone Number"  style="border-radius: 0; width:100%;" >
<input class="form-control" type="text" name="vph" placeholder="otp-ph" id="vph" size=8 maxlength=6  style="border-radius: 0; width:35%;  background-color: #ffa;color: #a90909;" />
<input id="verifyphonestatus"  name="verifyphonestatus" type=hidden readonly  value="N">
</span>
<span class="input-group-addon verifyPh" style="cursor: pointer;">Verify</span>
<span class="input-group-addon deletePhone" style="cursor: pointer;">Remove</span>
</div>

<h5 style="color:blue"><strong>Personal Identity</strong></h5>
<div class="input-group">
<span class="input-group-addon">ID-Type</span>
<select class="form-control" id="persidtype" NAME="persidtype" data-toggle="tooltip" data-placement="top" title="Personal Identity Type" maxlength="12" >
			<option value=aadhar>Aadhar-Card</option>			 
			<option value=voter>Voter-Card</option>
			<option value=pan>PAN-Card</option>
			<option value=driving>Driving-License</option>
			<option value=notst>Unknown/Not Stated</option>			
</select>		<!-- "form-control" -->
</div></br>
<div class="input-group">
<span class="input-group-addon">Id No</span>
<input class="form-control" id="persidvalue" NAME="persidvalue" data-toggle="tooltip" data-placement="top" title="Personal Identity Details" maxlength="12" ><!-- "form-control" -->
<span class="input-group-addon"><input type="checkbox" name="persidchecked" class="id_chkd" value="0" /></span>
</div>
</div>		<!-- "col-sm-6" -->
</div>		<!-- "row 1-1" -->
</div>		<!-- "col-sm-12" -->
<div class="col-sm-12">
<div class="row 1-2 ">
<div class="col-sm-6 well"><center><h5 style="color:blue"><b>Patient's Details</b></h5></center>
<textarea class="form-control" name="addline1" maxlength="200" placeholder="Address of Patient"></textarea>
<input class="form-control" type="text" name="policestn" maxlength="100" placeholder="Police Station" />

<!--<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>-->
<!--</div>-->		<!-- "input-group" -->

<input class="form-control" type="text" name="city"  maxlength="100" placeholder="City">

<Select class="form-control" name="dist" id="dist" data-toggle="tooltip" data-placement="top" title="District">
						<option value="dis" selected>Select District</option>
</select>		<!-- "form-control" -->

<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>
<Select class="form-control" name="state" id="state" data-toggle="tooltip" data-placement="top" title="State">
						<option value="state" selected>Select State</option>
<%=stateList(request)%>
</select>		<!-- "form-control" -->
</div>		<!-- "input-group" -->

<select class="form-control" name="country" data-toggle="tooltip" data-placement="top" title="Select Country" >
					<option value=IN>India
</select>		<!-- "form-control" -->

<!--<div class="input-group">
<span class="input-group-addon" style="color:red">*</span>-->
<input class="form-control" type="text" ID="pin" name="pin" maxlength="6" placeholder="PinCode" />
<!--</div>-->		<!-- "input-group" -->

</div>		<!-- "col-sm-6 well" -->
<div class="col-sm-6 well"><center><h5 style="color:blue"><b>Contact Person Details</b></h5></center>
<input class="form-control" type="text" name="pat_person" maxlength="100" placeholder="Name of Contact Person">
<input class="form-control" type="text" name="pat_relation" maxlength="100" placeholder="Realtion with Patient">
<TEXTAREA class="form-control" NAME="pat_person_add" ROWS="4" COLS="50" wrap=virtual onkeypress='return txtlength(this,200)' onblur='chkpest(this,200)' placeholder="Address Of contact Person"></TEXTAREA>
<p style="color:red">*(star) mark is mandatory field.</p>

<INPUT TYPE="hidden" name='consent' value='u'> <!-- y for yes, u for null n for no -->
	<INPUT TYPE=hidden NAME=entrydate></INPUT>

<!-- 	<INPUT TYPE="hidden" name="referring_doctor" value=""> -->	
	<INPUT TYPE="hidden" name='serno' value="">
	
  <div class="captchaField">
    <span id="SuccessMessage" class="success">Thanks! , The Captcha Is Correct!</span>
    <input type="text" id="UserCaptchaCode" class="CaptchaTxtField" placeholder='Enter Captcha - Case Sensitive'>
    <span id="WrongCaptchaError" class="error"></span>
    <div class='CaptchaWrap'>
      <div id="CaptchaImageCode" class="CaptchaTxtField">
        <canvas id="CapCode" class="capcode" width="300" height="80"></canvas>
      </div> 
      <input type="button" class="ReloadBtn" onclick='CreateCaptcha();'>
    </div>
  </div>


<br><br><div class="input-group">
<span class="input-group-addon">
<input class="form-control btn-primary submitbtn" type="submit" value="Submit" ></span>
<span class="input-group-addon">
<input class="form-control btn-primary" type="reset" value="Reset" ></span>
</div>		<!-- "input-group" -->
</div>		<!-- "col-sm-6 well" -->
</div>		<!-- "row 1-2" -->
</div>		<!-- "col-sm-12" -->

</form>
</div>		<!-- "row 1" -->
</div>		<!-- "container" -->
</body>


</html>
