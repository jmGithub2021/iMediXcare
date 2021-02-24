
package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface
public interface iMediXSQLLogInterface extends Remote {
	 
	//method used to Add a record
	
     public String  getAllSQLsData(String patid)throws RemoteException,SQLException;
     public boolean saveAllSQLsData(String patid)throws RemoteException,SQLException;
     public boolean setAllDataToDb(String sqlData)throws RemoteException,SQLException;     
  }
     