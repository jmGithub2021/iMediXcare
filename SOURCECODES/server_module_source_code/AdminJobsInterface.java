 package imedix;  
 
import java.rmi.*;
import java.sql.*;
import java.io.*;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Interface used for Manage Administrative jobs.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see AdminJobs
 */
 
 
//remote interface
public interface AdminJobsInterface extends Remote {
	
	/**
 	* Method used to view all pending users for Registration. 
 	* @return    	Vector with dataobj Objects. dataobj holds data of each records.
 	* @see        	dataobj
 	* @see        	data
 	*/
    public Object viewRegUsers()throws RemoteException,SQLException ;
       
    /**
 	* Method used to activate pending users.  
 	*
 	* @param  uids	User ids with # Separator
 	* @param  ccode	center code 
 	* @param  obj	Object (dataobj) with session user information
 	* @return    	1 for successfully done or 0 for Error.
 	* @see        	dataobj
 	*/
    public int  activeRegUsers(String uids,String ccode,dataobj obj)throws RemoteException,SQLException ;
    
    /**
 	* Method used to Update Physician of Local Patient(s).  
 	*
 	* @param  pids		Patient ids with # Separator
 	* @param  drcode	Assigned doctor regn no.
 	* @param  obj		Object (dataobj) with session user information.
 	* @return    		1 for successfully done or 0 for Error.
 	* @see        		dataobj
 	*/
    public int  updatePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException ;
    
    /**
 	* Method used to Update Physician of Tele Patient(s).  
 	*
 	* @param  pids		Patient ids with # Separator
 	* @param  drcode	Assigned doctor regn no.
 	* @param  obj		Object (dataobj) with session user information.
 	* @return    		1 for successfully done or 0 for Error.
 	* @see        		dataobj
 	*/
    public int updateTelePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException;
    
    /**
 	* Method used to Delete Patient from Patient Queue.  
 	*
 	* @param  pids		Patient ids with # Separator
 	* @param  que		'Local' for delete Local patient or 'Tele' for delete Remote Patient. 
 	* @param  obj		Object (dataobj) with session user information.
 	* @return    		'1' for successfully done or '0' for Error.
 	* @see        		dataobj
 	*/
    public int delPatient(String pids,String que,dataobj obj)throws RemoteException,SQLException ;
        
	/**
 	* Method used to Delete Patient from Tele Patient Wait Queue.  
 	*
 	* @param  paramString		Patient ids with # Separator
 	* @param  paramdataobj		'Local' for delete Local patient or 'Tele' for delete Remote Patient. 
 	* @return    				'1' for successfully done or '0' for Error.
 	* @see        				dataobj
 	*/        
     public int decideTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException ;    
    /**
 	* Method used for Bcakup the records .  
 	*
 	* @param  bkptype	bydate for Date wise or bypat for Patient wise.
 	* @param  pid		Patient ID Pattern. 
 	* @param  ccode		Center Code.
 	* @param  stdt		Starting Date.(Date Format y/m/d).
 	* @param  endt		Ending Date. (Date Format y/m/d)
 	* @return    		HTML String with Details.
 	*/	
    public String backupRcords(String bkptype,String pid,String ccode, String stdt, String endt)throws RemoteException,SQLException;
    
        
    /**
 	* Method used to get All Backup Directory.  
 	*
 	* @param  backup	Path of the bakup folder.
 	*/
    public String getAllBackupDirs(String backup )throws RemoteException,SQLException;
    
    
    /**
 	* Method used to Unknown.  
 	*
 	* @param  var1	Unknown.
 	*/
    public String deleteBackupRcords(String var1) throws RemoteException, SQLException;

    
    
    /**
 	* Method used to restore data to database from a Backup Directory.  
 	*
 	* @param  bkpdir	path of a bakup Directory.
 	* @return    		HTML String with Details.
 	*/
    public String restoreRcords(String bkpdir)throws RemoteException,SQLException;
    
    /**
 	* Method used to Search Patient(s).  
 	*
 	* @param  que			'Local' for search Local patient or 'Tele' for search Tele Patient.
 	* @param  searchBy		values: id,name,class & date 
 	*						<ul>
 	*						<li> id : Patient ID Pattern.
 	*						<li> name : Patient Name
 	*						<li> class : Disease Type
 	*						<li> date : patient Registration Date.
 	*						</ul>
 	* @param  serValue		Serching Value as par searchBy.
 	* @param  ccode			Center Code.
 	* @param  usrccode		User Center Code.
 	* @return    			Vector with dataobj Objects. dataobj holds data of each records.
 	* @see        	dataobj
 	* @see        	data
 	*/
    public Object searchPatient(String que, String searchBy,String serValue,String ccode,String usrccode)throws RemoteException,SQLException;
    
    /**
 	* Unused Method on our system.  
 	*/
    public Object searchPatientAddToQ(String que, String searchBy,String serValue,String ccode)throws RemoteException,SQLException;
        
    /**
 	* Method used to Add Deleted patient to patient queue.  
 	*
 	* @param  que			'Local' for  Local patient or 'Tele' for  Tele Patient.
 	* @param  pid			Patient ID.
 	* @return    			1 for successfully done or 0 for Error.
 	*/
    public int addToQue(String que, String pid)throws RemoteException,SQLException;
        
    public int rejectTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException;
    
	public String readSytemLog(String date) throws RemoteException, FileNotFoundException, IOException;	
}
