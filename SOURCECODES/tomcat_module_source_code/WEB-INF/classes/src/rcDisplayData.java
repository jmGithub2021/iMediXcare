package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.util.ArrayList;

public class rcDisplayData{
	private static DisplayDataInterface ddserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcDisplayData(String p){
	   try{
   	   // value will be read from file;
   	   
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   ddserver= (DisplayDataInterface)(registry.lookup("DisplayData"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public Object DisplayMed(String id,String dt,String slno) throws RemoteException,SQLException{
		 System.out.println(" Call DisplayMed");
		 Object res = ddserver.DisplayMed(id,dt,slno);
 	     return res;
	}
	
	public Object DisplayFrm(String tnam,String id,String dt,String slno) throws RemoteException,SQLException{
		 System.out.println(" Call DisplayFrm");
		 Object res = ddserver.DisplayFrm(tnam,id,dt,slno);
 	     return res;
	}
	
	public Object getAttachmentAndOtherFrm(String id,String ftype,String slno,String dt) throws RemoteException,SQLException{
		 System.out.println(" Call DisplayFrm");
		 Object res = ddserver.getAttachmentAndOtherFrm(id,ftype,slno,dt);
 	     return res;
	}

	public Object getSelfRelationPatList(String ccode) throws RemoteException, SQLException{
		Object res = ddserver.getSelfRelationPatList(ccode);
		return res; 
	}
	
	public Object getFamilyMembers(String primarypatid) throws RemoteException, SQLException{
		Object res = ddserver.getFamilyMembers(primarypatid);
		return res;
	}

	public Object DisplayFrmLayers(String tnam,String id,String dt,String slno)throws RemoteException,SQLException{
		return ddserver.DisplayFrmLayers(tnam,id,dt,slno);
	}
          
    public Object getChildAndOtherFrm(String id,String ftype,String slno) throws RemoteException,SQLException{
    	System.out.println(" Call getChildAndOtherFrm");
    	return ddserver.getChildAndOtherFrm(id,ftype,slno);
    }
     
    public Object getImgdetailsOtherimgMarkimg(String mtype,String id,String type,String dt,String isl,String msl,String rcode) throws RemoteException,SQLException{
    	System.out.println(" Call getImgdetailsOtherimgMarkimg");
    	return ddserver.getImgdetailsOtherimgMarkimg(mtype,id,type,dt,isl,msl,rcode);
    }
	
	
	public Object showLists(String paid)throws RemoteException,SQLException{
		return ddserver.showLists(paid);
	}
	public Object showAllLists(String paid)throws RemoteException,SQLException{
		return ddserver.showAllLists(paid);
	}
      
    public Object viewSummary(String paid)throws RemoteException,SQLException{
    	return ddserver.viewSummary(paid);
    }
    
    public Object viewSummary(String paid,String ccode)throws RemoteException,SQLException{
		return ddserver.viewSummary(paid,ccode);
	}
    
	public byte[] GetImage(String paid,String edate,String type,String slno)throws RemoteException,SQLException{
    	return ddserver.getImage(paid,edate,type,slno);
    }
    public byte[] GetBackupImage(String paid,String edate,String type,String slno)throws RemoteException,SQLException{
    	return ddserver.getBackupImage(paid,edate,type,slno);
    }
       
    public String GetImageCon_type(String paid,String edate,String type,String slno)throws RemoteException,SQLException{
    	//System.out.println(" Called GetImageCon_type ");
    	return ddserver.getImageCon_type(paid,edate,type,slno);
    }
    
    public byte[] getRImage(String paid,String edate,String type,String slno,String islno,String rcode)throws RemoteException,SQLException {
        	System.out.println(" Called getRImage ");
        	return ddserver.getRImage(paid,edate,type,slno,islno,rcode);
        }
        
    public String getRImageCon_type(String paid,String edate,String type,String slno,String islno,String rcode)throws RemoteException,SQLException {
        	return ddserver.getRImageCon_type(paid,edate,type,slno,islno,rcode);
        }
        
     public byte[] getDocument(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException {
        	return ddserver.getDocument(paid,edate,type,slno);
        }
     
     public Object getDocumentdetailsOthers(String paid,String edate,String type,String slno) throws RemoteException,SQLException{
     	return ddserver.getDocumentdetailsOthers(paid,edate,type,slno);
     }
     
     public String getDocumentExt(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException {
        	return ddserver.getDocumentExt(paid,edate,type,slno);
     }
        
     public byte[] getMovie(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException {
        	return ddserver.getMovie(paid,edate,type,slno);
     }
     
     public Object getMoviedetailsOthers(String paid,String edate,String type,String slno) throws RemoteException,SQLException{
     		return ddserver.getMovieExt(paid,edate,type,slno);
     }
     
     public String getMovieExt(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException {
        	return ddserver.getMovieExt(paid,edate,type,slno);
     }
      
     public String getMovieCon_type(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException {
        	return ddserver.getMovieCon_type(paid,edate,type,slno);
     }
        
     public Object getDataTeleRequest(String ccode,String pid)throws RemoteException,SQLException {
          return ddserver.getDataTeleRequest(ccode,pid);	
     }
     
     public Object getComplaintSummary(String id, int no ) throws RemoteException,SQLException{
     	 return ddserver.getComplaintSummary(id,no);
     }
     
     public String getVisitSummaryPHIV(String id, String year, int no) throws RemoteException,SQLException{
	     return ddserver.getVisitSummaryPHIV(id,year,no);
     }
     
     public String getVisitSummaryGEN(String id, String year, int no) throws RemoteException,SQLException{
	     return ddserver.getVisitSummaryGEN(id,year,no);
     }
     
     public Object getYearVisitSummary(String id) throws RemoteException,SQLException {
     	return ddserver.getYearVisitSummary(id);
     }
    public String getObservation(String id, String date)throws RemoteException,SQLException{
    	return ddserver.getObservation(id,date);
    }
    
    public String getPrescription(String id, String date,String slno) throws RemoteException,SQLException{
    		return ddserver.getPrescription(id,date,slno);
    }
    
    public String getAntiretroviralPrescription(String id,String edate,String slno) throws RemoteException,SQLException{
    	 return ddserver.getAntiretroviralPrescription(id,edate,slno);
    }
    
    public String getGenPrescriptionforMedication(String id,String date,String slno) throws RemoteException,SQLException{
    		return ddserver.getGenPrescriptionforMedication(id,date,slno);
    }
    
   	public String getCTXSummary(String id, int no,String edate,String slno)throws RemoteException,SQLException{
   		return ddserver.getCTXSummary(id,no,edate,slno);
   	
   	}
	public String getAntiTuberculosisSummary(String id, int no,String edate,String slno)throws RemoteException,SQLException{
		return ddserver.getAntiTuberculosisSummary(id,no,edate,slno);
	}

    public String getRecord(String id, String date) throws RemoteException,SQLException{
    	return ddserver.getRecord(id,date);
    }
    
    public String getImpression(String id) throws RemoteException,SQLException{
    	return ddserver.getImpression(id);
    }
    
    public String getImmuzinationData(String id) throws RemoteException,SQLException{
    	return ddserver.getImmuzinationData(id);
    }
    
    public String getPhenotypeRecord(String id) throws RemoteException,SQLException{
    	return ddserver.getPhenotypeRecord(id);
    }
    public String getCBCSummary(String patid, int no) throws RemoteException,SQLException{
    	return ddserver.getCBCSummary(patid,no);
    }
	public String getOtherCBCSummary(String patid, String[][] fields, int no) throws RemoteException,SQLException{
		return ddserver.getOtherCBCSummary(patid,fields,no);
	}
	public String getProbSummary(String patid, int no) throws RemoteException,SQLException{
		return ddserver.getProbSummary(patid,no);
	}
	public String getAntiRetroViralSummary(String patid, int no) throws RemoteException,SQLException{
		return ddserver.getAntiRetroViralSummary(patid,no);
	}
	public String getDrugAllergySummary(String patid) throws RemoteException,SQLException{
		return ddserver.getDrugAllergySummary(patid);
	}
	public String getVaccinationSummary(String patid) throws RemoteException,SQLException{
		return ddserver.getVaccinationSummary(patid);	
	}
	 public String getComplaintSummaryInString(String id, int no ) {
     String output="";
     	
     	 output += "<table width='100%' border='0' align='center' cellspacing='1' cellpadding='3' style='border:1px solid #00AA00'>";
         output += "<tr style='background-color:#D7FFD7'><th>Date</th><th>Chief Complaint</th><th>Duration</th></tr>";

     	try{
		Object res=ddserver.getComplaintSummary(id,no);
		if(res instanceof String) output+=res;
		else{
			Vector Vtmp = (Vector)res;
			if(Vtmp.size()>0){
				for(int j=0;j<Vtmp.size();j++){
					dataobj datatemp = (dataobj) Vtmp.get(j);
					String pdt = datatemp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					for (int i = 0; i < 3; i++){
						String tempcomp=datatemp.getValue(i * 3);
						if(tempcomp.equals("")) continue;
						String tempdur = datatemp.getValue(i*3 + 1)+ " "+datatemp.getValue(i*3 + 2);
						output+="<tr style='background-color:#FEFEF2;border:1px solid #880088'>";
						output+="<td align='center' nowrap>"+ dt +"</td>";
						output+="<td align='left'>" + tempcomp + "</td>";
						output+="<td align='left'>" + tempdur + "</td>";
						output+="</tr>";

					}	
				}

			}else{
				output+="<tr style='background-color:#FFFFFF'><td align='center' colspan='3'>No Complaint Recorded</td></tr>";
			}
		}
	}catch(Exception e){
		output+="Exception : "+e;
	}
	 output += "</table>";
	 
	return output;
     }
    
	public String getDiaognosisSummary(String patid) throws RemoteException,SQLException{
			return ddserver.getDiaognosisSummary(patid);	
	}
	public String getOncoStageSummary(String patid) throws RemoteException,SQLException{
			return ddserver.getOncoStageSummary(patid);	
	}
	
	public dataobj getPatientInfo(String patid) throws RemoteException,SQLException{
		return ddserver.getPatientInfo(patid);
	}
	public String getPercentile(String tabname, int month, String val) throws RemoteException,SQLException{
		return ddserver.getPercentile(tabname,month,val);
	}
	public dataobj getPercentile(String tabname, int month) throws RemoteException,SQLException{
		return ddserver.getPercentile(tabname,month);
	}
	
	public String getPastHistoryRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getPastHistoryRecord(patid);
	}
	
	public String getTuberculosisHistoryRecord(String patid)throws RemoteException,SQLException{
		return ddserver.getTuberculosisHistoryRecord(patid);	
	}
	
	public String getBirthHistoryRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getBirthHistoryRecord(patid);
	}
	
	public String getSocioEcoStatusRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getSocioEcoStatusRecord(patid);
	}
	
	public String getSupportSystemRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getSupportSystemRecord(patid);
	}
	public String getARTRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getARTRecord(patid);
	}
	public String getHIVExposedRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getHIVExposedRecord(patid);
	}
	public String getAdherenceRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getAdherenceRecord(patid);
	}
	public String getSocialHistoryRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getSocialHistoryRecord(patid);
	}
	
	public String getDevelopmentMilestonesRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getDevelopmentMilestonesRecord(patid);
	} 
	public String getPlanRecord(String patid) throws RemoteException,SQLException{
		return ddserver.getPlanRecord(patid);
	} 
          
    public String getImageDesc(String typ){
    	String imgDesc="";
    	if(typ.equalsIgnoreCase("BLD")) imgDesc="Blood Slide";
    	else if(typ.equalsIgnoreCase("CTS")) imgDesc="CT Scan";
    	else if(typ.equalsIgnoreCase("DCM")) imgDesc="Dicom Files";
    	else if(typ.equalsIgnoreCase("EEG")) imgDesc="EEG Files ";
    	else if(typ.equalsIgnoreCase("MRI")) imgDesc="MRI Files ";
    	else if(typ.equalsIgnoreCase("SEG")) imgDesc="Scanned ECG";
    	else if(typ.equalsIgnoreCase("SKP")) imgDesc="Scanned Skin Patch";
    	else if(typ.equalsIgnoreCase("SNG")) imgDesc="Sonograms";
    	else if(typ.equalsIgnoreCase("XRA")) imgDesc="X-Ray";
    	else if(typ.equalsIgnoreCase("OTH")) imgDesc="Others";
    	else if(typ.equalsIgnoreCase("DOC")) imgDesc="Documents";
    	else if(typ.equalsIgnoreCase("SND")) imgDesc="Sound Files";
    	else if(typ.equalsIgnoreCase("TEG")) imgDesc= "Text ECG";
    	else if(typ.equalsIgnoreCase("MOV")) imgDesc= "Movie Files";
    	else  imgDesc="Unknown";    
    	                             
    	return imgDesc;                   
    }
    public String getDataJSON(String pat_id,String tableName,String date,String nextDate) throws RemoteException,SQLException{
		return ddserver.getDataJSON(pat_id,tableName,date,nextDate);
	}
	public String pendingStudyUID(String pat_id,String type) throws RemoteException,SQLException{
		return ddserver.pendingStudyUID(pat_id,type);
	}
	public String patWisePendingStudyUID(String pat_id,String extra) throws RemoteException, SQLException{
		return ddserver.patWisePendingStudyUID(pat_id,extra);
	}
	public String getPendingStudyList(String opdno) throws RemoteException,SQLException{
		return ddserver.getPendingStudyList(opdno);
	}
	/*Soumyajit Das*/
	public String getPendingStudyListPAT(String opdno,String patid) throws RemoteException,SQLException{
		return ddserver.getPendingStudyListPAT(opdno,patid);
	}
	public ArrayList getSyncedStudyIDList(String opdno) throws RemoteException,SQLException{
		return ddserver.getSyncedStudyIDList(opdno);
	}
	public String activeStudyUID(String pat_id,String type) throws RemoteException,SQLException{
		return ddserver.activeStudyUID(pat_id,type);
	}
	public boolean isReport(String test_id) throws RemoteException,SQLException{
		return ddserver.isReport(test_id);
	}
	public boolean isNote(String test_id) throws RemoteException,SQLException{
		return ddserver.isNote(test_id);
	}
	public String getPathoData(String test_id) throws RemoteException,SQLException{
		return ddserver.getPathoData(test_id);
	}			
	public byte[] getPathoData(String test_id, String fileId)throws RemoteException,SQLException{
			return ddserver.getPathoData(test_id,fileId);
	}
	public Object latestData(String pat_id,String tableName)throws RemoteException,SQLException{
			return ddserver.latestData(pat_id,tableName);
	}
	public Object requestConsultantQueue(String centerid) throws RemoteException,SQLException{
		return ddserver.requestConsultantQueue(centerid);
	}
	public Object getDrugListIMEDIX() throws RemoteException, SQLException
	{
		return ddserver.getDrugListIMEDIX();
	}	
	public Object getDrugListIMEDIX(String ccode) throws RemoteException, SQLException{
		return ddserver.getDrugListIMEDIX(ccode);
	}
	public Object getDrugList(String name) throws RemoteException, SQLException{
		return ddserver.getDrugList(name);
	}

	public Object getDepartments(String center)throws RemoteException, SQLException{
		return ddserver.getDepartments(center);
	}

	public Object getAllDepartments(String center)throws RemoteException, SQLException{
		return ddserver.getAllDepartments(center);
	}

	public Object getDoctorsOfDepartment(String ccode, String department)throws RemoteException, SQLException{
		return ddserver.getDoctorsOfDepartment(ccode, department);
	}
	/*Soumyajit Das*/
	public Object getAllDoctors(String center)throws RemoteException, SQLException{
		return ddserver.getAllDoctors(center);
	}
	/*Soumyajit Das*/
	public Object getDrugListByCenter(String ccode) throws RemoteException, SQLException{
		return ddserver.getDrugListByCenter(ccode);
	}
	/*Soumyajit Das*/
	public Object getdrugs(String center)throws RemoteException,SQLException
	{
		return ddserver.getdrugs(center);
	}
	/*Soumyajit Das*/
	public Object getAlldrugs(String center)throws RemoteException,SQLException
	{
		return ddserver.getAlldrugs(center);
	}
	/*Soumyajit Das*/
	public Object getDrugListDefault() throws RemoteException, SQLException
	{
		return ddserver.getDrugListDefault();
	}
 }
