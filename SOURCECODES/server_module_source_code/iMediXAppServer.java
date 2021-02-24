package imedixserver;

import java.rmi.registry.*;
import java.net.*;
import java.io.*;
import imedix.*;
import phiv.*;
import tuberculosis.*;
import logger.*;
import onlinegc.*;

//extends UnicastRemoteObject

public class iMediXAppServer {

	private int      thisPort;
    private String   thisAddress;
    private Registry registry;  

	
    //constructor
    public iMediXAppServer(){
     try{
     	
		File dir = new File("lib");
        String[] children = dir.list();
        for (int i=0; i<children.length; i++) {
        File cfile= new File(dir,children[i]);
         if (cfile.isFile()) {
              System.out.println(cfile.toString());
              ClassPathHack.addFile(cfile);
        	}
        }
        
        
	}catch(Exception e){
		
	}
       
    }
    
    private void rebindAllService(){
    	
    	projinfo pinfo=new projinfo();
    	
		thisPort=Integer.parseInt(pinfo.blport);
		try{
			thisAddress= (InetAddress.getLocalHost()).toString();
        	System.out.println("this address="+thisAddress+",port="+thisPort );
        	//create the registry and bind the name and object.
        	registry = LocateRegistry.createRegistry(thisPort);
            
        }
        catch(Exception e){
       System.out.println(e.toString());
       
        }
        
    	try{
    		//System.out.println(myDate.getCurrentDateMSSql());
    		dbGenOperations dbgop = new dbGenOperations(pinfo);
    		CentreInfo cinfo = new CentreInfo(pinfo);
    		UserInfo uinfo = new UserInfo(pinfo);
    		PatqueueInfo pqinfo = new PatqueueInfo(pinfo);
    		ItemlistInfo ilinfo = new ItemlistInfo(pinfo);
    		DataEntryFrm definfo = new DataEntryFrm(pinfo);
    		DisplayData ddinfo = new DisplayData(pinfo);
    		AdminJobs ajinfo = new AdminJobs(pinfo);
    		onlinecommunicator onlComm = new onlinecommunicator(pinfo);
			phivdataentry phivdeinfo = new phivdataentry(pinfo);
			graphsinfo graphInfo = new graphsinfo(pinfo);
			imedixstat ststInfo = new imedixstat(pinfo);
			tbOperations tbOprsSrv=new tbOperations(pinfo);
			imedixlogger imedixLog=new imedixlogger(pinfo);
			TreatedPatient treatedPatient=new TreatedPatient(pinfo);
			// sms api
			SmsApi sms = new SmsApi(pinfo);
			// video conference
			VideoConference vidconf = new VideoConference(pinfo);



			registry.rebind("GenOperation", dbgop);
			registry.rebind("CentreInfo", cinfo);
			registry.rebind("UserInfo", uinfo);
			registry.rebind("PatqueueInfo", pqinfo);
			registry.rebind("ItemlistInfo", ilinfo);
			registry.rebind("DataEntryFrm", definfo);
			registry.rebind("DisplayData", ddinfo);
			registry.rebind("AdminJobs", ajinfo);       	
			registry.rebind("OnlineCommunicator", onlComm);
			registry.rebind("PhivDataEntry", phivdeinfo);
			registry.rebind("GraphsInfo", graphInfo);
			registry.rebind("iMediXStat", ststInfo);
			registry.rebind("TBOperations", tbOprsSrv);
			registry.rebind("iMediXLogger", imedixLog);
			registry.rebind("TreatedPatient", treatedPatient);
			registry.rebind("SmsApi",sms);
			registry.rebind("VideoConference", vidconf);

        	
         }
        catch(Exception e){
        }
        System.out.println("Creating remote object");    	
    }
    
    
   //main method
   public static void main(String[]args){
		
	   try{
        	// System.out.println("Surajit: "+URL.class+"\n"+Class.forName("java.net.URLClassLoader"));

        	 iMediXAppServer obj = new iMediXAppServer();	 
        	 obj.rebindAllService();
        	 
        	 	 
    	}
    	catch (Exception e) {
           e.printStackTrace();
           System.exit(1);
    	}

}

}

