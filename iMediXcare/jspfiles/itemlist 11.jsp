<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>
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
<%
	Connection conn = null;
	Statement stmt = null;
	Statement stmt1 = null,stmtprs=null,stmttsr=null;
	ResultSet RSet = null;
	ResultSet RSet1 = null,RSetprs=null,RSettsr=null;
	boolean ref=true;
	String wprn;
	String ID  = request.getParameter("id");
	String usr = request.getParameter("usr");
	String nam = request.getParameter("nam");
	String iSql = "", pid, pty, psl, pdt,strSQL="",dt="";
	MyWebFunctions thisObj = new MyWebFunctions();
	String Node="";

	ID=ID.toLowerCase();
////////////////////////////////////

	String local = thisObj.getCookieValue("currem", request.getCookies ());

	//if(Node.trim().length() == 0) {
	//	 ref=false;
	//	 Node = thisObj.getCookieValue("center", request.getCookies ());
	//}
	//String Node = thisObj.getCenterType( request.getCookies ());	// get the center type noda or referral
	//out.print("<BR><B>"+Node+"</B><BR>");
	//if(Node.equalsIgnoreCase("Nodal"))
	//{
		// ref=false;
		 Node = thisObj.getCookieValue("center", request.getCookies ());
		 Node=ID.substring(0,3).toLowerCase();
////////////////////////////////////////////////////////////////////////////

	//}
	thisObj.addCookie("patid",ID,response);

	//clear the cookie value of selected forms,images etc
	Cookie [] cookies = request.getCookies();
	if (cookies != null)
	{
		for (int i = 0; i < cookies.length; i++)
		{
			if(cookies[i].getName().equals("selfrm") || cookies[i].getName().equals("selimg") || cookies[i].getName().equals("selmark") || cookies[i].getName().equals("selsnd") || cookies[i].getName().equals("seldoc") || cookies[i].getName().equals("selmov"))
			{
			//out.println("cookies : "+cookies[i].getValue());
			cookies[i].setValue("");
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
			}

		}
	}

%>

<BODY BGColor="#EAF4FF" VLINK="BLUE" ALINK="BLUE" LINK="BLUE">
<TABLE Border=0>
<TR>
	<TD><A HREF="javascript:history.go(-1)"><IMG SRC="../images/back.jpg" WIDTH="21" HEIGHT="21" BORDER=1 ></A></TD>
	<TD><A HREF="javascript:location.reload()"><IMG SRC="../images/refresh.jpg" WIDTH="22" HEIGHT="22" BORDER=1 ></A></TD>
	<TD><A HREF="summary.jsp?id=<%=ID%>" Target=fullform Title="View Summary..."><IMG SRC="../images/summary.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD>
	<!-- <TD><A HREF="patiditems.jsp?id=<%=ID%>&nam=<%=nam%>" Target=_parent Title="Edit Send Items..."><IMG SRC="../images/sitem.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD> -->
	
<%  if (ref==false) { %>
	<TD><A HREF="oldpatid.jsp?ID=<%=ID%>" Target=_parent Title="Add New Forms/Docs...."><IMG SRC="../images/open.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD>
<%  } %>

</TR>
</Table>
<%
	String ty="";
	ty = thisObj.getCookieValue("type", request.getCookies ());
	if (ty.equalsIgnoreCase("doc")) {
			out.println("<Table border=1><TR>");
			out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/summary.jsp?id="+ID+"&usr="+usr+"&nam="+nam+"'  target=fullform><font Size=-1 color=red><b>General Information</B></font></A>)</TD>");
			
//out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/genimpress.jsp?id="+ID+"'  target=fullform><font Size=-1 color=red><b>Summary</B></font></A>)</TD></TR><TR>");

out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/hl7message.jsp?id="+ID+"'  target=fullform><font Size=-1 color=red><b>HL7</B></font></A>)</TD></TR><TR>");

			out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/editapp.jsp?id="+ID+"'  target=fullform><font Size=-1 color=red><b>Next Appointment</B></font></A>)</TD>");

			if(local.trim().length() == 0)
			{
			out.println("<TD>(<A HREF='"+gblTelemediKForms+"/selectdoc.jsp'  target=fullform><font Size=-1 color=red><B>Prescription</B></font></A>)</TD>");
			}
			else
			{
			out.println("<TD>(<A HREF='"+gblTelemediKForms+"/checksign.jsp'  target=fullform><font Size=-1 color=red><B>Prescription</B></font></A>)</TD>");
			}
			out.println("</TR><TR>");
		if(local.trim().length() == 0)
		{
			out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/telemedreq.jsp?id="+ID+"' target=fullform><font Size=-1 color=red><B>Teleconsultation-<BR>Needed</B></font></A>)</TD>");
		}
		if(local.trim().length() == 0)
		{
			out.println("<TD>(<A HREF='"+gblTelemediK+"/jspfiles/smr.jsp?id="+ID+"' target=fullform><font Size=-1 color=red><B>Summary</B></font></A>)</TD></TR></Table>");
		}
		else
		{
			out.println("<TD>(<A HREF='"+gblTelemediKForms+"/tsr.jsp?id="+ID+"' target=fullform><font Size=-1 color=red><B>Report</B></font></A>)</TD></TR></Table>");
		}

		}

%>
<TABLE>
<TR>
	<TD><B>PatID</B></TD>
	<TD><B>:</B></TD>
	<TD><FONT  COLOR="BLUE"><B><%=ID.toUpperCase()%></B></FONT></TD>
</TR>
<TR>
	<TD><B>Name</B></TD>
	<TD><B>:</B></TD>
	<TD><FONT  COLOR="BLUE"><B><%=nam%></B></FONT></TD>
</TR>
</TABLE>




<%   ////////////////////////////// LIST OF FORMS ///////////////////////////////////////


	String priority[]={"m","h","p","i","s","d","t"};
	int pr=0;

	try {
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>Forms</B></FONT>");

		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;

		String pcn="",qrpc="",idata="",rcnt="";
		while(pr<7)
		{
		iSql= "select distinct TYPE,PAT_ID, max(DATE) as date,MAX(SERNO) as serno, par_chl  from LISTOFFORMS,FORMS where upper(PAT_ID)= '"+ID.toUpperCase()+"' AND left(TYPE,1)='"+priority[pr]+"' AND par_chl <> 'C' ANd FORMS.CODE=LISTOFFORMS.TYPE group by TYPE" ;
		//out.println("iSql :"+iSql);
		RSet = stmt.executeQuery(iSql);
		while (RSet.next()) {
			pcn=RSet.getString("par_chl");
			pid = RSet.getString("PAT_ID");
			pdt = RSet.getString("date");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet.getString("TYPE").toLowerCase();
			psl = RSet.getString("serno");
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			//if it is a paren or normal form then print the link
			if(!pty.equalsIgnoreCase("PRS") && !pty.equalsIgnoreCase("TSR"))
			{
			if(pcn.trim().equalsIgnoreCase("p") || pcn.trim().equalsIgnoreCase("n"))
			{
				if(pcn.trim().equalsIgnoreCase("n"))
				{
					if(pty.equalsIgnoreCase("MED"))
					wprn = "<A HREF='displaymed.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+psl+"</A>";

					else

					wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+psl+"</A>";
				}
				else
					wprn = "<A HREF='writeval2.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+psl+"</A>";
				//form thumbnails
				out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
				cnt=cnt+1;
			} // end of if
			} //end of of if(!pty.equalsIgnoreCase("PRS") && !pty.equalsIgnoreCase("PRS"))



			//for new row
		 	 if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		} //end of loop
		pr=pr+1;
		} //end of if
		RSet.close();
		stmt.close();
	
		// for prs
	stmtprs = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	iSql= "select pat_id,name_hos,max(entrydate) as entrydate, max(serno) as serno from prs where upper(pat_id)='"+ID.toUpperCase()+"' group by pat_id";

		RSetprs = stmtprs.executeQuery(iSql);
		while (RSetprs.next()) {
			if(cnt>6)
			{
			out.println( "</TR><TR>");
			cnt=1;
			}
			pid = RSetprs.getString("PAT_ID");
			pdt = RSetprs.getString("entrydate");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			psl = RSetprs.getString("serno");
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			rcnt=RSetprs.getString("name_hos");
			wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty=prs&remc="+rcnt+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>PRS"+psl+"</A>";
			out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
				cnt=cnt+1;
		}
		RSetprs.close();
		stmtprs.close();

		// for tsr 
		stmttsr = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	iSql= "select pat_id,name_hos,max(entrydate) as entrydate, max(serno) as serno from tsr where upper(pat_id)='"+ID.toUpperCase()+"' group by pat_id";

		RSettsr = stmttsr.executeQuery(iSql);
		while (RSettsr.next()) {
			if(cnt>6)
			{
			out.println( "</TR><TR>");
			cnt=1;
			}
			pid = RSettsr.getString("PAT_ID");
			pdt = RSettsr.getString("entrydate");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			psl = RSettsr.getString("serno");
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			rcnt=RSettsr.getString("name_hos");
			wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty=tsr&remc="+rcnt+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>TSR"+psl+"</A>";
			out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
				cnt=cnt+1;
		}
		RSettsr.close();
		stmttsr.close();











		out.println( "</TR></TABLE>");
		
		conn.close();
	
	}
	catch(Exception e) {
		out.println(e);
	} 
%>


<%  ////////////////////////////// LIST OF Images ///////////////////////////////////////
	try {
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		iSql= "select distinct TYPE,max(ENTRYDATE)as b from PATIMAGES where Upper(PAT_ID)='"+ID.toUpperCase()+"' and TYPE<>'dcm'  group by TYPE" ;
		//out.println("isql : "+iSql);
		RSet = stmt.executeQuery(iSql);
		if(!RSet.isAfterLast())
		{
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>Images </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;
		//String dt;
		while (RSet.next()) {   //begin of while

		maxendt = RSet.getString("b");
		dd = maxendt.substring(8);
		mm=maxendt.substring(5,7);
		yy=maxendt.substring(0,4);
		Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		c1.setTime(date);
		maxendt=sdf.format(c1.getTime());
		c1.add(Calendar.DATE,-3);
		maxendt1=sdf.format(c1.getTime());
strSQL= "select PATPICURL,PAT_ID,ENTRYDATE,CON_TYPE,SERNO,TYPE from PATIMAGES where Upper(PAT_ID)= '" + ID.toUpperCase() + "' AND (FORMKEY is NULL or length(FORMKEY)=0) AND TYPE = '"+RSet.getString("TYPE")+"' AND (ENTRYDATE >='"+maxendt1+"' AND ENTRYDATE <= '"+maxendt+"')";
		//out.println("isql="+strSQL);
			RSet1 = stmt1.executeQuery(strSQL);
			if(!RSet1.isAfterLast())
			{
			while(RSet1.next())
			{
			
			
			patpicurl = RSet1.getString("PATPICURL");
			
			pid = RSet1.getString("PAT_ID");
			pdt = RSet1.getString("ENTRYDATE");
			content=RSet1.getString("CON_TYPE");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet1.getString("TYPE").toUpperCase().trim();
			psl = RSet1.getString("SERNO").trim();
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			//wprn="<IMG SRC='"+gblTelemediK+"//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl+"' Width=35 Height=35 >";
			wprn="<IMG SRC='displayimgor.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+" ' Width=35 Height=35 >";
			//patpicurl =  "/data/"+Node.toLowerCase()+"/"+pid.toLowerCase()+"/"+patpicurl;
			patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl;
			if(pty.equalsIgnoreCase("ECG")){
			wprn = "<A Href=\'showecg.jsp?image="+patpicurl+"&frm=N&mtype=nomark&patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' target=fullform>ECG"+psl+"</A>";
			out.println("<TD BackGround='../images/ecg.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");

			}else{
			out.println("<TD Width=30 Height=30 Valign=Bottom><A Href=\'showimage.jsp?image="+patpicurl+"&frm=N&mtype=nomark&patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Target=fullform>"+wprn+"</A></TD>");
		}
			cnt=cnt+1;
		} //end of while
		}
		
			if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		
		RSet1.close();
		} //end of while
		
		
		out.println( "</TR></TABLE>");
		RSet.close();
		stmt1.close();
		stmt.close();
		conn.close();
		
	}//end of if	
		
	} //end of try
	catch(Exception e) {
		out.println(e);
	}
		
		
%>



<%  ////////////////////////////// LIST OF VECTOR ///////////////////////////////////////
	try {
		String points="";
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL, gbldbusername, gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		iSql= "select points,pat_id, entrydate, type, serno from coord where lower(PAT_ID)= '"+ID.toLowerCase()+"' and type = 'crd' Order By type, serno" ;
		RSet = stmt.executeQuery(iSql);
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>Skin Patch</B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;
		
		while (RSet.next()) {
			// ?id=BCR22052003001&ty=h06&sl=0&dt=22/05/03
			points = RSet.getString("points");
			pid = RSet.getString("pat_id");
			pdt = RSet.getString("entrydate");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet.getString("type").toUpperCase().trim();
			psl = RSet.getString("serno").trim();
			pdt=pdt.replace('-','/');
			//patpicurl = patpicurl.toLowerCase();
			wprn = "<A HREF='viewpatch.jsp?id="+ID+"&ty=crd&sl="+psl+"&edate="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>"; 
			out.println("<TD BackGround='../images/skp.gif' Width=35 Height=40 Valign=Bottom>"
			+wprn+"</TD>");
			cnt=cnt+1;
			if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		}
		RSet.close();
		out.println( "</TR></TABLE>");
		stmt.close();
		conn.close();

	}
	catch(Exception e) {
		out.println(e);
	}
%>


<%  ////////////////////////////// LIST OF Dicoms ///////////////////////////////////////
	try {
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		iSql= "select distinct TYPE,max(ENTRYDATE)as b from PATIMAGES where Upper(PAT_ID)='"+ID.toUpperCase()+"' and TYPE='dcm' group by TYPE" ;
		//out.println("isql : "+iSql);

		RSet = stmt.executeQuery(iSql);
		if(!RSet.isAfterLast())
		{
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>DICOM Images </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;
		//String dt;
		while (RSet.next()) {   //begin of while
		
		maxendt = RSet.getString("b");
		dd = maxendt.substring(8);
		mm=maxendt.substring(5,7);
		yy=maxendt.substring(0,4);
		Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		c1.setTime(date);
		maxendt=sdf.format(c1.getTime());
		c1.add(Calendar.DATE,-3);
		maxendt1=sdf.format(c1.getTime());
strSQL= "select PATPICURL,PAT_ID,ENTRYDATE,CON_TYPE,SERNO,TYPE from PATIMAGES where PAT_ID= '" + ID.toUpperCase() + "' AND (FORMKEY is NULL or length(FORMKEY)=0) AND TYPE = 'dcm' AND (ENTRYDATE >='"+maxendt1+"' AND ENTRYDATE <= '"+maxendt+"')";
		//out.println("isql="+strSQL);
			RSet1 = stmt1.executeQuery(strSQL);
			if(!RSet1.isAfterLast())
			{
			while(RSet1.next())
			{
			
			
			patpicurl = RSet1.getString("PATPICURL");
			
			pid = RSet1.getString("PAT_ID");
			pdt = RSet1.getString("ENTRYDATE");
			content=RSet1.getString("CON_TYPE");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet1.getString("TYPE").toUpperCase().trim();
			psl = RSet1.getString("SERNO").trim();
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			//wprn="<IMG SRC='"+gblTelemediK+"//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl+"' Width=35 Height=35 >";
			//patpicurl=patpicurl.substring(0,patpicurl.lastIndexOf("."));
			
			patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl;
			wprn = "<A HREF='showdicom.jsp?ity=nom&id="+pid+"&ser="+psl+"&type="+pty+"&dt="+dt+"&img="+patpicurl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>"; 
	out.println("<TD BackGround='../images/dicom.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");





			//wprn="<IMG SRC='displayimgor.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+" ' Width=35 Height=35 >";
			//patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl;
//out.println("<TD Width=30 Height=30 Valign=Bottom><A Href=\'showimage.jsp?image="+patpicurl+"&frm=N&mtype=nomark&patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Target=fullform>"+wprn+"</A></TD>");
			
			
			cnt=cnt+1;
		} //end of while
		}
		
			if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		
		RSet1.close();
		} //end of while
		
		
		out.println( "</TR></TABLE>");
		RSet.close();
		stmt1.close();
		stmt.close();
		conn.close();
		
	}//end of if	
		
	} //end of try
	catch(Exception e) {
		out.println(e);
	}
		
		
%>


<%  ////////////////////////////// LIST OF DOCUMENTS ///////////////////////////////////////
	try {
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		iSql= "select distinct TYPE,max(ENTRYDATE)as b from PATDOC where PAT_ID='"+ID.toUpperCase()+"' group by TYPE" ;
		RSet = stmt.executeQuery(iSql);
		if(!RSet.isAfterLast())
		{
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>Documents and Audio </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;
		//String dt;
		while (RSet.next()) {   //begin of while
		
		maxendt = RSet.getString("b");
		dd = maxendt.substring(8);
		mm=maxendt.substring(5,7);
		yy=maxendt.substring(0,4);
		Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		c1.setTime(date);
		maxendt=sdf.format(c1.getTime());
		c1.add(Calendar.DATE,-3);
		maxendt1=sdf.format(c1.getTime());
strSQL= "select PATDOCURL,PAT_ID,ENTRYDATE,CON_TYPE,SERNO,TYPE from PATDOC where PAT_ID= '" + ID.toUpperCase() + "' AND TYPE = '"+RSet.getString("TYPE")+"' AND (ENTRYDATE >='"+maxendt1+"' AND ENTRYDATE <= '"+maxendt+"')";
			
			RSet1 = stmt1.executeQuery(strSQL);
			if(!RSet1.isAfterLast())
			{
			while(RSet1.next())
			{
			
			
			patpicurl = RSet1.getString("PATDOCURL");
			
			pid = RSet1.getString("PAT_ID");
			pdt = RSet1.getString("ENTRYDATE");
			content=RSet1.getString("CON_TYPE");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet1.getString("TYPE").toUpperCase().trim();
			psl = RSet1.getString("SERNO").trim();
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			patdocurl = "//data//"+Node.toLowerCase()+"//"+pid+"//"+patpicurl;	//url to display doc
			patpicurl =   "//data//"+Node.toLowerCase()+"//"+pid+"//"+patpicurl; // url to display audio
			//patpicurl = patpicurl.toLowerCase();
			if (pty.equalsIgnoreCase("snd")) {
				wprn = "<A HREF='playsound.jsp?obj="+patpicurl+"&id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>"; 
			out.println("<TD BackGround='../images/sound.jpg' Width=35 Height=35 Valign=Bottom>"
+wprn+"</TD>");
			}
			else {
				if (pty.equalsIgnoreCase("doc")) {
				wprn = "<A HREF='docframes.jsp?obj="+patdocurl+"&id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>"; 
					
//wprn = "<A HREF='"+Srv+gblTelemediK+"/data/"+patdocurl.toLowerCase()+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>"; 
					out.println("<TD BackGround='../images/doc.jpg' Width=35 Height=35 Valign=Bottom>"+wprn+"</TD>");
				}
			
			} //end of else
			cnt=cnt+1;
		} //end of while
		}
		
			if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		
		RSet1.close();
		} //end of while
		
		
		out.println( "</TR></TABLE>");
		RSet.close();
		stmt1.close();
		stmt.close();
		conn.close();
		
	}//end of if	
		
	} //end of try
	catch(Exception e) {
		out.println(e);
	}
		
//out.println("<FONT SIZE=-1 COLOR=#660000>&nbsp;<B><a href=header.jsp target=fullform>Movies</a></B></FONT><BR>");		
%>



<%    /////////////////////////////////////////////List Of Movies////////////////////////////////
	
	String typeimg="",serno="",maxendt="",maxendt1="",dd="",yy="",mm="";

	
	ty = thisObj.getCookieValue("type", request.getCookies ());
		try {
		String patpicurl="",content="";
		String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
		 
		Class.forName(gbldbjdbcDriver);
		conn = DriverManager.getConnection(gbldbURL,gbldbusername,gbldbpasswd);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//iSql= "select max(ENTRYDATE)as b from PATMOVIES where Upper(PAT_ID)='"+ID.toUpperCase()+"' AND formkey is NULL" ;
		iSql= "select max(ENTRYDATE)as b from PATMOVIES where Upper(PAT_ID)='"+ID.toUpperCase()+"' and (FORMKEY is NULL or length(FORMKEY)=0) " ;

		RSet = stmt.executeQuery(iSql);
		if(!RSet.isAfterLast())
		{
		
		out.println("<FONT SIZE=+1 COLOR=#660000>&nbsp;<B>Movies</B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#FF0000><TR>");
		int cnt=1;
		
		while (RSet.next()) {
		maxendt = RSet.getString("b");
		dd = maxendt.substring(8);
		mm=maxendt.substring(5,7);
		yy=maxendt.substring(0,4);
		Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		c1.setTime(date);
		maxendt=sdf.format(c1.getTime());
		c1.add(Calendar.DATE,-3);
		maxendt1=sdf.format(c1.getTime());
		strSQL= "select * from PATMOVIES where Upper(PAT_ID)= '" + ID.toUpperCase() + "' AND (FORMKEY is NULL or length(FORMKEY)=0)  AND TYPE = 'mov' AND (ENTRYDATE >='"+maxendt1+"' AND ENTRYDATE <= '"+maxendt+"')";
			//out.println("strSql is :"+strSQL);
			
			RSet1 = stmt1.executeQuery(strSQL);
			if(!RSet1.isAfterLast())
			{
			while(RSet1.next())
			{
			patpicurl = RSet1.getString("Link");
			pid = RSet1.getString("PAT_ID");
			pdt = RSet1.getString("ENTRYDATE");
			content=RSet1.getString("Con_Type");
			dt = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = RSet1.getString("type").toUpperCase().trim();
			psl = RSet1.getString("SERNO").trim();
			if (psl.length()<2) psl = "0" + psl;
			pdt=pdt.replace('-','/');
			
			patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+ "//"+patpicurl; // url to display movie
			//patpicurl = patpicurl.toLowerCase();
			if (pty.equalsIgnoreCase("mov")) {
				wprn="<A HREF='viewmovie.jsp?url=" + patpicurl + "&id="+pid+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+psl+"</A>";
		out.println("<TD BackGround='../images/video.jpg' Width=35 Height=35 Valign=Bottom>" + wprn + "</TD>");
			}
			
			cnt=cnt+1;
			if (cnt>6) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		} //end of while
		} //end of if
		
			
		
		RSet1.close();
		} //end of while
			RSet.close();
		out.println( "</TR></TABLE>");
		
		stmt1.close();
		stmt.close();
		conn.close();	
		
	} //end of if
		
	} //end of try
	catch(Exception e) {
		//out.println(e);
	}
%>

</body>
</html>




