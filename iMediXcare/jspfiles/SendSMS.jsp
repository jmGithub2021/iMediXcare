<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*,java.net.*"%>
<%@page import="imedix.SMS,imedix.rcSmsApi,javax.net.ssl.*"%>

<%
String mobileno = (String) request.getParameter("mobileno");
String messageid = (String) request.getParameter("messageid");
String dataAry[] = new String[1];
String phOtp  = (String)session.getAttribute("phOtp");
if(phOtp != null && !phOtp.trim().isEmpty()) {
	dataAry[0] = (String)session.getAttribute("phOtp");
	rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
	String message = rcsmsapi.makeMessage(messageid, dataAry);
	SMS sms = new SMS(request.getRealPath("/"));
	String retmsg = sms.Send(mobileno, message);
	out.println(retmsg);
}
else {
	out.println("Error:Session");
}
%>
