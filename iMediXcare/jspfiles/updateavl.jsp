<%@page language="java"  import= "imedix.rcUserInfo,imedix.dataobj,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	String ccode;
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String utype =cookx.getCookieValue("usertype", request.getCookies());
	if (userid.equalsIgnoreCase("admin")) ccode = request.getParameter("center");
	else ccode = cookx.getCookieValue("center", request.getCookies ());

	dataobj obj = new dataobj();
	obj.add("userid",userid);
	obj.add("usertype",utype);
	obj.add("center",ccode);

	String[] avl = request.getParameterValues("avl");
	
	String avl_all="";
	if(avl!=null){
		for (int i = 0; i < avl.length; ++i){
			avl_all+=",'"+avl[i]+"'";

		}
	}
		
	String[] rfl = request.getParameterValues("rfl");

	String rfl_all="";
	if(rfl!=null){
		for (int i = 0; i < rfl.length; ++i){
			rfl_all+=",'"+rfl[i]+"'";
		}
	}
	
if(avl_all.startsWith(",")) avl_all=avl_all.substring(1);
if(rfl_all.startsWith(","))  rfl_all=rfl_all.substring(1);

rcUserInfo rcUinfo = new rcUserInfo(request.getRealPath("/"));
try{
String ans=rcUinfo.updateAvailability(avl_all,rfl_all,obj);
	if(ans.equals("Done")){
		response.sendRedirect("showusers.jsp");	
	}else{
		out.println("Error");
	}
}catch(Exception e){
	out.println("Error : "+e);
}
%>
