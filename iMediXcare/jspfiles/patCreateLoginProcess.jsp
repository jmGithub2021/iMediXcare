<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*,org.json.simple.*,org.json.simple.parser.*"%>
<%@page import="imedix.Email,imedix.projinfo,imedix.SMS,imedix.rcSmsApi"%>

<%
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	String serverUrl = pinfo.gblhome;

	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());


	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	String pat_id = request.getParameter("pat_id");
	String email = request.getParameter("email");
	String phone = request.getParameter("mobile");

	String center_code = pat_id.substring(0, pat_id.length()-10);
	String pat_name = "";
	JSONObject jsonobj = new JSONObject();
	try
    {
        rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
		rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
        Object res=uinfo.getPatientData(pat_id);

		if(!(res instanceof String)){
			Vector tmp = (Vector)res;
			dataobj dobj = (dataobj)tmp.get(0);
			pat_name = dobj.getValue("pat_name") +" "+ dobj.getValue("l_name");

			dataobj newobj = new dataobj();
			newobj.add("uid", dobj.getValue("pat_id"));
			newobj.add("pwd", dobj.getValue("pat_id"));
			newobj.add("name", pat_name);

			newobj.add("type", "PAT");
			newobj.add("center", center_code);
			newobj.add("active", "Y");
			newobj.add("available", "Y");
			newobj.add("referral", "Y");
			if (email.length()>0) newobj.add("emailid", email);
			if (phone.length()>0) newobj.add("phone", phone);

			int res1 = uinfo.addPatientFromMed(newobj);
			if(res1==0)
				uinfo.convertTOSelf(pat_id);

			if(res1 == 0 ){
				pat_id = dobj.getValue("pat_id");

				Object new_res=uinfo.getuserinfo(pat_id);
				tmp = (Vector)new_res;
				/*
				**if(tmp.size()<=0) { //Most Likely this will not happen
				**	out.println("Login ID ("+pat_id+") Not Found !! Email/SMS Sending failed!!");
				**	out.flush(); // Send out whatever hasn't been sent out yet.
				**	out.close(); // Close the stream. Future calls will fail.
				**	return; // Return from the JSP servelet handler.
				**}
				*/
				dataobj temp = (dataobj) tmp.get(0);
				String emailid = (String) temp.getValue("emailid");
				String mobileno = (String) temp.getValue("phone");
				String verifemail = (String) temp.getValue("verifemail");
				String verifphone = (String) temp.getValue("verifphone");
				Email emailSent = new Email(request.getRealPath("/"));
				SMS sms = new SMS(request.getRealPath("/"));
				jsonobj.put("status", "success");
				if (verifemail.equalsIgnoreCase("Y")) {
					String mesg = "Dear " +pat_name + ",\nPlease find the login details below. \n\niMediX URL : "+serverUrl+"\nUserid: "+pat_id+"\nPassword: "+pat_id+"\n\nPlease contact Admin for issues if any.";

					String fileGenErrors = emailSent.Send(email,"iMediX Login Created",mesg);
				}
				if (verifphone.equalsIgnoreCase("Y")) {
					String dataAry[] = new String[4];
					dataAry[0] = pat_name;
					dataAry[1] = serverUrl;
					dataAry[2] = pat_id;
					dataAry[3] = pat_id;
					String message = (String) rcsmsapi.makeMessage("M006", dataAry);
					//String retmsg = sms.Send(mobileno, message);
				}
			}else{
				jsonobj.put("status1", "failure"+res1);
			}
		}else{
			jsonobj.put("status2", "failure");
		}

    }catch(Exception e)
    {
        //out.println("error.."+e.getMessage());
		StringWriter errors = new StringWriter();
		e.printStackTrace(new PrintWriter(errors));
		jsonobj.put("status3", "failure = " + errors.toString());
    }
	out.println(jsonobj);
%>
