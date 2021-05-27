package imedix;
  
import java.rmi.*;
import java.sql.*;
import java.io.*;
import java.util.*;
/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Interface used for Manage Data Entry Operations of iMediX System.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see DataEntryFrm
 */
 
//remote interface
public interface DataEntryFrmInterface extends Remote {
	 
	//method used to Add a record
	
	/**
 	* Method used to Insert new Med Form (New Patient Registration).<br>
 	* This method call from jspfiles/savemed.jsp files of presentation layer. 
 	* 
 	* @param  cod	Center Code.
 	* @param  obj	Object (dataobj) with all values.
 	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	* @see        	dataobj
 	*/
     public String  InsertMed(String cod, dataobj obj)throws RemoteException,SQLException ;
     
     //method used to Update a record
     
    /**
 	* Method used to update Med Form (Patient Registration).<br>
 	* This method call from jspfiles/saveeditmed.jsp file of presentation layer. 
 	* 
 	* @param  obj	Object (dataobj) with all values.
 	* @return    	'1' for successfully done or '0' for Error.
 	* @see        	dataobj
 	*/
     public int  updateMed(dataobj obj)throws RemoteException,SQLException ;
     
    //method used to Add a record
    
    /**
 	* Method used to Insert without Layers Forms of iMediX System.<br>
 	* This method call from jspfiles/savefrm.jsp file of presentation layer. 
 	* 
  	* @param  obj	Object (dataobj) with all values.
 	* @return    	'1' for successfully done or '0' for Error.
 	* @see        	dataobj
 	*/
    public int  InsertFrmAll(dataobj obj)throws RemoteException,SQLException ;
    
    //method used to Add a record
    
    /**
 	* Method used to Insert with Layers Forms of iMediX System.<br>
 	* This method call from jspfiles/middle_sub.jsp file of presentation layer. 
 	* 
  	* @param  obj	Object (dataobj) with all values.
 	* @return    	'1' for successfully done or '0' for Error.
 	* @see        	dataobj
 	*/
 	
    public int  InsertFrmLayers(dataobj obj)throws RemoteException,SQLException ;
     
     //method used to Delete a record
     
    /**
    * Unused Method on our system. Method used to Delete Records
 	* 
  	* @param  table	Table Name.
  	* @param  Cond	Condition. Where Cluse of SQL
 	* @return    	'1' for successfully done or '0' for Error.
 	*/
    public int  deleteRecord(String table, String Cond )throws RemoteException, SQLException ;
    
    //
    
    /**
    * Method used to Delete attachment records of a form or Unmapped records <br>
 	* This method call from forms/delimages.jsp file of presentation layer. 
  	* @param  pid		Patient ID.
  	* @param  type		Type of from (Form Code)
  	* @param  frmkey	"-1" for Unmapped images or form Serial No.
 	*/
 	
    public void  deleteAttachmentAllRecords(String pid,String type, String frmkey)throws RemoteException, SQLException ;
    
    /**
    * Method used to map uploaded (attachment) records with a form records.
 	* 
  	* @param  obj	Object (dataobj) with all values.
  	* @return    	'1' for successfully done or '0' for Error.
 	*/
    public int  updateAttachmentAllRecords(dataobj obj)throws RemoteException, SQLException ;
     
    /**
    * Method used to upload image,document,movie etc of Patients.
 	* 
  	* @param  obj	Object (dataobj) with all values.
  	* @param  b		Byte array of image,document,movie etc.
  	* @return    	'1' for successfully done or '0' for Error.
 	*/
    public int  UploadHttp(dataobj obj,byte[] b)throws RemoteException,SQLException;
    
    /**
    * Method used for Teleconsultation Request of patint with another hospital.
 	* 
  	* @param  obj	Object (dataobj) with all required values.
   	* @return    	Referred Hospital name for successfully done or Error for Exception.
 	*/
    public String  InsertTeleMedRequest(dataobj obj)throws RemoteException,SQLException;
    
    /**
    * Method used for Teleconsultation Request of patint with another hospital.
 	* 
  	* @param  obj	Object (dataobj) with all required values.
   	* @return    	Referred Hospital name for successfully done or Error for Exception.
 	*/
 	
    public String  SaveTeleMedRequest(dataobj obj)throws RemoteException,SQLException;
    
    /**
    * Method used to Save Marking images of Patients.
 	* 
  	* @param  obj	Object (dataobj) with all values.
  	* @param  b		Byte array of image.
  	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	*/
    public String  SaveMarkImg(dataobj obj,byte[] b)throws RemoteException,SQLException;
    
    /**
    * Method used Set Patient Visit.
 	* 
  	* @param  obj	Object (dataobj) with all values.
   	* @return    	'1' for successfully done or '0' for Error.
 	*/
    public int setVisitDate(dataobj obj)throws RemoteException,SQLException;
    
    /**
    * Method used to insert patient Problem.
 	* 
 	* @param  pat_id 	Patient ID.
 	* @param  problem 	Problem description
  	* @param  user 		User ID
  	* @param  usrcnt 	User center code
   	* @return    		"Done" for successfully Execute or "Error" for Exception.
 	*/
    public String insertProblem(String pat_id, String problem, String user,String usrcnt) throws RemoteException,SQLException;
    
    /**
    * Method used to insert patient Problem.
 	* 
 	* @param  pat_id 	Patient ID.
 	* @param  prob_ids 	Serial No of records.
  	* @param  obj		Object (dataobj) with require values.
   	* @return    		"Done" for successfully Execute or "Error" for Exception.
 	*/
    public String deleteProblem(String pat_id,String prob_ids,dataobj obj) throws RemoteException,SQLException;
    
    /**
    * Method used to get all problem list of a patient.
 	* 
 	* @param  pat_id 	Patient ID.
   	* @return    		HTML String.
 	*/
 	
    public String problemList(String pat_id) throws RemoteException,SQLException;
    
  /**
  * Method used to get all problem list of a patient.
 	* 
 	* @param  pat_id 	Patient ID.
 	* @param  status 	status of records.
  * @return    		HTML String.
 	*/
 	
    public String problemList(String pat_id, String status ) throws RemoteException,SQLException;

/**
  * Method used to add a patient to TelePatWaitQ.
  * 
  * @param  obj Object (dataobj) with all values.
  * @return HTML String.
  */
  
    public String add2TpatWaitQ(dataobj obj) throws RemoteException,SQLException;

/**
  * Method used to remove a patient from TelePatWaitQ.
  * 
  * @param  obj Object (dataobj) with all values.
  * @return HTML String.
  */
  
    public String delFromTpatWaitQ(dataobj obj) throws RemoteException,SQLException;
/**
 * Method used to move patient lpatq to treated lpatq.
 * @return 0/1
 */
public int moveLtoTreatedpatq(String patid)throws RemoteException,SQLException ;
/**
 * Method used to move patient tpatq to treated tpatq.
 * @return 0/1
 */
public int moveTtoTreatedpatq(String patid)throws RemoteException,SQLException ;

public boolean teleTreated(String patid, String rg_no) throws RemoteException,SQLException;
public int moveTreatedtoLpatq(dataobj obj)throws RemoteException,SQLException;
public int moveTreatedtoTpatq(dataobj obj)throws RemoteException,SQLException;  
public String advicedInvestigationAdd(dataobj obj) throws RemoteException,SQLException;  
public boolean isValidTestId(String testId) throws RemoteException, SQLException;
public boolean updateStudyUID(String testId, String studyUID) throws RemoteException, SQLException;
public String checkIntigrity(dataobj obj) throws RemoteException, SQLException;
public boolean isInQueue(String pat_id) throws RemoteException, SQLException;
public String getAssignDoc(String pat_id) throws RemoteException, SQLException;
public boolean isReport(dataobj obj) throws RemoteException,SQLException;
public boolean isNote(dataobj obj) throws RemoteException,SQLException;
public boolean uploadPathologydata(File file,dataobj obj) throws RemoteException,SQLException;
public boolean modifyTestId(String test_id,String studyUID) throws RemoteException,SQLException;
public boolean requestConsultant(String pat_id, String centerid,String dept) throws RemoteException,SQLException;
public boolean approveConsultant(String pat_id, String doc_id, String appoinmenttime, String uid) throws RemoteException,SQLException;
public boolean advicedConsultant(String pat_id, String uid) throws RemoteException,SQLException;
public boolean declineConsultant(String pat_id, String uid) throws RemoteException,SQLException;
public boolean isRequested(String pat_id) throws RemoteException,SQLException;
public boolean isAcceptedConsult(String pat_id) throws RemoteException,SQLException;
public String existPatientByOPD(String opdno) throws RemoteException, SQLException;
public String InsertMedWithoutDocAssign(String cod,dataobj obj)throws RemoteException,SQLException;

public boolean updateDepartment(int id, String field, String value) throws RemoteException, SQLException;
public boolean addDepartment(String dept_name, String ccode) throws RemoteException, SQLException;
public boolean deleteDepartment(int id) throws RemoteException, SQLException;

/*Soumyajit Das*/
public boolean updateDrug(int id, String field, String value) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean addDrug(String drug_name, String ccode) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean addMultipleDrugCSV(String drug_name[], String ccode) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean addMultipleDrug(String drug_id[], String ccode) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean deleteDrug(int id) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean addIMEDIXDrug(String drug_name) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean deleteIMEDIXDrug(int id) throws RemoteException, SQLException;
/*Soumyajit Das*/
public boolean updateIMEDIXDrug(int id, String field, String value) throws RemoteException, SQLException;


/*Soumyajit Das*/
public boolean updateLoginConsent(String uid)throws RemoteException,SQLException;
/*Soumyajit Das*/
public Object findLoginConsent(String uid)throws RemoteException,SQLException;
/*Soumyajit Das*/
public Object findConsentAdm()throws RemoteException,SQLException;
/*Soumyajit Das*/
public Object findConsentByCenter(String center)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean insertConsentAdm(String conid,String comments,String type,String path)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean consentMap(String conid,String center,String type)throws RemoteException,SQLException;
/*Soumyajit Das*/
public Object getSignedConsent(String uid)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean makeConsentLog(String uid,String conid,String center)throws RemoteException,SQLException;


/*Soumyajit Das*/
public boolean insertDocbanner(String rg_no,String name,String ccode,String path)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean updateDocbanner(String rg_no,String path,String avail)throws RemoteException,SQLException;
/*Soumyajit Das*/
public Object findDocbanner(String rg_no)throws RemoteException,SQLException;
/*Soumyajit Das*/
public String findConsultStrategy(String ccode)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean updateConsultStrategy(int val,String ccode)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean existsHEXResult(String test_id)throws RemoteException,SQLException;
/*Soumyajit Das*/
public boolean insertHEXResult(String test_id,String test_desc,String dateTime,String result)throws RemoteException,SQLException;
/*Soumyajit Das*/
public String getHEXResult(String test_id)throws RemoteException,SQLException;
/*Soumyajit Das*/
public String getServiceHex()throws RemoteException,SQLException;
}
