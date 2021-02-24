package tuberculosis;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Vector;
import java.util.StringTokenizer;
import imedix.*;
import logger.*;

public class tbOperations extends UnicastRemoteObject implements tbOperationsInterface {
		
	projinfo pinfo;
	dball mydb;
	
	public tbOperations(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	 public Object getDrugName() throws RemoteException,SQLException{
	  	String qSql="SELECT DISTINCT drug_id,drug_name,drug_grpid FROM drugname_tb";
	 	System.out.println(qSql);
	 	return mydb.ExecuteQuary(qSql); 
	 	 
	 }
	 
	public String getRecomendedDoses(String drugid, String drugcount) throws RemoteException,SQLException{

            String strRecoDosewithFormularion = "", strdosage="",tempstr="",strResult="";
            int startParam, endParam;
            String qSql="SELECT DISTINCT formulation,rec_dose,recdose_unit FROM drugdose_tb WHERE drug_id="+drugid+"";
            
            strdosage = "<table><tr><td align='left'><b>Choose the Dosage</b></td>";
            strdosage += "<td><select id='drugdosage_" + drugcount + "' name='drugdosage_" + drugcount + "' onchange=getTotalDosage(" + drugcount + ");><option value=''>Select dosage</option>";
            strRecoDosewithFormularion = "<table><tr><td><b>Recomended Dose</b></td></tr><tr><td><ul>";
                        
            try{
            	Object res=mydb.ExecuteQuary(qSql);
         		if(res instanceof String){
					strdosage= "Error : "+res;
				}else{
					Vector tmp = (Vector)res;
					if(tmp.size()>0){
						for(int ii=0;ii<tmp.size();ii++){
						dataobj temp = (dataobj) tmp.get(ii);
						
						strRecoDosewithFormularion += "<li><font color='blue' size='3' style='font-weight:bold;'>" + temp.getValue(1) + temp.getValue(2) + "</font></li>";
		                    
		                    tempstr=temp.getValue(1);
		                    
		                    if (tempstr.contains("-"))
		                    {
		                        String prmVals[]=tempstr.split("-");
		                        startParam= Integer.parseInt(prmVals[0]);
		                        endParam= Integer.parseInt(prmVals[1]);
		                       
		                        for (int i = startParam; i <= endParam; i++)
		                        {
		                            strdosage += "<option value='" + i + "'>" + i + temp.getValue(2) + "</option>";
		                        }
		                    }
		                    else
		                    {
		                        startParam = Integer.parseInt(tempstr.trim());
		                        strdosage += "<option value='" + startParam + "'>" + startParam + temp.getValue(2) + "</option>";
		                    }
		                    
														
						} //for
					}else{
						
						strRecoDosewithFormularion += "<li>No Information Found</li>";
                		strdosage += "<option value=''>No data</option>";
					}
							
			  } // else error
			  
            }catch (Exception e){
         		strdosage= "Error :" +e.toString() ;
         	}
         	strdosage += "</select></td></tr></table>";
            strRecoDosewithFormularion += "</ul></td></tr></table>";
            strResult = strRecoDosewithFormularion + strdosage+"<div id=\"finaldosage_"+drugcount+"\"></div>";
     
     return strResult;
	}
	
	public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException{
		   String strDrugInfo = "";

           String qSql = "SELECT DISTINCT drug_notice FROM drug_grp WHERE drug_id="+drugid+"";
           strDrugInfo = "<table><tr><td><b>Other Information</b></td></tr>";

			try{
            	Object res=mydb.ExecuteQuary(qSql);
         		if(res instanceof String){
					strDrugInfo= "Error : "+res;
				}else{
					Vector tmp = (Vector)res;
					if(tmp.size()>0){
						for(int ii=0;ii<tmp.size();ii++){
							dataobj temp = (dataobj) tmp.get(ii);
							strDrugInfo += "<tr><td><font size='3' color='maroon'>" + temp.getValue(0) + "</font></td></tr>";
						} //for
						if (strDrugInfo.equals("")){
                    		strDrugInfo += "<tr><td>No Information Found</td></tr>";
                		}
					}else{
						strDrugInfo += "<tr><td>No Information Found</td></tr>";	
					}
							
			  } // else error
			  
            }catch (Exception e){
         		strDrugInfo= "Error :" +e.toString() ;
         	}
            strDrugInfo += "</table>";
            return strDrugInfo;
	}
	
	
	public String getFormulation(String drugid,String drugcount) throws RemoteException,SQLException {
           String strformula = "", strdose = "", stroption="";
           
           String qSql= "SELECT DISTINCT formulation FROM drugdose_tb WHERE drug_id="+drugid+"";
            
           strformula = "<br><table><tr><td class='formcaption' align='left'><b>Choose the Formulation</b></td>";
           strformula += "<td><select id='drugformulation_" + drugcount + "' name='drugformulation_" + drugcount + "'><option value=''>Select Fomulation</option>";
           
           try{
            	Object res=mydb.ExecuteQuary(qSql);
         		if(res instanceof String){
					strformula= "Error : "+res;
				}else{
					Vector tmp = (Vector)res;
					if(tmp.size()>0){
						for(int ii=0;ii<tmp.size();ii++){
							dataobj temp = (dataobj) tmp.get(ii);
								strformula += "<option value='" + temp.getValue(0) + "'>" + temp.getValue(0) + "</option>";
						} //for
					}else{
						strformula += "<option value=''>No data</option>";
					}
							
			  } // else error
			  
            }catch (Exception e){
         		strformula= "Error :" +e.toString() ;
         	}
         	
            strformula += "</select></td></tr></table><br>";
            for (double i = 1; i <= 10; i+=0.5) stroption += "<option value='"+i+"'>"+i+"</option>";

            strdose = "<table><tr><td><b>Choose the Dose<b></td>";
           
            strdose += "<td><select id='drugdose_" + drugcount + "' name='drugdose_" + drugcount + "'><option value=''>Select Dose</option>";
            strdose += stroption + "</select></td></tr></table>";
            strdose += "<br><table><tr><td><b>Dispensed</b></td><td><input id='drugdisp_" + drugcount + "' name='drugdisp_" + drugcount + "'></td></tr></table>";
           return (strformula + strdose);
        }
        
   public String getPatientCurrentWeight(String patid, String distype) throws RemoteException,SQLException{
		String qSql="";
		 if (distype.equalsIgnoreCase("Pediatric HIV"))
              qSql="SELECT wt from h15 WHERE pat_id='"+ patid +"' ORDER BY entrydate DESC LIMIT 1";
            else
                qSql="SELECT wt from p00 WHERE pat_id='"+ patid +"' ORDER BY entrydate DESC LIMIT 1";
                
		String curAge=mydb.ExecuteSingle(qSql);
		if(curAge.equalsIgnoreCase("")) curAge="0";
		return curAge;
	}

	public int putTBPrescriptiondatainDB(String patid, String[][] data_Prescription,String hosname,String regno, String edate,dataobj obj) throws RemoteException,SQLException{
		
		String qSql = "select (max(serno)+1) as slno from k00 where pat_id='"+patid+"'";
        String slno = mydb.ExecuteSingle(qSql);
        if(slno==null) slno="0";
        
        String res="",qr="";
        try{
        	qr="";
	        for (int i = 0; i < data_Prescription.length; i++)
	          {
	          	if (data_Prescription[i][0].equals("") && data_Prescription[i][1].equals("") && data_Prescription[i][2].equals("")) continue;
	          	
	           // System.out.println("********"+i+" >>"+data_Prescription[i][0] + ">>"+data_Prescription[i][1]);
				qr += "#IMX# insert into k00(pat_id,drug_id,formulation,dose,pill_disp,pill_consumed,balance,name_hos,docrg_no,entrydate,serno)";
	 			qr += "values('" + patid + "','" +  data_Prescription[i][0].replaceAll("'","''") + "','" +  data_Prescription[i][1].replaceAll("'","''") + "','" +  data_Prescription[i][2].replaceAll("'","''") + "','" +  data_Prescription[i][3].replaceAll("'","''") + "','0','" +  data_Prescription[i][3].replaceAll("'","''") + "','" + hosname +"','" +regno+"','" + edate + "','" + slno + "') ";
	         }
	         
	       qr += "#IMX# insert into listofforms (pat_id,type,date,serno,sent) values('" + patid + "', 'k00', '" + edate + "','" + slno + "', 'N') ";
	       qr += "#IMX# Update lpatq set checked ='Y' where pat_id = '"+patid+"' ";	 
	       qr += "#IMX# Update tpatq set checked ='Y' where pat_id = '"+patid+"' ";	 
	       if(!qr.equals("")) qr=qr.substring(6);
	       //System.out.println("\r\n"+qr+"\r\n");
	       res = mydb.ExecuteTrans(qr);
	       

          }catch (Exception e){
         		res="Error..";
          }

           if(res.equalsIgnoreCase("Done")){
           	
           	////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("patid",patid);
					keydtls.add("entrydate",edate);
					
					desdtls.add("table","k00");
					desdtls.add("details",mydb.ExecuteSingle("SELECT description FROM forms where name='k00'"));
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),1,keydtls,desdtls);
					
		/////////////////////////////////////////////// log ////////////////////////////////////////////			

           	 return 1;
           }else return 0;
         
	}



	
}