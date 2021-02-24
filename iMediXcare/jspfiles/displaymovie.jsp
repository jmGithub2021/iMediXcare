<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*, java.io.OutputStream" %>
<%@ include file="..//includes/chkcook.jsp" %>
<HTML>
<HEAD>
<body>
<%
	String id="",ty="",endt="",dt="",sl="";
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	OutputStream os = response.getOutputStream();
	try {	
		id=request.getParameter("id");
		ty=request.getParameter("ty");
		sl=request.getParameter("sl");
		dt=request.getParameter("dt");
		//os.write(id.getBytes());
		//os.write("<br>".getBytes());
		//os.write(ty.getBytes());
		//os.write("<br>".getBytes());
		//os.write(sl.getBytes());
		//os.write("<br>".getBytes());
		//os.write(dt.getBytes());
		//endt=dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);
		String mime=ddinfo.getMovieCon_type(id,dt,ty,sl);
		byte [] _blob =ddinfo.getMovie(id,dt,ty,sl);
		response.setContentType(mime);
		os.write(_blob,0,_blob.length);
		os.flush();
		os.close();
	}catch(Exception e) {
		os.write(e.toString().getBytes());
		os.close();
	}

%>
</body>
</head>
</html>
