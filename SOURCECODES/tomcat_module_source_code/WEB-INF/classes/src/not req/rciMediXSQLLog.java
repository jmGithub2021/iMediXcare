
package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;

public class rciMediXSQLLog{
	
	private static iMediXSQLLogInterface offSQLSrv=null;
	private Registry registry;
	projinfo proj;
	
	public rciMediXSQLLog(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   offSQLSrv= (iMediXSQLLogInterface)(registry.lookup("iMediXSQLLogOperations"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	 public String  getAllSQLsData(String patid)throws RemoteException,SQLException{
	 	return offSQLSrv.getAllSQLsData(patid);
	 }
	 
     public boolean saveAllSQLsData(String patid)throws RemoteException,SQLException{
     	
     	return true;
     }
     
     public boolean setAllDataToDb(String sqlData)throws RemoteException,SQLException{
     	
     	return true;
     }
	
}
	 
	 
	 