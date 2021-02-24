package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcSmsApi{
    public static SmsInterface smsserver = null;
    private Registry registry;
    projinfo proj;
    

    public rcSmsApi(String p){
        try{
           // value will be read from file;
           proj= new projinfo(p);
           
           registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
           smsserver= (SmsInterface)(registry.lookup("SmsApi"));
                         
          }catch(Exception ex){
                System.out.println(ex.getMessage());
          }
     }

	 public Object getSMSTypes() throws RemoteException, SQLException {
		return smsserver.getSMSTypes();
	 }
	 
	 public Object getSMSType(String msgid) throws RemoteException,SQLException {
		return smsserver.getSMSType(msgid);
	 }
	 public Object addSMSType(dataobj obj) throws RemoteException,SQLException {
		return smsserver.addSMSType(obj);
	 }
	 public Object updateSMSType(String msgid, dataobj obj) throws RemoteException,SQLException {
		return smsserver.updateSMSType(msgid,obj);
	 }
	 public int deleteSMSType(String msgid) throws RemoteException,SQLException {
		return smsserver.deleteSMSType(msgid);
	 }
	 public Object getMessages() throws RemoteException, SQLException {
		return smsserver.getMessages();
	 }
	 public Object addLog(dataobj obj) throws RemoteException, SQLException {
		return smsserver.addLog(obj);
	 }
	 public String makeMessage(String msgid, String[] dataAry)  throws RemoteException, SQLException {
		 return smsserver.makeMessage(msgid, dataAry);
	 }

}
