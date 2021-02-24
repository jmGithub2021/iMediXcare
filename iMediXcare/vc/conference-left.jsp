<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
    <link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
    <script src="../bootstrap/jquery-2.2.1.min.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <script src="../bootstrap/jquery.dataTables.min.js"></script>
    <script src="../bootstrap/dataTables.bootstrap.min.js"></script>

    <script type="text/javascript" src="../bootstrap/js/loader.js"></script>
    <link href="../bootstrap/css/jquery-ui.css" rel="stylesheet">
    <script src="../bootstrap/js/jquery-ui.js"></script>

    <title>iMediX Conference Module</title>
</head>
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
	//out.println(usertype+"<br>"+tmpid+"<br>"+menuid);
	String str,str1;

	str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";
%>
    <h2>Left panel</h2>
    <h3>Data</h3>
    Username: <%=username%>
    UserId: <%=userid%>
    UserType: <%=usertype%>
</html>