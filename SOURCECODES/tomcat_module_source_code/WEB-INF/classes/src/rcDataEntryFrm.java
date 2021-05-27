package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.io.*;
import java.util.*;

public class rcDataEntryFrm{
	
	private static DataEntryFrmInterface defserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcDataEntryFrm(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   defserver= (DataEntryFrmInterface)(registry.lookup("DataEntryFrm"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public String  InsertMed(String cod, dataobj obj)throws RemoteException,SQLException{
		return defserver.InsertMed(cod,obj);
	}
	
	 public int updateMed(dataobj obj)throws RemoteException,SQLException{
	 	return defserver.updateMed(obj);
	 }

	public int  InsertFrmAll(dataobj obj)throws RemoteException,SQLException{
		return defserver.InsertFrmAll(obj);
	}
	
	public int  InsertFrmLayers(dataobj obj)throws RemoteException,SQLException{
		return defserver.InsertFrmLayers(obj);
	}
    	
	public int  deleteRecord(String table, String Cond)throws RemoteException,SQLException{
		return defserver.deleteRecord(table,Cond);
	}
	public void  deleteAttachmentAllRecords(String pid,String type, String frmkey)throws RemoteException,SQLException{
		defserver.deleteAttachmentAllRecords(pid,type,frmkey);
	}
	
	public int  updateAttachmentAllRecords(dataobj obj)throws RemoteException, SQLException {
		System.out.println("call updateAttachmentAllRecords");
		System.out.println(obj.getAllKey());
		return defserver.updateAttachmentAllRecords(obj);
	}
	
	    
    
    public int  UploadHttp(dataobj obj,byte[] b)throws RemoteException,SQLException{
    	return defserver.UploadHttp(obj,b);
    }
    
    public String  InsertTeleMedRequest(dataobj obj)throws RemoteException,SQLException{
    	return defserver.InsertTeleMedRequest(obj);
    }
    public String  SaveTeleMedRequest(dataobj obj)throws RemoteException,SQLException{
    	return defserver.SaveTeleMedRequest(obj);
    }
    
    public String  SaveMarkImg(dataobj obj,byte[] b)throws RemoteException,SQLException{
     		return defserver.SaveMarkImg(obj,b);
     }
	
	public int setVisitDate(dataobj obj)throws RemoteException,SQLException{
		return defserver.setVisitDate(obj);
	}
	
	public String insertProblem(String pat_id, String problem, String user,String usrcnt) throws RemoteException,SQLException{
		return defserver.insertProblem(pat_id,problem,user,usrcnt);
	}
    public String deleteProblem(String pat_id,String prob_ids,dataobj obj) throws RemoteException,SQLException{
    	return defserver.deleteProblem(pat_id,prob_ids,obj);
    }
    public String problemList(String pat_id) throws RemoteException,SQLException{
    		return defserver.problemList(pat_id);
    }
    public String problemList(String pat_id, String status ) throws RemoteException,SQLException{
    	return defserver.problemList(pat_id,status);
    }
    
    public String add2TpatWaitQ(dataobj obj) throws RemoteException,SQLException {
    	return defserver.add2TpatWaitQ(obj);
    }
	
	public String delFromTpatWaitQ(dataobj obj) throws RemoteException,SQLException {
		return defserver.delFromTpatWaitQ(obj);
	}	
	
	public int moveLtoTreatedpatq(String patid)throws RemoteException,SQLException{
			return defserver.moveLtoTreatedpatq(patid);
	}
	public int moveTtoTreatedpatq(String patid)throws RemoteException,SQLException{
			return defserver.moveTtoTreatedpatq(patid);
	}
	public boolean teleTreated(String patid, String rg_no) throws RemoteException,SQLException{
			return defserver.teleTreated(patid,rg_no);
	}
	public int moveTreatedtoLpatq(dataobj obj)throws RemoteException,SQLException{
			return defserver.moveTreatedtoLpatq(obj);
	}
	public int moveTreatedtoTpatq(dataobj obj)throws RemoteException,SQLException{
			return defserver.moveTreatedtoTpatq(obj);
	}	
	public String advicedInvestigationAdd(dataobj obj) throws RemoteException,SQLException{	
			return defserver.advicedInvestigationAdd(obj);
	}
	public boolean isValidTestId(String testId) throws RemoteException, SQLException{
			return defserver.isValidTestId(testId);
	}
	public boolean updateStudyUID(String testId, String studyUID) throws RemoteException, SQLException{
			return defserver.updateStudyUID(testId,studyUID);
	}
	public String checkIntigrity(dataobj obj) throws RemoteException,SQLException{	
			return defserver.checkIntigrity(obj);
	}
	public boolean isInQueue(String pat_id) throws RemoteException,SQLException{	
			return defserver.isInQueue(pat_id);
	}
	public String getAssignDoc(String pat_id) throws RemoteException, SQLException{
			return defserver.getAssignDoc(pat_id);
	}
	public boolean isReport(dataobj obj) throws RemoteException,SQLException{
			return defserver.isReport(obj);
	}
	public boolean isNote(dataobj obj) throws RemoteException,SQLException{
			return defserver.isNote(obj);
	}	
	public boolean uploadPathologydata(File file,dataobj obj) throws RemoteException,SQLException{
			return defserver.uploadPathologydata(file, obj);
	}
	public boolean modifyTestId(String test_id,String studyUID) throws RemoteException,SQLException{
			return defserver.modifyTestId(test_id,studyUID);
	}
	public boolean requestConsultant(String pat_id, String centerid,String dept) throws RemoteException,SQLException{
		return defserver.requestConsultant(pat_id,centerid,dept);
	}
	public boolean approveConsultant(String pat_id, String doc_id, String appoinmenttime, String uid) throws RemoteException,SQLException{
		return defserver.approveConsultant(pat_id, doc_id, appoinmenttime, uid);
	}
	public boolean advicedConsultant(String pat_id, String uid) throws RemoteException,SQLException{
		return defserver.advicedConsultant(pat_id,uid);
	}
	public boolean declineConsultant(String pat_id, String uid) throws RemoteException,SQLException{
		return defserver.declineConsultant(pat_id, uid);
	}
	public boolean isRequested(String pat_id) throws RemoteException,SQLException{
		return defserver.isRequested(pat_id);
	}
	public boolean isAcceptedConsult(String pat_id) throws RemoteException,SQLException{
		return defserver.isAcceptedConsult(pat_id);
	}
	public String existPatientByOPD(String opdno) throws RemoteException, SQLException{
		return defserver.existPatientByOPD(opdno);
	}
	public String InsertMedWithoutDocAssign(String cod,dataobj obj)throws RemoteException,SQLException{
		return defserver.InsertMedWithoutDocAssign(cod,obj);
	}

	public boolean updateDepartment(int id, String field, String value) throws RemoteException, SQLException{
		return defserver.updateDepartment(id, field, value);
	}

	public boolean addDepartment(String dept_name, String ccode) throws RemoteException, SQLException{
		return defserver.addDepartment(dept_name, ccode);
	}

	public boolean deleteDepartment(int id) throws RemoteException, SQLException{
		return defserver.deleteDepartment(id);
	}

	/*Soumyajit Das*/
	public boolean updateDrug(int id, String field, String value) throws RemoteException, SQLException
	{
		return defserver.updateDrug(id,field,value);
	}
	/*Soumyajit Das*/
	public boolean addDrug(String drug_name, String ccode) throws RemoteException, SQLException
	{
		return defserver.addDrug(drug_name,ccode);
	}
	/*Soumyajit Das*/
	public boolean addMultipleDrugCSV(String drug_name[], String ccode) throws RemoteException, SQLException
	{
		return defserver.addMultipleDrugCSV(drug_name,ccode);
	}
	/*Soumyajit Das*/
	public boolean addMultipleDrug(String drug_id[], String ccode) throws RemoteException, SQLException
	{
		return defserver.addMultipleDrug(drug_id,ccode);
	}
	/*Soumyajit Das*/
	public boolean deleteDrug(int id) throws RemoteException, SQLException
	{
		return defserver.deleteDrug(id);
	}
	
	/*Soumyajit Das*/
	public boolean addIMEDIXDrug(String drug_name) throws RemoteException, SQLException
	{
		return defserver.addIMEDIXDrug(drug_name);
	}
	/*Soumyajit Das*/
	public boolean deleteIMEDIXDrug(int id) throws RemoteException, SQLException
	{
		return defserver.deleteIMEDIXDrug(id);
	}
	/*Soumyajit Das*/
	public boolean updateIMEDIXDrug(int id, String field, String value) throws RemoteException, SQLException
	{
		return defserver.updateIMEDIXDrug(id, field, value);
	}

	/*Soumyajit Das*/
	public boolean updateLoginConsent(String uid)throws RemoteException,SQLException
	{
		return defserver.updateLoginConsent(uid);
	}
	/*Soumyajit Das*/
	public Object findLoginConsent(String uid)throws RemoteException,SQLException
	{
		return defserver.findLoginConsent(uid);
	}
	/*Soumyajit Das*/
	public Object findConsentAdm()throws RemoteException,SQLException
	{
		return defserver.findConsentAdm();
	}
	/*Soumyajit Das*/
	public Object findConsentByCenter(String center)throws RemoteException,SQLException
	{
		return defserver.findConsentByCenter(center);
	}
	/*Soumyajit Das*/
	public boolean insertConsentAdm(String conid,String comments,String type,String path)throws RemoteException,SQLException
	{
		return defserver.insertConsentAdm(conid,comments,type,path);
	}
	/*Soumyajit Das*/
	public boolean consentMap(String conid,String center,String type)throws RemoteException,SQLException
	{
		return defserver.consentMap(conid,center,type);
	}
	/*Soumyajit Das*/
	public Object getSignedConsent(String uid)throws RemoteException,SQLException
	{
		return defserver.getSignedConsent(uid);
	}
	/*Soumyajit Das*/
	public boolean makeConsentLog(String uid,String conid,String center)throws RemoteException,SQLException
	{
		return defserver.makeConsentLog(uid,conid,center);
	}





	/*Soumyajit Das*/
	public boolean insertDocbanner(String rg_no,String name,String ccode,String path)throws RemoteException,SQLException
	{
		return defserver.insertDocbanner(rg_no,name,ccode,path);
	}
	/*Soumyajit Das*/
	public boolean updateDocbanner(String rg_no,String path,String avail)throws RemoteException,SQLException
	{
		return defserver.updateDocbanner(rg_no,path,avail);
	}
	/*Soumyajit Das*/
	public Object findDocbanner(String rg_no)throws RemoteException,SQLException
	{
		return defserver.findDocbanner(rg_no);
	}


	/*Soumyajit Das*/
	public String findConsultStrategy(String ccode)throws RemoteException,SQLException
	{
		return defserver.findConsultStrategy(ccode);
	}

	/*Soumyajit Das*/
	public boolean updateConsultStrategy(int val,String ccode)throws RemoteException,SQLException
	{
		return defserver.updateConsultStrategy(val,ccode);
	}

	/*Soumyajit Das*/
	public boolean existsHEXResult(String test_id)throws RemoteException,SQLException
	{
		return defserver.existsHEXResult(test_id);
	}
	/*Soumyajit Das*/
	public boolean insertHEXResult(String test_id,String test_desc,String dateTime,String result)throws RemoteException,SQLException
	{
		return defserver.insertHEXResult(test_id,test_desc,dateTime,result);
	}
	/*Soumyajit Das*/
	public String getHEXResult(String test_id)throws RemoteException,SQLException
	{
		return defserver.getHEXResult(test_id);
	}
	/*Soumyajit Das*/
	public String getServiceHex()throws RemoteException,SQLException
	{
		return defserver.getServiceHex();
	}
	

}
