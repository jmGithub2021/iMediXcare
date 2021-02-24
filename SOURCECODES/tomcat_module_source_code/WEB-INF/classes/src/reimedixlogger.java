package logger;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.io.*;
import imedix.*;


public class reimedixlogger{
	private static imedixloggerInterface logServer=null;
	private Registry registry;
	projinfo proj;
	String path;
	public reimedixlogger(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   path=p;
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   logServer= (imedixloggerInterface)(registry.lookup("iMediXLogger"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	/* 1. Success > Successful login	 2. Failure > Login Failed 	3. Logout > SESSION CLOSED 4. Unknown */
	public void putLoginDetails(String uid, String utype,int evtType)throws RemoteException,SQLException{
		logServer.putLoginDetails(uid,utype,evtType);
	}
	
	/* 1. Insert 	 2. Edit  	3. Delete  4. Unknown */
	public void putFormInformation(String uid, String utype,int evtType,dataobj keydtls,dataobj desdtls )throws RemoteException,SQLException{
		logServer.putFormInformation(uid,utype,evtType,keydtls,desdtls);
	}


	
}