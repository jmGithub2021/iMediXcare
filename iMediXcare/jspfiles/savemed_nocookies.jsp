<%@page language="java" import="imedix.rcDataEntryFrm,imedix.rcCentreInfo,imedix.dataobj,java.util.*,java.io.*"%>

<%@ page import="java.net.URL" %> 
<%@ page import="java.net.URLConnection,java.net.URLEncoder, imedix.projinfo" %> 
<%@ page import="javax.net.ssl.HttpsURLConnection" %> 
<%@ page import="java.io.*" %> 
<%@ page import="javax.net.ssl.*" %> 

<%@ page import="java.util.Random,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo,imedix.ImedixCrypto,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>

<%
	cook cookx = new cook();
	rcCentreInfo centerinfo = new rcCentreInfo(request.getRealPath("/"));
	//String ccode=request.getParameter("referring_doctor");
	String referring_doctor = request.getParameter("referring_doctor");
	//ccode=ccode.substring(3,7);
	String ccode="VBCR019";
	//String usrccode =cookx.getCookieValue("center", request.getCookies());
	String usrccode = "VBCR019";
	//String userid =cookx.getCookieValue("userid", request.getCookies ());
	//String usr = cookx.getCookieValue("usertype", request.getCookies());
	String usr = "PAT";

	projinfo prin = new projinfo(request.getRealPath("/"));
	dataobj obj = new dataobj();
	dataobj loginObj = new dataobj();
	String isEmailVerified = request.getParameter("verifyemailstatus"); 
	String isPhoneVerified = request.getParameter("verifyphonestatus");
	
	if(isEmailVerified.equalsIgnoreCase("Y") || isPhoneVerified.equalsIgnoreCase("Y")){
		try{

		rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
		rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
		for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
				String key=e.nextElement().toString();
				String val=request.getParameter(key);
				if(key.equalsIgnoreCase("dateofbirth"))
					val = val.replaceAll("-","");
				obj.add(key,val);
				//out.println(key +" : "+val);
			}
		//obj.add("userid",userid);
		//obj.add("center",usrccode);
		//obj.add("referring_doctor",);
		obj.add("usertype",usr);
		//if(request.getParameter("opdno")==null)
			obj.add("opdno","00000000");

		String id = "";
		String exist_id = rcdef.checkIntigrity(obj);
		if(exist_id.length()>=14){
			if(rcdef.isInQueue(exist_id)){
					out.println("<script>alert('It seems You have already registered');</script>)");
					out.println("<script>window.location='displaymed.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+exist_id+"&ty=med&sl=&dt = ';</script>");
				}
			else{
					out.println("<script>window.location='patSortinfo.jsp?id='"+exist_id+"&usr="+usr+"&nam=*&patdis=&currpatqtype=local'</script>");
					//out.println("Patient id : "+exist_id +". This patient is already registered. <a href='setvisitdate.jsp?id="+exist_id+"' >Old Patient Registration</a>");
					out.println("<script>window.location='setvisitdate.jsp?id="+exist_id+"';</script>");
					
				}
		}			
		else{		
			id = rcdef.InsertMedWithoutDocAssign(ccode,obj);
			
		
		String patdis=request.getParameter("class");
		String pname = request.getParameter("pat_name");
		
		if(id.equalsIgnoreCase("Error")){
				out.println( "<CENTER>ERROR <br> Try Again</CENTER>" );
		}else{
			//String emailid = request.getParameter("email").trim();
			//String phone = request.getParameter("phone").trim();
			String emailid="", emailid_verif="", phone="", phone_verif="";
			try {
				 emailid = (String) session.getAttribute("EmailID");
				 emailid_verif = (String) session.getAttribute("EmailVS");
				 //out.println( "Email: " + emailid + " " + emailid_verif);

				 if( (emailid_verif == null || emailid_verif.isEmpty()) || (emailid == null || emailid.isEmpty())) {
					emailid_verif="N";
					emailid="";
				 } 
				 phone = (String) session.getAttribute("PhoneID");
				 phone_verif =(String) session.getAttribute("PhoneVS");
				//out.println( "Phone: " + phone + " " + phone_verif);

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
		
			Random random = new Random();
			String randomCode = String.format("%06d", random.nextInt(1000000));
			if(emailid.length()>0){
				loginObj.add("uid",id);
				loginObj.add("pwd",randomCode);
				loginObj.add("emailid",emailid);
				loginObj.add("phone",phone);
				loginObj.add("name",request.getParameter("pat_name"));
				loginObj.add("crtdate", myDate.getCurrentDateMySql());
				loginObj.add("center", "VBCR019");
				loginObj.add("userid", id);
				loginObj.add("type","PAT");
				loginObj.add("active","Y");
				loginObj.add("available","Y");
				loginObj.add("referral","Y");
				loginObj.add("verified", "A");
				//loginObj.add("verifemail", request.getParameter("verifyemailstatus")); //Get the varified status from signup form
				//loginObj.add("verifphone", request.getParameter("verifyphonestatus")); //Get the varified status from signup form
				loginObj.add("verifemail", emailid_verif); //Get the varified status from signup form
				loginObj.add("verifphone", phone_verif); //Get the varified status from signup form
				loginObj.add("consent","N");

				int ans = rcuinfo.InsertRegUsers(loginObj,null);
				
				
				String verifemail = emailid_verif; // request.getParameter("verifyemailstatus");
				String verifphone = phone_verif;   // request.getParameter("verifyphonestatus");
				String output="", retmsg="";
				if (verifemail.equalsIgnoreCase("Y")) {
					String subject = "iMediX Registration Status";
					String mesg = "Dear "+request.getParameter("pat_name")+",\n\n"+
								"Your iMediX account has been created. The login details are as follows\n\n"+
								"Website: "+prin.gblhome+"\n Login ID: Email/Patient ID\nPatient ID: "+id+"\nPassword: "+randomCode;
					Email em = new Email(request.getRealPath("/"));
					output = em.Send(emailid,subject,mesg);
				}
				if (verifphone.equalsIgnoreCase("Y")) {
					String dataAry[] = new String[4];
					dataAry[0] = request.getParameter("pat_name");
					dataAry[1] = prin.gblhome;
					dataAry[2] = id;
					dataAry[3] = randomCode;
					rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
					String message = (String) rcsmsapi.makeMessage("M007", dataAry);
					SMS sms = new SMS(request.getRealPath("/"));
					retmsg = sms.Send(phone, message);
				}
				out.println (output +"\n"+ retmsg);
				session.setAttribute("psw",randomCode);
			}
			else{
				out.println( "<CENTER>ERROR <br> Can not register</CENTER>" );
			}
			cookx.addCookie("patid",id,response);
			cookx.addCookie("patname",pname,response);
			//response.sendRedirect(response.encodeRedirectURL("showpatdata.jsp?id="+id+"&usr="+usr+"&nam="+pname+"&patdis="+patdis));
	%>

	<%
			//out.println("<br>"+ patdis);
			//out.println("<script>var chk=prompt('Successfully Registered !',' Pat ID :"+id+" and Password is your medical book number');</script>");
			
			out.println("<script>window.location='patRegstatus.jsp?id="+id+"';</script>");
		}
		}
		}catch(Exception e){
			StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
			String exceptionAsString = sw.toString();
			
			out.println( e.toString() +  exceptionAsString);
		}
	}
	else{
		out.println("<script>alert('Your email or phone needs to verified, please try again.');</script>");
		out.println("<script>window.location='/';</script>");
	}
	//response.sendRedirect("frames.html");


%>
