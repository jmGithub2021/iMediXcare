
/**
 * @author Saikat Ray
 **/
 
package imedix;

import java.*;
import java.io.*;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import javax.net.ssl.*;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.util.Map;
import java.security.*;

public class httpUploadDownloadFromAppl{

	private String lineEnd = "\r\n";
	private	String twoHyphens = "--";
	private	String boundary =  "**iMediX**";
	projinfo pinfo;
		
	public httpUploadDownloadFromAppl( projinfo p){
		pinfo =p;
	}

   	public void callUploadHttps(String file,String uri,String pid) {
        try {                
            UploadBufferHttpsURL(file,new URL(uri),pid);
            
        } catch (Exception ex) {
            ex.printStackTrace();
            
        }
    }
    public void callUploadHttp(String file,String uri) {
        try {
             UploadBufferHttpURL(file,new URL(uri));
        } catch (MalformedURLException ex) {
            ex.printStackTrace();
            
        }
    }
    
    public String downloadHttp(String sUrl,String formElement){
   		return sendPostHttps(sUrl,formElement);
   	}
   	public String downloadHttps(String sUrl,String formElement){
   		return sendPostHttp(sUrl,formElement);
   	}
    public String getCookieHttps(){
		ConfigureHttps();
       	String formElement="uid="+pinfo.ms_LoginID+"&pwd="+pinfo.ms_LoginPasswd+"&callby=OfflineDemain";
       	String sUrl = pinfo.ms_Proxy+ "/"+pinfo.ms_LoginUrl;
       	String cookStr="";
       	try {
       		
		  	URL url = new URL(sUrl); 
		  	HttpsURLConnection hurl = (HttpsURLConnection)url.openConnection();		  	
		  	
            System.out.println("getCookie >>>>>***sUrl : " + sUrl);          
            System.out.println("getCookie >>>>>***POSTING: " + formElement);   
            hurl.setRequestMethod("POST");  // "POST"
            hurl.setAllowUserInteraction(false); // you may not ask the user
            hurl.setDoInput(true);
            hurl.setDoOutput(true);
            hurl.setUseCaches(true);
            //hurl.setRequestProperty("User-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			OutputStream os = hurl.getOutputStream();
       		OutputStreamWriter out = new OutputStreamWriter(os);
			out.write(formElement );       	
       		out.flush();
	        out.close();
	        	     
			InputStream is = hurl.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
       		BufferedReader br = new BufferedReader(isr);
       		StringBuffer htmlReply = new StringBuffer();
       		String line = null;
       		
       		while( (line = br.readLine()) != null ){
       	 		htmlReply.append(line);
       	 		
       		} 
       	    		
     		 	String headerName=null;  
				
				for (int i=1; (headerName = hurl.getHeaderFieldKey(i))!=null; i++) {  
					if (headerName.equals("Set-cookie")|| headerName.equals("Set-Cookie")){  
						cookStr += hurl.getHeaderField(i).substring(0,hurl.getHeaderField(i).indexOf(";")+1)+" ";  
					}  
				
				}
				  
			System.out.println("\n\n"+cookStr);  
				
       		br.close();
       		isr.close();
       		is.close();
  			hurl.disconnect();
  			
		 } catch (Exception e) {
		  	System.out.println(e);
		 }
		
		return cookStr;
		 
 	}
 	public String getCookieHttp(){
		//ConfigureHttps();
       	String formElement="uid="+pinfo.ms_LoginID+"&pwd="+pinfo.ms_LoginPasswd+"&callby=OfflineDemain";
       	String sUrl = pinfo.ms_Proxy+ "/"+pinfo.ms_LoginUrl;
       	String cookStr="";
       	try {
       		
		  	URL url = new URL(sUrl); 
		  	HttpURLConnection hurl = (HttpURLConnection)url.openConnection();		  	
		  	
            System.out.println("getCookie >>>>>***sUrl : " + sUrl);          
            System.out.println("getCookie >>>>>***POSTING: " + formElement);   
            hurl.setRequestMethod("POST");  // "POST"
            hurl.setAllowUserInteraction(false); // you may not ask the user
            hurl.setDoInput(true);
            hurl.setDoOutput(true);
            hurl.setUseCaches(true);
            //hurl.setRequestProperty("User-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			OutputStream os = hurl.getOutputStream();
       		OutputStreamWriter out = new OutputStreamWriter(os);
			out.write(formElement );       	
       		out.flush();
	        out.close();
	        	     
			InputStream is = hurl.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
       		BufferedReader br = new BufferedReader(isr);
       		StringBuffer htmlReply = new StringBuffer();
       		String line = null;
       		
       		while( (line = br.readLine()) != null ){
       	 		htmlReply.append(line);
       	 		
       		} 
       		
       		//System.out.println("htmlReply : " + htmlReply +"\n\n");
       		// System.out.println("getResponseMessage : " + hurl.getResponseMessage());
       		// String cookie = hurl.getHeaderField("Set-Cookie");
       		//System.out.println("\ngetHeaderFields: " + hurl.getHeaderFields().toString());
     		//System.out.println(hurl.getResponseCode());
     		// System.out.println("\n\ncookie: " + cookie);
     		
     		 	String headerName=null;  
				
				for (int i=1; (headerName = hurl.getHeaderFieldKey(i))!=null; i++) {  
					if (headerName.equals("Set-cookie")|| headerName.equals("Set-Cookie")){  
						cookStr += hurl.getHeaderField(i).substring(0,hurl.getHeaderField(i).indexOf(";")+1)+" ";  
					}  
				
				}
				  
			System.out.println("\n\n"+cookStr);  
				
       		br.close();
       		isr.close();
       		is.close();
  			hurl.disconnect();
  			
		 } catch (Exception e) {
		  	System.out.println(e);
		 }
		
		return cookStr;
		 
 	}
 	
	private String sendPostHttps(String sUrl,String formElement){
	String oData="";
	try {
	  	URL url = new URL(sUrl); 
	  	HttpsURLConnection hurl = (HttpsURLConnection)url.openConnection();		  	
        System.out.println(">>>>>***sUrl : " + sUrl);          
        System.out.println(">>>>>***POSTING: " + formElement);   
        hurl.setRequestProperty("cookie",getCookieHttps());
        
        hurl.setRequestMethod("POST");  // "POST"
        hurl.setAllowUserInteraction(false); // you may not ask the user
        hurl.setDoInput(true);
        hurl.setDoOutput(true);
        hurl.setUseCaches(false);
   
   		OutputStream os = hurl.getOutputStream();
   		OutputStreamWriter out = new OutputStreamWriter(os);
		out.write( formElement );       	
   		out.flush();
        out.close();	     
		InputStream is = hurl.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
   		BufferedReader br = new BufferedReader(isr);
   		StringBuffer htmlReply = new StringBuffer();
   		String line = null;
   		while( (line = br.readLine()) != null ){
   	 		htmlReply.append(line);
   		} 
   			
   		oData=htmlReply.toString();
   		
   		br.close();
   		isr.close();
   		is.close();
   		
   		hurl.disconnect();
	 }
	 catch (Exception e) {
	  	System.out.println(e);
	  	oData="Error!!";
	 }
	 return oData;
}

	private String sendPostHttp(String sUrl,String formElement){
	String oData="";
	try {
	  	URL url = new URL(sUrl); 
	  	HttpURLConnection hurl = (HttpURLConnection)url.openConnection();		  	
        System.out.println(">>>>>***sUrl : " + sUrl);          
        System.out.println(">>>>>***POSTING: " + formElement);   
        hurl.setRequestProperty("cookie",getCookieHttp());
        
        hurl.setRequestMethod("POST");  // "POST"
        hurl.setAllowUserInteraction(false); // you may not ask the user
        hurl.setDoInput(true);
        hurl.setDoOutput(true);
        hurl.setUseCaches(false);
   
   		OutputStream os = hurl.getOutputStream();
   		OutputStreamWriter out = new OutputStreamWriter(os);
		out.write( formElement );       	
   		out.flush();
        out.close();	     
		InputStream is = hurl.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
   		BufferedReader br = new BufferedReader(isr);
   		StringBuffer htmlReply = new StringBuffer();
   		String line = null;
   		while( (line = br.readLine()) != null ){
   	 		htmlReply.append(line);
   		} 
   			
   		oData=htmlReply.toString();
   		
   		br.close();
   		isr.close();
   		is.close();
   		
   		hurl.disconnect();
	 }
	 catch (Exception e) {
	  	System.out.println(e);
	  	oData="Error!!";
	 }
	 return oData;
	 
}
 		
	/////////////////////////////////////////////////////////////////////////
    //////// HTTP Upload ..................................
    /////////////////////////////////////////////////////////////////////////
    
	//------------- Private Functions --------------------------------------
	
	
	private void ConfigureHttps() {
		// Create a trust manager that does not validate certificate chains
    	TrustManager[] trustAllCerts = new TrustManager[]{
        	new X509TrustManager() {
	            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
	                return null;
	            }
	            public void checkClientTrusted(
	                java.security.cert.X509Certificate[] certs, String authType) {
	            }
	            public void checkServerTrusted(
	                java.security.cert.X509Certificate[] certs, String authType) {
	            }
        	}
    	};
    
	    // Install the all-trusting trust manager
	    try {
	        SSLContext sc = SSLContext.getInstance("SSL");
	        sc.init(null, trustAllCerts, new java.security.SecureRandom());
	        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
	    } catch (Exception e) {
	    }
	    
	     try {
	        HostnameVerifier hv = new HostnameVerifier() {
			    public boolean verify(String urlHostName, SSLSession session) {
			        System.out.println("Warning: URL Host: "+urlHostName+" vs. "+session.getPeerHost());
			        return true;
			    }
			};
			
		 HttpsURLConnection.setDefaultHostnameVerifier(hv);
			
	    } catch (Exception e) {
	    }
	}

    
	private String UploadBufferHttpsURL(String file, URL url,String pid) {
		String ans="Done";
		ConfigureHttps();
      	HttpsURLConnection conn = null;
   		BufferedReader br = null;
		DataOutputStream dos = null;
		DataInputStream inStream = null;
		InputStream is = null;
		OutputStream os = null;
		int bytesRead, bytesAvailable, bufferSize;
  		byte[] buffer;
  		int maxBufferSize = 1*1024*1024;
  	  	
  	  	try{
   			//------------------ CLIENT REQUEST
	   		FileInputStream fileInputStream = new FileInputStream( new File(file));
      		// Open a HTTP connection to the URL
   			conn = (HttpsURLConnection) url.openConnection();
		   	// Allow Inputs
		   	conn.setDoInput(true);
		   	// Allow Outputs
		   	conn.setDoOutput(true);
		   	// Don't use a cached copy.
		   	conn.setUseCaches(false);
		   	// Use a post method.
		   	conn.setRequestMethod("POST");
		   	
		    conn.setRequestProperty("cookie",getCookieHttps());
		   	
   			conn.setRequestProperty("Connection", "Keep-Alive");
 			conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary);
   			dos = new DataOutputStream( conn.getOutputStream() );
   			
   			dos.writeBytes(twoHyphens + boundary + lineEnd);
   			dos.writeBytes("Content-Disposition: form-data; name=\"action\"" + lineEnd);
   			dos.writeBytes(lineEnd);
   			dos.writeBytes("put");
   			dos.writeBytes(lineEnd);
   			
   			dos.writeBytes(twoHyphens + boundary + lineEnd);
   			dos.writeBytes("Content-Disposition: form-data; name=\"patid\"" + lineEnd);
   			dos.writeBytes(lineEnd);
   			dos.writeBytes(pid);
   			dos.writeBytes(lineEnd);
   			
   			dos.writeBytes(twoHyphens + boundary + lineEnd);
   			dos.writeBytes("Content-Disposition: form-data; name=\"upload\";" + " filename=\"" + file +"\"" + lineEnd);
   			dos.writeBytes(lineEnd);
   			
			// create a buffer of maximum size
			bytesAvailable = fileInputStream.available();
			bufferSize = Math.min(bytesAvailable, maxBufferSize);
			buffer = new byte[bufferSize];
			// read file and write it into form...
   			bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			while (bytesRead > 0)
			{
				dos.write(buffer, 0, bufferSize);
				bytesAvailable = fileInputStream.available();
				bufferSize = Math.min(bytesAvailable, maxBufferSize);
				bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			}

		   // send multipart form data necesssary after file data...
		   
		   dos.writeBytes(lineEnd);
		   dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);
		   // close streams
		   fileInputStream.close();
		   dos.flush();
		   dos.close();
				 
		}catch (MalformedURLException ex){
			System.out.println("MalformedURLException:"+ex);
			ans="Exception";
		} catch (IOException ioe){
   			System.out.println("IOException:"+ioe);
   			ans=" Exception ";
  		}
		
		
		
  //------------------ read the SERVER RESPONSE
		
		try
		{
			
			inStream = new DataInputStream ( conn.getInputStream() );
			String str;
			while (( str = inStream.readLine()) != null)
			{
				System.out.println("Server response is: "+str);
				ans=str;
			}
			inStream.close();
			
			Map mp = conn.getHeaderFields();
		
			System.out.println("getResponseMessage >> "+conn.getResponseMessage());
			System.out.println("getHeaderFields >> "+mp.toString());
		
			conn.disconnect();
			
		}catch (IOException ioex){
			System.out.println("( ServerResponse Error): "+ioex);
			ans="Exception ";
		}
				
		System.out.println("Server response is >> "+ans);
		return ans;  	
  }
    
  	private String UploadBufferHttpsURL(String file, byte[] byteObj, URL url) {
		String ans="Done";
		ConfigureHttps();
      	HttpsURLConnection conn = null;
   		BufferedReader br = null;
		DataOutputStream dos = null;
		DataInputStream inStream = null;
		InputStream is = null;
		OutputStream os = null;
		
  	  	try{
   			//------------------ CLIENT REQUEST
	   		// Open a HTTP connection to the URL
   			conn = (HttpsURLConnection) url.openConnection();
		   	// Allow Inputs
		   	conn.setDoInput(true);
		   	// Allow Outputs
		   	conn.setDoOutput(true);
		   	// Don't use a cached copy.
		   	conn.setUseCaches(false);
		   	// Use a post method.
		   	conn.setRequestMethod("POST");
   			conn.setRequestProperty("Connection", "Keep-Alive");
 			conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary);
   			dos = new DataOutputStream( conn.getOutputStream() );
   			dos.writeBytes(twoHyphens + boundary + lineEnd);
   			dos.writeBytes("Content-Disposition: form-data; name=\"upload\";" + " filename=\"" + file +"\"" + lineEnd);
   			dos.writeBytes(lineEnd);
			// Writr byte data
			dos.write(byteObj);
		    // send multipart form data necesssary after file data...
		    dos.writeBytes(lineEnd);
		    dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);
		    // close streams
		    dos.flush();
		    dos.close();	 
		}catch (MalformedURLException ex){
			System.out.println("MalformedURLException:"+ex);
			ans="Error";
		} catch (IOException ioe){
   			System.out.println("IOException:"+ioe);
   			ans="Error";
  		}
  		
  		//------------------ read the SERVER RESPONSE
  	
		try
		{
			inStream = new DataInputStream ( conn.getInputStream() );
			String str;
			while (( str = inStream.readLine()) != null)
			{
			System.out.println("Server response is: "+str);
			ans=str;
			}
			inStream.close();
			conn.disconnect();
			
		}catch (IOException ioex){
			System.out.println("(ServerResponse Error): "+ioex);
			ans="Error";
		}
		
		System.out.println("Server response is >> "+ans);
		return ans;  	
  }
    
    private String UploadBufferHttpURL(String file, URL url) {
		String ans="Done";
		ConfigureHttps();
      	HttpURLConnection conn = null;
   		BufferedReader br = null;
		DataOutputStream dos = null;
		DataInputStream inStream = null;
		InputStream is = null;
		OutputStream os = null;
		int bytesRead, bytesAvailable, bufferSize;
  		byte[] buffer;
  		int maxBufferSize = 1*1024*1024;
  	  	
  	  	try{
   			//------------------ CLIENT REQUEST
	   		FileInputStream fileInputStream = new FileInputStream( new File(file));
      		// Open a HTTP connection to the URL
   			conn = (HttpURLConnection) url.openConnection();
		   	// Allow Inputs
		   	conn.setDoInput(true);
		   	// Allow Outputs
		   	conn.setDoOutput(true);
		   	// Don't use a cached copy.
		   	conn.setUseCaches(false);
		   	// Use a post method.
		   	conn.setRequestMethod("POST");
		   	conn.setRequestProperty("cookie",getCookieHttp());
   			conn.setRequestProperty("Connection", "Keep-Alive");
 			conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary);
   			dos = new DataOutputStream( conn.getOutputStream() );
   			dos.writeBytes(twoHyphens + boundary + lineEnd);
   			dos.writeBytes("Content-Disposition: form-data; name=\"upload\";" + " filename=\"" + file +"\"" + lineEnd);
   			dos.writeBytes(lineEnd);
   			
			// create a buffer of maximum size
			bytesAvailable = fileInputStream.available();
			bufferSize = Math.min(bytesAvailable, maxBufferSize);
			buffer = new byte[bufferSize];
			// read file and write it into form...
   			bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			while (bytesRead > 0)
			{
				dos.write(buffer, 0, bufferSize);
				bytesAvailable = fileInputStream.available();
				bufferSize = Math.min(bytesAvailable, maxBufferSize);
				bytesRead = fileInputStream.read(buffer, 0, bufferSize);
			}

		   // send multipart form data necesssary after file data...
		   
		   dos.writeBytes(lineEnd);
		   dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);
		   // close streams
		   fileInputStream.close();
		   dos.flush();
		   dos.close();
				 
		}catch (MalformedURLException ex){
			System.out.println("MalformedURLException:"+ex);
			ans="Error";
		} catch (IOException ioe){
   			System.out.println("IOException:"+ioe);
   			ans="Error";
  		}
  //------------------ read the SERVER RESPONSE
		
		try
		{
			
			inStream = new DataInputStream ( conn.getInputStream() );
			String str;
			while (( str = inStream.readLine()) != null)
			{
				System.out.println("Server response is: "+str);
				ans=str;
			}
			inStream.close();
			
			conn.disconnect();
			
		}catch (IOException ioex){
			System.out.println("(ServerResponse Error): "+ioex);
			ans="Error";
		}
		
		System.out.println("Server response is >> "+ans);
		return ans;  	
  }
  
    private String UploadBufferHttpURL(String file, byte[] byteObj, URL url) {
	String ans="Done";
	//ConfigureHttps();
  	HttpURLConnection conn = null;
	BufferedReader br = null;
	DataOutputStream dos = null;
	DataInputStream inStream = null;
	InputStream is = null;
	OutputStream os = null;
	
  	try{
		//------------------ CLIENT REQUEST
   		// Open a HTTP connection to the URL
		conn = (HttpURLConnection) url.openConnection();
	   	// Allow Inputs
	   	conn.setDoInput(true);
	   	// Allow Outputs
	   	conn.setDoOutput(true);
	   	// Don't use a cached copy.
	   	conn.setUseCaches(false);
	   	// Use a post method.
	   	conn.setRequestMethod("POST");
	   	conn.setRequestProperty("cookie",getCookieHttp());
		conn.setRequestProperty("Connection", "Keep-Alive");
		conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary);
		dos = new DataOutputStream( conn.getOutputStream() );
		dos.writeBytes(twoHyphens + boundary + lineEnd);
		dos.writeBytes("Content-Disposition: form-data; name=\"upload\";" + " filename=\"" + file +"\"" + lineEnd);
		dos.writeBytes(lineEnd);
		// Writr byte data
		dos.write(byteObj);
	    // send multipart form data necesssary after file data...
	    dos.writeBytes(lineEnd);
	    dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);
	    // close streams
	    dos.flush();
	    dos.close();	 
	}catch (MalformedURLException ex){
		System.out.println("MalformedURLException:"+ex);
		ans="Imedix Exception";
	} catch (IOException ioe){
		System.out.println("IOException:"+ioe);
		ans=" Imedix Exception";
	}
	
	//------------------ read the SERVER RESPONSE

	try
	{
		inStream = new DataInputStream ( conn.getInputStream() );
		String str;
		while (( str = inStream.readLine()) != null)
		{
			System.out.println("Server response is: "+str);
			ans=str;
		}
		inStream.close();
		conn.disconnect();
		
	}catch (IOException ioex){
		System.out.println("(ServerResponse Error): "+ioex);
		ans="Imedix Exception";
	}
	
	System.out.println("Server response is >> "+ans);
	return ans;  	
  }
}
