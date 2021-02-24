// @author Surajit Kundu 05.11.2015
<%@ include file="..//includes/chkcook.jsp" %>
<%@page import="imedix.cook,imedix.myDate,java.util.*,java.io.*,java.awt.*,java.net.URL,java.net.URLConnection,javax.net.ssl.*,java.net.HttpURLConnection,java.io.InputStreamReader,java.io.DataOutputStream,java.io.BufferedReader,java.net.HttpURLConnection"%>
<%
cook cookx = new cook();
String pid = cookx.getCookieValue("patid", request.getCookies()); 
String ftype=request.getParameter("ftype");
String desc=request.getParameter("desc");
//out.println(ftype+desc);
String lname = request.getParameter("lname");
if(lname==null) lname = cookx.getCookieValue("centername", request.getCookies()); 
String doc_name = request.getParameter("docName");
if(doc_name==null) doc_name = cookx.getCookieValue("userid", request.getCookies()); 
String cdate=myDate.getCurrentDate("dmy",false);

String currdate=myDate.getCurrentDate("ymd",true);
String fname=request.getParameter("ext");
String ext=fname.substring(fname.lastIndexOf(".")); //1
String ext1=ext.substring(1);
String UPLOAD_DIRECTORY = request.getRealPath("/data/"+pid+"/");
//String oFileName=pid+cdate+"new"+ext;
//String nFileName=pid+cdate+ftype+"new"+ext;
String url = request.getScheme()+"://" + request.getServerName() + ":" + request.getServerPort();
url =url+"/iMediXcare/"+"servlet/largefileupload";


//out.println("pid : "+pid+" ftype : "+ftype+" desc : "+desc+" lname : "+lname+" doc_name : "+doc_name+" cdate : "+cdate+" currdate : "+currdate+"ext : "+ext+"  ext1 : "+ext1+" UPLOAD-DIRECTORY : "+UPLOAD_DIRECTORY+"URL : "+url);

/*File oldFile=new File(UPLOAD_DIRECTORY+"/"+oFileName);
File newFile=new File(UPLOAD_DIRECTORY+"/"+nFileName);
oldFile.renameTo(newFile);*/
String urlParameters = pid+"&"+ftype+"&"+desc+"&"+lname+"&"+doc_name+"&"+currdate+"&"+cdate+"&"+ext1;

/*
try{		
		out.println(url);
		
		
		URL obj = new URL(url);  
		URLConnection connection = obj.openConnection();
		String urlParameters = pid+"&"+ftype+"&"+desc+"&"+lname+"&"+doc_name+"&"+currdate+"&"+cdate+"&"+ext+"&"+ext1;
	
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
	
				out.println(httpCon.toString());
				
				 //Send post request
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
				//	out.println(httpCon.toString());
				
				 //Send post request
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
out.println("Loading......");
response.sendRedirect("../jspfiles/showlist.jsp");
		
	}
	catch(Exception e)
	{
		out.print(e.toString());
	}
*/

%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
$.post("/iMediXcare/servlet/largefileupload",{stream:"<%=urlParameters%>"})
.done(function(data){
	if(data.trim().length>1)
		window.location="../jspfiles/showlist.jsp";
	else
		alert("Can not Uplaod");
	});
});
</script>
