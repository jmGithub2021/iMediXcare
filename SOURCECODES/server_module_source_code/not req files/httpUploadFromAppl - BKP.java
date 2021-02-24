
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


public class httpUploadFromAppl{

	
	httpUploadFromAppl(){
		
	}
   
   public void callUpload(String file,String uri) {
        try {
           // file="D:/iMediX Business Logic/server/ps_OffLineLog/BCRH0201090002.sql";
             //String uri = pinfo.ms_Proxy+"/"+ pinfo.ms_uploadService;
             System.out.print(file+"\n"+uri);             
             UploadBufferHttpsURL(file,new URL(uri));
            //UploadBufferHttpsURLAlt(file,new URL(uri));
            
        } catch (MalformedURLException ex) {
            ex.printStackTrace();
            
        }
    }
    public void callUpload(String file, byte[] ob,String uri) {
        try {
            
             //String uri = pinfo.ms_Proxy+"/"+ pinfo.ms_uploadService;
             
             UploadBufferHttps(file,new URL(uri));
            
        } catch (MalformedURLException ex) {
            ex.printStackTrace();
            
        }
    }
    
	
	/////////////////////////////////////////////////////////////////////////
    //////// HTTP Upload ..................................
    /////////////////////////////////////////////////////////////////////////
    
	//------------- Private Functions --------------------------------------
	
	
	private void setSSLTrustStore() {
		try{
		
		System.setProperty("javax.net.ssl.trustStore", "D:/iMediX Business Logic/server/imedixserver.keystore");
		System.setProperty("javax.net.ssl.trustStorePassword",  "teleadmin12");
		System.setProperty("javax.net.ssl.keyStore", "D:/iMediX Business Logic/server/imedixserver.keystore");
		System.setProperty("javax.net.ssl.keyStorePassword",  "teleadmin12");
		System.setProperty("java.protocol.handler.pkgs","com.sun.net.ssl.internal.www.protocol");
		System.setProperty("javax.net.debug","ssl,handshake");
		
		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		}catch(Exception e){
			System.out.println(e.toString());
		}
	}
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
	
	private StringBuffer boundary;
    
    private StringBuffer getRandomString() {

        StringBuffer sbRan = new StringBuffer(11);
        StringBuffer alphaNum = new StringBuffer();
        alphaNum.append("1234567890abcdefghijklmnopqrstuvwxyz");
        int num;
        for (int i = 0; i < 11; i++) {
            num = (int) (Math.random() * (alphaNum.length() - 1));
            sbRan.append(alphaNum.charAt(num));
        }
        return sbRan;
    }
    
    private void setBoundary() {
        boundary = new StringBuffer();
        boundary.append("--TeleMediKXABDC1234");
        boundary.append(getRandomString().toString());    
        //boundary.substring(2, boundary.length());
    }

     private StringBuffer[] setAllHead(File[] fileA, StringBuffer bound) {

        System.out.println("file length:" + fileA.length);
        StringBuffer[] sbArray = new StringBuffer[fileA.length];
        File file;
        StringBuffer sb;
        for (int i = 0; i < fileA.length; i++) {
            file = fileA[i];
            sbArray[i] = new StringBuffer();
            sb = sbArray[i];
            // Line 1.
            //sb.append("--");
            sb.append(bound.toString());
            sb.append("\r\n");
            // Line 2.
            sb.append("Content-Disposition: form-data; name=\"File");
            sb.append(i);
            sb.append("\"; filename=\"");
            sb.append(file.toString());
            sb.append("\"");
            sb.append("\r\n");
            // Line 3 & Empty Line 4.
            sb.append("Content-Type: application/octet-stream");
            sb.append("\r\n");
            sb.append("\r\n");
        }
        return sbArray;
    }

    private StringBuffer[] setAllTail(int fileLength, StringBuffer bound) {

        StringBuffer[] sbArray = new StringBuffer[fileLength];
        for (int i = 0; i < fileLength; i++) {
            sbArray[i] = new StringBuffer("\r\n");
        }
        // Telling the Server we have Finished.
        //sbArray[sbArray.length - 1].append("--");
        
        sbArray[sbArray.length - 1].append(bound.toString());
        sbArray[sbArray.length - 1].append("--\r\n");
        return sbArray;
    }
    
    private StringBuffer setAllHead(StringBuffer bound, String file) {
        StringBuffer sb = new StringBuffer();
        sb.append(boundary.toString());
        sb.append("\r\n");
        // Line 2.
        sb.append("Content-Disposition: form-data; name=\"File");
        sb.append("\"; filename=\"");
        sb.append(file);
        sb.append("\"");
        sb.append("\r\n");
        // Line 3 & Empty Line 4.
        sb.append("Content-Type: application/octet-stream");
        sb.append("\r\n");
        sb.append("\r\n");
        return sb;
    }
    
    private StringBuffer setAllTail(StringBuffer bound) {
        StringBuffer sbArray = new StringBuffer();
        // Telling the Server we have Finished.
        sbArray.append("\r\n");
        sbArray.append(bound.toString());
        sbArray.append("--\r\n");
        return sbArray;
    }
    
    
	private boolean UploadBufferHttpsURL(String file, URL url) {
		
      	boolean ans=false;
      	ConfigureHttps();
      	
      	HttpsURLConnection conn = null;
		BufferedReader br = null;
		DataOutputStream dos = null;
		DataInputStream inStream = null;
		
		InputStream is = null;
		OutputStream os = null;
		boolean ret = false;
		String StrMessage = "";
		String exsistingFileName = file;
		
		String lineEnd = "\r\n";
		String twoHyphens = "--";
		String boundary =  "*****";
	  	int bytesRead, bytesAvailable, bufferSize;
  		byte[] buffer;
  		int maxBufferSize = 1*1024*1024;
  		String responseFromServer = "";
	  	try{
   			//------------------ CLIENT REQUEST
	   		FileInputStream fileInputStream = new FileInputStream( new File(exsistingFileName) );
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
   			dos.writeBytes("Content-Disposition: form-data; name=\"upload\";" + " filename=\"" + exsistingFileName +"\"" + lineEnd);
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

		 ans=true;
		}catch (MalformedURLException ex){
			System.out.println("MalformedURLException:"+ex);
			ans=false;
		} catch (IOException ioe){
   			System.out.println("IOException:"+ioe);
   			ans=false;
  		}


  //------------------ read the SERVER RESPONSE
		
		
		try
		{
			inStream = new DataInputStream ( conn.getInputStream() );
			String str;
			while (( str = inStream.readLine()) != null)
			{
			System.out.println("Server response is: "+str);
			System.out.println("");
			}
			inStream.close();
			
		}catch (IOException ioex){
			System.out.println("(ServerResponse Error): "+ioex);
		}
		
		return ans;
      	
  }
      
    private boolean UploadBufferHttpsURLAlt(String file, URL url) {
		
		ConfigureHttps();
			
        boolean ans=false;
        try {
        
        File fn=new File(file);         
        InputStream fis = new FileInputStream(fn);
		byte ob[] = new byte[ (int) fn.length()];
		fis.read(ob);
		fis.close();
		String fname=fn.getName();
		
        int contentLength=1024; //TO Calculate
        setBoundary();
        
        
        StringBuffer sbufHead = setAllHead(boundary, fname);              
        StringBuffer sbufTail = setAllTail(boundary);
        StringBuffer sbuf = new StringBuffer();       
                
        contentLength=0;
        contentLength+=sbufHead.length();
        contentLength+=ob.length;
        contentLength+=sbufTail.length();
        System.out.println("contentLength :>> "+Integer.toString(contentLength));
        
     	HttpsURLConnection hurl = (HttpsURLConnection)url.openConnection();
       	
       	hurl.setRequestMethod("POST");
       	hurl.setRequestProperty("Connection", "Keep-Alive");
      	hurl.setRequestProperty("Content-type",""+ "multipart/form-data; boundary=" + boundary.substring(2,boundary.length()));
   	   	hurl.setRequestProperty("Content-length", "" + Integer.toString(contentLength));
   	   	hurl.setAllowUserInteraction(false); // you may not ask the user
     	hurl.setDoOutput(true);
    	hurl.setDoInput(true);
    	hurl.setUseCaches(false);
    	
    	DataOutputStream dataout = new DataOutputStream(new BufferedOutputStream(hurl.getOutputStream()));
	    BufferedReader datain = new BufferedReader(new InputStreamReader(hurl.getInputStream()));
	    
	    dataout.write(sbufHead.toString().getBytes());
	    dataout.write(ob);
	    dataout.write(sbufTail.toString().getBytes());    
	    
    	StringBuffer sb0 = new StringBuffer();
        sb0.append(sbufHead.toString());
        sb0.append(ob);
        sb0.append(sbufTail.toString());
	       
	    dataout.flush();
        dataout.close();
        dataout = null;
	   
	   	datain.close();
        datain = null;
        
        
        System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");
	        System.out.println(sb0.toString());
	        System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");
	
	
       
	    hurl.disconnect();
	    ans=true;
            
            
         } catch (Exception ex) {
             System.out.println(file+"\n"+url);
             System.out.println(ex.toString());
             ex.printStackTrace(System.out);
             ans=false;
        }
        return ans;
    }
	 
    
    private boolean UploadBufferHttps(String file, URL url) {

		 
		 ConfigureHttps();
		 setSSLTrustStore();
		 	
       //String cookstr=srcookiehandle.getCookie(frm);
       //System.out.println("UploadBuffer cookstr>>>>>"+cookstr);
       //hurl.setRequestProperty("cookie",cookstr);
              
        boolean ans=false;
        try {
        
        File fn=new File(file);         
        InputStream is = new FileInputStream(fn);
		byte ob[] = new byte[ (int) fn.length()];
		is.read(ob);
		is.close();
		
        int contentLength=1024; //TO Calculate
        setBoundary();
        StringBuffer sbufHead = setAllHead(boundary, file);
        StringBuffer sbufTail = setAllTail(boundary);
        StringBuffer sbuf = new StringBuffer();
        StringBuffer header = new StringBuffer();
        contentLength=0;
        contentLength+=sbufHead.length();
        contentLength+=ob.length;
        contentLength+=sbufTail.length();
        
        // Line 1. Header: Request line
        //System.out.println(ob.length);
        header.append("POST ");
        header.append(url.getPath());
        header.append("HTTP/1.0\r\n");
        //header.append("\r\n");
        // Line 2. Header: Entity
        header.append("Content-type: multipart/form-data; boundary=");
        header.append(boundary.substring(2,boundary.length()) + "\r\n");
        //header.append(boundary + "\r\n");
        //header.append(boundary + "\r\n");
        // Line 3.
        header.append("Content-length: ");
        header.append(contentLength);
        
        //header.append("\r\n");
        //cookstr.replace("\"", "\\\"");
        //header.append("Cookie: " + cookstr + "; Path=/iMediX");

        header.append("\r\n");
        // Line 4. Blank line
        header.append("\r\n");
        
        // If port not specified then use default http port 80.
        System.out.println("-------------------------------------------------");
        System.out.println(header.toString());
        System.out.println("-------------------------------------------------");
              
	     //Socket sock = new Socket(url.getHost(), (-1 == url.getPort()) ? 80 : url.getPort());
	    
	   	SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
	   	SSLSocket sock = (SSLSocket) sslsocketfactory.createSocket(url.getHost(), (-1 == url.getPort()) ? 443 : url.getPort());
        sock.setSendBufferSize(1024*1024*1024);
               
        System.out.println(url.getHost() + "isConnected : "+sock.isConnected());
        
        //sock.setSendBufferSize(10*1024*1024);
      // System.out.println("getKeepAlive()>>"+sock.getKeepAlive());
      // System.out.println("getSendBufferSize()>>"+sock.getSendBufferSize());
       
        //PrintWriter out = new PrintWriter(new BufferedOutputStream(sock.getOutputStream()));

	    DataOutputStream dataout = new DataOutputStream(new BufferedOutputStream(sock.getOutputStream()));
	    BufferedReader datain = new BufferedReader(new InputStreamReader(sock.getInputStream()));
	      
	     // out.print(header.toString().getBytes());
	     // out.print(sbufHead.toString().getBytes());
	     // out.print(ob);
	     // out.print(sbufTail.toString().getBytes());
	     
	     // String atr =new String(ob);
	      
	        dataout.write(header.toString().getBytes());
	        dataout.write(sbufHead.toString().getBytes());
	        
	        dataout.write(ob);
	        
	        //dataout.write(atr.toString().getBytes());
	        
	    //    dataout.write(sbufTail.toString().getBytes());    
	        
	        StringBuffer sb0 = new StringBuffer();
	        sb0.append(header.toString());
	        sb0.append(sbufHead.toString());
	        
//	        sb0.append(atr);
	        sb0.append(sbufTail.toString());
	        
	        System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");
	        System.out.println(sb0.toString());
	        System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");
	
	        
	        dataout.flush();
	        dataout.close();
	        dataout = null;
	        
	       // out.flush();
		   // out.close();
	       
	        datain.close();
	        datain = null;
	        sock.close();
	        sock = null;
	        ans=true;
            
            
         } catch (Exception ex) {
             	System.out.println(file+"\n"+url);
             	System.out.println(ex.toString());
             	ex.printStackTrace(System.out);
             	ans=false;
        }
        return ans;
    }
  
 
    private boolean UploadBufferHttp(String file, URL url) {

       //String cookstr=srcookiehandle.getCookie(frm);
       //System.out.println("UploadBuffer cookstr>>>>>"+cookstr);
       //hurl.setRequestProperty("cookie",cookstr);
      // setSSLTrustStore();
        
       boolean ans=false;
       
         try {
        	File fn=new File(file);         
        InputStream is = new FileInputStream(fn);
		byte ob[] = new byte[ (int) fn.length()];
		is.read(ob);
		is.close();
		
        int contentLength=1024; //TO Calculate
        setBoundary();
        StringBuffer sbufHead = setAllHead(boundary, file);
        StringBuffer sbufTail = setAllTail(boundary);
        StringBuffer sbuf = new StringBuffer();
        StringBuffer header = new StringBuffer();
        contentLength=0;
        contentLength+=sbufHead.length();
        contentLength+=ob.length;
        contentLength+=sbufTail.length();
        
        // Line 1. Header: Request line
        //System.out.println(ob.length);
        header.append("POST ");
        header.append(url.getPath());
        header.append(" HTTP/1.0\r\n");
        //header.append("\r\n");
        // Line 2. Header: Entity
        header.append("Content-type: multipart/form-data; boundary=");
        header.append(boundary.substring(2, boundary.length()) + "\r\n");
        //header.append(boundary + "\r\n");
        //header.append(boundary + "\r\n");
        // Line 3.
        header.append("Content-length: ");
        header.append(contentLength);
        
        //header.append("\r\n");
        //cookstr.replace("\"", "\\\"");
        //header.append("Cookie: " + cookstr + "; Path=/iMediX");
        
        header.append("\r\n");
        // Line 4. Blank line
        header.append("\r\n");
        // If port not specified then use default http port 80.
        System.out.println("-------------------------------------------------");
        System.out.println(header.toString());
        System.out.println("-------------------------------------------------");
                
       
            Socket sock = new Socket(url.getHost(), (-1 == url.getPort()) ? 80 : url.getPort());
            DataOutputStream dataout = new DataOutputStream(new BufferedOutputStream(sock.getOutputStream()));
            BufferedReader datain = new BufferedReader(new InputStreamReader(sock.getInputStream()));
            dataout.write(header.toString().getBytes());
            dataout.write(sbufHead.toString().getBytes());
            dataout.write(ob);
            dataout.write(sbufTail.toString().getBytes());    
            StringBuffer sb0 = new StringBuffer();
            sb0.append(header.toString());
            sb0.append(sbufHead.toString());
            sb0.append(ob);
            sb0.append(sbufTail.toString());
            System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");
            System.out.println(sb0.toString());
            System.out.println("<<<<<<<<<<>>>>>>>>>>>>>>>>>");

            System.out.println("Written :" + file);
            
            //dataout.flush();
            dataout.close();
            dataout = null;
            datain.close();
            datain = null;
            sock.close();
            sock = null;
            ans=true;
            
            
         } catch (Exception ex) {
             System.out.println(file+"\n"+url);
             ex.printStackTrace(System.out);
            ans=false;
        }
        return ans;
    }
    
}
