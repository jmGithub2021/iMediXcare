

\\Delete for open-source version


 
<!DOCTYPE html>
<html >
  <head>

<title>iMediX</title>
<link id="page_favicon" href="/favicon.ico" rel="icon" type="image/x-icon" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="login_css/style.css">  
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/captcha.css" />	
<script src="<%=request.getContextPath()%>/bootstrap/captcha.js"></script>  
<style>
input:invalid,
input:out-of-range {
    border-color:hsl(0, 50%, 50%);
    background:hsl(0, 50%, 90%);
}
</style>
</head>
<body  onLoad=document.getElementById("uid").focus() >

 
<br><br>
  <div class="im-login-form col-sm-6 col-sm-offset-3 well well-lg">
  <br>
  <a href="https://imedix.iitkgp.ac.in/iMediX/" target=_self>iMediX Home</a> | 
    <a href="javascript:window.history.go(-1)" target=_self>Go Back</a>
 <hr>
    <form METHOD="POST" ACTION="pat_forgotpswresp.jsp" name="frmLog" role = "form"  onSubmit="return CheckCaptcha()">
	<center><h2>iMediX</h2><p>Forgot Login?</p></center>
	Dear Patient, <br>
	Please provide your EmailID or UID, and click Submit button.
	     <input class="form-control inpt-bx"  type = "text" name="uid" id="uid" placeholder = "EmailID / UserID" class="required" required/>

	  <div class="row">
	     <div class="captchaField pull-left">
    <span id="SuccessMessage" class="success">Thanks! , The Captcha Is Correct!</span>
    <input type="text" id="UserCaptchaCode" class="CaptchaTxtField required" placeholder='Enter Captcha - Case Sensitive' required>
    <span id="WrongCaptchaError" class="error"></span>
    <div class='CaptchaWrap'>
      <div id="CaptchaImageCode" class="CaptchaTxtField">
        <canvas id="CapCode" class="capcode" width="300" height="80"></canvas>
      </div> 
      <input type="button" class="ReloadBtn" onclick='CreateCaptcha();'>
    </div>
  </div>
  </div>
  <div class="row">
      <input class="btn btn-primary subm-btn pull-left " type="submit" value="Submit" /> 
	   </div>
    </form>
  </div>
  <br>
</body>
</html>
