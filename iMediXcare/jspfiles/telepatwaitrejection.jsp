<%@page contentType="text/html" import="imedix.cook,imedix.dataobj,imedix.rcAdminJobs,java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%	
	String paramName="", paramValue="",pids="";
	Enumeration paramNames2 = request.getParameterNames();

	cook cookx = new cook();
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	String rcode=cookx.getCookieValue("rccode", request.getCookies ());
	String flag = request.getParameter("action");
	
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);

String rejectionReason = request.getParameter("reason");
if(rejectionReason != null)
	obj.add("rejectionReason",rejectionReason);

	 if(paramNames2.hasMoreElements() == false)
	 {
		 pids=pids+""+"#";
		 int ans=rcajob.rejectTelePatWait(pids,obj);
		
		//out.println("pids"+"="+pids + "<br>");
		out.println("<script>alert('Decison recorded Successfully');window.location.href='http://"+request.getServerName() + ":" + request.getServerPort()+"';</script>");
		//out.println("<center><Font size=+2 color=blue><b>Decison recorded Successfully</b></Font></center><BR>");
		//out.println("<center><A href=telewaitbrowse.jsp?rccode="+rcode+"><Font size=+1 color=blue>Browser Patient wait Queue</Font></A></center>");
		
		//out.println("<center><Font size=+2 color=red><b>Patient not selected, Please select Patient To Delete</b></Font></center><BR>");
		//out.println("<center><A href=telewaitbrowse.jsp><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
	}
	else
	{  
		while(paramNames2.hasMoreElements())
		{
		paramName  = (String)paramNames2.nextElement();
		paramValue = request.getParameter(paramName);
		//out.println(paramName+"="+paramValue);
		if(!paramName.equalsIgnoreCase("reason"))
			pids=pids+paramValue+"#";
		}
		int ans=rcajob.rejectTelePatWait(pids,obj);
		if(ans==1){
		//out.println("pids"+"="+pids + "<br>");
		out.println("<script>alert('Decison recorded Successfully');window.location.href='/iMediXcare/';</script>");
		//out.println("<center><Font size=+2 color=blue><b>Decison recorded Successfully</b></Font></center><BR>");
		//out.println("<center><A href=telewaitbrowse.jsp?rccode="+rcode+"><Font size=+1 color=blue>Browser Patient wait Queue</Font></A></center>");
		}else{
			out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
		}
	}	

%>
