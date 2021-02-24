<%@page contentType="text/html"  import="java.net.URLEncoder,imedix.dataobj,imedix.myDate,imedix.PACSEncryption,imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*" %>
<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL,java.net.*"%>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
		<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>
		<script src="../bootstrap/JsBarcode.all.min.js" ></script>

		<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
		<!--<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>-->
		<script src="../bootstrap/JsBarcode.all.min.js" ></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/html2pdf.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/dom-to-image.js" type="text/javascript"></script>

		<script src="https://d3js.org/d3.v5.min.js"></script>
		<!--<script src="http://cdn.jsdelivr.net/g/filesaver.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/amcharts/3.21.15/plugins/export/libs/FileSaver.js/FileSaver.min.js"></script>-->
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

.table-adv-invst{width:750px;border: 1px solid #4197c2;}
.table-adv-invst tbody td,tbody tr{background:#fff;color:#000;border: 1px solid #4197c2;font-size: 14}
	.table-adv-invst>tbody>tr>td, .table-adv-invst>tbody>tr>th, .table-adv-invst>tfoot>tr>td, .table-adv-invst>tfoot>tr>th, .table-adv-invst>thead>tr>td, .table-adv-invst>thead>tr>th {
		border: 1px solid #4197c2;
	}
	.table-adv-invst>thead>tr:nth-child(2){
		font-size: 14;
		background: #4198c1;
		color: #eee;
	}
	.table-adv-invst>thead>tr:nth-child(1){
	    font-weight: bold;
			font-size: 14;
		//color: #1378ab;
		background:#fff;
	}
	.print{cursor:pointer;}



</style>
</head>
<body>
	<!--@media print {
	      body, html {
	          width: 100%;
	          margin-top: 0%;
	          display: block;
	          height: 100%;
	      }
	}-->
<button onclick="savePDF()" id="download" style='float: right;'>Download: <span class="prcs-print glyphicon glyphicon-print pull-right"</span></button>
	<div id="pdf">

<div id="content">
<!--<canvas id="canvas" width="480" height="320"></canvas>
<button id="download" onclick="screenshot()">Download Pdf</button>-->
<%
cook cookx = new cook();
String patname = cookx.getCookieValue("patname",request.getCookies());
String pat_id="",desc="",refferedBy="",testName="",opdno="";
String innerHTML = "";

String PatAgeYMD = cookx.getCookieValue("PatAgeYMD", request.getCookies());
String sex = cookx.getCookieValue("sex", request.getCookies());
String username = cookx.getCookieValue("username", request.getCookies());


pat_id=request.getParameter("patId");
String tableName=request.getParameter("tableName");
String date=request.getParameter("date");
String nextDate=request.getParameter("nextDate");
rcDisplayData rd = new rcDisplayData(request.getRealPath("/"));
String result = rd.getDataJSON(pat_id,tableName,date,nextDate);
rcDataEntryFrm rc = new rcDataEntryFrm(request.getRealPath("/"));

//rc.getHEXResult(test_id);


out.println("<div id='print'><div class='table-responsive'><table align='center' class='table table-bordered table-adv-invst' id='sds'><thead><tr><td><!--<svg id='barcode'></svg>--><svg id='barcodeOPDNO'></svg></td><td>Name : "+patname+"</td><td>Age : "+PatAgeYMD+"</td><td>SEX : "+sex+"</td></tr><tr><th>TEST ID</th><th>TEST NAME</th><th>DESCRIPTION</th><th>TEST RESULT</th></tr></thead><tbody>");
	try{
		Object jsobj=new JSONParser().parse(result);
		JSONObject jsonObject = (JSONObject)jsobj;
		int size = jsonObject.size()-2;
		opdno = (String) jsonObject.get("opdno");
		for(int i=0;i<size;i++){
			String key = String.valueOf(i);
			JSONObject nestedObject = (JSONObject)jsonObject.get(key);
			String status = (String)nestedObject.get("status");
			String studyUID = (String)nestedObject.get("studyUID");
			String type = (String)nestedObject.get("type");
			String test_id = (String)nestedObject.get("test_id");
			String report=(String)rc.getHEXResult(test_id);
			String refferedby=(String)nestedObject.get("reffered_by");
			String range="";
			if(((String)nestedObject.get("description")).equalsIgnoreCase("Total Bilirubin"))
			{
					range="< = 1.2 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Direct Bilirubin"))
			{
					range="< = 0.5 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Glucose(Fasting)"))
			{
					range="80 - 120 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Glucose(PP)"))
			{
					range="80 - 120 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Glucose(Random)"))
			{
					range="80 - 120 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("SGPT"))
			{
					range="< = 50 IU/L";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("SGOT"))
			{
					range="< = 50 IU/L";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Creatinine"))
			{
					range="Male: 0.7 - 1.4 mg/dL<br>Female: 0.6 - 1.2 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Uric Acid"))
			{
					range="Male: 3.4 - 7.0 mg/dL<br>Female: 2.4 - 5.7 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Total Cholestrol"))
			{
					range="Normal: < 200 mg/dL<br>Border:200 - 240 mg/dl<br>High: > 240 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("HDL"))
			{
					range="30 - 70 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("LDL"))
			{
					range="< 150 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Triglyceride"))
			{
					range="< 160 mg/dL";
			}
			else if(((String)nestedObject.get("description")).equalsIgnoreCase("Haemoglobin"))
			{
					range="Male: 13.5 - 17.5 g/dL<br>Female: 12.0 - 15.5 g/dL";
			}
			else
			{
					range="-";
			}
			if(status.equalsIgnoreCase("A") && type.equalsIgnoreCase("Pathology") && !report.isEmpty())
			{
				innerHTML += "<tr><td align='center'><svg id = 'bar"+i+"' testid='"+(String)nestedObject.get("test_id")+"'></svg></td><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td >"+report+"</td></tr><tr><th>Normal Range :</th><td>"+range+"</td><th>Advised By :</th><td>"+refferedby+"</td></tr>";
			}

		}
	}
	catch(Exception ex)
	{
		out.println("error : \""+ex.toString()+"\"");
	}
out.println(innerHTML+"</tbody></table></div></div>");





%>
</div>
</div>
</body>

<script>

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

	$(document).ready(function(){

		JsBarcode("#barcodeOPDNO", "<%=opdno%>",{
			height:20,
			width:1,
			fontSize:12,
			background:"#eee"
			//text:"iMediX"
		});


	var no_of_tr = $(".table-adv-invst > tbody > tr").length;
	for(var i=1;i<=no_of_tr;i++){
		var id = $(".table-adv-invst > tbody > tr:nth-child("+i+") svg").attr("id");
		var testid = $(".table-adv-invst > tbody > tr:nth-child("+i+") svg").attr("testid");
		//console.log(id+":"+testid);
		testIdBarcode(""+id+"",testid);

	}

	});

function testIdBarcode(id,testid){
		JsBarcode("#"+id+"", testid,{
			height:20,
			width:1,
			fontSize:12,
			background:"#eee"
			//text:"iMediX"
		});
}
</script>
