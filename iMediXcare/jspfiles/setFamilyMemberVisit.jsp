<%@page contentType="text/html" import="imedix.rcGenOperations,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj,logger.reimedixlogger, imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*,imedix.Decryptcenter" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
String patid="",primarypatid="", name="", relation="";
patid = request.getParameter("patid");
primarypatid = request.getParameter("primarypatid");
name = request.getParameter("name");
relation = request.getParameter("relation");
//rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
//Object res = uinfo.getuserinfo();
//getuserinfo
cook cookx = new cook();
			cookx.addCookie("userid",patid,response);
			cookx.addCookie("username",name,response);
			cookx.addCookie("relationship",relation,response);
			cookx.addCookie("primarypatid",primarypatid,response);
			//cookx.addCookie("docdistype",temp.getValue("dis"),response);
			//cookx.addCookie("verifemail",temp.getValue("verifemail"),response);
			//cookx.addCookie("verifphone",temp.getValue("verifemail"),response);		
			//cookx.addCookie("center",ccd,response);

		response.sendRedirect(response.encodeRedirectURL("patient?templateid=1&menuid=head1&dest=patientAlldata&id="+patid)); 
%>