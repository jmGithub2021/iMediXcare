<%@page contentType="text/html"  import="imedix.rcDisplayData,imedix.myDate,imedix.dataobj,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
String pname="abc";
cook cookx = new cook();
String dt="", pdt="";

rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));

//Vector alldata= (Vector)ddinfo.showLists(patid);  
//Object res=null;

String lstd="",cstd="",rstd="";
String tempstr="";

String template=request.getParameter("template");
String pid=request.getParameter("id");
String patdis=request.getParameter("patdis");

if(pid==null) pid=cookx.getCookieValue("patid", request.getCookies());
if(pid.equals("")) pid=cookx.getCookieValue("patid", request.getCookies());
if(patdis==null) patdis=cookx.getCookieValue("patdis", request.getCookies());
if(pid.equals("")) pid=cookx.getCookieValue("patdis", request.getCookies());

cookx.addCookie("patid",pid,response);
cookx.addCookie("patdis",patdis,response);

//out.println("patdis :" +patdis );

String age = "", height = "", weight = "", htpcnt = "", wtpcnt = "", suffix = "";        


try{
	dataobj obj= ddinfo.getPatientInfo(pid);
	int aged= Integer.parseInt(obj.getValue("age_days"));
	String dob=obj.getValue("dob");

	int ageyear = (aged/365);
	int agemonth = ( (aged%365) /30 );
	int ageday = ( (aged%365)%30 );

	age += (ageyear > 0 ? Integer.toString(ageyear) + "Y " : "");
	age += (agemonth > 0 ? Integer.toString(agemonth) + "M " : "");
	age += (ageday > 0 ? Integer.toString(ageday) + "D " : "");
	suffix = obj.getValue("gender").equalsIgnoreCase("M") ? "boys" : "girls";

	if (!obj.getValue("height").equalsIgnoreCase(""))
	{
		String ht[] = obj.getValue("height").split(" ");
		ht[1]=ht[1].substring(0,10);

		height = ht[0] + " Cm (" + ht[1] + ")";
		int month=myDate.dateDiff(ht[1],dob,"ymd");

		htpcnt = ddinfo.getPercentile("ht_" + suffix, (int)(month/30), ht[0]);
	}

	if (!obj.getValue("weight").equalsIgnoreCase(""))
	{
		String wt[] = obj.getValue("weight").split(" ");
		wt[1]=wt[1].substring(0,10);
		weight = wt[0] + " Kg (" + wt[1] + ")";
		int month=myDate.dateDiff(wt[1],dob,"ymd");
		htpcnt = ddinfo.getPercentile("wt_" + suffix, (int)(month/30), wt[0]);
	}

}catch(Exception e){

}

String visitsum="", cbcsum="", probsum="", compsum="", antiretrosum="", allergysum="", othcbcsum="", vacsum="",medicationsum ="",stagesum ="",anthrosum="",tbhis="",psthis="";

if(patdis.equalsIgnoreCase("Pediatric HIV")){
	
			
			try{
				probsum = ddinfo.getProbSummary(pid, 5);
			}catch(Exception e){
				out.println("getProbSummary :"+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/problemlist.jsp'>Active Problems</a></center>" + probsum + "</div><br>";

				
			String year=myDate.getCurrentYear();
			
			try{
				visitsum = ddinfo.getVisitSummaryPHIV(pid, year,5);
			}catch(Exception e){
				out.println("getVisitSummary : "+e);
			}
		    lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/visitsummary.jsp'>Visit Summary</a></center>" + visitsum + "</div><br>";
               
			try{
				 compsum = ddinfo.getComplaintSummaryInString(pid, 5);
			}catch(Exception e){
				out.println("getComplaintSummaryInString : "+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/complaints.jsp'>Patient's Complaints</a></center>" + compsum + "</div><br>";

			try{
				 tbhis = ddinfo.getTuberculosisHistoryRecord(pid);
			}catch(Exception e){
				out.println("getTuberculosisHistoryRecord : "+e);
			}
			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/tbhistory.jsp'>Tuberculosis History</a></center>" + tbhis + "</div><br>";

			
			try{
				 psthis = ddinfo.getPastHistoryRecord(pid);
			}catch(Exception e){
				out.println("getPastHistoryRecord : "+e);
			}
			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/pasthistory.jsp'>Past History</a></center>" + psthis + "</div><br>";

///////////////////
		
			anthrosum += "<table width='100%' border='0' align='center' cellspacing='1' cellpadding='3' style='font-size:13px;border:1px solid #00AA00'>";
			anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Age</b></td><td>" + age + "</td><td><b>Percentile</b></td></tr>";
			anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Height</b></td><td>" + height + "</td><td>" + htpcnt + "</td></tr>";
			anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Weight</b></td><td>" + weight + "</td><td>" + wtpcnt + "</td></tr>";
			anthrosum += "</table>";
			
			cstd += "<div width='100%' valign='top'><center style='color:blue;font-weight:bold;margin:5px;font-size:120%'>Anthropometric Data</center>" + anthrosum + "</div><br>";
            

			try{
				cbcsum = ddinfo.getCBCSummary(pid, 5);
			}catch(Exception e){
				out.println("getCBCSummary : "+e);
			}

			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/comparativestudy.jsp?rid=cd4'>CD4 / Viral Load</a></center>" + cbcsum + "</div><br>";

			String[][] fields = new String[][] { { "haemoglobin", "s36", "Haemo" }, { "f_sgpt", "s11", "SGPT" }, { "f_sgot", "s11", "SGOT" }, { "f_urea", "s09", "Urea" }, { "f_creatinine", "s09", "Creatinine" } };
	
			try{
				othcbcsum = ddinfo.getOtherCBCSummary(pid, fields, 3);
			}catch(Exception e){
				out.println("getOtherCBCSummary :"+e);
			}
			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Other Findings</center>" + othcbcsum + "</div><br>";
			


			try{
				//vacsum = ddinfo.getVaccinationSummary(pid);
				vacsum = ddinfo.getImmuzinationData(pid);
			}catch(Exception e){
				out.println("getVaccinationSummary :"+e);
			}

			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/immuzination.jsp'>Immunization</a></center>" + vacsum + "</div><br>";


			try{
				allergysum = ddinfo.getDrugAllergySummary(pid);
			}catch(Exception e){
				out.println("getDrugAllergySummary :"+e);
			}

			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Drug Allergy</center>" + allergysum + "</div><br>";

			try{
					 antiretrosum = ddinfo.getAntiretroviralPrescription(pid,"","");
				}catch(Exception e){
					out.println("getAntiRetroViralSummary : "+e);
				}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../phivjsp/medication.jsp'>Anti-Retrovirals</a></center>" + antiretrosum + "</div><br>";
			
			try{
					 antiretrosum = ddinfo.getCTXSummary(pid,0,"","");
				}catch(Exception e){
					out.println("getAntiRetroViralSummary : "+e);
				}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../phivjsp/medication.jsp'>Cotrimoxazole Prophylaxis</a></center>" + antiretrosum + "</div><br>";
			
			try{
					 antiretrosum = ddinfo.getAntiTuberculosisSummary(pid,0,"","");
				}catch(Exception e){
					out.println("getAntiRetroViralSummary : "+e);
				}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../phivjsp/medication.jsp'>Anti-Tuberculosis Drugs</a></center>" + antiretrosum + "</div><br>";
			
			try{
					 antiretrosum = ddinfo.getGenPrescriptionforMedication(pid,"","");
				}catch(Exception e){
					out.println("getAntiRetroViralSummary : "+e);
				}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../phivjsp/medication.jsp'>Other Medicines</a></center>" + antiretrosum + "</div><br>";
			

	}else if(patdis.equalsIgnoreCase("Oncological")){
	
			try{
				probsum = ddinfo.getProbSummary(pid, 5);
			}catch(Exception e){
				out.println("getProbSummary :"+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/problemlist.jsp'>Active Problems</a></center>" + probsum + "</div><br>";

			String year=myDate.getCurrentYear();
			try{
				visitsum = ddinfo.getVisitSummaryGEN(pid, year,5);
			}catch(Exception e){
				out.println("getVisitSummary : "+e);
			}
		    lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/visitsummary.jsp'>Visit Summary</a></center>" + visitsum + "</div><br>";
        

			try{
				 compsum = ddinfo.getComplaintSummaryInString(pid, 5);
			}catch(Exception e){
				out.println("getComplaintSummaryInString : "+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/complaints.jsp'>Patient's Complaints</a></center>" + compsum + "</div><br>";


			


			anthrosum += "<table width='100%' border='0' align='center' cellspacing='1' cellpadding='3' style='font-size:13px;border:1px solid #00AA00'>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Age</b></td><td>" + age + "</td><td><b>Percentile</b></td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Height</b></td><td>" + height + "</td><td>" + htpcnt + "</td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Weight</b></td><td>" + weight + "</td><td>" + wtpcnt + "</td></tr>";
                anthrosum += "</table>";

				cstd += "<div width='100%' valign='top'><center style='color:blue;font-weight:bold;margin:5px;font-size:120%'>Anthropometric Data</center>" + anthrosum + "</div><br>";

				
			/*             
			String[][] fields = new String[][] { { "haemoglobin", "s36", "Haemo" }, { "f_sgpt", "s11", "SGPT" }, { "f_sgot", "s11", "SGOT" }, { "f_urea", "s09", "Urea" }, { "f_creatinine", "s09", "Creatinine" } };
			try{
				othcbcsum = ddinfo.getOtherCBCSummary(pid, fields, 3);
			}catch(Exception e){
				out.println("getOtherCBCSummary :"+e);
			}
			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Other Findings</center>" + othcbcsum + "</div><br>";
            */

			try{
				stagesum = ddinfo.getOncoStageSummary(pid);
			}catch(Exception e){
				out.println("getOncoStageSummary :"+e);
			}
			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Diagnosis</center>" + stagesum + "</div><br>";


///
			try{
				allergysum = ddinfo.getDrugAllergySummary(pid);
			}catch(Exception e){
				out.println("getDrugAllergySummary :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Drug Allergy</center>" + allergysum + "</div><br>";


			try{
				medicationsum = ddinfo.getGenPrescriptionforMedication(pid, "", "");
			}catch(Exception e){
				out.println("getGenPrescriptionforMedication :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Medication</center>" + medicationsum + "</div><br>";

/*
			try{
				vacsum = ddinfo.getDiaognosisSummary(pid);
			}catch(Exception e){
				out.println("getDiaognosisSummary :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Diagnosis</center>" + vacsum + "</div><br>";
*/

	}else if(patdis.equalsIgnoreCase("Tuberculosis")){ 
			
			try{
				probsum = ddinfo.getProbSummary(pid, 5);
			}catch(Exception e){
				out.println("getProbSummary :"+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/problemlist.jsp'>Active Problems</a></center>" + probsum + "</div><br>";

			String year=myDate.getCurrentYear();
			try{
				visitsum = ddinfo.getVisitSummaryGEN(pid, year,5);
			}catch(Exception e){
				out.println("getVisitSummary : "+e);
			}
		    lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/visitsummary.jsp'>Visit Summary</a></center>" + visitsum + "</div><br>";
        

			try{
				 compsum = ddinfo.getComplaintSummaryInString(pid, 5);
			}catch(Exception e){
				out.println("getComplaintSummaryInString : "+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/complaints.jsp'>Patient's Complaints</a></center>" + compsum + "</div><br>";

				anthrosum += "<table width='100%' border='0' align='center' cellspacing='1' cellpadding='3' style='font-size:13px;border:1px solid #00AA00'>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Age</b></td><td>" + age + "</td><td><b>Percentile</b></td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Height</b></td><td>" + height + "</td><td>" + htpcnt + "</td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Weight</b></td><td>" + weight + "</td><td>" + wtpcnt + "</td></tr>";
                anthrosum += "</table>";
                
                cstd += "<div width='100%' valign='top'><center style='color:blue;font-weight:bold;margin:5px;font-size:120%'>Anthropometric Data</center>" + anthrosum + "</div><br>";

			String[][] fields = new String[][] { { "haemoglobin", "s36", "Haemo" }, { "f_sgpt", "s11", "SGPT" }, { "f_sgot", "s11", "SGOT" }, { "f_urea", "s09", "Urea" }, { "f_creatinine", "s09", "Creatinine" } };
			try{
				othcbcsum = ddinfo.getOtherCBCSummary(pid, fields, 3);
			}catch(Exception e){
				out.println("getOtherCBCSummary :"+e);
			}
			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Other Findings</center>" + othcbcsum + "</div><br>";
           

/////////

			try{
				allergysum = ddinfo.getDrugAllergySummary(pid);
			}catch(Exception e){
				out.println("getDrugAllergySummary :"+e);
			}

			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Drug Allergy</center>" + allergysum + "</div><br>";

			
			try{
					 antiretrosum = ddinfo.getAntiTuberculosisSummary(pid,0,"","");
				}catch(Exception e){
					out.println("getAntiRetroViralSummary : "+e);
				}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../tbjsp/medication.jsp'>Anti-Tuberculosis Drugs</a></center>" + antiretrosum + "</div><br>";


			try{
				medicationsum = ddinfo.getGenPrescriptionforMedication(pid, "", "");
			}catch(Exception e){
				out.println("getGenPrescriptionforMedication :"+e);
			}

			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../tbjsp/medication.jsp'>Medication</a></center>" + medicationsum + "</div><br>";
			
			try{
				vacsum = ddinfo.getDiaognosisSummary(pid);
			}catch(Exception e){
				out.println("getDiaognosisSummary :"+e);
			}

			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Diagnosis</center>" + vacsum + "</div><br>";



	}else{
	
			try{
				probsum = ddinfo.getProbSummary(pid, 5);
			}catch(Exception e){
				out.println("getProbSummary :"+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/problemlist.jsp'>Active Problems</a></center>" + probsum + "</div><br>";

			String year=myDate.getCurrentYear();
			try{
				visitsum = ddinfo.getVisitSummaryGEN(pid, year,5);
			}catch(Exception e){
				out.println("getVisitSummary : "+e);
			}
		    lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/visitsummary.jsp'>Visit Summary</a></center>" + visitsum + "</div><br>";
        

			try{
				 compsum = ddinfo.getComplaintSummaryInString(pid, 5);
			}catch(Exception e){
				out.println("getComplaintSummaryInString : "+e);
			}

			lstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'><a class='btn btn-info btn-xs' href='../jspfiles/complaints.jsp'>Patient's Complaints</a></center>" + compsum + "</div><br>";

				anthrosum += "<table width='100%' border='0' align='center' cellspacing='1' cellpadding='3' style='font-size:13px;border:1px solid #00AA00'>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Age</b></td><td>" + age + "</td><td><b>Percentile</b></td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Height</b></td><td>" + height + "</td><td>" + htpcnt + "</td></tr>";
                anthrosum += "<tr style='background-color:#FEFEF2'><td align='left' style='font-size:12px;background-color:#D7FFD7' nowrap><b>Weight</b></td><td>" + weight + "</td><td>" + wtpcnt + "</td></tr>";
                anthrosum += "</table>";
                
                cstd += "<div width='100%' valign='top'><center style='color:blue;font-weight:bold;margin:5px;font-size:120%'>Anthropometric Data</center>" + anthrosum + "</div><br>";

			String[][] fields = new String[][] { { "haemoglobin", "s36", "Haemo" }, { "f_sgpt", "s11", "SGPT" }, { "f_sgot", "s11", "SGOT" }, { "f_urea", "s09", "Urea" }, { "f_creatinine", "s09", "Creatinine" } };
			try{
				othcbcsum = ddinfo.getOtherCBCSummary(pid, fields, 3);
			}catch(Exception e){
				out.println("getOtherCBCSummary :"+e);
			}
			cstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Other Findings</center>" + othcbcsum + "</div><br>";
           
			
/////////

			try{
				allergysum = ddinfo.getDrugAllergySummary(pid);
			}catch(Exception e){
				out.println("getDrugAllergySummary :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Drug Allergy</center>" + allergysum + "</div><br>";


			try{
				medicationsum = ddinfo.getGenPrescriptionforMedication(pid, "", "");
			}catch(Exception e){
				out.println("getGenPrescriptionforMedication :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Medication</center>" + medicationsum + "</div><br>";

			
			try{
				vacsum = ddinfo.getDiaognosisSummary(pid);
			}catch(Exception e){
				out.println("getDiaognosisSummary :"+e);
			}
			rstd += "<div width='100%' valign='top'><center style='color:red;font-weight:bold;margin:3px'>Diagnosis</center>" + vacsum + "</div><br>";
	}
	
%>

<%

String lstd1=lstd.replaceAll("<table ","<table class='table'");
String lstd2=lstd1.replaceAll("<div ","<div class='table-responsive'");

String cstd1=cstd.replaceAll("<table ","<table class='table'");
String cstd2=cstd1.replaceAll("<div ","<div class='table-responsive'");

String rstd1=rstd.replaceAll("<table ","<table class='table'");
String rstd2=rstd1.replaceAll("<div ","<div class='table-responsive'");

%>

<HTML>
<HEAD>
	<TITLE>TOTAL SUMMARY </TITLE>
	<link rel="stylesheet" type="text/css" href="../style/style2.css">
<style>

BODY
{
    font-family: tahoma, Arial, Helvetica, sans-serif;
    font-size: 9pt;
    background-color: #F0F4FE;
    text-decoration: none;
    margin: 0px;
    padding 0px;
}

a
{
    FONT-FAMILY: tahoma, Arial, Helvetica, sans-serif;
	vertical-align: middle;
	font-size: 10pt;
	margin: 5px;
	color: red;
	font-weight: bold;
	text-align: center;
	padding: 15 5 15 2; 
	text-decoration: none;
}
td{
	FONT-FAMILY: tahoma, Arial, Helvetica, sans-serif;
	font-size: 9pt;
}

</style>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>
<body>
<div class="container-fluid">
    <div id="conhead" align="right" style="background-color:#FFE8E8;width:100%;height:15px;vertical-align:middle;margin-bottom:5px"><%= tempstr %></div>
  
    <div class="row">
    <div class="col-sm-3 ">
    <%= lstd2 %>
    </div>		<!-- "col-sm-3" -->
    
    <div class="col-sm-6">
    <%= cstd2 %>
    </div>		<!-- "col-sm-3" -->
    
    <div class="col-sm-3">
    
   <%= rstd2 %>
    </div>		<!-- "col-sm-3" -->

  
 </div> <!-- "container-fluid" -->  
</body>

</html>


