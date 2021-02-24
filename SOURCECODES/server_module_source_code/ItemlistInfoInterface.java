package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;
import java.util.HashMap;

//remote interface
public interface ItemlistInfoInterface extends Remote {
	    
     public Object getListOfForms(String id,String p)throws RemoteException,SQLException ;
     public Object getListOfPrs(String id)throws RemoteException,SQLException ;
     public Object getListOfTsr(String id)throws RemoteException,SQLException ;

     public Object getListOfImages(String id) throws RemoteException,SQLException;
     public Object getListOfImagesDtl(String id,String type, String dt1,String dt2) throws 
     RemoteException,SQLException;
     
     public Object getListOfVectors(String id) throws RemoteException,SQLException;
     public Object getListOfVectorsDtl(String id) throws RemoteException,SQLException;
     
     public Object getListOfDicoms(String id ) throws RemoteException,SQLException;
     public Object getListOfDicomsDtl(String id, String dt1,String dt2) throws RemoteException,
     SQLException;
     
     public Object getListOfDocuments(String id) throws RemoteException,SQLException;
     public Object getListOfDocumentsDtl(String id,String type, String dt1,String dt2) throws 
     RemoteException,SQLException;
     
     public Object getListOfMovies(String id) throws RemoteException,SQLException;
     public Object getListOfMoviesDtl(String id,String dt1,String dt2) throws RemoteException,
     SQLException;
     
     /////////
     public Object getVisitWiseInfo(String id) throws RemoteException,SQLException;
     public String getFormsList(String id,String dt1, String dt2) throws RemoteException,SQLException;
     public String getImagesList(String id,String dt1, String dt2) throws RemoteException,SQLException;
     public String getDicomList(String id,String dt1, String dt2) throws RemoteException,SQLException;
     public String getDocList(String id,String dt1, String dt2) throws RemoteException,SQLException;
     public String getMoviesList(String id,String dt1, String dt2) throws RemoteException,SQLException;
     ////////
     public Object getRadiologyCount(String id) throws RemoteException,SQLException;
     public Object getRadiologyInfo(String id, String radiotype) throws RemoteException,SQLException;
     
    public String getImageDesc(String typ) throws RemoteException,SQLException;
 	public Object getVisitList(String id) throws RemoteException,SQLException;
	public Object getImagesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException;
	public Object getDocListTable(String id,String dt1, String dt2) throws RemoteException,SQLException;  
	public Object getMoviesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException;
	public Object getDicomListTable(String id,String dt1, String dt2) throws RemoteException,SQLException;   
	public Object getAdvicedListTable(String id,String dt1, String dt2,String priority) throws RemoteException,SQLException;                         
}


