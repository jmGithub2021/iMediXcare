package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcdpStats {
	
	private static imedixstatinterface statServer=null;
	private Registry registry;
	projinfo proj;
	String path;
	
	public rcdpStats(String p){
	  try{
			// value will be read from file;
			proj= new projinfo(p);   	   
			registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
			statServer= (imedixstatinterface)(registry.lookup("iMediXStat"));
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public Object getGenderData(String ccode)throws RemoteException,SQLException { 
		return statServer.getGenderData(ccode); 
	}

	public Object getGenderData(String ccode, String sst, String sto)throws RemoteException,SQLException { 
		return statServer.getGenderData(ccode, sst, sto); 
	}

	public Object getDiseaseData(String ccode)throws RemoteException,SQLException { 
		return statServer.getDiseaseData(ccode); 
	}
	public Object getDiseaseData(String ccode, String sst, String sto)throws RemoteException,SQLException { 
		return statServer.getDiseaseData(ccode,sst,sto); 
	}	
	
	public Object getAgeData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getAgeData(ccode); 
	}
	public Object getAgeData(String ccode, String sst, String sto)throws RemoteException,SQLException  { 
		return statServer.getAgeData(ccode,sst,sto); 
	}
	
	public Object getFormData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getFormData(ccode); 
	}
	public Object getImageData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getImageData(ccode); 
	}
	public Object getImageVsPatData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getImageVsPatData(ccode); 
	}
	public Object getTimeCountData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getTimeCountData(ccode); 
	}
	
	public Object getCenterData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getCenterData(ccode); 
	}
	public Object getCenterData(String ccode, String sst, String sto)throws RemoteException,SQLException  { 
		return statServer.getCenterData(ccode,sst,sto); 
	}


	public Object getTpatQRefToData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getTpatQRefToData(ccode); 
	}
	public Object getTpatQRefToData(String ccode, String sst, String sto)throws RemoteException,SQLException  { 
		return statServer.getTpatQRefToData(ccode,sst,sto); 
	}


	public Object getTpatQRefByData(String ccode)throws RemoteException,SQLException  { 
		return statServer.getTpatQRefByData(ccode); 
	}
	public Object getTpatQRefByData(String ccode, String sst, String sto)throws RemoteException,SQLException  { 
		return statServer.getTpatQRefByData(ccode,sst,sto); 
	}


}
