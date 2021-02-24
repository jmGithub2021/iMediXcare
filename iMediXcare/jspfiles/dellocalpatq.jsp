<%@page contentType="text/html" import="imedix.rcAdminJobs,imedix.dataobj,imedix.cook,java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%	
	String paramName="", paramValue="",pids="";
	Enumeration paramNames2 = request.getParameterNames();
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));

	cook cookx = new cook();
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
		int ans=rcajob.delPatient(pids,"Local",obj);
		if(ans==1){
			//out.println("pids"+"="+pids + "<br>");
			out.println("<center><Font size=+2 color=blue><b>Selected Patient Data Deleted Successfully</b></Font></center><BR>");
			out.println("<center><A href=browse.jsp><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
			out.println("<center><a href=headermenu_sk.jsp?templateid=1&menuid=head1><Font size=+1 color=blue>Home</Font></a></center>");
		}else out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
	}

%>
