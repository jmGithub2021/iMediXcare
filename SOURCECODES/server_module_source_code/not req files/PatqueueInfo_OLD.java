package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;

public class PatqueueInfo extends UnicastRemoteObject implements PatqueueInfoInterface {
		
	projinfo pinfo;
	
	public PatqueueInfo(projinfo p) throws RemoteException{
		pinfo=p;
	}

	public Object getLPatqueueAdmin(String ccode, int lowOffset, int rCount)throws RemoteException,SQLException{
	
	String sqlQuery = "select distinct lpatq.pat_id,lpatq.delflag,lpatq.checked,"; 
	sqlQuery = sqlQuery + " lpatq.entrydate, lpatq.appdate,med.referring_doctor, med.pat_name,med.class ";
	sqlQuery = sqlQuery +  " from lpatq, med  ";
	sqlQuery = sqlQuery +  " where upper(lpatq.pat_id)=upper(med.pat_id)";
	sqlQuery = sqlQuery +  " AND upper(lpatq.delflag)='N'";
	if(!ccode.equalsIgnoreCase("XXXX") && !ccode.equalsIgnoreCase("") )
		sqlQuery = sqlQuery +  " and upper(left(med.pat_id,4)) = '"+ccode.toUpperCase()+"'";
	sqlQuery = sqlQuery +  " order by lpatq.pat_id DESC, lpatq.entrydate DESC ";
	sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";

    dball mydb= new dball(pinfo);
    return mydb.ExecuteQuary(sqlQuery);
   
   	}
     
    public Object getLPatqueueDoc(String dreg, int lowOffset, int rCount ) throws RemoteException,SQLException{
	    String sqlQuery = "select lpatq.*, med.pat_name,med.class from lpatq, med " +
    	" where upper(lpatq.assigneddoc)='"+ dreg.toUpperCase()+
    	"' AND upper(lpatq.delflag)='N' and upper(lpatq.pat_id)=upper(med.pat_id)";
    	sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
   		dball mydb= new dball(pinfo);
   		return mydb.ExecuteQuary(sqlQuery);
    }
    
    
    public Object getLPatqueueOP(String ccode, int lowOffset, int rCount) throws RemoteException,SQLException{
    
    return new Object();
    
    }
     
    public Object getRPatqueueAdmin(String lcode,String rcode, int lowOffset, int rCount)throws RemoteException,SQLException{
	    String sqlQuery = "select distinct tpatq.pat_id,tpatq.delflag,tpatq.checked,"; 
		sqlQuery = sqlQuery + " tpatq.entrydate,tpatq.refer_doc,tpatq.assigneddoc,tpatq.refer_center,tpatq.teleconsultdt,med.pat_name,med.referring_doctor,med.class";
		sqlQuery = sqlQuery +  " from tpatq, med  ";
		sqlQuery = sqlQuery +  " where upper(tpatq.pat_id)=upper(med.pat_id)";
		sqlQuery = sqlQuery +  " AND upper(tpatq.delflag)='N'";
		if(lcode.equalsIgnoreCase("XXXX")){
			sqlQuery = sqlQuery +  " AND upper(tpatq.assignedhos)='"+rcode.toUpperCase()+"'";
		}else{
			sqlQuery = sqlQuery +  " AND (upper(tpatq.pat_id) Like '" + rcode.toUpperCase() + "%'";
			sqlQuery = sqlQuery +  " or upper(tpatq.refer_center)='"+rcode.toUpperCase()+"')";
		}
		if(!lcode.equalsIgnoreCase("XXXX") && !lcode.equalsIgnoreCase(""))
				sqlQuery = sqlQuery +  " AND upper(tpatq.assignedhos)='"+lcode.toUpperCase()+"'";
		
		sqlQuery = sqlQuery +  " order by tpatq.entrydate DESC, tpatq.pat_id DESC ";
		sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";

	    dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);	    
    }
	
	public Object test123(String test)throws RemoteException,SQLException{
		return test;
	}

//refer_doc->atending_doc
//assigned_doc->reffered_doc
	//pat_id, entrydate, attending_doc, referred_doc, referred_hospital, local_hospital, sent_by, send_records, userid, usertype

	public Object getRPatwaitqueueAdmin(String lcode,String rcode, int lowOffset, int rCount)throws RemoteException,SQLException{
	    String sqlQuery = "select distinct tpatwaitq.pat_id,"; 
		sqlQuery = sqlQuery + " tpatwaitq.entrydate,tpatwaitq.attending_doc,tpatwaitq.referred_doc,tpatwaitq.local_hospital,tpatwaitq.entrydate,med.pat_name,med.referring_doctor,med.class";
		sqlQuery = sqlQuery +  " from tpatwaitq, med  ";
		sqlQuery = sqlQuery +  " where upper(tpatwaitq.pat_id)=upper(med.pat_id)";
		//sqlQuery = sqlQuery +  " AND upper(tpatwaitq.delflag)='N'";
		if(lcode.equalsIgnoreCase("XXXX")){
			sqlQuery = sqlQuery +  " AND upper(tpatwaitq.referred_hospital)='"+rcode.toUpperCase()+"'";
		}else{
			sqlQuery = sqlQuery +  " AND (upper(tpatwaitq.pat_id) Like '" + rcode.toUpperCase() + "%'";
			sqlQuery = sqlQuery +  " or upper(tpatwaitq.local_hospital)='"+rcode.toUpperCase()+"')";
		}
		if(!lcode.equalsIgnoreCase("XXXX") && !lcode.equalsIgnoreCase(""))
				sqlQuery = sqlQuery +  " AND upper(tpatwaitq.referred_hospital)='"+lcode.toUpperCase()+"'";
		
		sqlQuery = sqlQuery +  " order by tpatwaitq.entrydate DESC, tpatwaitq.pat_id DESC ";
		sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";

	    dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);	    
    }


     
    public Object getRPatqueueDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException,SQLException{    
	     String sqlQuery = "select tpatq.*, med.pat_name,med.class from tpatq, med " +
    	" where upper(tpatq.assigneddoc) like '"+ dreg.trim().toUpperCase()+
    	"%' AND upper(tpatq.delflag)='N' and upper(tpatq.pat_id)=upper(med.pat_id)"+
    	" AND upper(tpatq.refer_center) like '"+rcode.toUpperCase().trim()+"%'";
    	sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
   		dball mydb= new dball(pinfo);
   		return mydb.ExecuteQuary(sqlQuery);
   		   
    }

	 public Object getRPatwaitqueueDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException,SQLException{    
	    String sqlQuery = "select tpatwaitq.*, med.pat_name,med.class from tpatwaitq, med " +
    	" where upper(tpatwaitq.referred_doc) like '"+ dreg.trim().toUpperCase()+
    	"%' AND upper(tpatwaitq.pat_id)=upper(med.pat_id)"+
    	" AND upper(tpatwaitq.local_hospital) like '"+rcode.toUpperCase().trim()+"%'";
    	sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
   		dball mydb= new dball(pinfo);
   		return mydb.ExecuteQuary(sqlQuery);   
    } //upper(tpatwaitq.delflag)='N' and 
     
    public Object getRPatqueueOP(String lcode,String rcode, int lowOffset, int rCount) throws RemoteException,SQLException{
    
    return new Object();
    	
    }
    
    /*
    public String getTotalLPatAdmin(String ccode) throws RemoteException,SQLException{
    	String sqlQuery = "Select count(*) as TP from lpatq where delflag='N' AND pat_id Like '" + ccode + "%'";
   		dball mydb= new dball(pinfo);
   		return mydb.ExecuteSingle(sqlQuery);
   	
    }
     
    public String getTotalRPatAdmin(String lcode,String rcode) throws RemoteException,SQLException{
   	 	String sqlQuery="";
   	 	if(!lcode.equalsIgnoreCase("XXXX") && !lcode.equalsIgnoreCase("") ){
   	 		sqlQuery = "Select count(*) as TP from tpatq where delflag='N' AND pat_id Like '" + rcode + "%'";
			sqlQuery = sqlQuery +  " AND upper(tpatq.assignedhos)='"+lcode.toUpperCase()+"'";
		}else{
			sqlQuery = "Select count(*) as TP from tpatq where delflag='N'";
 			sqlQuery = sqlQuery +  " AND upper(tpatq.assignedhos)='"+rcode.toUpperCase()+"'";
		}	
   		dball mydb= new dball(pinfo);
   		System.out.println("getTotalRPatAdmin :"+sqlQuery);
   		return mydb.ExecuteSingle(sqlQuery);
    }
     
    public String getTotalLPatDoc(String ccode,String dreg) throws RemoteException,SQLException{
    	String sqlQuery = "select count(*) from lpatq where upper(assigneddoc)='"+
    	dreg.toUpperCase()+"' AND delflag='N' and pat_id Like '" + ccode + "%'";
    	dball mydb= new dball(pinfo);
   		return mydb.ExecuteSingle(sqlQuery);	
    }
     
    public String getTotalRPatDoc(String rcode,String dreg) throws RemoteException,SQLException{
    	String sqlQuery = "select count(*) from tpatq where upper(assigneddoc) like '"+
    	dreg.toUpperCase().trim()+"%' AND delflag='N' and pat_id Like '" + rcode + "%'";
    	dball mydb= new dball(pinfo);
    	System.out.println("getTotalRPatDoc :"+sqlQuery);
   		return mydb.ExecuteSingle(sqlQuery);
    }*/
 	public String getTotalLPatAdmin(String string) throws RemoteException, SQLException {
        String string2 = "Select count(*) as TP from lpatq where delflag='N' AND pat_id Like '" + string + "%'";
        dball dball2 = new dball(this.pinfo);
        return dball2.ExecuteSingle(string2);
    }

    public String getTotalRPatAdmin(String string, String string2) throws RemoteException, SQLException {
        String string3 = "";
        if (!string.equalsIgnoreCase("XXXX") && !string.equalsIgnoreCase("")) {
            string3 = "Select count(*) as TP from tpatq where delflag='N' AND pat_id Like '" + string2 + "%'";
            string3 = string3 + " AND upper(tpatq.assignedhos)='" + string.toUpperCase() + "'";
        } else {
            string3 = "Select count(*) as TP from tpatq where delflag='N'";
            string3 = string3 + " AND upper(tpatq.assignedhos)='" + string2.toUpperCase() + "'";
        }
        dball dball2 = new dball(this.pinfo);
        System.out.println("getTotalRPatAdmin :" + string3);
        return dball2.ExecuteSingle(string3);
    }

    public String getTotalRPatwaitAdmin(String string, String string2) throws RemoteException, SQLException {
        String string3 = "";
        if (!string.equalsIgnoreCase("XXXX") && !string.equalsIgnoreCase("")) {
            string3 = "Select count(*) as TP from tpatwaitq where pat_id Like '" + string2 + "%'";
            string3 = string3 + " AND upper(tpatwaitq.referred_hospital)='" + string.toUpperCase() + "'";
        } else {
            string3 = "Select count(*) as TP from tpatwaitq where delflag='N'";
            string3 = string3 + " AND upper(tpatwaitq.referred_hospital)='" + string2.toUpperCase() + "'";
        }
        dball dball2 = new dball(this.pinfo);
        System.out.println("getTotalRPatwaitAdmin :" + string3);
        return dball2.ExecuteSingle(string3);
    }

    public String getTotalLPatDoc(String string, String string2) throws RemoteException, SQLException {
        String string3 = "select count(*) from lpatq where upper(assigneddoc)='" + string2.toUpperCase() + "' AND delflag='N' and pat_id Like '" + string + "%'";
        dball dball2 = new dball(this.pinfo);
        return dball2.ExecuteSingle(string3);
    }

    public String getTotalRPatDoc(String string, String string2) throws RemoteException, SQLException {
        String string3 = "select count(*) from tpatq where upper(assigneddoc) like '" + string2.toUpperCase().trim() + "%' AND delflag='N' and pat_id Like '" + string + "%'";
        dball dball2 = new dball(this.pinfo);
        System.out.println("getTotalRPatDoc :" + string3);
        return dball2.ExecuteSingle(string3);
    }

    public String getTotalRPatwaitDoc(String string, String string2) throws RemoteException, SQLException {
        String string3 = "select count(*) from tpatwaitq where upper(attending_doc) like '" + string2.toUpperCase().trim() + "%'";
        dball dball2 = new dball(this.pinfo);
        System.out.println("getTotalRPatwaitDoc :" + string3);
        return dball2.ExecuteSingle(string3);
    }

    public String getTotalRPatwaitDoc4twb(String string, String string2) throws RemoteException, SQLException {
        String string3 = "select count(*) from tpatwaitq where upper(referred_doc) like '" + string2.toUpperCase().trim() + "%' and status='W'";
        dball dball2 = new dball(this.pinfo);
        System.out.println("getTotalRPatwaitDoc :" + string3);
        return dball2.ExecuteSingle(string3);
    }    
}


   