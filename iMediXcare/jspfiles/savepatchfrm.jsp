<%@page contentType="text/html" import="imedix.cook,imedix.myDate,java.util.*,java.io.*,java.awt.*,java.net.URL,javax.net.ssl.*,java.net.HttpURLConnection,java.io.InputStreamReader,java.io.DataOutputStream,java.io.BufferedReader,java.net.URLConnection,java.net.MalformedURLException,org.apache.commons.codec.binary.Base64"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
//Surajit Kundu 23.08.2015
cook cookx = new cook();
String points=request.getParameter("pont");
String par=request.getParameter("dxn");
String img_desc=request.getParameter("img_desc");
String isl=request.getParameter("isl");
String dt1=request.getParameter("dt1");
String ht=request.getParameter("ht");
String dataURL=request.getParameter("imgdata");
String col=request.getParameter("getcolor");
if (ht==null || ht=="") ht="1";
String wd=request.getParameter("wd");
if(wd==null || wd=="") wd="1";
String url =request.getParameter("loc"); //http://127.0.0.1:5050/iMediX/servlet/savepatch
String ccode = cookx.getCookieValue("center", request.getCookies()); // get the center code from cookie
String us = cookx.getCookieValue("userid", request.getCookies());
String cn=cookx.getCookieValue("centername", request.getCookies());
String doc=cookx.getCookieValue("username", request.getCookies());

//out.print("center : " +ccode+" userid : "+us+" lab name : "+cn+"doc : "+doc+ " isl : "+isl);

/*try {
Base64 decoder = new Base64(); 
byte[] imgBytes = decoder.decode(dataURL);
File file=new File(request.getRealPath("/")+"/jspfiles/anatomyimages/temp_img1/"+us+dt1+isl+".png");
FileOutputStream osf = new FileOutputStream(file);
osf.write(imgBytes);
osf.flush();
}
catch(Exception e){
out.println("log1 : "+e.toString());
}*/
//out.println(url);
try{		
		//out.println(+url);
		URL obj = new URL(url);  
		String urlParameters = points+par+img_desc+"&"+cn+"&"+doc+"&"+us+"&"+ccode+"&"+isl+"&"+dt1+"&"+ht+"&"+wd+"&"+dataURL+"&"+col;
	/*	HttpURLConnection con = (HttpURLConnection)obj.openConnection();
	
       // out.println(con.toString());

		
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
		in.close();*/
		
		
		
			URLConnection connection = obj.openConnection();
			if (connection instanceof HttpsURLConnection)
			{
				HttpsURLConnection httpCon = (HttpsURLConnection) connection;
				TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager()
				{
					public java.security.cert.X509Certificate[] getAcceptedIssuers()
					{
						return null;
					}

					public void checkClientTrusted(
						java.security.cert.X509Certificate[] certs, String authType)
					{
					}

					public void checkServerTrusted(
						java.security.cert.X509Certificate[] certs, String authType)
					{
					}
				} };

				SSLContext sc = SSLContext.getInstance("TLSv1.2");
				sc.init(null, trustAllCerts, new java.security.SecureRandom());
				httpCon.setSSLSocketFactory(sc.getSocketFactory());
				HostnameVerifier allHostsValid = new HostnameVerifier() {
					public boolean verify(String hostname, SSLSession session) {
						return true;
					}
				};
				httpCon.setHostnameVerifier(allHostsValid);
				
				httpCon.setDoOutput(true);
				httpCon.setUseCaches(false);
				DataOutputStream wr = new DataOutputStream(httpCon.getOutputStream());
				wr.writeBytes(urlParameters);
				wr.flush();
				wr.close();

				

				BufferedReader in = new BufferedReader(
						new InputStreamReader(httpCon.getInputStream()));
				String inputLine="";
				StringBuffer response1 = new StringBuffer();

				while ((inputLine = in.readLine()) != null) {
					response1.append(inputLine);
				}
				in.close();


			}
			
			else{		
				HttpURLConnection httpCon = (HttpURLConnection) obj.openConnection();
				httpCon.setDoOutput(true);
				httpCon.setUseCaches(false);
				DataOutputStream wr = new DataOutputStream(httpCon.getOutputStream());
				wr.writeBytes(urlParameters);
				wr.flush();
				wr.close();

				

				BufferedReader in = new BufferedReader(
						new InputStreamReader(httpCon.getInputStream()));
				String inputLine="";
				StringBuffer response1 = new StringBuffer();

				while ((inputLine = in.readLine()) != null) {
					response1.append(inputLine);
				}
				in.close();	
			}		
		
		

		
		//print result
		//out.print(response1.toString());
//out.println("\n["+urlParameters+"]\n....");
//out.println("Loading......"+request.getRealPath("/"));
response.sendRedirect("showlist.jsp");
		
	}
	catch(Exception e)
	{
		out.print("log : "+e.toString());
	}
%>


