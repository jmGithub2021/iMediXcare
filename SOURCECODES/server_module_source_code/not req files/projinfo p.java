/**
 * @author Saikat Ray
 **/
 
package imedix;

import java.*;
import java.sql.*;
import java.io.*;
import java.util.Vector;
import java.util.Properties;  
import java.net.URL;

public class projinfo {
	
	 public String gblcentercode="";
	 public String gbldbjdbccriver="";
	 public String gbldburl="";
	 public String gbldbusername="";
	 public String gbldbpasswd="";
	 public String blport=""; 
	 public String tempdatadir = "";
	 public String ftphost = "";
	 public String ftpuser = "";
	 public String ftppasswd = "";
	 public String ftpdocsendpath;
	 public String ps_home="";
	 public String CenterTypeMSPS="";
	 public String SystemLogger="";
	 public String SystemLoggerPath="";
	 
	 public String GeneralSqlLog="";
	 public String GeneralSqlLogPath="";
	 
	public projinfo(){
		setvalue();
	}	
	private void setvalue()
    {   	
		    
	    try{
	    	
	    	
	    	URL aURL = getClass().getClassLoader().getResource("gblinfo.properties");
	    	
	    	System.out.println("proj aURL: "+aURL);
	    	
   			InputStream inputStream = (InputStream)aURL.openStream();

	    	//InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("gblinfo.properties");
		
		
			Properties properties = new Properties();  
			properties.load(inputStream);  
			gblcentercode = properties.getProperty("gblcentercode");  
			gbldbjdbccriver = properties.getProperty("gbldbjdbccriver");
			gbldburl = properties.getProperty("gbldburl");  
			gbldbusername = properties.getProperty("gbldbusername");  
			gbldbpasswd = properties.getProperty("gbldbpasswd");  
			blport = properties.getProperty("blport");
			tempdatadir = properties.getProperty("tempdatadir");
			ftphost = properties.getProperty("ftphost");
			ftpuser = properties.getProperty("ftpuser");
			ftppasswd = properties.getProperty("ftppasswd");
			ftpdocsendpath = properties.getProperty("ftpdocsendpath");
			ps_home = properties.getProperty("ps_home");
			CenterTypeMSPS = properties.getProperty("CenterTypeMSPS");
			SystemLogger = properties.getProperty("SystemLogger");
			SystemLoggerPath = properties.getProperty("SystemLoggerPath");
			GeneralSqlLog = properties.getProperty("GeneralSqlLog");
			GeneralSqlLogPath = properties.getProperty("GeneralSqlLogPath");
		}catch(Exception e){
			System.out.println("proj Exception: "+e.toString());
		}
		
		ptintall();
	}	
	
	private void ptintall(){
			System.out.println("blport :" + blport );
		}
}
	