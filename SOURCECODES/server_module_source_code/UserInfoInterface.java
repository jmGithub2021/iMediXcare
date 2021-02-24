package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface

public interface UserInfoInterface extends Remote {
	 
	 //method used to Add a record into login table
     public int  InsertRegUsers(dataobj obj,byte[] b)throws RemoteException,SQLException ;
    
     public Object getuserinfo(String id,String ps)throws RemoteException,SQLException ;
     
     public Object getuserinfo(String id)throws RemoteException,SQLException ;
     
	 public Object getuserinfoByrgNo(String rg_no) throws RemoteException,SQLException;
	 
     public String getreg_no(String id) throws RemoteException,SQLException;
     
     public String getName(String regn) throws RemoteException,SQLException;
     
     public byte[] getSign(String regn)throws RemoteException,SQLException;
     
     public Object getValues(String fld, String cond ) throws RemoteException,SQLException;
     
     public boolean sendDoctor(String uid,String rcode) throws RemoteException,SQLException;
     
     public int updateUserInfo(dataobj obj) throws RemoteException,SQLException;
     
     public boolean updateUserStatus(String uid, String status,dataobj obj) throws RemoteException,SQLException;
     
     public int deleteUser(String uid,dataobj obj) throws RemoteException,SQLException ;
     
     public Object getAllUsers(String ccode,String utyp,String ARAll) throws RemoteException,SQLException ;
     
     public String getSpecialization(String docid) throws RemoteException,SQLException ;
     
     public String updateAvailability(String Adocid,String Rdocid,dataobj obj) throws RemoteException,SQLException ;
 
     public boolean verifyPatient(String verifiedCode, String emailid) throws RemoteException, SQLException;

     public boolean convertTOSelf(String patid) throws RemoteException, SQLException;

     public String existEmail(String emailid) throws RemoteException, SQLException;
	 public String existPhone(String phone) throws RemoteException, SQLException;
	 public String existUid(String uid) throws RemoteException, SQLException;
     public String existRgno(String rgno) throws RemoteException, SQLException;
	 
     public Object getPatientsWithoutLogin(String key) throws RemoteException, SQLException;
     public Object getPatientData(String pat_id)throws RemoteException, SQLException;
     public int addPatientFromMed(dataobj obj) throws RemoteException, SQLException;
	 public Object getuserinfoByEmail(String emailid) throws RemoteException,SQLException;
	 public Object getuserinfoByAny(String serStr) throws RemoteException,SQLException;
	 public int addLoginRequest(dataobj obj) throws RemoteException, SQLException;
     public Object getLoginRequestData()throws RemoteException, SQLException;
	 public Object docOfMinPat(String center, String dis) throws RemoteException, SQLException;
	 public String fileUploadLimit(int dayLimit, String pat_id) throws RemoteException, SQLException;
      public boolean resetPassword(String uid, String pass) throws RemoteException,SQLException;
     /*Soumyajit Das*/
     public Object getUserOTP(String val) throws RemoteException,SQLException;
     /*Soumyajit Das*/
     public boolean deactivateAccount(String uid) throws RemoteException,SQLException;
     /*Soumyajit Das*/
	public boolean activateAccount(String uid) throws RemoteException,SQLException;
	//SK
	public Object getEmailId() throws RemoteException, SQLException;
	//SK
	public Object getEmailId(int low, int high) throws RemoteException, SQLException;
}


   
