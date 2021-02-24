package imedix;

/**
 * @author D Durga Prasad
 **/
  
import java.rmi.*;
import java.sql.*;

public interface SmsInterface extends Remote{
	public Object getSMSTypes() throws RemoteException, SQLException;
	public Object getSMSType(String msgid) throws RemoteException,SQLException;
	public Object addSMSType(dataobj obj) throws RemoteException,SQLException;
	public Object updateSMSType(String msgid, dataobj obj) throws RemoteException,SQLException;
	public int deleteSMSType(String msgid) throws RemoteException,SQLException;
	public Object getMessages() throws RemoteException, SQLException;
	public Object addLog(dataobj obj) throws RemoteException, SQLException;
	public String makeMessage(String msgid, String[] dataAry)  throws RemoteException, SQLException;
}
