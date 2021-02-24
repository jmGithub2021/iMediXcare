<%@page language="java" import="imedix.projinfo,imedix.rcUserInfo,imedix.dataobj,java.util.*,java.io.*, imedix.Email"%>
<%
	if(request.getMethod().equalsIgnoreCase("POST")){
		String name="", emailid="", verifiedEmail="";
		dataobj temp=null;
		projinfo prin = new projinfo(request.getRealPath("/"));
		Random random = new Random();
		String randomCode = String.format("%06d", random.nextInt(1000000));	
		String uid = request.getParameter("uid");
		String pass = randomCode;
		rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
		boolean reset = uinfo.resetPassword(uid,pass);
		Object res = uinfo.getuserinfo(uid);
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			temp = (dataobj) tmp.get(0);
			name = temp.getValue("name");
			emailid = temp.getValue("emailid");
			verifiedEmail = temp.getValue("verifemail");
		}

		if(reset && verifiedEmail.equalsIgnoreCase("Y")){
			String subject = "iMediX Registration Status";
			String mesg = "Dear "+name+",\n\n"+
						"Your iMediX account has been created. The login details are as follows\n\n"+
						"Website: "+prin.gblhome+"\n Login ID: "+uid+"\nPassword: "+randomCode;
			Email em = new Email(request.getRealPath("/"));
			String output = em.Send(emailid,subject,mesg);	
			out.println("Successfully Reset and email is sent to the user");		
		}
		else{
			out.println("Faild to reset");
		}
	}

%>
<html>
<body>
	<form method="post">
		<input type="text" name="uid" placeholder="Enter user ID" />
		<input type="submit" name="passSubmit" value="Reset Password" />
	</form>
</body>
</html>