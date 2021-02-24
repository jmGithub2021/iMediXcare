package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;

//remote interface
public interface graphsinfointerface extends Remote {
	     
    //method used to find a record

    public String  getNoSibling(String patid )throws RemoteException,SQLException;
    
    public Object getSiblingHistory(String patid )throws RemoteException,SQLException;
    
    public Object getParentHistory(String patid )throws RemoteException,SQLException;
    
    public double[][] getAgeCoords(String patid, String tab_field, String tab_name)throws RemoteException,SQLException;
    
    public double[][] getAgeCoords(String patid, String tab_field, String tab_name, int agemonth) throws RemoteException,SQLException;
        
    public double[][] getHIVRefCoords(String field_x, String field_y,String tab_name, int agemonth) throws RemoteException,SQLException;
    
    public String  getGraphList(String patid )throws RemoteException,SQLException;
    
    public double[][] getGenGraphCoords(String patid, String x, String y)throws RemoteException,SQLException;
    
    
    
}