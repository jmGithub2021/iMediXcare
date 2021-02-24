<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.medinfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*,org.json.simple.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	JSONArray jsarr = new JSONArray();
		cook cookx = new cook();
		String ccode = cookx.getCookieValue("center", request.getCookies ());
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
			Object res = ddinfo.getDrugListDefault();
			//Object res = ddinfo.getDrugListByCenter(ccode);
			Vector tmp = (Vector)res;
			//out.println("ffffff "+tmp.size());
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				jsarr.add(temp.getValue("drug_name"));
			}
	out.println(jsarr);
%>
