<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,imedix.rcCentreInfo,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	
	cook cookx = new cook();
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cnfo = new rcCentreInfo(request.getRealPath("/"));
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
	//out.println("dddddddddddd : "+patid.substring(0,4));
	
	

 
%>

<HTML>
<link rel="stylesheet" href="../style/style1.css" type="text/css" media="screen" />

<HEAD>
<TITLE>PATIENTS DATA-MED FORM....
</TITLE>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

</HEAD>
<style>
.assign-doc{padding:7px 12px;background: #ddd;}
.setvisit span.phy{
	border: 1px solid #ccc;
    box-shadow: 0px 0px 1px 0px #ccc;
}
</style>
<script>
	$(document).ready(function(){
		$(".setvisit-input").focus();
		if($(".setvisit-input").val().length>0){
			$(".setvisit-input").attr("readonly","true");		
		}
		
		
	$(".main-body form.setvisit").submit(function(e){
	var url="savevisitdate.jsp";
	//var formData = new FormData($("#newPres"));		 
	e.preventDefault();
	$.ajax({
		   type: "GET",
		   url: url,
		   data: $("form.setvisit").serialize(), 
		   success: function(data)
		   {
				//alert("Patient has been registered and visible in local patient queue.");
				$(".main-body").html("<div style='color:blue;padding:10px;font-size:18px'>Patient has been registered and visible in local patient queue.</div>");
				//window.location.reload();
				//window.location='displaymed.jsp?templateid=1&menuid=head1&dest=patientAlldata&id=<%=patid%>&ty=med&sl=&dt =';
		   },
		   error:function(erro)
		   {
				alert("ERROR");
			}
		 });
 
	});		
		
		
	});


	
</script>

<%
String action = "savevisitdate.jsp";
//<%=action
%>
<FORM class="well setvisit" role="form" METHOD=Get ACTION="<%=action%>" name="setvisit" >
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
	<input class="form-control btn-primary" type="submit" value="Submit" >
	</td>
</tr>
</table>

<BR><BR>
<!--<b><font color="#FF0000" size="4"><a href="localpatientsearch.jsp?cb=visit"> Search and Add to Patient Queue</a></font></b>-->

</center>
</FORM>
</body >
</html>
