<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.medinfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*,org.json.simple.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	JSONArray jsarr = new JSONArray();
	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	String serval= String.valueOf(request.getParameter("sv"));
	String cond  = " (`name` like '%"+serval.trim()+"%' or `emailid` like '%"+serval.trim()+"%' ";
           cond += " or `phone` like '%"+serval.trim()+"%' ) and ( emailid!='' and phone!='' ) ";
	Object res=uinfo.getValues("name,uid,emailid,phone,verifemail,verifphone",cond);
	Vector tmp = (Vector)res;
	if(tmp.size()>0){
        int limit = tmp.size();
        if (limit>20) limit=20;
		for(int ii=0;ii<limit;ii++){
			JSONObject obj = new JSONObject();
			dataobj tmpData = (dataobj) tmp.get(ii);
			String sData = "";
			sData += String.valueOf(tmpData.getValue("name")) + " | " ;
			sData += String.valueOf(tmpData.getValue("emailid")) + " | " ;
			sData += String.valueOf(tmpData.getValue("phone")) + " | " ;
			sData += String.valueOf(tmpData.getValue("verifemail")) + " | " ;
			sData += String.valueOf(tmpData.getValue("verifphone"));
			jsarr.add( sData );
		}
	}
	out.println(jsarr);	
%>