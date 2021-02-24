<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL"%>


<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL,java.net.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<body onload="test_getSheetsQueryResult()">
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




String hex_patId="",hex_testId="",hex_fromDate="",hex_toDate="";
if(request.getParameter("testId")!=null)
{
	hex_testId=request.getParameter("testId");


}
String temp="";int flag=1;String errorMsg="";
if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("hexList") != null) {
	hex_testId = request.getParameter("TestId");
	hex_patId = request.getParameter("PatId");
	hex_fromDate=request.getParameter("HexfromDate");
	hex_toDate=request.getParameter("HextoDate");

	if(hex_patId.length()<8 && hex_testId.length()==0)
	{
		out.write("<script>");
		out.write("alert('Patient Id must be of minimum length 8!')");
		out.write("</script>");
		errorMsg+="Patient Id must be of minimum length 8!<br>";
		flag=0;
	}
	if(hex_testId.length()!=0 && hex_patId.length()!=0 && !hex_testId.contains(hex_patId))
	{

		out.write("<script>");
		out.write("alert('Patient Id and Test Id are mismatching, please check! ')");
		out.write("</script>");
		errorMsg+="Patient Id and Test Id are mismatching, please check!<br>";
		flag=0;
	}
	if(hex_testId.length()==0 && hex_patId.length()==0)
	{
		out.write("<script>");
		out.write("alert('Enter Patient Id or Test Id!')");
		out.write("</script>");
		errorMsg+="Enter Patient Id or Test Id!<br>";
		flag=0;
	}
	if(hex_testId.length()!=0 && !rd.isValidTestId(hex_testId))
	{
		out.write("<script>");
		out.write("alert('Test Id is not Valid!')");
		out.write("</script>");
		errorMsg+="Test Id is not Valid!<br>";
		flag=0;
	}
}

%>
<script type="text/javascript">


function test_getSheetsQueryResult()
{
  //console.log("<%=errorMsg%>");
  var fileId = '1FgpZLnVFjv7SQ6HjmG-nQj6i22ZYirKSoSkvkTL3WXE';
  //var sheetName = 'Form Responses 1';
  //var rangeA1 = 'A1:H11';
  //var sqlText = "Select A, B, C, D, F,G,H WHERE O <> 'QCArogyam'  ";
  var H_patId="<%=hex_patId%>";
  var H_testId="<%=hex_testId%>";
  var H_fromDate="<%=hex_fromDate%>";
  var H_toDate="<%=hex_toDate%>";
  if(H_fromDate.localeCompare("yyyy-MM-dd")!=0)
  {
  	H_fromDate+=" 00:00:00";
  }
  if(H_toDate.localeCompare("yyyy-MM-dd")!=0)
  {
  	H_toDate+=" 00:00:00";
  }
  //console.log("Pat Id:-"+H_patId);
  //console.log("Test Id:-"+H_testId);
  //console.log("From Date:-"+H_fromDate);
  //console.log("To Date:-"+H_toDate);
  var sqlText;
  //sqlText = "Select C,F,G,H WHERE C like '"+H_patId+"%' ";
  /*if(H_patId=="")
  	console.log("patId null");
  if(H_testId=="")
  	console.log("testId null");
		*/
	if(H_patId=="" && H_testId!="")
  {
  		//sqlText = "Select C,F,G,H WHERE C='"+H_testId+"'";
  		sqlText = "Select C,F,G,H WHERE C like '"+H_testId+"%' ";
  }
  else if(H_patId!="")
  {
  		sqlText = "Select C,F,G,H WHERE C like '"+H_patId+"%' ";
  }
  //sqlText = "Select C,F,G,H WHERE C like 'SSKM%'";
  if(H_fromDate.localeCompare("yyyy-MM-dd")!=0)
  {
  	sqlText+=" and F>='"+H_fromDate+"'";
  }
  if(H_toDate.localeCompare("yyyy-MM-dd")!=0)
  {
  	sqlText+=" and F<='"+H_toDate+"'";
  }
  if(<%=flag%>=="0")
  {
  	var d="<p style='color:red;'>"+"<%=errorMsg%>"+"</p>";
  	//console.log(<%=errorMsg%>);
  	$(".errDisp").append(d);
  }

  if(<%=flag%>=="1" && (H_patId!="" || H_testId!=""))
  {
  	$(".HexDisplayList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Test Id</td><td>Test Time</td><td>Test Description</td><td>Test Result</td><td>Sync</td></tr></thead><tbody align='center'></tbody></table>");


  //console.log(sqlText);
  var request = 'https://docs.google.com/spreadsheets/d/' + fileId + '/gviz/tq?tqx=out:html&tq=' + encodeURIComponent(sqlText);
  //console.log("downloading");
  //console.log(request);

  $.get(request,
  function(val){
    //alert("val: " + val);
    //console.log("val:"+val);
    var data=val;

  	//$(".HexDisplayList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Test Id</td><td>Test Time</td><td>Test Description</td><td>Test Result</td><td>Sync</td></tr></thead><tbody align='center'></tbody></table>");
  	//console.log("data:"+data);
    var res=data;
    var ar=data.split('</tr>');
    if(ar.length==2)
    {
    	$(".HexDisplayList").append("<p style='color:red;'>No results found!</p>");
    }

    //var display="<table>";
    var x=0;
    var out=new Array(ar.length-1);
    for (var i = 0; i < out.length; i++) {
    	out[i] = new Array(4);
	}
	for(var i=0;i<ar.length-1;i++)
    {

    	var l=ar[i].indexOf("<td>");
    	var row=ar[i].substring(l);
    	//alert("row:-"+row);
    	var now=row.split("</td>");

    	//display+="<tr>";
    	var ht=["","","",""];
    	for(var j=0;j<now.length-1;j++)
    	{
    		var s=now[j].substring(4);
    		ht[j]=s;

    	}
    	var send=ht[0];
    	//console.log(ht);


    	var prin;
        $.ajax({
        	'async':false,
            'type': "POST",
            'global':false,
            'dataType': 'html',
            'url': "hex.jsp",
            'data': { "test_id":send },
            'success': function (data) {

                var st=data;
				var disp=st.substring(st.indexOf("<p>")+3,st.indexOf("</p>"));
				prin = disp;
            }
        });
		//console.log(ht+"-->"+prin);

    	if(i!=0 && prin.localeCompare("false")==0)
    	{
    		var rR=$("tbody").get(0).insertRow(x);
	    	var td0 = rR.insertCell(0);
			var td1 = rR.insertCell(1);
			var td2 = rR.insertCell(2);
			var td3 = rR.insertCell(3);
			var td4 = rR.insertCell(4);
			x=x+1;

    		var json={"testId":ht[0],"dateTime":ht[1],"testDesc":ht[2],"testResult":ht[3]};

			//console.log("x:-"+x);
    		//console.log(JSON.stringify(json));
	    	td0.innerHTML=ht[0];
			td1.innerHTML=ht[1];
			td2.innerHTML=ht[2];
			td3.innerHTML=ht[3];
			//'myFunction('"+json+"')'
			td4.innerHTML="<button id='"+JSON.stringify(json)+"' onclick='myFunction(this.id)'><span class='glyphicon glyphicon-refresh'></span><span class='flag glyphicon'></span></button>";



			td4.setAttribute("class", "hexModal");
			}

    }

  	});
	}

}

function myFunction(val)
{
	//alert(val.testId);
	//console.log("Sync obj:"+val);
	//alert($(this).attr("json")+"");
	$.post("hexCommit.jsp",{"json":val},function(data){
		var st=data;
		var disp=st.substring(st.indexOf("<p>")+3,st.indexOf("</p>"));
		//$(".hexUploader").html(data)
		alert(disp);
		//alert(data);
	});
	//alert("Sync button clicked");
}

</script>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<!--<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->
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
table th,table,td{font-size: 14px;}
table thead td{font-weight: 600;}
</style>
</head>
<script>
$(document).ready(function(){
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



});

	function pendingList()
	{
		//alert("button clicked");
		var url="serviceUrlHex.jsp";
		//var url="getStudyUID.jsp";
		var ajax_load = "<img class='loading' src='/iMediX/images/loading.gif' alt='loading...'>";
		//$(".main-body").html(ajax_load).load(url);
		$("body").html(ajax_load).load(url);

	}

</script>
<body>

<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Search For Pending Test</h3>
		</div>
		<div class="panel-body">
			<div class="row">

			<div class="col-sm-3">
			<label>For all pending patient list</label>
				<!--<input class="form-control btn-primary" type="submit" name="pendingTest" class="pendingTest" value="Get Pending List" />-->
				<button class="form-control btn-primary" onclick="pendingList()" >Get Pending List</button>
			</div>
			</div>

		</div>
	</div>




<div class="container-fluid">

	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Search For Test in HaemurEx</h3>
		</div>
		<div class="panel-body">
			<form method="POST" class="hex">
			<div class="row">
				<div class="col-sm-2">
					<label>Patient ID</label>
					<input class="form-control" type="text" name="PatId" placeholder="Patient Id" value="<%=hex_patId%>"/>
				</div>
				<div class="col-sm-2">
					<label>Test ID</label>
					<input class="form-control" type="text" name="TestId" placeholder="Test Id" value="<%=hex_testId%>"/>
				</div>
			<div class="col-sm-4">
				<label>By Date</label>
				<div class="input-group">
						<div id="from-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="HexfromDate" value="<%=hex_fromDate%>" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
						</div>
					<span class="input-group-addon">To</span>
						<div id="to-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="HextoDate" value="<%=hex_toDate%>" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
						</div>

				</div>
			</div>
			<div class="col-sm-2">
			<label>Submit</label>
				<input class="form-control btn-primary" type="submit" name="hexList" class="hexList" value="Get Test List" />
			</div>
			</div>
			</form>
			<div class="panel-body">
			<div class="HexDisplayList">

			</div>
			<div class="errDisp">

			</div>

		</div>
		</div>
	</div>

	<div class="modal fade" id="hexUploadModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <!-- Modal body -->
        <div class="modal-body hexUploader">
         Loading...
         Print Here
        </div>
      </div>
    </div>
	</div>




</div>

</body>
</html>
