<%@page contentType="text/html"%>
<%@page language="java"  import= "imedix.rcAdminJobs,imedix.dataobj,imedix.cook,java.util.*"%>

<%	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies ());

	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);

	String ids="";
	try{
	rcAdminJobs rcdef = new rcAdminJobs(request.getRealPath("/"));
	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
			String key=e.nextElement().toString();
			if ( key.equalsIgnoreCase("allupdate") || key.equalsIgnoreCase("all")) continue;
			else{
				String val=request.getParameter(key);
				ids=ids+val+"#";
			}
		}

	//out.println( "br"+ids+"<br>");

	if(ids.equals("")){
		out.println("<center><Font size=+2 color=blue><b> Select the user id </b></Font></center><BR>");
		return;
	}

	ids=ids.substring(0,ids.length()-1);

	//out.println( "br"+ids+"<br>");

	int ans = rcdef.activeRegUsers(ids,ccode,obj);
	if(ans==1){
		out.println("<center><Font size=+2 color=blue><b>Update Data Successfully</b></Font></center><BR>");
		out.println("<center><A href=showregque.jsp><Font size=+1 color=blue>Browser Registration Queue</Font></A></center>");
	 }else{
		out.println("<center><Font size=+2 color=blue><b> Error to Update Data </b></Font></center><BR>");
		out.println("<center><A href=showregque.jsp><Font size=+1 color=blue>Browser Registration Queue</Font></A></center>");
	 }

	}catch(Exception e){
		out.println( e.toString());
	}
%>
