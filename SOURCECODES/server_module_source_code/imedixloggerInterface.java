package logger;
/**
 * @author Saikat Ray
 **/
 
import java.rmi.*;
import java.sql.*;
import imedix.*;

//remote interface
public interface imedixloggerInterface extends Remote {
	
	/* 1. Success > Successful login	 2. Failure > Login Failed 	3. Logout > SESSION CLOSED 4. Unknown */
	public void putLoginDetails(String uid, String utype,int evtType)throws RemoteException,SQLException;
	
	/* 1. Insert 	 2. Edit  	3. Delete  4. Unknown */
	public void putFormInformation(String uid, String utype,int evtType,dataobj keydtls,dataobj desdtls )throws RemoteException,SQLException;

}
