<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,imedix.rcCentreInfo, imedix.rcDataEntryFrm, imedix.rcUserInfo, java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	boolean isInQueue = false;
	cook cookx = new cook();
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cnfo = new rcCentreInfo(request.getRealPath("/"));
	rcDataEntryFrm dataentry = new rcDataEntryFrm(request.getRealPath("/"));
	rcUserInfo userinfo = new rcUserInfo(request.getRealPath("/"));
	String  referring_doc,ccode="",patid="",patname="";
	ccode =cookx.getCookieValue("center", request.getCookies ());
	patid =cookx.getCookieValue("patid", request.getCookies ());
	patname =cookx.getCookieValue("patname", request.getCookies ());
	String dat = myDate.getCurrentDate("dmy",false);
	
	Enumeration paramNames = request.getParameterNames();
		if(paramNames.hasMoreElements()) {
		String paramName = (String)paramNames.nextElement();
		if(paramName.equalsIgnoreCase("id"))
			patid = request.getParameter("id");
			patname = "";
		}
	isInQueue = dataentry.isInQueue(patid);	
	//out.println(dataentry.isInQueue(patid));
	//out.println("dddddddddddd : "+patid.substring(0,4));
	
	

 
%>

<HTML>

<HEAD>
<TITLE>PATIENTS DATA-MED FORM....
</TITLE>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">-->
	<!--<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->
	<!--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>-->

</HEAD>
<style>
.assign-doc{padding:7px 12px;background: #ddd;}
.setvisit span.phy{
	border: 1px solid #ccc;
    box-shadow: 0px 0px 1px 0px #ccc;
}
.ui-dialog-titlebar{
    background: #45786d;
    color: #f5f5f5;	
}
</style>
<script>
	  $( function() {

	  });	
	$(document).ready(function(){

	  	if(<%=isInQueue%>==true){
	  		$(".ui-dialog").remove(); 
	  		$(".btn-setvisit").attr("disabled",true);
		    $( "#oldpatreg-dialog" ).dialog({
				resizable: false,
				height: "auto",
				width: 450,
				modal: true,
				body:"FFFFFF",
				buttons : [
				    {
				        text:'Visit the Patient',
				        class:'btn btn-info',
				        click: function() {
				        	window.location="?dest=patientAlldata&id=<%=patid%>";
				            $(this).dialog("close");  
				            $(this).remove();                      
				        }                   
				    },
				    {
				        text:'Remove the Patient',
				        class:'btn btn-warning',
				        click: function() {
							  $.get("patLTreatmentSts.jsp?status=false&patid=<%=patid%>&patqtype=local", function(data, status){
							  	if(status=="success")
							    	alert("The patient is moved to treated queue.");
						        	$(".btn-setvisit").attr("disabled",false);						    
							  });
							$(this).dialog("close");
							$(this).remove(); 				        	
				        }                   
				    }
				],
				close: function(){
					$(".ui-dialog").remove(); 
				},       
				my: 'top',
		       	at: 'top'	      
		    });
		}

		$(".setvisit-input").focus();
		if($(".setvisit-input").val().length>0){
			$(".setvisit-input").attr("readonly","true");		
		}
	$(".main-body form.setvisit").submit(function(e){
	var url="savevisitdate.jsp";
	//var formData = new FormData($("#newPres"));		 
	e.preventDefault();

 	registerOldPatient(url);
	});		
		
		
	});

	function registerOldPatient(url){
		$.ajax({
		   type: "GET",
		   url: url,
		   data: $("form.setvisit").serialize(), 
		   success: function(data)
		   {
		   	//alert(data);
				//alert("Patient has been registered and visible in local patient queue.");
				$(".main-body").html(data);
				//window.location.reload();
				//window.location='displaymed.jsp?templateid=1&menuid=head1&dest=patientAlldata&id=<%=patid%>&ty=med&sl=&dt =';
		   },
		   error:function(erro)
		   {
				alert("ERROR");
			}
		});		
	}

	
</script>

<%
String action = "savevisitdate.jsp";
//<%=action
%>

<div id="oldpatreg-dialog" style="display: none" class="alert alert-warning" title="Already assigned" ><p><span class="glyphicon glyphicon-alert" style="float:left; margin:12px 12px 20px 0;"></span>This patient(<%=patid%>) is already assigned to <%=userinfo.getName(dataentry.getAssignDoc(patid))%>. Please remove the patient from the queue for a new visit. You may also visit the patient for viewing records.</p>
</div>

<FORM class="well setvisit" role="form" METHOD=Get ACTION="<%=action%>" name="setvisit">
<CENTER>
<div class="title"><label>Old Patient Re-visit</label></div>
<div><strong>Patient ID <strong></div> 
<div class="input-group">
	<span class="input-group-btn phy">
<%
	//out.println ("<B>&nbsp;Choose Physician </B><SELECT class='form-control' name=selphy WIDTH='140' STYLE='width: 140' >");
	out.println("<SELECT class='btn assign-doc' name='selphy' title='Choose Physician' ><Option class='btn' value=''>Choose Physician</Option>");
		
	try {
		//String cnd="type='doc' AND center='"+curCCode+"' ORDER BY name ASC";
		//Object res=rcui.getValues("rg_no,name",cnd);

		Object res=rcui.getAllUsers(cnfo.getCenterCode(patid,"med"),"doc","A");

		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			//out.println (temp.getValue("rg_no").trim()+"="+temp.getValue("name").trim());

			out.println ("<Option Value='"+temp.getValue("rg_no").trim()+"'>"+temp.getValue("name").trim()+"</OPTION>");
			//out.println ("<Option Value='"+regcode.trim()+"'>"+dname.trim()+"</OPTION>");
		}
	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
	out.println ("</SELECT>");
%>
	</span>
	<span class="input-group-addon" title="Patient name"><%=patname%></span>	
	<input class="form-control setvisit-input" type="text" name="pat_id" size="25" maxlength="20" value="<%=patid%>">
	<input class="form-control" placeholder="OPD ID" type="text" name="opd_id" />
</div>
<BR><BR><BR>


<table class="table" Border=0 style="border-collapse: collapse" bordercolor="#111111" cellspacing="0">
<tr>
	<td>
	<!--<input class="form-control btn-primary" type="submit" value="Submit" onclick="return Otherdt(document.med.dateofbirth.value,'<%=dat%>')" >-->
	<input class="form-control btn-primary btn-setvisit" type="submit" value="Submit" >
	</td>
</tr>
</table>

<BR><BR>
<!--<b><font color="#FF0000" size="4"><a href="localpatientsearch.jsp?cb=visit"> Search and Add to Patient Queue</a></font></b>-->

</center>
</FORM>
</body >
</html>
