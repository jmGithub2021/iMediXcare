<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String userid =cookx.getCookieValue("userid", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());

	dataobj obj = new dataobj();
	try{
	  String skipFields="frmnam testdate pat_id entrydate nofimg name_hos";
	  skipFields += " hdmy1 hdmy2 hdmy3 tb_hdmy past_hdmy infection_hdmy ";

	  int dataFields=0, j=0, c=0;
	  rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));	
	  for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
		String key=e.nextElement().toString();
		String val=request.getParameter(key);
		obj.add(key,val);
		if (skipFields.indexOf(key)==-1 && val.length()>0 && key.equalsIgnoreCase(val)==false) dataFields++;
		if (val.length()<2 && val.length()>0) {
		  j=0; c=0;
		  while(j<val.length()) {
		    char tm = val.charAt(j);
		    if (Character.isLetterOrDigit(tm)) c++;
		    j++;
		  }
		  if (c==0) dataFields--;
		}
		//if (val.length()>0) out.println("dataFields = "+dataFields+"  key="+key +" : val="+val+"<br>");
	  }
	  obj.add("userid",userid);
	  obj.add("center",ccode);
	  obj.add("usertype",usr);
	  //out.println("<br>"+ dataFields);
	  if (dataFields>0) {
	    int ans = rcdef.InsertFrmLayers(obj);
	    if(ans==1) response.sendRedirect("showlist.jsp");
	    else out.println("Error: DB/RMI could be reason!!");
	    //out.println("<br>"+ ans);
	    //out.println("Attempted to Submit : " + ans);
	  }
	  else {
	    out.println("<br><br><br><center><font color='Blue' size='5'>Cannot Submit a Blank Form</font><br><br><br><a href='javascript: history.go(-1)'>Back</a><center>");
	  }
	}catch(Exception e){
		out.println( e.toString());
	}
%>