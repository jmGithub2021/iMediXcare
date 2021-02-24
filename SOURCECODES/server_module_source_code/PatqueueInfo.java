package imedix;

import java.io.PrintStream;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.SQLException;
import java.util.Vector;
//Downloaded from Server  Dt: 3Jan17, 17:30
public class PatqueueInfo
  extends UnicastRemoteObject
  implements PatqueueInfoInterface
{
  projinfo pinfo;
  
  public PatqueueInfo(projinfo paramprojinfo)
    throws RemoteException
  {
    this.pinfo = paramprojinfo;
  }
  
  public Object getLPatqueueAdmin(String ccode, int lowOffset, int rCount) throws RemoteException, SQLException
  {
    String sqlQuery = "select distinct lpatq.pat_id,lpatq.delflag,lpatq.checked,";
    sqlQuery = sqlQuery + " lpatq.entrydate, lpatq.appdate,med.referring_doctor, med.pat_name,med.class ";
    sqlQuery = sqlQuery + " from lpatq inner join med  ";
    sqlQuery = sqlQuery + " on lpatq.pat_id=med.pat_id";
    sqlQuery = sqlQuery + " WHERE upper(lpatq.delflag)='N'";
  /*  if ((!ccode.equalsIgnoreCase("XXXX")) && (!ccode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " and upper(left(med.pat_id,4)) = '" + ccode.toUpperCase() + "'";
    }*/
    if ((!ccode.equalsIgnoreCase("XXXX")) && (!ccode.equalsIgnoreCase(""))) {
      //sqlQuery = sqlQuery + " and upper(med.pat_id) like '" + ccode.toUpperCase() + "%'";
      sqlQuery = sqlQuery + " and upper(med.referring_doctor) like 'DOC" + ccode.toUpperCase() + "%'";

    }
    //sqlQuery = sqlQuery + " order by lpatq.pat_id DESC, lpatq.entrydate DESC ";
    sqlQuery = sqlQuery + " order by lpatq.entrydate DESC,med.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalpatAdmin >> "+sqlQuery);
    return localdball.ExecuteQuary(sqlQuery);
  }
  public Object getLPatqueueAdminSearch(String ccode, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException{
	String srchPatName = searchParam.getValue("srchPatName");
	String srchPatId = searchParam.getValue("srchPatId");
	String srchFrom = searchParam.getValue("srchFrom");
	String srchTo = searchParam.getValue("srchTo");
	String daterange = " and (DATE(lpatq.entrydate) between '"+srchFrom+"' and '"+srchTo+"')";
	String srchParam = "";
	if(srchPatName.length()>2) srchParam +=" and pat_name like '"+srchPatName+"%' or pat_name like ' "+srchPatName+"%'";
	if(srchPatId.length()>3) srchParam +=" and lpatq.pat_id like '%"+srchPatId+"%'";
	if(srchFrom.length()>9 && srchTo.length()>9) srchParam +=daterange;

    String sqlQuery = "select distinct lpatq.pat_id,lpatq.delflag,lpatq.checked,";
    sqlQuery = sqlQuery + " lpatq.entrydate, lpatq.appdate,med.referring_doctor, med.pat_name,med.class ";
    sqlQuery = sqlQuery + " from lpatq inner join med  ";
    sqlQuery = sqlQuery + " on lpatq.pat_id=med.pat_id";
    sqlQuery = sqlQuery + " WHERE upper(lpatq.delflag)='N'"+srchParam;
   if ((!ccode.equalsIgnoreCase("XXXX")) && (!ccode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " and upper(med.pat_id) like '" + ccode.toUpperCase() + "%'";
      sqlQuery = sqlQuery + " and upper(med.referring_doctor) like 'DOC" + ccode.toUpperCase() + "%'";
    }
    /*if ((!ccode.equalsIgnoreCase("XXXX")) && (!ccode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " or upper(med.pat_id) like '" + ccode.toUpperCase() + "%'";
    }*/
    //sqlQuery = sqlQuery + " order by lpatq.pat_id DESC, lpatq.entrydate DESC ";
    sqlQuery = sqlQuery + " order by lpatq.entrydate DESC,med.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalpatAdmin >> "+sqlQuery);
    return localdball.ExecuteQuary(sqlQuery);
			
	}
  
  

  /* Local treated patient queue Admin*/ 
  public Object getLPatqueueTreatedAdmin(String ccode,int lowOffset,int rCount) throws RemoteException, SQLException
  {
    String sqlQuery = "select distinct lt.pat_id,lt.delflag,lt.checked,";
    sqlQuery = sqlQuery + " lt.entrydate, lt.appdate,lt.data_moved,m.referring_doctor, m.pat_name,m.class ";
    sqlQuery = sqlQuery + " from lpatq_treated lt inner join med m ";
    sqlQuery = sqlQuery + " on lt.pat_id=m.pat_id";
    sqlQuery = sqlQuery + " WHERE upper(lt.delflag)='N'";
    if ((!ccode.equalsIgnoreCase("XXXX")) && (!ccode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " and upper(left(m.pat_id,4)) = '" + ccode.toUpperCase() + "'";
    }
    //sqlQuery = sqlQuery + " order by lpatq.pat_id DESC, lpatq.entrydate DESC ";
    sqlQuery = sqlQuery + " order by lt.entrydate DESC,m.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalTreatedpatientAdmin >> : "+sqlQuery);
    return localdball.ExecuteQuary(sqlQuery);
	}
  
  /*END Local treated patient queue Admin*/
  
  public Object getLPatqueueDoc(String dreg, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
//    String sqlQuery = "select lpatq.*, med.pat_name,med.class from lpatq inner join med on lpatq.pat_id=med.pat_id where upper(lpatq.assigneddoc)='" + dreg.toUpperCase() + "' AND upper(lpatq.delflag)='N' ";
//    sqlQuery = sqlQuery + " order by lpatq.entrydate DESC,med.class  ";
//    sqlQuery = sqlQuery + " Limit " + lowOffset + ", " + rCount + " ";
    String sqlQuery = "select @i:=@i+1 AS rowno,lpatq.*, med.pat_name,med.class from lpatq inner join med on lpatq.pat_id=med.pat_id,(SELECT @i:="+lowOffset+") AS R where upper(lpatq.assigneddoc)='" + dreg.toUpperCase() + "' AND upper(lpatq.delflag)='N' and DATE(lpatq.appdate)<=DATE(NOW())";
    sqlQuery = sqlQuery + " order by lpatq.appdate, lpatq.entrydate";
    sqlQuery = sqlQuery + " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalpatDoctor >> "+sqlQuery);    
    return localdball.ExecuteQuary(sqlQuery);
  }
  public Object getLPatqueueDocSearch(String dreg, int lowOffset, int rCount,dataobj searchParam) throws RemoteException, SQLException
  {
	String srchPatName = searchParam.getValue("srchPatName");
	String srchPatId = searchParam.getValue("srchPatId");
	String srchFrom = searchParam.getValue("srchFrom");
	String srchTo = searchParam.getValue("srchTo");
	String daterange = " and (DATE(lpatq.entrydate) between '"+srchFrom+"' and '"+srchTo+"')";
	String srchParam = "";
	if(srchPatName.length()>2) srchParam +=" and pat_name like '"+srchPatName+"%' or pat_name like ' "+srchPatName+"%'";
	if(srchPatId.length()>3) srchParam +=" and lpatq.pat_id like '%"+srchPatId+"%'";
	if(srchFrom.length()>9 && srchTo.length()>9) srchParam +=daterange;
	
	
    String sqlQuery = "select lpatq.*, med.pat_name,med.class from lpatq inner join med on lpatq.pat_id=med.pat_id where upper(lpatq.assigneddoc)='" + dreg.toUpperCase() + "' AND upper(lpatq.delflag)='N' "+srchParam;
    sqlQuery = sqlQuery + " order by lpatq.entrydate DESC,med.class  ";
    sqlQuery = sqlQuery + " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalpatDoctor >> "+sqlQuery);    
    return localdball.ExecuteQuary(sqlQuery);
  }	
  
  /* Local treated patient queue Doctor */
    public Object getLpatqTreatedDoc(String dreg, int lowOffset, int rCount) throws RemoteException, SQLException
  {
    String sqlQuery = "select lt.*, m.pat_name,m.class from lpatq_treated lt inner join med m on lt.pat_id=m.pat_id where upper(lt.assigneddoc)='" + dreg.toUpperCase() + "' AND upper(lt.delflag)='N' ";
    sqlQuery = sqlQuery + " order by lt.entrydate DESC,m.class  ";
    sqlQuery = sqlQuery + " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("LocalTreatedpatientDoc >> : "+sqlQuery);    
    return localdball.ExecuteQuary(sqlQuery);
  }
  /*END Local treated patient queue Doctor */
  
  public Object getLPatqueueOP(String ccode, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
    return new Object();
  }
  
  public Object getRPatqueueAdmin(String lcode,String rcode, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
    String sqlQuery = "select distinct tpatq.pat_id,tpatq.delflag,tpatq.checked,";
    sqlQuery = sqlQuery + " tpatq.entrydate,tpatq.refer_doc,tpatq.assigneddoc,tpatq.refer_center,tpatq.teleconsultdt,med.pat_name,med.referring_doctor,med.class";
    sqlQuery = sqlQuery + " from tpatq inner join med  ";
    sqlQuery = sqlQuery + " on tpatq.pat_id=med.pat_id";
    sqlQuery = sqlQuery + " where upper(tpatq.delflag)='N'";
    if (lcode.equalsIgnoreCase("XXXX"))
    {
      sqlQuery = sqlQuery + " AND upper(tpatq.assignedhos)='" + rcode.toUpperCase() + "'";
    }
    else
    {
      sqlQuery = sqlQuery + " AND (upper(tpatq.pat_id) Like '" + rcode.toUpperCase() + "%'";
      sqlQuery = sqlQuery + " or upper(tpatq.refer_center)='" + rcode.toUpperCase() + "')";
    }
    if ((!lcode.equalsIgnoreCase("XXXX")) && (!lcode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " AND upper(tpatq.assignedhos)='" + lcode.toUpperCase() + "'";
    }
    
    sqlQuery = sqlQuery + " order by tpatq.entrydate DESC,med.class  ";
    //sqlQuery = sqlQuery + " order by tpatq.entrydate DESC, tpatq.pat_id DESC ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("TelepatientAdmin >> : "+sqlQuery);    
    return localdball.ExecuteQuary(sqlQuery);
  }

/* Tele patient queue treated admin */
  public Object getRPatqueueTreatedAdmin(String lcode,String rcode, int lowOffset, int rCount) throws RemoteException, SQLException
  {
    String sqlQuery = "select distinct tt.pat_id,tt.delflag,tt.checked,";
    sqlQuery = sqlQuery + " tt.entrydate,tt.refer_doc,tt.assigneddoc,tt.refer_center,tt.teleconsultdt,tt.data_moved,m.pat_name,m.referring_doctor,m.class";
    sqlQuery = sqlQuery + " from tpatq_treated tt inner join med m ";
    sqlQuery = sqlQuery + " on tt.pat_id=m.pat_id";
    sqlQuery = sqlQuery + " where upper(tt.delflag)='N'";
    if (lcode.equalsIgnoreCase("XXXX"))
    {
      sqlQuery = sqlQuery + " AND upper(tt.assignedhos)='" + rcode.toUpperCase() + "'";
    }
    else
    {
      sqlQuery = sqlQuery + " AND (upper(tt.pat_id) Like '" + rcode.toUpperCase() + "%'";
      sqlQuery = sqlQuery + " or upper(tt.refer_center)='" + rcode.toUpperCase() + "')";
    }
    if ((!lcode.equalsIgnoreCase("XXXX")) && (!lcode.equalsIgnoreCase(""))) {
      sqlQuery = sqlQuery + " AND upper(tt.assignedhos)='" + lcode.toUpperCase() + "'";
    }
    
    sqlQuery = sqlQuery + " order by tt.entrydate DESC,m.class  ";
    //sqlQuery = sqlQuery + " order by tpatq.entrydate DESC, tpatq.pat_id DESC ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    dball localdball = new dball(this.pinfo);
    System.out.println("Teletreatedpat >> "+sqlQuery);
    return localdball.ExecuteQuary(sqlQuery);
  }
/* END tele patient queue treated admin */ 
  
  public Object test123(String paramString)
    throws RemoteException, SQLException
  {
    return paramString;
  }
  
  public Object getRPatwaitqueueAdmin(String lcode,String rcode, int lowOffset, int rCount,String status)
    throws RemoteException, SQLException
  {
	  /*
	   * String sqlQuery = "select distinct tpatwaitq.pat_id,"; 
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
	  */
		
    String sqlQuery = "select tpatwaitq.pat_id,";
    sqlQuery = sqlQuery + " tpatwaitq.entrydate,tpatwaitq.attending_doc,tpatwaitq.referred_doc,tpatwaitq.local_hospital,tpatwaitq.entrydate,tpatwaitq.status,tpatwaitq.req_id,med.pat_name,med.referring_doctor,med.class ";
    sqlQuery = sqlQuery + " from tpatwaitq inner join med  "; 
    sqlQuery = sqlQuery + " on tpatwaitq.pat_id=med.pat_id";
	if(lcode.equalsIgnoreCase("XXXX")){
		sqlQuery = sqlQuery +  " AND tpatwaitq.referred_hospital='"+rcode+"'";
	}else{
		sqlQuery = sqlQuery +  " AND (tpatwaitq.pat_id Like '" + lcode + "%'";
		sqlQuery = sqlQuery +  " or tpatwaitq.local_hospital='"+lcode+"')";
	}
	if(status.equalsIgnoreCase("A") || status.equalsIgnoreCase("W") || status.equalsIgnoreCase("R") || status.equalsIgnoreCase("D"))
		sqlQuery = sqlQuery+" and tpatwaitq.status='"+status+"'";	
	if(!lcode.equalsIgnoreCase("XXXX") && !lcode.equalsIgnoreCase(""))
			sqlQuery = sqlQuery +  " AND tpatwaitq.referred_hospital='"+rcode+"'";      
    sqlQuery = sqlQuery + " order by tpatwaitq.entrydate DESC, tpatwaitq.pat_id DESC ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    
    System.out.println("getRPatwaitqueueAdmin() : "+sqlQuery);
    
    dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sqlQuery);
  }
  
  public Object getRPatqueueDoc(String rcode, String dreg, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
    //String sqlQuery = "select tpatq.*, med.pat_name,med.class from tpatq inner join med on tpatq.pat_id=med.pat_id where upper(tpatq.assigneddoc) like '" + dreg.trim().toUpperCase() + "%' AND upper(tpatq.delflag)='N'" + " AND upper(tpatq.refer_center) like '" + rcode.toUpperCase().trim() + "%'";
    String sqlQuery = "select tpatq.*, med.pat_name,med.class from tpatq inner join med on tpatq.pat_id=med.pat_id where upper(tpatq.assigneddoc) like '" + dreg.trim().toUpperCase() + "%' AND upper(tpatq.delflag)='N'";
    sqlQuery = sqlQuery + " and DATE(tpatq.teleconsultdt)<=DATE(NOW()) order by tpatq.entrydate DESC, med.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    
    System.out.println(" getRPatqueueDoc+ : " + sqlQuery);
    
    dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sqlQuery);
  }

/* Tele patient queue doctor */

  public Object getRPatqueueTreatedDoc(String rcode, String dreg, int lowOffset, int rCount) throws RemoteException, SQLException
  {
    String sqlQuery = "select tt.*, m.pat_name,m.class from tpatq_treated tt inner join med m on tt.pat_id=m.pat_id where upper(tt.assigneddoc) like '" + dreg.trim().toUpperCase() + "%' AND upper(tt.delflag)='N'" + " AND upper(tt.refer_center) like '" + rcode.toUpperCase().trim() + "%'";
    sqlQuery = sqlQuery + " order by tt.entrydate DESC, m.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    
    System.out.println(" getRPatqueueTreatedDoc+ : " + sqlQuery);
    
    dball localdball = new dball(this.pinfo);
    System.out.println("TeleTreatedpatientDoc >> : "+sqlQuery);    
    return localdball.ExecuteQuary(sqlQuery);
  }

/* END Tele patient queue doctor */
  
  public Object getRPatwaitqueueDoc(String rcode, String dreg, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
	  /*
	   *  String sqlQuery = "select tpatwaitq.*, med.pat_name,med.class from tpatwaitq, med " +
    	" where upper(tpatwaitq.referred_doc) like '"+ dreg.trim().toUpperCase()+
    	"%' AND upper(tpatwaitq.pat_id)=upper(med.pat_id)"+
    	" AND upper(tpatwaitq.local_hospital) like '"+rcode.toUpperCase().trim()+"%'";
    	sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
   		dball mydb= new dball(pinfo);
   		return mydb.ExecuteQuary(sqlQuery);  
   		* */
    String sqlQuery = "select tpatwaitq.*, med.pat_name,med.class from tpatwaitq inner join med on tpatwaitq.pat_id=med.pat_id where upper(tpatwaitq.referred_doc) like '" + dreg.trim().toUpperCase() + "%' AND status='W' ";
    sqlQuery = sqlQuery + " order by tpatwaitq.entrydate DESC,med.class  ";
    sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
    //System.out.println(str);
    
    dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sqlQuery);
  }
    
  public Object getRPatqueueOP(String lcode,String rcode, int lowOffset, int rCount)
    throws RemoteException, SQLException
  {
    return new Object();
  }
  
   public Object getRPatrefqueueDoc(String dreg, int lowOffset, int rCount, String status)
    throws RemoteException, SQLException
  {
    System.out.println("dreg >>" + dreg + "<<");
    String sqlQuery;
    if (dreg.trim().equals("ADM")) {
      sqlQuery = "select tpatwaitq.*, med.pat_name,med.class from tpatwaitq inner join med on tpatwaitq.pat_id=med.pat_id ";
      	if(status.equalsIgnoreCase("A") || status.equalsIgnoreCase("W") || status.equalsIgnoreCase("R") || status.equalsIgnoreCase("D"))
		sqlQuery = sqlQuery+" and tpatwaitq.status='"+status+"'";
      sqlQuery = sqlQuery + " order by tpatwaitq.entrydate DESC, med.class  ";
      sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
      System.out.println("getRPatrefqueueDoc(for admin)>>" + sqlQuery);
    }
    else {
      sqlQuery = "select tpatwaitq.*, med.pat_name,med.class from tpatwaitq inner join med on tpatwaitq.pat_id=med.pat_id where upper(tpatwaitq.attending_doc) like '" + dreg.trim().toUpperCase() + "%'" + " ";
		if(status.equalsIgnoreCase("A") || status.equalsIgnoreCase("W") || status.equalsIgnoreCase("R") || status.equalsIgnoreCase("D"))
		sqlQuery = sqlQuery+" and tpatwaitq.status='"+status+"'";
      sqlQuery = sqlQuery + " order by tpatwaitq.entrydate DESC,med.class  ";
      sqlQuery = sqlQuery +  " Limit " + lowOffset + ", " + rCount + " ";
      System.out.println("getRPatrefqueueDoc(for doc)>>" + sqlQuery);
    }
    dball localdball = new dball(this.pinfo);
    return localdball.ExecuteQuary(sqlQuery);
  }
  
  public String getTotalLPatAdmin2(String paramString)
    throws RemoteException, SQLException
  {
    //String str = "Select count(*) as TP from lpatq where delflag='N' AND pat_id Like '" + paramString + "%'";
    String str = "Select count(*) as TP from lpatq where delflag='N' AND upper(assigneddoc) LIKE '"+"DOC"+paramString.toUpperCase()+"%'";
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalLPatAdmin>>"+str);
    return localdball.ExecuteSingle(str);
  }

  public String getTotalLPatAdmin(String paramString)
    throws RemoteException, SQLException
  {
    String str = "Select count(*) as TP from lpatq where delflag='N' AND pat_id Like '" + paramString + "%'";
    //String str = "Select count(*) as TP from lpatq where delflag='N' AND upper(assigneddoc) LIKE '"+"DOC"+paramString.toUpperCase()+"%'";
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalLPatAdmin>>"+str);
    return localdball.ExecuteSingle(str);
  }

  public String getTotalLPatTreatedAdmin(String paramString)
    throws RemoteException, SQLException
  {
	String str = "";  
	if(paramString.equalsIgnoreCase("XXXX"))
		str = "Select count(*) as TTP from lpatq_treated where delflag='N'";
	else{	
    //str = "Select count(*) as TTP from lpatq_treated where delflag='N' AND pat_id Like '" + paramString + "%'";
    str = "Select count(*) as TTP from lpatq_treated where delflag='N' AND upper(assigneddoc) LIKE '"+"DOC"+paramString.toUpperCase()+"%'";
  }
    dball localdball = new dball(this.pinfo);
    System.out.println("totalTreatedLpat >> "+str);
    return localdball.ExecuteSingle(str);
  }
  
  public String getTotalRPatAdmin(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "";
    if ((!paramString1.equalsIgnoreCase("XXXX")) && (!paramString1.equalsIgnoreCase("")))
    {
      str = "Select count(*) as TP from tpatq where delflag='N' AND pat_id Like '" + paramString2 + "%'";
      str = str + " AND upper(tpatq.assignedhos)='" + paramString1.toUpperCase() + "'";
    }
    else
    {
      str = "Select count(*) as TP from tpatq where delflag='N'";
      str = str + " AND upper(tpatq.assignedhos)='" + paramString2.toUpperCase() + "'";
    }
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatAdmin :" + str);
    return localdball.ExecuteSingle(str);
  }

  public String getTotalRPatTreatedAdmin(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "";
    if ((!paramString1.equalsIgnoreCase("XXXX")) && (!paramString1.equalsIgnoreCase("")))
    {
      str = "Select count(*) as TP from tpatq_treated tt where delflag='N' AND pat_id Like '" + paramString2 + "%'";
      str = str + " AND upper(tt.assignedhos)='" + paramString1.toUpperCase() + "'";
    }
    else
    {
      str = "Select count(*) as TP from tpatq_treated tt where delflag='N'";
      str = str + " AND upper(tt.assignedhos)='" + paramString2.toUpperCase() + "'";
    }
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatTreatedAdmin :" + str);
    return localdball.ExecuteSingle(str);
  }
  
  public String getTotalRPatwaitAdmin(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "";
    if ((!paramString1.equalsIgnoreCase("XXXX")) && (!paramString1.equalsIgnoreCase("")))
    {
      str = "Select count(*) as TP from tpatwaitq where pat_id Like '" + paramString1 + "%'";
      str = str + " AND upper(tpatwaitq.referred_hospital)='" + paramString2.toUpperCase() + "'";
    }
    else
    {
      str = "Select count(*) as TP from tpatwaitq where delflg='N'";
      str = str + " AND upper(tpatwaitq.referred_hospital)='" + paramString2.toUpperCase() + "'";
    }
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatwaitAdmin :" + str);
    return localdball.ExecuteSingle(str);
  }
  
  public String getTotalLPatDoc(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    //String str = "select count(*) from lpatq where upper(assigneddoc)='" + paramString2.toUpperCase() + "' AND delflag='N' and pat_id Like '" + paramString1 + "%'";
    String str = "select count(*) from lpatq where upper(assigneddoc)='" + paramString2.toUpperCase() + "' AND delflag='N'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalLPatDoc>>"+str);
    return localdball.ExecuteSingle(str);
  }
  public String getTotalLPatTreatedDoc(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    //String str = "select count(*) from lpatq_treated where upper(assigneddoc)='" + paramString2.toUpperCase() + "' AND delflag='N' and pat_id Like '" + paramString1 + "%'";
    String str = "select count(*) from lpatq_treated where upper(assigneddoc)='" + paramString2.toUpperCase() + "' AND delflag='N'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("TotalLPatTreatedDoc >> : "+str);
    return localdball.ExecuteSingle(str);
  }  
  public String getTotalRPatDoc(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "select count(*) from tpatq where upper(assigneddoc) like '" + paramString2.toUpperCase().trim() + "%' AND delflag='N' and pat_id Like '" + paramString1 + "%'";
    //String str = "select count(*) from tpatq where upper(assigneddoc) like '" + paramString2.toUpperCase().trim() + "%' AND delflag='N'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatDoc :" + str);
    return localdball.ExecuteSingle(str);
  }
  public String getTotalRPatTreatedDoc(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "select count(*) from tpatq_treated where upper(assigneddoc) like '" + paramString2.toUpperCase().trim() + "%' AND delflag='N' and pat_id Like '" + paramString1 + "%'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatTreatedDoc :" + str);
    return localdball.ExecuteSingle(str);
  }  
  public String isAvaliableInTwaitQ(String patid) throws RemoteException, SQLException{
	  String str = "select count(*) from tpatwaitq where pat_id='"+patid+"' and status='W'";
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatTreatedDoc :" + str);
    return localdball.ExecuteSingle(str);	  
  }
  public String getTotalRPatwaitDoc(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "select count(*) from tpatwaitq where upper(attending_doc) like '" + paramString2.toUpperCase().trim() + "%'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatwaitDoc :" + str);
    return localdball.ExecuteSingle(str);
  }
  
  public String getTotalRPatwaitDoc4twb(String paramString1, String paramString2)
    throws RemoteException, SQLException
  {
    String str = "select count(*) from tpatwaitq where upper(referred_doc) like '" + paramString2.toUpperCase().trim() + "%' and status='W'";
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotalRPatwaitDoc :" + str);
    return localdball.ExecuteSingle(str);
  }
  
  public String getTotal(String tableName)
    throws RemoteException, SQLException
  {
    String str = "select count(*) from " + tableName;
    
    dball localdball = new dball(this.pinfo);
    System.out.println("getTotal :" + str);
    return localdball.ExecuteSingle(str);
  }
  public boolean updateLpatqAssignDate(String pat_id, String appdate) throws RemoteException, SQLException{
		String sql = "update lpatq set appdate='"+appdate+"' where pat_id='"+pat_id+"'";
		dball localdball = new dball(this.pinfo);
		String result = localdball.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
  }
  public boolean updateTpatqAssignDate(String pat_id, String teleconsultdt) throws RemoteException, SQLException{
		String sql = "update tpatq set teleconsultdt='"+teleconsultdt+"' where pat_id='"+pat_id+"'";
		dball localdball = new dball(this.pinfo);
		String result = localdball.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
  }  

  public Object getLPatEntry(String pat_id) throws RemoteException, SQLException{
    String sql = "select * from lpatq where pat_id = '"+pat_id+"'";
    dball localdball = new dball(this.pinfo);
    System.out.println("getLPatEntry >> : "+sql);    
    return localdball.ExecuteQuary(sql);
  }
  public Object getTPatEntry(String pat_id) throws RemoteException, SQLException{
    String sql = "select * from tpatq where pat_id = '"+pat_id+"'";
    dball localdball = new dball(this.pinfo);
    System.out.println("getTPatEntry >> : "+sql);    
    return localdball.ExecuteQuary(sql);
  }  
  public Object appoinmentNotSetList(String docRegNo) throws RemoteException, SQLException{
	  String sql = "select lpatq.*,trim(CONCAT(IFNULL(pre,'') , ' ' , IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) as patname from lpatq INNER JOIN med on lpatq.pat_id=med.pat_id where lpatq.appdate IS NULL and lpatq.assigneddoc='"+docRegNo+"'";
		dball localdball = new dball(this.pinfo);
		System.out.println("appoinmentNotSetList >> : "+sql);    
		return localdball.ExecuteQuary(sql);
  }
  public Object appoinmentNotSetListTpatq(String docRegNo) throws RemoteException, SQLException{
	  String sql = "select tpatq.*,trim(CONCAT(IFNULL(pre,'') , ' ' , IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) as patname from tpatq INNER JOIN med on tpatq.pat_id=med.pat_id where tpatq.teleconsultdt IS NULL and tpatq.assigneddoc='"+docRegNo+"'";
		dball localdball = new dball(this.pinfo);
		System.out.println("appoinmentNotSetListTpatq >> : "+sql);    
		return localdball.ExecuteQuary(sql);
  }  
  public boolean resetAppoinmentTpatq(String patid) throws RemoteException, SQLException{
	  String sql = "update tpatq set teleconsultdt="+null+" where pat_id='"+patid+"'";
		dball localdball = new dball(this.pinfo);
		String result = localdball.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done"))
			return true;
		else
			return false; 
  }
  public boolean resetAppoinmentLpatq(String patid) throws RemoteException, SQLException{
	  String sql = "update lpatq set appdate="+null+" where pat_id='"+patid+"'";
		dball localdball = new dball(this.pinfo);
		String result = localdball.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done"))
			return true;
		else
			return false; 
  }
  
}
