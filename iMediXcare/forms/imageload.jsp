<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*,java.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id,dat="",cen="";
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	cen = cookx.getCookieValue("center",request.getCookies());
	//out.print("&nbsp;<B><BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + System.getProperty("os.name")+ "</B></FONT><BR>");
	dat = myDate.getCurrentDate("dmy",false);
	
%>
<!DOCTYPE html>
<HTML>
<head>   

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>File Uploading</title>
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<!--	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap-filestyle.min.js"></script>-->


<link rel="stylesheet" type="text/css" href="../style/style2.css">
<!--<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script2.js"></SCRIPT>-->
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/chdateformat.js"/></SCRIPT>
<script>
function drop_evt(evt) {
	evt.preventDefault();
	document.getElementById("smallFile").files = evt.dataTransfer.files;
	document.getElementById("drop_div").innerHTML = evt.dataTransfer.files[0].name;
}
function dragOver_evt(evt) {
  evt.preventDefault();
} 
function setvalues() {
	document.imgld.desc.value = document.imgld.type.value + " File";
}
function datentry(){
	document.imgld.entrydate.value=GetMysqlCurrDateTime();
}

function MM_displayStatusMsg(msgStr) { //v1.0
  status=msgStr;
  document.MM_returnValue = true;
}
//-->

function fileCheck(){ 	
	if(document.getElementById('smallFile').value=="" || document.getElementById('smallFile').value == null){
		alert("Choose a file");
		return false;
	}
	return true;
}

function fileSizeCheck(){
	var sizeinbytes = document.getElementById('smallFile').files[0].size;
	var sizekb=sizeinbytes/1024;
	if(sizekb>=990){ 
		document.getElementById("fileSize").innerHTML=(sizekb/1024).toFixed(2)+" MB";
		let mb = Math.floor((sizekb/1024));
		if(mb > 9){
			document.getElementById('smallFile').value="";
			document.getElementById("fileSize").innerHTML = "Please upload less then 10 mb file";
			}
	}
	else{
		document.getElementById("fileSize").innerHTML=sizekb.toFixed(2)+" KB";
	}
} 
function fileTypeChk(fTyps){
	var file = document.getElementById('smallFile').files[0].name;
	var fileExt = file.substring(file.lastIndexOf(".")+1,file.length);
	var obj = {
		"BLD":["png","jpeg","jpg","bmp"],
		"CTS":["png","jpeg","jpg","bmp"],
		"DCM":["dcm"],
		"DOC":["doc","docx","pdf","txt"],
		"EEG":["png","jpeg","jpg","bmp"],
		"MRI":["png","jpeg","jpg","bmp"],
		"MOV":["mp4","avi","mov","wmv"],
		"SEG":["png","jpeg","jpg","bmp"],
		"SKP":["png","jpeg","jpg","bmp"],
		"SNG":["png","jpeg","jpg","bmp"],
		"SND":["mp3","wav"],
		"TEG":["txt"],
		"XRA":["png","jpeg","jpg","bmp"],
		"OTH":["png","jpeg","jpg","bmp"]
		}
			if(obj[fTyps].indexOf(fileExt.toLowerCase())>=0){
				return true;
			}
			else{
				alert("Supported file is ["+obj[fTyps]+"]");
				return false;
			}
}
$(document).ready(function(){
	$("select[name=type]").change(function(){
		fileTypeChk(this.value);
	});
});
				

</script>

<style>
.input-group-addon{
	min-width:13.2rem;
	}
.drop-div{
	border:1px solid black;
	height:100px;	
	position: relative;
}	
#smallFile{
	position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
}
</style>

</head>
<BODY background= "../images/pagebg.jpg" onload='datentry();' >
<div class="container-fluid">

<BR><BR>

<center>
<div class="row">
<div class="col-sm-1"></div>

<div class="col-sm-10 tableb">
<BLOCKQUOTE>
<!-- <FONT SIZE="+2" >Image load</FONT> -->
<CENTER><U><FONT SIZE="+2" > File Upload </FONT></U></CENTER>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="../servlet/uploadfilehttp" name="imgld"  onsubmit="return testdt(document.imgld.testdate.value,'<%=dat%>')">
<!-- hardcoded url -->
  <INPUT TYPE="hidden" name="pat_id" value="<%=id%>">

<div class="drop-div" id="drop_div" ondrop = "drop_evt(event);" ondragover="dragOver_evt(event);" >
   Drop Here
   <input type="file" NAME="userfile" onChange="fileSizeCheck()" onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')" onMouseOut="MM_displayStatusMsg(' ')" class="filestyle" id="smallFile" />
</div>
   <!--<INPUT TYPE=file NAME=userfile size=53 onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')" onMouseOut="MM_displayStatusMsg(' ')">-->
<br/>
<div class="input-group">
	<span class="input-group-addon">Description:</span> 
<INPUT class="form-control" NAME="imgdesc" Size=53 Maxlength=300 onMouseOver="MM_displayStatusMsg('type very short description of the file')" onMouseOut="MM_displayStatusMsg(' ')">
</div>

<div class="input-group">
	<span class="input-group-addon">Laboratory Name : </span> 
	<INPUT  class="form-control" TYPE=textbox NAME=lab_name />
</div>

	
<div class="input-group">
	<span class="input-group-addon">Doctor Name : </span>  
	<INPUT class="form-control" TYPE=textbox NAME=doc_name>
</div>	

		
<div class="input-group">
	<span class="input-group-addon">File type: </span>
   <select class="form-control" name=type ><!-- OnClick="setvalues();" -->
				<option value="BLD">Blood Slides </option>
				<option value="CTS">CT Scan </option>
				<option value="DCM">Dicom Files</option>
				<option value="DOC">Documents</option>
				<option value="EEG">EEG </option>
				<option value="MRI">MRI</option>
				<option value="MOV">Movie Files</option>
				<option value="SEG">Scanned ECG </option>
				<option value="SKP">Scanned Skin Patch </option>
				<option value="SNG">Sonograms</option>
				<option value="SND">Sound Files</option>
				<option value="TEG">Text ECG </option>
				<option value="XRA">X-Ray </option>
	            <option value="OTH">Others</option>
   </select>
</div>   
   

<input type=hidden name=entrydate>
<div class="input-group">
	<span class="input-group-addon">Date Of Test:</span>
	<input class="form-control" id="testdate" name=testdate size=8 maxlength=8 onblur='chkdt(this);' />
</div>


	<BR>
	<BR>
	<center><input class="btn btn-primary" type="submit" value="Upload" onclick="return fileCheck()" style="background-color: '#FFE0C1'; color: '#000000'; font-weight:BOLD; font-style:oblique "></CENTER>

</FORM>
</BLOCKQUOTE>
</div>		<!-- "col-sm-10" -->

<div class="col-sm-1"></div>

</div>		<!-- "row" -->

</center>
</div>		<!-- "container-fluid" -->
</body>

</HTML>
