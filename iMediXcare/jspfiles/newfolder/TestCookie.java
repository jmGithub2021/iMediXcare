import netscape.javascript.*;
import java.awt.*;
import java.awt.event.*;
import java.applet.*;

/*
* <APPLET CODE=TestCookie.class MAYSCRIPT HEIGHT=150 WIDTH=200>
* </APPLET>
*/

public class TestCookie extends Applet implements ActionListener {
  TextField tf1, tf2;
  Button b1, b2, b3;

  public void init() {
    tf1 = new TextField(20);
    tf2 = new TextField(20);
    
    b1 = new Button("Write Cookie");
    b2 = new Button("Read Cookie");
    b3 = new Button("Delete Coookie");
    
    setLayout(new FlowLayout());
    add(tf1);
    add(tf2);
    add(b1);
    add(b2);
    add(b3);
    
    b1.addActionListener(this);
    b2.addActionListener(this);
    b3.addActionListener(this);
    }
    
  public void actionPerformed(ActionEvent ae) {
    if (ae.getSource() == b1) {
       /*  
       **  write a cookie
       **    computes the expiration date, good for 1 month
       */
       java.util.Calendar c = java.util.Calendar.getInstance();
       c.add(java.util.Calendar.MONTH, 1);
       String expires = "; expires=" + c.getTime().toString();

       String s1 = tf1.getText() + expires; 
       System.out.println(s1);
        
       JSObject myBrowser = JSObject.getWindow(this);
       JSObject myDocument =  (JSObject) myBrowser.getMember("document");
    
       myDocument.setMember("cookie", s1);
       }

    if (ae.getSource() == b2) {
       /*
       **   read a cookie
       */
       tf2.setText(getCookie());
       }

    if (ae.getSource() == b3) {
       /*
       **  delete a cookie, set the expiration in the past
       */
       java.util.Calendar c = java.util.Calendar.getInstance();
       c.add(java.util.Calendar.MONTH, -1);
       String expires = "; expires=" + c.getTime().toString();

       String s1 = tf1.getText() + expires; 
       JSObject myBrowser = JSObject.getWindow(this);
       JSObject myDocument =  (JSObject) myBrowser.getMember("document");
       myDocument.setMember("cookie", s1);
       }
    }

    public String getCookie() {
      /*
      ** get all cookies for a document
      */
      try {
        JSObject myBrowser = (JSObject) JSObject.getWindow(this);
        JSObject myDocument =  (JSObject) myBrowser.getMember("document");
        String myCookie = (String)myDocument.getMember("cookie");
        if (myCookie.length() > 0) 
           return myCookie;
        }
      catch (Exception e){
        e.printStackTrace();
        }
      return "?";
      }

     public String getCookie(String name) {
       /*
       ** get a specific cookie by its name, parse the cookie.
       **    not used in this Applet but can be useful
       */
       String myCookie = getCookie();
       String search = name + "=";
       if (myCookie.length() > 0) {
          int offset = myCookie.indexOf(search);
          if (offset != -1) {
             offset += search.length();
             int end = myCookie.indexOf(";", offset);
             if (end == -1) end = myCookie.length();
             return myCookie.substring(offset,end);
             }
          else 
            System.out.println("Did not find cookie: "+name);
          }
        return "";
        }
}