package tuberculosis;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;
import imedix.*;
import logger.*;

//remote interface
public interface tbOperationsInterface extends Remote {

	public Object getDrugName() throws RemoteException,SQLException;
	public String getRecomendedDoses(String drugid, String drugcount) throws RemoteException,SQLException;
	public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException;
	public String getFormulation(String drugid,String drugcount) throws RemoteException,SQLException;
	public String getPatientCurrentWeight(String patid, String distype) throws RemoteException,SQLException;
	public int putTBPrescriptiondatainDB(String patid, String[][] data_Prescription,String hosname,String regno, String edate,dataobj obj) throws RemoteException,SQLException;
	
}