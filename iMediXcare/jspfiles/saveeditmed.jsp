<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%

	dataobj obj = new dataobj();
	try{
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies());
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String usr = cookx.getCookieValue("type", request.getCookies());

	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
			String key=e.nextElement().toString().trim();
			String val=request.getParameter(key).trim();
			if (key.equalsIgnoreCase("persidvalue") && val.length()==0) val="notst";
			obj.add(key,val);
			System.out.println(key+" : "+val+"");
			out.println(key+" : "+val+"<br>");
			
		}
	obj.add("userid",userid);
	obj.add("center",ccode);
	obj.add("type",usr);

	String id=request.getParameter("pat_id");

	int ans = rcdef.updateMed(obj);
	

	if(ans==1){
			response.sendRedirect(response.encodeRedirectURL("displaymed.jsp?id="+id)); 

	}else{
			out.println("Error");
	}


	}catch(Exception e){
		out.println( e.toString());
	}
	//response.sendRedirect("frames.html");

%>
