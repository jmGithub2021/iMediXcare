package imedix;
/**
 * @author Saikat Ray, Modified
 * 
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface
public interface imedixstatinterface extends Remote {

	public Object getGenderData(String ccode)throws RemoteException,SQLException ;
	public Object getGenderData(String ccode, String sst, String sto)throws RemoteException,SQLException ;

	public Object getDiseaseData(String ccode)throws RemoteException,SQLException ;
	public Object getDiseaseData(String ccode, String sst, String sto)throws RemoteException,SQLException ;
	
	public Object getAgeData(String ccode)throws RemoteException,SQLException ;
	public Object getAgeData(String ccode, String sst, String sto)throws RemoteException,SQLException ;

	public Object getFormData(String ccode)throws RemoteException,SQLException ;
	public Object getImageData(String ccode)throws RemoteException,SQLException ;
	public Object getImageVsPatData(String ccode)throws RemoteException,SQLException ;
	public Object getTimeCountData(String ccode)throws RemoteException,SQLException ;

	public Object getCenterData(String ccode)throws RemoteException,SQLException ;   
	public Object getCenterData(String ccode, String sst, String sto)throws RemoteException,SQLException ;   
	
	public Object getTpatQRefToData(String ccode)throws RemoteException,SQLException ;
	public Object getTpatQRefToData(String ccode, String sst, String sto)throws RemoteException,SQLException ;
	
	public Object getTpatQRefByData(String ccode)throws RemoteException,SQLException ;
	public Object getTpatQRefByData(String ccode, String sst, String sto)throws RemoteException,SQLException ;
	 
	public Object getDocPatQueueInfo(String doc_id) throws RemoteException, SQLException;
 }
