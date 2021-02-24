<%@page contentType="text/html" import="imedix.cook,imedix.dataobj,imedix.rcAdminJobs,java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%	
	String paramName="", paramValue="",pids="";
	Enumeration paramNames2 = request.getParameterNames();

	cook cookx = new cook();
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	String rcode=cookx.getCookieValue("rccode", request.getCookies ());
	
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);


	 if(paramNames2.hasMoreElements() == false)
	 {
		out.println("<center><Font size=+2 color=red><b>Patient not selected, Please select Patient To Delete</b></Font></center><BR>");
		out.println("<center><A href=browse.jsp><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
	}
	else
	{  
		while(paramNames2.hasMoreElements())
		{
		paramName  = (String)paramNames2.nextElement();
		paramValue = request.getParameter(paramName);
		//out.println(paramName+"="+paramValue);
		pids=pids+paramValue+"#";
		}
		int ans=rcajob.delPatient(pids,"Tele",obj);
		if(ans==1){
		//out.println("pids"+"="+pids + "<br>");
		out.println("<center><Font size=+2 color=blue><b>Selected Patient Data Deleted Successfully</b></Font></center><BR>");
		out.println("<center><A href=headermenu_sk.jsp?rccode="+rcode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
		}else{
			out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
		}
	}

%>
