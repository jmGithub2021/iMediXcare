<%@page language="java" import= "imedix.rcDataEntryFrm,imedix.rcCentreInfo,imedix.dataobj,java.util.*,java.io.*"%>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection,java.net.URLEncoder, imedix.projinfo" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.net.ssl.*" %>

<%@ page import="java.util.Random,imedix.cook, java.util.*,imedix.myDate,imedix.rcUserInfo,imedix.ImedixCrypto,imedix.Email,imedix.SMS,imedix.rcSmsApi"%>

<%
	cook cookx = new cook();
	rcCentreInfo centerinfo = new rcCentreInfo(request.getRealPath("/"));

	projinfo prin = new projinfo(request.getRealPath("/"));

		rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
		rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
			String emailid = request.getParameter("email").trim();
			String phone = request.getParameter("phone").trim();
			String id=  request.getParameter("id").trim();
			String pat_name= request.getParameter("pat_name").trim();

				 //out.println( "Email: " + emailid + " " + emailid_verif);
				 //out.println( "Phone: " + phone + " " + phone_verif);
				 //return;

				String output="", retmsg="";
				if (!emailid.equalsIgnoreCase("")) {
					String subject = "iMediX Registration Status";
					String mesg = "Dear "+pat_name+",\n\n"+
								"Your iMediX account has been created. The login details are as follows\n\n"+
								"Website: "+prin.gblhome+"\n Login ID: Email/Patient ID\nPatient ID: "+id+"\nPassword: "+id;
					Email em = new Email(request.getRealPath("/"));
					output = em.Send(emailid,subject,mesg);
					if(output.equalsIgnoreCase("Sent message Successfully...."))
					{
						output="Email Sent Successfully";
					}
				}
				if (!phone.equalsIgnoreCase("")) {
					String dataAry[] = new String[4];
					dataAry[0] = pat_name;
					dataAry[1] = prin.gblhome;
					dataAry[2] = id;
					dataAry[3] = id;
					rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
					String message = (String) rcsmsapi.makeMessage("M007", dataAry);
					SMS sms = new SMS(request.getRealPath("/"));
					retmsg = sms.Send(phone, message);
					//if(retmsg.equalsIgnoreCase(phone))
					if(retmsg.contains(phone))
					{
						retmsg="Sms Sent Successfully";
					}
				}
				out.println ("<p>"+output +"\n"+ retmsg+"</p>");

	%>
