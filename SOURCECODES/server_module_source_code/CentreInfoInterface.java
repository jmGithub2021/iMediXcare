package imedix;
  
import java.rmi.*;
import java.sql.*;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Interface used to Manage Centres of the System.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see CentreInfo
 */
 
//remote interface
public interface CentreInfoInterface extends Remote {
	 
	/**
 	* Method used to get Local Center Informations.  
 	* @return    	Vector with dataobj Objects. dataobj holds data of each records. 
 	*				Value of each fields are stored as data object.
 	* @see        	dataobj
 	* @see        	data
 	*/
     public Object getLCentreInfo()throws RemoteException,SQLException ;
     
    /**
 	* Method used to get Remote Center Informations.  
 	*
 	*@param  CCode	Center Code.
 	*@return    	Vector with dataobj Object. dataobj holds data of each records.
 	* @see        	dataobj
 	*/
     public Object getRCentreInfo(String CCode)throws RemoteException,
        SQLException ;
     
    /**
 	* Method used to get Center Name.  
 	*
 	*@param  CCode	Center Code.
 	*@return    	Center Name.
 	*/ 
     public String getHosName(String CCode)throws RemoteException,SQLException ;
     
    /**
 	* Method used to get All Center Informations.  
 	*
 	*@return    	Object (dataobj) with available Data.
 	*@see        	dataobj
 	*/
     public Object getAllCentreInfo()throws RemoteException,SQLException;
     
     /**
 	* Method used, to get First Center Code ordered by code.  
 	*
 	*@param  CCode	Center Code.
 	*@return    	Center Code.
 	* @see        	dataobj
 	*/
     public String getFirstCentreCode()throws RemoteException,SQLException;
     
    /**
 	* Unused Method on our system.  
 	*/
     public int seveCentreInfo(dataobj obj)throws RemoteException,SQLException ;
     
     /**
 	* Method used, to Edit Center Informations.
 	*
 	*@param  obj	Object (dataobj) with all values.
 	*@return    	1 for successfully done or 0 for Error
 	* @see        	dataobj
 	*/
     public int editCentreInfo(dataobj obj)throws RemoteException,SQLException ;
    
	/**
 	* Method used, to Edit Center Informations.
 	* Added by Durga @22Dec2016
 	*@param  obj	Object (dataobj) with all values.
 	*@return    	1 for successfully done or 0 for Error
 	* @see        	dataobj
 	*/ 
     public int editCentreVisibility(dataobj obj)throws RemoteException,SQLException ;

     /**
 	* Method used, to Delete Center Informations.
 	*
 	*@param  ccode	Center Code.
 	*@param  obj	Object (dataobj) with all values.
 	*@return    	1 for successfully done or 0 for Error
 	* @see        	dataobj
 	*/
     public int deleteCentreInfo(String ccode,dataobj obj)throws RemoteException,SQLException ;
	 	/**
 	* Method used, to get center code.
 	* Added by Surajit @01May2018
 	*@param  id tableName (patient id, med table) or (user reg. no, login table) 	
 	*@return    	center code
 	* @see        	dataobj
 	*/ 
	 public String getCenterCode(String id, String tableName) throws RemoteException,SQLException;
	 /**
	  * Method used, to get prescrption related information of patient.
	  * 
	  * @param id Patient Id. and pre||prs
	  * @return Assigned doctor name, department, center, OPD no, No of visit
	  */
	 public Object presInfoData(String id, String entrydate, String tableName) throws RemoteException,SQLException;
	 	/**
 	* Method used, to check given center code is valid or not
 	* Added by Surajit @03May2018
 	*@param  centerCode 	
 	*@return    	boolean
 	*/ 	 
	 public boolean isValidCenter(String centerCode) throws RemoteException,SQLException;
                
}
