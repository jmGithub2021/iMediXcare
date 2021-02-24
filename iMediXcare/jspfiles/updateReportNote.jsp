<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj,imedix.PACSEncryption,imedix.projinfo, imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*"%>


<%
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, HEAD");
        response.addHeader("Access-Control-Allow-Headers", "X-PINGOTHER, Origin, X-Requested-With, Content-Type, Accept");
        response.addHeader("Access-Control-Max-Age", "1728000");
response.setHeader("Access-Control-Allow-Origin", "*"); 
String path = request.getRealPath("/");
PACSEncryption penc = new PACSEncryption(path);
projinfo pinfo=new projinfo(path);
String uid = pinfo.PACSuid;
String pass = pinfo.PACSpass;
String acptUrlf = pinfo.PACSAcceptingIP;

String acptURL[] = {"10.5.29.88","10.5.29.87","127.0.0.1","10.124.68.253","161.202.180.186"};

try{
	JSONObject jsobj = new JSONObject();
		Enumeration e = request.getHeaderNames();
		while(e.hasMoreElements()){
			String key=e.nextElement().toString().trim();
			String val=request.getHeader(key).trim();	
			
			jsobj.put(key,val);
		}
			//	out.println(jsobj.toString());




String remoteAddr="";
      if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        //out.println(remoteAddr);

//out.println(penc.PACSDecryptionString("55NhaNduYpU=","IITPACS@123"));
//out.println(Arrays.asList(acptURL).contains(remoteAddr));
//if(acptUrl.equals("//"+remoteAddr) && "PUT".equalsIgnoreCase(request.getMethod())){
//if(Arrays.asList(acptURL).contains(remoteAddr) && "POST".equalsIgnoreCase(request.getMethod())){
  if("POST".equalsIgnoreCase(request.getMethod())){
	String authUser = "d",authPass = "",flag="";
	try{
		rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
		dataobj obj = new dataobj();
		for (Enumeration en = request.getParameterNames() ; en.hasMoreElements() ;) {
			String key=en.nextElement().toString().trim();
			String val=request.getParameter(key).trim();
			if (key.equalsIgnoreCase("authuser") && val.length()>0) authUser = penc.PACSDecryptionString(val,pass);
			if (key.equalsIgnoreCase("flag") && val.length()>0) flag = val;
			obj.add(key,val);
			//System.out.println(key+" : "+val+"");
			//out.println(key+" : "+val+"<br>");
			
		}
		
		if(authUser.equals(uid)){
			if(flag.equals("r"))
				out.println("{\"msg\":\""+rcdef.isReport(obj)+"\"}");
			if(flag.equals("n"))
				out.println("{\"msg\":\""+rcdef.isNote(obj)+"\"}");
			//out.println(authUser);
		}
		else{out.println("{\"msg\":\"Authentication faild\"}");}
	}	
	catch(Exception ex){out.println("{\"msg\":\""+ex.toString()+"\"}");}	

}

 else{out.println("{\"msg\":\"Request is comming from Anonymous server(System can not recognise) OR invalid request\"}");}       
        
        
        
        
        
	}
	catch(Exception ex){out.println("{\"msg\":\""+ex.toString()+"\"}");}        
%>
