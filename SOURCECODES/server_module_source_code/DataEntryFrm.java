package imedix;
import java.util.*;
import java.rmi.*;
import java.sql.*;
import java.io.*;
import java.rmi.server.*;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;
import logger.*;
import org.json.simple.*;
import org.json.simple.parser.*;
import java.util.Iterator;
import org.apache.commons.io.*;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This class used for Manage Data Entry Operations of iMediX Systems.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see DataEntryFrmInterface
 */
 
public class DataEntryFrm extends UnicastRemoteObject implements DataEntryFrmInterface {
		
	projinfo pinfo;
	dball mydb;
	
	/**
     * Constructor used to create this object.
     * @param p server Configuration class object.
     * @see projinfo
     */
     
	public DataEntryFrm(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public String InsertMed(String cod,dataobj obj)throws RemoteException,SQLException {
		dataobj tmp= obj;
		String ans="Error";

		String key="",val="",qr="",id="",qr1,qr2,qr3;
		
		String dat="",dat1="";
					
		try{
		
		Date dt = new Date();
		int dd,mm,yy;
	

		dd = dt.getDate();
		mm= dt.getMonth()+1;;
		yy = dt.getYear()+ 1900;
		if (dd <10) { dat = "0" + dd; }
		else { dat = ""+dd; }
		if(mm<10) {dat = dat + "0"+mm; }
		else {dat = dat+mm; }
		dat =dat + Integer.toString(yy).substring(2);
			
		//dat1 = tmp.getValue("entrydate"); //Integer.toString(yy)+"/"+dat.substring(2,4)+"/"+dat.substring(0,2);
	
		dat1 = myDate.getCurrentDateMySql();
		tmp.replace("entrydate",dat1);
		//cod=cod+"."+dat;
		cod=cod+dat;
		//qr = "select count(pat_id) as p from med where left(pat_id,10) = '" + cod + "'"; 
		qr = "select count(pat_id) as p from med where pat_id like '" + cod + "%'"; 
	//	System.out.println(qr);
		String cnt=mydb.ExecuteSingle(qr);
		if(cnt.equalsIgnoreCase("")) cnt="0";
		int nu = Integer.parseInt(cnt);
		if (nu < 10) { id = cod+"000"+cnt; }
		else if (nu < 100){ id = cod+"00"+cnt; }
		else { id = cod+"0"+cnt; }
				
		qr = "select * from med";
		String token = mydb.FieldTypesmeta(qr);
		StringTokenizer st = new StringTokenizer(token,"=&");
				
	//	qr1 = "insert into med values('"+id+"','"+dat1+"',";
		qr1 = "insert into med values('"+id+"',";
							
		while(st.hasMoreTokens())
		{
			key = st.nextToken();
			val = st.nextToken();
			
		    //System.out.println(key+"="+val);
		//|| key.trim().equalsIgnoreCase("entrydate")
		
			if( key.trim().equalsIgnoreCase("pat_id")) continue;
			else{
				if(key.trim().equalsIgnoreCase("serno")) qr1 =  qr1+"0)";
				else{
					String qv=tmp.getValue(key);
					//qv=qv.replaceAll("'","\\\\'");
					qv=qv.replaceAll("'","''");
										
					
					if(qv.length()>0){
						if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME") ||val.equalsIgnoreCase("VARCHAR")){
						
							if(key.trim().equalsIgnoreCase("dateofbirth")) qv=myDate.getFomateDate("ymd",true,tmp.getValue("dateofbirth"));
							qr1 = qr1+"'"+qv+"',";
						}

						else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr1 = qr1+qv+",";
							else {
								//System.out.println(val);
								qr1 = qr1+"'" + qv + "',";
								
								}
					}else
					 qr1 = qr1 + "NULL,";					
				}
				
			}
	   }
	      
	   //	lastupdate
	   String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'");   	
	   qr2 = "insert into listofforms values('"+id+"','med','"+dat1+"',"+"0"+",'N',null,null,'"+rg_no+"',null)";	   
	   qr3 = "insert into lpatq values('"+id+"','"+dat1+"',null,'"+tmp.getValue("referring_doctor")+"','"+tmp.getValue("class")+"','N','N','"+tmp.getValue("opdno")+"')";
	   String qr4="insert into patientvisit(pat_id,visitdate,attending_person) values('"+id+"','"+dat1+"','"+tmp.getValue("referring_doctor")+"')";
	   
	   //START TRANSACTION
	  
	   //String trns="BEGIN; "+qr1+"; "+qr2+"; "+qr3+"; "+qr4+"; COMMIT;";
	   //mydb.ExecuteSql(trns);
	   
	   String trns=qr1+"#IMX#"+qr2+"#IMX#"+qr3+"#IMX#"+qr4;
	   ans = mydb.ExecuteTrans(trns);
	    
	  System.out.println(qr1);	   
	 // mydb.ExecuteSql(qr1);
	 //  mydb.ExecuteSql(qr2);
	  System.out.println(qr2);
	 // mydb.ExecuteSql(qr3);
	 System.out.println(qr3);
	 //  mydb.ExecuteSql(qr4);
	 System.out.println(qr4);
	  
	  
	   }catch(Exception e){
	   		id="Error";
	   }
	   
	   if(ans.equalsIgnoreCase("Error")) id="Error";
	   else{
	   	
	   	////////////////////////// log //////////////////////////////////////////////////////////////////
			imedixlogger imxlog = new imedixlogger(pinfo);
			dataobj keydtls = new dataobj();
			dataobj desdtls = new dataobj();
			keydtls.add("patid",id);
			keydtls.add("entrydate",dat1);
			
			desdtls.add("table","MED");
			desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='MED'"));
			imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
	  /////////////////////////////////////////////// log ////////////////////////////////////////////

	   }
	   
	   return id;
}

	public String InsertMedWithoutDocAssign(String cod,dataobj obj)throws RemoteException,SQLException {
		dataobj tmp= obj;
		String ans="Error";

		String key="",val="",qr="",id="",qr1="",qr2="",qr3;
		
		String dat="",dat1="";
					
		try{
		
		Date dt = new Date();
		int dd,mm,yy;
	

		dd = dt.getDate();
		mm= dt.getMonth()+1;;
		yy = dt.getYear()+ 1900;
		if (dd <10) { dat = "0" + dd; }
		else { dat = ""+dd; }
		if(mm<10) {dat = dat + "0"+mm; }
		else {dat = dat+mm; }
		dat =dat + Integer.toString(yy).substring(2);
			
		//dat1 = tmp.getValue("entrydate"); //Integer.toString(yy)+"/"+dat.substring(2,4)+"/"+dat.substring(0,2);
	
		dat1 = myDate.getCurrentDateMySql();
		tmp.replace("entrydate",dat1);
		//cod=cod+"."+dat;
		cod=cod+dat;
		//qr = "select count(pat_id) as p from med where left(pat_id,10) = '" + cod + "'"; 
		qr = "select count(pat_id) as p from med where pat_id like '" + cod + "%'"; 
	//	System.out.println(qr);
		String cnt=mydb.ExecuteSingle(qr);
		if(cnt.equalsIgnoreCase("")) cnt="0";
		int nu = Integer.parseInt(cnt);
		if (nu < 10) { id = cod+"000"+cnt; }
		else if (nu < 100){ id = cod+"00"+cnt; }
		else { id = cod+"0"+cnt; }
				
		qr = "select * from med";
		String token = mydb.FieldTypesmeta(qr);
		StringTokenizer st = new StringTokenizer(token,"=&");
				
	//	qr1 = "insert into med values('"+id+"','"+dat1+"',";
		qr1 = "insert into med values('"+id+"',";
							
		while(st.hasMoreTokens())
		{
			key = st.nextToken();
			val = st.nextToken();
			
		    //System.out.println(key+"="+val);
		//|| key.trim().equalsIgnoreCase("entrydate")
		
			if( key.trim().equalsIgnoreCase("pat_id")) continue;
			else{
				if(key.trim().equalsIgnoreCase("serno")) qr1 =  qr1+"0)";
				else{
					String qv=tmp.getValue(key);
					//qv=qv.replaceAll("'","\\\\'");
					qv=qv.replaceAll("'","''");
										
					
					if(qv.length()>0){
						if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME") ||val.equalsIgnoreCase("VARCHAR")){
						
							if(key.trim().equalsIgnoreCase("dateofbirth")) qv=myDate.getFomateDate("ymd",true,tmp.getValue("dateofbirth"));
							qr1 = qr1+"'"+qv+"',";
						}

						else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr1 = qr1+qv+",";
							else {
								//System.out.println(val);
								qr1 = qr1+"'" + qv + "',";
								
								}
					}else
					 qr1 = qr1 + "NULL,";					
				}
				
			}
	   }
	      
	   //	lastupdate
	   String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'");   	
	   qr2 = "insert into listofforms values('"+id+"','med','"+dat1+"',"+"0"+",'N',null,null,'"+rg_no+"',null)";	   
	   //qr3 = "insert into lpatq values('"+id+"','"+dat1+"',null,'"+tmp.getValue("referring_doctor")+"','"+tmp.getValue("class")+"','N','N','"+tmp.getValue("opdno")+"')";
	   //String qr4="insert into patientvisit(pat_id,visitdate,attending_person) values('"+id+"','"+dat1+"','"+tmp.getValue("referring_doctor")+"')";
	   
	   //START TRANSACTION
	  
	   //String trns="BEGIN; "+qr1+"; "+qr2+"; "+qr3+"; "+qr4+"; COMMIT;";
	   //mydb.ExecuteSql(trns);
	   
	   String trns=qr1+"#IMX#"+qr2;
	   ans = mydb.ExecuteTrans(trns);
	    
	  System.out.println(qr1);	   
	 // mydb.ExecuteSql(qr1);
	 //  mydb.ExecuteSql(qr2);
	  System.out.println(qr2);
	 // mydb.ExecuteSql(qr3);
	// System.out.println(qr3);
	 //  mydb.ExecuteSql(qr4);
	// System.out.println(qr4);
	  
	  
	   }catch(Exception e){
	   		id="Error";
		  System.out.println("InsertMedWithoutDocAssign()>> "+qr1);	   
		 // mydb.ExecuteSql(qr1);
		 //  mydb.ExecuteSql(qr2);
		  System.out.println("InsertMedWithoutDocAssign()>> "+qr2);	   		
	   }
	   
	   if(ans.equalsIgnoreCase("Error")) id="Error";
	   else{
	   	
	   	////////////////////////// log //////////////////////////////////////////////////////////////////
			imedixlogger imxlog = new imedixlogger(pinfo);
			dataobj keydtls = new dataobj();
			dataobj desdtls = new dataobj();
			keydtls.add("patid",id);
			keydtls.add("entrydate",dat1);
			
			desdtls.add("table","MED");
			desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='MED'"));
			imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
	  /////////////////////////////////////////////// log ////////////////////////////////////////////

	   }
	   
	   return id;
}



  
  //method used to Update a record
  public int updateMed(dataobj obj)throws RemoteException,SQLException{
     int ans=1;
	 dataobj tmp;
	 
	 String key="",val="",qr="",qryfld="",qryval="";
	 
	 String id=obj.getValue("pat_id");
	 String sl=obj.getValue("serno");
	 String dat1 = myDate.getCurrentDateMySql();
	 obj.replace("entrydate",dat1);
		
	//////// 
	 qr = "select * from med where pat_id = '"+id+"' and serno ="+ sl;
	 Object res=mydb.ExecuteQuary(qr);
	 
	 if(res instanceof String) {
	 	System.out.println("Error :"+res);
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
	///////////////
	 qr ="select * from med_history";
	 
	 String token = mydb.FieldTypesmeta(qr);
	 StringTokenizer st = new StringTokenizer(token,"=&");
	 
	 while(st.hasMoreTokens()){
		key = st.nextToken();
		val = st.nextToken();
				
		String qv=tmp.getValue(key);
		//qv=qv.replaceAll("'","\\\\'");
		qv=qv.replaceAll("'","''");
		
	//	System.out.println(key+">>"+qv);
		qryfld=qryfld+key+",";
			
			if(qv.length()>0){
				if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
					qryval = qryval+"'"+qv+"',";
					
				else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
					String dt="";
					
					if(key.equalsIgnoreCase("entrydateofchange")) dt=dat1;
					else if(key.equalsIgnoreCase("dateofbirth") || key.equalsIgnoreCase("entrydate") ) dt=qv;
					else dt=myDate.getFomateDate("ymd",true,qv);
					qryval = qryval+"'"+dt+"',";
					
				}
				else if (val.equalsIgnoreCase("INTEGER") || val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
				qryval = qryval+qv+",";
				else {
			//		System.out.println("MatchNot Found :"+val);
					qryval = qryval+"'"+ qv +"',";
				}
			}else{
				if(key.equalsIgnoreCase("entrydateofchange")) {
					String dt=myDate.getCurrentDate("ymd",true);
					qryval = qryval+"'"+dt+"',";
				}
				else 	qryval = qryval + "null,";	
			}
				
							
     } // while
     
     qryfld = qryfld.substring(0,qryfld.lastIndexOf(','));
	 qryval = qryval.substring(0,qryval.lastIndexOf(','));
	
	 qryfld = "( " + qryfld + " ) ";
	 qryval = "( " + qryval + " ) ";
	 String iSql = "INSERT INTO med_history "+qryfld+" VALUES "+qryval;
   
     String a=mydb.ExecuteSql(iSql);
     if(a.equalsIgnoreCase("Done")) ans=1;
     else{
     	System.out.println("Error :");
     	return 0;
     }

     qr = "update med set ";

     for(int i=0;i<obj.getLength();i++){
     	key = obj.getKey(i);
		val = obj.getValue(i);
		if( key.trim().equalsIgnoreCase("pat_id") || key.trim().equalsIgnoreCase("entrydate") || key.trim().equalsIgnoreCase("serno") || key.trim().equalsIgnoreCase("userid") || key.trim().equalsIgnoreCase("center")) continue;
		else{
			val=val.replaceAll("'","''");
			if(val.equals("")) qr=qr + key + " = null, ";		
			else qr=qr + key +" ='"+val+"', ";
		}
     } // for
 	 
 	 qr = qr.substring(0,qr.lastIndexOf(','));	
     qr=qr+" where pat_id = '"+id+"' and serno= "+sl + " ";
     a=mydb.ExecuteSql(qr);
     
	 if(a.equalsIgnoreCase("Done")){
	 	ans=1;
	 	////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					
					keydtls.add("patid",obj.getValue("pat_id"));
					keydtls.add("entrydate",dat1);
					
					desdtls.add("table","MED");
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='MED'"));
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
		/////////////////////////////////////////////// log ////////////////////////////////////////////
	 }else{
     	System.out.println("Error :");
     	return 0;
     }
     
     qr = "Update lpatq set discategory = '"+obj.getValue("class")+"', assigneddoc ='"+ obj.getValue("referring_doctor") +"' where pat_id = '"+tmp.getValue("pat_id")+"'"; 
	 a=mydb.ExecuteSql(qr);
    // String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+obj.getValue("userid")+"' and center ='"+obj.getValue("center")+"'");   	
	// String qr2 = "insert into listofforms values('"+id+"','med','"+dat1+"',"+"0"+",'N',null,null,'"+rg_no+"',null)";	   
	// a=mydb.ExecuteSql(qr2); 
	 
     return ans;
     
  }
       
    //method used to Add a record
    
    public int  InsertFrmAll(dataobj obj )throws RemoteException,SQLException {
    		int ans =0,tag=0;
    		dataobj tmp= obj;
    		String qr="",tname="",key="",val="";
    		//String cdt=myDate.getCurrentDate("ymd",true);  
    			
    		String cdt = myDate.getCurrentDateMySql();
    		tmp.replace("entrydate",cdt);
    		tname=tmp.getValue("frmnam");
    			
			int sl=getserno(tname,tmp.getValue("pat_id"));
			
			tmp.replace("serno",Integer.toString(sl));
			
    		try{
    		
    			qr = "select * from "+ tname;
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				qr = "insert into "+tname+" values( ";
					
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
					if(key.trim().equalsIgnoreCase("serno")){
						qr =  qr+ sl +")";
						tag=1;
					}else{
						String qv=tmp.getValue(key);

						//qv=qv.replaceAll("'","\\\\'");

						qv=qv.replaceAll("'","''");
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
								qr = qr+"'"+qv+"',";
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								String dt="";
								if(key.equalsIgnoreCase("entrydate")){
									dt=qv;
								}else if(key.equalsIgnoreCase("testdate")){
									dt=myDate.getDateMySql(qv);
								}else{
									dt=myDate.getFomateDate("ymd",true,qv);
								}
								qr = qr+"'"+dt+"',";
							}else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr = qr+qv+",";
							else {
								//	System.out.println("MatchNot Found :" +tname+":"+val);
									qr = qr+"'"+ qv +"',";
									}
						}else
							qr = qr + "null,";					
					}
				}
				
				if(tag==0) {
					qr=qr.substring(0,qr.length()-1);
					qr = qr+ " )";
					}
					
			//	System.out.println(qr);
	   		//	mydb.ExecuteSql(qr);
	   			
	   			String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'"); 
	   			String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent,rg_no)"; 
				sqlQuery+="values('"+tmp.getValue("pat_id")+"','"+tname+"','"+cdt+"',"+sl+",'N','"+rg_no+"')";
			
			//	System.out.println(sqlQuery);
	   		//	mydb.ExecuteSql(sqlQuery);
	   			
	   			String trns=qr+"#IMX#"+sqlQuery;
	   			
	   			String ans1 = mydb.ExecuteTrans(trns);
	   			
	   			System.out.println("ans1>>>>>>>>>>>>"+ans1);

				if(ans1.equalsIgnoreCase("Done")){

					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",tmp.getValue("pat_id"));
					keydtls.add("entrydate",cdt);
					
					desdtls.add("table",tname);
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='"+tname+"'"));
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		
	   		
		   			if(tname.equalsIgnoreCase("pre")){
		   				String appdt=tmp.getValue("apptdate");
		   				sqlQuery="";
		   				if(appdt.length()==0)
		   					sqlQuery = "Update lpatq set appdate = null, checked ='Y' where pat_id = '"+tmp.getValue("pat_id")+"'";
		   				else{
		   					appdt=myDate.getFomateDate("ymd",true,appdt);
		   					sqlQuery = "Update lpatq set appdate = '"+appdt+"', checked ='Y' where pat_id = '"+tmp.getValue("pat_id")+"'";
		   				}
		   				
		   			System.out.println("Pre :"+sqlQuery);
		   			mydb.ExecuteSql(sqlQuery);
		   				
		   			}
		   			
		   			if(tname.equalsIgnoreCase("prs")){
		   				sqlQuery = "Update tpatq set checked ='Y' where pat_id = '"+tmp.getValue("pat_id")+"'";	   				
		   				System.out.println("Pre :"+sqlQuery);
		   				mydb.ExecuteSql(sqlQuery);	
		   			}
		   			
	    			ans =1;	
	    			//System.out.println("Pre :"+sqlQuery);
					updateAttachmentAllRecords(tmp);
						    			
    			}/////// 		
    		}catch(Exception e){
    			System.out.println("Exception :"+e);
    			ans =0;	
    		}
    	return ans;
    	
    }
    
     //method used to Add a record for Layers forms
    public int  InsertFrmLayers(dataobj obj )throws RemoteException,SQLException {
    		int ans =0,lftag=1;
    		String trns="";
    		dataobj tmp= obj;
    		String qr="",tname="",key="",val="",fld,tmptname="";
    		int sl=0;
    		String cdt = myDate.getCurrentDateMySql();
			tmp.replace("entrydate",cdt);
			
    		try{
    			tname=tmp.getValue("frmnam");
    			StringTokenizer frms = new StringTokenizer(tmp.getValue("frmnam"),"#");
    			while (frms.hasMoreTokens())
				{
				 tname = frms.nextToken().toLowerCase();
				
				 if(lftag==1){
					sl=getserno(tname,tmp.getValue("pat_id"));
				}
    			qr = "select * from "+ tname;
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				fld = " (";
				qr  = " values( ";
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
						
					if(key.trim().equalsIgnoreCase("serno")){
						qr =  qr+ sl+",";
						fld=fld+key+",";
						
					}else{
						String qv=tmp.getValue(key);
						//qv=qv.replaceAll("'","\\\\'");
						qv=qv.replaceAll("'","''");
						fld=fld+key+",";
							
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
								qr = qr+"'"+qv+"',";
								
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								String dt="";
								if(key.equalsIgnoreCase("entrydate")){
									dt=qv;
								}else if(key.equalsIgnoreCase("testdate")){
									dt=myDate.getDateMySql(qv);
								}else{
									dt=myDate.getFomateDate("ymd",true,qv);
								}
								qr = qr+"'"+dt+"',";
							}
							else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
								qr = qr+qv+",";
							else {
					//			System.out.println("MatchNot Found :" +tname+":"+val);
								qr = qr+"'"+ qv +"',";
							}
						}else
							qr = qr + "null,";					
					}
				}
				
				fld=fld.substring(0,fld.length()-1)+")";
				qr=qr.substring(0,qr.length()-1)+")";
				qr="insert into "+tname +  fld + qr;				
			//	System.out.println("\nQr : "+qr);
			//	mydb.ExecuteSql(qr);
				trns=trns+qr+"#IMX#";
				if(lftag==1){
	   				String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'"); 	 	   					
	   				String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent,rg_no)"; 
					sqlQuery+="values('"+tmp.getValue("pat_id")+"','"+tname+"','"+cdt+"',"+sl+",'N','"+rg_no+"')";					
					//System.out.println(sqlQuery);
		   			//mydb.ExecuteSql(sqlQuery);
		   			trns=trns+sqlQuery+"#IMX#";
		   			tmptname=tname;
		   			lftag=0;
	   			}
    		  }// while token
    		  
    		   	trns=trns.substring(0,trns.length()-5);
    		   	System.out.println(trns);
    		  	String ans1 = mydb.ExecuteTrans(trns);
   				if(ans1.equalsIgnoreCase("Done")){
   					 ans=1;
   				
   				////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",tmp.getValue("pat_id"));
					keydtls.add("entrydate",cdt);
					
					desdtls.add("table",tmptname);
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='"+tmptname+"'"));
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
				/////////////////////////////////////////////// log ////////////////////////////////////////////

	 
   				}else ans=0;
	   				
    		}catch(Exception e){
    			ans =0;	
    		}
    		
    	return ans;	
    }
    ////
    
      //method used to Delete a record
    public int  deleteRecord(String table, String Cond )throws RemoteException, SQLException {
    		return 1;
    }
            
    public int UploadHttp(dataobj obj,byte[] b)throws RemoteException,SQLException {
    	
    		int ans =0,tag=0;
    		dataobj tmp= obj;
    		String qr="",tname="",key="",val="",type="",fld="",imgtyp="",desc="";
    		
    		String cdt = myDate.getCurrentDateMySql();
			tmp.replace("entrydate",cdt);
			    		
    		try{
    			type=tmp.getValue("type");
    			imgtyp=tmp.getValue("imgtyp");
    			
				if(type.equalsIgnoreCase("DOC") || type.equalsIgnoreCase("SND") || type.equalsIgnoreCase("TEG")){
					desc="Document";
					tname="patdoc";
				}else if(type.equalsIgnoreCase("MOV") || imgtyp.equalsIgnoreCase("M")){
					 desc="movies";
					 tname="patmovies";
				}else{
					 desc="images";
					 tname="patimages";
				}
				
    			qr = "select * from "+ tname;
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				fld=" (";
				qr = " values( ";
				
				int sl=getserno(tname,tmp.getValue("pat_id"),type);
				
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
					
			//		System.out.println(key +"="+val);
					
					if(key.trim().equalsIgnoreCase("serno")){
						qr =  qr+ sl+",";
						fld=fld+key+",";
						
					}else{
						
						String qv=tmp.getValue(key);
						//qv=qv.replaceAll("'","\\\\'");
						qv=qv.replaceAll("'","''");
						
						fld=fld+key+",";
						
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
								qr = qr+"'"+qv+"',";
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								String dt="";
								if(key.equalsIgnoreCase("entrydate")){
									dt=qv;
								}else if(key.equalsIgnoreCase("testdate")){
									dt=myDate.getDateMySql(qv);
								}else{
									dt=myDate.getFomateDate("ymd",true,qv);
								}
								qr = qr+"'"+dt+"',";
							}
							else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr = qr+qv+",";
							
							else {
						//			System.out.println("MatchNot Found :" +tname+":"+val);
									qr = qr+"'"+ qv +"',";
								}
						}else if (val.equalsIgnoreCase("blob") || val.equalsIgnoreCase("longblob") || val.equalsIgnoreCase("mediumblob")){
								if(b==null) qr = qr + "null,";
								else qr=qr+"?,";
						}else
							qr = qr + "null,";					
					}
				}
				
				//fld=fld+"patpic)";
				//qr=qr+"?)";
				
				fld=fld.substring(0,fld.length()-1)+")";
				qr=qr.substring(0,qr.length()-1)+")";
				qr="insert into "+tname + fld + qr;
								
				System.out.println("qr "+qr);
				
			//	System.out.println("QR"+qr);
				String a="";
				
				if(b==null) a=mydb.ExecuteSql(qr);
				else a=mydb.ExecuteImage(qr,b);
				
				if(a.equalsIgnoreCase("Done")){
					String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'"); 
					String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent,rg_no)"; 
					sqlQuery+="values('"+tmp.getValue("pat_id")+"','"+tname+"','"+cdt+"',"+sl+",'N','"+rg_no+"')";
					System.out.println("sqlQuery "+sqlQuery);
					mydb.ExecuteSql(sqlQuery);
					
				////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",tmp.getValue("pat_id"));
			   		keydtls.add("entrydate",cdt);
					
					desdtls.add("table",tname);
					desdtls.add("details",desc+" Uploaded ("+type+")");
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
				/////////////////////////////////////////////// log ////////////////////////////////////////////

				}

	   		//	System.out.println(a);
	   			ans = sl;
	   			
    		}catch(Exception e){
    			ans =-1;	
    		}
    		
    	return ans;
    }
            
    public String  SaveMarkImg(dataobj obj,byte[] b)throws RemoteException,SQLException{
    	
    	String ans = "Save";
    		dataobj tmp= obj;
    		String qr="",tname="",key="",val="",type="",fld="",imgtyp="";
    		String cdt = myDate.getCurrentDateMySql();
			tmp.replace("entrydate",cdt);
    		try{
    			type=tmp.getValue("type");
    			qr = "select * from refimages";
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				fld=" (";
				qr = " values( ";
				
				int sl=getserno("refimages",tmp.getValue("pat_id"),type);
				
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
					
			//		System.out.println(key +"="+val);
					
					if(key.trim().equalsIgnoreCase("serno")){
						qr =  qr+ sl+",";
						fld=fld+key+",";
						
					}else{
						
						String qv=tmp.getValue(key);
						//qv=qv.replaceAll("'","\\\\'");
						qv=qv.replaceAll("'","''");
						
						fld=fld+key+",";
						
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
								qr = qr+"'"+qv+"',";
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								String dt="";
								if(key.equalsIgnoreCase("entrydate")){
									dt=qv;
								}else if(key.equalsIgnoreCase("testdate")){
									dt=myDate.getDateMySql(qv);
								}else{
									dt=myDate.getFomateDate("ymd",true,qv);
								}
								qr = qr+"'"+dt+"',";
							}
							else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr = qr+qv+",";
							
							else {
						//			System.out.println("MatchNot Found :" +tname+":"+val);
									qr = qr+"'"+ qv +"',";
								}
						}else if (val.equalsIgnoreCase("blob") || val.equalsIgnoreCase("longblob") || val.equalsIgnoreCase("mediumblob")){
								qr=qr+"?,";
						}else
							qr = qr + "null,";					
					}
				}
				
				//fld=fld+"patpic)";
				//qr=qr+"?)";
				
				fld=fld.substring(0,fld.length()-1)+")";
				qr=qr.substring(0,qr.length()-1)+")";
				qr="insert into refimages " + fld + qr;
								
			//	System.out.println("FLD "+fld);
			//	System.out.println("QR"+qr);
				
	   			String a=mydb.ExecuteImage(qr,b);
	   			if(a.equalsIgnoreCase("Done")){
					String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+tmp.getValue("userid")+"' and center ='"+tmp.getValue("center")+"'"); 
					String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent,rg_no)"; 
					sqlQuery+="values('"+tmp.getValue("pat_id")+"','refimages','"+cdt+"',"+sl+",'N','"+rg_no+"')";
					mydb.ExecuteSql(sqlQuery);
					
				////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",tmp.getValue("pat_id"));
					keydtls.add("entrydate",cdt);
					
					desdtls.add("table","refimages");
					desdtls.add("details","Refimage Saved ("+tmp.getValue("type")+")");
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
				/////////////////////////////////////////////// log ////////////////////////////////////////////
				
				}
				
	   		//	System.out.println(a);
	   			ans ="Save";		
	   			
    		}catch(Exception e){
    			ans ="Error";	
    		}
    		
    	return ans;
    }
     
    public void  deleteAttachmentAllRecords(String pid,String type, String frmkey)throws RemoteException, SQLException{
	    String dsql = "delete from  patimages where lower(pat_id) = '"+pid.toLowerCase()+"' and type = '"+type.toLowerCase()+"' and formkey = "+frmkey+"";
	    String ans=mydb.ExecuteSql(dsql);
	    ans=dsql = "delete from  patmovies where lower(pat_id) = '"+pid.toLowerCase()+"' and type = '"+type.toLowerCase()+"' and formkey = "+frmkey+"";
	    mydb.ExecuteSql(dsql);
    }    
    
    public int  updateAttachmentAllRecords(dataobj obj)throws RemoteException, SQLException {
	
	  String tdt=obj.getValue("testdate");
	  String dt=null;
	  if(tdt!="") dt=myDate.getFomateDate("ymd",true,tdt);
      String sl=obj.getValue("serno");
      String pid = obj.getValue("pat_id");
      String type = obj.getValue("frmnam");
      String edate = obj.getValue("entrydate");
       
      String usql = "UPDATE patimages set formkey = '"+sl+"', testdate ='"+ dt+"', entrydate ='"+ edate+"' where lower(pat_id) = '"+pid.toLowerCase()+"' and type = '"+type.toLowerCase()+"' and formkey = -1";
      String ans=mydb.ExecuteSql(usql);
           
      usql ="UPDATE patmovies set formkey = '"+sl+"', testdate ='"+ dt+"', entrydate ='"+ edate+"' where lower(pat_id) = '"+pid.toLowerCase()+"' and type = '"+type.toLowerCase()+"' and formkey = -1";
	  ans=mydb.ExecuteSql(usql);
	  
     // return InsertFrmAll(obj);
      return 1;
    }
        
    public String  InsertTeleMedRequest(dataobj obj)throws RemoteException,SQLException{
    String hosname="";
    
    dataobj tmp= obj;
    String lcenetr = tmp.getValue("local_hospital"); 
    String rcenter = tmp.getValue("referred_hospital"); 
    String attdoc = tmp.getValue("attending_doc"); 
    String refdoc = tmp.getValue("referred_doc"); 
    String patid = tmp.getValue("pat_id");
    String dt=myDate.getCurrentDateMySql();//.getCurrentDate("ymd",true);
    String qr="", ans="";
        
    try{
    
	    if(lcenetr.equalsIgnoreCase(rcenter)){
	    	String distype=mydb.ExecuteSingle("Select class from med where upper(pat_id) = '"+patid.toUpperCase()+"'");
	    	//String edate=mydb.ExecuteSingle("Select entrydate from med where upper(pat_id) = '"+patid.toUpperCase()+"'");
			if(rcenter != null && !rcenter.isEmpty()) { rcenter = refdoc.substring(4,4); }
	    	qr="insert into tpatq (pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag)";
    		qr=qr+ " values('"+patid+"','"+dt+"','"+dt+"','"+refdoc+"','"+attdoc+"','"+rcenter+"','"+distype+"','N','N')";
    		ans=mydb.ExecuteSql(qr);
    		qr="update lpatq set checked='Y' where pat_id='"+patid+"'";
    		ans=mydb.ExecuteSql(qr);	    	
	    }else{
	    	qr="insert into sendq (pat_id,attending_doc,referred_doc,referred_hospital,send_records,sent_by)";
	    	qr=qr+" values ('"+patid+"','"+attdoc+"','"+refdoc+"','"+rcenter+"','"+tmp.getValue("send_records")+"','"+tmp.getValue("sent_by")+"')";
	    	ans=mydb.ExecuteSql(qr);
	    }
	    qr="update lpatq set checked='Y' where pat_id='"+patid+"'";
    	ans=mydb.ExecuteSql(qr);
    	hosname=mydb.ExecuteSingle("Select name from center where upper(code) = '"+rcenter.toUpperCase()+"'");	
    }catch(Exception e){
    	hosname="..Error";
    }
    
    return hosname;
    	
    }
    
    public String  SaveTeleMedRequest(dataobj obj)throws RemoteException,SQLException{
     
     String hosname="";
    
    dataobj tmp= obj;
    String lcenetr = tmp.getValue("local_hospital"); 
    String rcenter = tmp.getValue("referred_hospital"); 
    String attdoc = tmp.getValue("attending_doc"); 
    String refdoc = tmp.getValue("referred_doc"); 
    String patid = tmp.getValue("pat_id");
    String dt=myDate.getCurrentDateMySql();//.getCurrentDate("ymd",true);
    String qr="", ans="";
    if(rcenter != null && !rcenter.isEmpty()) { rcenter = refdoc.substring(4,4); }
    try{
    	   	String distype=mydb.ExecuteSingle("Select class from med where upper(pat_id) = '"+patid.toUpperCase()+"'");
	    //	String edate=mydb.ExecuteSingle("Select entrydate from med where upper(pat_id) = '"+patid.toUpperCase()+"'");
	   
	    	if(pinfo.CenterTypeMSPS.equalsIgnoreCase("PS")){
	    			qr="insert into tpatq (pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent)";
    				qr=qr+ " values('"+patid+"','"+dt+"','"+dt+"','"+refdoc+"','"+attdoc+"','"+lcenetr+"','"+distype+"','N','N','"+rcenter+"','N')";
	    	}else if(pinfo.CenterTypeMSPS.equalsIgnoreCase("MS")){
	    			qr="insert into tpatq (pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate)";
    				qr=qr+ " values('"+patid+"','"+dt+"','"+dt+"','"+refdoc+"','"+attdoc+"','"+lcenetr+"','"+distype+"','N','N','"+rcenter+"','Y','"+dt+"')";
	    	} else {
	    		return "BL >> MS-PS Configure Error...";
	    	}
	    		    	
    		ans=mydb.ExecuteSql(qr);
    		
    		if(ans.equalsIgnoreCase("Done")){
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",tmp.getValue("pat_id"));
					keydtls.add("entrydate",dt);
					
					desdtls.add("table","tpatq");
					desdtls.add("details","Teleconsultation Request");
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   			}
	   			
    		qr="update lpatq set checked='Y' where pat_id='"+patid+"'";
    		ans=mydb.ExecuteSql(qr);    		    	
    		hosname=mydb.ExecuteSingle("Select name from center where upper(code) = '"+rcenter.toUpperCase()+"'");	
    							    		
    }catch(Exception e){
    	hosname="..Error";
    }
    
    return hosname;
    	
    }    
    
    public int setVisitDate(dataobj obj)throws RemoteException,SQLException{
		System.out.println("Inside setVisitDate:-");
		System.out.println();
    	
    	int ans=1;    		
		//String appdt=obj.getValue("visitdate");
		String appdt = myDate.getCurrentDateMySql();
		String lpatappdt = null;
		System.out.println("Appoinment:"+obj.getValue("appointment"));
		if(!(obj.getValue("appointment")).equals(""))
		{
			lpatappdt="'"+obj.getValue("appointment")+"'";
		}
		
		String sqlQuery="";
		if(obj.getValue("assigndoc") == null || obj.getValue("assigndoc").length()<=2){
			sqlQuery = "INSERT INTO lpatq(pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag,opdno) select pat_id,entrydate,"+lpatappdt+",referring_doctor,class,'N','N',opdno from med where pat_id='"+obj.getValue("pat_id")+"'";
		}
		//String sqlQuery = "Update lpatq set appdate = '"+appdt+"', delflag = 'N', checked ='N' where pat_id = '"+obj.getValue("pat_id")+"'";
		else{
			
			String uSql = "update med set referring_doctor = '"+obj.getValue("assigndoc")+"', opdno = '"+obj.getValue("opdno")+"'  where pat_id='"+obj.getValue("pat_id")+"'";
			System.out.println("uSql:-"+uSql);
			mydb.ExecuteSql(uSql);
			System.out.println("query usql successful");
			System.out.println();
			sqlQuery = "INSERT INTO lpatq(pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag,opdno) select pat_id,entrydate,"+lpatappdt+",'"+obj.getValue("assigndoc")+"',class,'N','N',opdno from med where pat_id='"+obj.getValue("pat_id")+"'";
		}
		System.out.println("sqlQuery:-"+sqlQuery);
		String a=mydb.ExecuteSql(sqlQuery);
		
		if(a.equalsIgnoreCase("Done"))
		{ 
			System.out.println("sqlQuery Successfuly done");
			System.out.println();
			ans=1;
		 
		}
			else{
				
     		System.out.println("sqlQuery Error :");
			 System.out.println(); 
			 return 0;
     	}
		String qr = "insert into patientvisit values('"+obj.getValue("pat_id")+"','";
		qr = qr+ appdt+"','";
		qr = qr+ obj.getValue("userid") +"')";
		System.out.println("Query qr:-"+qr);
		a=mydb.ExecuteSql(qr);
		
		if(a.equalsIgnoreCase("Done")){
			 ans=1;
			 System.out.println("qr Successfuly done");
			System.out.println();
			 
		////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",obj.getValue("pat_id"));
										
					desdtls.add("table","patientvisit");
					desdtls.add("table","lpatq");
					
					desdtls.add("details","Update Visit Date");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	
	
		}else{
			System.out.println("qr Error :");
			System.out.println();
     		return 0;
     	}
		System.out.println("setVisitDate >> "+sqlQuery+" \n setVisitDate1 >> "+"\n ans >>"+ans);
    	return ans;
    }
    
    public String insertProblem(String pat_id, String problem, String user,String usrcnt) throws RemoteException,SQLException{
    	
    	   String qSql = "select name from login where uid ='"+user+"'";
           String addby= mydb.ExecuteSingle(qSql);
        
           qSql = "select rg_no from login where uid ='"+user+"' and center ='"+usrcnt+"'"; 
           String rg_no= mydb.ExecuteSingle(qSql);
           //String dt=myDate.getCurrentDate("ymd",true);
           String dt=myDate.getCurrentDateMySql();
           int sl=getserno("z00",pat_id);	
           //problem=problem.replaceAll("'","\\\\'");
           
           problem=problem.replaceAll("'","''");
           
           String iSql= "insert into z00 (pat_id, prob_desc, onset, added_by,status,entrydate,serno) values('"+pat_id+"','"+problem+"','"+dt+"','"+addby+"','n','"+dt+"',"+sl+")";     
    	   System.out.println(iSql);
    	   String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent,rg_no)"; 
		   sqlQuery+="values('"+pat_id+"','z00','"+dt+"',"+sl+",'N','"+rg_no+"')";
		   
		   // mydb.ExecuteSql(sqlQuery);
	       // return  mydb.ExecuteSql(iSql);
           String trns=iSql+"#IMX#"+sqlQuery;
  		   String ans1 = mydb.ExecuteTrans(trns);
		   if(ans1.equalsIgnoreCase("Done")){

					
////////////////////////// log //////////////////////////////////////////////////////////////////
				imedixlogger imxlog = new imedixlogger(pinfo);
				dataobj keydtls = new dataobj();
				dataobj desdtls = new dataobj();
				keydtls.add("patid",pat_id);
				keydtls.add("entrydate",dt);
				
				desdtls.add("table","z00");
				desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='z00'"));
				imxlog.putFormInformation(user,mydb.ExecuteSingle("SELECT type FROM login where uid='"+user+"'"),1,keydtls,desdtls);
				
/////////////////////////////////////////////// log ////////////////////////////////////////////

	   		}
	   return ans1;
	   
    }
    
    public String deleteProblem(String pat_id,String prob_ids,dataobj obj) throws RemoteException,SQLException{
    	
    	   String dt=myDate.getCurrentDate("ymd",true);
           String dSql = "update z00 set status='y', outset='"+dt+"' where pat_id='"+pat_id+"' and serno in (" + prob_ids + ")";
            
           System.out.println("\n"+dSql);
           String ans=mydb.ExecuteSql(dSql);
           if(ans.equalsIgnoreCase("Done")){
            
            ////////////////////////// log //////////////////////////////////////////////////////////////////
				imedixlogger imxlog = new imedixlogger(pinfo);
				dataobj keydtls = new dataobj();
				dataobj desdtls = new dataobj();
				keydtls.add("patid",pat_id);
				keydtls.add("serno",prob_ids);
				
				desdtls.add("table","z00");
				//desdtls.add("status","y");
				//desdtls.add("outset",dt);
				desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='z00'") + " (Deleted)");
				imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
				
/////////////////////////////////////////////// log ////////////////////////////////////////////
			}
           return  ans;
       }
       
    public String problemList(String pat_id) throws RemoteException,SQLException{
    	
    	String output = "", updateinfolist = "";
        
        
        int count = 1;
        String qSql= "Select serno, prob_desc, l.name, update_info, onset, outset, status from z00 pl, login l where pat_id ='"+pat_id+"' and pl.added_by=l.name order by status";
        
        System.out.println("\n"+qSql);
        
        try{
               
        output += "<html><head>";
        output += "</HEAD><body bgcolor=#EDDBCB><CENTER><FONT SIZE=+1 COLOR=#333300><U><B>Problem List</B></U></FONT>";
        output += "<form name=problem method=post action=problemlist.jsp><table border=1><tr><td>Sl. No.</td><td width='60%'>Problem Details</td><td>Added By</td><td>On set</td><td>Out set</td></tr>";
		
		Object res=mydb.ExecuteQuary(qSql);
		
		if(res instanceof String){
			System.out.println(res);	
		}
		else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0){
				for(int i=0;i<tmp.size();i++){
					 dataobj tempdata = (dataobj) tmp.get(i);
			 		 
			 		if (tempdata.getValue(6).equalsIgnoreCase("n"))
	                    output += "<tr style='background-color:white'>";
                	else
                    	output += "<tr>";
                    
                    output += "<td>" + count + "</td>";
                	output += "<td>" + tempdata.getValue(1).trim();
                	updateinfolist = tempdata.getValue(3).trim();
                	
                	if (!updateinfolist.equalsIgnoreCase("")){
                		
                    String[] updateinfo = updateinfolist.split("|&|");
                    
                    //Split(new string[] { "|&|" }, StringSplitOptions.RemoveEmptyEntries);

                    output += "<br><br><table width='100%' border=0 style='font-size:75%'>";
                    for (int j = updateinfo.length - 1; j >=0 ; j--)
                    {
                    	String[] info = updateinfo[j].split("&|&");
                    	                    	
                        //string[] info = updateinfo[i].Split(new string[] { "&|&" }, StringSplitOptions.RemoveEmptyEntries);
                        
                        output += "<tr>";
                        output += "<td>" + info[0] + "</td>";
                        output += "<td>" + info[1] + "</td>";
                        output += "<td>" + info[2] + "</td>";
                        output += "</tr>";
                    }
                    output += "</table>";
                }
                
                output += "</td>";
                output += "<td>" + tempdata.getValue(2).trim() + "</td>";
                output += "<td>" + myDate.getFomateDateYMD("dmy",true,tempdata.getValue(4).replaceAll("-","")) + "</td>";
                output += "<td>" + myDate.getFomateDateYMD("dmy",true,tempdata.getValue(5).replaceAll("-","")) + "</td>";
                output += "<td><a href='problemlist.jsp?patid=" + pat_id + "&id=" + tempdata.getValue(0).trim() + "&action=edit'>Edit</a></td>";
                output += "<td><a href='problemlist.jsp?patid=" + pat_id + "&id=" + tempdata.getValue(0).trim() + "&action=delete'>Delete</a></td>";
                output += "</tr>";

                count++;
                
				} // for
			}
		}
		
		output += "</table></form></body></html>";

		 }catch(Exception e){
		 	System.out.println(e.toString());
		 }
	
	
     return output;

    }
    
    public String problemList(String pat_id, String status ) throws RemoteException,SQLException{
    
           // String qSql = "select prob_id, prob_desc, added_by, onset, outset, status from z00 where pat_id ='"+pat_id+ "' " + (status.equalsIgnoreCase("all") ? "" : "and status = '"+status+"'") + " order by onset desc";
            String qSql = "select serno, prob_desc, added_by, onset, outset, status from z00 where pat_id ='"+pat_id+ "' " + (status.equalsIgnoreCase("all") ? "" : "and status =  'n'") + " order by onset desc";
           // String qSql = "select prob_id, prob_desc, added_by, onset, outset, status from z00 where pat_id ='"+pat_id+ "' " + (status.equalsIgnoreCase("all") ? "" : "") + " order by onset desc";
           
            int count = 1;
            String output = "";
            //System.out.println("\n"+qSql);
            
            Object res=mydb.ExecuteQuary(qSql);
            
            
        if(res instanceof String){
			System.out.println(res);	
		}
		else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0){
				output = "<table border=1><tr><td>Sl. No.</td><td width='45%'>Problem Details</td><td>Added By</td><td>On set</td>" + (status.equalsIgnoreCase("all") ? "<td>Out set</td>" : "") + "</tr>";
				
				for(int i=0;i<tmp.size();i++){
					 dataobj tempdata = (dataobj) tmp.get(i);
					
					 if (tempdata.getValue(5).equalsIgnoreCase("n"))
                        output += "<tr style='background-color:white'>";
                     else
                        output += "<tr>";
                     
                     if (status.equalsIgnoreCase("del"))
                    	output += "<td><input type='checkbox' name='pob_id' value='" + tempdata.getValue(0).trim() + "'></td>";
                     else
                    	output += "<td>" + count + "</td>";
                     
                     
                    output += "<td>" + tempdata.getValue(1) + "</td>";
                    output += "<td>" + tempdata.getValue(2) + "</td>";
                    output += "<td>" + myDate.getFomateDateYMD("dmy",true,tempdata.getValue(3).replaceAll("-","")) + "</td>";
                    
                    if (status.equalsIgnoreCase("all")) {
                   
                    	if(tempdata.getValue(5).equalsIgnoreCase("y"))
                        	output += "<td>" + myDate.getFomateDateYMD("dmy",true,tempdata.getValue(4).replaceAll("-","")) + "</td>";
						else output += "<td align='center'>" + "-" + "</td>";
					 }
					 
                    output += "</tr>";
                    count++;					 
			}
			output += "</table>";
			
		}
	}// else 		 

            
            return output;
    }
    
    
    private int getserno(String t,String pid){
    	int sno=0;
    	String qr="";
    	try{
    		qr="select count(pat_id)as c from "+t+" where lower(pat_id) = '"+pid.toLowerCase()+"'";
    		String sr=mydb.ExecuteSingle(qr);
    		if(sr.equals("")) sr="0";
    		sno=Integer.parseInt(sr);
    		
    	}catch(Exception e){
    		System.out.println(e.toString()+ "***"+ qr);
    		sno=0;
    	}
    	
    	return sno;
    	
    }
    
    private int getserno(String t,String pid,String type){
    	int sno=0;
    	try{
    		String qr="select count(pat_id)as c from "+t+" where lower(pat_id) = '"+pid.toLowerCase()+"'";
    		qr=qr + " and lower(type) = '"+type.toLowerCase()+"'";
    		
    		String sr=mydb.ExecuteSingle(qr);
    		if(sr.equals("")) sr="0";
    		sno=Integer.parseInt(sr);
    		
    	}catch(Exception e){
    		System.out.println(e.toString());
    		sno=0;
    	}
    	return sno;
    }
  /* Surajit Edition strat here */ 
    public String add2TpatWaitQ(dataobj obj) throws RemoteException,SQLException {
    
	    String attending_doc = obj.getValue("attending_doc");
		String referred_doc = obj.getValue("referred_doc");
		String referred_hospital = obj.getValue("referred_hospital");
		String local_hospital = obj.getValue("local_hospital");
		String sent_by = obj.getValue("sent_by");
		String pat_id = obj.getValue("pat_id");
		String send_records = obj.getValue("send_records");
		String usertype = obj.getValue("usertype");
		String entrydate = obj.getValue("entrydate");
		String userid = obj.getValue("userid");
		//09:53:57	update  imedixdb2.tpatq set refer_center= substr(refer_doc,4,4)  where refer_center=''	252 row(s) affected Rows matched: 252  Changed: 252  Warnings: 0	0.043 sec
	
		if(referred_hospital != null && referred_hospital.isEmpty()) { referred_hospital = referred_doc.substring(4,4); }	
     	String sql  = "insert into tpatwaitq "; 
     	       sql += " (pat_id, entrydate, attending_doc, referred_doc, referred_hospital, local_hospital, sent_by, send_records, userid, usertype, status, req_id) ";
     	       sql += " values ("+"'"+pat_id+"',"+"'"+entrydate+"',"+"'"+attending_doc+"',"+"'"+referred_doc+"',"+"'"+referred_hospital+"',"+"'"+local_hospital+"',"+"'"+sent_by+"',"+"'"+send_records+"',"+"'"+userid+"',"+"'"+usertype+"',"+"'W',"+"'todo'"+")";
    	
    	String ans=mydb.ExecuteSql(sql);
 			System.out.println("add2TpatWaitQ >> "+sql);   	
    	return ans;

     }
     
    public String delFromTpatWaitQ(dataobj obj) throws RemoteException,SQLException {

    	String pat_id = obj.getValue("pat_id");
		String reff_doc_id = obj.getValue("reff_doc_id");
		String atten_doc_id = obj.getValue("atten_doc_id");

    	String sql  = " delete from tpatwaitq ";
    		   sql += " where pat_id="+"'"+pat_id+"'"+" and referred_doc='"+reff_doc_id+"'";
    		   sql += " and attending_doc='"+atten_doc_id+"'"; //testing

    	String ans=mydb.ExecuteSql(sql);
    	return ans;
    }   
    
    
    /* move patient queue to treated patient queue */
    
    public int moveLtoTreatedpatq(String patid)throws RemoteException,SQLException{
		String result="",result1="";
		int status = 0,status1 = 0;		
		String sql = "INSERT INTO lpatq_treated(pat_id,appdate,assigneddoc,discategory,opdno) SELECT pat_id,appdate,assigneddoc,discategory,opdno FROM lpatq where pat_id='"+patid+"'";
		result = mydb.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done")) status = 1;
		String del_sql = "delete from lpatq where pat_id='"+patid+"'";
		if(status == 1)
			result1 = mydb.ExecuteSql(del_sql);
		if(result1.equalsIgnoreCase("Done")) status1 = 1;
		System.out.println("moveLtoTreatedpatq >> "+sql);
			return status1;
	}

	public int moveTreatedtoLpatq(dataobj obj)throws RemoteException,SQLException{
		String result="",result1="";
		int status = 0,status1 = 0;		
	/*	String sql = "INSERT INTO lpatq(pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag) SELECT pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag FROM lpatq_treated where pat_id='"+obj.getValue("pat_id")+"'";
		result = mydb.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done")) status = 1;
		String del_sql = "delete from lpatq_treated where pat_id='"+obj.getValue("pat_id")+"'";
		if(status == 1)
			result1 = mydb.ExecuteSql(del_sql);
		if(result1.equalsIgnoreCase("Done")){
			int svd = setVisitDate(obj);
			if(svd==1) status1 = 1;
		}
		System.out.println("moveTreatedtoLpatq >> "+sql);	*/
			return status1;	
	}
		
	
	public int moveTtoTreatedpatq(String patid)throws RemoteException,SQLException{
		String result="",result1="";
		int status = 0,status1 = 0;	
		String sql = "INSERT INTO tpatq_treated(pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate) SELECT * FROM tpatq where pat_id='"+patid+"'";
		result = mydb.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done")) status = 1;
		String del_sql = "delete from tpatq where pat_id='"+patid+"'";
		if(status == 1)
			result1 = mydb.ExecuteSql(del_sql);
		if(result1.equalsIgnoreCase("Done")) status1 = 1;
		System.out.println("moveTtoTreatedpatq >> "+sql);		
		System.out.println("status:"+status+" status1"+status1);
		
		System.out.println("result:"+result+" result1"+result1);
			return status1;
	}
	public boolean teleTreated(String patid, String reffered_doc){
		String  rg_no =  mydb.ExecuteSingle("Select rg_no from login where uid ='"+reffered_doc+"'"); 
		//Status D means, Patient is prescribed by referral doctor. That change local doctor/admin can see from tele pat referred status menu
		String sql = "update tpatwaitq set status='D' where pat_id = '"+patid+"' and referred_doc = '"+rg_no+"' and status='A'";
		String result = mydb.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
	}
	
	public int moveTreatedtoTpatq(dataobj obj)throws RemoteException,SQLException{
		String result="",result1="";
		int status = 0,status1 = 0;	
		String sql = "INSERT INTO tpatq(pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate) SELECT pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate FROM tpatq_treated where pat_id='"+obj.getValue("pat_id")+"'";
		result = mydb.ExecuteSql(sql);
		if(result.equalsIgnoreCase("Done")) status = 1;
		String del_sql = "delete from tpatq_treated where pat_id='"+obj.getValue("pat_id")+"'";
		if(status == 1)
			result1 = mydb.ExecuteSql(del_sql);
		if(result1.equalsIgnoreCase("Done")){
			//int svd = setVisitDate(obj);
			//if(svd==1) 
			status1 = 1;
		}
		System.out.println("moveTreatedtoTpatq >> "+sql);		
			return status1;
	}	
    
    /* END move patient queue to treated patient queue */
    
	public String advicedInvestigationAdd(dataobj obj) throws RemoteException,SQLException{
		String result="",result1="",data="";
		int objLength=0,serno=0,flag=0;
		String j = String.valueOf(0);
		String test_id="",pat_id="",opdno="",test_name="",description="",type="",reffered_by="",status="P";
		String cdt = myDate.getCurrentDateMySql();		
		result = obj.getValue("jsonAdvice");
		try{
	    Object jsobj=new JSONParser().parse(result); 
		JSONObject jsonObject = (JSONObject)jsobj;  
		pat_id = (String)jsonObject.get("pat_id");
		opdno = mydb.ExecuteSingle("select opdno from med where pat_id='"+pat_id+"'");
		reffered_by = (String)jsonObject.get("reffered_by");
		objLength = jsonObject.size()-3 /* subtructing pat_id and reffered_by and center*/;
		
		String noOfrecd = mydb.ExecuteSingle("select count(*) from listofforms where pat_id ='"+pat_id+"' and type='ai0'"); 
		System.out.println(noOfrecd +" : "+"select count(*) from listofforms where pat_id ='"+pat_id+"' and type='ai0'");
		
		for(int i=0;i<objLength;i++){
			String key = String.valueOf(i);
			JSONObject nested_jsonObject = (JSONObject)jsonObject.get(key); 
			//test_id= (String)nested_jsonObject.get("test_id");

			type= (String)nested_jsonObject.get("type");
			test_name= (String)nested_jsonObject.get("test_name");
			//test_id= test_name.replace(" ","")+pat_id+(Integer.parseInt(noOfrecd)+i);
			test_id= pat_id+(Integer.parseInt(noOfrecd)+i+10000);
			System.out.println("Test_id >> "+test_id);
			description= (String)nested_jsonObject.get("description");
			serno = Integer.parseInt(noOfrecd)+i;

			String sql = "INSERT INTO ai0(test_id,pat_id,opdno,test_name,description,type,status,entrydate,reffered_by,serno) values('"+test_id+"','"+pat_id+"','"+opdno+"','"+test_name+"','"+description+"','"+type+"','"+status+"','"+cdt+"','"+reffered_by+"','"+serno+"')";
			result = mydb.ExecuteSql(sql);
			System.out.println("SQL >> "+sql);
			String  rg_no=  mydb.ExecuteSingle("Select rg_no from login where uid ='"+reffered_by+"'"); 
			
			if(result.equalsIgnoreCase("Done")) flag = 1;

			if(flag==1){
				String i_sql = "INSERT INTO listofforms(pat_id,type,serno,date,rg_no) values('"+pat_id+"','ai0','"+serno+"','"+cdt+"','"+rg_no+"')";
				result1 = mydb.ExecuteSql(i_sql);
				System.out.println("i_SQL >>  "+i_sql);
				if(result1.equalsIgnoreCase("Done")){data="1";}
								
		}
		}
				System.out.println("DATA : "+data);
		return data;	
		}catch(Exception ex){return ex.toString();}
	}
	
	public boolean isValidTestId(String testId) throws RemoteException,SQLException{
		String query = "SELECT count(*) from ai0 where test_id='"+testId+"'";
		String noOfrecord = mydb.ExecuteSingle(query);
		int no_of_test = 0;
		try{
			no_of_test = Integer.parseInt(noOfrecord);
		}catch(Exception ex){no_of_test=0;}
		if(no_of_test > 0)
			return true;
		else
			return false;
	}
	
	public boolean updateStudyUID(String testId, String studyUID) throws RemoteException,SQLException{
		String sqlcheck = "select count(*) from ai0 where studyUID='"+studyUID+"'";
		int noofrecords=0;
		try{
			noofrecords = Integer.parseInt(mydb.ExecuteSingle(sqlcheck));
			System.out.println(sqlcheck);
		}catch(Exception ex){System.out.println("Err09934 : "+ex.toString());}
		if(noofrecords<1){
			String query = "UPDATE ai0 set studyUID = '"+studyUID+"', status='A',testdate=CURDATE() where test_id = '"+testId+"'";
			String result = mydb.ExecuteSql(query);
			System.out.println(query);
			if(result.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
		else{
			return false;
			}
		
	}

	
	public String checkIntigrity(dataobj obj) throws RemoteException,SQLException{
		String query = "select pat_id from med where persidtype='"+obj.getValue("persidtype")+"' and persidvalue='"+obj.getValue("persidvalue")+"'";
		String pat_id = "";
		pat_id = mydb.ExecuteSingle(query);
		System.out.println("Patient id : "+pat_id);
		return pat_id;
	}
	public boolean isInQueue(String pat_id) throws RemoteException,SQLException{
		String query = "select count(*) from lpatq where pat_id='"+pat_id+"'";
		String nofp = mydb.ExecuteSingle(query);
		int no_of_pat = 0;
		try{
			no_of_pat = Integer.parseInt(nofp);
		}catch(Exception ex){no_of_pat=0;}
		if(no_of_pat > 0)
			return true;
		else
			return false;
	}
	public String getAssignDoc(String pat_id) throws RemoteException, SQLException{
		String query = "select assigneddoc from lpatq where pat_id='"+pat_id+"'";
		String assigneddoc = mydb.ExecuteSingle(query);
		System.out.println("getAssignDoc(): "+assigneddoc);
		return assigneddoc;
	}
	public boolean isReport(dataobj obj) throws RemoteException,SQLException{
		String studyUID = obj.getValue("studyUID");
		if(studyUID.length()>4){
			String sql = "update ai0 set isReport = 1 where studyUID = '"+studyUID+"'";
			String result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(result.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
		else{return false;}
	}
	public boolean isNote(dataobj obj) throws RemoteException,SQLException{
		String studyUID = obj.getValue("studyUID");
		if(studyUID.length()>4){		
			String sql = "update ai0 set isNote = 1 where studyUID = '"+studyUID+"'";
			String result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(result.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
		else{return false;}
	}

public boolean updateInvestigation(String test_id) throws RemoteException,SQLException{
	String sql = "update ai0 set status='A' where test_id='"+test_id+"'";
	boolean result=false;
	try{
		String db_result = mydb.ExecuteSql(sql);
		System.out.println(sql);
		if(db_result.equalsIgnoreCase("Done"))
			result = true;
		else
			result = false;
	}catch(Exception ex){System.out.println("updateInvestigation() ERR: "+ex.toString());}
	return result;
}
	
	public boolean uploadPathologydata(File file,dataobj obj) throws RemoteException,SQLException{
		boolean result = false;
		System.out.println("fileid:-"+obj.getValue("fileId"));
		String sql_query = "insert into pathoData(pat_id,test_id,fileId,ext,size,rawData) value('"+obj.getValue("pat_id")+"','"+obj.getValue("test_id")+"','"+obj.getValue("fileId")+"','"+obj.getValue("extension")+"','"+obj.getValue("fileSize")+"',?)";
		try{
			            						
			InputStream inputStream = new FileInputStream(file);
			byte[] bytes = IOUtils.toByteArray(inputStream);
			String dx_result = mydb.ExecuteImage(sql_query,bytes);
			System.out.println(sql_query);
				if(!dx_result.equals("Done")){
					System.out.println("Can't upload file contact to administrator : "+dx_result);	
				}					
				else{
					if(updateInvestigation(obj.getValue("test_id")))
						result = true;
				}
			//file.delete();
			
		}
		catch(Exception ex){System.out.println(ex.toString());}	
	 return result;
	}	

	public boolean modifyTestId(String test_id,String studyUID) throws RemoteException,SQLException{
		
		String sql = "update ai0 set studyUID='"+studyUID+"',status='A' where test_id='"+test_id+"'";
		boolean result=false;
		if(studyUID.length()>10){
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("updateInvestigation() ERR: "+ex.toString());
			result = false;
		}
		}
		return result;		
	}
	public boolean requestConsultant(String pat_id, String centerid,String dept) throws RemoteException,SQLException{
		String sql = "insert into consultrequest(pat_id, centerid, dept, requested) values('"+pat_id+"','"+centerid+"','"+dept+"','Y')";
		boolean result=false;
		if(pat_id.length()>10){
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("requestConsultant() ERR: "+ex.toString());
			result = false;
		}
		}
		return result;	
	}
	public boolean approveConsultant(String pat_id, String doc_id, String appoinmenttime, String uid) throws RemoteException,SQLException{
		String sql = "update consultrequest set requested = 'A', doc_id='"+doc_id+"', appoinmenttime='"+appoinmenttime+"', operator='"+uid+"' where pat_id='"+pat_id+"' and requested = 'Y'";
		if(appoinmenttime==null)
		{
		sql = "update consultrequest set requested = 'A', doc_id='"+doc_id+"', appoinmenttime="+appoinmenttime+", operator='"+uid+"' where pat_id='"+pat_id+"' and requested = 'Y'";
		}
		boolean result=false;
		if(pat_id.length()>10){
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("approveConsultant() ERR: "+ex.toString());
			result = false;
		}
		}
		return result;	
	}
	public boolean advicedConsultant(String pat_id, String uid) throws RemoteException,SQLException{
		String sql = "update consultrequest set requested = 'D', operator='"+uid+"' where pat_id='"+pat_id+"' and requested = 'A'";
		boolean result=false;
		if(pat_id.length()>10){
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("advicedConsultant() ERR: "+ex.toString());
			result = false;
		}
		}
		return result;	
	}
	public boolean declineConsultant(String pat_id, String uid) throws RemoteException,SQLException{
		String sql = "update consultrequest set requested = 'N', operator='"+uid+"' where pat_id='"+pat_id+"' and requested = 'Y'";
		boolean result=false;
		if(pat_id.length()>10){
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("declineConsultant() ERR: "+ex.toString());
			result = false;
		}
		}
		return result;	
	}	
	public boolean isRequested(String pat_id) throws RemoteException,SQLException{
		String sql = "select count(*) from consultrequest where pat_id='"+pat_id+"' and requested='Y'";
		String nofp = mydb.ExecuteSingle(sql);
		int no_of_rs = 0;
		try{
			no_of_rs = Integer.parseInt(nofp);
		}catch(Exception ex){no_of_rs=0;}
		if(no_of_rs > 0)
			return true;
		else
			return false;		
	}
	public boolean isAcceptedConsult(String pat_id) throws RemoteException,SQLException{
		String sql = "select count(*) from consultrequest where pat_id='"+pat_id+"' and requested='A'";
		String nofp = mydb.ExecuteSingle(sql);
		int no_of_rs = 0;
		try{
			no_of_rs = Integer.parseInt(nofp);
		}catch(Exception ex){no_of_rs=0;}
		if(no_of_rs > 0)
			return true;
		else
			return false;		
	}
	public String existPatientByOPD(String opdno) throws RemoteException, SQLException{
		String sql = "select count(*) as noopdno from med where opdno='"+opdno+"' and relationship='Self'";
		System.out.println("DataEntryFrm->existPatientByOPD: "+sql);
		return mydb.ExecuteSingle(sql);
	}
		
	public boolean updateDepartment(int id, String field, String value) throws RemoteException, SQLException{
		String sql = "update department set "+field + "="+value+" where iddepartment="+Integer.toString(id);

		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->updateDepartment: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->updateDepartment (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}

	public boolean addDepartment(String dept_name, String ccode) throws RemoteException, SQLException{
		String sql = "insert into department (department_name, center, active) values('"+
				dept_name+"','"+ccode+"',1)";

		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->addDepartment: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->addDepartment (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	
	public boolean deleteDepartment(int id) throws RemoteException, SQLException{
		String sql = "delete from department where iddepartment = "+Integer.toString(id);

		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->deleteDepartment: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->deleteDepartment (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean updateDrug(int id, String field, String value) throws RemoteException, SQLException{
		System.out.println("id:-"+id+" field:-"+field+" value:-"+value);
		String sql="";
		if(field.equalsIgnoreCase("drug_name"))
		{
		//System.out.println("Update Drug:-"+value+"value.length()--"+value.length());
		String v=value.substring(1,value.length()-1).replace("'","^");
		v=v.replace("\"","^");
		//String sql = "update druglistbycenter set `"+field +"`='"+value.substring(1,value.length()-1).replace("'","\\'")+"' where sl_no="+Integer.toString(id);
		sql = "update druglistbycenter set `"+field +"`='"+v+"' where sl_no="+Integer.toString(id);
		}
		else
		{
			sql = "update druglistbycenter set `"+field +"`='"+value+"' where sl_no="+Integer.toString(id);
		}
		System.out.println("sql:-"+sql);

		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->updateDrug: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->updateDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean addDrug(String drug_name, String ccode) throws RemoteException, SQLException{
		//String sql="insert into druglistbycenter (`drug_name`,ccode,active) values ('"+drug_name.replace("'","\\'")+"','"+ccode+"',1)";
		String nm=drug_name.replace("'","^");
		nm=nm.replace("\"","^");
		String sql="insert into druglistbycenter (`drug_name`,ccode,active) values ('"+nm+"','"+ccode+"',1)";
		
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->addDrug: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->addDrug (Error): "+ex.toString());
			result = false;
		}
		
				return result;
	}
	public boolean addMultipleDrugCSV(String drug_name[], String ccode) throws RemoteException, SQLException{
		boolean result=false;
		String sql="insert into druglistbycenter (`drug_name`,ccode,active) values ";
		
		for(int i=0;i<drug_name.length;i++)
		{
			if(drug_name.length-i!=1)
			{
				sql+="('"+drug_name[i]+"','"+ccode+"',1),";
			}
			else
			{
				sql+="('"+drug_name[i]+"','"+ccode+"',1)";
			}

		}
		String db_result = mydb.ExecuteSql(sql);
		System.out.println("DatEntryFrm->addMultipleDrugCSV: "+sql);
		if(db_result.equalsIgnoreCase("Done"))
			result = true;
		else
			result = false;

		return result;
	}
	public boolean addMultipleDrug(String drug_id[], String ccode) throws RemoteException, SQLException{
		boolean result=false;
		//String sql="insert into druglistbycenter (drug_name,ccode,active) values ('"+drug_name+"','"+ccode+"',1)";
		String sql="insert into druglistbycenter (`drug_name`,ccode,active) values ";
		String isql="select drug_name from druglist where sl_no in (";
		for(int i=0;i<drug_id.length;i++)
		{
			isql+=drug_id[i];
			if(drug_id.length-i!=1)
			{
				isql+=",";
			}

		}
		isql+=")";
		boolean res=false;
		try{
			System.out.println("DatEntryFrm->addMultipleDrug-->SELECT QUERY: "+isql);
			Object dname=mydb.ExecuteQuary(isql);
			Vector tmpv1 = (Vector)dname;
			for(int j=0;j<tmpv1.size();j++){
				dataobj tmpdata1 = (dataobj) tmpv1.get(j);
				String drug_name = tmpdata1.getValue("drug_name").replace("'","\\'");
				sql+="('"+drug_name+"','"+ccode+"',1)";
				if(tmpv1.size()-j!=1)
				{
					sql+=",";
				}


			}

		/*}catch(Exception ex){
			System.out.println("DatEntryFrm->addMultipleDrug (Error): "+ex.toString());
			res = false;
			
		}			
		try{*/

			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->addMultipleDrug: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->addMultipleDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean deleteDrug(int id) throws RemoteException, SQLException{
		String sql = "delete from druglistbycenter where sl_no="+Integer.toString(id);

		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->deleteDrug: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->deleteDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean deleteIMEDIXDrug(int id) throws RemoteException, SQLException{
		String sql = "delete from druglist where sl_no="+Integer.toString(id);
		//String sql = "delete from druglist where sl_no= ?";
		String ar[]=new String[1];
		ar[0]=Integer.toString(id);
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			//String db_result = mydb.ExecuteSql(sql,ar,1);
			System.out.println("DatEntryFrm->deleteDrug: "+sql+"--"+Arrays.toString(ar));
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->deleteDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean updateIMEDIXDrug(int id, String field, String value) throws RemoteException, SQLException{
		String v=value.substring(1,value.length()-1).replace("'","^");
		v=v.replace("\"","^");
		String sql = "update druglist set `"+field+"`='"+v+"' where sl_no="+Integer.toString(id);
		//String sql = "update druglist set ? = ? where sl_no= ?";
		String ar[]=new String[3];
		ar[0]=field;
		ar[1]=value;
		ar[2]=Integer.toString(id);
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			//String db_result = mydb.ExecuteSql(sql,ar,3);
			System.out.println("DatEntryFrm->updateDrug: "+sql+"--"+Arrays.toString(ar));
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->updateDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean addIMEDIXDrug(String drug_name) throws RemoteException, SQLException{
		String nm=drug_name.replace("'","^");
		nm=nm.replace("\"","^");
		String sql="insert into druglist (`drug_name`) values ('"+nm+"')";
		//String sql="insert into druglist (drug_name) values ('?')";
		String ar[]=new String[1];
		ar[0]=drug_name;
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			//String db_result = mydb.ExecuteSql(sql,ar,1);
			System.out.println("DatEntryFrm->addDrug: "+sql+"--"+Arrays.toString(ar));
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->addDrug (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}

	public boolean updateLoginConsent(String uid)throws RemoteException,SQLException
	{
		String sql = "update login set consent='Y' where uid='"+uid+"'";
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->updateLoginConsent: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->updateLoginConsent (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public Object findLoginConsent(String uid)throws RemoteException,SQLException
	{
		String sql="select consent from login where uid='"+uid+"'";
		System.out.println("findLoginConsent->"+sql);
		return mydb.ExecuteSingle(sql);
		
	}
	public Object findConsentAdm()throws RemoteException,SQLException
	{
		String sql="select * from consentform";
		System.out.println("findConsentAdm->"+sql);
		return mydb.ExecuteQuary(sql);

	}
	public Object findConsentByCenter(String center)throws RemoteException,SQLException
	{
		String sql="select * from consentdocmap where center='"+center+"'";
		System.out.println("findConsentByCenter->"+sql);
		return mydb.ExecuteQuary(sql);		
	}
	public boolean insertConsentAdm(String conid,String comments,String type,String path)throws RemoteException,SQLException
	{
		String time=myDate.getCurrentDateMySql();
		String sql = "insert into consentform(conid,time,type,comments,path) values('"+conid+"','"+time+"','"+type+"','"+comments+"','"+path+"')";
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->insertConsentAdm: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->insertConsentAdm (Error): "+ex.toString());
			result = false;
		}
		
		return result;

	}
	public boolean consentMap(String conid,String center,String type)throws RemoteException,SQLException
	{
		String path="";
		String gsql="select path from consentform where conid='"+conid+"'";
		Object res3=mydb.ExecuteSingle(gsql);
		if(res3 instanceof String){
			path=res3.toString();	
		}
		/*else{
		Vector tmp3 = (Vector)res3;
			//System.out.println(tmp.size());
			if(tmp3.size()>0){
				for(int i=0;i<tmp3.size();i++){
					 dataobj tempdata3 = (dataobj) tmp3.get(i);
					 path=tempdata3.getValue(0);
				}
			}
		}*/
		String isql="select * from consentdocmap where center='"+center+"' and path='"+path+"'";
		Object exist=mydb.ExecuteQuary(isql);
		Vector tmp = (Vector)exist;
		
		String sql="";
		if(tmp.size()==0)
		{
			sql = "insert into consentdocmap(conid,center,type,path) values ('"+conid+"','"+center+"','"+type+"','"+path+"')";
		}
		else{
			sql = "update consentdocmap set conid='"+conid+"', path='"+path+"' where center='"+center+"' and type='"+type+"'";
		}
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->consentMap: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->consentMap (Error): "+ex.toString());
			result = false;
		}
		
		return result;

	}
	public Object getSignedConsent(String uid)throws RemoteException,SQLException
	{
		String sql="select consentlogs.time,path from consentlogs join consentform on consentlogs.conid=consentform.conid  and uid='"+uid+"'";
		System.out.println("getSignedConsent->"+sql);
		return mydb.ExecuteQuary(sql);		
	}
	public boolean makeConsentLog(String uid,String conid,String center)throws RemoteException,SQLException
	{
		boolean b=updateLoginConsent(uid);
		String time=myDate.getCurrentDateMySql();
		String sql = "insert into consentlogs(uid,time,conid,center) values('"+uid+"','"+time+"','"+conid+"','"+center+"')";
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->makeConsentLog: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->makeConsentLog (Error): "+ex.toString());
			result = false;
		}
		
		return result;


	}
	public boolean insertDocbanner(String rg_no,String name,String ccode,String path)throws RemoteException,SQLException
	{
		String sql = "insert into docbanner(rg_no,docname,center,path,avail) values('"+rg_no+"','"+name+"','"+ccode+"','"+path+"','Y')";
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->insertDocbanner: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->insertDocbanner (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public boolean updateDocbanner(String rg_no,String path,String avail)throws RemoteException,SQLException
	{
		//String sql = "insert into docbanner(rg_no,docname,center,path,avail) values('"+rg_no+"','"+name+"','"+ccode+"','"+path+"','Y')";
		String sql="update docbanner set path='"+path+"',avail='"+avail+"' where rg_no='"+rg_no+"'";
		boolean result=false;
		
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println("DatEntryFrm->updateDocbanner: "+sql);
			if(db_result.equalsIgnoreCase("Done"))
				result = true;
			else
				result = false;
		}catch(Exception ex){
			System.out.println("DatEntryFrm->updateDocbanner (Error): "+ex.toString());
			result = false;
		}
		
		return result;
	}
	public Object findDocbanner(String rg_no)throws RemoteException,SQLException
	{
		//String sql = "insert into docbanner(rg_no,docname,center,path,avail) values('"+rg_no+"','"+name+"','"+ccode+"','"+path+"','Y')";
		String sql="select * from docbanner where rg_no='"+rg_no+"'";
		System.out.println("findDocbanner->"+sql);
		return mydb.ExecuteQuary(sql);
		
	}

	public String findConsultStrategy(String ccode)throws RemoteException,SQLException
	{
		String sql = "select type from  consultstrategy where ccode ='"+ccode+"'";
		String res=mydb.ExecuteSingle(sql);
		System.out.println("findConsultStrategy:-"+sql+"->"+res);
		return res;

	}
	public boolean updateConsultStrategy(int val,String ccode)throws RemoteException,SQLException
	{
		String q="select count(*) from consultstrategy where ccode= '"+ccode+"'";
		String res=mydb.ExecuteSingle(q);
		String sql="";
		if(res.equalsIgnoreCase("0"))
		{	String qm="";
			if(val==0)
			{
				qm="insert into consultstrategy (ccode,type) values ('"+ccode+"','random')";
			}
			else if(val==1)
			{
				qm="insert into consultstrategy (ccode,type) values ('"+ccode+"','admin')";
			}
			String out=mydb.ExecuteSql(qm);
			if(out.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
		else
		{
		if(val==0)
		{
			sql = "update consultstrategy set type = 'random' where ccode = '"+ccode+"'";
		}
		else if(val==1)
		{
			sql = "update consultstrategy set type = 'admin' where ccode = '"+ccode+"'";
		}
		//String sql = "update consultStrategy set type = '"+val+"' where strat = 'strategy'";
		
		String updateStrategy=mydb.ExecuteSql(sql);
		System.out.println("updateConsultStrategy:-"+sql+"->"+updateStrategy);
		if(updateStrategy.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
	}

	public boolean existsHEXResult(String test_id)throws RemoteException,SQLException
	{
		String query="select count(test_id) from hexPathology where test_id='"+test_id+"'";
		//where test_id='"+testId+"'";
		String res=mydb.ExecuteSingle(query);
		System.out.println(test_id+":"+query+":"+res);
		if(res.equalsIgnoreCase("0"))
			return false;
		else
			return true;
		
	
	}
	public boolean insertHEXResult(String test_id,String test_desc,String dateTime,String result)throws RemoteException,SQLException
	{
		
		String queryPatId="select pat_id from ai0 where test_id='"+test_id+"'";
		String pat_id = "";
		pat_id = mydb.ExecuteSingle(queryPatId);
		System.out.println("Get pat_id:-"+queryPatId+":="+pat_id);
		String status="A";
		String queryUpdateStatus="UPDATE ai0 set status = '"+status+"' where test_id='"+test_id+"'";
		
		String query="insert into hexPathology (test_id,testTime,Description,Result,pat_id) values ('"+test_id+"','"+dateTime+"','"+test_desc+"','"+result+"','"+pat_id+"')";
		String res=mydb.ExecuteSql(query);
		String updateStatus="";
		//String result = 
		if(res.equalsIgnoreCase("Done"))
		{
			System.out.println("Insert into hexPathology:-"+query+":="+res);
			updateStatus=mydb.ExecuteSql(queryUpdateStatus);
			System.out.println("Update Status in ai0:-"+queryUpdateStatus+":="+updateStatus);
			if(updateStatus.equalsIgnoreCase("Done"))
				return true;
			else
				return false;
		}
		else
			return false;

		
	}
	public String getHEXResult(String test_id)throws RemoteException,SQLException
	{
		String query="select Result from hexPathology where test_id='"+test_id+"'";
		String result = "";
		result = mydb.ExecuteSingle(query);
		System.out.println(query+": "+result);
		return result;
	}
	public String getServiceHex()throws RemoteException,SQLException
	{
		String query="select pat_id,test_id,test_name,description from ai0 where status='P' and type='Pathology'";
		Object res=mydb.ExecuteQuary(query);
		String query2="select distinct(pat_id) from ai0 where status='P' and type='Pathology'";
		Object res2=mydb.ExecuteQuary(query2);
		String allPatId="";
		JSONObject result=new JSONObject();
		if(res instanceof String){
			System.out.println(res);	
		}
		else{
			Vector tmp = (Vector)res2;
			//System.out.println(tmp.size());
			if(tmp.size()>0){
				for(int i=0;i<tmp.size();i++){
					 dataobj tempdata = (dataobj) tmp.get(i);
					 String patid="";
					 patid=tempdata.getValue(0);
					 if(i!=(tmp.size()-1))
					 {
						allPatId+="'"+patid+"',";
					 }
					 else
					 {
						allPatId+="'"+patid+"'";
					 }			 					 					 
				} 
			}
			
			String patDetailsQuery="select pat_id,concat(COALESCE(pat_name,''),' ',COALESCE(m_name,''),' ',COALESCE(l_name,'')) as patName,age,sex,referring_doctor from med where pat_id in ("+allPatId+")";
			Object patDetail=mydb.ExecuteQuary(patDetailsQuery);
			Vector tmp2 = (Vector)res;
			Vector tmp3=(Vector)patDetail;
			HashMap<String, HashMap<String, String>>  allData=new HashMap<String, HashMap<String, String>> ();
			
			//System.out.println(tmp3.size());

			if(tmp3.size()>0){
				for(int i=0;i<tmp3.size();i++){
					 dataobj tempdata2 = (dataobj) tmp3.get(i);
					 String patId="",patName="",age="",sex="",ref_doc="";

					 patId=	tempdata2.getValue(0);
					 patName=tempdata2.getValue(1);
					 age=tempdata2.getValue(2);
					 sex=tempdata2.getValue(3);
					 ref_doc=tempdata2.getValue(4);

					 HashMap<String, String>  dat = new HashMap<String, String> (); 
					 dat.put("patName",patName);
					 dat.put("age", age);
					 dat.put("sex", sex);
					 dat.put("ref_doc",ref_doc);
					 
			   		 allData.put(patId, dat);

				} 
			}

			if(tmp2.size()>0){
				//System.out.println(tmp2.size());
				int count=0;
				for(int i=0;i<tmp2.size();i++){
					//System.out.println("i:- "+i);
					 dataobj tempdata = (dataobj) tmp2.get(i);
					 String tid="",tname="",tdes="",patid="",patName="",age="",sex="",ref_doc="";
					 patid=tempdata.getValue(0);
					 tid=tempdata.getValue(1);
					 tname=tempdata.getValue(2);
					 tdes=tempdata.getValue(3);
					 //Dictionary d=allData.get(patid);
					 if(allData.get(patid)!=null)
					 {
						patName=allData.get(patid).get("patName");
						age=allData.get(patid).get("age");
						sex=allData.get(patid).get("sex");
						ref_doc=allData.get(patid).get("ref_doc");
						//System.out.println(patName+" "+age+" "+sex+" "+ref_doc);
						//System.out.println(patid+" "+tid+" "+tname+" "+tdes);
						//System.out.println();
						JSONObject obj = new JSONObject();
						obj.put("pat_id",patid);
						obj.put("patName",patName);
						obj.put("age",age);
						obj.put("sex",sex);
						obj.put("ref_doc",ref_doc);
						obj.put("test_id", tid);
						obj.put("test_name", tname);
						obj.put("description", tdes);
						result.put(count,obj);
						count++;
					 }

				}
				result.put(count,allData); 

				
			}
			
		
			System.out.println(result.toString());
			return result.toString();

		}
		return "error";
	}
	 
}
