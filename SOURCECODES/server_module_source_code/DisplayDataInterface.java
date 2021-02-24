package imedix;
/**
 * @author Saikat Ray
 **/
  
import java.rmi.*;
import java.sql.*;
import java.util.Vector;
import java.util.ArrayList;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Interface used for Manage The Display The Data of iMediX System.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see DisplayData
 */
 
//remote interface
public interface DisplayDataInterface extends Remote {
	    
     public Object DisplayMed(String id,String dt,String slno)throws RemoteException,SQLException ;
     
     public Object DisplayFrm(String tnam,String id,String dt,String slno)throws RemoteException,SQLException ;
    
     public Object getAttachmentAndOtherFrm(String id,String ftype,String slno,String dt) throws RemoteException,SQLException;

     public Object getSelfRelationPatList(String ccode) throws RemoteException, SQLException;

      public Object getFamilyMembers(String primarypatid) throws RemoteException, SQLException;

     public Object DisplayFrmLayers(String tnam,String id,String dt,String slno)throws RemoteException,SQLException ;
     
     public Object getChildAndOtherFrm(String id,String ftype,String slno) throws RemoteException,SQLException;
	 
     public Object getImgdetailsOtherimgMarkimg(String mtype,String id,String type,String dt,String isl,String msl,String rcode) throws RemoteException,SQLException;
	
     public Object showLists(String paid)throws RemoteException,SQLException ;
     
     public Object showAllLists(String paid)throws RemoteException,SQLException ;
      
     public Object viewSummary(String paid)throws RemoteException,SQLException ;
     
     public Object viewSummary(String paid,String ccode)throws RemoteException,SQLException;
     
     public byte[] getImage(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
     public byte[] getBackupImage(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
        
     public String getImageCon_type(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
     
     public byte[] getRImage(String paid,String edate,String type,String slno,String islno,String rcode)throws RemoteException,
        SQLException ;
        
     public String getRImageCon_type(String paid,String edate,String type,String slno,String islno,String rcode)throws RemoteException,
        SQLException ;
     
     public byte[] getDocument(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
     
     public Object getDocumentdetailsOthers(String paid,String edate,String type,String slno) throws RemoteException,SQLException;
     
     public String getDocumentExt(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
        
     public byte[] getMovie(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
     
     public Object getMoviedetailsOthers(String paid,String edate,String type,String slno) throws RemoteException,SQLException;
     
     public String getMovieExt(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;
     
     public String getMovieCon_type(String paid,String edate,String type,String slno)throws RemoteException,
        SQLException ;

    public Object getDataTeleRequest(String ccode,String pid)throws RemoteException,SQLException;
     
   	public Object getComplaintSummary(String id, int no ) throws RemoteException,SQLException;
   	public String getVisitSummaryPHIV(String id, String year, int no) throws RemoteException,SQLException;
	public String getVisitSummaryGEN(String id, String year, int no) throws RemoteException,SQLException;

   	public Object getYearVisitSummary(String id) throws RemoteException,SQLException;
   	
    public String getObservation(String id, String date)throws RemoteException,SQLException;
    
    public String getPrescription(String id, String date,String slno) throws RemoteException,SQLException;
    
    public String getAntiretroviralPrescription(String id,String edate,String slno) throws RemoteException,SQLException;
    public String getCTXSummary(String id, int no,String edate,String slno)throws RemoteException,SQLException;
    public String getAntiTuberculosisSummary(String id, int no,String edate,String slno)throws RemoteException,SQLException;
        
    
    public String getGenPrescriptionforMedication(String id,String date,String slno) throws RemoteException,SQLException;
    public String getRecord(String id, String date) throws RemoteException,SQLException;
    public dataobj getVisitDates(String id,String year) throws RemoteException,SQLException;
    
    public String getImpression(String id) throws RemoteException,SQLException;
    public String getImmuzinationData(String id) throws RemoteException,SQLException;
    public String getPhenotypeRecord(String id) throws RemoteException,SQLException;  
    
  	public String getCBCSummary(String patid, int no) throws RemoteException,SQLException;
	public String getOtherCBCSummary(String patid, String[][] fields, int no) throws RemoteException,SQLException;
	public String getProbSummary(String patid, int no) throws RemoteException,SQLException;
	public String getAntiRetroViralSummary(String patid, int no) throws RemoteException,SQLException;
	public String getDrugAllergySummary(String patid) throws RemoteException,SQLException;
		
	public String getVaccinationSummary(String patid) throws RemoteException,SQLException;
	public String getDiaognosisSummary(String patid) throws RemoteException,SQLException;
	public String getOncoStageSummary(String patid) throws RemoteException,SQLException;
	
	public dataobj getPatientInfo(String patid) throws RemoteException,SQLException;
	public String getPercentile(String tabname, int month, String val) throws RemoteException,SQLException;
	public dataobj getPercentile(String tabname, int month) throws RemoteException,SQLException;
	
	public String getPastHistoryRecord(String patid) throws RemoteException,SQLException;
	public String getTuberculosisHistoryRecord(String patid)throws RemoteException,SQLException;
	
	public String getBirthHistoryRecord(String patid) throws RemoteException,SQLException;
	
	public String getSocioEcoStatusRecord(String patid) throws RemoteException,SQLException;
	public String getSupportSystemRecord(String patid) throws RemoteException,SQLException;
	public String getARTRecord(String patid) throws RemoteException,SQLException;
	public String getHIVExposedRecord(String patid) throws RemoteException,SQLException;
	public String getAdherenceRecord(String patid) throws RemoteException,SQLException;
	
	public String getSocialHistoryRecord(String patid) throws RemoteException,SQLException;
	public String getDevelopmentMilestonesRecord(String patid) throws RemoteException,SQLException;
	public String getPlanRecord(String patid) throws RemoteException,SQLException;
	public String getDataJSON(String pat_id,String tableName,String date,String nextDate) throws RemoteException,SQLException;	
	public String pendingStudyUID(String pat_id,String extra) throws RemoteException,SQLException;
	public String patWisePendingStudyUID(String pat_id,String extra) throws RemoteException, SQLException;
	public String getPendingStudyList(String opdno) throws RemoteException,SQLException;
   /*Soumyajit Das*/
   public String getPendingStudyListPAT(String opdno,String patid) throws RemoteException,SQLException;
	public ArrayList getSyncedStudyIDList(String opdno) throws RemoteException,SQLException;
	public String activeStudyUID(String pat_id,String extra) throws RemoteException,SQLException;
	public boolean isReport(String test_id) throws RemoteException,SQLException;
	public boolean isNote(String test_id) throws RemoteException,SQLException;
	public String getPathoData(String test_id) throws RemoteException,SQLException;
	public byte[] getPathoData(String test_id, String fileId)throws RemoteException,SQLException;
	public Object latestData(String pat_id,String tableName)throws RemoteException,SQLException;
   public Object requestConsultantQueue(String centerid) throws RemoteException,SQLException;
   public Object getDrugListIMEDIX() throws RemoteException, SQLException;
	public Object getDrugListIMEDIX(String ccode) throws RemoteException, SQLException;
	public Object getDrugList(String name) throws RemoteException, SQLException;

   public Object getDepartments(String center)throws RemoteException, SQLException;
   public Object getAllDepartments(String center)throws RemoteException, SQLException;
   public Object getDoctorsOfDepartment(String ccode, String department)throws RemoteException, SQLException;
/*Soumyajit Das*/
	public Object getAllDoctors(String center)throws RemoteException, SQLException;
   /*Soumyajit Das*/
   public Object getDrugListByCenter(String ccode) throws RemoteException, SQLException;
   /*Soumyajit Das*/
   public Object getdrugs(String center)throws RemoteException,SQLException;
   /*Soumyajit Das*/
   public Object getAlldrugs(String center)throws RemoteException,SQLException;
   /*Soumyajit Das*/
   public Object getDrugListDefault() throws RemoteException, SQLException;
}
