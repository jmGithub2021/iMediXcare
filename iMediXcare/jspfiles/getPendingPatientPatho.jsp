<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
cook cookx = new cook();
	rcDataEntryFrm rd = new rcDataEntryFrm(request.getRealPath("/"));
	rcDisplayData rdd = new rcDisplayData(request.getRealPath("/"));
	String path = request.getRealPath("/");
	String testId = "",pendingStudyUID = "",activeStudyUID="";

	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String utype= cookx.getCookieValue("usertype",request.getCookies());

	String listtype="";
	listtype = request.getParameter("listtype");
	//out.println("DDDD : "+listtype);

Date cur_date = new Date();
SimpleDateFormat dde = new SimpleDateFormat("YYYY-MM-dd");
String today = dde.format(cur_date);
String msg = "",postTestId="";

String patId = "",patName="",phone="";
if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("getPendingPatient") != null) {
	patName = request.getParameter("patName");
	patId = request.getParameter("patId");
	phone = request.getParameter("phone");
	String testType = request.getParameter("type");
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	testType="Pathology";
	String extra = testType+"#"+fromDate+"#"+toDate+"#"+patName+"#"+phone+"#"+ccode;
//	out.println(fromDate+" : "+toDate);
	//out.println(extra);
	pendingStudyUID = (listtype != null && listtype.equals("T"))?rdd.pendingStudyUID(patId,extra):rdd.patWisePendingStudyUID(patId,extra);
	msg = "Search Results.";
}
else{
	String fromDate = "",toDate="",testType="";
	fromDate = "";
	    Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -7);
        Date prevDate = cal.getTime();
		fromDate = dde.format(prevDate);
	toDate = today;

	testType="Pathology";
	String param = testType+"#"+fromDate+"#"+toDate+"#"+patName+"#"+phone+"#"+ccode;
	//out.println(param);
	pendingStudyUID = (listtype != null && listtype.equals("T"))?rdd.pendingStudyUID("",param):rdd.patWisePendingStudyUID("",param);
	msg = "Last 7 days pending test list.";
}
//out.println(rdd.pendingStudyUID("VWXYZ0191905180000",""));

%>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
<style>
.bootstrap-datetimepicker-widget ul{padding:0px;}
#from-datepicker span, #to-datepicker span{
	left: 0px !important;
    border-radius: 0px;
}
#from-datepicker input, #to-datepicker input{
    border-radius: 0px;
}
table th,table,td{font-size: 14px;}
table thead td{font-weight: 600;}
</style>
</head>
<script>
$(document).ready(function(){
var obj ;
var obj_size=0;
<%if(listtype != null && listtype.equals("T")){%>
try{
	var obj_temp = JSON.stringify(<%=pendingStudyUID%>);
	console.log(obj_temp);
	//console.log("TT : "+obj_temp+" : "+typeof(obj_temp));
	if(typeof(obj_temp)=="undefined" || obj_temp == undefined);
	else{
		obj = JSON.parse(obj_temp);
		console.log(<%=pendingStudyUID%>);
		obj_size = Object.keys(obj).length;
		if(obj_size>0){
			$(".pendingStudyUIDList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Patient Name</td><td>Phone</td><td>Test Id</td><td>Test Name</td><td>Description</td><td>Reffered By</td><td>Entrydate</td><td>Upload Test Report</td></tr></thead><tbody align='center'></tbody></table>")
		}
	}
}
catch(err){console.log(err);}
var rowCount=0;
for(var i=0;i<obj_size-1;i++){
	if(obj[i].type=="Pathology"){
	var row = $("tbody").get(0).insertRow(rowCount);
	rowCount++;
	var td0 = row.insertCell(0);
	var td1 = row.insertCell(1);
	var td2 = row.insertCell(2);
	var td3 = row.insertCell(3);
	var td4 = row.insertCell(4);
	var td5 = row.insertCell(5);
	var td6 = row.insertCell(6);
	var td7 = row.insertCell(7);
	td0.innerHTML=obj[i].patName;
	td1.innerHTML=obj[i].phone;
	td2.innerHTML=obj[i].testId;
	td3.innerHTML=obj[i].test_name;
	td4.innerHTML=obj[i].description;
	td5.innerHTML=obj[i].reffered_by;
	//td5.innerHTML=obj[i].type;
	td6.innerHTML=obj[i].entrydate.substring(0,10);
	td6.setAttribute("title",obj[i].entrydate);
	/*if(obj[i].type=="Radiology"){
		td7.innerHTML="<span class='glyphicon glyphicon-refresh'></span><span class='flag glyphicon'></span>";
		td7.setAttribute("testId", obj[i].testId);
		td7.setAttribute("class", "syncStudyUID "+obj[i].testId);
	}
	*/

		td7.innerHTML="<span class='glyphicon glyphicon-upload'></span>";
		td7.setAttribute("testId", obj[i].testId);
		td7.setAttribute("class", "pathoModal "+obj[i].testId);
		td7.setAttribute("data-toggle", "modal");
		td7.setAttribute("data-target", "#pathoUploadModal");
	}
}
<%} else{%>

try{
	var obj_temp = JSON.stringify(<%=pendingStudyUID%>);
	//console.log("TT : "+obj_temp+" : "+typeof(obj_temp));
	if(typeof(obj_temp)=="undefined" || obj_temp == undefined);
	else{
		obj = JSON.parse(obj_temp);
		console.log(<%=pendingStudyUID%>);
		obj_size = Object.keys(obj).length;
		if(obj_size>0){
			$(".pendingStudyUIDList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Patient Name</td><td>Patient Id</td><td>Phone</td><td>OPD NO</td><td>Study</td></tr></thead><tbody align='center'></tbody></table>")
		}
	}
}
catch(err){console.log(err);}
for(var i=0;i<obj_size;i++){
	var row = $("tbody").get(0).insertRow(i);
	var td0 = row.insertCell(0);
	var td1 = row.insertCell(1);
	var td2 = row.insertCell(2);
	var td3 = row.insertCell(3);
	var td4 = row.insertCell(4);
	td0.innerHTML=obj[i].patName;
	td1.innerHTML=obj[i].patId;
	td2.innerHTML=obj[i].phone;
	td3.innerHTML=obj[i].opdno;

		td4.innerHTML="<span class='glyphicon glyphicon-list' style='cursor:pointer'></span>";
		td4.setAttribute("opdNo", obj[i].opdno);
		td4.setAttribute("patId", obj[i].patId);
		td4.setAttribute("class", "testListModal "+obj[i].opdno);
		//td3.setAttribute("data-toggle", "modal");
		//td3.setAttribute("data-target", "#tesListModalId");

}

<%}%>


$(".syncStudyUID").click(function(){
	var rotation = $(this).children(".glyphicon-refresh");
	for(var i=0;i<=180;i++){
		setTimeout(function(i) {
		rotation.attr("style","transform:rotate("+i+"deg)");
	},i * 10, i);
		}

	var testId = $(this).attr("testId").trim();
	$.ajax({
		type: "POST",
		url: "studyUIDSync.jsp",
		data: {'testId':testId},
		success: function(data){
			//alert(data.trim());
			if(data.trim()=="1"){
					$("."+testId).children(".flag").addClass("glyphicon-ok").removeClass("glyphicon-remove");
					$("."+testId).children(".flag").attr("style","color:green;float:right");
			}
			else{

					$("."+testId).children(".flag").addClass("glyphicon-remove").removeClass("glyphicon-ok");
					$("."+testId).children(".flag").attr("style","color:red;float:right");
			}
		},
	});
});
$(".pendingStudyUIDList-child").delegate("#pendingOPDStudyList .syncopdStudyUID", "click",
	function(){

	var rotation = $(this).children(".glyphicon-refresh");
	for(var i=0;i<=180;i++){
		setTimeout(function(i) {
		rotation.attr("style","transform:rotate("+i+"deg)");
	},i * 10, i);
		}

	var testId = $(this).attr("testId").trim();
	var pacsstudyUID = $("#pacsStudyUIDList").val();
	$.ajax({
		type: "POST",
		url: "studyUIDSync.jsp",
		data: {'testId':testId,'studyUID':pacsstudyUID},
		success: function(data){
			//alert(data.trim());
			if(data.trim()=="1"){
					$("."+testId).children(".flag").addClass("glyphicon-ok").removeClass("glyphicon-remove");
					$("."+testId).children(".flag").attr("style","color:green;float:right");
					$("."+testId).append("<div>..."+pacsstudyUID.substring((pacsstudyUID.length-10),pacsstudyUID.length)+"</div>");
			}
			else{

					$("."+testId).children(".flag").addClass("glyphicon-remove").removeClass("glyphicon-ok");
					$("."+testId).children(".flag").attr("style","color:red;float:right");
			}
		},
	});

		//alert($(this).attr("testID")+" : "+$(this).children("#pacsStudyUIDList").val());
	}
);


$(".testListModal").click(function(){

	var opdno = $(this).attr("opdno").trim();
	var patid = $(this).attr("patId").trim();
	$.ajax({
		type: "POST",
		url: "studyUIDSync.jsp",
		data: {'opdno':opdno,'patid':patid},
		success: function(data){
			//console.log("EE"+data.trim());
			var list_obj=null,studyList=null,list_obj_size=0;
			try{
				//var obj_temp = data.trim().replace(/\\/g, "");
				var obj_temp = data.trim();
				//console.log("TT : "+obj_temp+" : "+typeof(obj_temp));
				if(typeof(obj_temp)=="undefined" || obj_temp == undefined);
				else{
					list_obj = JSON.parse(obj_temp).studyList;
					studyList = JSON.parse(list_obj);
					//console.log(studyList);
					//console.log("GG : "+JSON.parse(obj_temp)).pacsStudyList);
					//console.log("GG 2 : "+Array.from((obj_temp)[2]));
					list_obj_size = Object.keys(studyList).length;
					/*var pacsStudyUID_obj = JSON.parse(obj_temp).pacsStudyList[0];
					var pacsStudyModality_obj = JSON.parse(obj_temp).pacsStudyList[1];
					var pacsStudy_des = JSON.parse(obj_temp).pacsStudyList[2];
					var pacsStudylistDropdown = "<select class='form-control' id='pacsStudyUIDList'>";
					for(var i=0;i<pacsStudyUID_obj.length;i++){
						pacsStudylistDropdown += "<option value='"+pacsStudyUID_obj[i]+"'>"+pacsStudyUID_obj[i]+" ("+pacsStudyModality_obj[i]+")"+" ("+pacsStudy_des+")</option>";
					}
					pacsStudylistDropdown +="</select>";*/
					if(list_obj_size>0){
						//$(".pendingStudyUIDList-child").html("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Patient Name</td><td>Test Id</td><td>Test Name</td><td>Description</td><td>Reffered By</td><td>Type</td><td>Entrydate</td><td>Upload Test Report "+pacsStudylistDropdown+"</td></tr></thead><tbody align='center' id='pendingOPDStudyList'></tbody></table>")
						$(".pendingStudyUIDList-child").html("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Patient Name</td><td>Phone</td><td>Test Id</td><td>Test Name</td><td>Description</td><td>Reffered By</td><td>Entrydate</td><td>Upload Test Report</td></tr></thead><tbody align='center' id='pendingOPDStudyList'></tbody></table>")

					}
				}
			}
			catch(err){console.log(err);}


			//console.log("num of tests: "+list_obj_size);
			var rowCount=0;
			for(var i=0;i<list_obj_size-1;i++){
				//console.log("i:-"+i);
				if(studyList[i].type=="Pathology")
				{
				var row = $("tbody#pendingOPDStudyList").get(0).insertRow(rowCount);
				rowCount++;
				var td0 = row.insertCell(0);
				var td1 = row.insertCell(1);
				var td2 = row.insertCell(2);
				var td3 = row.insertCell(3);
				var td4 = row.insertCell(4);
				var td5 = row.insertCell(5);
				var td6 = row.insertCell(6);
				var td7 = row.insertCell(7);
				td0.innerHTML=studyList[i].patName;
				td1.innerHTML=studyList[i].phone;
				td2.innerHTML=studyList[i].testId;
				td3.innerHTML=studyList[i].test_name;
				td4.innerHTML=studyList[i].description;
				td5.innerHTML=studyList[i].reffered_by;
				//td5.innerHTML=studyList[i].type;
				td6.innerHTML=studyList[i].entrydate.substring(0,10);
				td6.setAttribute("title",studyList[i].entrydate);
				/*if(studyList[i].type=="Radiology"){
					//var pacsStudyUIDList = JSON.parse(pacsStudyUID_obj);
					//console.log("DD "+pacsStudyUID_obj+" : "+pacsStudyModality_obj);

					td7.innerHTML="<span class='glyphicon glyphicon-refresh'></span><span class='flag glyphicon'></span>";
					td7.setAttribute("testId", studyList[i].testId);
					td7.setAttribute("class", "syncopdStudyUID "+studyList[i].testId);
				}*/

					td7.innerHTML="<span class='glyphicon glyphicon-upload'></span>";
					td7.setAttribute("testId", studyList[i].testId);
					td7.setAttribute("class", "pathoModal "+studyList[i].testId);
					td7.setAttribute("data-toggle", "modal");
					td7.setAttribute("data-target", "#pathoUploadModal");
				}
			}


			//alert(data.trim());
			//console.log(data.trim());
		},
	});

});



		var d = new Date();
	$(function () {
    var startDate = new Date("10/10/1995"),
        endDate = new Date("<%=today%>");
		$('#from-datepicker').datetimepicker({
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 4,
			keyboardNavigation: 1,
			minView: 2,
			forceParse: 0,
			startDate: startDate,
			endDate: endDate,
			setDate: startDate
		});

	    var startDateTo = new Date("10/10/1995"),
        endDateTo = new Date("<%=today%>");
		$('#to-datepicker').datetimepicker({
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 4,
			keyboardNavigation: 1,
			minView: 2,
			forceParse: 0,
			startDate: startDateTo,
			endDate: endDateTo,
			setDate: endDateTo
		});


	});



	$("#pendList").dataTable({
		"lengthMenu": [[20,50], [20,50]],
		"info":     false
	});


	$(document).on("click", ".pathoModal" , function(){
		$.post("pathologyFileUploader.jsp",{testid:""+$(this).attr("testid")+"",patid:""+$(this).attr("testid").substring(0,18)+""},function(data){$(".pathoUploader").html(data)});
	});
	$(".tesListModalId").click(function(){
		$(".tesListModalBody").html(

		);
	});
});
</script>
<body>

<div class="container-fluid">
<% if(utype.equalsIgnoreCase("adm")){ %>
<div class="row">
<div class="col-sm-12">
	<a href="pacsResultlist.jsp" >TEST DETAILS FROM PACS</a>
</div>
</div>
<%	} %>




	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Search For Pending Test</h3>
		</div>
		<div class="panel-body">
			<form method="POST" class="pendingStudyUID">
			<div class="row">
				<div class="col-sm-2">
					<label>Patient Name</label>
					<input class="form-control" type="text" name="patName" placeholder="Min. 3 Character" value="<%=patName%>"/>
				</div>
				<div class="col-sm-2">
					<label>Patient ID</label>
					<input class="form-control" type="text" name="patId" placeholder="Patient Id" value="<%=patId%>"/>
				</div>
				<div class="col-sm-2">
					<label>Phone</label>
					<input class="form-control" type="text" name="phone" placeholder="Phone" value="<%=phone%>"/>
				</div>
			<div class="col-sm-2">
				<label>Investigation Type</label>
				<select class="form-control" name="type" disabled=true>
					<!--<option value="">Select</option>
					<option value="" disabled="true">Radiology</option>-->
					<option value="Pathology">Pathology</option>
				</select>
			</div>
			<div class="col-sm-4">
				<label>By Date</label>
				<div class="input-group">
						<div id="from-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="fromDate" value="FROM" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
						</div>
					<span class="input-group-addon">To</span>
						<div id="to-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="toDate" value="To" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
						</div>

				</div>
			</div>
			<div class="col-sm-2">
			<label>Submit</label>
				<input class="form-control btn-primary" type="submit" name="getPendingPatient" class="getPendingPatient" value="Get Pending List" />
			</div>
			</div>
			</form>
		</div>
	</div>

	<div class="panel panel-success">
		<div class="panel-heading">
			<h3 class="panel-title"><%=msg%> <label class="pull-right"><a class="btn btn-small" href="?listtype=T">TestWise</a><a class="btn btn-small" href="?listtype=P">PatientWise</a></label></h3>
		</div>
		<div class="panel-body">
			<div class="pendingStudyUIDList">

			</div>
			<div class="pendingStudyUIDList-child">

			</div>
		</div>
	</div>

  <div class="modal fade" id="pathoUploadModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <!-- Modal body -->
        <div class="modal-body pathoUploader">
         Loading...
        </div>
      </div>
    </div>
	</div>
    <div class="modal fade" id="tesListModalId">
    <div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
		<div class="modal-header">
		  <button type="button" class="close" data-dismiss="modal">&times;</button>
		  <h4 class="modal-title">Modal Header</h4>
		</div>
        <!-- Modal body -->
        <div class="modal-body tesListModalBody">
         Loading...
        </div>
      </div>
    </div>
	</div>


</div>

</body>
</html>
