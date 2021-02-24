<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>
<%

	MyWebFunctions thisObj = new MyWebFunctions();

	Connection conn = null;
	Statement stmt = null;
	ResultSet RSet = null;
	
	String str, uid, name;
	String sqlQuery="";
	boolean found=false;

	//read values from cookie	

	if (typ.equalsIgnoreCase("doc"))
	{

	}
	else {
			try {
				Class.forName(gbldbjdbcDriver);
				conn = DriverManager.getConnection(gbldbURL, gbldbusername, gbldbpasswd);
				stmt = conn.createStatement();
			sqlQuery = "select * from LOGIN where type = 'doc' order by NAME,UID" ;
				out.print("<BR>");
				out.print("<Table Width=150 >");
				out.print("<TR><TD>Select Doctor</TD></TR>");
				RSet = stmt.executeQuery(sqlQuery);
				while (RSet.next())
				{
					str=RSet.getString("NAME") + " (" + RSet.getString("UID") + ") ";
					out.print("<TR><TD>"+str.toUpperCase()+"</TD></TR>");
				}
				RSet.close();
				out.print("<\Table>");
			}
			catch (Exception e)
			{ out.println("DB Connection Error found <B>"+e+"</B>"); }
			stmt.close();
			conn.close();	
	}
%>
