<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
String id,nam,us="";
id = request.getParameter("ID").trim();
out.print("id : " + id);

Connection conn = null;
Statement stmt = null;
MyWebFunctions thisObj = new MyWebFunctions();
us = thisObj.getCookieValue("user", request.getCookies());
ResultSet RSet = null;
String sqlQuery,iData;
boolean found=false;

try {
	Class.forName(gbldbjdbcDriver);
	conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
	stmt = conn.createStatement();
	sqlQuery = "select PAT_ID,PAT_NAME from med where lower(PAT_ID) = '" + id.toLowerCase() +"'";
	try {
		RSet = stmt.executeQuery(sqlQuery);
		while(RSet.next())
		{
			thisObj.addCookie("patid",id,response);
			thisObj.addCookie("patname",RSet.getString("PAT_NAME"),response);
			found = true;
			break;
		}

	} catch(Exception e)
	{out.print("Exception **: "+e); }

	RSet.close();
	stmt.close();
	conn.close();

} catch(Exception e)
{out.print("Exception!! : "+e); }

		
if (found == false)
{
	out.print("<BR><BR><CENTER><B>");
	out.print("<FONT SIZE=+2 COLOR='DARKBLUE'>Patient with "+id+" id </FONT><BR>");
	out.print("<FONT SIZE=+2 COLOR='RED'>Not Found/ Currently Locked</FONT><BR><BR>");
	out.print("<FONT SIZE=+2 COLOR=#8F8F8F>Please enter correct Patient ID</FONT>");
	out.print("<br><A href='javascript:history.back();'> Try Again </A>");
	out.print("</B></CENTER>");
}
else
{		
		String usrdir=gblFTPRoot.substring(0,gblFTPRoot.lastIndexOf("/"))+"/"+us+"/"+id.trim();
		//out.println("usrdir"+usrdir);
		File fdir = new File(usrdir);
		boolean yes=fdir.mkdirs();
		if (yes)
			out.print("<BR>id Dir created : "+usrdir);
		else
			out.println("<BR>id Not created : ");
		String fid=gblFTPRoot.substring(0,gblFTPRoot.lastIndexOf("/"))+"/"+us+"/patid.txt";
		FileOutputStream fo=new FileOutputStream(fid);
		for(int i=0;i<id.length();++i)
		{
			fo.write(id.charAt(i));
		}
		fo.close();  	
	response.sendRedirect(response.encodeRedirectURL("frames.html"));
}
%>


