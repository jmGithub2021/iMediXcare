<%@page contentType="text/html" import="imedix.cook" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<head>
<title>Telemedicine..</title></head>

<%	
	String usertype ="",userid="",username="",distype="",prg="";
	String path = request.getRealPath("/");
	String str=request.getParameter("data");
	cook cookx = new cook();
	String id = cookx.getCookieValue("patid", request.getCookies());
	userid = cookx.getCookieValue("userid", request.getCookies());
	username = cookx.getCookieValue("username", request.getCookies());
	usertype = cookx.getCookieValue("usertype", request.getCookies());
	distype= cookx.getCookieValue("distype", request.getCookies());
	
	
	//out.println("centertype "+cookx.getCookieValue("centertype", request.getCookies()) +"<br>");
	//out.println("centername "+cookx.getCookieValue("centername", request.getCookies()) +"<br>");

	if (usertype.equals("adm")) {
		prg="adminjob.jsp";
	}
	else if (usertype.equals("doc")) {
		prg="docjob_n.jsp";
	}
	else  {
		prg="operjob_n.jsp";
	}

	if (str==null){
%>
	<frameset rows="60,*" border=0 >
			 <frame src="<%=prg%>" NAME="top" Scrolling=no NORESIZE >
			 <frame src="welcome.jsp" NAME="bot" NORESIZE >
			 <noframes>
				  Sorry, this document can be viewed only with a frames-capable browser.
				  <a href = "">Take this link</a> to the first HTML doc in the set.
			 </noframes>
		</frameset>

<%
	}else{
%>

			<frameset rows="90,*" border=0>
			 <frame src="<%=prg%>" NAME=top Scrolling=no NORESIZE >
			 <frame src="showpatdata.jsp?id=<%=id%>&usr=doc" NAME=bot NORESIZE >
			 <noframes>
				  Sorry, this document can be viewed only with a frames-capable browser.
				  <a href = "">Take this link</a> to the first HTML doc in the set.
			 </noframes>
		</frameset>

<%
	}
%>

</html>
