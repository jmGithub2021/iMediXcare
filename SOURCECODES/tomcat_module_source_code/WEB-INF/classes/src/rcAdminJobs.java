package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.io.*;

public class rcAdminJobs{
	
	private static AdminJobsInterface ajserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcAdminJobs(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   ajserver= (AdminJobsInterface)(registry.lookup("AdminJobs"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	 
    public Object viewRegUsers()throws RemoteException,SQLException {
		return ajserver.viewRegUsers();
    }

    //method used to active regusers
    public int  activeRegUsers(String uids,String ccode,dataobj obj)throws RemoteException,SQLException{
    	return ajserver.activeRegUsers(uids,ccode,obj);
    }
    
    public int  updatePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException{
    	return ajserver.updatePhysician(pids,drcode,obj);
    }
    
    public int  updateTelePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException{
    	return ajserver.updateTelePhysician(pids,drcode,obj);
    }
    
     //method used to Delete Patient from patq
    public int delPatient(String pids,String que,dataobj obj)throws RemoteException,SQLException{
    	return ajserver.delPatient(pids,que,obj);
    }
    
    //stdt & endt = y/m/d
    public String backupRcords(String bkptype,String pid,String ccode, String stdt, String endt)throws RemoteException,SQLException{
    		return ajserver.backupRcords(bkptype,pid,ccode,stdt,endt);
    }
    
    public String deleteBackupRcords(String pids)throws RemoteException,SQLException{
    	return ajserver.deleteBackupRcords(pids);
    }

	public int decideTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException {
		return ajserver.decideTelePatWait(paramString, paramdataobj);
	}
 	
    public String getAllBackupDirs(String backup)throws RemoteException,SQLException{
    		return ajserver.getAllBackupDirs(backup);
    }
    
    public String restoreRcords(String bkpdir)throws RemoteException,SQLException{
    		return ajserver.restoreRcords(bkpdir);
    }
    
    public Object searchPatient(String que, String searchBy,String serValue,String ccode,String usrccode)throws RemoteException,SQLException{
    		return ajserver.searchPatient(que,searchBy,serValue,ccode,usrccode);
    }
    
    //String que, String searchBy,String serValue,String ccode,String usrccode
    
    
    public Object searchPatientAddToQ(String que, String searchBy,String serValue,String ccode)throws RemoteException,SQLException{
    		return ajserver.searchPatientAddToQ(que,searchBy,serValue,ccode);
    }
    public int addToQue(String que, String pid)throws RemoteException,SQLException{
    	return ajserver.addToQue(que,pid);
    }	
    public int rejectTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException{
		return ajserver.rejectTelePatWait(paramString, paramdataobj);		
	}
	 
	public String readSytemLog(String date) throws RemoteException, FileNotFoundException, IOException{
		return ajserver.readSytemLog(date);
	}	 
		
	}
