<%@page contentType="text/html" import="imedix.rcCentreInfo,imedix.rcGenOperations,imedix.rcDisplayData, imedix.dataobj,imedix.cook, java.util.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Teleconsultation Request</title>
<script language="javascript" type="text/javascript">

function changeDoctor(){
		var tar,pid,code;
		pid=document.telereq.pat_id.value;
		code=document.telereq.rhoscod.value;
		tar="telemedreq.jsp?id="+pid+"&rhoscod="+code;
		//alert(tar);
		//window.location=tar;
		$.get(tar,function(data,status){
			$(".tele-consult").html(data);
			getDepartments(code);
		});
}

function getDepartments(_ccode = ""){
	if(_ccode == ""){
		_ccode = document.telereq.rhoscod.value;
	}
	$.get('departmentInfo.jsp?active=true&ccode='+_ccode, function(data,status){
		var depts = JSON.parse(data);
		var options = '<option value="NIL">Select Department</option>';
		depts.forEach(element => {
			options += '<option value="'+element['dept_name']+'">'+element['dept_name']+'</option>';
		});
		$('#department').html(options);
	})
}

var doctor_count = 0;
function getDoctors(){
	var dept = $('#department').val();
	var _ccode = document.telereq.rhoscod.value;
	if(dept == 'NIL'){
		//var options = '<option value="NIL">Select Doctor</option>';
		//$("#rdocnam").html(options);
		changeDoctor();
		doctor_count = 0;
	}else{
		$.get('departmentInfo.jsp?cmd=doctors&dept_name='+dept+'&ccode='+_ccode, function(data,status){
			var doctors = JSON.parse(data)
			var options = '<option value="NIL">Select Doctor</option>';
			doctor_count = doctors.length;
			console.log('Doctor count: '+doctor_count);
			doctors.forEach(element => {
				options += '<option value="'+element['rg_no']+'">'+element['name']+'</option>';
			});
			$("#rdocnam").html(options);
		});
	}

}

function checkValue(){

	//var hospital = document.getElementById("rhoscod").value;
	//var doc = document.getElementById("rdocnam").value;
	var hospital = $('#rhoscod').val();
	var doc = $('#rdocnam').val();
	var department = $('#department').val();

	if(hospital == 'NIL'){
		alert("Please select a Hospital");
		return false;
	}
	if(department  == 'NIL' && doc == 'NIL'){
		alert('Please select a Department and/or Doctor');
		return false;
	}
	if(doc == 'NIL' && doctor_count == 0){
		alert("No doctor found");
		return false;
	}
	$("#docName").val($("#rdocnam option:selected").html());
	return true;

	/*
	$("#docName").val($("#rdocnam option:selected").html());
	if(hospital == 'NIL' || doc == 'NIL' ){
		alert("Select Hospital or Doctor name");
		return false;
	}
	else{
			$("#tele-req-submit").prop("disabled",true);
			return true;
		}
		*/
}
</script>

<style>
.input-group-addon{
color:blue;
min-width:11rem;
}
</style>

</head>

<%
Object res=null;
rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

//String patid=request.getParameter("id");
//String ccode=request.getParameter("ccode");

cook cookx = new cook();
rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));

String patid = cookx.getCookieValue("patid", request.getCookies());
String ccode =cookx.getCookieValue("center", request.getCookies ());
Vector alldata=null;
String att_doc="";
String pccode=rcci.getCenterCode(patid,"med").toUpperCase();

String RcCode=request.getParameter("rhoscod");
if(RcCode==null) RcCode="";
try {

	if(RcCode.equals("")){
		if(ccode.equals("XXXX") ) RcCode=rcci.getFirstCentreCode();
		else RcCode=ccode;
	}
}catch(Exception e){}

try{
	alldata= (Vector)ddinfo.getDataTeleRequest(RcCode,patid);

	att_doc=(String) alldata.get(0);
}catch(Exception e){
	out.println(e.toString());
}
%>

<link rel="stylesheet" type="text/css" href="../style/style2.css">

<body>

<div class="container-fluid tele-consult">

<!-- <form method="get" name="telereq" action='savesendreq.jsp'>
 -->
 <form method="get" name="telereq" id="telerequest-form" onsubmit="return checkValue()" action='tele_request.jsp'>
<CENTER>
 <INPUT TYPE="hidden" name="curr_ccode" value=<%=pccode%>>
 <INPUT TYPE="hidden" name="pat_id" value=<%=patid%>>
 <INPUT TYPE="hidden" name="att_doc" value=<%=att_doc%>>


  <h2>Teleconsultation Request</h2>


<div class="row ">

<div class="col-lg-3 col-sm-1"></div>

<div class="col-lg-6 col-sm-10 tableb">
<div class="input-group">
 <div class="input-group-addon">Hospital Name</div>
 <SELECT class="form-control" id="rhoscod" NAME="rhoscod" onChange="changeDoctor()";>
	  <%

		try
		{
			String refed_all=rcGen.getAnySingleValue("referhospitals","referred","code='"+pccode+"'");

			//out.println("query string:: "+refed_all);

			out.println("refed_all:>"+refed_all);

			res = (Object)alldata.get(1);

			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;

				out.println("Length:>"+Vtmp.size());
                out.println("<option value='NIL' selected>_Select Hospital_</option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String occode=datatemp.getValue("code");
						if(refed_all.indexOf(occode)>-1){
							if(RcCode.equalsIgnoreCase(datatemp.getValue("code"))){
								out.println("<option  selected='selected' value="+occode+">"+datatemp.getValue("name")+"</option><br>");
							}else{
								out.println("<option value="+occode+">"+datatemp.getValue("name")+"</option><br>");
							}
						}
					} // end for
			}// end else
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

	  %>
	  </SELECT>
</div>		<!-- "input-group" -->
		<div class="input-group">
			<div class="input-group-addon">Department *</div>
			<select class="form-control" id="department" name="department" onChange="getDoctors()">
			<%
			/*
				Object depts = ddinfo.getAllDepartments(ccode);
				Vector deptsV = (Vector)depts;
				//String options = "";
				for(int i=0;i<deptsV.size();i++){
					dataobj obj = (dataobj)deptsV.get(i);
					out.println("<option value='"+obj.getValue("iddepartment")+"'>"+obj.getValue("department_name")+"</option>");
				}
			*/
			%>
			</select>
		</div>

	  <div class="input-group">
 <div class="input-group-addon">Doctor Name</div>
	  <SELECT class="form-control" id = "rdocnam" NAME="rdocnam">
	  <%

	  try
		{	res = (Object)alldata.get(2);
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()<1){
					out.println("<option value='NIL' >No match Found</option>");
				}else{
					out.println("<option value='NIL'>Select Doctor</option>");

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						out.println("<option value="+datatemp.getValue("rg_no")+">"+datatemp.getValue("name")+"</option><br>");
					}
				}
			}
		}
		catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}
	  %>
	  </SELECT>
	  <input type="hidden" name="docName" id="docName" value="" hiddden/>
</div>		<!-- "input-group" -->


	  <div class="input-group" style="display: none;">
 <div class="input-group-addon">Send Records</div>
 <select class="form-control" NAME="records" size="1">
        <option value="all">All</option>
        <option value="sel">Selected</option>
    </select>
</div>		<!-- "input-group" -->

  <br/><CENTER><INPUT class="btn btn-primary" id="tele-req-submit" TYPE="submit" value="Submit"></CENTER>



</form>

</div>		<!-- "col-lg-6 col-sm-10" -->

<div class="col-lg-3 col-sm-1" id="retdata"  name="retdata"></div>

</div>		<!-- "row" -->
<div id="dialog-form" title="Send Email Reminder"></div>
</div>		<!-- "container-fluid" -->
</body>
</html>
<script >
$( document ).ready(function() {
    $(document).on('change', '#rdocnam', function(event) {
		//alert("hi");
		var docid1 = $("select#rdocnam option").filter(":selected").val();
		var hospid1 =$("select#rhoscod option").filter(":selected").val();
		var patid1 = "'<%=patid%>'";
		$.post("telepatwaitlist.jsp", { patid: patid1, hospid: hospid1, docid:docid1 },
			function(data, status){
				//alert("Data: " + data + "\nStatus: " + status);
				//$("#retdata").html("Data: " + data + "\nStatus: " + status);
		});
	});
	getDepartments();
});
</script>
