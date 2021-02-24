<%@page contentType="text/html" import= "imedix.rcGenOperations,imedix.rcCentreInfo,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
String id,nam,usr="";

rcGenOperations rcgop=new rcGenOperations(request.getRealPath("/"));
rcCentreInfo cnfo = new rcCentreInfo(request.getRealPath("/"));
cook cookx = new cook();
id = request.getParameter("id").trim();
usr = cookx.getCookieValue("usertype", request.getCookies());
String ccode= cookx.getCookieValue("center", request.getCookies ());
String pidCcode="";

if(id==null) id="";
id=id.replaceAll("'","''");

if(id.equals("")) {
	out.println("<font size=+1><Br><Br><center>Patient ID is Blank<br>Can Not Add or Modify Patient's Data <br> ");
	out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Back' ></A>");
	return;
}
if(id.length()>=4)
	pidCcode=cnfo.getCenterCode(id,"med").toUpperCase();
else{
	out.println("<font size=+1><Br><Br><center>Invalid Patient ID <br>Patient Visit Can Not be Saved<br> ");
	out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Back' ></A>");
	return;
}

if(!ccode.equals("XXXX") && !pidCcode.equals(ccode)){
	out.print("<BR><BR><CENTER><B>");
	out.print("<FONT SIZE=+2 COLOR='DARKBLUE'>Patient with "+id+" id </FONT><BR>");
	out.print("<FONT SIZE=+2 COLOR='RED'>Not Found/ Currently Locked</FONT><BR><BR>");
	out.print("<FONT SIZE=+2 COLOR=#8F8F8F>Please enter correct Patient ID</FONT>");
	out.print("<br><A href='javascript:history.back();'> Try Again </A>");
	out.print("</B></CENTER>");
	return;
}

String patdis="General Medical";
String pname="";
//String sqlQuery,iData;
boolean found=false;

try {
	String cnd= "lower(pat_id) = '" + id.toLowerCase() +"'";
	pname=rcgop.getAnySingleValue("med","pat_name",cnd);
	//out.print("<br>"+pname+"<br>"+cnd);
	if(!pname.equals("")){
		cookx.addCookie("patid",id,response);
		cookx.addCookie("patname",pname,response);
		found = true;
	}
			
} catch(Exception e){
	out.print("Exception!! : "+e); 
}

if (found == false)
{
	out.print("<BR><BR><CENTER><B>");
	out.print("<FONT SIZE=+2 COLOR='DARKBLUE'>Patient with "+id+" id </FONT><BR>");
	out.print("<FONT SIZE=+2 COLOR='RED'>Not Found/ Currently Locked</FONT><BR><BR>");
	out.print("<FONT SIZE=+2 COLOR=#8F8F8F>Please enter correct Patient ID</FONT>");
	out.print("<br><A href='javascript:history.back();'> Try Again </A>");
	out.print("</B></CENTER>");
}
else
{
	found = false;
	try {
		String cnd= "lower(pat_id) = '" + id.toLowerCase() +"'";
		pname=rcgop.getAnySingleValue("lpatq","pat_id",cnd);
		if(!pname.equals("")) found = true;
	} catch(Exception e){
		out.print("Exception **: "+e);
	}

	if(found==false){
%>
		<FORM METHOD=get ACTION="confirmadd.jsp">
				<CENTER>
				<INPUT TYPE="hidden" name=id value=<%=id%>><BR><BR>
				<FONT SIZE="+2" color=RED>The patient ID <I>'<%=id%>' </I>is not there in patient queue</FONT><BR>
				<FONT SIZE="+1" COLOR="DARKGREEN"><B>Do you want to add this patient to queue and resume data entry task.</B></FONT>
				<BR><BR>
				<INPUT TYPE="submit" name=yes value=YES style="background-color: 'DARKBLUE'; color: BLUE; font-weight:BOLD; font-style:oblique " width=5>
				<INPUT TYPE="submit" name=no value=NO style="background-color: 'DARKBLUE'; color: BLUE; font-weight:BOLD; font-style:oblique " width=5>	</CENTER>
		</FORM>
<%	
	}

	else{
		String cnd= "lower(pat_id) = '" + id.toLowerCase() +"'";
		patdis=rcgop.getAnySingleValue("med","class",cnd);
		response.sendRedirect(response.encodeRedirectURL("showpatdata.jsp?id="+id+"&usr="+usr+"&nam="+pname+"&patdis="+patdis));
	}
}
%>


