package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface
public interface PatqueueInfoInterface extends Remote {
	    
	public Object getLPatqueueAdmin(String ccode, int lowOffset, int rCount )throws RemoteException,SQLException;
	public Object getLPatqueueAdminSearch(String ccode, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException;
	public Object getLPatqueueTreatedAdmin(String ccode, int lowOffset, int rCount) throws RemoteException, SQLException;
	public Object getLPatqueueDoc(String dreg, int lowOffset, int rCount ) throws RemoteException,SQLException;
	public Object getLPatqueueDocSearch(String dreg, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException;
	public Object getLpatqTreatedDoc(String dreg, int lowOffset, int rCount) throws RemoteException, SQLException;
	public Object getLPatqueueOP(String ccode, int lowOffset, int rCount ) throws RemoteException,SQLException;

	public Object getRPatqueueAdmin(String lcode,String rcode, int lowOffset, int rCount )throws RemoteException,SQLException ;
	public Object getRPatqueueTreatedAdmin(String lcode,String rcode, int lowOffset, int rCount) throws RemoteException, SQLException;	
	public Object getRPatwaitqueueAdmin(String lcode,String rcode, int lowOffset, int rCount,String status )throws RemoteException,SQLException;

	////test////
	public Object test123(String test)throws RemoteException,SQLException;

	public Object getRPatqueueDoc(String rcode, String dreg, int lowOffset, int rCount ) throws RemoteException,SQLException;
	public Object getRPatqueueTreatedDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException, SQLException;	
	public String isAvaliableInTwaitQ(String patid) throws RemoteException, SQLException;
	public Object getRPatwaitqueueDoc(String rcode, String dreg, int lowOffset, int rCount ) throws RemoteException,SQLException;
	public Object getRPatqueueOP(String lcode,String rcode, int lowOffset, int rCount ) throws RemoteException,SQLException;
	public Object getRPatrefqueueDoc(String dreg,int lowOffset, int rCount,String status) throws RemoteException, SQLException;

	//public String getTotalLPatAdmin(String ccode) throws RemoteException,SQLException;
	//public String getTotalRPatAdmin(String lcode,String rcode) throws RemoteException,SQLException;
	//public String getTotalLPatDoc(String ccode,String dreg) throws RemoteException,SQLException;
	//public String getTotalRPatDoc(String rcode,String dreg) throws RemoteException,SQLException;
	public String getTotalLPatAdmin2(String string) throws RemoteException, SQLException;
	public String getTotalLPatAdmin(String string) throws RemoteException, SQLException;
	public String getTotalLPatTreatedAdmin(String string) throws RemoteException, SQLException;
	public String getTotalRPatAdmin(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatTreatedAdmin(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatwaitAdmin(String string, String string2) throws RemoteException, SQLException;
	public String getTotalLPatDoc(String string, String string2) throws RemoteException, SQLException;
	public String getTotalLPatTreatedDoc(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatDoc(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatTreatedDoc(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatwaitDoc(String string, String string2) throws RemoteException, SQLException;
	public String getTotalRPatwaitDoc4twb(String string, String string2) throws RemoteException, SQLException;       
	public String getTotal(String tableName) throws RemoteException, SQLException;  
	public boolean updateLpatqAssignDate(String pat_id, String entrydate) throws RemoteException, SQLException; 
	public boolean updateTpatqAssignDate(String pat_id, String teleconsultdt) throws RemoteException, SQLException;
	public Object getLPatEntry(String pat_id) throws RemoteException, SQLException;
	public Object getTPatEntry(String pat_id) throws RemoteException, SQLException;
	public Object appoinmentNotSetList(String docRegNo) throws RemoteException, SQLException;
	public Object appoinmentNotSetListTpatq(String docRegNo) throws RemoteException, SQLException;
	public boolean resetAppoinmentTpatq(String patid) throws RemoteException, SQLException;
	public boolean resetAppoinmentLpatq(String patid) throws RemoteException, SQLException;
}


