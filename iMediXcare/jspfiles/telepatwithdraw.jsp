<%@page contentType="text/html" import="imedix.cook,imedix.dataobj,imedix.rcAdminJobs,imedix.rcDataEntryFrm, java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%	

	String result = "";
	String paramName="", paramValue="",pids="";
	Enumeration paramNames2 = request.getParameterNames();
	cook cookx = new cook();
	rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));

	String rcode=cookx.getCookieValue("rccode", request.getCookies ());
	
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);
	int ii=0;

	 if(paramNames2.hasMoreElements() == false)
	 {
		out.println("<center><Font size=+2 color=red><b>Patient not selected, Please select Patient To withdraw/remove from list</b></Font></center><BR>");
		out.println("<center><A href=telepatrefstatus.jsp><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
	}
	else
	{  
		while(paramNames2.hasMoreElements())
		{
			ii=ii+1;
		paramName  = (String)paramNames2.nextElement();
		paramValue = request.getParameter(paramName);
		//out.println(paramName+"="+paramValue);
		//pids=pids+paramValue+"#";

		//out.println(paramName);
		//out.println(paramValue);

		String[] parts = paramValue.split("-", 3);
		
		String pat_id = parts[0];
		String reff_doc_id = parts[1];
		String atten_doc_id = parts[2];

		//out.println("\n"+pat_id);  // prints pat_id
		//out.println("\n"+reff_doc_id);  // prints reff_doc_id
		//out.println("\n"+atten_doc_id);
		/*
		String pat_id = obj.getValue("pat_id");
		String reff_doc_id = obj.getValue("reff_doc_id");
		String atten_doc_id = obj.getValue("atten_doc_id");
		*/
		obj.add("pat_id",pat_id);
		obj.add("reff_doc_id",reff_doc_id);
		obj.add("atten_doc_id",atten_doc_id);

		//String sql = "delete from tpatwaitq where pat_id="+"'"+pat_id+"'"+" and referred_doc='"+reff_doc_id+"'"+" and attending_doc='"+atten_doc_id+"'"; //testing
		//out.println(ii+":: "+sql);

		//result = dbc.ExecuteUpdateQuery(sql); // here focus!
		result = rcdef.delFromTpatWaitQ(obj);
		//out.println("result"+result);
		}

		if( (result.toLowerCase()).matches("(?i).*error.*") )
		{
			out.println("<center><Font size=+2 color=red><b>Error to Update Data </b></Font></center><BR>");
			out.println("<center><A href=telepatrefstatus.jsp><Font size=+1 color=blue>Browse Patient teleconsultation status Queue</Font></A></center>");
		}
		else
		{
			out.println("<center><Font size=+2 color=blue><b>Selected Patient Data withdrawn/removed Successfully</b></Font></center><BR>");
			out.println("<center><A href=telepatrefstatus.jsp><Font size=+1 color=blue>Browse Patient teleconsultation status Queue</Font></A></center>");

		}
		//int ans=rcajob.decideTelePatWait(pids,obj);
		/*if(result==1){
		//out.println("pids"+"="+pids + "<br>");
		out.println("<center><Font size=+2 color=blue><b>Selected Patient Data Deleted Successfully</b></Font></center><BR>");
		out.println("<center><A href=telewaitbrowse.jsp?rccode="+rcode+"><Font size=+1 color=blue>Browser Patient wait Queue</Font></A></center>");
		}else{
			out.println("<center><Font size=+2 color=blue><b>Error to Update Data </b></Font></center><BR>");
		}*/
	}

%>
