<%@page contentType="text/html"  import="imedix.cook,imedix.rcDisplayData,imedix.rcItemlistInfo,imedix.rcDataEntryFrm,java.net.URLEncoder,imedix.dataobj,imedix.myDate,imedix.projinfo,imedix.PACSEncryption,imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
		<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>
<style>
.table-adv-invst tbody td,tbody tr{background:#fff;color:#000;}
	.table-adv-invst>tbody>tr>td, .table-adv-invst>tbody>tr>th, .table-adv-invst>tfoot>tr>td, .table-adv-invst>tfoot>tr>th, .table-adv-invst>thead>tr>td, .table-adv-invst>thead>tr>th {
		border: 1px solid #4197c2;
	}
	.table-adv-invst>thead>tr:nth-child(2){
		background: #4198c1;
		color: #eee;
	}
	.table-adv-invst>thead>tr:nth-child(1){
	    font-weight: bold;
		color: #1378ab;
	}
	.print{cursor:pointer;}
	.pathoView,.pacsView{float:right;}
	.pathoView:hover,.pathoView:focus,.pacsView:hover,.pacsView:focus{text-decoration: none;color: #015ff5;}
	a:hover,a:focus{text-decoration: none;color: #015ff5;}
	.invsReport,.invsView{pointer-events: all;}
</style>
</head>


<%
String patid="",tableName="",date="",nextDate="";
patid = request.getParameter("id");
tableName = request.getParameter("ty");
date = request.getParameter("dt");
nextDate = request.getParameter("ndt");

//date="2020/03/10";
cook cookx = new cook();
String utyp=cookx.getCookieValue("usertype", request.getCookies());

rcDisplayData rd = new rcDisplayData(request.getRealPath("/"));
String result = rd.getDataJSON(patid,tableName,date,nextDate);
PACSEncryption penc = new PACSEncryption(request.getRealPath("/"));
projinfo pinfo=new projinfo(request.getRealPath("/"));
rcDataEntryFrm rc = new rcDataEntryFrm(request.getRealPath("/"));
String pacsUrl = pinfo.PACSurl;
String uid = pinfo.PACSuid;
String pass = pinfo.PACSpass;
//String test_id="",test_name="",description="",status="",entrydate="",reffered_by="",type="";
String innerHTML = "";
//out.println(result);
out.println("<div class='table-responsive'><table align='center' class='table table-bordered table-adv-invst'><thead><tr align ='center'><td colspan=4>Advised Investigation</td><td id='print' colspan=2><a href = 'ai0_print.jsp?id="+patid+"&ty="+tableName+"&dt="+date+"&ndt="+nextDate+"' target='_blank'>Print</a></td></tr><tr><!--<th>TEST ID</th>--><th>TEST NAME</th><th>DESCRIPTION</th><th>REFFERED BY</th><th>Report</th><th>STATUS</th></tr></thead><tbody>");
	try{
		Object jsobj=new JSONParser().parse(result);
		JSONObject jsonObject = (JSONObject)jsobj;
		int size = jsonObject.size()-2;
		for(int i=0;i<size;i++){
			String key = String.valueOf(i);
			JSONObject nestedObject = (JSONObject)jsonObject.get(key);
			String status = (String)nestedObject.get("status");
			String studyUID = (String)nestedObject.get("studyUID");
			String type = (String)nestedObject.get("type");
			String test_id = (String)nestedObject.get("test_id");
			String report=(String)rc.getHEXResult(test_id);
			String createReportURL = pacsUrl+"ReportsExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
			String viewReportURL="",viewReportHTML="";
			if(rd.isReport(studyUID)){
				viewReportURL = pacsUrl+"ViewReportExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
				viewReportHTML = "<a class='frameView pull-right' href='"+viewReportURL+"' target='_blank'>View</a>";
			}
			if(status.equalsIgnoreCase("A") && type.equalsIgnoreCase("Radiology")){
				//innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'><a href='"+createReportURL+"' target='_blank'>Create</a>"+viewReportHTML+"</td><td class='invsView'>"+(String)nestedObject.get("status")+"<a class='pacsView' target='_blank' href=pacsViewer.jsp?patid="+patid+"&studyUID="+(String)nestedObject.get("studyUID")+"&url="+URLEncoder.encode(pacsUrl+"ShowViewerExt.aspx?StudyUID="+(String)nestedObject.get("studyUID")+"&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass),"UTF-8")+">View</a></td></tr>";
				if(utyp.equalsIgnoreCase("pat"))
				{
					innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'>"+viewReportHTML+"</td><td class='invsView'>"+(String)nestedObject.get("status")+"</td></tr>";
				}
				else
				{
				innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'><a href='"+createReportURL+"' target='_blank'>Create</a>"+viewReportHTML+"</td><td class='invsView'>"+(String)nestedObject.get("status")+"<a class='pacsView' target='_blank' href="+pacsUrl+"ShowViewerExt.aspx?StudyUID="+(String)nestedObject.get("studyUID")+"&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass)+">View</a></td></tr>";
				}
			}
			else if(status.equalsIgnoreCase("A") && type.equalsIgnoreCase("Pathology"))
				{
					//innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'>"+viewReportHTML+"<a class='pathoView' target='_blank' href='pathologyResultView.jsp?patId="+patid+"&tableName="+tableName+"&date="+date+"'>View</a></td><td class='invsView'>"+(String)nestedObject.get("status")+"</td></tr>";


					 if(!report.isEmpty())
					 {
				     innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'>"+viewReportHTML+"<a class='pathoView' target='_blank' href='pathologyResultView.jsp?patId="+patid+"&tableName="+tableName+"&date="+date+"&nextDate="+nextDate+"'>View</a></td><td class='invsView'>"+(String)nestedObject.get("status")+"</td></tr>";
					 }
					 else
					 {
						 innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td class='invsReport' style='min-width: 130px;'><a class='pathoView' target='_blank' href='pathologyFileview.jsp?testId="+test_id+"'>View</a>"+viewReportHTML+"</td><td class='invsView'>"+(String)nestedObject.get("status")+"</td></tr>";
					 }
				}
			else
				innerHTML += "<tr><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td></td><td class='invsReport' style='min-width: 130px;'><!--<a href='"+createReportURL+"' target='_blank'>Create</a>"+viewReportHTML+"</td>--><td>"+(String)nestedObject.get("status")+"</td></tr>";
		}
	}catch(Exception ex){out.println("error : \""+ex.toString()+"\"");}
out.println(innerHTML+"</tbody></table></div>");
%>
    <div class="row"><div class="col-sm-1"></div><div id="previewImage" class="col-sm-10"></div><div class="col-sm-1"></div></div>
<script>
/*var element = $(".table-adv-invst");
var getCanvas;

    $("#print").on('click', function () {
         html2canvas(element, {
         onrendered: function (canvas) {
                $("#previewImage").append(canvas);
                getCanvas = canvas;
             }
         });


			setTimeout(function(){
				$("#previewImage canvas").css("width","595px");

				savePDF();
					//window.print();
			},2000);
    });

    function savePDF(){
				 $("canvas").attr("style","display:none");
		 try {
			 var canvas = document.getElementsByTagName('canvas')[0];
			canvas.getContext('2d');
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
		    var pdf = new jsPDF('1', 'mm', "a4");
		    pdf.addImage(imgData, 'JPEG', 10, 10);
		    var namefile = "<%=patid%>";
		    pdf.save(namefile + ".pdf");
		 } catch(e) {
			 alert("Error description: " + e.message);
		 }

	}*/
</script>
