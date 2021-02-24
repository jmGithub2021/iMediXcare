package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcCentreInfo{
	
	private static CentreInfoInterface ciserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcCentreInfo(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   ciserver= (CentreInfoInterface)(registry.lookup("CentreInfo"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public Object getLCentreInfo() throws RemoteException,SQLException{
		 System.out.println(" Call getLCentreInfo");
		 Object res = ciserver.getLCentreInfo();
 	     return res;
	}
	
	public Object getRCentreInfo(String ccode) throws RemoteException,SQLException{
		 Object res = ciserver.getRCentreInfo(ccode);
 	     return res;
	}
	
	public String getHosName(String CCode) throws RemoteException,SQLException{
		 return ciserver.getHosName(CCode);
	}
	
	public Object getAllCentreInfo()throws RemoteException,SQLException{
		System.out.println(" Call getAllCentreInfo");
		Object res = ciserver.getAllCentreInfo();
 	    return res;
 	     
	}
	public String getFirstCentreCode()throws RemoteException,SQLException{
		return ciserver.getFirstCentreCode();
	}
		
	public int editCentreInfo(dataobj obj)throws RemoteException,SQLException {
		return ciserver.editCentreInfo(obj);
	}

	public int editCentreVisibility(dataobj obj)throws RemoteException,SQLException {
		return ciserver.editCentreVisibility(obj);
	}
     
     public int deleteCentreInfo(String ccode,dataobj obj)throws RemoteException,SQLException {
     	return ciserver.deleteCentreInfo(ccode,obj);
     }
     public Object presInfoData(String id, String entrydate, String tableName) throws RemoteException,SQLException{
			return ciserver.presInfoData(id, entrydate,tableName);
	}
  	 public String getCenterCode(String id, String tableName) throws RemoteException,SQLException{
		 return ciserver.getCenterCode(id,tableName);
	 }		 
	 public boolean isValidCenter(String centerCode) throws RemoteException,SQLException{
		return ciserver.isValidCenter(centerCode);
	}
	
	}
