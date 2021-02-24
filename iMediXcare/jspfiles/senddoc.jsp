<%@page language="java"  import= "imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	
	String center="",regno="";
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	cook cookx = new cook();

	center= cookx.getCookieValue("center", request.getCookies());
	regno=request.getParameter("uid").trim();

%>

<HTML>
<HEAD>

</HEAD>
<BODY BGColor='#FFCCCC'>
<CENTER><BR><BR><BR>
<%		
	out.println("<TABLE Width=640 Border=0><TR><TD><CENTER>");
	out.println("<FONT SIZE='+1' COLOR='#CC3300'>Sending Doctors Information</FONT>");
	out.println("</CENTER></TD></TR></TABLE>");
	out.println("<BR>");
	out.println("<TABLE Width=400 Border=2><TR><td>");
	//Qr="Select * from CENTER where upper(centertype)<>'S'";
%>

<CENTER>
<FORM METHOD=GET ACTION="dosenddoc.jsp" Name="ftpfrm" onSubmit="return validate();">
<TABLE>
	<INPUT TYPE="hidden" NAME="rg_no" Value="<%=regno%>">
	<TR><td>&nbsp;</td></TR>
	<TR>
	<TD Align=Right>Send To</TD>
	<TD Align=Center>:</TD>
	<TD><SELECT NAME="rhoscod">
	<%	
		int  Pos=0;
		Object res=cinfo.getAllCentreInfo();
		if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
		else{
				Vector Vtmp = (Vector)res;
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
							if(!center.equalsIgnoreCase(datatemp.getValue("code"))){
							out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
							Pos=Pos+1;
							}
					} // end for
			}// end else
		out.println("</SELECT><br></TD>");
	%>

</TR>

<TR>
	<TD Align=Right></TD>
	<TD Align=Center></TD>
	<TD>
	<%
		if(Pos==0)
		
			out.println("<FONT SIZE='3pt' COLOR=RED>Contact System Administrator</FONT>");
		else 
			out.println("<INPUT TYPE='submit' Value='Send Now'>");
		
	%>	
	</TD>
</TR>
</TABLE>
</FORM>
</CENTER>
</TD></TR></TABLE>
</CENTER>
</BODY>
</HTML>
