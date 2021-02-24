<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj,java.util.*"%>
<%
	//cook cookx = new cook();
	//String ccode =cookx.getCookieValue("center", request.getCookies ());

	String userid=request.getParameter("uid");
	if(!userid.equals("")){
		dataobj obj = new dataobj();
		
		try{
			rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
			for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
				String key=e.nextElement().toString();
				String val=request.getParameter(key);
				if (val.endsWith("\r\n")) val=val.replaceAll("\r\n", "");
				if (val.endsWith("\n\r")) val=val.replaceAll("\n\r", "");
				obj.add(key,val);
			}
			obj.add("consent","N");
			int ans = rcdef.InsertRegUsers(obj);
			if(ans==1){
				response.sendRedirect("regdone.jsp?id="+userid);
			 }else{
				response.sendRedirect("regfail.jsp");
			}

		//out.println("<br>"+ userid);
			}catch(Exception e){
				out.println( e.toString());
			}

		}else 
			response.sendRedirect("regfail.jsp");

%>
