<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.myDate,imedix.rcDataEntryFrm,imedix.rcUserInfo, imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*" %>
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
	obj.add("pat_id",patid);
	obj.add("visitdate",myDate.getCurrentDate("ymd",true));
	obj.add("userid",userid);
	
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	int status = 0;
	if(currpatqtype.equalsIgnoreCase("local"))
		status = rcdef.moveTreatedtoLpatq(obj);
	else if(currpatqtype.equalsIgnoreCase("tele"))	
		status = rcdef.moveTreatedtoTpatq(obj);
	else
		status = 0;
	out.println(update(status));
	}catch(Exception ex){out.println("ERROR09763 : "+ex.toString());}
%>
