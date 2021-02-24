

\\Delete for open-source version


<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@page import="imedix.Email,imedix.projinfo,imedix.SMS,imedix.rcSmsApi"%> 

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


<script language="JavaScript">
if ( window.history.replaceState ) {
  window.history.replaceState( null, null, window.location.href );
}
</script>


</head>
<body>
<br><br>
  <div class="im-login-form col-sm-6 col-sm-offset-3 well well-lg">
  <br>
  <a href="https://imedix.iitkgp.ac.in/iMediX/" target=_self>iMediX Home</a> |  
   <a href="javascript:window.history.go(-1)" target=_self>Go Back</a>
 <hr>
<% 		projinfo pinfo=new projinfo(request.getRealPath("/"));
		String serverUrl = pinfo.gblhome;

		rcUserInfo ruser=new rcUserInfo(request.getRealPath("/"));	
		String emailid0=request.getParameter("uid").trim();
		out.println ( emailid0);
		Object res=ruser.getuserinfoByEmail(emailid0);
	
		Vector tmp = (Vector)res;
		if(tmp.size()<=0) {
			out.println("<h2>EmailID/UID Not Found !! You must request Admin to create a login for you. <br><br>Do you want to make request for New Login ?  Click <a href='jspfiles/patnewlogin.jsp' target=_self>here</a> to make request.</h2>");
			}
		else {
		dataobj temp = (dataobj) tmp.get(0);
		String emailid = (String) temp.getValue("emailid");
		String mobileno = (String) temp.getValue("phone");
		
		String uid = (String) temp.getValue("uid");
		String patname = (String) temp.getValue("name");
		String pwd = (String) temp.getValue("pwd");
		
		String verifemail = (String) temp.getValue("verifemail");
		String verifphone = (String) temp.getValue("verifphone");
		
		if (verifemail.equalsIgnoreCase("Y")) {
			String mesg = "Dear " +patname + ",\nPlease find the login details below. \n\niMediX URL : "+serverUrl+"\nUserid: "+uid+" ( or "+emailid+")\nPassword: "+pwd+"\n\nPlease contact Admin for issues if any.";
			Email emailSent = new Email(request.getRealPath("/"));
			String fileGenErrors = emailSent.Send(emailid,"iMediX Login Details",mesg);
			out.println("<br>Email Attempted : " + fileGenErrors);
		}	
		/* adding SMS here */
		if (verifphone.equalsIgnoreCase("Y")) {
			String dataAry[] = new String[2];
			dataAry[0] = emailid;
			dataAry[1] = pwd;
			rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
			String message = (String) rcsmsapi.makeMessage("M005", dataAry);
			SMS sms = new SMS(request.getRealPath("/"));
			String retmsg = sms.Send(mobileno, message);
			out.println("<br>SMS Attempted : " + retmsg);
		}
		out.println ("<br>Kindly check your email/SMS that you have registered with us. Else you must contact the System Admin.");
		}
	
%>
</div>

</body>
</html>