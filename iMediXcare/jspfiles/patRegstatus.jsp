<%@page language="java" import= "imedix.rcDataEntryFrm,imedix.rcCentreInfo,imedix.dataobj,java.util.*,java.io.*"%>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection,java.net.URLEncoder, imedix.projinfo" %>
<%@ page import="javax.net.ssl.HttpsURLConnection,java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.net.ssl.*" %>

<%@ page import="java.util.Random,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo,imedix.ImedixCrypto,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/jquery-ui.js"></script>
<%
projinfo prin = new projinfo(request.getRealPath("/"));
cook cookx = new cook();
String id=cookx.getCookieValue("patid", request.getCookies());
if("POST".equalsIgnoreCase(request.getMethod()))
{
  //cook cookx = new cook();
  //String id=cookx.getCookieValue("patid", request.getCookies());
  String psw= (String) request.getSession(true).getAttribute("psw");
  String pat_name= cookx.getCookieValue("patname", request.getCookies());

  String emailid="", emailid_verif="", phone="", phone_verif="";
  try {
     emailid = (String) request.getSession(true).getAttribute("EmailID");
     emailid_verif = (String) request.getSession(true).getAttribute("EmailVS");
     if( (emailid_verif == null || emailid_verif.isEmpty()) || (emailid == null || emailid.isEmpty())) {
      emailid_verif="N";
      emailid="";
     }
     phone = (String) request.getSession(true).getAttribute("PhoneID");
     phone_verif =(String) request.getSession(true).getAttribute("PhoneVS");
     if( (phone_verif == null || phone_verif.isEmpty()) || (phone == null || phone.isEmpty())) {
       phone_verif="N";
       phone="";
     }
     //out.println( "Email: " + emailid + " " + emailid_verif);
     //out.println( "Phone: " + phone + " " + phone_verif);
     //return;
  } catch (Exception e) {
    out.println( e.toString() );
  }

  String verifemail = emailid_verif; // request.getParameter("verifyemailstatus");
  String verifphone = phone_verif;   // request.getParameter("verifyphonestatus");
  String output="", retmsg="";
  if (verifemail.equalsIgnoreCase("Y")) {
    String subject = "iMediX Registration Status";
    String mesg = "Dear "+pat_name+",\n\n"+
          "Your iMediX account has been created. The login details are as follows\n\n"+
          "Website: "+prin.gblhome+"\n Login ID: Email/Patient ID\nPatient ID: "+id+"\nPassword: "+psw;
    Email em = new Email(request.getRealPath("/"));
    output = em.Send(emailid,subject,mesg);
  }
  if (verifphone.equalsIgnoreCase("Y")) {
    String dataAry[] = new String[4];
    dataAry[0] = pat_name;
    dataAry[1] = prin.gblhome;
    dataAry[2] = id;
    dataAry[3] = psw;
    rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
    String message = (String) rcsmsapi.makeMessage("M007", dataAry);
    SMS sms = new SMS(request.getRealPath("/"));
    retmsg = sms.Send(phone, message);
  }

}





%>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<style>
.acount-status-panel {
    margin: 15px 0;
}
.lab3{color:#af1010;}


</style>
<script>
function reSend()
{

  $.post( "patRegstatus.jsp", function( data ) {
    alert("Login Details sent Successfully");
  });
/*
  $.ajax({
    type: 'POST',
    success: function(data) {
        //location.reload(true);
        }
  });
*/

}
function printPage(){
	var getDiv = document.getElementById("pat-reg-print");
	var newWindow = window.open('','','height=4960px,width=7016px');
	newWindow.document.write('<html><head><title>Generated from iMediX</title>');
	newWindow.document.write("<link rel=\"stylesheet\" href=\"<%=request.getContextPath()%>/bootstrap/css/patientRegSts.css\" type=\"text/css\" media=\"print\"/>");
	newWindow.document.write("</head><body onload='window.print()'>");
	newWindow.document.write(getDiv.innerHTML);
	newWindow.document.write('</body></html>');
	newWindow.document.close();
	return false;
}
</script>

<div class="container-fluid text-center acount-status-panel" id="pat-reg-print">
    <div class="panel panel-info">
      <div class="panel-heading"><b>Account Status</b> <a  class= 'pull-right btn btn-default print-a' href="javascript:printPage()"><span class='glyphicon glyphicon-print'> Print</span></a></div>
      <div class="panel-body">
		<ul class="list-group">
		  <li class="list-group-item lab1">User Name: <span><b><%=id%> </b>(Please note it is your login id.)</span></li>
		  <li class="list-group-item lab2"><b>Password is sent to your email ID / mobile no. </b> (We suggest you to change the password after login.)</li>
		</ul>
		<a class="btn btn-info btn-home" href='/' >Home</a>
    <a class="btn btn-primary" onclick="reSend()" >Resend Login Details</a>
	  </div>
    </div>
</div>
