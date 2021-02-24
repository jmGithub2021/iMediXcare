package tuberculosis;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import imedix.*;

public class rctbOperations{
	
	private static tbOperationsInterface tbOprssrv=null;
	private Registry registry;
	projinfo proj;
	
	public rctbOperations(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   tbOprssrv= (tbOperationsInterface)(registry.lookup("TBOperations"));

   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public Object getDrugName() throws RemoteException,SQLException{
		return tbOprssrv.getDrugName();
	}
	public String getRecomendedDoses(String drugid, String drugcount) throws RemoteException,SQLException{
		return tbOprssrv.getRecomendedDoses(drugid,drugcount);
	}
	public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException{
			return tbOprssrv.getOtherInfoAboutDrug(drugid);
	}
	public String getFormulation(String drugid,String drugcount) throws RemoteException,SQLException{
				return tbOprssrv.getFormulation(drugid,drugcount);
	}
	public String getPatientCurrentWeight(String patid, String distype) throws RemoteException,SQLException{
		return tbOprssrv.getPatientCurrentWeight(patid,distype);
	}
	public int putTBPrescriptiondatainDB(String patid, String[][] data_Prescription ,String hosname,String regno, String edate,dataobj obj) throws RemoteException,SQLException{
		return tbOprssrv.putTBPrescriptiondatainDB(patid,data_Prescription,hosname,regno,edate,obj);
	}
	
	public String getTotalDosage(String dosage,String weight){
            String strtemp="";
            double result = Double.parseDouble(dosage) * Double.parseDouble(weight);
            strtemp = "<br><table><tr><td><td align='left'><b>Total Dosage: </b></td>";
            strtemp += "<td><font size='3' color='Maroon'><b>" + result + "mg" + "</b></font></td></tr></table>";
            return (strtemp);
    }
        
	}