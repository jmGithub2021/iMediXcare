<%@page language="java"  import= "imedix.rcAdminJobs,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	dataobj obj = new dataobj();
	try{
	rcAdminJobs rcAjob = new rcAdminJobs(request.getRealPath("/"));

	String que=request.getParameter("que");
	String ID=request.getParameter("ID");
	String cv=request.getParameter("cb");
	int ans = rcAjob.addToQue(que,ID);
	

	if(ans==1){
		   if(cv.equals("visit")) response.sendRedirect(response.encodeRedirectURL("setvisitdate.jsp")); 
		   else
			response.sendRedirect(response.encodeRedirectURL("oldpat.jsp")); 

	}else{
			out.println("Error");
	}


	}catch(Exception e){
		out.println( e.toString());
	}
	//response.sendRedirect("frames.html");

%>