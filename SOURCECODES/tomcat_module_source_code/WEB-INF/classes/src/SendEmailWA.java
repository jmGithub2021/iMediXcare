package imedixservlets;
//iMediX_IN
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import imedix.ImedixCrypto;
import org.json.simple.*;
import org.json.simple.parser.*;
import java.net.URL;

public class SendEmailWA extends HttpServlet {

   
   public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
         PrintWriter out = response.getWriter();
         out.println("Get Method Not Supported!!");
         return;
      }
   
   public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

      PrintWriter out = response.getWriter();
      String recp="", subject="",messageToSend="",filename="";
      String mailRelayServer = "", mailedByUser="", mailedByUserPassword="", mailPort="", useSSL="",useAuthentication="";
      String useProxy="", proxyIP="", proxyPort="";
      Properties properties, properties2;      
      try {
    	  	URL aURL = getClass().getClassLoader().getResource("mail.properties");
	     	System.out.println("proj aURL: "+aURL);
   			InputStream inputStream = (InputStream)aURL.openStream();
			 properties = new Properties();  
			properties.load(inputStream);
			
			mailRelayServer = properties.getProperty("mailRelayServer");  
			mailedByUser = properties.getProperty("mailedByUser");  
			mailedByUserPassword = properties.getProperty("mailedByUserPassword");
         mailPort = properties.getProperty("mailPort");  
			useSSL = properties.getProperty("useSSL");  
			useAuthentication = properties.getProperty("useAuthentication");
       
         useProxy = properties.getProperty("useProxy");  
			proxyIP = properties.getProperty("proxyIP");  
         proxyPort = properties.getProperty("proxyPort");

	      ImedixCrypto imx = new ImedixCrypto();
	      String encParam =  request.getParameter("content");
		  int numRand = Integer.parseInt( request.getParameter("numr") );
		  String delim = imx.getDelim( numRand );
		  String decParam =  imx.b64Dec(encParam) ;
	
	      //out.println ("encParam: " +  encParam);
	      //out.println ("decParam: " +  decParam);
 		  
		  StringTokenizer st = new StringTokenizer(decParam, delim);
		  int num=0;
		  String dataAry[] = new String[5];
		  while(st.hasMoreTokens()){
     			dataAry[num++] = (String) (st.nextElement());
		  }
	
	      // Recipient's email ID needs to be mentioned.
	      recp =  dataAry[0]; //request.getParameter("recp");
	      // Recipient's email ID Subject needs to be mentioned.
	      subject =  dataAry[1];
	      // Recipient's email ID Subject needs to be mentioned.
	      messageToSend =  imx.urldec ( dataAry[2] );
		  filename = imx.urldec (dataAry[3]);
	      
	      long millis=System.currentTimeMillis();  
	      java.util.Date date=new java.util.Date(millis);   

	      messageToSend += "\n\n--\n\niMediX IT Team\nDated: " + date.toString();
		//out.println ("recp: " +  recp);
		//out.println ("subj: " +  subject);
		//out.println ("mesg: " +  messageToSend);
  

      } 
      catch (Exception ex) {
		out.println("Err:Durga " + ex);
		out.println("Network Error migth have occured. Please try again. <a href='window.history.go(-1)'>Back</a>");
		ex.printStackTrace();
		return;
      }

      // Sender's email ID needs to be mentioned
      String from = mailedByUser; //"telemed@cse.iitkgp.ac.in";
      // Assuming you are sending email from localhost
      String host = mailRelayServer; //"10.3.103.129";

      String senderName = from;
      String senderPassword = mailedByUserPassword; //"TeleMed@4321";

      // Get system properties
      properties2 = System.getProperties();
      // Setup mail server
      properties2.setProperty("mail.smtp.host", host);
      properties2.setProperty("mail.smtp.username", senderName);
      properties2.setProperty("mail.smtp.password", senderPassword);
      properties2.setProperty("mail.smtp.port", mailPort);
      properties2.setProperty("mail.smtp.auth", useAuthentication);
      properties2.setProperty("mail.smtp.starttls.enable", useSSL); //TLS
      if (  Integer.parseInt(useProxy)==1) {
         properties2.setProperty("mail.smtp.proxy.host", proxyIP);
         properties2.setProperty("mail.smtp.proxy.port", proxyPort); //TLS   
      }
      // Get the default Session object.
      Session session = Session.getDefaultInstance(properties2, new javax.mail.Authenticator() {
         protected PasswordAuthentication getPasswordAuthentication()
         {
           return new PasswordAuthentication(senderName, senderPassword);
         }
       });     
        // Set response content type
      response.setContentType("text/html");
      

      try {
         // Create a default MimeMessage object.
         Message message = new MimeMessage(session);
      
         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));
         
         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO, new InternetAddress(recp));
         
         // Set Subject: header field
         message.setSubject( subject );
         
         // Now set the actual message
			//message.setText( messageToSend );
			
		//Surajit eddition start	
         // Create the message part
         BodyPart messageBodyPart = new MimeBodyPart();

         // Now set the actual message
         messageBodyPart.setText(messageToSend);

         // Create a multipar message
         Multipart multipart = new MimeMultipart();

         // Set text message part
         multipart.addBodyPart(messageBodyPart);

         // Part two is attachment
         messageBodyPart = new MimeBodyPart();
         String attachment = filename; // Let the calling function send fullname
         DataSource source = new FileDataSource(attachment);
         messageBodyPart.setDataHandler(new DataHandler(source));
         messageBodyPart.setFileName(attachment);
         multipart.addBodyPart(messageBodyPart);

         // Send the complete message parts
         message.setContent(multipart);
		
		// @Surajit Eddition end	
		 
         // Send message
         Transport.send(message);
         String title = "";
         String res = "Sent message successfully....";
         
         out.println( title +  res); //+ "\n>> " + properties2.toString());
      } catch (MessagingException mex) {
 	 String title = "";
     String res = "Failed sending message! Try Again !! " + mex; // + "\n>> " + properties2.toString();
     out.println( title +  res );

      }
   }
} 
