/*
 * srcookiehandle.java
 *
 * Created on March 30, 2008, 4:40 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */


import netscape.javascript.JSObject;

public class srcookiehandle {
	
	
	public static String getCookie(offlinemarkdicom onlv3 ) {
      /*
      ** get all cookies for a document
      */
      try {
        JSObject myBrowser = (JSObject) JSObject.getWindow(onlv3);
        JSObject myDocument =  (JSObject) myBrowser.getMember("document");
        
        String myCookie = (String)myDocument.getMember("cookie");
        
        //System.out.println("--- Document Url: "+(String)myDocument.getMember("URL"));
        //myCookie += "***Document Url: "+(String)myDocument.getMember("cookie");
        
        if (myCookie.length() > 0) 
           return myCookie;
        }
      catch (Exception e){
        e.printStackTrace();
        }
      return "";
      
      }
      
      public static void writeCookie(offlinemarkdicom onlv3 , String c){
      	JSObject myBrowser = JSObject.getWindow(onlv3);
      	JSObject myDocument =  (JSObject) myBrowser.getMember("document");
        myDocument.setMember("cookie", c);
      	
      }
	
}