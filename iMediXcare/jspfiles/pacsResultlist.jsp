<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL"%>
<%@ include file="..//includes/chkcook.jsp" %>

<% 
cook cookx = new cook();
String utype= cookx.getCookieValue("usertype",request.getCookies());
if(utype.equalsIgnoreCase("adm")){
%>

<%
	String studyList = "[]";
	Date cur_date = new Date();
	SimpleDateFormat dde = new SimpleDateFormat("MM/dd/yyyy");
	String today = dde.format(cur_date);

	String startDate = "";
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DATE, -1);
	Date prevDate = cal.getTime();    
	startDate = dde.format(prevDate);

	String path = request.getRealPath("/");
	rcDataEntryFrm rd = new rcDataEntryFrm(path);
	rcDisplayData rdd = new rcDisplayData(path);
	
	
if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("getpendingStudyUID") != null) {
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
//	out.println(fromDate+" : "+toDate);
	studyList = getstudyList(fromDate,toDate,path);
}	
%>

<%!
public String getstudyList(String fromdate,String todate, String path){
	String result = "",studyUID="",status="";
	projinfo pinfo=new projinfo(path);
	rcDataEntryFrm rdef = new rcDataEntryFrm(path);
  //  String serializedTest_id = "\""+test_id+"\"";
    String serializedTest_id = "{\"FromDate\":\""+fromdate+"\",\"ToDate\":\""+todate+"\"}";
		 try{
			String type = "application/json";
			String serviceURL = (pinfo.PACSServiceURL);
			URL url = new URL(serviceURL+"GetStudyUIDListWithinDateRange");
			OutputStreamWriter osw ;
			
			
			URLConnection connection = url.openConnection();
			if (connection instanceof HttpsURLConnection)
			{
				HttpsURLConnection httpCon = (HttpsURLConnection) connection;
				TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager()
				{
					public java.security.cert.X509Certificate[] getAcceptedIssuers()
					{
						return null;
					}

					public void checkClientTrusted(
						java.security.cert.X509Certificate[] certs, String authType)
					{
					}

					public void checkServerTrusted(
						java.security.cert.X509Certificate[] certs, String authType)
					{
					}
				} };

				SSLContext sc = SSLContext.getInstance("TLSv1.2");
				sc.init(null, trustAllCerts, new java.security.SecureRandom());
				httpCon.setSSLSocketFactory(sc.getSocketFactory());
				HostnameVerifier allHostsValid = new HostnameVerifier() {
					public boolean verify(String hostname, SSLSession session) {
						return true;
					}
				};
				httpCon.setHostnameVerifier(allHostsValid);
				httpCon.setDoOutput(true);
				httpCon.setRequestMethod("POST");
				httpCon.setRequestProperty( "Content-Type", type);
				osw = new OutputStreamWriter(
				httpCon.getOutputStream());
				//String test_id = request.getParameter("test_id");
				OutputStream os = httpCon.getOutputStream();
				os.write(serializedTest_id.getBytes());
				os.flush();
				BufferedReader br = new BufferedReader(new InputStreamReader(httpCon.getInputStream())); 
					String output="";
				while ((output = br.readLine()) != null) {
					result = output.replaceAll("^\"|\"$", "").replaceAll("\\\\", "");
				}			
			}
			else{
				HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
				httpCon.setDoOutput(true);
				httpCon.setRequestMethod("POST");
				httpCon.setRequestProperty( "Content-Type", type);
				osw = new OutputStreamWriter(
				httpCon.getOutputStream());
				//String test_id = request.getParameter("test_id");
				OutputStream os = httpCon.getOutputStream();
				os.write(serializedTest_id.getBytes());
				os.flush();
				BufferedReader br = new BufferedReader(new InputStreamReader(httpCon.getInputStream())); 
					String output="";
				while ((output = br.readLine()) != null) {
					result = output.replaceAll("^\"|\"$", "").replaceAll("\\\\", "");
				}	
			}
			//out.println(result);
			status = result;
			JSONParser parser = new JSONParser();
			JSONArray array = (JSONArray)parser.parse(result);
				result += " : "+array.size();
			
			/*if (array.size()>1){
				status = "It seems test has been performed twice or more. Contact to nodal center adminstrator.<br>";
				for(int i=0;i<array.size();i++)
				studyUID += (String)((JSONObject)array.get(i)).get("StudyUID")+"<br>";
				//out.println(studyUID);
			}
			else{
				status = "Test is not done till now";
			}*/
			//out.println(httpCon.getResponseCode());
			//out.println(httpCon.getResponseMessage());
			osw.close();
		}catch(Exception ex){studyUID = ex.toString();}
	return status;
}
%>



<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="/iMediX/bootstrap/bootstrap-datetimepicker.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="/iMediX/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="/iMediX/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
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
.testid-td{display:inline-flex;}
.testid-td .idChangeEvt{margin-left:5px;color:blue;}
</style>
</head>
<script>
$(document).ready(function(){
	
	
var obj ;
var obj_size=0;
try{
	var obj_temp = JSON.stringify(<%=studyList%>);
	//console.log("TT : "+obj_temp+" : "+typeof(obj_temp));
	if(typeof(obj_temp)=="undefined" || obj_temp == undefined);
	else{	
		obj = JSON.parse(obj_temp);	
		obj_size = obj.length;
		if(obj_size>0){
			$(".StudyUIDList").append("<table class='table table-bordered dataTable' id='List'><thead><tr><td>Patient Name</td><td>DateOfBirth</td><td>SEX</td><td>Modality</td><td>Study Date</td><td>Test Id</td><td>Study UID</td></tr></thead><tbody align='center'></tbody></table>")
		}
	}
	//console.log(obj[0]);
}
catch(err){console.log(err);}
for(var i=0;i<obj_size-1;i++){
	var row = $("tbody").get(0).insertRow(i);
	var td1 = row.insertCell(0);
	var td2 = row.insertCell(1);
	var td3 = row.insertCell(2);
	var td4 = row.insertCell(3);
	var td5 = row.insertCell(4);
	var td6 = row.insertCell(5);
	var td7 = row.insertCell(6);
	td1.innerHTML=obj[i].PatientName;
	td2.innerHTML=obj[i].DateOfBirth;
	td3.innerHTML=obj[i].Sex;
	td4.innerHTML=obj[i].Modality;
	td5.innerHTML=obj[i].StudyDate;
	td6.innerHTML="<span class='testIdValue'><input id='"+obj[i].StudyUID+"' name='studyUID' value='"+obj[i].StudyUID+"' hidden/><input type='text' name='upTestId' value='"+obj[i].PatientId+"' readonly/></span><span class='idChangeEvt glyphicon glyphicon-ok pull-right'></span>";
	td7.innerHTML=obj[i].StudyUID;
	td6.setAttribute("class","testid-td");
}
	
	
	
	
	
	//var d = new Date();
	$(function () {
	var startDate = new Date("10/10/1995"),
	endDate = new Date("<%=startDate%>");
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
		setDate: endDate
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
		$("#List").dataTable({
		"lengthMenu": [[20,50], [20,50]],
		"info":     false
	});
	
$(".testIdValue").click(function(){
$(this).children("input").prop("readonly",false);
});	

$(".idChangeEvt").click(function(){
	var updatedTestId = $(this).siblings("span").children("input[name='upTestId']").val();
	var studyUID = $(this).siblings("span").children("input[name='studyUID']").val();
	if(updatedTestId.length>1 || studyUID.length>10){
		$.post("ajax_correct_testId.jsp",{upTestId:""+updatedTestId+"",studyUID:""+studyUID+""}).done(function(data){alert(data.trim());});
		//alert(updatedTestId+" : "+studyUID);
	}

});
	
	
});
</script>
<BODY background="../images/txture.jpg" >
	<Font Size='5' color=#3300FF> <B>GET PACS RESULT</B> </Font></TD>
	<A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED;float:right; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A>
	<div class="container-fluid">
	
	
<div class="container-fluid">
<div class="row">
<div class="col-sm-12">
	<a href="getStudyUID.jsp" >GET PENDING LIST</a>
</div>
</div>
	<div class="row">
	<form method="POST" class="getstudyUID">
	<div class="col-sm-10">
		<label>By Date</label>
		<div class="input-group">
				<div id="from-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
					<input data-format="MM/dd/yyyy" type="text" name="fromDate" value="<%=startDate%>" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
				</div>
			<span class="input-group-addon">To</span>
				<div id="to-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
					<input data-format="MM/dd/yyyy" type="text" name="toDate" value="<%=today%>" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
				</div>
		</div>		
	</div>
	<div class="col-sm-2">
		<label>Submit</label>
		<input class="form-control btn-primary" type="submit" name="getpendingStudyUID" class="getpendingStudyUID" value="Get Study List" />
	</div>
	</form>
	</div>

	<div class="StudyUIDList table-responsive"></div>
	
</div>
</body>
<%	} %>
