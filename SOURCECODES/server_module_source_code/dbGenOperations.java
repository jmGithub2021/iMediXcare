package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.StringTokenizer;
import java.util.Date;
import java.util.*;
import logger.*;


/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Class used for Manage Database Operations of iMediX System.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see dbGenOperationsInterface
 */
 
public class dbGenOperations extends UnicastRemoteObject implements dbGenOperationsInterface {
		
	projinfo pinfo;
	dball mydb;
	
	/**
     * Constructor used to create this object.
     * @param p server Configuration class object.
     * @see projinfo
     */
     
	public dbGenOperations(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
public Object dataforGeneral(String category) throws RemoteException,SQLException{

            String qSql= "SELECT obsncode,finding FROM exam WHERE category='"+category+"'";
           // System.out.print("dataforGeneral="+qSql);	
            return mydb.ExecuteQuary(qSql);  
     }


	public String  FindCount(String table,String cond )throws RemoteException,SQLException{
		 String sql="Select count(*) from "+ table +" where "+ cond;
		 System.out.println(sql);
		 return mydb.ExecuteSingle(sql);
	}
    
    public String  FindCount(String table)throws RemoteException,SQLException{
    	String sql="Select count(*) from "+ table ;
    	return mydb.ExecuteSingle(sql);
    }
        
    public Object findRecords(String tname, String flds, String cond)throws RemoteException,SQLException{
       String sql="SELECT "+flds+" FROM "+tname +" WHERE "+cond;
      // System.out.println(sql);
       //dball mydb= new dball(pinfo);
       Object aa=mydb.ExecuteQuary(sql);
       return aa;  	
    }
            
    public String  getAnySingleValue(String tname, String fld, String cond)throws RemoteException,SQLException{
    	String sql="SELECT "+fld+" FROM "+tname +" WHERE "+cond;
    	System.out.println("getAnySingleValue>>"+sql);
    	
    	//dball mydb= new dball(pinfo);
    	return mydb.ExecuteSingle(sql);
    }
    
    public int  saveAnyInfo(dataobj obj)throws RemoteException,SQLException {
    		
    		int ans =0;
    		dataobj tmp= obj;
    		String qr="",tname="",key="",val="",fld="";
    		try{
    			tname=tmp.getValue("tname");
    			qr = "select * from "+ tname;
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				
				fld = " (";
				qr  = " values( ";
							
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
					String qv=tmp.getValue(key);
					qv=qv.replaceAll("'","''");
					
					fld=fld+key+",";
					
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") || val.equalsIgnoreCase("VARCHAR"))
								qr = qr+"'"+qv+"',";
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								String dt=myDate.getFomateDate("ymd",true,qv);
								qr = qr+"'"+dt+"',";
							}
							else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
							qr = qr+qv+",";
							else {
								//	System.out.println("MatchNot Found :" +tname+":"+val);
									qr = qr+"'"+ qv +"',";
									}
						}else
							qr = qr + "null,";					
				}

				
				fld=fld.substring(0,fld.length()-1)+")";
				qr=qr.substring(0,qr.length()-1)+")";
				qr="insert into "+tname +  fld + qr;		
				//System.out.println(qr);
	   			mydb.ExecuteSql(qr);
    			ans =1;
    			
    			if(ans==1){
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					desdtls.add("table",tname);
					desdtls.add("details","Inser Data");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   		}
	   		
    		}catch(Exception e){
    			ans =0;	
    		}
    		
    	return ans;	
    }
   
   
   public int  saveAnyInfo(dataobj obj,String prmkey)throws RemoteException,SQLException{
   		String tname=obj.getValue("tname");
   		String pkeyval=obj.getValue(prmkey);
   		String dQr = "delete from "+ tname +" where "+prmkey+"='"+pkeyval+"'";
   		mydb.ExecuteSql(dQr);
   		return this.saveAnyInfo(obj);
   }
    
    
   public int  updateAppDate(dataobj obj)throws RemoteException,SQLException{
   	
     	String appdt=obj.getValue("editdate");
   		appdt=myDate.getFomateDate("ymd",true,appdt);
	   	String sqlQuery = "Update lpatq set appdate = '"+appdt+"', checked ='Y' where pat_id = '"+obj.getValue("pat_id")+"'";
     	String str=mydb.ExecuteSql(sqlQuery);
     	if(str.equalsIgnoreCase("Error")) return 0;
   		else{
   		
   		
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("pat_id",obj.getValue("pat_id"));
					desdtls.add("table","lpatq");
					desdtls.add("details","Update Appointment Date");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	   
	   		
   				return 1;		
   		}
   	
   }
   
   public String  getDobOfPatient(String patid )throws RemoteException,SQLException{
   	   	
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
				String xx [] = entryDate.split("-");
			    
			    c1.set(Integer.parseInt(xx[0]),Integer.parseInt(xx[1])-1,Integer.parseInt(xx[2]));
				String dten=myDate.dateFormat("yyyy-MM-dd",c1.getTime());
				System.out.println("dten : "+dten);
				
				String ages[]=ag.split(",",3);
				
				//	System.out.println("ages.length :"+ages.length);
				if(!ages[0].equals("")) c1.add(Calendar.YEAR, - Integer.parseInt(ages[0].trim()));
				if(!ages[1].equals("")) c1.add(Calendar.MONTH, - Integer.parseInt(ages[1].trim()));
				if(!ages[2].equals("")) c1.add(Calendar.DATE, - Integer.parseInt(ages[2].trim()));
				dob=myDate.dateFormat("yyyy-MM-dd",c1.getTime());
				
				System.out.println("dob : "+dob);
				
                }
			}
	} //else
	
	return dob;
	
   }
   
   public String  getAgeInMonthOfPatient(String patid,String cdt )throws RemoteException,SQLException{
   	
   			String	tdt = cdt;
			tdt=tdt.substring(0,10);
			tdt=tdt.replace("/","-");
			
			String dob=getDobOfPatient(patid);
			dob=dob.replace("/","-");
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
		    
		    String agem=Integer.toString((daysDiff/30));        
		 	return agem;
   }
   
   public String  getAgeInDaysOfPatient(String patid,String cdt )throws RemoteException,SQLException{
   	
   			String	tdt = cdt;
			tdt=tdt.substring(0,10);
			tdt=tdt.replace("/","-");
			
			String dob=getDobOfPatient(patid);
			dob=dob.replace("/","-");
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
		    String ageday=Integer.toString(daysDiff);        
		 	return ageday;
		 	
   }
   
   public String  getPatientName(String patid)throws RemoteException,SQLException{
   		String qSql="SELECT trim(CONCAT(IFNULL(pre,'') , ' ' , IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) from med where pat_id='"+ patid +"'";
   		return mydb.ExecuteSingle(qSql);
   	
   }
   
	public boolean isLeapYear(int y){
         if (y%4==0){
         	if(y%100==0) {
         		if(y%400==0)return true;
         		else return false;
         	}else return true;
         }else return false;
   }
    
   public String  getPatientAgeYMD(String patid,String cdt)throws RemoteException,SQLException{
   			
   			int[] monthDay = {31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
   			int year;
        	int month;
        	int day;
        	int increment;
        	
			cdt=cdt.substring(0,10);
			cdt=cdt.replace("/","-");
			String xx1 [] = cdt.split("-");
			java.util.Date currdt = new Date(Integer.parseInt(xx1[0]),Integer.parseInt(xx1[1])-1,Integer.parseInt(xx1[2]));
			
			String dob=getDobOfPatient(patid);
			dob=dob.replace("/","-");
			dob=dob.substring(0,10);
			String xx2 [] = dob.split("-");		
			java.util.Date fromDate=new Date(Integer.parseInt(xx2[0]),Integer.parseInt(xx2[1])-1,Integer.parseInt(xx2[2]));
			
			
			/// 
            /// Day Calculation
            /// 
            
            increment = 0;
			if (fromDate.getDate() > currdt.getDate())
            {
                increment = monthDay[fromDate.getMonth()-1];
            }

            /// if it is february month
            /// if it's to day is less then from day
            
            if (increment == -1)
            {
                if (isLeapYear(fromDate.getYear())==true)
                {
                    // leap year february contain 29 days
                    //System.out.println("isLeapYear : "+fromDate.getYear());
                    increment = 29;
                }
                else
                {
                    increment = 28;
                }
            }
            
            if (increment != 0)
            {
                day = (currdt.getDate() + increment) - fromDate.getDate();
                increment = 1;
            }
            else
            {
                
                day = currdt.getDate() - fromDate.getDate();
                
                //System.out.println(currdt.getDate()+","+fromDate.getDate() +" day:"+day);
                
            }
            
            ///
            ///month calculation
            ///
            if ((fromDate.getMonth() + increment) > currdt.getMonth())
            {
                month = (currdt.getMonth() + 12) - (fromDate.getMonth() + increment);
                increment = 1;
            }
            else
            {
                month = currdt.getMonth() - (fromDate.getMonth() + increment);
                increment = 0;
            }

            ///
            /// year calculation
            ///
            year = currdt.getYear() - (fromDate.getYear() + increment);
            String op="";
            
            if(year>0) op+=year + (year>1 ? " Year(s)," : " Year," );
            if(month>0) op+=" "+month + (month>1 ? " Month(s)," : " Month," ); //" month(s),";
            if(day>0) op+=" "+day + (day>1 ? " Day(s)," : " Day," ); // " day(s),";
            op=op.substring(0,op.length()-1);
            
			
		return op;	
				
   }

    public String dataforImmunization(String string) throws RemoteException, SQLException {
        String string2 = "";
        String string3 = "";
        String string4 = "-1";
        int n = 0;
        String string5 = "select a13.vaccine_id,a13.age_given,a13.site,a13.code,a13.entrydate,immun_schedule.age,immun_schedule.vaccine_code as vaccine_code,";
        string5 = string5 + "(select vac_name from immunization where immunization.vac_code=immun_schedule.vaccine_code) as vName,";
        string5 = string5 + "(select vac_info from immunization where immunization.vac_code=immun_schedule.vaccine_code) as info,";
        string5 = string5 + "(select disease from immunization where immunization.vac_code=immun_schedule.vaccine_code) as Dis";
        string5 = string5 + " from a13, immun_schedule where a13.vaccine_id=immun_schedule.vac_id and pat_id='" + string + "' order by vaccine_code";
        try {
            Object object = this.mydb.ExecuteQuary(string5);
            if (object instanceof String) {
                string2 = "Error : " + object;
            } else {
                Vector vector = (Vector)object;
                if (vector.size() > 0) {
                    for (int i = 0; i < vector.size(); ++i) {
                        dataobj dataobj2 = (dataobj)vector.get(i);
                        String string6 = dataobj2.getValue("vaccine_code");
                        System.out.println(string4 + "=" + string6);
                        if (!string6.equalsIgnoreCase(string4)) {
                            if (!string4.equalsIgnoreCase("-1")) {
                                string2 = string2 + "</table></td></tr></table><br>";
                            }
                            string2 = string2 + "<table border='0' width='90%' align='center'>";
                            string2 = string2 + "<tr><td style='color:blue;font-weight:bold;font-size:12pt' style='cursor:pointer;cursor:hand;' onclick='shownhide(" + n + ", 100)')>" + dataobj2.getValue(9) + "</td></tr>";
                            string2 = string2 + "<tr><td><table  id='tab_" + n + "' align='center' width='100%' cellspacing='1' cellpadding='3' style='visibility:hidden;display:none;background-color:#CECEFF;'>";
                            string2 = string2 + "<tr style='background-color:#CBF8CB;height:15px'><th>Vaccine</th><th>Date Given</th><th>Site</th><th>Age Given</th><th>Age Recomended</th><th>Code</th></tr>";
                            string4 = string6;
                            ++n;
                        }
                        String string7 = dataobj2.getValue(7) + " " + dataobj2.getValue(0).substring(dataobj2.getValue(0).length() - 1);
                        string3 = myDate.mysql2ind((String)dataobj2.getValue(4));
                        string2 = string2 + "<tr align='center' style='background-color:#FEFEF2;border:1px solid #880088'>";
                        string2 = string2 + "<td>" + string7 + "</td>";
                        string2 = string2 + "<td>" + string3 + "</td>";
                        string2 = string2 + "<td>" + dataobj2.getValue(2) + "</td>";
                        string2 = string2 + "<td>" + dataobj2.getValue(1) + "</td>";
                        string2 = string2 + "<td>" + dataobj2.getValue(5) + "</td>";
                        string2 = string2 + "<td>" + dataobj2.getValue(3) + "</td>";
                        string2 = string2 + "</tr>";
                    }
                }
            }
        }
        catch (Exception var8_8) {
            string2 = "Error :" + var8_8.toString();
        }
        return string2;
    }

    public String getVaccineRecAge(String string) throws RemoteException, SQLException {
        String string2 = "Select age from immun_schedule where vac_id='" + string + "'";
        return this.mydb.ExecuteSingle(string2);
    }

	public String exeSingleSQL(String sqlq)throws RemoteException,SQLException
	{
		return mydb.ExecuteSingle(sqlq);
    }
    public boolean isTelePat(String patid, String assigneddoc){
		boolean result = false;
		String sql = "select count(*) from tpatq where pat_id='"+patid+"' and assigneddoc = '"+assigneddoc+"'";
		System.out.println(sql);
		String nofp = mydb.ExecuteSingle(sql);
		int no_of_pat = 0;
		try{
			no_of_pat = Integer.parseInt(nofp);
		}catch(Exception ex){no_of_pat=0;}
		if(no_of_pat > 0)
			result = true;
		else
			result = false;		
	return result;
	}
	public boolean uploadCOVIDdata(String patientid, String result) throws RemoteException,SQLException{
		boolean rs = false;
		String sql = "insert into covid19(pat_id, result) values('"+patientid+"','"+result+"')";
		//if(patientid!=null){
			System.out.println(sql);
		try{
			String db_result = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(db_result.equalsIgnoreCase("Done"))
				rs = true;
			else
				rs = false;
		}catch(Exception ex){
			System.out.println("uploadCOVIDdata() ERR: "+ex.toString());
			rs = false;
		}
		//}*/
		return rs;	
	}
    public String getCOVIDdata(String patid) throws RemoteException, SQLException {
        String sql = "Select result from covid19 where pat_id='" + patid + "'";
        return this.mydb.ExecuteSingle(sql);
    }	

}
