<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.medinfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*,org.json.simple.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	JSONArray jsarr = new JSONArray();
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	String serval= String.valueOf(request.getParameter("sv"));
	String cond=" name like '%"+serval.trim()+"%' ";
	
	Object res=uinfo.getValues("name,uid,emailid,phone",cond);
	Vector tmp = (Vector)res;
	if(tmp.size()>0){
		for(int ii=0;ii<tmp.size();ii++){
			JSONObject obj = new JSONObject();
			dataobj tmpData = (dataobj) tmp.get(ii);
			jsarr.add( String.valueOf(tmpData.getValue("name")) + " | " + String.valueOf(tmpData.getValue("emailid")) +" | " + String.valueOf(tmpData.getValue("phone")));
		}
	}
	out.println(jsarr);	
%>