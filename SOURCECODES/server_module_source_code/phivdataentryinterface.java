package phiv;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;
import imedix.*;

//remote interface
public interface phivdataentryinterface extends Remote {

	 public Object dataforGenotype(String mutationtype)throws RemoteException,SQLException;
	 public Object dataforGeneral(String category) throws RemoteException,SQLException;
	 public Object dataforpillcount(String patid) throws RemoteException,SQLException;
	 
	 public int updatePillCount(String[][] arr,String patid,dataobj obj) throws RemoteException,SQLException;
	 
	 public Object getDrugName(int agemonth) throws RemoteException,SQLException;
	 public Object getFormulation(int drugID ) throws RemoteException,SQLException;
	 public Object getDrugDose(int armvpackageid) throws RemoteException,SQLException;
	 public String getDrugInfo(int drugID) throws RemoteException,SQLException;
	 public String getDrugList(String id) throws RemoteException,SQLException;
	 public String getFormulationList(String patid, String drugid, String id) throws RemoteException,SQLException;
	 
	 public int putPrescriptionDatainDB(String patid, String[][] data_Prescription,String ctx,String ctxdose,String duration, String edate,dataobj obj) throws RemoteException,SQLException;
     
     public String dataforDevMilestone(String category) throws RemoteException,SQLException;
     public String dataforImmunization(String patid) throws RemoteException,SQLException;
     public String getVaccineRecAge(String vacc_id) throws RemoteException,SQLException;
     public String getPatientCurrentWeight(String patid) throws RemoteException,SQLException;
     public String getCTXFormulation(String patid) throws RemoteException,SQLException;
     public String getCTXDose(String formulation_id)throws RemoteException,SQLException;
	 
	 public int putCTXDatainDB(String patid, String[][] data_Prescription,String hosname,String regno, String edate,dataobj obj) throws RemoteException,SQLException;
	
	 public String getDrugName(String patid, String drugCount, String drugType) throws RemoteException,SQLException;
     public String getDrugDoseandOtherInfo(String patid, String drugCount, String drugid,String drugType) throws RemoteException,SQLException;
     public String getRecomendedDoses(String drugid) throws RemoteException,SQLException;
     public String getDrugFormulation(String drugid) throws RemoteException,SQLException;
     public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException;
     
     public int putPHIVPrescriptiondatainDB(String patid, String[][] data_Prescription,String hosname,String regno,String edate,dataobj obj) throws RemoteException,SQLException;
     
}


