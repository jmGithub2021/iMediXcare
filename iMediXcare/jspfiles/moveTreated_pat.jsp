<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcDataEntryFrm,imedix.rcUserInfo, imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%!
boolean update(int status){
	if(status==1)
		return true;
	else 
		return false;
}
%>
<%
	cook cookx = new cook();
	
	String usrccode =cookx.getCookieValue("center", request.getCookies());
	String userid =cookx.getCookieValue("userid", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());
	String currpatqtype = cookx.getCookieValue("currpatqtype", request.getCookies());
	String patid = request.getParameter("patid");
	
	dataobj obj = new dataobj();
	try{

	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	int status = 0;
	if(currpatqtype.equalsIgnoreCase("local"))
		status = rcdef.moveLtoTreatedpatq(patid);
	else if(currpatqtype.equalsIgnoreCase("tele"))	
		status = rcdef.moveTtoTreatedpatq(patid);
	else
		status = 0;
	out.println(update(status));
	}catch(Exception ex){out.println("ERROR09763 : "+ex.toString());}
%>
