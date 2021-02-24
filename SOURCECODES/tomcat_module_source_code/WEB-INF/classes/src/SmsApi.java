package imedixservlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.HttpHost;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.client.config.RequestConfig;

import imedix.ImedixCrypto;
import org.json.simple.*;
import org.json.simple.parser.*;
import java.net.URL;

import java.io.*;
import java.util.*;
import org.apache.http.conn.params.ConnRoutePNames;

/* 
   * WILL WORK ONLY FOR WBHEALTH.GOV.IN 
   * PLEASE HANDLE WITH CARE
   * SHOULD NOT MODIFY THIS UNLESS THERE IS A CHANGE
   * D Durga Prasad 
*/


public class SmsApi{
	
     public String smsUser, smsPassword, smsSender, SmsURL, smsType, strErr, proxyIP, proxyPort;
	 private boolean Status;
	 public int useProxy;
     /*
     public String  proxyIP,proxyPort;
     public int useProxy;
     */
        /**
		 * //https:///www.bulksmsgateway.in/sendmessage.php?
		 * user=technocratz&
		 * password=TechnoTC123!&
		 * message=Your TEXT MESSAGE&
		 * sender=TLHLTH&
		 * mobile=9831303340&
		 * type=3

	 * Send Single text SMS
	 * @param user : User Name
	 * @param password : Password
	 * @param message  : message
	 * @param sender   : sender
	 * @param mobile : Single Mobile Number e.g. '99XXXXXXX' 
	 * @param type : 3
	 * @return 
	 *
	 */
	public SmsApi () {

        try {

            URL aURL = getClass().getClassLoader().getResource("mail.properties");
            System.out.println("proj aURL: "+aURL);
            InputStream inputStream = (InputStream)aURL.openStream();
            Properties properties = new Properties();  
            properties.load(inputStream);

		    smsUser = properties.getProperty("smsUser");  
            smsPassword = properties.getProperty("smsPassword");
			smsSender = properties.getProperty("smsSender"); 
			//smsType = properties.getProperty("smsType");
			SmsURL = properties.getProperty("smsURL");
           /*
            useProxy = Integer.parseInt(properties.getProperty("useProxy"));  
            proxyIP = properties.getProperty("proxyIP");
            proxyPort = properties.getProperty("proxyPort");
            */
            if ( smsUser.length()==0 || smsPassword.length()==0  || smsSender.length()==0 )
            {
                Status = false;
                strErr = "[ SUR:"+smsUser+",SPW:"+smsPassword+",SSN:"+smsSender+",STP:"+smsType+"URL:"+SmsURL+"] atleast One is Empty ";
            }
            else {
                Status = true;
                strErr = "OK";
            }
        }
        catch (Exception e) {
			Status = false;
			StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
			String exceptionAsString = sw.toString();
            strErr = exceptionAsString;
        }
	}
	
	public String sendSingleSMS(String message , String mobileNumber){
		String responseString = "";
		SSLSocketFactory sf=null;
		SSLContext context=null;
        String encryptedPassword;
        if  (this.Status == false) {
            responseString = "Failed to load [mail.properties] " + strErr;
            return responseString;
        }
		try {
			//context=SSLContext.getInstance("TLSv1.1"); // Use this line for Java version 6
			context=SSLContext.getInstance("TLSv1.2"); // Use this line for Java version 7 and above
			context.init(null, null, null);
			sf=new SSLSocketFactory(context, SSLSocketFactory.STRICT_HOSTNAME_VERIFIER);
			Scheme scheme = new Scheme("https",443,sf);
            HttpClient client = new DefaultHttpClient();
			/*
            if (useProxy==1) {
                HttpHost proxy = new HttpHost(proxyIP, Integer.parseInt(proxyPort));
                RequestConfig config = RequestConfig.custom().setProxy(proxy).build();
                client.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,proxy);
                System.out.println("Going Through Proxy : " + proxy.toString());
            }
            else System.out.println("Skipping Proxy");
			*/
			client.getConnectionManager().getSchemeRegistry().register(scheme);
			//http://203.212.70.200/smpp/sendsms?username=telrad&password=telrad123&to=8336908xxx&from=TELRAD&text=<<your Approved Template>>
			String params = "username="+smsUser;
			params += "&password="+smsPassword;
			params += "&to="+mobileNumber;
			params += "&from="+smsSender;
			params += "&text="+message;			
			//params += "&type="+smsType;

			HttpGet httpGet = new HttpGet(SmsURL+"?" + params);
			HttpResponse response=client.execute(httpGet);
			BufferedReader bf=new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			String line="";
			while((line=bf.readLine())!=null){
				responseString = responseString+line;
			}
			responseString += "  " + SmsURL+"?" + params;
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (KeyManagementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return responseString;
	}

	/****
	 * Method  to convert Normal Plain Text Password to MD5 encrypted password
	 ***/
	
	private String MD5(String text) throws NoSuchAlgorithmException, UnsupportedEncodingException  
	{ 
		MessageDigest md;
		md = MessageDigest.getInstance("SHA-1");
		byte[] md5 = new byte[64];
		md.update(text.getBytes("iso-8859-1"), 0, text.length());
		md5 = md.digest();
		return convertedToHex(md5);
	}

	protected String hashGenerator(String userName, String senderId, String content, String secureKey) {
		// TODO Auto-generated method stub
		StringBuffer finalString=new StringBuffer();
		finalString.append(userName.trim()).append(senderId.trim()).append(content.trim()).append(secureKey.trim());
		String hashGen=finalString.toString();
		StringBuffer sb = null;
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-512");
			md.update(hashGen.getBytes());
			byte byteData[] = md.digest();
			//convert the byte to hex format method 1
			sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}

		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sb.toString();
	}


	private String convertedToHex(byte[] data) 
	{ 
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) { 
			int halfOfByte = (data[i] >>> 4) & 0x0F;
			int twoHalfBytes = 0;
			do { 
				if ((0 <= halfOfByte) && (halfOfByte <= 9)) {
					buf.append( (char) ('0' + halfOfByte) );
				}
				else {
					buf.append( (char) ('a' + (halfOfByte - 10)) );
				}
				halfOfByte = data[i] & 0x0F;
			} while(twoHalfBytes++ < 1);
		} 
		return buf.toString();
	}
}
