<%@page language="java"%>
<%@page contentType="text/html" import="imedix.cook,imedix.UserAccessCheck, java.io.*,javax.crypto.*,javax.crypto.spec.SecretKeySpec,java.util.*" %>


<%!

	public String writeLog(String log, String path){
		try{
			File file = new File(path+"/AccessControl.log");
			boolean isCreated = false;
			if(file.exists())
				isCreated = file.createNewFile();

			FileWriter writer = new FileWriter(file, true); 
			writer.write(log); 
			writer.flush();
			writer.close();
			return String.valueOf(file.exists())+"Done"+String.valueOf(isCreated);
		}catch(Exception ex){return "Error03940: "+ex.toString();}
	}
	public SecretKey getSecretKey(HttpSession session){
	    String encodedKey = (String) session.getAttribute("dataCryptoKey");
	    byte[] decodedKey = java.util.Base64.getDecoder().decode(encodedKey);
	    SecretKey key = new SecretKeySpec(decodedKey, 0, decodedKey.length, "DES"); 
	    return key;	
	}
%>



<%
	//Response.AddHeader "cache-control", "no-store, must-revalidate, private" //asp
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader ("Expires", 0);
	String redirectto= "../403.jsp";
	boolean logout = false;

	String cookUserid="",cookUserType="",cookCenter="",cookJsessionid="",cookiMediXid="";
	Cookie [] telecookies=request.getCookies();

	cook cookx1 = new cook();
	cookUserid = cookx1.getCookieValue("userid",telecookies);
	cookUserType = cookx1.getCookieValue("usertype",telecookies);
	cookCenter = cookx1.getCookieValue("center",telecookies);
	//cookJsessionid = cookx1.getCookieValue("JSESSIONID",telecookies);
	cookiMediXid = cookx1.getCookieValue("iMediXSessionId",telecookies);

	HttpSession hsess = request.getSession();
	String sid = hsess.getId();

	//JSESSIONID
	//userid
	//usertype
	//center
	/* Temp var */
	//out.println("FFF: "+this.getClass().getName());
if(!UserAccessCheck.isAccessable(this.getClass().getName(),cookUserType.toLowerCase())){
	String classname = this.getClass().getName() +" : "+cookUserType+"\n";
	writeLog(classname,request.getRealPath("/"));
	logout = true;
	//out.println("<script>alert('ClassName: "+this.getClass().getName()+" : User: "+cookUserType+" You do not have access of this module');</script>");

}

if(cookiMediXid==null || cookiMediXid.equals("")  || !cookiMediXid.equals(sid) || cookUserid==null || cookUserid.equals("")  || cookCenter==null || cookCenter.equals("") || cookUserType==null || cookUserType.equals("")){
	
	/*
		out.println("<BR>request.getSession() : "+sid);
		out.println("<BR>cookUserid: "+cookUserid);
		out.println("<BR>cookUserType: "+cookUserType);
		out.println("<BR>cookCenter: "+cookCenter);
		out.println("<BR>HttpSession: "+sid);
		out.println("<BR>cookiMediXid: "+cookiMediXid);
	*/

	cookx1.delAllCookies(telecookies,response);
	session.invalidate();
	cookx1.delAllCookies(telecookies,response);
	
	/*
		out.println("<BR><BR><BR>request.getSession() : "+sid);
		out.println("<BR>cookUserid: "+cookUserid);
		out.println("<BR>cookUserType: "+cookUserType);
		out.println("<BR>cookCenter: "+cookCenter);
		out.println("<BR>HttpSession: "+sid);
		out.println("<BR>cookiMediXid: "+cookiMediXid);
	*/
		
		logout = true;
		//return;
	}
	if(logout)
		response.sendRedirect(redirectto );

%>
