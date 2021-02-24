<%@page contentType="text/html" import="imedix.cook,imedix.rcdpStats,java.util.*,imedix.dataobj,com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonPrimitive" %>
<%@page errorPage="error.jsp" %>
<%
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	//cname = cname.substring(0,cname.lastIndexOf(" "));
	//String str= "<I>Online Telemedicine Center </I><br><b>"+cname + "</b>";
	//out.println(str.toUpperCase());

	String path = request.getRealPath("/");
	rcdpStats dpStats = new rcdpStats(request.getRealPath("/"));
	//"start="+vstart+"&to="+vto+"&cent"+cent;
	String vstart = request.getParameter("start");
	String vto = request.getParameter("to");
	String vcent = request.getParameter("cent");
	//out.println(vcent + " " + vstart + " " + vto);

	dataobj agev = (dataobj)dpStats.getAgeData(vcent,vstart,vto);

	JsonArray data = new JsonArray();

	JsonArray row = new JsonArray();
	row.add(new JsonPrimitive("Age-Group"));
	row.add(new JsonPrimitive("Number"));
	data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Adult" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("A") )));
    data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Teenager" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("E") )));
    data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Child" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("C") )));
    data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Toddler" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("T") )));
    data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Infant" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("I") )));
    data.add(row);

	row = new JsonArray();
    row.add(new JsonPrimitive( "Neonate" ));
    row.add(new JsonPrimitive( Integer.parseInt(agev.getValue("N") )));
    data.add(row);

	out.println(data.toString());
%>
