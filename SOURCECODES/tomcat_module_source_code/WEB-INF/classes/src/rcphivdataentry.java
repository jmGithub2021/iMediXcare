package phiv;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import imedix.*;

public class rcphivdataentry{
	
	private static phivdataentryinterface phivdesrv=null;
	private Registry registry;
	projinfo proj;
	
	public rcphivdataentry(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   phivdesrv= (phivdataentryinterface)(registry.lookup("PhivDataEntry"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
     public String dataforGenotype(String mutationtype,String nm)throws RemoteException,SQLException{
     	String output="";
     	int c=0;
     	Object res=phivdesrv.dataforGenotype(mutationtype);	
     	if(res instanceof String){
			output="<td>No Data Available</td>";
			}else{
     			Vector tmp = (Vector)res;
     		//	output+="<input id='"+nm+"' name='"+nm+"' type='checkbox' style='position:absolute;display:none;' value='' checked>";
     			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				output+="<td width='25%'><input id='"+nm+"' name='"+nm+"' type='checkbox' value='"+temp.getValue(0).trim()+"'>"+temp.getValue(0).trim()+"</td>";
				c++;
				if(c==4){
					c=0;
					output+="</TR><TR>";
				}
				}
		}
	//	System.out.println("OutPUT>>>>>>>>>>"+output);
	
		return output;
     }
     
     public String dataforpillcount(String patid) throws RemoteException,SQLException{
     		String output="",dataHiddenField="",formula="";
     		
     		Object res=phivdesrv.dataforpillcount(patid);
     		if(res instanceof String){
     			output="<H3>No Pill is available</H3><br>+Error:"+res;
     		}else{
     			Vector tmp = (Vector)res;
     			//System.out.println("tmp.size() :"+tmp.size());
     			if(tmp.size()>0){
     				output+="<form name='frmPillCount' action='submitpillcount.jsp' method='post'>\n";
     				output+="<input type=hidden id='frmnam' name='frmnam' value=s36>\n";
     				output+="<table align=center width=80%><tr><td>\n";
     				for(int i=0;i<tmp.size();i++){
     					
     					dataobj tempdata = (dataobj) tmp.get(i);
     					
     					if(tempdata.getValue(2).equalsIgnoreCase("") || tempdata.getValue(2)!=null)
     						formula = tempdata.getValue(2); 
     					else 
     						 formula = tempdata.getValue(3); 
               
                
                																																																																			
                
                output += ("<table align=center ><tr><td><h3><font weight=bold family=Arial color=Green>Pill Count</h3></td></tr></table>");
                output += ("<table align=center valign=top><tr><td valign=top><font weight=bold size=4 family=verdana color=#6633FF>Drug Name</td><td><B>" +tempdata.getValue(1) + " (" + formula + ")</B></td></tr></table>");

                output += ("<table align=center valign=top><tr><td valign=top><font weight=bold size=4 family=verdana color=#6633FF>Pills Dispensed</td><td><input name=disp_" + tempdata.getValue(0) + " size=8 maxlength=8 value=\"" + tempdata.getValue(6) + "\" onblur='if (checkint(document.frmPillCount.disp_" + tempdata.getValue(0) + ".value) == false){setTimeout(\"document.frmPillCount.disp_" + tempdata.getValue(0) + ".select();\",1); }'></input></td>");
                
                //output += ("<td valign=top><font weight=bold size=4 family=verdana color=#6633FF>Pills Consumed</td><td><input name=cons_" + tempdata.getValue(0) + " size=8 maxlength=8 value=\"" + tempdata.getValue(8) + "\" onblur= \"document.frmPillCount.adh_rate_" + tempdata.getValue(0) + ".value=parseFloat(this.value/document.frmPillCount.disp_" + tempdata.getValue(0) + ".value*100)\" ></input></td></tr>");
                
                output += ("<td valign=top><font weight=bold size=4 family=verdana color=#6633FF>Pills Consumed</td><td><input name=cons_" + tempdata.getValue(0) + " size=8 maxlength=8 value=\"" + tempdata.getValue(8) + "\" onblur= \"if (checkint(document.frmPillCount.cons_" + tempdata.getValue(0) + ".value) == false){  setTimeout('document.frmPillCount.cons_" + tempdata.getValue(0) + ".select();',1); }else cal_adhrate(document.frmPillCount.adh_rate_" + tempdata.getValue(0) + ",document.frmPillCount.disp_" + tempdata.getValue(0) + ",this);\" ></input></td></tr>");
                
                output += ("<tr><td valign=top><font weight=bold size=4 family=verdana color=#6633FF>Adherence Rate</td><td><input name=adh_rate_" + tempdata.getValue(0) + " size=8 value=\"" + tempdata.getValue(9) + "\" readonly ></td></tr></table><br>");
                
                dataHiddenField += ","+tempdata.getValue(0);
                
     			}
     				
     			 dataHiddenField=dataHiddenField.substring(1);
     			 output+= "</td></tr><tr><td><input type=hidden name=row_id value=" + dataHiddenField + "></input></td></tr></table>";
     			 output+= ("<table align=center><tr><td><input type=Submit value=Submit ID=but_Submit/></tr></td></table>");
           		 output+= ("</td></tr></table>");
           		      				
     			}else{
     				output="<H3>No Pill is available</H3><br>";	
     				output+= ("</td></tr></table>");
     			}
     			 
     		}
     	return output;
     }
     
      private double Round(Double Rval, int Rpl) {
		  Double p = (Double)Math.pow(10,Rpl);
		  Rval = Rval * p;
		  float tmp = Math.round(Rval);
		  return (double)(tmp/p);
    }
    
     
     public int updatePillCount(String[][] arr,String patid,dataobj obj) throws RemoteException,SQLException{
     	return phivdesrv.updatePillCount(arr,patid,obj);	
       
     }
	 
	 public Object getDrugName(int agemonth) throws RemoteException,SQLException{
	 	return phivdesrv.getDrugName(agemonth);	
	 }
	 public Object getFormulation(int drugID ) throws RemoteException,SQLException{
	 	return phivdesrv.getFormulation(drugID);	
	 }
	 public Object getDrugDose(int armvpackageid) throws RemoteException,SQLException{
	 	return phivdesrv.getDrugDose(armvpackageid);	
	 }
	 public String getDrugInfo(int drugID) throws RemoteException,SQLException{
	 	return phivdesrv.getDrugInfo(drugID);	
	 }
	
	 public String getDrugList(String id) throws RemoteException,SQLException{
	 	return phivdesrv.getDrugList(id);	
	 }
	 public String getFormulationList(String patid, String drugid, String id) throws RemoteException,SQLException{
	 	return phivdesrv.getFormulationList(patid,drugid,id);	
	 }
	
	 public int putPrescriptionDatainDB(String patid, String[][] data_Prescription,String ctx,String ctxdose,String duration, String edate,dataobj obj) throws RemoteException,SQLException{
	  	return phivdesrv.putPrescriptionDatainDB(patid,data_Prescription,ctx,ctxdose,duration,edate,obj);
	 } 
	 
     public String dataforDevMilestone(String category) throws RemoteException,SQLException{
     	return phivdesrv.dataforDevMilestone(category);
     }
 	 	 	
 	public String getPatientCurrentWeight(String patid) throws RemoteException,SQLException{
 		return phivdesrv.getPatientCurrentWeight(patid);
 	}
    public String getCTXFormulation(String patid) throws RemoteException,SQLException{
    	return phivdesrv.getCTXFormulation(patid);
    }
    public String getCTXDose(String formulation_id)throws RemoteException,SQLException{
    	return phivdesrv.getCTXDose(formulation_id);
    }
    
    public int putCTXDatainDB(String patid, String[][] data_Prescription ,String hosname,String regno , String edate,dataobj obj) throws RemoteException,SQLException{
    	return phivdesrv.putCTXDatainDB(patid,data_Prescription,hosname,regno,edate,obj);
    }
    
    public String getDrugName(String patid, String drugCount, String drugType) throws RemoteException,SQLException{
    	return phivdesrv.getDrugName(patid,drugCount,drugType);
    }
     public String getDrugDoseandOtherInfo(String patid, String drugCount, String drugid,String drugType) throws RemoteException,SQLException{
     	return phivdesrv.getDrugDoseandOtherInfo(patid,drugCount,drugid,drugType);
     }
     public String getRecomendedDoses(String drugid) throws RemoteException,SQLException{
     	return phivdesrv.getRecomendedDoses(drugid);
     }
     public String getDrugFormulation(String drugid) throws RemoteException,SQLException{
     	return phivdesrv.getDrugFormulation(drugid);
     }
     public String getOtherInfoAboutDrug(String drugid) throws RemoteException,SQLException{
     	return phivdesrv.getOtherInfoAboutDrug(drugid);
     }
     
	  public int putPHIVPrescriptiondatainDB(String patid, String[][] data_Prescription,String hosname,String regno,String edate,dataobj obj) throws RemoteException,SQLException{
	  	return phivdesrv.putPHIVPrescriptiondatainDB(patid,data_Prescription,hosname,regno,edate,obj);
	  }
    
	}