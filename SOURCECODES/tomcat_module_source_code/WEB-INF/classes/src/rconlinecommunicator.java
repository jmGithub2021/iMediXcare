
package onlinegc;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import imedix.*;

public class rconlinecommunicator{
	
	private static onlineinterface onlserver=null;
	private Registry registry;
	projinfo proj;
	
	public rconlinecommunicator(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   onlserver= (onlineinterface)(registry.lookup("OnlineCommunicator"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public String setUserDetalis(String uid,String pswd,String patid)throws RemoteException,SQLException{
		return onlserver.setUserDetalis(uid,pswd,patid);
	}
	
	public String getAllPatID(String uid)throws RemoteException,SQLException {
		return onlserver.getAllPatID(uid);
	}
		
	public String disconnectUser(String uid)throws RemoteException,SQLException{
		return onlserver.disconnectUser(uid);
	}
	
	public String putMessage(String postedby,String postedto,String message,String status,String patid)throws RemoteException,SQLException{
		String xx=onlserver.putMessage(postedby,postedto,message,status,patid);
		System.out.println(" **** putMessage >> "+xx);
		
		return xx;
	}
	
	public String getMessage(String postedto)throws RemoteException,SQLException{
		String xx=onlserver.getMessage(postedto);
		
		System.out.println(" **** getMessage >> "+xx);
		
		return xx;
	}
   
   	public String joinForConf(String postedby,String patid,String postedtos)throws RemoteException,SQLException{
   		return onlserver.joinForConf(postedby,patid,postedtos);
   	}
   
   	public String updateConfStatus(String postedby,String patid,String confid)throws RemoteException,SQLException{
   		return onlserver.updateConfStatus(postedby,patid,confid);
   	}
   
   public String getOnlineDoc(String postedby,String patid)throws RemoteException,SQLException{
   		return onlserver.getOnlineDoc(postedby,patid);
   }
   
   public String getConfUser(String patid)throws RemoteException,SQLException{
   		return onlserver.getConfUser(patid);
   }
   
   public String getImgListForApplet(String patid)throws RemoteException,SQLException{
   		return onlserver.getImgListForApplet(patid);
   }
   
     
	
	
}
	 
	 
	 