<%@page language="java" import= "imedix.rcDataEntryFrm,imedix.rcCentreInfo,imedix.dataobj,imedix.rcPatqueueInfo"%>

<%@ page import="java.net.URL" %> 
<%@ page import="java.net.URLConnection,java.net.URLEncoder" %> 
<%@ page import="javax.net.ssl.HttpsURLConnection" %> 
<%@ page import="java.io.*" %> 
<%@ page import="javax.net.ssl.*" %> 

<%@ page import="java.util.Random,imedix.Email,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo, imedix.SMS,imedix.rcSmsApi"%>

<%@ include file="..//includes/chkcook.jsp" %>

<%
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	rcPatqueueInfo pqinfo = new rcPatqueueInfo(request.getRealPath("/"));
	cook cookx = new cook();
	String username = cookx.getCookieValue("username", request.getCookies());
	String Hr = request.getParameter("Hr");
	String Mn = request.getParameter("Mn");
	String Dt = request.getParameter("Dt");
	String Others = request.getParameter("Others");
	String uid = request.getParameter("uid");
	String uname = request.getParameter("uname");
	String datetime = Dt+" "+Hr+":"+Mn+":00";

if(pqinfo.updateLpatqAssignDate(uid,datetime)){
	Object res=uinfo.getuserinfo(uid);
	Vector tmp = (Vector)res;
	if(tmp.size()<=0) {
		out.println("Login ID ("+uid+") Not Found !!");
	    out.flush(); // Send out whatever hasn't been sent out yet.
		out.close(); // Close the stream. Future calls will fail.
		return; // Return from the JSP servelet handler.
	}
		
	dataobj temp = (dataobj) tmp.get(0);
	String emailid = (String) temp.getValue("emailid");
	String mobileno = (String) temp.getValue("phone");
	
	String verifemail = (String) temp.getValue("verifemail");
	String verifphone = (String) temp.getValue("verifphone");
	/*
	if (emailid.length()<=0) {
		out.println("Email-ID Not Found !!");
	    out.flush(); // Send out whatever hasn't been sent out yet.
		out.close(); // Close the stream. Future calls will fail.
		return; // Return from the JSP servelet handler.
	}
	*/
	//String emailid = "ddprasad@gmail.com"; //request.getParameter("Others");

	if (verifemail.equalsIgnoreCase("Y")) {
		String mesg2 = "Online consultation with doctor ("+username+") has been fixed on "+ Dt +" at " + Hr + " Hrs "+ Mn + " Mins (24 hrs format).\nPlease be online atleast 15 Mins before the start of the meeting. An invitation link will be sent to you.\n\nComments: " + Others;
		//String url = "https://imedix.wbhealth.gov.in/iMediX/servlet/SendEmail";
		String subject = "iMediX: Doctor Communicates ";
		String mesg = "Dear "+uname +" ("+uid+") ,\n\nPlease read the following communication from iMediX Doctor ("+username+")\n\n"+ mesg2;
		Email email = new Email(request.getRealPath("/"));
		String resp = email.Send(emailid,subject,mesg);
		out.println(resp);
	}
	if (verifphone.equalsIgnoreCase("Y")) {
			String dataAry[] = new String[4];
			dataAry[0] = uid;
			dataAry[1] = Dt;
			dataAry[2] = Hr + "Hrs " + Mn + "Mins (24 Hrs format)";
			dataAry[3] = username;		
			rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
			String message = (String) rcsmsapi.makeMessage("M002", dataAry);
			SMS sms = new SMS(request.getRealPath("/"));
			String retmsg = sms.Send(mobileno, message);
			//out.println("<br>SMS Attempted : " + retmsg);
	}
	
	
}
%>
