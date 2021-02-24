package imedix;


import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.net.Proxy;
import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import javax.net.ssl.*;
import java.util.*;
import java.net.InetAddress; 
import java.net.InetSocketAddress; 
import java.net.UnknownHostException; 
/*
	SMS sms = new SMS("somePath");
	sms.Send()*/
public class SMS {
	static String path;
	private static String  proxyIP,proxyPort,strErr;
	private static int useProxy;
	private static boolean Status;
	public SMS(String path0) { 
		path=path0;
		try {
			URL aURL = getClass().getClassLoader().getResource("mail.properties");
			System.out.println("proj aURL: "+aURL);
			InputStream inputStream = (InputStream)aURL.openStream();
			Properties properties = new Properties();  
			properties.load(inputStream);
			useProxy = Integer.parseInt(properties.getProperty("useProxy"));  
			proxyIP = properties.getProperty("proxyIP");
			proxyPort = properties.getProperty("proxyPort");
			Status = true;
			strErr = "OK";
		}
		catch (Exception e) {
			Status = false;
			strErr = e.toString();
		}
	}
	
	public static String Send(String mobileno, String mesg)  {
		String lineOut="" ;
		try {
			projinfo pj = new projinfo(path);			
			ImedixCrypto imx = new ImedixCrypto();
			String url = pj.SMSURL + "/servlet/SendSMS";
			
			int numRand = imx.getRandomBetween(0,6);
			String delim = imx.getDelim( numRand );
			String param = "" + mobileno + delim + imx.urlenc(mesg) + delim + "";
			String contentTOPost = "numr="+Integer.toString(numRand)+"&content="+ imx.b64Enc(param)+"";
			lineOut = pushMessage(contentTOPost, url);
			return lineOut;
		}catch(Exception e){
			lineOut = e.toString() ;
			return lineOut;
		}
	}
	
	private static String pushMessage(String contentTOPost, String url) {
		String lineOut="";
		try {
			URL urlObj = new URL(url);
			HttpsURLConnection httpCon ;
			if (useProxy==1) {
				Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(proxyIP, Integer.parseInt(proxyPort)));
				httpCon = (HttpsURLConnection) urlObj.openConnection(proxy);
			}
			else  httpCon = (HttpsURLConnection) urlObj.openConnection();

			TrustManager[] trustAllCerts = new TrustManager[] { 
				new X509TrustManager()
				{
				public java.security.cert.X509Certificate[] getAcceptedIssuers() { return null; }
				public void checkClientTrusted (java.security.cert.X509Certificate[] certs, String authType) {}
				public void checkServerTrusted( java.security.cert.X509Certificate[] certs, String authType){}
				} 
			};

			SSLContext sc = SSLContext.getInstance("TLSv1.2");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			httpCon.setSSLSocketFactory(sc.getSocketFactory());
			HostnameVerifier allHostsValid = new HostnameVerifier() {
				public boolean verify(String hostname, SSLSession session) {return true;}
			};

			//add request header
			httpCon.setRequestMethod("POST");
			httpCon.setRequestProperty("User-Agent", "irrelevant");
			httpCon.setHostnameVerifier(allHostsValid);
			httpCon.setDoOutput(true);
			httpCon.setDoInput(true);

			// Send post request
			DataOutputStream wr = new DataOutputStream(httpCon.getOutputStream());
			wr.writeBytes(contentTOPost);
			wr.flush();
			wr.close();	

			// Read response
			BufferedReader in = new BufferedReader(new InputStreamReader(httpCon.getInputStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				lineOut += inputLine;
			}
			in.close();
			return lineOut;
		}catch(Exception e){
			lineOut = e.toString() ;
			return lineOut;
		}
	}
	
}
