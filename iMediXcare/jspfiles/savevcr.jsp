<%@page language="java"  import= "imedix.rcGenOperations,imedix.dataobj,imedix.cook,java.util.*"%>

<%@ include file="..//includes/chkcook.jsp" %>
<%
	int ans =0;
	cook cookx = new cook();
	
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));
	dataobj obj = new dataobj();
	try{

	
	for (Enumeration e = request.getParameterNames() ; e.hasMoreElements();) {
			String key=e.nextElement().toString();
			String val=request.getParameter(key);
			obj.add(key,val);
			
		}

		String dh=obj.getValue("durhr").trim();
		String dm=obj.getValue("durmin").trim();
		
		Date dt=new Date();
		Calendar calendar = Calendar.getInstance();
		String tm[] =obj.getValue("sttime").trim().split(":");
		int h=Integer.parseInt(tm[0]);

		if(obj.getValue("ampm").trim().equals("pm")) h=h+12;
		
		//out.println("****"+Integer.toString(h));

		dt.setHours(h);
		dt.setMinutes(Integer.parseInt(tm[1]));
		dt.setSeconds(Integer.parseInt(tm[2]));

        calendar.setTime(dt);
		
        calendar.add(Calendar.HOUR_OF_DAY, Integer.parseInt(dh));
		calendar.add(Calendar.MINUTE, Integer.parseInt(dm));
        
		String etime= calendar.get(Calendar.HOUR_OF_DAY)+":"+calendar.get(Calendar.MINUTE)+":"+calendar.get(Calendar.SECOND);

		obj.add("starttime",Integer.toString(h)+":"+tm[1]+":"+tm[2]);
		obj.add("endtime",etime);
		obj.add("duration",dh+":"+dm);
		obj.add("tname","online_history");
		
		//for(int i=0;i<obj.getLength();i++) out.println(obj.getKey(i) + " : " +obj.getValue(i)+"<br>");
	 ans = rcGen.saveAnyInfo(obj);
	if(ans==1){
			out.println("<center><Font size=+2 color=blue><b>Save Data Successfully</b></Font></center><BR>");
		out.println("<center><A href='javascript:history.go(-1)'><Font size=+1 color=blue>Browser Patient Queue</Font></A></center>");
	 }else{
			//response.sendRedirect(".....jsp");
			
	 }
	out.println("<br>"+ ans);
	}catch(Exception e){
		out.println( e.toString());
	}
%>


