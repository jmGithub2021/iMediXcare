<%@page language="java"  import= "imedix.rcGenOperations,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String userid=cookx.getCookieValue("userid", request.getCookies ());
	String utype =cookx.getCookieValue("usertype", request.getCookies());

	String actiontype =request.getParameter("actiontype").trim();
	
	int ans =0;
	dataobj obj = new dataobj();
	dataobj obj1 = new dataobj();

	obj.add("userid",userid);
	obj.add("usertype",utype);

	obj1.add("userid",userid);
	obj1.add("usertype",utype);


	try{
	rcCentreInfo rcCinfo = new rcCentreInfo(request.getRealPath("/"));
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));
	String refed_all=""; 

	String[] refed = request.getParameterValues("Referred");
	if(refed!=null){
		for (int i = 0; i < refed.length; ++i){
			//out.println(i+"Referred=>>"+refed[i]+"<br>");
			refed_all+=","+refed[i];
		}
	}
	String refing_all=""; 
	String[] refing = request.getParameterValues("Referring");
	if(refing!=null){
		for (int i = 0; i < refing.length; ++i){
			//out.println(i+"Referring=>>"+refing[i]+"<br>");
			refing_all+=","+refing[i];
		}
	}

if(refed_all.startsWith(",")) refed_all=refed_all.substring(1);
if(refing_all.startsWith(","))  refing_all=refing_all.substring(1);

String nccode = request.getParameter("code");
obj1.add("tname","referhospitals");
obj1.add("code",nccode);
obj1.add("referred",refed_all);
obj1.add("referring",refing_all);


	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
			String key=e.nextElement().toString();
			String val=request.getParameter(key);
			obj.add(key,val);
	}


	if(actiontype.equals("S")){
		obj.add("tname","center");
		ans = rcGen.saveAnyInfo(obj);
		int ans1 = rcGen.saveAnyInfo(obj1,"code"); /// add to referhospitals
	}else if(actiontype.equals("CE")){
		ans = rcCinfo.editCentreInfo(obj);
	}else{
		ans = rcCinfo.editCentreInfo(obj);
		int ans1 = rcGen.saveAnyInfo(obj1,"code"); /// Update to referhospitals
	}

out.println("<br>"+ actiontype);

	if(actiontype.equals("CE")){
		if(ans==1){
				response.sendRedirect("editcenter2.jsp");		
		 }else{
				//response.sendRedirect(".....jsp");
				out.println("Error");
		 }
	}else{
		  if(ans==1){
				response.sendRedirect("showcenter.jsp");		
		 }else{
				//response.sendRedirect(".....jsp");
				out.println("Error");
		 }
	}
	out.println("<br>"+ ans);
	}catch(Exception e){
		out.println( e.toString());
	}
%>
