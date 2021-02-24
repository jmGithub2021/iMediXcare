<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id,dat="",cen="";
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	cen = cookx.getCookieValue("center",request.getCookies());
	//out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + id + "</B></FONT><BR>");
	dat = myDate.getCurrentDate("dmy",false);
	long timestamp = new Date().getTime();
%>

<HTML>
<HEAD>


<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<!--
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
-->
   
	<TITLE>Provisional Diagnosis</TITLE>
<!--<link rel="stylesheet" type="text/css" href="../style/style2.css">-->
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.jsp">
var putdate,putmonth,putyear;
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
function datentry(){
dateentry();
document.a14.entrydate.value=putdate+putmonth+putyear;
}

$("#compReport").change(function(){
	$(".fileName-msg").html(this.files[0].name);
	
});

$("form.a14-report").submit(function(e){
	var url = "../jspfiles/a14_report_upload.jsp";
	e.preventDefault();
	$.ajax({
			type:"POST",
			url:url,
			data:new FormData(this),
			processData: false,
            contentType: false,
            cache: false,
			success:function(data){
				//alert(data.trim());
				if(data.trim().length>0){
					$(".fileName-timestamp").html("<INPUT type=hidden name='report_link' value='"+data.trim()+"' hidden/>");
				}
				$("form.a14").submit();
				},
			error:function(error){alert("File could not be submited !");}
		
		});
});


	$("form.a14").submit(function(e){
	var url="../jspfiles/savefrm.jsp";
	//var formData = new FormData($("#newPres"));		 
	e.preventDefault();
	$.ajax({
		   type: "POST",
		   url: url,
		   data: $(".add-comp form").serialize(), 
		   success: function(data)
		   {
				alert("done");
				$('#add_comp').modal('toggle');	
				$(".modal-backdrop").remove();	
				$("input[name='report_link']").remove();				
				var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
				$(".main-body").html(ajax_load).load("patientAlldata.jsp?id=<%=id%>");
		   },
		   error:function(erro)
		   {
				alert("From could not be submited !");
			}
		 });
 
	});

	
</SCRIPT>
<style>
.comp-upload-div{
	border: 1px solid #ddd;
    padding: 4px 12px;
    border-radius: 4px;
	position: absolute;
    top: -50px;
    right: 50px;
}
.upload-btn{margin:auto;display:block;}
.comp-upload-div label{padding:5px;margin:0px;}
.comp-upload-span{
	border: 1px solid #ddd;
    padding: 4px 12px;
    font-size: 20px;
    border-radius: 20px;
    color: #4a93ea;
    background: #e1e7ef;
    cursor: pointer;
}
input[name="compReport"]{
    position: absolute;
    top: 0;
    left: 0px;
    float: right;
    width: 60px;
    opacity: 0;
    display: inline-block;
    overflow: hidden;
}
.fileName-msg{color:#4a93ea;}
</style>
</HEAD>
<BODY onload='datentry();'>
<div class="container-fluid">

<TABLE class='tableb table table-bordered'>
<TR><TD>
<FORM class="a14" role="form" METHOD=post ACTION="../jspfiles/savefrm.jsp" name="a14">
<INPUT TYPE="hidden" name="frmnam" value="a14" >
<INPUT TYPE="hidden" name="pat_id" value="<%=id%>">

	<fieldset color=#66CCFF><legend><FONT SIZE="4"COLOR="RED"><b>Chief Complaints<B></FONT></legend>

	<TABLE class="table">
		<TR>
		<TD>1.</TD>
		<TD><INPUT class="form-control" NAME=comp1 maxlength=150 style="min-width:100px;" required></INPUT></TD>
		<TD><FONT SIZE="3"COLOR="blue">Duration</FONT></TD>
		<TD><INPUT class="form-control" NAME=dur1 maxlength=50 onblur='checkintObj(this);' style="min-width:100px;" required></INPUT></TD>
		<TD>
		<SELECT class="form-control" NAME=hdmy1 style="min-width:100px;" required>
			<OPTION value="months" selected>months</OPTION>
			<OPTION value="weeks">weeks</OPTION>
			<OPTION value="days">days</OPTION>
			<OPTION value="hours">hours</OPTION>
		</SELECT>
		</TD>
	    </TR>

		<TR>
		<TD>2.</TD>
		<TD><INPUT class="form-control" NAME=comp2 maxlength=150 style="min-width:100px;"></INPUT></TD>
		<TD><FONT SIZE="3"COLOR="blue">Duration</FONT></TD>
		<TD><INPUT class="form-control" NAME=dur2 maxlength=50 onblur='checkintObj(this);' style="min-width:100px;"></INPUT></TD>
		<TD>
		<SELECT class="form-control" NAME=hdmy2 style="min-width:100px;">
			<OPTION value="months" selected>months</OPTION>
			<OPTION value="weeks">weeks</OPTION>
			<OPTION value="days">days</OPTION>
			<OPTION value="hours">hours</OPTION>
		</SELECT>
		</TD>
		</TR>

		<TR>
		<TD>3.</TD><TD><INPUT class="form-control" NAME=comp3 maxlength=150 style="min-width:100px;"></INPUT></TD>
		<TD><FONT SIZE="3"COLOR="blue">Duration</FONT></TD>
		<TD><INPUT class="form-control" NAME=dur3 maxlength=50 onblur='checkintObj(this);' style="min-width:100px;"></INPUT></TD>
		<TD>
		<SELECT class="form-control" NAME=hdmy3 style="min-width:100px;">
			<OPTION value="months" selected>months</OPTION>
			<OPTION value="weeks">weeks</OPTION>
			<OPTION value="days">days</OPTION>
			<OPTION value="hours">hours</OPTION>
		</SELECT>
		</TD>
		</TR>
	</TABLE>
	</fieldset> 

	
	<fieldset><legend><FONT SIZE="4"COLOR="RED"><b>History of Present Illness<B></FONT></legend>
	<TABLE class="table">
		<TR>
		<TD valign=middle><FONT SIZE="3" COLOR="blue">Records here:</font></TD>
		<TD><TEXTAREA class="form-control" onkeypress="return txtlength(this,300)" onblur=chkpest(this,300) name=rh wrap=virtual cols=50 rows=7></TEXTAREA></TD>
		</TR>
	</TABLE>
	</fieldset>


<TABLE class="table">
<TR>
 <TD>Test date</TD><TD><INPUT class="form-control" id="testdate" NAME="testdate"  value=<%=dat%> maxlength=8></INPUT></TD>

<TD><INPUT type=hidden name=entrydate></INPUT><span class="fileName-timestamp"></span>
<INPUT class="btn btn-primary" type="hidden" value="Submit" onclick="return testdt(document.a14.testdate.value,'<%=dat%>')" style="background-color: '#D3CEC9'; color: '#000000'; font-weight:BOLD; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--<INPUT class="btn btn-warning" type="reset" value="Reset" style="background-color: '#D3CEC9'; color: '#000000'; font-weight:BOLD; ">--></TD>
</TR>
</TABLE>
</FORM>
<form class="a14-report" enctype="multipart/form-data" name="a14-report">
	
	<div class="comp-upload-div pull-right"><span class="fileName-msg"></span><label>Upload File : </label><span class="comp-upload-span glyphicon glyphicon-upload pull-right"><input type="file" name="compReport" id="compReport" /></span></div>
<input class="btn btn-primary upload-btn" type="submit" name="submit" value="Submit" />
</form>
</td></tr>
</table>

</div>		<!-- "container-fluid" -->
</BODY>
</HTML>
