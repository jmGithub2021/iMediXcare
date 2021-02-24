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
	String test_id=request.getParameter("test_id").trim();
	//out.println("<p>"+j+"</p>");
	boolean res=rd.existsHEXResult(test_id);
	out.println("<p>"+res+"</p>");
	

%>
<script type="text/javascript">
console.log("<%=test_id%>"+":"+"<%=res%>");

</script>