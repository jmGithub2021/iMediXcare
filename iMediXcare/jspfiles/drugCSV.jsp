<%@page language="java"  import= "imedix.projinfo,imedix.rcDisplayData,java.nio.charset.StandardCharsets,java.nio.charset.StandardCharsets.*,java.net.URLEncoder,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>



<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/jquery-ui.js"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>-->
<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
</head>
<script language="JavaScript">

function addDrugs()
{
  var drug_name=[];
  var id=[];
  var oTable = document.getElementById('searchdrug');
  var rowLength = oTable.rows.length;
  /*
  for (i = 1; i < rowLength; i++){
     var oCells = oTable.rows.item(i).cells;
     var cellLength = oCells.length;
     drug_name.push(oCells.item(1).innerHTML.toString());
     id.push(oCells.item(0).innerHTML.toString());
     //drug_name.push(oCells.item(1).val());
     //id.push(oCells.item(0).val());

   }*/

   var table = $('#searchdrug').DataTable();

   table.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
    var data = this.data();
    drug_name.push(data['drug_name'][0]);
   });
   if(drug_name.length==0)
   {
     alert("Please add a csv file first!!!");
     return false;
   }
   var param = {cmd: 'csv-multiple', drug_name: drug_name.toString()};

   $.ajax({
       type: 'POST',
       url: "updateDruglist.jsp",
       data: param,
       dataType: "text",
       success: function(data) {
           var res = JSON.parse(data);
           alert(res.message);
           location.reload(true);
       }
       //location.reload(true);
   });
}

$(document).ready(function(){

  //$('#searchdrug').DataTable();
  var isCsv = function(name) {
	    return name.match(/csv$/i);
	};
  function readSingleFile(evt) {
    var f = evt.target.files[0];
    //console.log(f.name);
    if(!isCsv(f.name)){
      alert("Please upload a .csv file !!!");
      return;
    }
    if (f) {
      var r = new FileReader();
      r.onload = function(e) {
        var drugs="";
          var contents = e.target.result;
          //document.write("File Uploaded! <br />" + "name: " + f.name + "<br />" + "content: " + contents + "<br />" + "type: " + f.type + "<br />" + "size: " + f.size + " bytes <br />");
          var return_data = new Array();
          var lines = contents.split("\n"), output = [];
          for (var i=0; i<lines.length-1; i++){
            return_data.push({
                "drug_name": lines[i].split(","), "id" : (i+1)
              })
            //drugs+="<tr><td>" + lines[i].split(",").join("</td><td>") + "</td></tr>";
          }
          //console.log(drugs);
          $("#searchdrug").dataTable().fnDestroy();
          $('#searchdrug').DataTable({
              "data": return_data,
                "columns": [
                { "data":"id"},{"data": "drug_name" }
              ]
          });

          //$('#drugs').html(drugs);
     }
      r.readAsText(f);
      //document.write(output);

    } else {
      alert("Failed to load file");
    }
  }
  document.getElementById('fileinput').addEventListener('change', readSingleFile);

});
</script>

<style>
input:invalid,
input:out-of-range {
    border-color:hsl(0, 50%, 50%);
    background:hsl(0, 50%, 90%);
}
.ui-widget.ui-widget-content{z-index:1055 !important;}
.ui-helper-hidden-accessible{
    display:none !important;
}
ul.ui-autocomplete {
	list-style: none;
	list-style-type: none;
	padding: 0px;
	margin: 0px;
	background-color: white;
	width:500px;
	height: 120px;
	overflow-x: hidden;
	overflow-y: auto;

}

</style>
<BODY background="../images/txture.jpg" >
  <div class="container-fluid">
  
  <TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
  <TR>
    <TD><Font Size='5' color=#3300FF> <B>IMPORT DRUGS FROM CSV FILE</B> </Font></TD>
    <TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
  </TR>
  </TABLE>
  <%
  	cook cookx = new cook();
  	String utyp=cookx.getCookieValue("usertype", request.getCookies());
  	String usr=cookx.getCookieValue("userid", request.getCookies());

  	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

  	String ccode= cookx.getCookieValue("center", request.getCookies ());
  	String cname = cookx.getCookieValue("centername", request.getCookies ());

  	rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
    projinfo pinfo=new projinfo(request.getRealPath("/"));
    //if ((contentType.indexOf("multipart/form-data") >= 0)) {

    //    DiskFileItemFactory factory = new DiskFileItemFactory();
    //   factory.setSizeThreshold(maxMemSize);

  %>




  <div class="container-fluid">

		<div class="row">
			<div class="col-md-8 col-md-offset-2" style="margin-top: 20px;">

        <button class="btn btn-primary" style="float:right;" onClick="window.location.href='druglist_manage.jsp'">Go Back</button>
        <input type="file" id="fileinput" />
        <table style="margin-top:20px;" class="table table-bordered table-stripped table-hover" id="searchdrug">

        <thead>
        <tr>
        <th>Drug ID</th>
        <th>Drug Name</th>
        </tr>
        </thead>
      </table>
      <button class="btn btn-primary" style="float:left;" onClick="addDrugs()">Add Drugs</button>
    </div>

  </div>
</body>
</html>
