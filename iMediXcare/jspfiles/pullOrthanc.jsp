<%@page  contentType="text/html" import="imedix.rcDataEntryFrm,imedix.dataobj,imedix.cook,java.util.*,java.io.*,java.lang.*,java.sql.*,javax.servlet.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
// surajit Kundu @ 06/08/2015
%>

<style>
tr.table1:nth-child(even){ background-color: #B0C4DE ;color:blue;font-size:12px}
tr.table1:nth-child(odd){background-color:#F0F8FF;color: 000066 ;font-size:12px}
tr.table2{background-color:00CCFF;color:#00FF7F}
div#wd{color:#FF4500}
</style>

<script>
function zoomimage()
{
	var wd = document.getElementById("wadid").innerHTML;
 
document.getElementById("wadoid").value=wd;
}
</script>


<%
	cook cookx = new cook();
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String userid =cookx.getCookieValue("userid", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());

	dataobj obj = new dataobj();
	String wadoid=request.getParameter("id");
out.print("<div id='wd' >WADOID : ");
	out.print("<sa id='wadid'  style='color:Blue'>"+wadoid+"</sa>");
out.print("</div>");
String Srv = "http://" + request.getServerName() + ":" + request.getServerPort();
String Srv1=Srv.replace(":8080",":8042");
	//out.print("Location of Orthanc : "+Srv);
try{
	String s = null, cmdOut=null, imgSrc=null, s1=null,cmdOut1=null;
	
	String cmd = "curl "+Srv1+"/instances/" + wadoid + "/simplified-tags";
	String cmd1 = "curl "+Srv1+"/instances/"+ wadoid + "/";
	imgSrc = "<img src='"+Srv1+"/instances/" + wadoid + "/preview' alt='Not supported'>"; 
	
	
	Process p1 = Runtime.getRuntime().exec(cmd1);
		BufferedReader stdInput1 = new BufferedReader(new InputStreamReader(p1.getInputStream()));
		BufferedReader stdError1 = new BufferedReader(new InputStreamReader(p1.getErrorStream()));

		// read the output from the command
		System.out.println("Here is the standard output of the command:\n");
		while ((s1 = stdInput1.readLine()) != null) {
			cmdOut1 += s1;
			//out.println(s);
		}
		 
		//cmdOut=cmdOut.replace(""{", "");
		//cmdOut=cmdOut.replace("}", "").trim();
		//cmdOut=cmdOut.replace("\"", "").trim();
		//cmdOut=cmdOut.trim();
		String JOBJs1[] = cmdOut1.split(",");
		out.println("<table><tr><td valign=top>");
		out.println("<table border=1>");
		for(int i=7; i<(JOBJs1.length-1); i++) {
		String IDs1[] = JOBJs1[i].split(":");	
		String sdsd=IDs1[1];
		String serd=sdsd.replace("\"","").trim();
		//out.println("<tr class = 'table1'><td>" + IDs1[0] + "</td><td>" + serd + "</td></tr>");
		
		out.println("<a href='"+Srv1+"/web-viewer/app/viewer.html?series="+serd+"'target='content2' style='color:Green'><b>View image from Orthanc Viewer</b></a>");
		}
		
		out.print("</table>");
	//out.println("CMD: " + cmd);
	try {
		Process p = Runtime.getRuntime().exec(cmd);
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
		BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));

		// read the output from the command
		System.out.println("Here is the standard output of the command:\n");
		while ((s = stdInput.readLine()) != null) {
			cmdOut += s;
			//out.println(s);
		}
		 
		//cmdOut=cmdOut.replace(""{", "");
		//cmdOut=cmdOut.replace("}", "").trim();
		//cmdOut=cmdOut.replace("\"", "").trim();
		//cmdOut=cmdOut.trim();
		String JOBJs[] = cmdOut.split(",");
		out.println("<table><tr><td valign=top>");
		out.println("<table border=1>");
		
		out.println("<tr class = 'table2'><td><b>TAG</b></td><td><b>Value</b></td></tr>");
		for(int i=0; i<JOBJs.length; i++) {
			String IDs[] = JOBJs[i].split(":");
			out.println("<tr class = 'table1'><td>" + IDs[0] + "</td><td>" + IDs[1] + "</td></tr>");
		}
		out.print("</table>");
		out.print("</td><td valign=top>"+ imgSrc );
		
		// surajit Kundu @ 06/08/2015
		
		out.print("<form action='zoomdicomimage.jsp' action='POST' onSubmit='return zoomimage()'>");
		out.print("<input id='wadoid' type='hidden' name='wadoid' value='' />");
		out.print("<center><input type='submit' value='Zoom Image' /></center>");
		
		out.print("</td></tr></table>");
		
		// read any errors from the attempted command
		//
		//out.println("Here is the standard error of the command (if any):\n");
		//while ((s = stdError.readLine()) != null) {
		//	out.println(s);
		//}
		
		
		
		
	}
	catch (Exception e) {
		//out.println("exception happened - here's what I know: ");
		//out.println("<a href='http://10.4.1.61:8042/web-viewer/app/viewer.html?series='");+IDs1[1]+out.println("target='content2'><b>Click Here</b></a>");
		e.printStackTrace();
	}
}
	catch(Exception ex){out.println("Error :  : : "+ex.toString());}
	
%>
