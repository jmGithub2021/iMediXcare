<%@page contentType="text/html" import="imedix.projinfo,java.io.*,java.util.*,imedix.PACSEncryption,imedix.cook,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
String clientOrigin = request.getHeader("origin");
out.println(clientOrigin);
response.setHeader("Access-Control-Allow-Origin", "10.*.*.*");
response.setHeader("Access-Control-Allow-Methods", "POST");
response.setHeader("Access-Control-Allow-Headers", "Content-Type");
response.setHeader("Access-Control-Max-Age", "86400");
String path = request.getRealPath("/");
PACSEncryption penc = new PACSEncryption(path);
projinfo pinfo=new projinfo(path);
String uid = pinfo.PACSuid;
String pass = pinfo.PACSpass;
String PACSurl = (pinfo.PACSurl);
//out.println(penc.PACSEncryptionString(uid,pass));
String showViewExt = "http://10.5.29.87:2015/ShowViewerExt.aspx?StudyUID=1.3.12.2.1107.5.2.10.17467.30000009041405495870300000001" + "&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass);
String viewReport = "http://10.5.29.87:2015/ViewReportExt.aspx?StudyUID=1.3.12.2.1107.5.2.10.17467.30000009041405495870300000007"  + "&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass);
String viewNotes = "http://10.5.29.87:2015/ViewNotesExt.aspx?StudyUID=1.3.12.2.1107.5.2.10.17467.30000009041405495870300000007" + "&uid=" + penc.PACSEncryptionString(uid,pass) + "&pwd=" + penc.PACSEncryptionString(uid,pass);
String tt = "http://10.5.29.87:2015/ViewNotesExt.aspx?StudyUID=1.3.12.2.1107.5.2.10.17467.30000009041405495870300000007&uid=9vmxeQvy/Lk=&pwd=9vmxeQvy/Lk=";
%>

<%!
public String pacsView(String pacsURL){
	String result = "";
		try{
			String type = "text/html";
			//String serviceURL = (pinfo.PACSServiceURL);
			URL url = new URL(pacsURL);
			HttpURLConnection httpCon = (HttpURLConnection) url.openConnection();
			httpCon.setDoOutput(true);
			httpCon.setRequestMethod("GET");
			httpCon.setRequestProperty( "Content-Type", type);
			BufferedReader br = new BufferedReader(new InputStreamReader(httpCon.getInputStream())); 
				String output="";
			while ((output = br.readLine()) != null) {
				result += output;
			}	

			
		}catch(Exception ex){result = ex.toString();}
		return result;
}
			
%>

<html>
<head><title>
	TeleRad : View Image
</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<link href="<%=PACSurl%>/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%=PACSurl%>/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link href="<%=PACSurl%>/css/font_family_Open_Sans.css" rel="stylesheet" />
<link href="<%=PACSurl%>/css/font-awesome.css" rel="stylesheet" />
<link href="<%=PACSurl%>/css/style.css" rel="stylesheet" />
<link href="<%=PACSurl%>/css/pages/dashboard.css" rel="stylesheet" />
<link rel="shortcut icon" href="<%=PACSurl%>/img/TeleIcon.png" />


    <script src="<%=PACSurl%>/Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="<%=PACSurl%>/Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="<%=PACSurl%>/Scripts/jquery-ui.js" type="text/javascript"></script>
    <link href="<%=PACSurl%>/css/jqueryui-1.8.1-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=PACSurl%>/Scripts/jquery-1.4.2-jquery.min.js"></script>
    <script type="text/javascript" src="<%=PACSurl%>/Scripts/jqueryui-1.8.1-jquery-ui.min.js"></script>

    <script src="<%=PACSurl%>/js/jquery-1.7.2.min.js"></script>
    <script src="<%=PACSurl%>/js/bootstrap.js"></script>

	
</head>
	<script>
	$(document).ready(function(){
		//jQuery.support.cors = true;
	$.ajax({
		async: false,
		crossDomain: true,
        type: "GET",
        url: "<%=viewReport%>",
//data: '',
        contentType: "application/json; charset=utf-8",
        dataType: "jsonp",
        success: function (result) { $(document).body(result); }
    });
	});
	</script>


<%
//out.println("GGGG : "+pacsView(tt));
%>
<html>
<body>
<div class="">
<button >View Report</button>
</div>
<div class="">

<!--<iframe width="100%" height="100%"></iframe>-->
</div>
<!--<div class="">
<iframe src="<%=viewReport%>" width="100%" height="100%"></iframe>
</div>
<div class="">
<iframe src="<%=viewNotes%>" width="100%" height="100%"></iframe>
</div>-->
<div class="">
</div>
<div class="">
</div>
</body>
</html>
