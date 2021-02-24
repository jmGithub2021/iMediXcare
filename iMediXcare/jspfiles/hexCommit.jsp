<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.rcPatqueueInfo,imedix.cook,imedix.dataobj, imedix.myDate ,java.util.*,java.io.*,imedix.Decryptcenter,imedix.rcDataEntryFrm"%>
<%@page contentType="text/html" import= "javax.servlet.*,imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*,java.io.FileReader,java.io.IOException"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%@page contentType="text/html" import= "imedix.projinfo,imedix.rcDataEntryFrm,java.net.URLConnection,javax.net.ssl.*,java.text.*,imedix.rcDisplayData,java.io.*,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray,java.nio.charset.Charset,java.io.BufferedReader,java.io.IOException ,java.io.InputStreamReader,java.io.OutputStream,java.net.HttpURLConnection,java.net.MalformedURLException,java.net.URL,java.net.*"%>

<%


	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcDataEntryFrm rd = new rcDataEntryFrm(request.getRealPath("/"));
	rcDisplayData rdd = new rcDisplayData(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	rcDataEntryFrm rde = new rcDataEntryFrm(request.getRealPath("/"));
	String path = request.getRealPath("/");
	String j=request.getParameter("json").trim();
	//out.println("<p>"+j+"</p>");
	
	
	JSONObject json;
	JSONParser parser = new JSONParser();
	json=(JSONObject) parser.parse(request.getParameter("json").trim());


	//out.println(json);
	String test_id=(String)json.get("testId");
	//String pat_id=(String)json.get("");
	String test_desc=(String)json.get("testDesc");
	String test_result=(String)json.get("testResult");
	String dateTime=(String)json.get("dateTime");
	dateTime=dateTime.substring(0,dateTime.length()-3);
	//out.println("<p>"+test_id+","+test_desc+","+test_result+","+dateTime+"</p>");
	
	String iMedList="";
	
	boolean res=rd.existsHEXResult(test_id);
	//out.println("<p>"+res+"</p>");
	if(!res)
	{
		boolean result=rd.insertHEXResult(test_id,test_desc,dateTime,test_result);
		if(result)
			out.println("<p>Record Inserted</p>");
		else
			out.println("<p>Record Insertion Failure</p>");
	}
	else
	{
		out.println("<p>Record already Exists</p>");
	}
	

	

	/*
	boolean result=rd.updatePacsStudyUID(iMedId,studyUid);
	if(result)
		out.println("Update Successful");
	else
		out.println("Update not Successful");

	//We have to return iMedId to pax
	*/	



%>
