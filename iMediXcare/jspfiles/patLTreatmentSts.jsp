<%@page contentType="text/html" import="imedix.layout,java.io.*,java.text.*,imedix.cook,imedix.rcGenOperations,imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.rcPatqueueInfo,imedix.dataobj,imedix.myDate,imedix.projinfo, java.util.*,org.json.simple.*,org.json.simple.parser.*" %>

<%
String status = request.getParameter("status");
String patid = request.getParameter("patid");
String appdate = request.getParameter("dateapp");
String patqtype = request.getParameter("patqtype");
cook cookx = new cook();
String userid =cookx.getCookieValue("userid", request.getCookies ());

	rcPatqueueInfo pqinfo = new rcPatqueueInfo(request.getRealPath("/"));
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	String laptqlistObj = (String)session.getAttribute("lpatqlist");
	JSONParser lpatparser = new JSONParser();
	JSONArray lpatqlist = new JSONArray();
	int nextPatSize=0;
	int flag = 0;
	if(laptqlistObj!=null){
		lpatqlist = (JSONArray)lpatparser.parse(laptqlistObj);
		nextPatSize = lpatqlist.size();
		for(int i=0;i<nextPatSize;i++){
			if(String.valueOf(lpatqlist.get(i)).equalsIgnoreCase(patid))
				flag = i;
		}
		if(nextPatSize>0){
			lpatqlist.remove(flag);
			session.setAttribute("lpatqlist",String.valueOf(lpatqlist));
		}
		if(nextPatSize==0){
			//Call lpatq if return any updated records session.setAttribute
		}
		out.println(lpatqlist);		
	}	
if(status.equalsIgnoreCase("true")){
	//pqinfo.updateLpatqAssignDate(patid,appdate);	//Already updating in commdoc2pat.jsp and commdoc2tpat.jsp page
}
else{
	if(patqtype.equalsIgnoreCase("local")){
		rcdef.advicedConsultant(patid,userid);
		rcdef.moveLtoTreatedpatq(patid);
	}
	if(patqtype.equalsIgnoreCase("tele")){
		rcdef.moveTtoTreatedpatq(patid);
		rcdef.teleTreated(patid, userid);	
	}
}

%>