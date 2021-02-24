<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL"%>


<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL,java.net.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<!--<%@page contentType="text/html" import= "imedix.rcDataEntryFrm"%>-->



<!DOCTYPE html>
<html>
<head>


	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/JsBarcode.all.min.js" ></script>
	<!--<script src="<%=request.getContextPath()%>/bootstrap/jspdf/html2pdf.js" type="text/javascript"></script>-->

	<script src="../bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
	<script src="https://rawgit.com/eKoopmans/html2pdf/master/dist/html2pdf.bundle.min.js"></script>

	<!--<script src="https://rawgit.com/eKoopmans/html2pdf/master/dist/html2pdf.bundle.js"></script>-->
	<script src="https://github.com/ahwolf/jsPDF/blob/master/jspdf.plugin.svgToPdf.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/highcharts/8.0.4/lib/svg2pdf.js"></script>

<style>
@page {
  size: A4;
  margin: 0;
}
@media print {

			body, html {

					width: 100%;
					margin-top: 3%;
					margin-left: 3%;
					margin-right: 3%;
					margin-bottom: 3%;
					display: block;
					height: 100%;
			}
			#download {
      visibility: hidden;
   }
		}
.bootstrap-datetimepicker-widget ul{padding:0px;}
#from-datepicker span, #to-datepicker span{
	left: 0px !important;
    border-radius: 0px;
}
#from-datepicker input, #to-datepicker input{
    border-radius: 0px;
}
table th,table,td{font-size: 16px;}
table thead td{font-weight: 600;}
</style>

</head>

<%
	rcDataEntryFrm rd = new rcDataEntryFrm(request.getRealPath("/"));
	String result=rd.getServiceHex();
	String patId=new String(request.getParameter("patId"));
	JSONParser parser = new JSONParser();
	JSONObject json = (JSONObject) parser.parse(result);
	JSONObject allPatient=(JSONObject)json.get(Integer.toString(json.size()-1));
	//out.println(patId);
	//out.println(request.getContextPath());

%>
<script type="text/javascript">

//$(".pendingList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td>Test Id</td><td>Test Time</td><td>Test Description</td><td>Test Result</td><td>Sync</td></tr></thead><tbody align='center'></tbody></table>");

//$(".pendingList").append("<%=result%>");


var jobj_pat=<%=allPatient%>;
var jobj_test=<%=json%>;
var pat_id="<%=patId%>";
//pat_id=new String(pat_id);

console.log("Patient Id:-"+pat_id);
var jobj=JSON.stringify(jobj_pat);
var jobjTest=JSON.stringify(jobj_test);
var obj=JSON.parse(jobj);
var objT=JSON.parse(jobjTest);

var age=obj[pat_id]["age"].toString().split(",")[0];
var patName=obj[pat_id]["patName"];
var sex=obj[pat_id]["sex"];
var ref_doc=obj[pat_id]["ref_doc"];
$(".patDetails").append("<p style='font-style: italic;font-family:courier;'>Patient Name: "+patName+"</p><p style='font-style: italic;font-family:courier;'>Patient Id: "+pat_id+"</p><p style='font-style: italic;font-family:courier;'>Sex: "+sex+"</p><p style='font-style: italic;font-family:courier;'>Age : "+age+"</p><p style='font-style: italic;font-family:courier;'>Referring Doctor: "+ref_doc+"</p>");
$(".testList").append("<table class='table table-bordered dataTable' id='pendList'><thead><tr><td align='center'>Test Id</td><td>Test Description</td><td>Check if Tested</td></tr></thead><tbody align='center'></tbody></table>");
var count=0;
for(var k in objT) {

        if(pat_id.localeCompare(objT[k]["pat_id"])==0)
        {

            var rR=$("tbody").get(0).insertRow(count);
            var td0 = rR.insertCell(0);
			var td1 = rR.insertCell(1);
			var td2 = rR.insertCell(2);
			count++;


			var json={"testId":objT[k]["test_id"],"testDesc":objT[k]["description"]};

			td0.innerHTML="<svg id = 'bar"+(count)+"' testid='"+objT[k]["test_id"]+"'</svg>";
			td1.innerHTML=objT[k]["description"];

			//'myFunction('"+json+"')'
			td2.innerHTML="<button id='"+objT[k]["test_id"]+"' onclick='myFunction(this.id)'><span class='glyphicon glyphicon-share'></span><span class='flag glyphicon'></span></button>";
        }
        barC();
    }

 function barC()
 {
 	var no_of_tr = $(".dataTable > tbody > tr").length;
	for(var i=1;i<=no_of_tr;i++){
		var id = $(".dataTable > tbody > tr:nth-child("+i+") svg").attr("id");
		var testid = $(".dataTable > tbody > tr:nth-child("+i+") svg").attr("testid");
		console.log(id+":"+testid);
		testIdBarcode(""+id+"",testid);

	}
 }
function testIdBarcode(id,testid){
		JsBarcode("#"+id+"", testid,{
			height:20,
			width:1,
			fontSize:12,
			background:"#eee"
			//text:"iMediX"
		});
	}
function myFunction(val)
{
	//alert(val.testId);
	console.log("Sync obj:"+val);
	var url="arogyam.jsp?testId="+val;
	var ajax_load = "<img class='loading' src='/iMediXcare/images/loading.gif' alt='loading...'>";
	$("body").html(ajax_load).load(url);
	//alert($(this).attr("json")+"");

	//alert("Sync button clicked");
}








function saveAs(uri, filename) {

    print("Done");
  }

function savePDF() {
	console.log("savePDF");
	html2canvas($("#pdf"), {
      onrendered: function(canvas) {
        saveAs(canvas.toDataURL(), 'iMediX.pdf');
      }
    });

	}

</script>


<body>
	<button onclick="savePDF()" id="download" style='float: right;'>Download: <span class="prcs-print glyphicon glyphicon-print pull-right"</span></button>
	<div id="pdf">
	<div class="panel panel-info">

		<div class="panel-heading">
			<div class="patDetails">

			</div>
			<h3 class="panel-title"></h3>
		</div>
		<div class="panel-body">
			<div class="testList">
			<!--<%=result%>-->
			</div>
		</div>
	</div>
	</div>








</body>
</html>
