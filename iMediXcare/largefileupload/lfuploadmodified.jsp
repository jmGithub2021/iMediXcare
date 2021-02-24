<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj, imedix.cook,java.util.*, imedix.myDate" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%	
	cook cookx=new cook();
	projinfo pinfo = new projinfo(request.getRealPath("/"));
	String user  = cookx.getCookieValue("userid", request.getCookies ());
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String pid = cookx.getCookieValue("patid", request.getCookies());
	String cdate=myDate.getCurrentDate("dmy",false);
	String ccdate = cdate.substring(0,2)+"-"+cdate.substring(2,4)+"-"+cdate.substring(4);
	 
	String currdate=myDate.getCurrentDate("ymd",true);
	//out.println("Currdate : "+currdate);
%>




<html>
	<style>
		
		table{border-color:#eee}
		input#myfile{background-color:white}
		form#lfuploadform{background-color:white}
	</style>
<head>

<script src="JS/main.js" ></script>
<script src="JS/jqueryform.js" ></script>
<script src="JS/fileUploadScript.js" ></script>
<!-- Include css styles here -->
<link href="style20.css" rel="stylesheet" type="text/css" />
</head>

<script>
	function filecheck()
	{
		var file1=document.getElementById("myfile").value;
		var n = file1.lastIndexOf(".");
		if(file1==""||file1==null)
		{
			alert("Choose a file");
		return false;
		}
		else if(n=='-1'||n<0){
		alert("File extension not found !");
		return false;
		}
		else{stream();}
	}

	function check()
	{
	//document.getElementById("getfile").value=document.getElementById("myfile").value.replace(/^.*[\\\/]/, '');
	document.getElementById("ext").value=document.getElementById('myfile').value;
	var sizeinbytes = document.getElementById('myfile').files[0].size;
	var sizekb=sizeinbytes/1024;
	if(sizekb>=990) 
	document.getElementById("fsize").innerHTML=(sizekb/1024).toFixed(2)+" MB";
	else
	document.getElementById("fsize").innerHTML=sizekb.toFixed(2)+" KB";
	}
	
	function desc()
	{
	var des=document.getElementById("fdes").value;
	document.getElementById("des").value=des;
	document.getElementById("lname").value = document.getElementById("tempLname").value;
	document.getElementById("docName").value = document.getElementById("tempDname").value;
	}
	function filetype()
	{	
	var filtype=document.getElementById("type").value;
	document.getElementById("ftype").value=filtype;
	}
	function stream(){
		
		var pid = "<%=pid%>";
		var ftype = $("#ftype").val();
		var desc = $("#fdes").val();
		var lname = $("#tempLname").val();
		var doc_name = $("#tempDname").val();
		var file = $("#ext").val();
		var ext = file.substring(file.lastIndexOf(".")+1);
		var d = new Date("<%=currdate%>");
		$("#stream").val(pid+"&"+ftype+"&"+desc+"&"+lname+"&"+doc_name+"&"+"<%=currdate%>".toString()+"&"+"<%=cdate%>".toString()+"&"+ext);
	//	console.log(pid+"&"+ftype+"&"+desc+"&"+lname+"&"+doc_name+"&"+"<%=currdate%>".toString()+"&"+"<%=cdate%>".toString()+"&"+ext);
		
	}	
	</script>

<body>

 <form id="UploadForm"  action="UploadFile.jsp" method="post" onsubmit="return filecheck()" enctype="multipart/form-data">
	 
	 <table border="1">
		<tr><td colspan="2"><input onChange="check()" type="file" size="60" id="myfile" name="myfile"></td></tr>
		<tr><td><label>File Size : </label></td><td><label id="fsize"></label></td></tr>
		<tr><td><label>Patient : </label><label><%=pid%></label></td><td><label>Description : </label><input id="fdes" type="text" maxlength="30" onkeyup="desc()"></input></td></tr>
		<tr><td><label>Doctor Name: </label><label><input type="text" id="tempDname" onkeyup="desc()" /></label></td><td><label>Laboratory Name: </label><label><input type="text" id="tempLname" onkeyup="desc()" /></label></td></tr>
		<tr><td>
			<select name="type" id="type" onChange="filetype()">
				<option value="BLD">Blood Slides </option>
				<option value="CTS">CT Scan </option>
				<!--<option value="DCM">Dicom Files</option> -->
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
		</td><td><label>Test Date : </label><label id="prntftype"><%=ccdate%></label></td></tr>
		<tr><td colspan="2">
       <div id="progressbox">
         <div id="progressbar"></div>
         <div id="percent">Progress status</div>
       </div>
       </tr></td>
 <br />
<tr><td colspan="2"><div id="message"></div></tr></td>

</table>
<br>
<input type="submit" value="Upload"><br>
</form>


<input type="hidden" id="ftype" value="BLD" name="ftype" />
<input type="hidden" id="des" name="desc" />
<input type="hidden" id="lname" name="lname" />
<input type="hidden" id="docName" name="docName" />
<input type="hidden" id="ext" name="ext" />


<form id="lfuploadform" action="/iMediXcare/servlet/largefileupload" method="POST" >
<input type="hidden" id="stream" name="stream" value="stream">
</form>

</body>
</html>
