<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>
<html>
<head>
<title>Image Effects</title>
<style>
A { text-decoration: None;
	color: BLUE;
	font-weight: BOLD;
};
</style>

<%
	MyWebFunctions thisObj = new MyWebFunctions();
	Cookie [] cookies = request.getCookies(); 
	if (cookies != null)
	{
		for (int i = 0; i < cookies.length; i++)
		{	
			if(cookies[i].getName().equalsIgnoreCase("Drug"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
			
			if(cookies[i].getName().equalsIgnoreCase("Qty"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Dose"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Com"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Dura"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
			
			if(cookies[i].getName().equalsIgnoreCase("Count"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath(gblTelemediK);
			response.addCookie(cookies[i]);
			}
		}
	}

	
	Connection conn = null;
	Statement stmt = null;
	ResultSet RSet = null;
	
	String str="", u="", n="", r="",docid="", ty="", redirectto="";
	String sqlQuery="";
	boolean found=false;

	//read values from cookie	
	try {
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL, gbldbusername, gbldbpasswd);
		stmt = conn.createStatement();




	docid = thisObj.getCookieValue("user", request.getCookies ());
	ty = thisObj.getCookieValue("type", request.getCookies ());
	if (ty.equalsIgnoreCase("doc")) {
		
		//redirectto = "../jspfiles/pre_frame.jsp?docid="+docid;
		redirectto = "../jspfiles/dummy1.html?docid="+docid;
		response.sendRedirect(response.encodeRedirectURL(redirectto));
	}
	/////////////////////////////////// ELSE ///////////////////////////////////////////////////
	
		
		sqlQuery = "select * from LOGIN where TYPE = 'doc' order by NAME,UID" ;
		out.print("<BR>");
		out.print("<Table Width=350 Border=0>");
		out.print("<TR><TD><B><FONT SIZE=6px COLOR=#FF00FF>Select Doctor</FONT></B></TD></TR>");
		RSet = stmt.executeQuery(sqlQuery);
		while (RSet.next())
		{
			u = RSet.getString("UID");
			n = RSet.getString("NAME");
			r = RSet.getString("RG_NO");
			str="(<B><FONT SIZE=4px COLOR=RED>UID:</FONT>" + u + " ,  <FONT SIZE=4px COLOR=RED>RgNo:</FONT>"+r+ "</B>) ";
			//out.println(str);
			out.println("<TR><TD>&nbsp;&nbsp;&nbsp;<A HREF='../jspfiles/pre_frame.jsp?docid="+u+"'>"+ n + "</A>&nbsp;&nbsp;" + str.toUpperCase() + "</TD></TR>");
		}
		RSet.close();
		out.println("</Table>");
		stmt.close();
		conn.close();	
	}
	catch (Exception e)
	{ out.println("DB Connection Error found <B>"+e+"</B>"); }
%>

</body>
</html>
