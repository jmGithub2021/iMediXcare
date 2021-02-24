<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,imedix.rcPatqueueInfo,imedix.rcUserInfo,imedix.myDate,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	rcCentreInfo centerinfo = new rcCentreInfo(request.getRealPath("/"));
	rcPatqueueInfo pqinfo = new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
	//String ccode=request.getParameter("referring_doctor");
	String referring_doctor = request.getParameter("referring_doctor");
	//ccode=ccode.substring(3,7);
	String ccode=centerinfo.getCenterCode(referring_doctor,"login");
	String usrccode =cookx.getCookieValue("center", request.getCookies());
	//String usrccode = "VBCR019";
	String userid =cookx.getCookieValue("userid", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());
	String usrname = cookx.getCookieValue("username", request.getCookies());

	out.println(usrccode);
	dataobj obj = new dataobj();
	try{

	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
			String key=e.nextElement().toString();
			String val=request.getParameter(key);
			if(key.equalsIgnoreCase("dateofbirth"))
				val = val.replaceAll("-","");
			obj.add(key,val);
			//out.println(key +" : "+val);
		}
	obj.add("userid",userid);
	obj.add("center",usrccode);
	obj.add("usertype",usr);

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
		if(usr.equalsIgnoreCase("pat")){
			id = rcdef.InsertMedWithoutDocAssign(usrccode,obj);
			String output="", retmsg="";
			String emailid = (String) session.getAttribute("verifemail");
			String phone = (String) session.getAttribute("verifphone");
			if (emailid.length()>0) {
				String subject = "Family Member Inclusion in iMediX";
				String mesg = "Dear "+usrname+",\n\n"+
							"One of your family members is now associated with your iMediX account.\n\n"+
							"Name: "+request.getParameter("pat_name")+"\n Relationship:"+request.getParameter("relationship")+"\n\n"+
							"*Note: If such activivity is not performed by you, please contact to iMediX administrator.";
				Email em = new Email(request.getRealPath("/"));
				//output = em.Send(emailid,subject,mesg);
			}
			if (phone.length()>0) {
				rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
				//String message = (String) rcsmsapi.makeMessage("M007", dataAry);
				String message="Update: Family Member Association in iMediX";
				SMS sms = new SMS(request.getRealPath("/"));
				//retmsg = sms.Send(phone, message);
			}			
		}
		else	
			id = rcdef.InsertMed(ccode,obj);


	String patdis=request.getParameter("class");
	String pname = request.getParameter("pat_name");

	if(id.equalsIgnoreCase("Error")){
			out.println( "<CENTER>ERROR <br> Try Again</CENTER>" );
	}else{
		cookx.addCookie("patid",id,response);
		cookx.addCookie("patname",pname,response);
		//response.sendRedirect(response.encodeRedirectURL("showpatdata.jsp?id="+id+"&usr="+usr+"&nam="+pname+"&patdis="+patdis));
		pqinfo.updateLpatqAssignDate(id,myDate.getCurrentDateMySql());
		String loginStatus = "";
		if(request.getParameter("pat-login") != null){
			dataobj loginObj = new dataobj();
			loginObj.add("uid",id);
			loginObj.add("pwd",id);
			loginObj.add("name",request.getParameter("pat_name"));
			loginObj.add("crtdate", myDate.getCurrentDateMySql());
			loginObj.add("center", usrccode);
			loginObj.add("userid", userid);
			loginObj.add("type","PAT");
			loginObj.add("active","Y");
			loginObj.add("available","Y");
			loginObj.add("referral","Y");
			loginObj.add("verified", "A");
			loginObj.add("verifemail", "N"); //Get the varified status from signup form
			loginObj.add("verifphone", "N"); //Get the varified status from signup form
			loginObj.add("consent","N");

			int ans = rcuinfo.InsertRegUsers(loginObj,null);
			loginStatus = "Patient login id is Patient ID and password is same as patient ID";
		}
		//out.println("<br>"+ patdis);
		out.println("<script>var chk=prompt('Successfully Registered !\n "+loginStatus+"',' Pat ID :"+id+"');</script>");
		String login;
		if(request.getParameter("pat-login") != null)
		{
			login="Y";
		}
		else
		{
			login="N";
		}
		//out.println("<script>window.location='displaymed.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+id+"&ty=med&sl=&dt = ';</script>");
		out.println("<script>window.location='displaymed.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+id+"&login="+login+"&ty=med&sl=&dt = ';</script>");

	}
	}
	}catch(Exception e){
		out.println( e.toString());
	}
	//response.sendRedirect("frames.html");


%>
