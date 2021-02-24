<%@page contentType="text/html" %>
<%
String patid="",sl="",ty="",endt="",param1="",param2="";
patid=request.getParameter("id");
ty=request.getParameter("ty");
sl=request.getParameter("sl");
endt=request.getParameter("dt");
param1="viewdoc.jsp?id="+patid+"&dt="+endt+"&ty="+ty+"&sl="+sl;
param2="disdoc.jsp?id="+patid+"&dt="+endt+"&ty="+ty+"&sl="+sl;
%>
<html>
<head>
<title>Frames Layout</title>
</head>
<frameset rows="25%,*" Border=0 >
     <frame src="<%=param1%>" NAME=viewd Scrolling=no>
     <frame src="<%=param2%>" NAME=disd>
     <noframes>
          Sorry, this document can be viewed only with a frames-capable browser.
          <a href = "">Take this link</a> to the first HTML doc in the set.
     </noframes>
</frameset>
</html>
