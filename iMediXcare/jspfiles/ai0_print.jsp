<%@page contentType="text/html"  import="imedix.rcDisplayData,imedix.dataobj,imedix.myDate,imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*" %>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
		<!--<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>-->
		<script src="https://cdn.jsdelivr.net/jsbarcode/3.6.0/JsBarcode.all.min.js" ></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/html2pdf.js" type="text/javascript"></script>
<style>
@media print {
      body, html {
          width: 100%;
          margin-top: 0%;
          display: block;
          height: 100%;
      }
}
.table-adv-invst{width:750px;border: 1px solid #4197c2;}
.table-adv-invst tbody td,tbody tr{background:#fff;color:#000;border: 1px solid #4197c2;}
	.table-adv-invst>tbody>tr>td, .table-adv-invst>tbody>tr>th, .table-adv-invst>tfoot>tr>td, .table-adv-invst>tfoot>tr>th, .table-adv-invst>thead>tr>td, .table-adv-invst>thead>tr>th {
		border: 1px solid #4197c2;
	}
	.table-adv-invst>thead>tr:nth-child(2){
		background: #4198c1;
		color: #eee;
	}
	.table-adv-invst>thead>tr:nth-child(1){
	    font-weight: bold;
		//color: #1378ab;
		background:#fff;
	}
	.print{cursor:pointer;}
</style>

</head>


<%
String patid="",tableName="",date="",opdno="",nextDate="";
patid = request.getParameter("id");
tableName = request.getParameter("ty");
date = request.getParameter("dt");
nextDate = request.getParameter("ndt");

cook cookx = new cook();
String patname = cookx.getCookieValue("patname",request.getCookies());
String PatAgeYMD = cookx.getCookieValue("PatAgeYMD", request.getCookies());
String sex = cookx.getCookieValue("sex", request.getCookies());
String username = cookx.getCookieValue("username", request.getCookies());


rcDisplayData rd = new rcDisplayData(request.getRealPath("/"));
String result = rd.getDataJSON(patid,tableName,date,nextDate);

//String test_id="",test_name="",description="",status="",entrydate="",reffered_by="",type="";
String innerHTML = "";
//out.println(result);
//out.println("<table align='center'><tr align ='center'><td colspan=4>Adviced Investigation</td><td id='print'>Print</td></tr></table>");
out.println("<table align='center' class='table table-bordered table-adv-invst' id='sds'><thead><tr><td>Name : "+patname+"</td><td>Age : "+PatAgeYMD+"</td><td>SEX : "+sex+"</td><td>Adviced By : "+username+"</td><td><!--<svg id='barcode'></svg>--><svg id='barcodeOPDNO'></svg></td></tr><tr><th>TEST ID</th><th>TEST NAME</th><th>DESCRIPTION</th><th>REFFERED BY</th><th>STATUS</th></tr></thead><tbody>");
	try{
		Object jsobj=new JSONParser().parse(result);
		JSONObject jsonObject = (JSONObject)jsobj;
		opdno = (String) jsonObject.get("opdno");
		int size = jsonObject.size()-2;
		for(int i=0;i<size;i++){
			String key = String.valueOf(i);
			JSONObject nestedObject = (JSONObject)jsonObject.get(key);
			innerHTML += "<tr><td align='center'><svg id = 'bar"+i+"' testid='"+(String)nestedObject.get("test_id")+"'></svg></td><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td>"+(String)nestedObject.get("status")+"</td></tr>";
		}
	}catch(Exception ex){out.println("error : \""+ex.toString()+"\"");}
out.println(innerHTML+"</tbody></table>");
%>
    <div class="row"><div class="col-sm-1"></div><div id="previewImage" class="col-sm-10"></div><div class="col-sm-1"></div></div>
<script>


	$(document).ready(function(){
		var pat_id = "";
		JsBarcode("#barcodeOPDNO", "<%=patid.toUpperCase()%>",{
			height:25,
			width:1,
			fontSize:14,
			background:"#eee"
			//text:"iMediX"
		});
		/*JsBarcode("#barcodeOPDNO", "<%=opdno%>",{
			height:30,
			width:1,
			fontSize:14,
			background:"#eee"
			//text:"iMediX"
		});	*/

	var no_of_tr = $(".table-adv-invst > tbody > tr").length;
	for(var i=1;i<=no_of_tr;i++){
		var id = $(".table-adv-invst > tbody > tr:nth-child("+i+") svg").attr("id");
		var testid = $(".table-adv-invst > tbody > tr:nth-child("+i+") svg").attr("testid");;
		testIdBarcode(""+id+"",testid);

	}

         html2canvas(element, {
         onrendered: function (canvas) {
               // $("#previewImage").append(canvas);
              //  getCanvas = canvas;
              // savePDF(canvas);
             }
         });

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


var element = $(".table-adv-invst");
var getCanvas;

    $("#print").on('click', function () {
         html2canvas(element, {
         onrendered: function (canvas) {
               // $("#previewImage").append(canvas);
              //  getCanvas = canvas;
                //savePDF(canvas);
             }
         });


			/*setTimeout(function(){
				$("#previewImage canvas").css("width","100%");

				//savePDF();
					//window.print();
			},2000);*/
		//	myPdfA();
    });

    function savePDF(canvas){
				// $("canvas").attr("style","display:none");
		 try {
			 //var canvas = document.getElementsByTagName('canvas')[0];
			//canvas.getContext('2d');
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
		    var pdf = new jsPDF();
		    pdf.addImage(imgData, 'JPEG', 6, 12);
		    var namefile = "<%=patid%>";
		    		        var iframe = document.createElement('iframe');
		        iframe.setAttribute('style', 'position:absolute;top:0;right:0;height:100%; width:100%');
		        document.body.appendChild(iframe);
				setTimeout(function() {
				iframe.src = pdf.output('datauristring');
				}, 1000);

		    //pdf.save(namefile + ".pdf");
		 } catch(e) {
			 alert("Error description: " + e.message);
		 }

	}

	function myPdfA(){
		var pdf = new jsPDF('p', 'pt', 'letter');
		var canvas = pdf.canvas;
		var width = 600;
		//canvas.width=8.5*72;
		document.body.style.width=width + "px";

		html2canvas(document.body, {
		    canvas:canvas,
		    onrendered: function(canvas) {
		        var iframe = document.createElement('iframe');
		        iframe.setAttribute('style', 'position:absolute;top:0;right:0;height:100%; width:600px');
		        document.body.appendChild(iframe);
		        iframe.src = pdf.output('datauristring');

		       //var div = document.createElement('pre');
		       //div.innerText=pdf.output();
		       //document.body.appendChild(div);
		    }
		});
		}

</script>
