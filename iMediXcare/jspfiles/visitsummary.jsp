<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",dat="";
	String tempstr = "", tempstrD = "";
	boolean isfirst = false;
	String  year="", date="", data="", tempstr1 = "", tempstr2 = "", str1 = "", str2 = "", str3 = "";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	String patdis = cookx.getCookieValue("patdis", request.getCookies());
	


	//out.println(id);
	
%>

<html >
<head >

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

<script language='javascript' src='ajaxcall.js'></script>
<style>
BODY
{
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 8pt;
    background-color: #F0F4FE;
    text-decoration: none;
    margin: 0px;
    padding: 0px;
}

div#conhead a
{
  //  font-size: 9pt;
    margin: 5px;
    color: blue;
    font-weight: bold;
    text-align: center;
   // padding: 5 5 5 2;
   // height: 20px;
    text-decoration: none;
}

div#content a
{
    text-decoration:none;
}
</style>
</head>
<body><CENTER>
	<%
	try{
		data = request.getParameter("data") != null ? request.getParameter("data") : "";
		date = request.getParameter("date") != null ? request.getParameter("date") : "";
		
		if (data != "" && date != ""){
			
			String dt = date.substring(6)+"-"+date.substring(3,5)+"-"+date.substring(0,2);

			//String dt = date.substring(8,10)+"/"+date.substring(5,7)+"/"+date.substring(0,4);	

            if(data.equalsIgnoreCase("obsrv")==true){
				tempstrD = "<br><span style='color:red;font-weight:bold'>Observation Detail on " + date + "</span><br><br>";
				tempstrD += rcDd.getObservation(id, dt);
            }else if(data.equalsIgnoreCase("prscp")==true){
				tempstrD = "<br><span style='color:red;font-weight:bold'>Prescription on " + date + "</span><br><br>";
				
				if(patdis.equalsIgnoreCase("Pediatric HIV"))
					tempstrD += rcDd.getPrescription(id, dt,"");
				else 
					tempstrD += rcDd.getGenPrescriptionforMedication(id, dt,"");

				//tempstrD += rcDd.getPrescription(id, date,"");

			}else if(data.equalsIgnoreCase("rcord")==true){
				tempstrD = "<br><span style='color:red;font-weight:bold'>Important Patient Records on " + date + "</span><br><br>";
				tempstrD += rcDd.getRecord(id, dt);
            }

		}else{
			
			year = request.getParameter("year") != null ? request.getParameter("year"): "";
			//out.println("year:'"+year+"'");

			if (year != "")
			{
				tempstr2 = "<span style='color:red;font-weight:bold'>Visit Record for Year " + year + "</span><br><br>";

				/*

                    visitdates = mydata.getVisitDates(pid, year, utype);
                    string[] dates = new string[] { };
                    if (visitdates.Get(year) != null)
                        dates = visitdates.Get(year).Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

                    if (dates.Length > 0)
                    {
                        tempstr2 += "<table style='font-size:12px;color:blue' width='500'>";
                        for (int i = 0; i < dates.Length; i++)
                        {
                            if (i % 4 == 0) tempstr2 += "<tr>";
                            tempstr2 += "<td align='center'>" + dates[i] + "</td>";
                        }
                        tempstr2 += "</table><br>";
                    }
					*/
					//tempstr2 += rcDd.getVisitSummary(id, year, 0);


					if(patdis.equalsIgnoreCase("Pediatric HIV"))
						tempstr2 += rcDd.getVisitSummaryPHIV(id, year,0);
					else 
						tempstr2 += rcDd.getVisitSummaryGEN(id, year,0);


			}else{
				Object res = rcDd.getYearVisitSummary(id);
				String fstyear="";
				if(res instanceof String) out.println(res);
					
				else{
					Vector Vtmp = (Vector)res;
					if(Vtmp.size()>0){
						for(int j=0;j<Vtmp.size();j++){
							dataobj datatemp = (dataobj) Vtmp.get(j);
							
								tempstr1 += "<a class='btn btn-info btn-xs' href=\"javascript:ExecuteCallContent('visitsummary.jsp', 'get', 'year=" + datatemp.getValue(0) + "', '', 'contentL')\">" + datatemp.getValue(0) + "(" + datatemp.getValue(1) + ")</a>";
								if(j==0) fstyear=datatemp.getValue(0);

						} //end for

							tempstr2 = "<span style='color:red;font-weight:bold'>Visit Record for Year " + fstyear + "</span><br><br>";

							if(patdis.equalsIgnoreCase("Pediatric HIV"))
								tempstr2 += rcDd.getVisitSummaryPHIV(id, fstyear,0);
							else 
								tempstr2 += rcDd.getVisitSummaryGEN(id, fstyear,0);

					   

					}else{
						tempstr1 = "No Record available";
					}// end if Vtmp size
				} // end else  res

/////

out.println("<div id='conhead' align='center' style='background-color:#FFE8E8;width:100%;'>" + tempstr1 + "</div>" + "\n");
out.println("<div id='contentL' align='center' style='width:90%;'>" + tempstr2 + "</div>");
out.println("<div id='contentD' style='width:90%;'></div>");

isfirst = true;



/////////

			}// end if else year

		} // end 1st if else

if (!isfirst)
	{
		if (tempstr1 != "") out.println(tempstr1);
		if (tempstr2 != "") out.println(tempstr2);
		if (tempstrD != "") out.println(tempstrD);
	}

		
}catch(Exception e){
	out.println(e);
}
	%>
</CENTER>
</body>
</html>
