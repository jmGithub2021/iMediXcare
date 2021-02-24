<%@page language="java" import= "imedix.rcUserInfo"%>
<div style="text-align:center">
<%
String verificationCode = "",emailid="";
	verificationCode = request.getParameter("id");
	emailid = request.getParameter("emailid");
	rcUserInfo genoperation = new rcUserInfo(request.getParameter("/"));
 	if(genoperation.verifyPatient(verificationCode,emailid))
		out.println("<div>Your email is successfully verified. The iMediX account will be activated shorlty. We will update you by Email/SMS.</div>");
	else
		out.println("Not verfied, contact to Administrator");
%>
<a style class="btn btn-info btn-home" href='/' >Home</a>
</div>