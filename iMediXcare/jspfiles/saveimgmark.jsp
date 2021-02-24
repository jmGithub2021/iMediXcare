<%@ include file="..//includes/chkcook.jsp" %>
<%@page import="imedix.cook,imedix.myDate,java.util.*,java.io.*,java.awt.*,java.net.URL,java.net.HttpURLConnection,java.io.InputStreamReader,java.io.DataOutputStream,java.io.BufferedReader,java.net.HttpURLConnection"%>

<%
//Surajit Kundu 23.08.2015
cook cookx = new cook();
String points=request.getParameter("pont");
String par=request.getParameter("dxn");
String img_desc=request.getParameter("img_desc");
//String isl=request.getParameter("isl");
//String dt1=request.getParameter("dt1");
//String ht=request.getParameter("ht");
//String dataURL=request.getParameter("imgdata");
String col=request.getParameter("getcolor");
//if (ht==null || ht=="") ht="1";
String wd=request.getParameter("wd");
//if(wd==null || wd=="") wd="1";
String url =request.getParameter("loc"); //http://127.0.0.1:5050/iMediX/servlet/savepatch
String ccode = cookx.getCookieValue("center", request.getCookies()); // get the center code from cookie
String us = cookx.getCookieValue("userid", request.getCookies());
String cn=cookx.getCookieValue("centername", request.getCookies());
String doc=cookx.getCookieValue("username", request.getCookies());

out.println(par+"&ccode="+ccode+"&uid="+us+"&fhand="+points+"&col="+col+"&cter="+cn+"&doc="+doc);
try{		
		out.println(url);
		URL obj = new URL(url);  
		HttpURLConnection con = (HttpURLConnection)obj.openConnection();
	
        out.println(con.toString());

		//String urlParameters = points+par+img_desc+"&"+cn+"&"+doc+"&"+us+"&"+ccode+"&"+isl+"&"+dt1+"&"+ht+"&"+wd+"&"+dataURL+"&"+col;
		//String urlParameters=prms+"&ccode="+ccode+"&uid="+uid+"&line="+lin+"&circle="+cir+"&rect="+rectan+"&fhand="+fhand+"&col="+col
		String urlParameters=par+"&ccode="+ccode+"&uid="+us+"&fhand="+points+"&col="+col+"&cter="+cn+"&doc="+doc;
		// points + String par="&"+pid+"&"+fn +"&"+ edt+"&"+frmtyp+"&"+null;
		 //Send post request
		con.setDoOutput(true);
		con.setUseCaches(false);
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(urlParameters);
		wr.flush();
		wr.close();

		

		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine="";
		StringBuffer response1 = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response1.append(inputLine);
		}
		in.close();
		
		//print result
		//out.print(response1.toString());
//out.println("\n["+urlParameters+"]\n....");
//out.println("Loading......");
response.sendRedirect("showlist.jsp");
		
	}
	catch(Exception e)
	{
		e.printStackTrace(new java.io.PrintWriter(out));
		//out.println(e.toString());
		out.println("URL sk : "+url);
	}
%>


