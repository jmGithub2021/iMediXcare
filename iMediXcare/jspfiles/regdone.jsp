<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.projinfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@page language="java"%>
<%@page language="java"  import= "java.security.MessageDigest"%>
<%@ page import="java.util.Random,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo,imedix.ImedixCrypto,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>
<%
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	String type="",rg_no="",name="",emailid="",phone="";
	String str=request.getParameter("id");
	String uid=str;
	//String pwd=session.getAttribute("pwd").toString();
	Object res =uinfo.getuserinfo(uid);
	Vector vtemp = (Vector)res;
	if(vtemp.size()>0){
		for(int i=0;i<vtemp.size();i++)
		{
			dataobj ddobj = (dataobj)vtemp.get(i);
			rg_no = ddobj.getValue("rg_no");
			type = ddobj.getValue("type");
			name = ddobj.getValue("name");
			emailid = ddobj.getValue("emailid");
			phone = ddobj.getValue("phone");
		}
		}
		//out.println(rg_no+"-"+type+"-"+name+"-"+emailid+"-"+phone);
	String output="", retmsg="";
	/*if (!emailid.equalsIgnoreCase("")) {
		String subject = "iMediX Registration Status";
		String mesg = "Dear "+name+",\n\n"+
					"Your iMediX account has been created. The login details are as follows\n\n"+
					"Website: "+pinfo.gblhome+"\n Login ID: Email/Patient ID\nPatient ID: "+uid+"\nPassword: "+pwd;
		Email em = new Email(request.getRealPath("/"));
		output = em.Send(emailid,subject,mesg);
	}
	if (!phone.equalsIgnoreCase("")) {
		String dataAry[] = new String[4];
		dataAry[0] = name;
		dataAry[1] = pinfo.gblhome;
		dataAry[2] = uid;
		dataAry[3] = pwd;
		rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
		String message = (String) rcsmsapi.makeMessage("M013", dataAry);
		SMS sms = new SMS(request.getRealPath("/"));
		retmsg = sms.Send(phone, message);
	}*/
	

%>
<HTML>
	<HEAD>

		<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
			<script src="../bootstrap/jquery-2.2.1.min.js"></script>
			<script src="../bootstrap/js/bootstrap.min.js"></script>
		</head>
<BODY bgcolor="#FFDECE">
<BR><BR><BR><BR><BR><BR><BR>
	<!--<CENTER><FONT SIZE="+2" COLOR="#FF6699"><B>Congratulations, the ID <%=str%> is available! User will get activation letter via e-mail and sms. </B>-->
	<CENTER><FONT SIZE="+2" COLOR="#FF6699"><B>Congratulations, the ID <%=str%> is created successfully ! </B>
		</FONT><BR><BR>
<!--<FONT SIZE="+1" ><A HREF="../index.jsp"><U>Go To Home Page</U></A></FONT> -->
</CENTER>
</BODY>
</HTML>
