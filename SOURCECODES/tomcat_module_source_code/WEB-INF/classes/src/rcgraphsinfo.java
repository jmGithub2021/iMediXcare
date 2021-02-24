package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcgraphsinfo{
	
	private static graphsinfointerface graphsInfo=null;
	private Registry registry;
	projinfo proj;
	
	public rcgraphsinfo(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   graphsInfo= (graphsinfointerface)(registry.lookup("GraphsInfo"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public String  getNoSibling(String patid )throws RemoteException,SQLException{
			return 	graphsInfo.getNoSibling(patid);
	}
    
    public Object getSiblingHistory(String patid )throws RemoteException,SQLException{
    		return 	graphsInfo.getSiblingHistory(patid);	
    }
    
    public Object getParentHistory(String patid )throws RemoteException,SQLException{
    		return 	graphsInfo.getParentHistory(patid);
    }
    
    public double[][] getAgeCoords(String patid, String tab_field, String tab_name)throws RemoteException,SQLException{
    	return 	graphsInfo.getAgeCoords(patid,tab_field,tab_name);
    }
    
    public double[][] getAgeCoords(String patid, String tab_field, String tab_name,int agemonth)throws RemoteException,SQLException{
    	return 	graphsInfo.getAgeCoords(patid,tab_field,tab_name,agemonth);
    }
    
    public double[][] getHIVRefCoords(String field_x, String field_y,String tab_name,int agemonth) throws RemoteException,SQLException{
    	return 	graphsInfo.getHIVRefCoords(field_x,field_y,tab_name,agemonth);
    }
    public String  getGraphList(String patid )throws RemoteException,SQLException{
     	return 	graphsInfo.getGraphList(patid);
    }
    
   public double[][] getGenGraphCoords(String patid, String x, String y)throws RemoteException,SQLException{
   		return 	graphsInfo.getGenGraphCoords(patid,x,y);
   }
    
}