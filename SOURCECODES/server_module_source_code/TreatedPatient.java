package imedix;

import java.io.PrintStream;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.SQLException;
import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;
import logger.*;

public class TreatedPatient
  extends UnicastRemoteObject
  implements TreatedPatientInterface
{
  projinfo pinfo;
  dball mydb;
  
  public TreatedPatient(projinfo paramprojinfo)
    throws RemoteException
  {
    this.pinfo = paramprojinfo;
		mydb= new dball(pinfo);    
  }
  
	public Object getLpatqTreated(String ccode,String utype,int min,int max) throws RemoteException,SQLException{
		String sql = "select * from lpatq_treated where pat_id like '"+ccode+"%' limit "+min+","+max+"";
		 dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sql);		
	}
  	public Object getTpatqTreated(String ccode,String utype,int min,int max) throws RemoteException,SQLException{
		String sql = "select * from tpatq_treated where pat_id like '"+ccode+"%' limit "+min+","+max+"";
		 dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sql);		
	}
	public int moveLtoTreatedpatq(String cod, String patid)throws RemoteException,SQLException{
	String result="",result1="";
	int status = 0,status1 = 0;		
	String sql = "INSERT IGNORE INTO lpatq_treated(pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag) SELECT * FROM lpatq where pat_id='"+patid+"'";
	result = mydb.ExecuteSql(sql);
	if(result.equalsIgnoreCase("Done")) status = 1;
	String del_sql = "delete from lpatq where pat_id='"+patid+"'";
	if(status == 1)
		result1 = mydb.ExecuteSql(del_sql);
	if(result1.equalsIgnoreCase("Done")) status1 = 1;
		return status1;
	}
	public int moveTtoTreatedpatq(String cod, String patid)throws RemoteException,SQLException{
	String result="",result1="";
	int status = 0,status1 = 0;	
	String sql = "INSERT IGNORE INTO tpatq_treated(pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate) SELECT * FROM tpatq where pat_id='"+patid+"'";
	result = mydb.ExecuteSql(sql);
	if(result.equalsIgnoreCase("Done")) status = 1;
	String del_sql = "delete from tpatq where pat_id='"+patid+"'";
	if(status == 1)
		result1 = mydb.ExecuteSql(del_sql);
	if(result1.equalsIgnoreCase("Done")) status1 = 1;
		return status1;
	}
}
