package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.Date;
import java.util.*;
import imedix.dbGenOperations;

public class graphsinfo extends UnicastRemoteObject implements graphsinfointerface {
		
	projinfo pinfo;
	dball mydb;
	public graphsinfo(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
 	public String  getNoSibling(String patid )throws RemoteException,SQLException{
 		 //String sql="DECLARE @abc int SELECT @abc = COUNT(*) FROM h14 WHERE (PAT_ID ='"+patid+"') AND (LOWER(relationship) <> 'self') SELECT DISTINCT @abc + 1 FROM h14 WHERE (PAT_ID = '"+patid+"' ) AND (LOWER(relationship) = 'self')";
		// String sql= "SELECT COUNT(*) ((SELECT * FROM h14 WHERE ((pat_id ='"+patid+"') AND (LOWER(relationship) != 'self'))) UNION SELECT * FROM h14 WHERE (pat_id='" + patid + "' AND LOWER(relationship) = 'self') LIMIT 1)) as tab1 ";
		// return mydb.ExecuteProcSingle(sql);
		 
		 
		 String sql= "SELECT count(*) FROM ((select * FROM h14 WHERE ((pat_id ='"+patid+"') AND (LOWER(relationship) != 'self'))) UNION (SELECT * FROM h14 WHERE (pat_id='" + patid + "' AND LOWER(relationship) = 'self') Limit 1)) as tab1";
		 return mydb.ExecuteSingle(sql);
		 
	}
	
	public Object getSiblingHistory(String patid )throws RemoteException,SQLException{
		String sql= "SELECT * FROM (SELECT relationship, is_alive, commonparents, hiv, age_year, age_month, age_day, haart, oi, comments FROM h14 WHERE (pat_id='"+patid+"' AND LOWER(relationship) <> 'self') UNION SELECT relationship, is_alive, commonparents, hiv, age_year, age_month, age_day, haart, oi, comments FROM h14 WHERE pat_id='"+patid+"' AND LOWER(relationship) = 'self' AND entrydate = (SELECT MAX(entrydate) FROM h14 WHERE pat_id='"+patid+"' AND LOWER(relationship) = 'self') ) AS tab1 ORDER BY age_year DESC, age_month DESC, age_day DESC "; //LIMIT 1
        return mydb.ExecuteQuary(sql);  
	}
    
    public Object getParentHistory(String patid )throws RemoteException,SQLException{
    	String sql= "SELECT * FROM h12 WHERE pat_id='"+patid+"' ORDER BY entrydate DESC LIMIT 1";
        
        return mydb.ExecuteQuary(sql);    
    }
    
    public double[][] getAgeCoords(String patid, String tab_field, String tab_name)throws RemoteException,SQLException{
     
    Calendar c1 = Calendar.getInstance(); 
    String sql="SELECT age, dateofbirth, type, entrydate FROM med WHERE pat_id ='"+patid+"'";
    Object res=mydb.ExecuteQuary(sql); 
    String dob=""; 
      
    if(res instanceof String){
		System.out.println(res);
				
	}else{
		Vector tmp = (Vector)res;
		System.out.println("tmp.size()"+tmp.size());
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			dob = temp.getValue("dateofbirth");
										
			if (!dob.equalsIgnoreCase("")){
				 //dob=dob.substring(8,10)+"/"+dob.substring(5,7)+"/"+dob.substring(0,4);
			}else{
                String ag = temp.getValue(0);
                String entryDate = temp.getValue("entrydate");
				entryDate=entryDate.substring(0,10);
				System.out.println("entryDate length :"+entryDate);
				
				String xx [] = entryDate.split("-");
			    c1.set(Integer.parseInt(xx[0]),Integer.parseInt(xx[1])-1,Integer.parseInt(xx[2]));
				String ages[]=ag.split(",",3);
				//	System.out.println("ages.length :"+ages.length);
				if(!ages[0].equals("")) c1.add(Calendar.YEAR, - Integer.parseInt(ages[0].trim()));
				if(!ages[1].equals("")) c1.add(Calendar.MONTH, - Integer.parseInt(ages[1].trim()));
				if(!ages[2].equals("")) c1.add(Calendar.DATE, - Integer.parseInt(ages[2].trim()));
				dob=myDate.dateFormat("yyyy-MM-dd",c1.getTime());
									
                }
                
			}
	} //else
	
	System.out.println("dob:>>"+dob);

	sql="SELECT DISTINCT COUNT(*) FROM " + tab_name + " WHERE pat_id = '"+patid+"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != ''";
	String count = mydb.ExecuteSingle(sql);
	int cnt=0;
	if(count.equalsIgnoreCase("")) cnt=0;
	else cnt=Integer.parseInt(count);
	double[][] coords = new double[cnt][2];
	
	System.out.println("cnt:>>"+cnt);
	
	sql="SELECT DISTINCT " + tab_field + ", entrydate FROM " + tab_name + " WHERE pat_id ='"+patid +"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != '' ORDER BY entrydate";
	res=mydb.ExecuteQuary(sql); 
	cnt=0;
	
	if(res instanceof String){
		System.out.println(res);
				
	}else{
		Vector tmp = (Vector)res;
		System.out.println("tmp.size()"+tmp.size());
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String	tdt = temp.getValue(1);
			tdt=tdt.substring(0,10);
			String xx1 [] = tdt.split("-");
			java.util.Date tstdt = new Date(Integer.parseInt(xx1[0]),Integer.parseInt(xx1[1])-1,Integer.parseInt(xx1[2]));
			dob=dob.substring(0,10);
			String xx2 [] = dob.split("-");
			
			java.util.Date dobdt=new Date(Integer.parseInt(xx2[0]),Integer.parseInt(xx2[1])-1,Integer.parseInt(xx2[2]));
			long ldatetst=tstdt.getTime();
			long ldatedob=dobdt.getTime();
			int hrtst   = (int)(ldatetst/3600000); //60*60*1000
		    int hrdob   = (int)(ldatedob/3600000);
		    int daystst = (int)hrtst/24;
		    int daysdob = (int)hrdob/24;
		    int daysDiff  = daystst - daysdob;
		    
		    System.out.println("daysDiff:>>"+daysDiff);
		    		    
		    //	    int years =		(int)(daysDiff / 365);
		    //        int months = (int)((daysDiff % 365) / 30);
		    //        int days = daysDiff - (years * 365 + months * 30);
		            
			String vl=temp.getValue(0);
			if (vl.equalsIgnoreCase("")) vl="0";
			System.out.println("daysDiff/30 :>>"+(daysDiff/30));
				
		   	coords[cnt][0] = (daysDiff/30.0);
        	coords[cnt][1] = Double.parseDouble(vl);
           	cnt++;
		}
	}
    return coords;	
    }
    
   public double[][] getAgeCoords(String patid, String tab_field, String tab_name, int agemonth) throws RemoteException,SQLException{
   	
   	dbGenOperations dbGen=new dbGenOperations(pinfo);
    String dob= dbGen.getDobOfPatient(patid);
      
	System.out.println("dob:>> "+dob);
	
	String sql="SELECT DISTINCT COUNT(*) FROM " + tab_name + " WHERE pat_id = '"+patid+"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != '' AND " + (agemonth <= 24 ? "(DATEDIFF(testdate,'" + dob + "')/30.41) <= 24" : "(DATEDIFF(testdate,'" + dob + "')/30.41) > 24");
	
	System.out.println("\n\r"+sql+"\n\r");

	String count = mydb.ExecuteSingle(sql);
	int cnt=0;
	if(count.equalsIgnoreCase("")) cnt=0;
	else cnt=Integer.parseInt(count);
	double[][] coords = new double[cnt][2];
	System.out.println("cnt:>>"+cnt);
	
	sql="SELECT DISTINCT " + tab_field + ", testdate FROM " + tab_name + " WHERE pat_id ='"+patid +"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != '' AND " + (agemonth <= 24 ? "(DATEDIFF(testdate,'" + dob + "')/30.41) <= 24" : "(DATEDIFF(testdate,'" + dob + "')/30.41) > 24")+" ORDER BY testdate";
	
	System.out.println("*\n\r"+sql+"\n\r");
		
	Object res=mydb.ExecuteQuary(sql); 
	cnt=0;
	if(res instanceof String){
		System.out.println(res);
	}else{
		Vector tmp = (Vector)res;
		System.out.println("tmp.size()"+tmp.size());
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String	tdt = temp.getValue(1);
			tdt=tdt.substring(0,10);
			String xx1 [] = tdt.split("-");
			java.util.Date tstdt = new Date(Integer.parseInt(xx1[0]),Integer.parseInt(xx1[1])-1,Integer.parseInt(xx1[2]));
			dob=dob.substring(0,10);
			String xx2 [] = dob.split("-");
			java.util.Date dobdt=new Date(Integer.parseInt(xx2[0]),Integer.parseInt(xx2[1])-1,Integer.parseInt(xx2[2]));
			long ldatetst=tstdt.getTime();
			long ldatedob=dobdt.getTime();
			int hrtst   = (int)(ldatetst/3600000); //60*60*1000
		    int hrdob   = (int)(ldatedob/3600000);
		    int daystst = (int)hrtst/24;
		    int daysdob = (int)hrdob/24;
		    int daysDiff  = daystst - daysdob;
		    System.out.println("daysDiff:>>"+daysDiff);
		    
		    //	    int years =		(int)(daysDiff / 365);
		    //      int months = (int)((daysDiff % 365) / 30);
		    //      int days = daysDiff - (years * 365 + months * 30);
			
			String vl=temp.getValue(0);
			if (vl.equalsIgnoreCase("")) vl="0";
			System.out.println("daysDiff/30 :>>"+(daysDiff/30.41));
		   	coords[cnt][0] = (daysDiff/30.41);
        	coords[cnt][1] = Double.parseDouble(vl);
           	cnt++;
		}
	}
	return coords;      
   }    

   public double[][] getHIVRefCoords(String field_x, String field_y,String tab_name, int agemonth) throws RemoteException,SQLException{
    	
    	
    	String sql="SELECT DISTINCT COUNT(*) FROM " + tab_name + " WHERE " + field_y + " IS NOT NULL AND " + (agemonth <= 24 ? "agemonth <= 24" : "agemonth > 24");
    	String count = mydb.ExecuteSingle(sql);
		int cnt=0;
		if(count.equalsIgnoreCase("")) cnt=0;
		else cnt=Integer.parseInt(count);
		System.out.println(cnt);
		double[][] coords = new double[cnt][2];
	
		sql="SELECT DISTINCT " + field_x + ", " + field_y + " FROM " + tab_name + " WHERE " + field_y + " IS NOT NULL AND " + (agemonth <= 24 ? "agemonth <= 24" : "agemonth > 24")+ " ORDER BY " + field_x;
		Object res=mydb.ExecuteQuary(sql); 
		System.out.println(sql);
		
		if(res instanceof String){
			System.out.println(res);
		}else{
			Vector tmp = (Vector)res;
			System.out.println(" getHIVRefCoords : tmp.size() "+tmp.size());
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
					coords[i][ 0] = Double.parseDouble(temp.getValue(0));
                	coords[i][ 1] =  Double.parseDouble(temp.getValue(1));                
			}
		}
		return coords;	
		
    }
    
     public String  getGraphList(String patid )throws RemoteException,SQLException{
     	String tempstr = "";
     	String sql="SELECT DISTINCT q.field_id, q.field_caption, q.field_unit FROM quantitative_field q INNER JOIN listofforms l ON q.form_id = l.TYPE WHERE (l.PAT_ID ='"+patid+"')";
     	Object res=mydb.ExecuteQuary(sql); 
		System.out.println(sql);
		
		if(res instanceof String){
			System.out.println(res);
		}else{
			Vector tmp = (Vector)res;
			System.out.println(" getHIVRefCoords : tmp.size() "+tmp.size());
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				tempstr += "<li><a href='../servlet/gengraph?x=age&y=" + temp.getValue(0) + "&caption=" + temp.getValue(1) + "' target='content2'>Age vs. " + temp.getValue(1) + "</a></li>";
			}
		}
		System.out.println(tempstr);
        return tempstr;
    }
 
     public double[][] getGenGraphCoords(String patid, String x, String y)throws RemoteException,SQLException{
    	
    	
    Calendar c1 = Calendar.getInstance(); 
    String dob=myDate.getCurrentDate("ymd",true);
    
    if(x.equalsIgnoreCase("age")){
	        
	    String sql="SELECT age, dateofbirth, type, entrydate FROM med WHERE pat_id ='"+patid+"'";   
	    Object res=mydb.ExecuteQuary(sql); 
	    if(res instanceof String){
			System.out.println(res);
					
		}else{
			Vector tmp = (Vector)res;
			System.out.println("tmp.size()"+tmp.size());
			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				dob = temp.getValue("dateofbirth");
											
				if (!dob.equalsIgnoreCase("")){
					 //dob=dob.substring(8,10)+"/"+dob.substring(5,7)+"/"+dob.substring(0,4);
				}else{
	                String ag = temp.getValue(0);
	                String entryDate = temp.getValue("entrydate");
					entryDate=entryDate.substring(0,10);
					
					String xx [] = entryDate.split("-");
				    c1.set(Integer.parseInt(xx[0]),Integer.parseInt(xx[1])-1,Integer.parseInt(xx[2]));
					String ages[]=ag.split(",",3);
					//	System.out.println("ages.length :"+ages.length);
					if(!ages[0].equals("")) c1.add(Calendar.YEAR, - Integer.parseInt(ages[0].trim()));
					if(!ages[1].equals("")) c1.add(Calendar.MONTH, - Integer.parseInt(ages[1].trim()));
					if(!ages[2].equals("")) c1.add(Calendar.DATE, - Integer.parseInt(ages[2].trim()));
					dob=myDate.dateFormat("yyyy-MM-dd",c1.getTime());
										
	                }
	                
				}
		} //else
		
	}//////
	
	System.out.println("********* dob:>>"+dob);
	
	String tab_field = "", tab_name = "";
    String qSql = "SELECT tab_field, tab_name FROM quantitative_field WHERE field_id ='"+y+"'";
    System.out.println("*1:"+qSql);
    
    Object res=mydb.ExecuteQuary(qSql); 
    if(res instanceof String){
		System.out.println(res);
	}else{
		Vector tmp = (Vector)res;
		System.out.println("tmp.size()"+tmp.size());
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			tab_field = temp.getValue(0);
			tab_name = temp.getValue(1);
		}
	}
		
	qSql = "SELECT DISTINCT COUNT(*) FROM " + tab_name + " WHERE pat_id ='"+patid+"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != ''";
	
	System.out.println("**2:"+qSql);
	
	String count = mydb.ExecuteSingle(qSql);
	int cnt=0;
	if(count.equalsIgnoreCase("")) cnt=0;
	else cnt=Integer.parseInt(count);
    	
   double[][] coords = new double[cnt][2];
    	
  qSql = "SELECT DISTINCT " + tab_field + ", testdate  FROM " + tab_name + " WHERE pat_id = '"+patid+"' AND " + tab_field + " IS NOT NULL AND " + tab_field + " != '' ORDER BY testdate"; 
  
  System.out.println("***3:"+qSql);
  res=mydb.ExecuteQuary(qSql); 
  if(res instanceof String){
			System.out.println(res);
	}else{
		Vector tmp = (Vector)res;
		System.out.println(" getHIVRefCoords : tmp.size() "+tmp.size());
		cnt=0;
		for(int i=0;i<tmp.size();i++){
			dataobj temp1 = (dataobj) tmp.get(i);
			
			String vl=temp1.getValue(0);
			String	tdt = temp1.getValue(1);
			
			System.out.println("***vl:>>"+vl);
			System.out.println("***tdt:>>"+tdt);
			
			tdt=tdt.substring(0,10);
			String xx1 [] = tdt.split("-");
			java.util.Date tstdt = new Date(Integer.parseInt(xx1[0]),Integer.parseInt(xx1[1])-1,Integer.parseInt(xx1[2]));
			dob=dob.substring(0,10);
			
			System.out.println("***dob:"+dob);
				
			String xx2 [] = dob.split("-");
			java.util.Date dobdt=new Date(Integer.parseInt(xx2[0]),Integer.parseInt(xx2[1])-1,Integer.parseInt(xx2[2]));
			long ldatetst=tstdt.getTime();
			long ldatedob=dobdt.getTime();
			int hrtst   = (int)(ldatetst/3600000); //60*60*1000
		    int hrdob   = (int)(ldatedob/3600000);
		    int daystst = (int)hrtst/24;
		    int daysdob = (int)hrdob/24;
		    int daysDiff  = daystst - daysdob;
		    System.out.println("daysDiff:>>"+daysDiff);
		    		    
		    //	    int years =		(int)(daysDiff / 365);
		    //      int months = (int)((daysDiff % 365) / 30);
		    //      int days = daysDiff - (years * 365 + months * 30);
		            
			if (vl.equalsIgnoreCase("")) vl="0";
			System.out.println("daysDiff/30 :>>"+(daysDiff/30));
		   	coords[cnt][0] = (daysDiff/30.0);
        	coords[cnt][1] = Double.parseDouble(vl);  
        	cnt++;            
		}
	}
		
	System.out.println("***** coords:>>>>"+coords.length);
		
	return coords;
    	
  }
    
}