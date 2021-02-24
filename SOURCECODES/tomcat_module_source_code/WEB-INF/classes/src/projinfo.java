package imedix;

import java.io.*;

public class projinfo{
	 public String gblcentercode="";
	 public String blip="";
	 public String blport="";
	 public String gblroot="";	
	 public String gblhome="";
	 public String gbltelemedix="";
	 public String gblsip="";
	 public String gbltemp="";
	 public String gblPageRow="";
	 public String gbldata="";
	 public String LargeFileSaveLayer="";
	 public String PACSServiceURL="";
	 public String PACSuid="";
	 public String PACSpass="";
	 public String PACSurl="";
	 public String PACSAcceptingIP="";
	 public String EmailURL="";
	 public String SMSURL="";
	 public String maxFileUploadLimit="";
	 public String vidServerUrl="";

	public projinfo( String path){
		setvalue(path);
	}	
	
	public void setvalue( String p)
    {   	
		String gblarray[] = new String [128];	
		int gblindex=0;
		int gblcount=0;
		String gblstr="";
		try {
			//FileInputStream gblfin = new FileInputStream(p+"/config.info");
			FileInputStream gblfin = new FileInputStream(p+"config.info");
			System.out.println("Config path:--->"+p+"config.info");
			do{
				gblindex = gblfin.read();
				if((char) gblindex != '\n') gblstr = gblstr + (char) gblindex;
				else {
					gblarray[gblcount++]=gblstr;
					gblstr="";
					}
			}while(gblindex != -1);
	   	    	
			for (gblindex=0; gblindex<gblcount; gblindex++) {
				gblstr =gblarray[gblindex].substring(gblarray[gblindex].indexOf('=')+1);
				gblarray[gblindex] = gblstr.trim();		
								
	//			System.out.println(gblarray[gblindex]);
			}
			
			int c=0;
			/* Don't Change the Order of these variables */
			gblcentercode = gblarray[c++];
			blip = gblarray[c++];
			blport = gblarray[c++];
			gblroot = gblarray[c++];
			gblhome = gblarray[c++];	
			gbltelemedix = gblarray[c++];
			gblsip = gblarray[c++];
			gbltemp = gblarray[c++];
			gblPageRow = gblarray[c++];
			gbldata = gblarray[c++];
			LargeFileSaveLayer = gblarray[c++];
			PACSServiceURL = gblarray[c++];
			PACSuid = gblarray[c++];
			PACSpass = gblarray[c++];
			PACSurl = gblarray[c++];
			EmailURL = gblarray[c++];
			SMSURL = gblarray[c++];
			maxFileUploadLimit = gblarray[c++];
			vidServerUrl = gblarray[c++];
		}
	    catch ( Exception e) {
			System.out.println("projInfo.java error:-");
	    	System.out.println(e.toString());
	    }
	    
		
	} 
	
	}
	
