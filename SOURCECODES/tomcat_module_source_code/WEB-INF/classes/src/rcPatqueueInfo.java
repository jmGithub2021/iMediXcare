package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcPatqueueInfo{
	
	private static PatqueueInfoInterface pqiserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcPatqueueInfo(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   pqiserver= (PatqueueInfoInterface)(registry.lookup("PatqueueInfo"));
	      
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
     public Object getLPatqueueAdmin(String ccode, int lowOffset, int rCount) throws RemoteException,SQLException{
     	return pqiserver.getLPatqueueAdmin(ccode,lowOffset,rCount);
     }
    public Object getLPatqueueAdminSearch(String ccode, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException{
		return pqiserver.getLPatqueueAdminSearch(ccode,lowOffset,rCount,searchParam);
	} 
    public Object getLPatqueueTreatedAdmin(String ccode, int lowOffset, int rCount) throws RemoteException, SQLException{
		return pqiserver.getLPatqueueTreatedAdmin(ccode,lowOffset,rCount);
  }
  public String getTotalLPatAdmin2(String ccode) throws RemoteException,SQLException{
    return pqiserver.getTotalLPatAdmin2(ccode);
  }
     public String getTotalLPatAdmin(String ccode) throws RemoteException,SQLException{
     	return pqiserver.getTotalLPatAdmin(ccode);
     }
     public String getTotalLPatTreatedAdmin(String ccode) throws RemoteException,SQLException{
     	return pqiserver.getTotalLPatTreatedAdmin(ccode);
     }     
     public Object getLPatqueueDoc(String dreg, int lowOffset, int rCount) throws RemoteException,SQLException{
     	return pqiserver.getLPatqueueDoc(dreg,lowOffset,rCount);
     }
    public Object getLPatqueueDocSearch(String dreg, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException{
		return pqiserver.getLPatqueueDocSearch(dreg,lowOffset,rCount,searchParam);
	}
    public Object getLpatqTreatedDoc(String dreg, int lowOffset, int rCount) throws RemoteException, SQLException{
		return pqiserver.getLpatqTreatedDoc(dreg,lowOffset,rCount);
	}
          
     public String getTotalLPatDoc(String ccode,String dreg) throws RemoteException,SQLException{
     	return pqiserver.getTotalLPatDoc(ccode,dreg);
     }
     public String getTotalLPatTreatedDoc(String ccode,String dreg) throws RemoteException,SQLException{
     	return pqiserver.getTotalLPatTreatedDoc(ccode,dreg);
     }       
     public Object getRPatqueueAdmin(String lcode,String rcode, int lowOffset, int rCount)throws RemoteException,SQLException {
     	return pqiserver.getRPatqueueAdmin(lcode,rcode,lowOffset,rCount);
     }
	public Object getRPatqueueTreatedAdmin(String lcode,String rcode, int lowOffset, int rCount) throws RemoteException, SQLException{
			return pqiserver.getRPatqueueTreatedAdmin(lcode,rcode,lowOffset,rCount);
	}
     public Object getRPatwaitqueueAdmin(String lcode,String rcode, int lowOffset, int rCount,String status)throws RemoteException,SQLException {
      return pqiserver.getRPatwaitqueueAdmin(lcode,rcode,lowOffset,rCount,status);
     }

     public Object getRPatwaitqueueDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException,SQLException{
      return pqiserver.getRPatwaitqueueDoc(rcode,dreg,lowOffset,rCount);
     }

     public String getTotalRPatAdmin(String lcode,String rcode) throws RemoteException,SQLException{
     	return pqiserver.getTotalRPatAdmin(lcode,rcode);	
     }
     public String getTotalRPatTreatedAdmin(String lcode,String rcode) throws RemoteException,SQLException{
     	return pqiserver.getTotalRPatTreatedAdmin(lcode,rcode);	
     }     
     public Object getRPatqueueDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException,SQLException{
     	return pqiserver.getRPatqueueDoc(rcode,dreg,lowOffset,rCount);
     }
     public Object getRPatqueueTreatedDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException, SQLException{
		return pqiserver.getRPatqueueTreatedDoc(rcode,dreg,lowOffset,rCount);
	}
    public String getTotalRPatDoc(String rcode,String dreg) throws RemoteException,SQLException{
     	return pqiserver.getTotalRPatDoc(rcode,dreg);
     }
    public String getTotalRPatTreatedDoc(String rcode,String dreg) throws RemoteException,SQLException{
     	return pqiserver.getTotalRPatTreatedDoc(rcode,dreg);
     }     
     public String getTotalRPatwaitAdmin(String lcode, String rcode) throws RemoteException, SQLException {
       return pqiserver.getTotalRPatwaitAdmin(lcode, rcode);
     }
	 public String isAvaliableInTwaitQ(String patid) throws RemoteException, SQLException{
		 return pqiserver.isAvaliableInTwaitQ(patid);
	 }
     public String getTotalRPatwaitDoc(String rcode, String dreg) throws RemoteException, SQLException {
        return pqiserver.getTotalRPatwaitDoc(rcode, dreg);
     }
     public String getTotalRPatwaitDoc4twb(String rcode, String dreg) throws RemoteException, SQLException {
       return pqiserver.getTotalRPatwaitDoc4twb(rcode, dreg);
     }
     public String getTotal(String tableName) throws RemoteException, SQLException {
	   return pqiserver.getTotal(tableName);
	 }
     public Object getRPatrefqueueDoc(String dreg,int lowOffset, int rCount,String status) throws RemoteException, SQLException{
		return pqiserver.getRPatrefqueueDoc(dreg,lowOffset,rCount,status);
	 }
	 public boolean updateLpatqAssignDate(String pat_id, String appdate) throws RemoteException, SQLException{
		 return pqiserver.updateLpatqAssignDate(pat_id,appdate);
   }
   public boolean updateTpatqAssignDate(String pat_id, String teleconsultdt) throws RemoteException, SQLException{
	   return pqiserver.updateTpatqAssignDate(pat_id,teleconsultdt);
   }
   public Object getLPatEntry(String pat_id) throws RemoteException, SQLException{
      return pqiserver.getLPatEntry(pat_id);
   }
   public Object getTPatEntry(String pat_id) throws RemoteException, SQLException{
	   return pqiserver.getTPatEntry(pat_id);
   }
   public Object appoinmentNotSetList(String docRegNo) throws RemoteException, SQLException{
	   return pqiserver.appoinmentNotSetList(docRegNo);
   }
   public Object appoinmentNotSetListTpatq(String docRegNo) throws RemoteException, SQLException{
	   return pqiserver.appoinmentNotSetListTpatq(docRegNo);
   }
   public boolean resetAppoinmentTpatq(String patid) throws RemoteException, SQLException{
	   return pqiserver.resetAppoinmentTpatq(patid);
   }
   public boolean resetAppoinmentLpatq(String patid) throws RemoteException, SQLException{
	   return pqiserver.resetAppoinmentLpatq(patid);
   }
	}
