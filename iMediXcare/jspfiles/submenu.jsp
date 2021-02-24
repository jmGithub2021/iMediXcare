<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>

<% 	
	cook cookx = new cook();
	String userid = cookx.getCookieValue("userid", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
	String distype= cookx.getCookieValue("distype", request.getCookies());
	String tmpid = request.getParameter("templateid");
	String menuid = request.getParameter("menuid");

	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	layout LayoutMenu = new layout(request.getRealPath("/"));
		String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"left","2");
		
			String menu1=menu.replaceAll("target=\"content2\"","");
		String menu2=menu1.replaceAll("'header2'","this.getAttribute('value')");
		String menu3=menu2.replaceAll("href","href='#' value");
		//String menu3=menu2.replaceAll("target='content2'","");
		//menu1="<ul>"+menu1+"</ul>";

		
		out.println(menu3);



%>
