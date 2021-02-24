package imedixservlets;

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
import imedix.dataobj;
import imedix.rcSmsApi;
/*
CREATE TABLE `sms_logs` (
  `slno` int(11) NOT NULL AUTO_INCREMENT,
  `mobileno` varchar(25) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `result` varchar(10) DEFAULT NULL,
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`slno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/
public class SendSMS extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       PrintWriter out = response.getWriter();
       out.println("Get Method Not Supported!!");
       return;
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String mobileno="", subject="",messageToSend="";
        try {
            ImedixCrypto imx = new ImedixCrypto();
            String encParam =  request.getParameter("content");
            int numRand = Integer.parseInt( request.getParameter("numr") );
            String delim = imx.getDelim( numRand );
            String decParam =  imx.b64Dec(encParam);
            StringTokenizer st = new StringTokenizer(decParam, delim);
            int num=0;
            String dataAry[] = new String[5];
            while(st.hasMoreTokens()){
                   dataAry[num++] = (String) (st.nextElement());
            }
            // Recipient's Mobile No needs to be mentioned.
            mobileno =  dataAry[0]; //request.getParameter("recp");
            // Recipient's Mobile Message needs to be mentioned.
	        messageToSend =  imx.urldec ( dataAry[1] );
	        long millis=System.currentTimeMillis();  
            java.util.Date date=new java.util.Date(millis);
            // Recipient's Mobile Message needs to be mentioned.
            messageToSend += "\n--\niMediX IT Team\nDated: " + date.toString();   
            SmsApi sa = new SmsApi();
            String finalMsg = sa.sendSingleSMS( imx.urlenc(messageToSend) , mobileno);
			String result="";
			if (finalMsg.contains("402,")) result="Success";
			else result="Failed";
			rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
			dataobj obj = new dataobj();	
			obj.add("mobileno",mobileno);
			obj.add("message",messageToSend);
			obj.add("result",finalMsg);
			dataobj objres = (dataobj) rcsmsapi.addLog(obj);
			out.println ( (String) obj.getValue("mobileno") + " " + finalMsg);
			//out.println ( (String) obj.getValue("message") );
        } 
        catch (Exception ex) {
           out.println("Err:Durga " + ex);
           out.println("Network Error might have occured. Please try again. <a href='window.history.go(-1)'>Back</a>");
           ex.printStackTrace();
           return;
        }

    }
}