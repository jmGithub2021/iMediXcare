<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.cook,imedix.dataobj, imedix.myDate ,java.util.*,java.io.*,imedix.Decryptcenter"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	
	cook cookx = new cook();
	Decryptcenter imc = new Decryptcenter();

	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	String  referring_doc,ccode="";
	ccode =cookx.getCookieValue("center", request.getCookies ());
	String dat = myDate.getCurrentDate("dmy",false);
	String cName="";
	if(ccode.equalsIgnoreCase("XXXX")) cName="All Hospitals" ;
	else cName=cinfo.getHosName(ccode);


%>

<HTML>
<HEAD>
<TITLE>DOCTOR LIST....</TITLE>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<!--<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>-->



<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.js"> </SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script2.js"> </SCRIPT>
</head>

<body>
<div class="container-fluid"><br>
<CENTER><B>
<FONT  SIZE='+2' COLOR='#3300CC'>List of Doctors : &nbsp; <%=cName%>
</font>

<BR> <FONT COLOR='#3300CC'>(Click on <FONT  COLOR='#FF00CC'></FONT>
<FONT COLOR='RED'>Doctor Name </FONT> <FONT COLOR='#3300CC'>to proceed)</FONT>

<FONT > <BR> Download Consent Form: 
	<a href='../consentform/banglaversion.pdf' class="text-info">Bengali Version</a>&nbsp;
	<a href='../consentform/englishversion.pdf' class="text-info">English Version </a> </FONT></B>
</CENTER><hr>



<%
	try{
	String pvCode="", validity = "";
		Object res=rcui.getAllUsers(ccode,"doc","A");
        if(res instanceof String){
			out.println(res);
		}else{
			Vector Vtmp = (Vector)res;
			//out.println("Vtmp.size()"+Vtmp.size()+"<br>");

			for(int i=0;i<Vtmp.size();i++){

				dataobj tempdata = (dataobj) Vtmp.get(i);	
				
				String stCode=tempdata.getValue("center");
				String cname=tempdata.getValue(10);
				String rg_no=tempdata.getValue("rg_no");
				String visibility = tempdata.getValue("visibility").trim();
				String expdate = imc.decryptLicString(  tempdata.getValue("expdate") );
				java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
				java.util.Date today = new java.util.Date();
				long timeDiff = expDate.getTime() - today.getTime();
				long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
				if (daysDiff<15) validity = " ( <font color='red'>Valid for another <b>" + daysDiff + "</b> day(s) only </font> ) " ;
				else validity = "";
				if (visibility.equalsIgnoreCase("Y")) {
					if(!stCode.equalsIgnoreCase(pvCode)){
						 if(i>0) out.println("</div><div class='panel panel-info'><div class='panel-heading'>" + cname + validity + "</div>");
						 else out.println("<div class='panel panel-info'><div class='panel-heading'>" + cname + validity + "</div>");	
						pvCode=stCode;
					} 
					out.println("<div class='list-group'><a href='../forms/med1.jsp?doc_id="+rg_no+ "' class='list-group-item' >");
					out.println("Doctor Name : <strong style='color:blue'>"+tempdata.getValue(1) + "</strong>&nbsp;&nbsp;<span class='mark'>" +rcui.getSpecialization(rg_no)+"</span></A></div>");
					//out.println("");
				}
			 }
			 out.println("</div>");
		}
}catch(Exception e){
	out.println(e);
}

%>



</div>		<!-- "container-fluid" -->
</body>
</html>
