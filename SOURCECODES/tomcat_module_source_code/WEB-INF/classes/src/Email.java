package imedix;
//iMediX_IN

import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import javax.net.ssl.*;

/*
	Email em = new Email("somePath");
	em.Send()*/
public class Email {
	static String path;
	public Email(String path0) { path=path0;}
	
	public static String SendWA(String emailid, String subject, String mesg, String filename) {
		
		String lineOut="";
		try {
			projinfo pj = new projinfo(path);			
			ImedixCrypto imx = new ImedixCrypto();
			String url = pj.EmailURL + "/servlet/SendEmailWA";
			
			int numRand = imx.getRandomBetween(0,6);
			String delim = imx.getDelim( numRand );
			String param = "" + emailid + delim + subject + delim + imx.urlenc(mesg) + delim + filename + delim + "";
			String contentTOPost = "numr="+Integer.toString(numRand)+"&content="+ imx.b64Enc(param)+"";
			lineOut = pushMessage(contentTOPost, url);
			return lineOut;
		}catch(Exception e){
			lineOut = e.toString() ;
			return lineOut;
		}
	}
	
	public static String Send(String emailid, String subject, String mesg)  {
		String lineOut="" ;
		try {
			projinfo pj = new projinfo(path);			
			ImedixCrypto imx = new ImedixCrypto();
			String url = pj.EmailURL + "/servlet/SendEmail";
			
			int numRand = imx.getRandomBetween(0,6);
			String delim = imx.getDelim( numRand );
			String param = ""+emailid+ delim +subject+ delim + imx.urlenc(mesg) + delim + "";
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
			HttpsURLConnection httpCon = (HttpsURLConnection) urlObj.openConnection();
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