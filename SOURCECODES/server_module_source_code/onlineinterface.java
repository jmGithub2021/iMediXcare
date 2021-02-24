

package onlinegc;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;


//remote interface
public interface onlineinterface extends Remote {
	
   
   public String setUserDetalis(String uid,String pswd,String patid)throws RemoteException,SQLException ;
   
   public String getAllPatID(String uid)throws RemoteException,SQLException ;
   
   public String disconnectUser(String uid)throws RemoteException,SQLException ;
   
   public String putMessage(String postedby,String postedto,String message,String status,String patid)throws RemoteException,SQLException ;
   
   public String getMessage(String postedto)throws RemoteException,SQLException ;
   
   public String joinForConf(String postedby,String patid,String postedtos)throws RemoteException,SQLException ;
   
   public String updateConfStatus(String postedby,String patid,String confid)throws RemoteException,SQLException ;
   
   public String getOnlineDoc(String postedby,String patid)throws RemoteException,SQLException ;
   
   public String getConfUser(String patid)throws RemoteException,SQLException ;
   
   public String getImgListForApplet(String patid)throws RemoteException,SQLException ;
          
}
