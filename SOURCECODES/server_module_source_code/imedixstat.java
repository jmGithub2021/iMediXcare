package imedix;

import java.io.*;
import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.StringTokenizer;
import java.util.Vector;
import imedix.dataobj;
import java.util.Date;

public class imedixstat extends UnicastRemoteObject implements imedixstatinterface {
		
	projinfo pinfo;
	dball mydb;

	public imedixstat(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public Object getGenderData(String ccode)throws RemoteException,SQLException {
	 	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select sex, count(*) as nop from med group by sex Order by nop";
	 	else
	 		qSql = "Select sex, count(*) as nop from med where pat_id LIKE '" + ccode + "%' group by sex Order by nop";
	 	return mydb.ExecuteQuary(qSql);	 	
	 }

	 public Object getGenderData(String ccode, String sst, String sto)throws RemoteException,SQLException {
	 	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	qSql = "Select sex, count(*) as nop from med where pat_id LIKE '" + ccode + "%' and entrydate between date('" + sst + "') and date('" + sto + "') group by sex Order by nop";
	 	System.out.println("DDPTEST: " + qSql);
	 	return mydb.ExecuteQuary(qSql);	 	
	 }
     
     public Object getDiseaseData(String ccode)throws RemoteException,SQLException { 	
	 	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select class, count(*) as nop from med group by class Order by nop";
	 	else
	 		qSql = "Select class, count(*) as nop from med where pat_id LIKE '" + ccode + "%' group by class Order by nop";
	 	return mydb.ExecuteQuary(qSql);	 	
     }
     
	public Object getDiseaseData(String ccode, String sst, String sto)throws RemoteException,SQLException { 	
	 	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	qSql = "Select class, count(*) as nop from med where pat_id LIKE '" + ccode + "%' and entrydate between date('" + sst + "') and date('" + sto + "') group by class Order by nop";
	 	return mydb.ExecuteQuary(qSql);	 	
     }     
     
     
     
     
     public Object getAgeData(String ccode)throws RemoteException,SQLException {
     	
     	dataobj ageData= new dataobj();
     	ageData.add("A","0");
     	ageData.add("E","0");
     	ageData.add("C","0");
     	ageData.add("T","0");
     	ageData.add("I","0");
     	ageData.add("N","0");
     		 
     	String qSql ="";
     	
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select type, count(*) as nop from med where type is not null group by type Order by nop";
	 	else
	 		qSql = "Select type, count(*) as nop from med where type is not null and pat_id LIKE '" + ccode + "%' group by type Order by nop";
	 	
	 	Object obj = mydb.ExecuteQuary(qSql);	 
	 	if(obj instanceof String){
				//ageData.add("Data","Not Found");
		}else{
			Vector Vtmp = (Vector)obj;
		    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 ageData.setValue(data.getValue(0),data.getValue(1));
		
			 }
		}
		
		if(ccode.equalsIgnoreCase("XXXX")){
		
	 		qSql = "SELECT age, COUNT(t.PAT_ID) FROM ";
	 		qSql+="(SELECT pat_id, DATEDIFF(CURDATE(),dateofbirth) AS age FROM med  WHERE type is null and dateofbirth is not null) as t GROUP BY age";
	 		
	 	}else{
	 		
	 		qSql = "SELECT age, COUNT(t.pat_id) FROM ";
	 		qSql+="(SELECT pat_id, DATEDIFF(CURDATE(),dateofbirth) AS age FROM med  WHERE type is null and dateofbirth is not null and pat_id LIKE '" + ccode + "%') as t GROUP BY age";

		}
		System.out.println(qSql);
	//	( (ageData.getValue("A").equals("")? "0":ageData.getValue("A"))
		
		obj = mydb.ExecuteQuary(qSql);
		if(obj instanceof String){
				//ageData.add("Data Not Found ","0");
		}else{
			Vector Vtmp = (Vector)obj;
		    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 
			  double agem = Double.parseDouble(data.getValue(0))/365;
			  double age = agem/12;
			  int cnt=Integer.parseInt(data.getValue(1));
			  
			  if (age >= 18){
			  	int val=Integer.parseInt(ageData.getValue("A"));
			  	val+=cnt;
			  	
			  	ageData.setValue("A",Integer.toString(val));
			  }else if (age >= 12){
			  	int val=Integer.parseInt(ageData.getValue("E"));
			  	val+=cnt;
			  	ageData.setValue("E",Integer.toString(val));
			  	
			  }else if (age >= 5){
			  
			  	int val=Integer.parseInt(ageData.getValue("C"));
			  	val+=cnt;
			  	ageData.setValue("C",Integer.toString(val));
			  	
			  }else if (age >= 2){
			   	int val=Integer.parseInt(ageData.getValue("T"));
			  	val+=cnt;
			  	ageData.setValue("T",Integer.toString(val));
			  	
			  }else if (agem > 1){
			   	int val=Integer.parseInt(ageData.getValue("I"));
			  	val+=cnt;
			  	ageData.setValue("I",Integer.toString(val));
			  	
			  }else{
			  	int val=Integer.parseInt(ageData.getValue("N"));
			  	val+=cnt;
			  	ageData.setValue("N",Integer.toString(val));
			  }
			  
			  
		   }
		}///
		
				
	 	return ageData;
     }
     
	public Object getAgeData(String ccode, String sst, String sto)throws RemoteException,SQLException {
     	
     	dataobj ageData= new dataobj();
     	ageData.add("A","0");
     	ageData.add("E","0");
     	ageData.add("C","0");
     	ageData.add("T","0");
     	ageData.add("I","0");
     	ageData.add("N","0");
     		 
     	String qSql ="";
		if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	qSql = "Select type, count(*) as nop from med where type is not null and pat_id LIKE '" + ccode + "%' and entrydate between date('" + sst + "') and date('" + sto + "') group by type Order by nop";
	 	
	 	Object obj = mydb.ExecuteQuary(qSql);	 
	 	if(obj instanceof String){
				//ageData.add("Data","Not Found");
		}else{
			Vector Vtmp = (Vector)obj;
		    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 ageData.setValue(data.getValue(0),data.getValue(1));
		
			 }
		}
		
		//if(ccode.equalsIgnoreCase("XXXX")){
		
	 	//	qSql = "SELECT age, COUNT(t.PAT_ID) FROM ";
	 	//	qSql+="(SELECT pat_id, DATEDIFF(CURDATE(),dateofbirth) AS age FROM med  WHERE type is null and dateofbirth is not null) as t GROUP BY age";
	 		
	 	//}else{
	 		
	 		qSql = "SELECT age, COUNT(t.pat_id) FROM ";
	 		qSql+="(SELECT pat_id, DATEDIFF(CURDATE(),dateofbirth) AS age FROM med  WHERE type is null and dateofbirth is not null and pat_id LIKE '" + ccode + "%' and entrydate between date('" + sst + "') and date('" + sto + "') ) as t  GROUP BY age";

		//}
		//System.out.println(qSql);
	//	( (ageData.getValue("A").equals("")? "0":ageData.getValue("A"))
		
		obj = mydb.ExecuteQuary(qSql);
		if(obj instanceof String){
				//ageData.add("Data Not Found ","0");
		}else{
			Vector Vtmp = (Vector)obj;
		    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 
			  double agem = Double.parseDouble(data.getValue(0))/365;
			  double age = agem/12;
			  int cnt=Integer.parseInt(data.getValue(1));
			  
			  if (age >= 18){
			  	int val=Integer.parseInt(ageData.getValue("A"));
			  	val+=cnt;
			  	
			  	ageData.setValue("A",Integer.toString(val));
			  }else if (age >= 12){
			  	int val=Integer.parseInt(ageData.getValue("E"));
			  	val+=cnt;
			  	ageData.setValue("E",Integer.toString(val));
			  	
			  }else if (age >= 5){
			  
			  	int val=Integer.parseInt(ageData.getValue("C"));
			  	val+=cnt;
			  	ageData.setValue("C",Integer.toString(val));
			  	
			  }else if (age >= 2){
			   	int val=Integer.parseInt(ageData.getValue("T"));
			  	val+=cnt;
			  	ageData.setValue("T",Integer.toString(val));
			  	
			  }else if (agem > 1){
			   	int val=Integer.parseInt(ageData.getValue("I"));
			  	val+=cnt;
			  	ageData.setValue("I",Integer.toString(val));
			  	
			  }else{
			  	int val=Integer.parseInt(ageData.getValue("N"));
			  	val+=cnt;
			  	ageData.setValue("N",Integer.toString(val));
			  }
			  
			  
		   }
		}///
		
				
	 	return ageData;
     }
          
     
     public Object getFormData(String ccode)throws RemoteException,SQLException {
     	
     	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select forms.description, count(*) as nop from listofforms,forms where forms.name = listofforms.type and upper(listofforms.type)<>'MED' and upper(forms.par_chl) <> 'C' group by forms.description Order by nop desc";
	 	else
	 		qSql = "Select forms.description, count(*) as nop from listofforms,forms where forms.name = listofforms.type and upper(listofforms.type)<>'MED' and upper(forms.par_chl) <> 'C' and pat_id LIKE '" + ccode + "%' group by forms.description Order by nop desc";
	 	return mydb.ExecuteQuary(qSql);	 
	 	
     }
     
     public Object getImageData(String ccode)throws RemoteException,SQLException {
     		
     	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select type,(select description from forms where name=type) as discrip,  count(*) as nop from patimages group by type Order by nop";
	 	else
	 		qSql = "Select type, (select description from forms where name=type) as discrip, count(*) as nop from patimages where pat_id LIKE '" + ccode + "%' group by type Order by nop";
	 	return mydb.ExecuteQuary(qSql);	 

     }
     
     public Object getImageVsPatData(String ccode)throws RemoteException,SQLException {
     	
     	dataobj imgVsPatData= new dataobj();
     		
     	String qSql ="";
	 	if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql = "Select count(pat_id) as nop from med where pat_id not in (select pat_id FROM patimages)";
	 	else
	 		qSql = "Select count(pat_id) as nop from med where pat_id not in (select pat_id FROM patimages) and pat_id LIKE '" + ccode + "%'";
	
		String cnt=mydb.ExecuteSingle(qSql);
		imgVsPatData.add("0",cnt);
	
	
		if(ccode.equalsIgnoreCase("XXXX"))
	 		qSql ="SELECT tab1.imgCnt, COUNT(tab1.pat_id) FROM (SELECT pat_id, COUNT(type) AS imgCnt FROM patimages GROUP BY pat_id) AS tab1 GROUP BY tab1.imgCnt  ORDER BY tab1.imgCnt";
	 	else
	 		qSql = "SELECT tab1.imgCnt, COUNT(tab1.pat_id) FROM (SELECT pat_id, COUNT(type) AS imgCnt FROM patimages GROUP BY pat_id) AS tab1 where pat_id LIKE '" + ccode + "%' GROUP BY tab1.imgCnt  ORDER BY tab1.imgCnt";
	
		
		Object obj = mydb.ExecuteQuary(qSql);	 
	 	if(obj instanceof String){
				System.out.println(obj.toString());
		}else{
			Vector Vtmp = (Vector)obj;
		    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 imgVsPatData.add(data.getValue(0),data.getValue(1));
		
			 }
		}
		
		
     return imgVsPatData;
     
     }
     
     public Object getTimeCountData(String ccode)throws RemoteException,SQLException {
     	
     	return null;
     }

    public Object getCenterData(String ccode)throws RemoteException,SQLException {
    	String qSql ="";
    	if(ccode.equalsIgnoreCase("XXXX")) 
     		//qSql = "select left(M.pat_id,4) as CODE,C.name as NAME,count(*) as PATIENTS from `med` as M inner join `center` as C on  C.code=left(M.pat_id,4)  group by left(M.pat_id,4)";
		    qSql ="select  C.code  as CODE,count(*) as PATIENTS from `med` as M inner join `center` as C on M.pat_id like concat('',C.code,'%')  group by C.code";
     	else
	 		//qSql = "select left(M.pat_id,4) as CODE,C.name as NAME,count(*) as PATIENTS from `med` as M inner join `center` as C on  C.code=left(M.pat_id,4) and C.code='"+ccode+"' group by left(M.pat_id,4)";
		 qSql ="select  C.code  as CODE,count(*) as PATIENTS from `med` as M inner join `center` as C on M.pat_id like concat('',C.code,'%') and C.code='"+ccode+"'  group by C.code";
		 System.out.println( "getCenterData-1: " + qSql);
	 	return mydb.ExecuteQuary(qSql);	 
	}

    public Object getCenterData(String ccode , String sst, String sto)throws RemoteException,SQLException {
    	String qSql ="";
		if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	//qSql = "select left(M.pat_id,4) as CODE,C.name as NAME,count(*) as PATIENTS from `med` as M inner join `center` as C on  C.code=left(M.pat_id,4) and C.code like '"+ccode+"%' and M.entrydate between date('" + sst + "') and date('" + sto + "') group by left(M.pat_id,4)";
		qSql ="select  C.code  as CODE,count(*) as PATIENTS from `med` as M inner join `center` as C on M.pat_id like concat('',C.code,'%') and C.code like '%"+ccode+"%' and M.entrydate between date('" + sst + "') and date('" + sto + "')  group by C.code";
		System.out.println( "getCenterData-2: " + qSql);
	 	return mydb.ExecuteQuary(qSql);	 
	}


	public Object getTpatQRefToData(String ccode)throws RemoteException,SQLException {
    	String qSql ="";
     	if(ccode.equalsIgnoreCase("XXXX")) 
     		qSql = "select assignedhos as ASNHOSP,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on M.pat_id like concat('',C.code,'%')  group by assignedhos ";
     	else
	 		qSql = "select assignedhos as ASNHOSP,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on M.pat_id like concat('',C.code,'%')  and C.code='"+ccode+"' group by assignedhos";
	 	return mydb.ExecuteQuary(qSql);	 
	}

	public Object getTpatQRefToData(String ccode, String sst, String sto)throws RemoteException,SQLException {
    	String qSql ="";
		if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	qSql = "select assignedhos as ASNHOSP,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on M.pat_id like concat('',C.code,'%')  and C.code like '%"+ccode+"%' and  M.entrydate between date('" + sst + "') and date('" + sto + "') group by assignedhos";
	 	return mydb.ExecuteQuary(qSql);	 
	}

	public Object getTpatQRefByData(String ccode)throws RemoteException,SQLException {
    	String qSql ="";
    	if(ccode.equalsIgnoreCase("XXXX")) 
     		qSql = "select refer_center as REFCODE,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on  M.pat_id like concat('',C.code,'%')  group by refer_center ";
     	else
	 		qSql = "select refer_center as REFCODE,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on M.pat_id like concat('',C.code,'%')  and C.code='"+ccode+"' group by refer_center";
	 	return mydb.ExecuteQuary(qSql);	 
	}

	public Object getTpatQRefByData(String ccode, String sst, String sto)throws RemoteException,SQLException {
    	String qSql ="";
		if(ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("ALL") || ccode.equalsIgnoreCase("")) ccode="";
	 	qSql = "select refer_center as REFCODE,count(*) as PATIENTS from `tpatq` as M inner join `center` as C on M.pat_id like concat('%',C.code,'%')  and C.code like '"+ccode+"%' and M.entrydate between date('" + sst + "') and date('" + sto + "')  group by refer_center";
	 	return mydb.ExecuteQuary(qSql);	 
	}

	public Object getDocPatQueueInfo(String doc_id) throws RemoteException, SQLException{
		Vector<String> result = new Vector<String>(5);
		Date d = new Date();
		String curDate = myDate.dateFormat("yyyy-MM-dd", d);

		try{
		// today's pending consultation (lpatq)
		String sql = "select count(*) as lpc from lpatq where assigneddoc = '"+doc_id + "' and appdate is null";
		System.out.println("getDocPatQueueInfo -> "+sql);
		result.add((String)mydb.ExecuteSingle(sql));
		

		// today's appointment (lpatq)
		sql = "select count(*) as la from lpatq where assigneddoc = '"+doc_id + "' and DATE(appdate) <= '"+curDate+"'";
		System.out.println("getDocPatQueueInfo -> "+sql);
		result.add((String)mydb.ExecuteSingle(sql));
		

		// today's pending consultation (tpatq)
		sql = "select count(*) as tpc from tpatq where assigneddoc = '"+doc_id + "' and teleconsultdt is null";
		System.out.println("getDocPatQueueInfo -> "+sql);
		result.add((String)mydb.ExecuteSingle(sql));
		

		// today's appointment (tpatq)
		sql = "select count(*) as ta from tpatq where assigneddoc = '"+doc_id + "' and DATE(teleconsultdt) <= '"+curDate+"'";
		System.out.println("getDocPatQueueInfo -> "+sql);
		result.add((String)mydb.ExecuteSingle(sql));

		// today's pending consultation (tpatwq)
		sql = "select count(*) as tw from tpatwaitq where referred_doc = '"+doc_id + "' and status = 'W'";
		System.out.println("getDocPatQueueInfo -> "+sql);
		result.add((String)mydb.ExecuteSingle(sql));
		
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
}
