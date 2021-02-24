<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj, imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));

	String ccode =cookx.getCookieValue("center", request.getCookies ());
	dataobj obj = new dataobj();

	obj.add("pat_id",request.getParameter("pat_id"));
	obj.add("attending_doc",request.getParameter("att_doc"));
	obj.add("referred_doc",request.getParameter("rdocnam"));
	obj.add("referred_hospital",request.getParameter("rhoscod"));
	obj.add("local_hospital",cookx.getCookieValue("center", request.getCookies()));
	obj.add("sent_by",cookx.getCookieValue("userid", request.getCookies()));

	String hosnam="",records="",srec="";
	String patid=request.getParameter("pat_id");

	records=request.getParameter("records");

	if(records.equals("all"))
	{
		obj.add("send_records","all");
	}
	else
	{
		srec="forms:med-00#";
		srec=srec+cookx.getCookieValue("selfrm",request.getCookies());
		srec=srec+"@images:";
		srec=srec+cookx.getCookieValue("selimg",request.getCookies());
		srec=srec+"@refimages:";
		srec=srec+cookx.getCookieValue("selmark",request.getCookies());
		srec=srec+"@documents:";
		srec=srec+cookx.getCookieValue("seldoc",request.getCookies());
		srec=srec+cookx.getCookieValue("selsnd",request.getCookies());
		srec=srec+"@movies:";
		srec=srec+cookx.getCookieValue("selmov",request.getCookies());
		//srec=srec+"@vector:";
		//srec=srec+thisObj.getCookieValue("selvec",request.getCookies());
		obj.add("send_records",srec);
	}
	//call rem
	hosnam=rcdef.InsertTeleMedRequest(obj);
%>
<html>
<body><BR><BR><BR><BR><BR><BR><BR>
<CENTER><TABLE border=0>
<TR>
	<TD>
	<FONT SIZE=+2 COLOR=green><B>Data of the Patient ('<%=patid%>') will be sent to <%=hosnam.toUpperCase()%></B></FONT>
</TD>
</TR>
</TABLE>
</CENTER></body>
</html> 
