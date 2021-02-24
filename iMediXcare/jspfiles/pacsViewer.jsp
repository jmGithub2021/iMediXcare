<%@page contentType="text/html"  import="imedix.rcDisplayData,imedix.dataobj,java.net.URLEncoder,imedix.myDate,imedix.projinfo,imedix.rcGenOperations,imedix.medinfo,imedix.PACSEncryption,imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*" %>

<%

rcDisplayData rd = new rcDisplayData(request.getRealPath("/"));
PACSEncryption penc = new PACSEncryption(request.getRealPath("/"));
projinfo pinfo=new projinfo(request.getRealPath("/"));
String pacsUrl = pinfo.PACSurl;
String uid = pinfo.PACSuid;
String pass = pinfo.PACSpass;
String viewerURL  = request.getParameter("url");
String studyUID = request.getParameter("studyUID");
String patid= request.getParameter("patid");
String date = request.getParameter("date");
rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));
medinfo minfo = new medinfo(request.getRealPath("/"));
String pat_name_query="trim(CONCAT(IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) as pat_name";
String patname="",sex="",age="",patdis="";
		Object res=rcGen.findRecords("med",pat_name_query+",class,sex","pat_id='"+patid+"'");
		Vector tmp = (Vector)res;
		dataobj temp = (dataobj) tmp.get(0);
		
		patname=temp.getValue("pat_name");
		patdis=temp.getValue("class");
		sex=minfo.getSexValues().getValue(temp.getValue("sex"));
					
		String cdat = myDate.getCurrentDate("ymd",true);				
		age=rcGen.getPatientAgeYMD(patid,cdat);

String createReportURL = pacsUrl+"ReportsExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
String createNoteURL = pacsUrl+"NotesExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
String viewReportURL = "", viewReportHTML="";
String viewNoteURL = "", viewNoteHTML="";
//out.println(createReportURL+"<br>");
//out.println(createNoteURL+"<br>");
if(rd.isReport(studyUID)){
	viewReportURL = pacsUrl+"ViewReportExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
	//viewReportHTML = "<a class='frameView pull-right' value='"+viewReportURL+"' target='_blank'>View Report</a>";
	viewReportHTML = "<a class='frameView pull-right' href='"+viewReportURL+"' target='_blank'>View Report</a>";
}
if(rd.isNote(studyUID)){
	viewNoteURL = pacsUrl+"ViewNotesExt.aspx?studyUID="+studyUID+"&uid="+penc.PACSEncryptionString(uid,pass)+"&pwd="+penc.PACSEncryptionString(uid,pass);
	//viewNoteHTML = "<a class='frameView pull-right' value='"+viewNoteURL+"' target='_blank'>View Note</a>";	
	viewNoteHTML = "<a class='frameView pull-right' href='"+viewNoteURL+"' target='_blank'>View Note</a>";	
}	

//out.println(rd.isReport(studyUID)+"<br>");
//out.println(rd.isNote(studyUID)+"<br>");


String testList = rd.activeStudyUID(patid,"");
String testListHTML = "";
//out.println(testList);
	try{
		Object jsobj=new JSONParser().parse(testList); 
		JSONObject jsonObject = (JSONObject)jsobj;
		int size = jsonObject.size()-1;
		for(int i=0;i<size;i++){
			String key = String.valueOf(i);
			JSONObject nestedObject = (JSONObject)jsonObject.get(key);	
			String status = (String)nestedObject.get("status");		
				//testListHTML += "<tr><td>"+(String)nestedObject.get("test_id")+"</td><td>"+(String)nestedObject.get("test_name")+"</td><td>"+(String)nestedObject.get("description")+"</td><td>"+(String)nestedObject.get("reffered_by")+"</td><td>"+(String)nestedObject.get("status")+"<a class='pacsView' target='_blank' href=pacsViewer.jsp?patid="+patid+"&date="+date+"&studyUID="+(String)nestedObject.get("studyUID")+"&url="+URLEncoder.encode(pacsUrl+"ShowViewerExt.aspx?StudyUID="+(String)nestedObject.get("studyUID")+"&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass),"UTF-8")+">View</a></td></tr>"; 			
				String entrydate = (String)nestedObject.get("entrydate");
				testListHTML += "<li class='list-group-item'><dt class='inline' title='"+entrydate+"'>"+entrydate.substring(0,10)+"</dt><dd class='inline pull-right'><a class='pacsView' title='"+(String)nestedObject.get("description")+"' href=pacsViewer.jsp?patid="+patid+"&studyUID="+(String)nestedObject.get("studyUID")+"&url="+URLEncoder.encode(pacsUrl+"ShowViewerExt.aspx?StudyUID="+(String)nestedObject.get("studyUID")+"&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass),"UTF-8")+">"+(String)nestedObject.get("test_name")+"</a><span style='margin-left:10px; padding:2px;border: 1px solid #d9edf7;'><a href='"+viewerURL+"' target='_blank'>View Images</a></span></dd></li>";	
		}
	}catch(Exception ex){out.println("error : \""+ex.toString()+"\"");} 
	
%>



<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/index.css">	
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js"></script>
</head>
<script>
$(document).ready(function(){
/*var loadUrl = "https://imedix.iitkgp.ac.in/PACS/ShowViewerExt.aspx?StudyUID=1.3.12.2.1107.5.2.10.17467.30000009070812353389000000001&uid=9vmxeQvy/Lk=&pwd=9vmxeQvy/Lk=";
	var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
	//	$("#pacsViewer").html(ajax_load).load(loadUrl);
	$("#pacsViewer").html(ajax_load);
	/*	$.get(loadUrl,function(data,status){
			$("#pacsViewer").html(data);
			});*/
	/*	$("#pacsViewer").css("min-height","100%");
		$("#pacsViewer").css("max-height","100%");*/
	
	
	$.ajaxSetup ({
			cache: false
		});	
		function clearPanel(url) {

			document.getElementById("pacsViewer").innerHTML= "<object class='responsive obj' type='text/html' data="+url+" style='width:100%; height:100%;'>> </object>";
			
	}	
	$(".frameView").click(function(){
		//console.log();
		clearPanel($(this).attr("value"));
		});
   $(".toggleBtn").click(function(){
        $(".toggleDiv").toggle("slide", {direction:'left'},400);
        $(this).toggleClass("byeSK");
		$(this).children("span").toggleClass("glyphicon-chevron-left",400).toggleClass("glyphicon-chevron-right",400)
		$(".pacsBody").toggleClass("fullWidth");
    });
		
});
	
	
	
	
</script>
<style>
.inline{display:inline;}
.viewerHomeicn{float:right;}
a:hover{    text-decoration: none;color: #0555d6;}
.fullWidth{width:100%;transition-property: width;transition-delay: 0.4s;transition-duration: 0.5s;left:0;float:right;margin-top:-1px;}
.leftpacsViewerDiv{position: relative;}
.byeSK{left:0px;right:auto !important;background: #bddcfb;}
.toggleBtn{
	position: absolute;
    top: 40%;
    right: -8px;
    padding: 8px 4px;
    border: 1px solid;
    border-color: #8acdf7;
	z-index: 9999;
}
.leftpacsViewerDiv .toggleDiv .frameView:hover{
   /* border: 1px solid #c9b29c;
    padding: 2px 2px;
    border-radius: 2px;*/
	box-shadow: 0px 1px 1px 1px #d9edf7;
}

</style>
<body>
	<div class="container-fluid">
			
		<div class="row">
			<div class="col-sm-3 leftpacsViewerDiv">
			<a class="toggleBtn"><span class="glyphicon glyphicon-chevron-left"></span></a>
			<div class="toggleDiv" >
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">Patient Summary <a class="frameView viewerHomeicn" value="<%=viewerURL%>" ><span class="glyphicon glyphicon-home"></span></a></h3>
					</div>
					<div class="panel-body">
					
					<ul class="list-group">
						<li class="list-group-item"><dt class="inline">NAME : </dt><dd class="inline"><%=patname%></dd></li>
						<li class="list-group-item"><dt class="inline">AGE : </dt><dd class="inline"><%=age%></dd></li>        
						<li class="list-group-item"><dt class="inline">SEX : </dt><dd class="inline"><%=sex%></dd></li>
						<li class="list-group-item"><dt class="inline">CLASS : </dt><dd class="inline"><%=patdis%></dd></li>
					</ul>		
					</div>
					<ul class="list-group">
						<!--<li class="list-group-item"><a class="frameView" value="<%=createReportURL%>" target="_blank">Create Report</a><%=viewReportHTML%></li>
						<li class="list-group-item"><a class="frameView" value="<%=createNoteURL%>" target="_blank">Create Note</a><%=viewNoteHTML%></li>  -->      
						<li class="list-group-item"><a class="frameView" href="<%=viewerURL%>" target="_blank">View Images</a></li>
						<li class="list-group-item"><a class="frameView" href="<%=createReportURL%>" target="_blank">Create Report</a><%=viewReportHTML%></li>
						<li class="list-group-item"><a class="frameView" href="<%=createNoteURL%>" target="_blank">Create Note</a><%=viewNoteHTML%></li>
					</ul>
				</div>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">Load Other Test</h3>
					</div>
					<div class="panel-body">
					<ul class="list-group">
						<%=testListHTML%>
					</ul>
					</div>
				</div>
			</div>	
			</div>
			<div class="col-sm-9 pacsBody" id="pacsViewer">
			<!--<iframe width="100%" height="100%" src="<%=viewerURL%>"></iframe>-->
			</div>
		</div>
	</div>
</body>
</html>
