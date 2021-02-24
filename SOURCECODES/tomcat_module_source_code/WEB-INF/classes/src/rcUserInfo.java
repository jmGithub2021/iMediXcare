package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcUserInfo{
	
	private static UserInfoInterface uiserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcUserInfo(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   uiserver= (UserInfoInterface)(registry.lookup("UserInfo"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
    public int  InsertRegUsers(dataobj obj,byte[] b)throws RemoteException,SQLException{
    	return uiserver.InsertRegUsers(obj,b);
    }	    

	public Object getuserinfo(String id,String ps) throws RemoteException,SQLException{
		 System.out.println(" Call getuserinfo");
		 Object res = uiserver.getuserinfo(id,ps);
 	     return res;
	}
	public Object getuserinfo(String id) throws RemoteException,SQLException{
		 System.out.println(" Call getuserinfo");
		 Object res = uiserver.getuserinfo(id);
 	     return res;
	}
	
	 public String getreg_no(String id) throws RemoteException,SQLException{
	 	return uiserver.getreg_no(id);
	 }
     
     public String getName(String regn) throws RemoteException,SQLException{
     	return uiserver.getName(regn);
     }
     
     public byte[] getSign(String regn)throws RemoteException,SQLException{
     	return uiserver.getSign(regn);
     }
      
     public Object getValues(String fld, String cond ) throws RemoteException,SQLException{
     	return uiserver.getValues(fld,cond);
     	
     }
     
     public boolean sendDoctor(String uid,String rcode) throws RemoteException,SQLException{
     	return uiserver.sendDoctor(uid,rcode);
     }
     
     public int updateUserInfo(dataobj obj) throws RemoteException,SQLException{
     	return uiserver.updateUserInfo(obj);
     }     
	 
	 public boolean updateUserStatus(String uid,String status,dataobj obj) throws RemoteException,SQLException{
	 		return uiserver.updateUserStatus(uid,status,obj);
	 }
	 
	 public int deleteUser(String uid,dataobj obj) throws RemoteException,SQLException {
	 		return uiserver.deleteUser(uid,obj);
	 }
	 
	 public Object getAllUsers(String ccode,String utyp,String ARAll) throws RemoteException,SQLException {
	 	return uiserver.getAllUsers(ccode,utyp,ARAll);
	 }
	 
	 public Object getuserinfoByrgNo(String rg_no) throws RemoteException,SQLException{
		 return uiserver.getuserinfoByrgNo(rg_no);
	 }
     
     public String getSpecialization(String docid) throws RemoteException,SQLException{
     	return uiserver.getSpecialization(docid);
     }
	 public String updateAvailability(String Adocid,String Rdocid,dataobj obj) throws RemoteException,SQLException{
	 	return uiserver.updateAvailability(Adocid,Rdocid,obj);
	 }
	 public boolean verifyPatient(String verifiedCode, String emailid) throws RemoteException, SQLException{
		return uiserver.verifyPatient(verifiedCode,emailid); 
	 }
	 public boolean convertTOSelf(String patid) throws RemoteException, SQLException{
	 	return uiserver.convertTOSelf(patid);
	 }
	 public String existEmail(String emailid) throws RemoteException, SQLException{
		 return uiserver.existEmail(emailid);
	 }
	 public String existPhone(String phone) throws RemoteException, SQLException{
		 return uiserver.existPhone(phone);
	 }
	 public String existUid(String uid) throws RemoteException, SQLException{
		 return uiserver.existUid(uid);
	 }
	 public String existRgno(String rgno) throws RemoteException, SQLException{
		 return uiserver.existRgno(rgno);
	 }
	//New Addition as on 21-April-2020
	 public Object getPatientsWithoutLogin(String key) throws RemoteException,SQLException {
		return uiserver.getPatientsWithoutLogin(key);
	 }
	 public Object getPatientData(String pat_id)throws RemoteException, SQLException{
		return uiserver.getPatientData(pat_id);
	 }
	 public int addPatientFromMed(dataobj obj) throws RemoteException, SQLException{
		return uiserver.addPatientFromMed(obj);
	 }
	 public Object getuserinfoByEmail(String emailid) throws RemoteException, SQLException{
		return uiserver.getuserinfoByEmail(emailid);
	 }
	 public Object getuserinfoByAny(String serStr) throws RemoteException, SQLException{
		return uiserver.getuserinfoByAny(serStr);
	 }
	 public int addLoginRequest(dataobj obj) throws RemoteException, SQLException{
		return uiserver.addLoginRequest(obj);
	 }
	 public Object getLoginRequestData() throws RemoteException, SQLException{
		return uiserver.getLoginRequestData();
	 }
	public Object docOfMinPat(String center, String dis) throws RemoteException, SQLException{
		return uiserver.docOfMinPat(center, dis);
	}
	public String fileUploadLimit(int dayLimit, String pat_id) throws RemoteException, SQLException{
		return uiserver.fileUploadLimit(dayLimit,pat_id);
	}
	public boolean resetPassword(String uid, String pass) throws RemoteException,SQLException{
		return uiserver.resetPassword(uid,pass);
	}
	public Object getUserOTP(String val) throws RemoteException,SQLException
	{
		return uiserver.getUserOTP(val);
	}
	public boolean deactivateAccount(String uid) throws RemoteException,SQLException
	{
		return uiserver.deactivateAccount(uid);
	}
	public boolean activateAccount(String uid) throws RemoteException,SQLException
	{
		return uiserver.activateAccount(uid);
	}
	public Object getEmailId() throws RemoteException, SQLException
	{
		return uiserver.getEmailId();
	}
	public Object getEmailId(int low, int high) throws RemoteException, SQLException
	{
		return uiserver.getEmailId(low,high);
	}
	}
