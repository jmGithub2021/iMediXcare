<%@page contentType="text/html" import="imedix.cook,imedix.rcdpStats,java.util.*,imedix.dataobj,com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonPrimitive" %>
<%@page errorPage="error.jsp" %>
<%
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	//cname = cname.substring(0,cname.lastIndexOf(" "));
	String str= "<I>Online Telemedicine Center </I><br><b>"+cname + "</b>";
	//out.println(str.toUpperCase());

	String path = request.getRealPath("/");
	rcdpStats dpStats = new rcdpStats(request.getRealPath("/"));
	//"start="+vstart+"&to="+vto+"&cent"+cent;
	String vstart = request.getParameter("start");
	String vto = request.getParameter("to");
	String vcent = request.getParameter("cent");
	//out.println(vcent + " " + vstart + " " + vto);

	Vector v = (Vector)dpStats.getTpatQRefByData(vcent,vstart,vto);
	//out.println( v.size() );

	JsonArray data = new JsonArray();
	JsonArray row = new JsonArray();
	row.add(new JsonPrimitive("ReferredBy"));
	row.add(new JsonPrimitive("Patients"));
	data.add(row);
	String str1="";
	for (int i = 0; i < v.size(); i++){
		dataobj innerObj = (dataobj)v.elementAt(i);
		row = new JsonArray();
        row.add(new JsonPrimitive( innerObj.getValue("refer_center") ));
        row.add(new JsonPrimitive( Integer.parseInt(innerObj.getValue("PATIENTS")) ));
        data.add(row);
	}
	out.println(data.toString());


%>
