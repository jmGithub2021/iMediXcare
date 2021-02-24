<%@page contentType="text/html" import="imedix.layout,java.io.*" %>
<head>
	<LINK REL="SHORTCUT ICON" HREF="../images/icon.ico"> 
</head>
<% 	

	layout LayoutMenu = new layout(request.getRealPath("/"));

	String menu=LayoutMenu.getMainMenu();
	out.println(menu);
	
	
%>
