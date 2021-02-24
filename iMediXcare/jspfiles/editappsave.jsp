<%@page language="java"  import= "imedix.rcGenOperations,imedix.dataobj,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	
	dataobj obj = new dataobj();
	try{
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));
	
	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
			String key=e.nextElement().toString();
			String val=request.getParameter(key).trim().replaceAll("/","");
			obj.add(key,val);
		}

	int ans = rcGen.updateAppDate(obj);
	String dt=request.getParameter("editdate");
	if(ans==1){
			out.println("<br><br><center><FONT SIZE='+2'> Next Visit Date is set on :" + dt + "</FONT></center>");
	 }else{
			out.println("Error");
	 }
	//out.println("<br>"+ ans);
	}catch(Exception e){
		out.println( e.toString());
	}
%>