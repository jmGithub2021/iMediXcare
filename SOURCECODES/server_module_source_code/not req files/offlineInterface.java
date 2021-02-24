package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface

public interface offlineInterface extends Remote {
	 	 
     public byte[] downloadLog(String ccode)throws RemoteException,SQLException;
     public String uploadLog(byte[] sqlData)throws RemoteException,SQLException;
          	             
}


   