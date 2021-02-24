<%@page language="java" import= "java.util.*,java.io.*"%>
<%
	String fld = request.getParameter("fld");
	String fldstat = request.getParameter("fldstat");
	String fldtype = request.getParameter("fldtype");
	if (fldtype.equalsIgnoreCase("E")) {
		session.setAttribute("EmailID",fld);
		session.setAttribute("EmailVS",fldstat);
	}
	else {
		session.setAttribute("PhoneID",fld);
		session.setAttribute("PhoneVS",fldstat);
	}
	/*  String emailid="", emailid_verif="", phone="", phone_verif="";
		emailid = (String) session.getAttribute("EmailID");
		emailid_verif = (String) session.getAttribute("EmailVS");
		phone = (String) session.getAttribute("PhoneID");
		phone_verif =(String) session.getAttribute("PhoneVS");
		out.println("email,phone saved to session!!");
	*/
%>
