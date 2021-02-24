<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.dataobj,imedix.projinfo,imedix.cook,java.util.*"%>
<%@page language="java"  import= "java.security.MessageDigest,javax.xml.bind.DatatypeConverter"%>
<%@ page import="java.util.Random,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo,imedix.ImedixCrypto,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>
<%@ include file="..//includes/chkcook.jsp" %>
<html>
	<head>
		<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<script src="../bootstrap/jquery-2.2.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<%
	cook cookx = new cook();
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());

	if(ccode==null) return;
	if(ccode.equals("")) return;

	String isEmailVerified = request.getParameter("verifyemailstatus"); 
	String isPhoneVerified = request.getParameter("verifyphonestatus");
	String name="";
	//out.println( isEmailVerified + "|" + isPhoneVerified);
	if(isEmailVerified.equalsIgnoreCase("Y") || isPhoneVerified.equalsIgnoreCase("Y")) {
		dataobj obj = new dataobj();
		obj.add("userid",userid);
		obj.add("usertype",utype);

		try{
		rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
		
		for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
				String key=e.nextElement().toString();
				String val=request.getParameter(key);
				obj.add(key,val);
			}
		int ans = rcuinfo.updateUserInfo(obj);
		if(ans==1){
			 Object res =uinfo.getuserinfo(userid);
		 	 Vector vtemp = (Vector)res;
		 	 String emailid="",phone="",verifemail="",verifphone="";
		 	 if(vtemp.size()>0){
			 		for(int i=0;i<vtemp.size();i++)
			 		{
			 			dataobj ddobj = (dataobj)vtemp.get(i);
			 			name = ddobj.getValue("name");
						emailid = ddobj.getValue("emailid");
						phone = ddobj.getValue("phone");
						verifemail = ddobj.getValue("verifemail");
						verifphone = ddobj.getValue("verifphone");
			 		}
		 	 }
			 if(verifemail.equalsIgnoreCase("Y"))
			 {
				 String output="";
				 String subject = "Account Details Updated";
				 String mesg = "Dear "+name+",\n\n"+"Your Account Details has been updated. Please contact Admin if you have not done it.";
				 Email em = new Email(request.getRealPath("/"));
				 output = em.Send(emailid,subject,mesg);

			 }
			 if(verifphone.equalsIgnoreCase("Y"))
			 {
				 String retmsg="";
				 String dataAry[] = new String[1];
		 		dataAry[0] = name;
		 		rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
		 		String message = (String) rcsmsapi.makeMessage("M014", dataAry);
		 		SMS sms = new SMS(request.getRealPath("/"));
		 		retmsg = sms.Send(phone, message);
			 }


				//response.sendRedirect("showusers.jsp");
				out.println("<BR><BR><CENTER><h3>Profile Edited Sucessfully</h3> Please logout and login to make the changes effect into the system.</CENTER>");

		 }else{
			if(ans==2) out.println("Existing Password does not match");
			else out.println("Error");
		 }
		//out.println("<br>"+ ans);
		}catch(Exception e){
			out.println( e.toString());
		}
	}
	else{
		out.println("<script>alert('Your email or phone needs to verified, please try again.');</script>");
	}
%> 
</body>
</html>