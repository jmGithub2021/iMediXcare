<%@page contentType="text/html" import="imedix.rcPatqueueInfo,imedix.myDate,imedix.rcDataEntryFrm,org.json.simple.*,imedix.rcUserInfo,imedix.rcAdminJobs,imedix.dataobj,imedix.cook,imedix.Email,java.util.*,imedix.SMS,imedix.rcSmsApi" %>
<%-- <%@ include file="..//includes/chkcook.jsp" %> --%>
<%
	String paramName="", paramValue="",pids="";

	cook cookx = new cook();
	String curpatccode= cookx.getCookieValue("currpatqcenter", request.getCookies ());

	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));

	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());

	String relation = cookx.getCookieValue("relationship",request.getCookies());
	String primarypatid = cookx.getCookieValue("primarypatid",request.getCookies());

	//String ccode= cookx.getCookieValue("center", request.getCookies ());
//out.println(patname+" RR"+gender );
	String ccode= request.getParameter("cen");
	String disp =  request.getParameter("disp");
	String pid = request.getParameter("ch1");
	String docreg = request.getParameter("regcode");

	Object res;
	if(relation.equalsIgnoreCase("self") || relation.equals("") || relation==null)
		res = rcui.getuserinfo(pid);
	else
		res = rcui.getuserinfo(primarypatid);

	Vector tmp = (Vector)res;
	dataobj temp = (dataobj) tmp.get(0);
	String emailid = (String) temp.getValue("emailid");
	String patname = (String) temp.getValue("name");

	String mobileno = (String) temp.getValue("phone");
	String verifemail = (String) temp.getValue("verifemail");
	String verifphone = (String) temp.getValue("verifphone");


	JSONObject result = new JSONObject();
	String pq = rcpqi.getTotalLPatAdmin(userid);
	if(pq.equals("0")){


		try{
			String phy="",phyName="",phyUID="",phyEmail="", phyPhone="", phyVerifEmail="", phyVerifPhone="";
			out.println("CALLING ");
			//Object res1 = rcui.docOfMinPat(ccode, disp);
			Object res1 = rcui.getuserinfoByrgNo(docreg);
			Vector vtemp = (Vector)res1;
			out.println(vtemp.size());
			if(vtemp.size()>0){
				dataobj ddobj = (dataobj)vtemp.get(0);
				phy = String.valueOf(ddobj.getValue("rg_no"));
				phyEmail = String.valueOf(ddobj.getValue("emailid"));
				phyName = String.valueOf(ddobj.getValue("name"));
				phyUID = String.valueOf(ddobj.getValue("uid"));
				phyPhone = String.valueOf(ddobj.getValue("phone"));
				phyVerifEmail = String.valueOf(ddobj.getValue("verifemail"));
				phyVerifPhone = String.valueOf(ddobj.getValue("verifphone"));
				//out.println(phy+"--"+phyEmail+"--"+phyName+"--"+phyUID+"--"+phyPhone+"--"+phyVerifEmail+"--"+phyVerifPhone);
			}
			if(phy.equals("")){
				result.put("message", "No doctor found");
			}else{
				dataobj obj = new dataobj();
				obj.add("pat_id",pid);
				obj.add("assigndoc",phy);
				obj.add("visitdate",myDate.getCurrentDate("ymd",true));
				obj.add("userid",userid);
				obj.add("opdno","");
				obj.add("appointment","");

				//int ans = 0;
				int ans = rcdef.setVisitDate(obj);
				//int ans=rcajob.updatePhysician(pid,phy,obj);
				if(ans==1){
					result.put("message", "A doctor has been assigned to you");
					Email email = new Email(request.getRealPath("/"));
					SMS sms = new SMS(request.getRealPath("/"));

					if (phyVerifEmail.equalsIgnoreCase("Y")) {
						String subject="New Patient Assignment";
						String messages = "Dear Dr."+phyName.replaceAll("(?i)Dr.","")+",\n\n"+
									"A new patient is assigned to you for consultation\n"+
									"Patient Details:\nPatient ID: "+pid+", Name: "+patname;
						/*"Dear Dr.[0], A new patient (ID: [1], Name:[2]) is assigned to you for consultation";*/
						email.Send(phyEmail,subject,messages);
					}
					if (phyVerifPhone.equalsIgnoreCase("Y")) {
						String dataAry[] = new String[3];
						dataAry[0] = phyName.replaceAll("(?i)Dr.","");
						dataAry[1] = pid;
						dataAry[2] = patname;
						String message = (String) rcsmsapi.makeMessage("M009", dataAry);
						String retmsg = sms.Send(phyPhone, message);
					}
					/////////////////////////////////////////////////
					if (verifemail.equalsIgnoreCase("Y")) {
						String patMessage="Dear "+patname+"\n\n"+
						"You are assigned to Dr."+phyName.replaceAll("(?i)Dr.","")+". You may upload your medical records.";
						//"Dear [0], You are assigned to Dr.[1] You may upload your medical records.";
						email.Send(emailid,"Doctor Assignment",patMessage);
					}
					if (verifphone.equalsIgnoreCase("Y")) {
						String dataAry[] = new String[2];
						dataAry[0] = patname;
						dataAry[1] = phyName.replaceAll("(?i)Dr.","");
						String pmessage = (String) rcsmsapi.makeMessage("M010", dataAry);
						String pretmsg = sms.Send(mobileno, pmessage);
					}
					//out.println("<center><Font size=+2 color=blue><b>Update Data Successfully</b></Font></center><BR>");
					//out.println("<center><A href=browse.jsp?curCCode="+curpatccode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
				}else{
					//out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
					result.put("message", "Could not update data");
				}
			}

		}catch(Exception e){
			result.put("message", "Could not send request to the doctor");
		}
	}else{
		result.put("message", "You are already in patient queue");
	}


	out.println(result);
%>
