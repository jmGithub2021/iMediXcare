<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL"%>


<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL,java.net.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<!--<%@page contentType="text/html" import= "imedix.rcDataEntryFrm"%>-->
<%
	rcDataEntryFrm rd = new rcDataEntryFrm(request.getRealPath("/"));
	String result=rd.getServiceHex();
	
	JSONParser parser = new JSONParser();
	JSONObject json = (JSONObject) parser.parse(result);
	JSONObject allPatient=(JSONObject)json.get(Integer.toString(json.size()-1));
	//out.println(allPatient.size());
	//out.println(json.get("0"));
	//out.println("-----------");
	//out.println(allPatient);

%>
<script type="text/javascript">
	
//$(".pendingList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Test Id</td><td>Test Time</td><td>Test Description</td><td>Test Result</td><td>Sync</td></tr></thead><tbody align='center'></tbody></table>");

//$(".pendingList").append("<%=result%>");


$(".pendingList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Patient Id</td><td>Patient Name</td><td>Sex</td><td>Age</td><td>Reffered Doctor</td><td>See Tests</td></tr></thead><tbody align='center'></tbody></table>");
var jobj_pat=<%=allPatient%>;
var jobj_test=<%=json%>;
var jobj=JSON.stringify(jobj_pat);
//console.log("print:-"+jobj);
//console.log(JSON.stringify(jobj["VWXYZ0190302200000"]));
var obj=JSON.parse(jobj);
var count=0;
for(var k in obj) {
        
            //console.log(obj[k]);
            //console.log(obj[k]["sex"]);
            var rR=$("tbody").get(0).insertRow(count);
            count++;
	    	var td0 = rR.insertCell(0);
			var td1 = rR.insertCell(1);
			var td2 = rR.insertCell(2);
			var td3 = rR.insertCell(3);
			var td4 = rR.insertCell(4);	
			var td5 = rR.insertCell(5);
			//console.log(obj[k]["age"].toString());
			var ar=obj[k]["age"].toString().split(",");

			td0.innerHTML=k;
			td1.innerHTML=obj[k]["patName"];
			td2.innerHTML=obj[k]["sex"];
			td3.innerHTML=ar[0];
			td4.innerHTML=obj[k]["ref_doc"];
			
			//'myFunction('"+json+"')'
			td5.innerHTML="<button id='"+k+"' onclick='myFunction(this.id)'><span class='glyphicon glyphicon-random'></span><span class='flag glyphicon'></span></button>";
        } 

function myFunction(val)
{
	console.log("Sync obj:"+val);
	var url="pathologyTestsByPatient.jsp?patId="+val;
	var ajax_load = "<img class='loading' src='/iMediXcare/images/loading.gif' alt='loading...'>";
	$("body").html(ajax_load).load(url);
}

</script>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<!--<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->
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
<body>
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">List of Patients with Pending Test</h3>
		</div>
		<div class="panel-body">			
			<div class="pendingList">
			<!--<%=result%>-->
			</div>
		</div>
	</div>







</body>
</html>