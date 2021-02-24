
package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;

public class rcOfflineOperations{
	
	private static offlineInterface offAppServer=null;
	private Registry registry;
	projinfo proj;
	
	public rcOfflineOperations(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   offAppServer= (offlineInterface)(registry.lookup("OfflineLogOperations"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public byte[] downloadLog(String ccode)throws RemoteException,SQLException{
		return offAppServer.downloadLog(ccode);
	}
	
	public String uploadLog(byte[] sqldata)throws RemoteException,SQLException{
		return offAppServer.uploadLog(sqldata);
	}
	
}
	 
	 
	 