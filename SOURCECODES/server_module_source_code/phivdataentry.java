package phiv;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Vector;
import java.util.StringTokenizer;
import imedix.*;
import logger.*;

public class phivdataentry extends UnicastRemoteObject implements phivdataentryinterface {
		
	projinfo pinfo;
	dball mydb;
	
	public phivdataentry(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	 public Object dataforGenotype(String mutationtype)throws RemoteException,SQLException{
	
	  	String qSql="Select mutation from genotype where trim(mutation_type) ='"+mutationtype.trim()+"'";
	  	//System.out.print("dataforGenotype="+qSql);
	 	return mydb.ExecuteQuary(qSql);
	 	
	 }
     public Object dataforGeneral(String category) throws RemoteException,SQLException{

            String qSql= "SELECT obsncode,finding FROM exam WHERE category='"+category+"'";
           // System.out.print("dataforGeneral="+qSql);	
            return mydb.ExecuteQuary(qSql);  
     }
     
     public Object dataforpillcount(String patid) throws RemoteException,SQLException{
    
       	 //String gSql = "select distinct row_id,drug,formula,prep,dose,pill_desp,balance,pill_consumed,remarks,ROUND(CAST(pill_consumed AS FLOAT)/pill_desp*100, 2) from a02 as pc,drugindex as dr,formulation as fm,arvpackage as arvp where pat_id='"+patid+"' and balance>0 and pc.drug_id=dr.id_drugindex and arvp.id_arvpackage=pc.arvpackage_id and arvp.formula=fm.id_formulation Union select distinct row_id,drug,formula,prep,dose,pill_desp,balance,pill_consumed,remarks, 0 from  a02 pc,drugindex dr,formulation fm,arvpackage arvp where pat_id='"+patid+"' and pill_desp=0 and pc.drug_id=dr.id_drugindex and arvp.id_arvpackage=pc.arvpackage_id and arvp.formula=fm.id_formulation"; 
       	 //String gSql = "select distinct row_id,drug,formula,prep,dose,pill_desp,balance,pill_consumed,remarks,pill_consumed from k02  pc,drugindex  dr,formulation  fm,arvpackage  arvp where pat_id='"+patid+"' and balance>0 and pc.drug_id=dr.id_drugindex and arvp.id_arvpackage=pc.arvpackage_id and arvp.formula=fm.id_formulation Union select distinct row_id,drug,formula,prep,dose,pill_desp,balance,pill_consumed,remarks, 0 from  k02 pc,drugindex dr,formulation fm,arvpackage arvp where pat_id='"+patid+"' and pill_desp=0 and pc.drug_id=dr.id_drugindex and arvp.id_arvpackage=pc.arvpackage_id and arvp.formula=fm.id_formulation"; 
         
         String gSql = "select distinct row_id,drug_name,formulation_am,formulation_pm,dose_am,dose_pm,pill_disp,balance,pill_consumed," +
                                "Round(cast(pill_consumed as DECIMAL)/pill_disp*100, 2) " +
                                "from  k02 pc,drug_grp dg " +
                                "where PAT_ID='"+ patid + "' and balance>0 and pc.drug_id=dg.drug_id " +
                                "Union select distinct row_id,drug_name,formulation_am,formulation_pm,dose_am,dose_pm,pill_disp,balance,pill_consumed, 0 " +
                                "from  k02 pc,drug_grp dg " +
                                "where PAT_ID='"+ patid +"' and pill_disp=0 and pc.drug_id=dg.drug_id";
                                
         
         System.out.println("\n"+gSql+"\n");
         
         return mydb.ExecuteQuary(gSql);  
         
     }
     	 
	 public int updatePillCount(String[][] arr,String patid,dataobj obj) throws RemoteException,SQLException{
	 	 String qr="";
	 	 String ans="";
            for (int i = 0; i < arr.length;i++ ){
            	qr = "update k02 set pill_disp='" + arr[i][1] + "',pill_consumed='" + arr[i][2] +"',balance='"+(Integer.parseInt(arr[i][1])-Integer.parseInt(arr[i][2]))+"' where row_id='" + arr[i][0].trim() + "' and pat_id='"+patid+"'";
            	ans=mydb.ExecuteSql(qr);
            	
             if(ans.equalsIgnoreCase("Done")){
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",patid);
					keydtls.add("row_id",arr[i][0]);
					
					desdtls.add("table","k02");
					desdtls.add("details","Update Pill Count");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
				}
            }
            
           if(ans.equalsIgnoreCase("Done")){
           	
           	
	   			
           	 return 1;
           }else return 0;
            
	 }
	 
	 public Object getDrugName(int agemonth) throws RemoteException,SQLException{

	 	String qSql= "SELECT id_drugindex,drug FROM drugindex where minagemonth <="+agemonth+" and id_drugindex < 99 ORDER BY id_drugindex";
	 	System.out.println(qSql);
	 	return mydb.ExecuteQuary(qSql);  	
	 }
	 
	 public Object getFormulation(int drugID ) throws RemoteException,SQLException{
	 	
        String qSql= "SELECT id_arvpackage,prep,formuladose FROM arvpackage,formulation WHERE id_drug="+drugID+" AND id_formulation=formula ORDER BY formula";
       	System.out.println(qSql);
       	
        return mydb.ExecuteQuary(qSql);  
        
	 }
	 
	 public Object getDrugDose(int armvpackageid) throws RemoteException,SQLException{
	 	
	 	dataobj obj=new dataobj();
	 	
	 	String qSql = "SELECT DISTINCT formula FROM arvpackage WHERE id_arvpackage="+armvpackageid;
	 	String formula=mydb.ExecuteSingle(qSql);
	 	qSql = "SELECT DISTINCT am FROM weightband WHERE id_pack="+armvpackageid+" AND weight=(select max(weight) FROM weightband WHERE weight<=14)";
 		String am=mydb.ExecuteSingle(qSql);
 		obj.add("formula",formula);
 		obj.add("am",am);
 		
	 	return obj;
	 }
	 public String getDrugInfo(int drugID) throws RemoteException,SQLException{
	 	
	 	String qSql = "SELECT comment From drugindex WHERE id_drugindex="+drugID;
	 	System.out.println(qSql+"\n "+mydb.ExecuteSingle(qSql));
	 	
	 	return mydb.ExecuteSingle(qSql);
	 	
	 }
	 public String getDrugList(String id) throws RemoteException,SQLException{
	 		

           	String qSql= "select drug_id, drug_name, drug_grpid from drug_grp order by drug_grpid";
            String newgrp = "", prevgrp = "", selstr = "";
            System.out.println("getDrugList:\n"+qSql);
            
            Object res=mydb.ExecuteQuary(qSql);
            
            if(res instanceof String){
				selstr= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				if(tmp.size()>0){
				for(int i=0;i<tmp.size();i++){
			 		dataobj temp = (dataobj) tmp.get(i);
				 		newgrp = temp.getValue(2);
			 			if (!prevgrp.equalsIgnoreCase(newgrp)){
			 				
							if (prevgrp.equalsIgnoreCase("")) selstr += "</OPTGROUP>";
							selstr += "<OPTGROUP LABEL='" + newgrp + "'>";
						}
						selstr += "<OPTION VALUE='" + temp.getValue(0) + "'>" + temp.getValue(1) + "</OPTION>";
						prevgrp = newgrp;					
					}
					selstr = "<SELECT id='drug" + id + "' name='drug" + id + "' onchange=populateFormula('" + id + "')><OPTION VALUE=''>Choose One</OPTION>" + selstr + "</SELECT>";
						
				}
			}	 	 
	 	return selstr;
	 }
	 
	 public String getFormulationList(String patid, String drugid, String id) throws RemoteException,SQLException{
	 	
	 	String qSql = "DECLARE @wt float SELECT TOP 1 @wt = wt FROM h15 WHERE PAT_ID='"+patid+"' ORDER BY entrydate DESC SELECT range_id FROM param_range where param_start <= @wt and param_end >= @wt and param_type = 'w'";
   	 	String rangeid = mydb.ExecuteProcSingle(qSql);
   	 	
        qSql = "SELECT item_no, dd.dose_id, formulation, med_amount FROM param_drug pd, dose_list dl, drug_dose dd WHERE pd.drug_id='"+drugid+"' AND pd.range_id='"+rangeid+"' AND pd.list_id=dl.list_id AND dl.dose_id=dd.dose_id AND pd.drug_id=dd.drug_id ORDER BY item_no";
     	String selstr = "";
      
        Object res=mydb.ExecuteQuary(qSql);
            
            if(res instanceof String){
				selstr= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				if(tmp.size()>0){
				for(int i=0;i<tmp.size();i++){
			 		dataobj temp = (dataobj) tmp.get(i);
			 		 selstr += "<OPTION VALUE='" + temp.getValue(0) + "'>" + temp.getValue(2) + "</OPTION>";
			 		 
			 		}
			 		selstr = "<SELECT id='form" + id + "' name='form" + id + "' >" + selstr + "</SELECT>";
			 	}
			 }
	 	return selstr;
	 }
	 
	 public int putPrescriptionDatainDB(String patid, String[][] data_Prescription,String ctx,String ctxdose,String duration, String edate,dataobj obj) throws RemoteException,SQLException{
	 
        String qr="";
        int pillConsumed=0;
		if (ctx.equals("")) ctx="null";
		if (ctxdose.equals("")) ctxdose="null";
		if (duration.equals("")) duration="null";
        String qSql = "select count(pat_id) from a02 where pat_id='"+patid+"'";
        String slno = mydb.ExecuteSingle(qSql);
        String res="";
        
        for (int i = 0; i < data_Prescription.length; i++){
          	qr="";
            System.out.println("********"+i+" >>"+data_Prescription[i][0] + ">>"+data_Prescription[i][1]);
            if (data_Prescription[i][0].equals("") || data_Prescription[i][1].equals("") || data_Prescription[i][2].equals("")) continue;
            qr += "insert into a02(pat_id,drug_id,arvpackage_id,dose,pill_desp,balance,pill_consumed,ctx,ctxdose,duration,entrydate,serno)";
            qr += "values('" + patid + "','" + data_Prescription[i][0].replaceAll("'","''") + "','" + data_Prescription[i][1].replaceAll("'","''")+ "','" + data_Prescription[i][2].replaceAll("'","''") + "','" + data_Prescription[i][3].replaceAll("'","''")+ "','" + data_Prescription[i][3]+ "','" + pillConsumed + "'," + ctx + "," + ctxdose + "," + duration + ",'" + edate + "','" + slno + "') ";
           	res=mydb.ExecuteSql(qr);         	
          }
          
         String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent)"; 
		 sqlQuery+="values('"+patid+"','a02','"+edate+"',"+slno+",'N')";
		 
		 if(res.equalsIgnoreCase("Done")){
		 	 mydb.ExecuteSql(sqlQuery);	
		 	
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",patid);
					keydtls.add("entrydate",edate);
					
					desdtls.add("table","a02");
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='a02'"));
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////			
		 
		 }
         
         sqlQuery = "Update lpatq set checked ='Y' where pat_id = '"+patid+"'";	   				
	  	 mydb.ExecuteSql(sqlQuery);	
	   	
         if(res.equalsIgnoreCase("Done")) return 1;
         else return 0;
	 }
	 
	 public String dataforDevMilestone(String category) throws RemoteException,SQLException{
	 	String strTable = "", strcat="";
        try{
         String qSql= "SELECT age," + category + " FROM dev_milesones order by serial_num";
         Object res=mydb.ExecuteQuary(qSql);
         if(res instanceof String){
				strTable= "Error : "+res;
		}else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0){
				strTable += "<table border='0' width='100%' style='background-color:#CECEFF;'";
            	if(category.equalsIgnoreCase("gross_motor")) strcat="Gross Motor";
            	else if(category.equalsIgnoreCase("visual_motor")) strcat = "Visual Motor";
            	else if(category.equalsIgnoreCase("lang")) strcat = "Language";
            	else if(category.equalsIgnoreCase("social")) strcat = "Social/Adaptive";
            	
            	strTable += "<tr style='background-color:#CBF8CB;height:15px'><th>Age</th><th>" + strcat + "</th></tr>";                  
				for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
                    
                    strTable += "<tr style='background-color:#FEFEF2;border:1px solid #880088'><td id='agecol_"+i+"'>" + temp.getValue(0) + "</td>";
                    strTable += "<td id='catcol_" + i + "' onclick=\"fillData('catcol_" + i + "','agecol_"+i+"','" + category + "')\" style='cursor:pointer; cursor:hand;'>";
				    String val = temp.getValue(1); 
                    
                    if (val.contains(",")) val = val.replace(",", ",<br>");
                    if (val.contains(";")) val = val.replace(";", ",");
                    strTable += val + "</td></tr>";
				}
				strTable += "</table>";
			}else{
				strTable += "<table border=1>";
                strTable += "<tr><td>No Data</td><tr>";
                strTable += "</table>";
			}
		  }		
		}catch (Exception e){
         	strTable= "Error :" +e.toString() ;
        }  
      return strTable; 
         
	 }
	
	public String dataforImmunization(String patid) throws RemoteException,SQLException{

			String vaccine_name, strTable="",dt="";
            String prevVacCode = "-1";
            int i = 0;

            String qr = "select a13.vaccine_id,a13.age_given,a13.site,a13.code,a13.entrydate,immun_schedule.age,immun_schedule.vaccine_code as vaccine_code,";
            qr += "(select vac_name from immunization where immunization.vac_code=immun_schedule.vaccine_code) as vName,";
            qr += "(select vac_info from immunization where immunization.vac_code=immun_schedule.vaccine_code) as info,";
            qr += "(select disease from immunization where immunization.vac_code=immun_schedule.vaccine_code) as Dis";
            qr += " from a13, immun_schedule where a13.vaccine_id=immun_schedule.vac_id and pat_id='"+ patid +"' order by vaccine_code";
        
            try{
            	Object res=mydb.ExecuteQuary(qr);
         		if(res instanceof String){
					strTable= "Error : "+res;
				}else{
					Vector tmp = (Vector)res;
					if(tmp.size()>0){
						for(int ii=0;ii<tmp.size();ii++){
						dataobj temp = (dataobj) tmp.get(ii);
						String VacCode = temp.getValue("vaccine_code"); 
						
						System.out.println(prevVacCode +"="+ VacCode);
						
						if(!VacCode.equalsIgnoreCase(prevVacCode)){
							if (!prevVacCode.equalsIgnoreCase("-1"))
                            {
                                strTable += "</table></td></tr></table><br>";
                            }
                            
                            //strTable += "<font style='font-color:#0000FF;font-size:18px;'>" + myrdr.GetValue(9) + "</font>";
                            strTable += "<table border='0' width='90%' align='center'>";
                            strTable += "<tr><td style='color:blue;font-weight:bold;font-size:12pt' style='cursor:pointer;cursor:hand;' onclick='shownhide(" + i + ", 100)')>" + temp.getValue(9) + "</td></tr>";
                            strTable += "<tr><td><table  id='tab_" + i + "' align='center' width='100%' cellspacing='1' cellpadding='3' style='visibility:hidden;display:none;background-color:#CECEFF;'>";
                            strTable += "<tr style='background-color:#CBF8CB;height:15px'><th>Vaccine</th><th>Date Given</th><th>Site</th><th>Age Given</th><th>Age Recomended</th><th>Code</th></tr>";
                         	prevVacCode = VacCode;  
                            i++;
						} // if
						
						 vaccine_name = temp.getValue(7) +" "+ temp.getValue(0).substring(temp.getValue(0).length()-1) ;// myrdr.GetValue(0).ToString().Remove (0,myrdr.GetValue(0).ToString().Length-1);
                          dt=myDate.mysql2ind(temp.getValue(4));
                            
                            strTable += "<tr align='center' style='background-color:#FEFEF2;border:1px solid #880088'>";
                            strTable += "<td>"+vaccine_name+"</td>";
                            strTable += "<td>" + dt + "</td>";
                            strTable += "<td>" + temp.getValue(2) + "</td>";
                            strTable += "<td>" + temp.getValue(1) + "</td>";
                            strTable += "<td>" + temp.getValue(5) + "</td>";
                            strTable += "<td>" + temp.getValue(3) + "</td>";
                            strTable += "</tr>";
						
						} //for
						
					}//if	
							
			  } // else
			  
            }catch (Exception e){
         		strTable= "Error :" +e.toString() ;
         	} 
         return strTable;
	}
	
	public String getVaccineRecAge(String vacc_id) throws RemoteException,SQLException{
		String qSql="Select age from immun_schedule where vac_id='"+ vacc_id + "'";		
		return mydb.ExecuteSingle(qSql);
	}
	
	public String getPatientCurrentWeight(String patid) throws RemoteException,SQLException{
		String qSql="SELECT wt from h15 WHERE pat_id='"+ patid +"' ORDER BY entrydate DESC LIMIT 1";
		String curAge=mydb.ExecuteSingle(qSql);
		if(curAge.equalsIgnoreCase("")) curAge="0";
		return curAge;
	}
	
	public String getCTXFormulation(String patid) throws RemoteException,SQLException{
	
		 String  strResult = "";
		 int drugCount = 1;
		try{
			
		 String currentweight = getPatientCurrentWeight(patid);
		 
		 if (currentweight.equalsIgnoreCase("0")){
                strResult = "<table cellpadding=\"12\"><tr><td class='formcaption' align='left'><b>Choose the Formulation</b></td>";
                strResult += "<td><select id='formulaid_" + drugCount + "' name='formulaid_" + drugCount + "'><option value=''>Select Formulation</option>";
                strResult += "<option value='' >No Data</option>";
                strResult += "</select></td></tr></table>";
         }else{
         	 String qSql="SELECT DISTINCT range_id FROM ctx_weight WHERE "+ currentweight +" BETWEEN start_param AND end_param";
             String rangeid = mydb.ExecuteSingle(qSql);
         	 
         	 qSql= "SELECT DISTINCT formulation,id FROM ctx_dose WHERE range_id="+rangeid;
         	 strResult = "<table cellpadding=\"12\"><tr><td class='formcaption' align='left'><b>Choose the Formulation</b></td>";
             strResult += "<td><select id='formulaid_" + drugCount + "' name='formulaid_" + drugCount + "'onchange='populateDrugDose(this.value);'><option value=''>Select Formulation</option>";	
         
         	
         	Object res=mydb.ExecuteQuary(qSql);
         	if(res instanceof String){
				strResult= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 for(int ii=0;ii<tmp.size();ii++){
			 		dataobj temp = (dataobj) tmp.get(ii);
					strResult += "<option value='" + temp.getValue(1) + "'>" + temp.getValue(0) + "</option>";
				}
			}
			
            strResult += "</select></td></tr></table>";
         }
       }catch (Exception e){
         		strResult= "Error :" +e.toString() ;
       } 
       return strResult;
		 
    }
    
    public String getCTXDose(String formulation_id)throws RemoteException,SQLException{
    	String strResult="";
    	int drugCount = 1;
    	if(formulation_id.equalsIgnoreCase("")) return "";
    	try{
	    	String qSql = "SELECT  dose,unit FROM ctx_dose WHERE id="+formulation_id;	
	        strResult = "<table cellpadding=\"12\"><tr><td class='formcaption' align='left'><b>Choose the Dose</b></td>";
	        strResult += "<td><select id='dose_" + drugCount + "' name='dose_" + drugCount + "'><option value=''>Select Dose</option>";
			
			Object res=mydb.ExecuteQuary(qSql);
         	if(res instanceof String){
				strResult= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 for(int ii=0;ii<tmp.size();ii++){
			 		dataobj temp = (dataobj) tmp.get(ii);
					strResult += "<option value='" + temp.getValue(0) +" "+ temp.getValue(1) + "'>" + temp.getValue(0) +" "+ temp.getValue(1) + "</option>";
				}
			}
	        strResult += "</select></td></tr></table>";
            strResult += "</table>";
            strResult += "<table cellpadding=\"12\"><tr><td align='left'><b>Dispensed</b></td><td><input id='drugdisp_"+drugCount+"' name='drugdisp_"+drugCount +"'></td></tr></table>";

	  }catch (Exception e){
         		strResult= "Error :" +e.toString() ;
      } 
		 return strResult;

    }
    
    public int putCTXDatainDB(String patid, String[][] data_Prescription,String hosname,String regno, String edate,dataobj obj) throws RemoteException,SQLException{
        
        String qSql = "select count(pat_id) from k01 where pat_id='"+patid+"'";
        String slno = mydb.ExecuteSingle(qSql);
        
        String res="",qr="";
        try{
	        for (int i = 0; i < data_Prescription.length; i++)
	          {
	          	qr="";
	          	if (data_Prescription[i][0].equals("") && data_Prescription[i][1].equals("") && data_Prescription[i][2].equals("")) continue;
	          	 
	            //System.out.println("********"+i+" >>"+data_Prescription[i][0] + ">>"+data_Prescription[i][1]);
	           	qr += "insert into k01(pat_id,formulation_id,dose,pill_disp,pill_consumed,balance,name_hos,docrg_no,entrydate,serno)";
	            qr += "values('" + patid + "','" + data_Prescription[i][0].replaceAll("'","''") + "','" + data_Prescription[i][1].replaceAll("'","''") + "','" + data_Prescription[i][2].replaceAll("'","''") + "','0','" + data_Prescription[i][2].replaceAll("'","''") + "','" +hosname +"','" +regno+"','" + edate + "','" + slno + "') ";
	           	res=mydb.ExecuteSql(qr);
	         }
         }catch (Exception e){
         		res="Error..";
         }
          
         if(res.equalsIgnoreCase("Done")){
	         String sqlQuery="insert into listofforms (pat_id,type,date,serno,sent)"; 
			 sqlQuery+="values('"+patid+"','k01','"+edate+"',"+slno+",'N')";
			 if(res.equalsIgnoreCase("Done")) mydb.ExecuteSql(sqlQuery);	
	         sqlQuery = "Update tpatq set checked ='Y' where pat_id = '"+patid+"'";	   				
		  	 mydb.ExecuteSql(sqlQuery);	
		  	 
		  	 	 	
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",patid);
					keydtls.add("entrydate",edate);
					
					desdtls.add("table","k01");
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='k01'"));
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////			

	         return 1;
         }else return 0; 	
    }
    
    
    ///add new fn
	 public String getDrugName(String patid, String drugCount, String drugType) throws RemoteException,SQLException{
	 	
	 	System.out.println(patid+">>"+drugCount+">>"+drugType);
	 	
	 	 String isInitialPeriod="",strQuery="";
	 	 String strDrugId="", strResult="",prevOptGrp="";
	 	 try{
	 	 
	 	 String currentweight = getPatientCurrentWeight(patid);
		 String qSql="SELECT DISTINCT range_id FROM param_range WHERE "+currentweight+" BETWEEN param_start AND param_end AND param_type='w'";
		 
		 int rangeid = Integer.parseInt(mydb.ExecuteSingle(qSql));
		 	 
		 if(drugType.equalsIgnoreCase("fdcleadin"))
                strQuery = "SELECT DISTINCT drug_id,list_id FROM param_drug WHERE range_id="+ rangeid +" AND initial_period='Y' ORDER BY drug_id";
         else if(drugType.equalsIgnoreCase("fdcnotleadin"))
                strQuery = "SELECT DISTINCT drug_id,list_id FROM param_drug WHERE range_id="+ rangeid +" AND initial_period='N' ORDER BY drug_id";
         else if (drugType.equalsIgnoreCase("efv"))
                strQuery = "SELECT DISTINCT drug_id,list_id FROM param_drug WHERE range_id="+ rangeid +" AND hasvalue='Y' ORDER BY drug_id";
         else
                strQuery = "SELECT DISTINCT drug_id,list_id FROM param_drug WHERE range_id="+ rangeid +" order by drug_id";
   
   		   Object res=mydb.ExecuteQuary(strQuery);
         	if(res instanceof String){
				strResult= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 for(int ii=0;ii<tmp.size();ii++){
			 		dataobj temp = (dataobj) tmp.get(ii);
			 		strDrugId+=","+temp.getValue(0);
				}
			}
			 strDrugId=strDrugId.substring(1);
			
			 if(drugType.equalsIgnoreCase("fdcleadin"))
	             strQuery = "SELECT DISTINCT drug_id,drug_name,drug_grpid FROM drug_grp WHERE drug_id IN (" + strDrugId + ") AND drug_grpid='FDC'";
	         else if(drugType.equalsIgnoreCase("fdcnotleadin"))
	             strQuery = "SELECT DISTINCT drug_id,drug_name,drug_grpid FROM drug_grp WHERE drug_id IN (" + strDrugId + ") AND drug_grpid='FDC' AND followon_regimen='Y'";
	         else if (drugType.equalsIgnoreCase("efv"))
	             strQuery = "SELECT DISTINCT drug_id,drug_name,drug_grpid FROM drug_grp WHERE drug_id IN (" + strDrugId + ") AND drug_grpid='EFV'";
	         else
	             strQuery = "SELECT DISTINCT drug_id,drug_name,drug_grpid FROM drug_grp WHERE drug_id IN (" + strDrugId + ") AND drug_grpid NOT IN ('FDC','EFV')ORDER BY drug_grpid";
	   
            strResult = "<table cellpadding=\"12\"><tr><td class='formcaption' align='left'><b>Choose the drug</b></td>";
            strResult += "<td><select id='drugid_" + drugCount + "' name='drugid_"+drugCount +"'onchange='populateDrugDose(" + drugCount + ");'><option value=''>Select drug</option>";
			
			res=mydb.ExecuteQuary(strQuery);
			
         	if(res instanceof String){
				strResult= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				prevOptGrp = "initial";
				 for(int ii=0;ii<tmp.size();ii++){
			 		dataobj temp = (dataobj) tmp.get(ii);
			 		if (!temp.getValue(0).equalsIgnoreCase(prevOptGrp) || prevOptGrp=="initial")
                    {
                        strResult = strResult + "<optgroup label='" + temp.getValue(2) + "'>";
                        prevOptGrp = temp.getValue(2);
                    }
                   strResult += "<option value='" + temp.getValue(0) + "'>"+temp.getValue(1)+"</option>"; 
				}
			}
			strResult += "</select></td></tr></table>";
            strResult += "</table>" ;
            strResult += "<div id=\"divdrugInfo_" + drugCount + "\"></div></fieldset></div>";
            strResult +="<div id=\"divdrugdose_" + drugCount + "\"></div></fieldset></div>";
            
           }catch (Exception e){
           	
         		strResult="Error.." + e.toString();
         		System.out.println( e.toString());
          }
            return strResult;
	 }
	 
	 public String getDrugDoseandOtherInfo(String patid, String drugCount, String drugid,String drugType) throws RemoteException,SQLException{
	 	
	     String strtemp = "", strResult="",actualDoses="", recomendedDose="",otherInfo="";
	     String actualDosesAm = "", actualDosesPm = "", strTotalDoses = "", strQuery="";
         String formulation="", strDispense="";

		 try{
		 	
         String currentweight = getPatientCurrentWeight(patid);
		 String qSql = "SELECT DISTINCT range_id FROM param_range WHERE "+currentweight+" BETWEEN param_start AND param_end AND param_type='w'"; 
		 String rangeid = mydb.ExecuteSingle(qSql);
         
         if(drugType.equalsIgnoreCase("fdcleadin"))
               strQuery = "SELECT DISTINCT item_no,dd.dose_id,formulation,med_amount FROM param_drug pd, dose_list dl, drug_dose dd WHERE pd.drug_id="+ drugid +" AND pd.range_id= " +rangeid+ " AND pd.initial_period='Y' AND pd.list_id=dl.list_id AND dl.dose_id=dd.dose_id AND pd.drug_id=dd.drug_id ORDER BY item_no";
         else if ( drugType.equalsIgnoreCase("fdcnotleadin"))
               strQuery = "SELECT DISTINCT item_no,dd.dose_id,formulation,med_amount FROM param_drug pd, dose_list dl, drug_dose dd WHERE pd.drug_id="+ drugid +" AND pd.range_id=" +rangeid+ " AND pd.initial_period='N' AND pd.list_id=dl.list_id AND dl.dose_id=dd.dose_id AND pd.drug_id=dd.drug_id ORDER BY item_no";
         else
               strQuery = "SELECT DISTINCT item_no,dd.dose_id,formulation,med_amount FROM param_drug pd, dose_list dl, drug_dose dd WHERE pd.drug_id="+ drugid +" AND pd.range_id=" +rangeid+ " AND pd.list_id=dl.list_id AND dl.dose_id=dd.dose_id AND pd.drug_id=dd.drug_id ORDER BY item_no";

            strTotalDoses="<table cellpadding=\"12\">";
            actualDosesAm = "<tr><td class='formcaption' align='left'><b>Choose the Dose(AM)</b></td>";
            actualDosesAm += "<td><select id='drugdoseam_" + drugCount + "' name='drugdoseam_" + drugCount + "'><option value=''>Select drug dose</option>";

            actualDosesPm = "<tr><td class='formcaption' align='left'><b>Choose the Dose(PM)</b></td>";
            actualDosesPm += "<td><select id='drugdosepm_" + drugCount + "' name='drugdosepm_" + drugCount + "'><option value=''>Select drug dose</option>";

            Object res=mydb.ExecuteQuary(strQuery);
         	 if(res instanceof String){
				actualDosesAm= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 for(int ii=0;ii<tmp.size();ii++){
			 		dataobj temp = (dataobj) tmp.get(ii);
			 		strtemp=temp.getValue(3);
			 		if (strtemp.contains("bid")){
			 			strtemp = strtemp.substring(0,strtemp.lastIndexOf("bid"));// .Remove(strtemp.LastIndexOf("bid"));
			 			if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
                        {
                            
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtemp.trim() + "'>" + strtemp + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtemp.trim() + "'>" + strtemp + "</option>";
                        }
                        else
                        {
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtemp.trim() + "'>" + temp.getValue(2) + "-" + strtemp.trim() + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtemp.trim() + "'>" + temp.getValue(2) + "-" + strtemp.trim() + "</option>";
                        }
			 		}else if (strtemp.contains(",")){
			 			
			 			 String strtempAm = strtemp.substring(0,strtemp.lastIndexOf(",")); //strtemp.Substring(0, (strtemp.LastIndexOf(",")));
                         String strtempPm = strtemp.substring(strtemp.lastIndexOf(",")+1); //strtemp.Substring(strtemp.LastIndexOf(",") + 1);

			 			if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
                        {
                            
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtempAm.trim() + "'>" + strtempAm.trim() + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtempPm.trim() + "'>" + strtempPm.trim() + "</option>";
                        }else
                        {
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtempAm.trim() + "'>" + temp.getValue(2) + "-" + strtempAm.trim() + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtempPm.trim() + "'>" + temp.getValue(2) + "-" + strtempPm.trim() + "</option>";
                        }	
			 		}else if (strtemp.contains("am")){
			 			String strtempAm = strtemp.substring(0,strtemp.lastIndexOf("am")); //strtemp.Substring(0, (strtemp.LastIndexOf("am")));
                            
			 		  	if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
                     	{   
                     		actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtempAm.trim() + "'>" + strtempAm.trim() + "</option>";
                            actualDosesPm += "<option value=''>No Evening dose</option>";
                        }else{
                            
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + strtempAm.trim() + "'>" + temp.getValue(2) + "-" + strtempAm.trim() + "</option>";
                            actualDosesPm += "<option value=''>No Evening dose</option>";
                        }
			 		}else if (strtemp.contains("pm")){
			 			String strtempPm = strtemp.substring(0,strtemp.lastIndexOf("pm")); //strtemp.Substring(0,strtemp.LastIndexOf("pm"));
			 			
			 		  	if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
                        {
                            actualDosesAm += "<option value=''>No Morning dose</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtempPm.trim() + "'>" + strtempPm.trim() + "</option>";
                        }
                        else
                        {
                            actualDosesAm += "<option value=''>No Morning dose</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + strtempPm.trim()  + "'>" + temp.getValue(2)  + "-" + strtempPm.trim() + "</option>";
                        }
			 		}else{
			 			
			 		  	if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
                        {
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" + temp.getValue(3) + "'>" + temp.getValue(3) + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + temp.getValue(3) + "'>" + temp.getValue(3) + "</option>";
                        }
                        else
                        {
                            actualDosesAm += "<option value='" + temp.getValue(2) + "#" +temp.getValue(3) + "'>" + temp.getValue(2) + "-" + temp.getValue(3) + "</option>";
                            actualDosesPm += "<option value='" + temp.getValue(2) + "#" + temp.getValue(3) + "'>" + temp.getValue(2) + "-" + temp.getValue(3) + "</option>";
                        }
			 		}
			 		
				}// for
			}
            actualDosesAm += "</select></td></tr>";
            actualDosesPm += "</select></td></tr>";
            strDispense = "<tr><td><b>Pill Dispense</b></td><td><input id='drugdisp_" + drugCount + "' name='drugdisp_" + drugCount + "'></td></tr>";      
            strTotalDoses += actualDosesAm+actualDosesPm+strDispense+"</td></tr></table>";
			if (drugType.equalsIgnoreCase("fdcleadin") || drugType.equalsIgnoreCase("fdcnotleadin") || drugType.equalsIgnoreCase("efv"))
            {
                formulation = getDrugFormulation(drugid);
                strResult = formulation;
            }
            else
            {
                formulation = getDrugFormulation(drugid);
                recomendedDose = getRecomendedDoses(drugid);
                strResult = recomendedDose+formulation;
            }
            otherInfo = getOtherInfoAboutDrug(drugid);
            strResult += strTotalDoses;
            }catch (Exception e){
         		strResult="Error.." + e.toString();
         		System.out.println( e.toString());
          	}
            return strResult;
    }
    
    public String getRecomendedDoses(String drugid) throws RemoteException,SQLException{
            String strRecoDose="";
            String qSql = "SELECT DISTINCT formulation,reco_dose FROM drug_dose WHERE drug_id="+drugid+"";
            Object res=mydb.ExecuteQuary(qSql);
            strRecoDose = "<table><tr><td><b>Recomended Dose</b></td></tr><tr><td><ul>";
         	 if(res instanceof String){
				strRecoDose= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 if(tmp.size()>0){
					 for(int ii=0;ii<tmp.size();ii++){
				 		dataobj temp = (dataobj) tmp.get(ii);
				 		strRecoDose += "<li><font color='blue' size='3' style='font-weight:bold;'>" + temp.getValue(1) + "</font></li>";
				 	 }
			 	 }else{
			 	 	strRecoDose += "<li>No Information Found</li>";
			 	 }
			 }
			strRecoDose += "</ul></td></tr></table>";
            return strRecoDose;
   }
   
   public String getDrugFormulation(String drugid) throws RemoteException,SQLException{
   	      String strRecoDose = "";
          String qSql = "SELECT DISTINCT formulation FROM drug_dose WHERE drug_id="+drugid+"";
          
          Object res=mydb.ExecuteQuary(qSql);
          strRecoDose = "<table><tr><td><b>Formulation</b></td></tr><tr><td><ul>";
         	 if(res instanceof String){
				strRecoDose= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 if(tmp.size()>0){
					 for(int ii=0;ii<tmp.size();ii++){
				 		dataobj temp = (dataobj) tmp.get(ii);
				 		strRecoDose += "<li><font color='blue' size='3' style='font-weight:bold;'>" + temp.getValue(0) + "</font></li>";
				 	 }
			 	 }else{
			 	 	strRecoDose += "<li>No Information Found</li>";
			 	 }
			 }
            strRecoDose += "</ul></td></tr></table>";
            return strRecoDose;
        }
        
        public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException{
           	String strDrugInfo = "";
			String qSql = "SELECT DISTINCT drug_notice FROM drug_grp WHERE drug_id="+drugid+"";
            
            Object res=mydb.ExecuteQuary(qSql);
          	strDrugInfo = "<table><tr><td><b>Other Information</b></td></tr>";
         	 if(res instanceof String){
				strDrugInfo= "Error : "+res;
			}else{
				Vector tmp = (Vector)res;
				 if(tmp.size()>0){
					 for(int ii=0;ii<tmp.size();ii++){
				 		dataobj temp = (dataobj) tmp.get(ii);
				 		strDrugInfo += "<tr><td><font size='3' color='maroon'>"+temp.getValue(0)+"</font></td></tr>";
				 		 
				 	 }
			 	 }else{
			 	 	strDrugInfo += "<tr><td>No Information Found</td></tr>";
			 	 }
			 }
            strDrugInfo += "</table>";
           return strDrugInfo;
    }
        
    public int putPHIVPrescriptiondatainDB(String patid, String[][] data_Prescription,String hosname,String regno,String edate,dataobj obj) throws RemoteException,SQLException{
      	
            String qr = "";
            String res="";
            
            String formulationam="", formulationpm="", doseam="", dosepm="";
            String pillDispensed;
            try{
            	String qSql = "select (max(serno)+1) as slno from k02 where pat_id='"+patid+"'";
        		String slno = mydb.ExecuteSingle(qSql);
        		if(slno==null) slno="0";
				qr="";
			
	        for (int i = 0; i < data_Prescription.length; i++){
	          
	          	
	            if (data_Prescription[i][0].equals("") && data_Prescription[i][1].equals("") && data_Prescription[i][2].equals("")) continue;
	            
	            System.out.println("** *** >>"+i+" >>"+data_Prescription[i][0] + ">>"+data_Prescription[i][1]+ ">>"+data_Prescription[i][2]);
	            
	            
	            if (data_Prescription[i][1].contains("#"))
                {
                	//System.out.println("Indexof AM:"+data_Prescription[i][1].indexOf("#"));
                	
                    formulationam = data_Prescription[i][1].substring(0, data_Prescription[i][1].indexOf("#"));
                    
                    //System.out.println("formulationam:"+formulationam);
                    
                    doseam = data_Prescription[i][1].substring(data_Prescription[i][1].indexOf("#") + 1);
					//System.out.println("doseam:"+doseam);
                }
                else
                {
                    formulationam = "";
                    doseam = "";
                }
                
             if (data_Prescription[i][2].contains("#"))
                {
                	//System.out.println("Indexof PM:"+data_Prescription[i][2].indexOf("#"));
                	
                    formulationpm = data_Prescription[i][2].substring(0, data_Prescription[i][2].indexOf("#"));
                    //System.out.println("formulationpm:"+formulationpm);
                    dosepm = data_Prescription[i][2].substring(data_Prescription[i][2].indexOf("#") + 1);
               		//System.out.println("dosepm:"+dosepm);
                }
                else
                {
                    formulationpm = "";
                    dosepm = "";
                }
                    
               	qr += "#IMX# Insert into k02(pat_id,drug_id,formulation_am,formulation_pm,dose_am,dose_pm,pill_disp,pill_consumed,balance,name_hos,docrg_no,entrydate,serno) ";
                qr += "values('" + patid + "','" + data_Prescription[i][0].replaceAll("'","''") + "','" + formulationam.replaceAll("'","''") + "','" + formulationpm.replaceAll("'","''") + "','" + doseam.replaceAll("'","''") + "','" + dosepm.replaceAll("'","''") + "','" + data_Prescription[i][3].replaceAll("'","''") + "','0','" + data_Prescription[i][3].replaceAll("'","''") + "','" +hosname +"','" +regno+"','" + edate + "','" + slno + "') ";
                //qr += "#IMX# insert into listofforms (pat_id,type,date,serno,sent) values('" + patid + "', 'k02', '" + edate + "','" + slno + "', 'N')";
	       }
	       
	       qr += "#IMX# insert into listofforms (pat_id,type,date,serno,sent) values('" + patid + "', 'k02', '" + edate + "','" + slno + "', 'N') ";
	       qr += "#IMX# Update lpatq set checked ='Y' where pat_id = '"+patid+"' ";	 
	       qr += "#IMX# Update tpatq set checked ='Y' where pat_id = '"+patid+"' ";	 
	       
	       if(!qr.equals("")) qr=qr.substring(6);
	       
	       //System.out.println("\r\n"+qr+"\r\n");
	       
	       res = mydb.ExecuteTrans(qr);
	      
          }catch (Exception e){
         		res="Error..";
         		System.out.println(e.toString());
          }
           if(res.equalsIgnoreCase("Done")){
           	
           	
           		  	 	 	
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",patid);
					keydtls.add("entrydate",edate);
					
					desdtls.add("table","k02");
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='k02'"));
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////			


           	 return 1;
           	 
           }else return 0;
           	
          
        }
        
      
}
	   