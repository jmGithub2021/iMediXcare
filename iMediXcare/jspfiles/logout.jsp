<%@page contentType="text/html" import="java.util.*,java.text.*,java.io.*,java.net.*,logger.reimedixlogger, imedix.cook" %>

<html>
<head>
<script language="JavaScript">
function cl()
{
//alert("dasd");
var preval,crem;
	
	var ch=(navigator.appName.indexOf("Microsoft") != -1);
	if(ch==true)
	{
		preval=getCookie("node");
		crem=getCookie("currem");
		
		if(preval != null)
		{
		document.cookie="node=";
		}
		
		if(crem != null)
		{
		document.cookie="currem=";
		} 
	}
	else
	{
		preval=getCookie("node");
		//alert(preval);
		crem=getCookie("currem");
		alert(crem);
		if(preval.length != 0)
		{
		document.cookie="node=";
		}

		if(crem.length != 0)
		{
		document.cookie="currem=";
		}				
	}
}

function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }

</script>
<head>
<body onLoad='cl()'>
<%	

	//MyWebFunctions thisObj = new MyWebFunctions();

	String us="",typ="",qr="";
	/*
	us=thisObj.getCookieValue("user", request.getCookies ());
	typ=thisObj.getCookieValue("type", request.getCookies ());	
	if(typ.equals("doc"))
	{
	 qr="update LPATQ set delflage='yes' where CHECKED='y'";
	 thisObj.ExecuteSql(qr);
	
	}
	
	*/
			
			cook cookx = new cook();
			String uid=cookx.getCookieValue("userid", request.getCookies ());
			String utype =cookx.getCookieValue("usertype", request.getCookies());

			String osname=System.getProperty("os.name");
			String scriptpath="/jspfiles/shellscripts";
			String ser = request.getServerName();
			try{
			 InetAddress hostAdd = InetAddress.getByName(ser);
	       	 String remoteip = hostAdd.getHostAddress();
		 	 out.println(remoteip);
	   		 Runtime rt = Runtime.getRuntime();
			 String home=request.getRealPath("/")+"temp";

			 //File fdir = new File(home);
			 //if(!fdir.exists()){
			//	boolean yes1 = fdir.mkdirs();
			// }

			 Process proc;
			 int x;
			 File testusr=new File(home+"/"+uid);

			 if(osname.startsWith("W") || osname.startsWith("w")){
					if(testusr.isDirectory())
					{
						proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/delusr.bat "+uid+" "+home);
						x=proc.waitFor();
					}
					out.println(request.getRealPath("/")+"jspfiles/shellscripts/cuser.bat "+uid+" "+home);
					//out.println(home);
			
			}else if(osname.startsWith("L") || osname.startsWith("l")){
					if(testusr.isDirectory())
					{
						proc = rt.exec(request.getRealPath("/")+"jspfiles/shellscripts/delusr.sh "+uid+" "+home);
						x=proc.waitFor();
					}
					//out.println(request.getRealPath("/")+"jspfiles/shellscripts/cuser.sh");
					//out.println(home);
			}
			}catch(Exception e)
			{out.println(e);}

	
	reimedixlogger imxlog = new reimedixlogger(request.getRealPath("/"));
	imxlog.putLoginDetails(uid,utype,3);


	Cookie [] cookies = request.getCookies(); 

	if (cookies != null)
	{
		for (int i = 0; i < cookies.length; i++)
		{		
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			//cookies[i].setPath(gblTelemediK);
			cookies[i].setPath("/iMediXcare");
			response.addCookie(cookies[i]);
		}
	} // if
	
	

	String WebServer, redirectto;
	WebServer = request.getHeader( "host" );

	session.setAttribute("uid", null);

	//out.println (redirectto);
	//String fullPath = "http://" + request.getServerName() + ":" + request.getServerPort() + "/iMediX/index.html";
	//redirectto= "../index.html";
	redirectto= "index.jsp";
	response.sendRedirect(redirectto );

	//response.setHeader("Window-target","_top");
	//response.sendRedirect(response.encodeRedirectURL(redirectto ));
	//response.sendRedirect("'../index.html' target='_top' rel='nofollow'");

%>
</body>
</html>
