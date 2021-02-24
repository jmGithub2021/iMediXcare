<%@page contentType="text/html" import="imedix.rcAdminJobs,imedix.dataobj,imedix.cook,java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>
<%	
	String paramName="", paramValue="",pids="",regcode="";
	regcode=request.getParameter("regcode");

	cook cookx = new cook();
	String curpatccode= cookx.getCookieValue("currpatqcenter", request.getCookies ());

	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));

	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);


	if(regcode.equals(""))
	{
		out.println("<center><Font size=+2 color=red><b>Physician not selected, Please  Physician</b></Font></center><BR>");
		out.println("<center><A href=telebrowse.jsp?curCCode="+curpatccode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
		return;
		
	}

	Enumeration paramNames2 = request.getParameterNames();
	
	 if(paramNames2.hasMoreElements() == false)
	 {
		out.println("<center><Font size=+2 color=red><b>Patient Or Physician not selected, Please select Patient and Physician</b></Font></center><BR>");
		out.println("<center><A href=telebrowse.jsp?curCCode="+curpatccode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
		return;
	}
	else
	{
		while(paramNames2.hasMoreElements())
		{
			paramName  = (String)paramNames2.nextElement();
			paramValue = request.getParameter(paramName);
			//out.println(paramName+"="+paramValue + "<br>");
			//pids=pids+paramValue+"#";
			if(!paramName.equals("regcode")) pids=pids+paramValue+"#";
		}
	
		//out.println("pids"+"="+pids + "<br>");

		if(pids==""){
			out.println("<center><Font size=+2 color=red><b>Patient not selected, Please select Patient </b></Font></center><BR>");
			out.println("<center><A href=telebrowse.jsp?curCCode="+curpatccode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
			return;
		}else{
			int ans=rcajob.updateTelePhysician(pids,regcode,obj);
			if(ans==1){
			out.println("<center><Font size=+2 color=blue><b>Update Data Successfully</b></Font></center><BR>");
			out.println("<center><A href=telebrowse.jsp?curCCode="+curpatccode+"><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
			}else{
				out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
			}
		}
	}

%>