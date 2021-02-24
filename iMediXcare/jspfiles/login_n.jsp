<%@page contentType="text/html" import="imedix.rcGenOperations,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj,logger.reimedixlogger, imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*,imedix.Decryptcenter,javax.crypto.*" %>

<% 
 
if(session.getAttribute("uid")==null || session.getAttribute("uid")=="")
{

	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires", 0);
	
	String usrid="",pswd="",qval="",data="",callby="",uid="";

	usrid = request.getParameter( "uid" ).trim();
	pswd= request.getParameter( "pwd" ).trim();
	callby= request.getParameter("callby");
	if(callby==null) callby="";

	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	reimedixlogger imxlog = new reimedixlogger(request.getRealPath("/"));
	Object res=uinfo.getuserinfo(usrid,pswd);

	if(res instanceof String){
		imxlog.putLoginDetails(usrid,"Unknown",2);
		String WebServer, redirectto;
		WebServer = request.getHeader( "host" );
		out.println("0");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){

			cook cookx = new cook();
			//cookx.delAllCookies(request.getCookies(),response);
			//session.invalidate();
			HttpSession ss = request.getSession(true);
			String sid = ss.getId();
			//out.println(sid);
		
			cookx.addCookie("iMediXSessionId",sid,response);
			dataobj temp = (dataobj) tmp.get(0);
			
			String p="P";
			String actv=temp.getValue("active");
			char p1=p.charAt(0);
			char actv1=actv.charAt(0);
			if(p1==actv1)
			{
			out.println("<h3 style='color:red'><center>Your account is not activated !</center></h3>");
			out.println("<h4 style='color:green'><center><a href='../index.jsp'>Home</a></center></h4>");
			}
			else{
			out.println("<h3> not working</h3>");
		
			String ccd=temp.getValue("center");
			//-------------------------------------
			//--------------------------------------		
			//temp.gotop();
			uid = temp.getValue("uid");
			out.println("uname "+temp.getValue("uid")); // here
			out.println(" name "+temp.getValue("name"));
			out.println(" type "+temp.getValue("type"));
			out.println(" Dis "+temp.getValue("dis") + "<br>"); // here
			session.setAttribute("uid",uid);
			session.setAttribute("utype",temp.getValue("type"));
			session.setAttribute("verifemail",temp.getValue("verifemail"));
			session.setAttribute("verifphone",temp.getValue("verifemail"));	
			//Creating the SecretKey for data forlder path encryption-decryption. Then store it in session, which can be used from any jsp.	
			SecretKey key = KeyGenerator.getInstance("DES").generateKey();
			String encodedKey = Base64.getEncoder().encodeToString(key.getEncoded());
			session.setAttribute("dataCryptoKey",encodedKey);

			cookx.addCookie("userid",temp.getValue("uid"),response);
			cookx.addCookie("username",temp.getValue("name"),response);
			cookx.addCookie("usertype",temp.getValue("type"),response);
			cookx.addCookie("docdistype",temp.getValue("dis"),response);
			cookx.addCookie("verifemail",temp.getValue("verifemail"),response);
			cookx.addCookie("verifphone",temp.getValue("verifemail"),response);		
			cookx.addCookie("center",ccd,response);
			
			imxlog.putLoginDetails(temp.getValue("uid"), temp.getValue("type"),1);
			//Update Center Validity
			Decryptcenter imc = new Decryptcenter();
			
			rcCentreInfo rcCinfo = new rcCentreInfo(request.getRealPath("/"));
			String ccode  = ccd;
			String userid = temp.getValue("uid");
			String utype  = temp.getValue("type");
			try {
				int cnt=1;
				Object res0=cinfo.getAllCentreInfo();
				Vector tmp0 = (Vector)res0;
				for(int i=0;i<tmp0.size();i++){
					dataobj obj = new dataobj();
					dataobj temp0 = (dataobj) tmp0.get(i);
					String occode = temp0.getValue("code").trim();
					String cname = temp0.getValue("name").trim();
			
					String expdate = imc.decryptLicString(  temp0.getValue("expdate") );
					java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
					java.util.Date today = new java.util.Date();
					long timeDiff = expDate.getTime() - today.getTime();
					long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
					int ans = -99;		
					obj.add("userid",userid);
					obj.add("usertype",utype);
					obj.add("code",occode);
					obj.add("tname","center");
					if (daysDiff<=0) {
						obj.add("visibility","N");
						ans = rcCinfo.editCentreVisibility(obj);
					}
					System.out.println("occode: "+occode + ", daysDiff: " + daysDiff + ", ans=" + ans);	
				}
			}
			catch (Exception e) {
				out.println("Error : <B>"+e+"</B>");		
			}
			//Update Center Validity
			if(ccd.equalsIgnoreCase("XXXX")){
				cookx.addCookie("centername","All Hospital",response);
			}else{
				Object resc=cinfo.getRCentreInfo(ccd);
				Vector tmpc = (Vector)resc;
				dataobj tempc = (dataobj) tmpc.get(0);
				cookx.addCookie("centername",tempc.getValue("name"),response);
			}
			cookx.addCookie("centertype","local",response);
			
			String osname=System.getProperty("os.name");
			String scriptpath="/jspfiles/shellscripts";
			String ser = request.getServerName();
			try{
			 
			 //InetAddress hostAdd = InetAddress.getByName(ser);
	       	 //String remoteip = hostAdd.getHostAddress();
		 	 
			 //out.println(remoteip);

	   		 Runtime rt = Runtime.getRuntime();
			 String home=request.getRealPath("/")+"temp";
			 File fdir = new File(home);
			 if(!fdir.exists()){
				boolean yes1 = fdir.mkdirs();
			 }
			 Process proc;
			 int x;
			 File testusr=new File(home+"/"+uid);
			 out.println("test: |"+home+"|"+uid+"|");
			 if(osname.startsWith("W") || osname.startsWith("w")){
					if(testusr.isDirectory())
					{
						proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/delusr.bat "+uid+" "+home);
						x=proc.waitFor();
					}
					proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/cuser.bat "+uid+" "+home);
					x=proc.waitFor();

					//out.println(request.getRealPath("/")+"jspfiles/shellscripts/cuser.bat "+uid+" "+home);
					//out.println(home);
			
			}else if(osname.startsWith("L") || osname.startsWith("l")){
					if(testusr.isDirectory())
					{
						proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/delusr.sh "+uid+" "+home);
						x=proc.waitFor();
					}
					proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/cuser.sh "+uid+" "+home);
					x=proc.waitFor();
					
					//out.println(request.getRealPath("/")+"jspfiles/shellscripts/cuser.sh");
					//out.println(home);

			}
			}catch(Exception e)
			{out.println(e);}
			
			if(callby.equalsIgnoreCase("OfflineDemain")) 
			{response.flushBuffer(); 
			out.println("op1");}
		//	else {response.sendRedirect(response.encodeRedirectURL("headermenu_sk.jsp?templateid=1&menuid=head1")); 
			else {
				if (utype.equalsIgnoreCase("pat")) {
					response.sendRedirect(response.encodeRedirectURL("patient?templateid=1&menuid=head1&dest=patientAlldata&id="+uid)); 
					//out.println("op2");
				}
				else {
					response.sendRedirect(response.encodeRedirectURL("home")); 
					//out.println("op2");
				}
		}
			
}
		}else{
			imxlog.putLoginDetails(uid,"Unknown",2);
			out.println("0");	

		}
	
	}


}


/*
  //@ you can use this one also to prevent multi login
 
else
{
out.print("<h3 style='color:red'>You are not allowed to login !</h3>");
out.print((String)request.getParameter("sign"));
out.print("<a href='../index.jsp'>Try Login</a>");
}
*/

 else
 {
	 out.print("<script>alert('You already logged on');");
	 out.print("window.location.href='index.jsp'");
	 out.print("</script>");
 }


 %>	
 	
