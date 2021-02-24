<%@page contentType="text/html" import="imedix.cook,imedix.rcAdminJobs,imedix.dataobj,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<head>

<title>Patient queue</title>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>

<body background="blutextb.gif" bgcolor="#FFFFFF" text="#003399" link="#CC9900" vlink="#666699" alink="#CC3399">
<br><br>
<CENTER>
<font face="century gothic, arial, helvetica" size="12px">
<strong>Search Result</strong><br>
</font>
<form NAME="send" METHOD="GET" ACTION="sendlist.jsp">

  </font><table border="0" align="center" class='table table-condensed table-bordered'>
    <tr>
      <td><font face="century gothic, arial, helvetica"><b>Patient ID</b></font></td>
      <td><font face="century gothic, arial, helvetica"><b>Name</b></font></td>
      <td><font face="century gothic, arial, helvetica"><b>Disease Type</b></font></td>
      <td><font face="century gothic, arial, helvetica"><b>Registration Date<br>(dd/mm/yyyy)</font></td>
      <td><font face="century gothic, arial, helvetica"><b>Checked<br></b></font></td>
      <td><font face="century gothic, arial, helvetica">&nbsp;</font></td>
   </tr>

<%

String value="";
String que=request.getParameter("que");
String cb=request.getParameter("cb");

String searchBy = request.getParameter("R1");
cook cookx = new cook();
String usrccode = cookx.getCookieValue("center", request.getCookies ());
String ccode = request.getParameter("center");

String utyp=cookx.getCookieValue("usertype", request.getCookies());
String usr=cookx.getCookieValue("userid", request.getCookies());
if(cb==null) cb="";

if(searchBy.equals("date"))
{
	value =  request.getParameter("year") +"/"+ request.getParameter("month") +"/"+ request.getParameter("day"); 
}else if(searchBy.equals("id")){
	value=request.getParameter("id");

}else if(searchBy.equals("name")){
	value=request.getParameter("name");

}else if(searchBy.equals("class")){
	value=request.getParameter("distype");
}

String color="",edt="",pid="",pname="",distyp="";
color = "#FFFFCC";
int c=0;

rcAdminJobs rcajob=new rcAdminJobs(request.getRealPath("/"));

try {
	 Object res=rcajob.searchPatient(que,searchBy,value.trim(),ccode,usrccode);
		  if(res instanceof String){
				out.println( "Error <Br> res :"+ res);
			}else{
			Vector tmp = (Vector)res;
			 for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);			
				pid=temp.getValue("pat_id");
				pname=temp.getValue("pre") +". " + temp.getValue("pat_name")+" " +temp.getValue("m_name")+" " +temp.getValue("l_name") ; 
				distyp=temp.getValue("class");
				edt=temp.getValue("entrydate");
				if(edt.length()==0) edt="";
				else edt= edt.substring(8,10)+"/"+edt.substring(5,7)+"/"+edt.substring(0,4);
			
			c=c+1;

			if(color.equals("#FFFFCC")) color = "#CCFFCC";
			else color = "#FFFFCC";  
			
			out.println("<TR ");
			out.println("bgcolor=" + color + ">");
			out.println("<TD><A class='btn btn-default' HREF='showpatdata.jsp?id="+pid+"&usr="+usr+"&nam=*&patdis="+distyp+"' target=_top>"+ pid+"</a></TD>");
			out.println("<TD>");
			out.println(pname+"</TD>");
			out.println("<TD>" + distyp + "</TD>");
			out.println("<TD>" + edt + "</TD>");
			if(temp.getValue("checked").equals("R"))    //possible only in case of referral, as when data comes from other end we mark R in patq table
				out.println("<TD>N</TD>");
			else
			out.println("<TD>" + temp.getValue("checked").toUpperCase() + "</TD>");
			
			if(temp.getValue("checked").equals("NOT IN PATQ"))
				out.println("<TD>" + "<a href=addtoq.jsp?ID=" + temp.getValue("pat_id") + "&que="+que+"&cb="+cb+"> Add to Queue</a>" + "</TD>");
				out.println("</TR>");
	} // for
	 } // else
		
}catch(Exception sqle)
{
	out.println("Error in sql :"+sqle);
}

out.println("<B><FONT SIZE='+1'>Number of records found : </FONT><font color=red size=+1>" + String.valueOf(c) + "</font></B>");

out.println("<TR><td colspan='5' align='center'>");
out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Back' ></A>");
out.println("</td></TR>");
%>
  </table>
</form>
</p>
</font></CENTER>
</body>
</html>
