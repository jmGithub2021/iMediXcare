package imedix;
/**
 * @author Surajit Kundu
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface
public interface TreatedPatientInterface extends Remote {
public Object getLpatqTreated(String ccode,String utype,int min,int max)throws RemoteException,SQLException;
public Object getTpatqTreated(String ccode,String utype,int min,int max)throws RemoteException,SQLException;
public int moveLtoTreatedpatq(String cod, String patid)throws RemoteException,SQLException ;
public int moveTtoTreatedpatq(String cod, String patid)throws RemoteException,SQLException ;
}
