<%@page contentType="text/html" import="imedix.rcUserInfo,imedix.rconlinecommunicator,imedix.cook, imedix.dataobj,java.util.*" %>
<%
	String uid = "",pwd="",patid="";
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	rconlinecommunicator onlComm=new rconlinecommunicator(request.getRealPath("/"));
	try {
		uid=request.getParameter("uid");
		pwd=request.getParameter("pwd");
		patid = request.getParameter("patid");

		Object res=uinfo.getuserinfo(uid,pwd);

		if(res instanceof String){
			out.println("Rejected");
		}else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0){
				String output=onlComm.setUserDetalis(uid,pwd,patid);
				out.println(output);
			}else{
				out.println("Rejected");
			}
		}
	}catch(Exception e) {
		out.println("Rejected");
	}
%>