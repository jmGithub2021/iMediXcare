package imedix;

import javax.servlet.http.*;
import java.net.*;

public class cook{
	
	String gbltelemedix="/iMediXcare";
	//String gbltelemedix="/";
	PACSEncryption encDec = new PACSEncryption("");
	projinfo pinfo=new projinfo("");
	String key = pinfo.PACSpass;
	public cook(String str){
		gbltelemedix=str;
	}
	
	public cook(){
		
	}
	
	public void addCookie(String name, String value, HttpServletResponse response)
	{
			
			String encName = "",encValue="";
			try{
			encName = encDec.PACSEncryptionString(name,key);
			encValue = encDec.PACSEncryptionString(value,key);
		}catch(Exception ex){}
			Cookie cook1 = new Cookie(name,encValue);
			cook1.setPath(gbltelemedix);
			response.addCookie(cook1);
			
	}
	public void addCookieSpl(String name, String value, HttpServletResponse response)
	{
			
			String encName = "",encValue="";
			try{
			encName = encDec.PACSEncryptionString(name,key);
			encValue = encDec.PACSEncryptionString(value,key);
			Cookie cook1 = new Cookie(name,URLEncoder.encode(encValue, "UTF-8"));
			cook1.setPath(gbltelemedix);
			response.addCookie(cook1);
			}catch(Exception ex){}
			
	}
		
	public void delCookie(String name, Cookie[] cookies, HttpServletResponse response)
	{
			if (cookies != null)
			{
				for (int i = 0; i < cookies.length; i++)
				{
					if (cookies[i].getName().equalsIgnoreCase(name)) {
						cookies[i].setValue(null);
						cookies[i].setMaxAge(0);
						cookies[i].setPath(gbltelemedix);
						response.addCookie(cookies[i]);
						break;
					}
				}
			} 
	}
	
	public void setValues(String nam, String val, Cookie[] cookies , HttpServletResponse response) 
	{
		if (cookies != null)
			for (int i = 0; i < cookies.length; i++)
				if ( cookies[i].getName().equalsIgnoreCase(nam)){
					try{
					 cookies[i].setValue(encDec.PACSEncryptionString(val,key)); 
					}catch(Exception ex){}
					 break;
				}			
	}
	
	public String getCookieValue(String name, Cookie[] cookies)
	{
		String str="";
		try{
			for (int i=0; i< cookies.length; i++) {
			if (cookies[i].getName().equals(name)) {
				try{
			    str = encDec.PACSDecryptionString(cookies[i].getValue(),key);
				}catch(Exception ex){}
				break;
			}
		}
		}catch(Exception e){
			str="";
		}
		
		return str;
	}

	public String getCookieValueSpl(String name, Cookie[] cookies)
	{
		String str="";
		try{
			for (int i=0; i< cookies.length; i++) {
			if (cookies[i].getName().equals(name)) {
				try{
			    str = encDec.PACSDecryptionString(URLDecoder.decode(cookies[i].getValue(), "UTF-8"),key);
				}catch(Exception ex){}
				break;
			}
		}
		}catch(Exception e){
			str="";
		}
		
		return str;
	}	

	public void delAllCookies(Cookie[] cookies , HttpServletResponse response) 
	{
		if (cookies != null)
		{
			for (int i = 0; i < cookies.length; i++)
			{
				//System.out.println(cookies[i].getName());
				cookies[i].setValue(null);
				//cookies[i].setValue("");
				cookies[i].setMaxAge(0);
				cookies[i].setPath(gbltelemedix);
				response.addCookie(cookies[i]);
				
			}
		} 
	}
				
}
