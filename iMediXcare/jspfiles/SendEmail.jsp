<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@page import="imedix.SMS,imedix.Email"%> 
<%
String email = (String) request.getParameter("email");
String messageid = (String) request.getParameter("messageid");
String emOtp  = (String)session.getAttribute("emOtp");
if(emOtp != null && !emOtp.trim().isEmpty()) {
	if (messageid.equalsIgnoreCase("OTP")) {
		String mesg = "Dear Patient,\n\nThe OTP to verify your emailid is " + emOtp +
		".\nPlease contact Admin for issues if any.";
		Email emailSent = new Email(request.getRealPath("/"));
		String fileGenErrors = emailSent.Send(email,"iMediX: Verify Email",mesg);
		out.println (fileGenErrors);
	}
} 
else {
	out.println("Error:Session");
}
%>