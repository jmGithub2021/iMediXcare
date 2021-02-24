package imedix;

import java.io.*;
import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.StringTokenizer;
import java.util.Vector;
import logger.*;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This class used for Manage Administrative jobs.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see AdminJobsInterface
 */
 
public class AdminJobs extends UnicastRemoteObject implements AdminJobsInterface {
		
	projinfo pinfo;
	dball mydb;
	
	/**
     * Constructor used to create this object.
     * @param p server Configuration class object.
     * @see projinfo
     */
	public AdminJobs(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	
	public Object viewRegUsers()throws RemoteException,SQLException {
    String qr="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active from login where upper(active)='P' and upper(verified)='A'";
    System.out.println("BL call viewRegUsers"+qr);
    return mydb.ExecuteQuary(qr);	
    } 
    
    //regupdate.jsp
    
	public int  activeRegUsers(String uids,String ccode,dataobj obj)throws RemoteException,SQLException{
     	int ans =1;
     	String key,ktype;
     	System.out.println(uids);
     		
     	try{
     	String ids[]=uids.split("#");    	
     	for(int ii=0;ii<ids.length;ii++ ){
     		String id=ids[ii].trim();
     	    String usql = "UPDATE login set active = 'Y',available = 'Y',referral = 'Y' where lower(uid) = '"+id.toLowerCase().trim()+"'";
			System.out.println(usql);
			mydb.ExecuteSql(usql);
			ans=1;
			
			if(ans==1){
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("uid",id);
									
					desdtls.add("table","login");
					desdtls.add("details","Activate Users");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		}
	   		
			String tmpUtype=mydb.ExecuteSingle("Select type from login where lower(uid) = '"+id.toLowerCase().trim()+"'");
			String tmpRg_no=mydb.ExecuteSingle("Select rg_no from login where lower(uid) = '"+id.toLowerCase().trim()+"'");
			String tmpDistype=mydb.ExecuteSingle("Select dis from login where lower(uid) = '"+id.toLowerCase().trim()+"'");
			if(tmpUtype.equalsIgnoreCase("doc")){
	   			String IsQl="insert into  othdis values('"+tmpRg_no +"','"+tmpDistype+"')";
	   			mydb.ExecuteSql(IsQl);
	   		}
     		    		
     	} // end of for ii  
     	}catch(Exception e){
     		ans=0;
     	}
     	
     	return ans;
     }
     
	public int updatePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException{
		int ans=-1;
		System.out.println(pids);
		String uSql="",pid="";
		
		StringTokenizer stpids = new StringTokenizer(pids,"#");
    	while (stpids.hasMoreTokens()){
			pid = stpids.nextToken().toUpperCase();
			uSql = "update med set referring_doctor = '"+drcode+"' where pat_id='"+pid+"'";
			mydb.ExecuteSql(uSql);
			uSql = "update lpatq set assigneddoc = '"+drcode+"' where pat_id='"+pid+"'";
			mydb.ExecuteSql(uSql);
			ans=1;	
			
			if(ans==1){
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("pat_id",pid);
									
					desdtls.add("table","lpatq");
					desdtls.add("table","med");
					desdtls.add("assigneddoc",drcode);
					desdtls.add("details","Update Local Physician");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		}
	   		
		}
		return ans;
	}
	
	public int updateTelePhysician(String pids,String drcode,dataobj obj)throws RemoteException,SQLException{
		int ans=-1;
		System.out.println(pids);
		String uSql="",pid="";
		
		StringTokenizer stpids = new StringTokenizer(pids,"#");
    	while (stpids.hasMoreTokens()){
			pid = stpids.nextToken().toUpperCase();
			//uSql = "update med set referring_doctor = '"+drcode+"' where pat_id='"+pid+"'";
			//mydb.ExecuteSql(uSql);
			uSql = "update tpatq set assigneddoc = '"+drcode+"' where pat_id='"+pid+"'";
			mydb.ExecuteSql(uSql);
			ans=1;	
			
			if(ans==1){
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("pat_id",pid);
									
					desdtls.add("table","tpatq");
					desdtls.add("assigneddoc",drcode);
					desdtls.add("details","Update Tele Physician");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		}
		}
		return ans;
	}
		
	public int delPatient(String pids,String que,dataobj obj)throws RemoteException,SQLException{
		 
		int ans=-1;
		System.out.println(pids);
		String uSql="",pid="";
		StringTokenizer stpids = new StringTokenizer(pids,"#");
    	while (stpids.hasMoreTokens()){
			pid = stpids.nextToken().toUpperCase();
			if(que.equalsIgnoreCase("Local"))
				uSql = "update lpatq set delflag = 'Y' where upper(checked) ='Y' and upper(pat_id)='"+pid+"'";
			else if(que.equalsIgnoreCase("Tele"))
				uSql = "update tpatq set delflag = 'Y' where upper(checked) ='Y' and upper(pat_id)='"+pid+"'";
					

			mydb.ExecuteSql(uSql);
			ans=1;
			
			if(ans==1){
			System.out.println("delPatient >> "+uSql);					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("pat_id",pid);
					
					if(que.equalsIgnoreCase("Local")){
					 	desdtls.add("table","lpatq");
					 	desdtls.add("details","Delete Local Patient");
					}else{
						  desdtls.add("table","tpatq");
						  desdtls.add("details","Delete Tele Patient");
					}
					
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		}
	   		
		}
		
		return ans;
		 
	}

  public int decideTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException
  {
    int i = -1;
    System.out.println(paramString);
    String str1 = "";String str2 = "";String str3 = "";String str4 = "";String str5 = "",referred_doc="";
    StringTokenizer localStringTokenizer = new StringTokenizer(paramString, "#");
   // str2 = "update tpatwaitq set status = 'R' where status = 'W'";
    //this.mydb.ExecuteSql(str2);
    
    referred_doc = mydb.ExecuteSingle("select rg_no from login where uid = '"+paramdataobj.getValue("userid")+"'");

    while (localStringTokenizer.hasMoreTokens())
    {
      str3 = localStringTokenizer.nextToken().toUpperCase();
      
      str1 = "update tpatwaitq set status = 'A' where upper(pat_id)='" + str3 + "' and referred_doc = '"+referred_doc+"' and status = 'W'";
      System.out.println("Update tpatwaitqueue : "+str1);
      this.mydb.ExecuteSql(str1);
      
      str5 = "Select * from tpatwaitq where pat_id = '" + str3 + "' and referred_doc = '"+referred_doc+"'";
      Object localObject = this.mydb.ExecuteQuary(str5);
      
      Vector localVector = (Vector)localObject;
      dataobj localdataobj1 = (dataobj)localVector.get(0);
      
      String str6 = myDate.getCurrentDateMySql();
      String str61 = null; //As per discussion with sir, teleconsultdt default date is null
      String str7 = myDate.getCurrentDateMySql();
      String str8 = localdataobj1.getValue("attending_doc").trim();
      String str9 = localdataobj1.getValue("referred_doc").trim();
      String str10 = localdataobj1.getValue("referred_hospital").trim();
      String str11 = localdataobj1.getValue("local_hospital").trim();
      String str12 = localdataobj1.getValue("sent_by").trim();
      String str13 = localdataobj1.getValue("send_records").trim();
      String str14 = localdataobj1.getValue("userid").trim();
      String str15 = localdataobj1.getValue("usertype").trim();
      String str16 = this.mydb.ExecuteSingle("Select class from med where upper(pat_id) = '" + str3.toUpperCase() + "'");
      
      str4 = "insert into tpatq (pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent)";
      str4 = str4 + " values('" + str3 + "','" + str6 + "'," + str61 + ",'" + str9 + "','" + str8 + "','" + str11 + "','" + str16 + "','N','N','" + str10 + "','N')";
      this.mydb.ExecuteSql(str4);
      System.out.println("decideTelePatWait >> "+str4+" assi :: "+localdataobj1.getValue("referred_hospital").trim());
      i = 1;
      if (i == 1)
      {
        imedixlogger localimedixlogger = new imedixlogger(this.pinfo);
        dataobj localdataobj2 = new dataobj();
        dataobj localdataobj3 = new dataobj();
        localdataobj2.add("pat_id", str3);
        
        localdataobj3.add("table", "tpatwaitq");
        localdataobj3.add("details", "Accept tele Patient");
        
        localimedixlogger.putFormInformation(paramdataobj.getValue("userid"), paramdataobj.getValue("usertype"), 2, localdataobj2, localdataobj3);
      }
    }
    return i;
  }




	
	public String backupRcords(String bkptype,String pid,String ccode, String stdt, String endt)throws RemoteException,SQLException{
		
		String output="<center>",qr="",infil="";
		int cnt=0;
		String bkpdir=createBackupDir(ccode);
		String bakpath=pinfo.tempdatadir+"/backup/"+bkpdir;
		
		
		if(bkptype.equalsIgnoreCase("bydate")){			
			qr = "select pat_id,entrydate,pat_name from med where entrydate >= '"+stdt+"' and entrydate <= '"+endt+"' and pat_id like '"+ccode+"%'"; 	
			output="<B>Back Up in the range of "+"&nbsp;<FONT COLOR=RED>"+stdt+"&nbsp; -- &nbsp;"+endt+"</B></FONT><BR>";
			
		}else if(bkptype.equalsIgnoreCase("bypat")){
			qr = "select pat_id,entrydate,pat_name from med where Upper(pat_id) like '"+pid.toUpperCase() +"%'";
			output="<B>Back Up of : </B>"+"&nbsp;<FONT COLOR=RED>"+pid.toUpperCase()+"</FONT><BR>";	
		}	
			
		Object res=mydb.ExecuteQuary(qr);
		
		
		if(res instanceof String){
			
			//	if(bkptype.equalsIgnoreCase("bydate"))
			//  output=output+"<BR><B><FONT COLOR=GREEN> No Patient ID found in the specified criteria</FONT></B>";
			//	else output=output + "<BR><B><FONT COLOR=GREEN>Patient ID not found </FONT></B>";
			
		}else{
			
			Vector tmp = (Vector)res;
			output=output+"<BR>Bak Dir : "+bkpdir+"<br>";
			output=output+"<br>center = " + ccode +"<br>";
			output=output+"<BR><FONT COLOR=GREEN><U><B>List of patient ID whose backup is taken</B></U></FONT><BR>";		
			
			File bakf=new File(bakpath);
			boolean yy=bakf.mkdirs();
			
			String filnam = bakpath+"/"+bkpdir+".txt";
			
			infil="Date of Backup : "+ myDate.getCurrentDate("dmy",false) +"\n";
			infil+="Center Code : "+ccode+"\n";
			infil+="List of Patient ID's whose backup is taken \n";			
			BackupUtility bku = new BackupUtility(pinfo,ccode,bkpdir); ////projinfo p,String code,String bk
			
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				String patid = temp.getValue("pat_id");
				infil+=patid+"\n";
				
				//metacontent.writeline(patid)
				
				String qrq = "select pat_id from lpatq where pat_id = '"+patid+"'";
				String op=mydb.ExecuteSingle(qrq);
				
				if(op.equalsIgnoreCase("")) 
					output=output+"<UL> <LI> <FONT COLOR=DARKORANGE><B>"+patid+"</B></FONT></UL>";	
				else
					output=output+"<UL> <LI> <FONT COLOR=BLUE><B>"+patid+"</B></FONT></UL>";
					
				bku.createBackup(patid);
				cnt = cnt +1;
			} // end for
		} // end else
		
		if(cnt==0){
			
			if(bkptype.equalsIgnoreCase("bydate"))
				 output=output+"<BR><B><FONT COLOR=GREEN> No Patient ID found in the specified criteria</FONT></B>";
			else output=output + "<BR><B><FONT COLOR=GREEN>Patient ID not found </FONT></B>";
			
		}else{
			output=output +"<BR><B><FONT COLOR=GREEN>Total No. Patient Whose Data Bakup Taken : </FONT></B>";
			output=output +"&nbsp;<B><FONT COLOR=BLUE>"+cnt+"</FONT></B>";
			output=output +"<BR>Back up kept at : <B>"+bakpath+"</B>";
			output=output +" <BR><BR> ";
			output=output + "<FORM METHOD=get ACTION='bkdeleterecord.jsp'>";
			output=output + "<BR><B><CENTER><FONT SIZE='+1'>(ID displayed in </FONT><FONT color=BLUE>BLUE</FONT><FONT> color cannot be deleted from DataBase as they are still in patient queue)</FONT></CENTER></B>";
			output=output + "<BR><B><FONT SIZE='+1' COLOR='RED'>Delete Data of above mentioned Patient from Database</FONT></B><BR><BR>";
			output=output + "<INPUT TYPE='hidden' name=stdt value="+stdt+">";
			output=output + "<INPUT TYPE='hidden' name=updt value="+endt+">";
			output=output + "<INPUT TYPE='hidden' name=patid value="+pid+">";
			output=output + "<INPUT TYPE='hidden' name=bkpdir value="+bkpdir+">";
			output=output + "<INPUT TYPE='hidden' name=bkptype value="+bkptype+">";
		//	output=output + "<INPUT TYPE='submit' name=delete value=Delete style='background-color: DARKBLUE; color: WHITE; font-weight:BOLD; font-style:oblique;' width=5>";
			//output=output + "<INPUT TYPE='button' name=no value=NO style='background-color: DARKBLUE; color: WHITE; font-weight:BOLD; font-style:oblique;' width=5>";
			output=output + "<BR></FORM>";
					
		}
			output=output+ "<BR><BR><CENTER><A HREF='backupinterface.jsp'>Back</A></CENTER>";
			output=output+ "</center>";			
			
			return output;
	
	}
	
	public String deleteBackupRcords(String string) throws RemoteException, SQLException {
        String[] arrstring = string.split("#");
        for (int i = 0; i < arrstring.length; ++i) {
            try {
                BackupUtility.delAllRecords((String)arrstring[i], (projinfo)this.pinfo);
                continue;
            }
            catch (Exception var4_4) {
                // empty catch block
            }
        }
        return "Done";
    }


	
	
	public String getAllBackupDirs(String backup)throws RemoteException,SQLException{
		String backupdirs="";
		String bakpath=pinfo.tempdatadir+"/"+backup;
				
		try{
			File bkpdir=new File(bakpath);
			String[] childdir = bkpdir.list();
			if( !bkpdir.isDirectory() || childdir.length <= 0 ){
				backupdirs="None";
       		}
			else{
				for(int i=0;  i < childdir.length; i++){
					File pdir=new File(bkpdir,childdir[i]);
					if(pdir.isDirectory()){
						backupdirs=backupdirs+pdir.getName()+"#";
					}
				}
			}

		}catch (Exception e) {
			System.out.println("Error in getAllBackupDirs :"+e.toString());
			backupdirs="None";
		}
		System.out.println("AdminJobs => getAllBackupDirs: "+backupdirs);
		return backupdirs;
	}
	
	public String restoreRcords(String bkpdir)throws RemoteException,SQLException{
		
		String ResPatList=getAllBackupDirs("backup/"+bkpdir);
	//	String patlist[]=ResPatList.split("#");
		uploadtodb utodb=new uploadtodb(bkpdir,pinfo);
        utodb.StratUpload();
		return ResPatList;
	}
	
	public Object searchPatient(String que, String searchBy,String serValue,String ccode,String usrccode)throws RemoteException,SQLException{
		Object obj=null;
		String qr="",cond="";
	
		serValue=serValue.replaceAll("'","''");
		
		if(usrccode.equalsIgnoreCase("XXXX")) cond="";
		else cond=" and tpatq.assignedhos like '"+usrccode+"%'";
		
		if(que.equalsIgnoreCase("Local"))
			qr= "select med.pat_id, med.entrydate, med.class, med.pre,med.pat_name,med.m_name,med.l_name,'NOT IN PATQ' as checked from med where med.pat_id in (select lpatq.pat_id from lpatq where upper(lpatq.delflag)='Y' ) AND med.pat_id like '"+ccode+"%' and ";
		else if(que.equalsIgnoreCase("Tele"))
			qr= "select med.pat_id, med.entrydate , med.class ,med.pre,med.pat_name,med.m_name,med.l_name, 'NOT IN PATQ' as checked from med where med.pat_id in (select tpatq.pat_id from tpatq where upper(tpatq.delflag)='Y' "+ cond +" ) AND med.pat_id like '"+ccode+"%' and ";
		
		qr=AddToSQL(qr,searchBy,serValue);
			
		if(que.equalsIgnoreCase("Local"))
			qr= qr+ " union select distinct lpatq.pat_id, med.entrydate, med.class,med.pre,med.pat_name,med.m_name,med.l_name, checked from med, lpatq where lpatq.pat_id = med.pat_id  and upper(lpatq.delflag)='N' and med.pat_id like '"+ccode+"%' and ";
		else if(que.equalsIgnoreCase("Tele"))
			qr= qr+ " union select distinct tpatq.pat_id, med.entrydate, med.class,med.pre,med.pat_name,med.m_name,med.l_name, checked from med, tpatq where tpatq.pat_id = med.pat_id  and upper(tpatq.delflag)='N' "+ cond +" and med.pat_id  like '"+ccode+"%' and ";
		
		qr=AddToSQL(qr,searchBy,serValue);
		
		System.out.println(qr);
		
		
		
		//	try
		//	{
		//		FileOutputStream out = new FileOutputStream("D:/Log.txt");
		
		//		PrintStream p = new PrintStream( out );
				
		//		p.println (qr);
		
		//		p.close();
		//	}
		//	catch (Exception e)
		//	{
		//		System.err.println ("Error writing to file");
		//	}
			
		obj=mydb.ExecuteQuary(qr);
		return obj;
	}
	
	
	public Object searchPatientAddToQ(String que, String searchBy,String serValue,String ccode)throws RemoteException,SQLException{
		Object obj=null;
		String qr="";
		
		if(que.equalsIgnoreCase("Local"))
			qr= "select med.pat_id, med.entrydate, med.class, med.pre,med.pat_name,med.m_name,med.l_name, 'NOT IN PATQ' as checked from med where med.pat_id not in (select lpatq.pat_id from lpatq where upper(lpatq.delflag)='N' ) AND ";  
		else if(que.equalsIgnoreCase("Tele"))
			qr= "select med.pat_id, med.entrydate,med.class, med.pre,med.pat_name,med.m_name,med.l_name, 'NOT IN PATQ' as checked from med where med.pat_id not in (select tpatq.pat_id from tpatq where upper(tpatq.delflag)='N' ) AND ";  	
		qr=AddToSQL(qr,searchBy,serValue);
				
		obj=mydb.ExecuteQuary(qr);
		return obj;
	}
	
	
	public int addToQue(String que, String pid)throws RemoteException,SQLException{
		int ans=1;
		String qr="";
		String a="";
		
		String qsql="Select pat_id from lpatq where upper(pat_id)='"+pid.toUpperCase()+"'";
		String id=mydb.ExecuteSingle(qsql);
		
		if(id.equals("")){
			
			qsql="Select * from med where upper(pat_id)='"+pid.toUpperCase()+"' order by entrydate desc";
			Object res = mydb.ExecuteQuary(qsql);
	 	    
	 	    dataobj tmp=null;
	 	    if(res instanceof String) {
		 		System.out.println("Med Form Not Found Error :"+res);
		 		return 0;
		 	}
		 	else{
				 Vector vtmp = (Vector)res;
				 if(vtmp.size()>0){
				 	tmp = (dataobj) vtmp.get(0);
				 }else{
				 	System.out.println("Error :");
			 		return 0;
				 }
		 	}
		 	if(que.equalsIgnoreCase("Local")){
		 		
			 	qr = "insert into lpatq (pat_id, entrydate, appdate, assigneddoc,discategory,checked,delflag) values ( ";
				qr=qr+"'"+pid+"','"+ tmp.getValue("entrydate")+"','";
				qr=qr+"'"+myDate.getCurrentDate("ymd",true)+"','"+ tmp.getValue("referring_doctor")+"','";
				qr=qr+"'"+tmp.getValue("class")+"','N','N')";
		 	}else if(que.equalsIgnoreCase("Tele")){
			 	qr = "insert into tpatq (pat_id, entrydate, teleconsultdt, assigneddoc,refer_doc,refer_center,discategory,checked,delflag) values ( ";
				qr=qr+"'"+pid+"','"+ tmp.getValue("entrydate")+"','";
				qr=qr+"'"+myDate.getCurrentDate("ymd",true)+"','"+ tmp.getValue("referring_doctor")+"','";
				qr=qr+"'"+tmp.getValue("referring_doctor")+"','"+pid.substring(0,4)+"','";
				qr=qr+"'"+tmp.getValue("class")+"','N','N')";
			
		 	}
		 	
		 	a = mydb.ExecuteSql(qr);
		 	
		}else{
			if(que.equalsIgnoreCase("Local"))
				qr = "Update lpatq set delflag = 'N', checked ='N' where pat_id = '"+pid+"'";
			else if(que.equalsIgnoreCase("Tele")) 
				qr = "Update tpatq set delflag = 'N', checked ='N' where pat_id = '"+pid+"'";	
	 		a=mydb.ExecuteSql(qr);
		}
		
		if(a.equalsIgnoreCase("Done")) ans=1;
     	else{
     		System.out.println("Error :");
     		ans=0;
     	}
     
		return ans;
	}		
		
	private String createBackupDir(String cod){
		String slno="",cdt;
		boolean bool;
		int count=0;
		File backf=new File(pinfo.tempdatadir+"//backup");		
		if(backf.exists()==false) //if backup dir does not exists create it
		{
			boolean y1=backf.mkdirs();
		}
	
		if(backf.exists())
		{
			String listdir[]=backf.list();
			count=listdir.length+1;
			slno=String.valueOf(count);
			if(count < 10)
				slno = "00"+String.valueOf(count);
			if(count >=10 && count < 100)
				slno = "0"+String.valueOf(count);
		}
		
		cdt=myDate.getCurrentDate("dmy",false);		
		String bakdir = "BAK"+cod+cdt+slno;
		return bakdir;
				
	}
	
	private String AddToSQL(String strSQL,String str,String sval){
		
	if(str.equalsIgnoreCase("id")) 
		strSQL = strSQL + " Upper(med.pat_id) LIKE '%" + sval.toUpperCase() + "%' ";
	else if(str.equalsIgnoreCase("name"))
		strSQL = strSQL + " ( Upper(med.pat_name) LIKE '%" + sval.toUpperCase() + "%' or Upper(med.l_name) LIKE '%" + sval.toUpperCase() + "%' or Upper(med.m_name) LIKE '%" + sval.toUpperCase() + "%' ) ";
	else if(str.equalsIgnoreCase("class"))
		strSQL = strSQL + " Upper(med.class) LIKE '" + sval.toUpperCase() + "%'";
	else if(str.equals("date"))
		strSQL = strSQL + " date(med.entrydate) = '" + sval + "' ";
	
	return strSQL;
	
	}

  public int rejectTelePatWait(String paramString, dataobj paramdataobj) throws RemoteException, SQLException
  {
    int i = -1;
    System.out.println(paramString);
    String str1 = "";String str2 = "";String str3 = "";String str4 = "";String str5 = "",referred_doc="";
    StringTokenizer localStringTokenizer = new StringTokenizer(paramString, "#");
   // str2 = "update tpatwaitq set status = 'R' where status = 'W'";
    //this.mydb.ExecuteSql(str2);
    referred_doc = mydb.ExecuteSingle("select rg_no from login where uid = '"+paramdataobj.getValue("userid")+"'");
    while (localStringTokenizer.hasMoreTokens())
    {
      str3 = localStringTokenizer.nextToken().toUpperCase();
      
      str1 = "update tpatwaitq set status = 'R',req_id='"+paramdataobj.getValue("rejectionReason")+"' where upper(pat_id)='" + str3 + "' and referred_doc='"+referred_doc+"' and status='W'";
      
      this.mydb.ExecuteSql(str1);
		System.out.println(str1);
      i = 1;
      if (i == 1)
      {
        imedixlogger localimedixlogger = new imedixlogger(this.pinfo);
        dataobj localdataobj2 = new dataobj();
        dataobj localdataobj3 = new dataobj();
        localdataobj2.add("pat_id", str3);
        
        localdataobj3.add("table", "tpatwaitq");
        localdataobj3.add("details", "Disinclined tele Patient");
        
        localimedixlogger.putFormInformation(paramdataobj.getValue("userid"), paramdataobj.getValue("usertype"), 2, localdataobj2, localdataobj3);
      }
    }
    return i;
  }

  public String readSytemLog(String date) throws RemoteException, FileNotFoundException, IOException{
	 String dest = pinfo.SystemLoggerPath;
	 FileInputStream fis = new FileInputStream(dest+"/"+date+"AccessLog.xml");
	int fileLength = fis.available();
	String result = "";
	for(int i=0;i<fileLength;i++){
		result += (char)fis.read();
	}
	return result;
  }
			
	
}

