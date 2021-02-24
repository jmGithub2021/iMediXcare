<%@ page import="java.util.*,java.*,java.io.*" %>

<%@page contentType="text/html" %>
<%@ include file="..//chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>

<HTML>
<HEAD>
<STYLE>
TABLE { Border: 1;
		font: Tahoma;
		color: RED;
}
A:HOVER {
		color:RED;
		background-color: YELLOW;
}
</STYLE>
</HEAD>
<BODY>
<center>
<TABLE BORDER=1>
<TR><TD>HL7 Parser Tool</TD></TR>

<TR><TD>
<%
	MyWebFunctions thisObj = new MyWebFunctions();
	String thome = thisObj.gblRoot;
	String user  = thisObj.getCookieValue("user", request.getCookies ());
	String pid  = request.getParameter("id");
	String srvr =  request.getServerName();
	int port =  request.getServerPort();
	String ccode = thisObj.getCookieValue("center", request.getCookies ());
	String addr = "http://" + srvr + ":" + Integer.toString(port) + thisObj.gblTelemediK;
	String patlist="";
	int i;
	try{
		File hl7directory=new File(thisObj.gblFTPRoot+"/TEMP/HL7");
		String[] childdir = hl7directory.list();
		//out.println(thisObj.gblFTPRoot+"/TEMP/HL7");

		if( !hl7directory.isDirectory() || childdir.length <= 0 ){
			patlist="Directory Empty";
       		}
		else{
			//out.println(childdir.length);
			for(i=0;  i < childdir.length; i++){
				File pdir=new File(hl7directory,childdir[i]);
				if(pdir.isDirectory()){
					patlist=patlist+pdir.getName()+"#";
					}
			}
			//out.println(" "+i+" "+patlist);
		}

	}catch (Exception e) {
		//out.println("Error found <B>"+e.toString()+"</B>");
	}

%>
 <APPLET CODE="hl7parse.class" codebase="./hl7/" archive="hl7parse.jar,  mysql-connector-java-3.1.7-bin.jar"  WIDTH=890 HEIGHT=400>
    <param name="telemedhome" value="<%=addr%>" />
    <param name="patlist" value="<%=patlist%>" />
 </APPLET>

</TD>
</TR>
<TR><TD>If you are Running this Applet for first-time, Save this <a href="onlineconf/.java.policy" style="text-decoration:none">file</A> in your HOME driectory<br>You may also need latest jre. Install it from <a href="onlineconf/jre15.exe" style="text-decoration:none">this location</a>.
</TD></TR>
</TABLE>
</center>
</BODY>
</HTML>
