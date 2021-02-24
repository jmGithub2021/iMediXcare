<%@page contentType="text/html" import="imedix.rcItemlistInfo, imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

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
<link rel="stylesheet" type="text/css" href="../style/anylinkvertical.css">

</HEAD>
<%
	
	rcItemlistInfo rcaili=new rcItemlistInfo(request.getRealPath("/"));

	boolean ref=true;
	String wprn;

	String ID  = request.getParameter("id");
	String usr = request.getParameter("usr");
	//String nam = request.getParameter("nam");

	String iSql = "", pid, pty, psl,dsl="", pdt,strSQL="",dt="";
	String Node="";

////////////////////////////////////
	cook cookx = new cook();
	String local = cookx.getCookieValue("node", request.getCookies ());
	String ccode = cookx.getCookieValue("center", request.getCookies ());
////////////////////////////////////////////////////////////////////////////
	
	cookx.addCookie("patid",ID,response);

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

<BODY BGColor="#F6FAFE" VLINK="BLUE" ALINK="BLUE" LINK="BLUE" background="../images/txture3.jpg">
<TABLE Border=0>
<TR>
	<TD>
	
	<A HREF="javascript:history.go(-1)"><IMG SRC="../images/back.jpg" WIDTH="21" HEIGHT="21" BORDER=1 ></A>
	
	</TD>
	<TD><A HREF="javascript:location.reload()"><IMG SRC="../images/refresh.jpg" WIDTH="22" HEIGHT="22" BORDER=1 ></A></TD>
	<TD><A HREF="generalimpression.jsp?id=<%=ID%>" Target='fullform' Title="View General Impression"><IMG SRC="../images/summary.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD>


<TD><A HREF="browse.jsp" Target='content1' Title="Back To Patient Queue..."><IMG SRC="../images/patque.jpg" WIDTH="100" HEIGHT="21" BORDER=1></A></TD>

	<!-- <TD><A HREF="patiditems.jsp?id=<%=ID%>" Target=_parent Title="Edit Send Items..."><IMG SRC="../images/sitem.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD> -->
	
<%  if (ref==false) { %>
	<TD><A HREF="oldpatid.jsp?ID=<%=ID%>" Target=_parent Title="Add New Forms/Docs...."><IMG SRC="../images/open.jpg" WIDTH="21" HEIGHT="21" BORDER=1></A></TD>
<%  } %>

</TR>
</Table>
<FONT  COLOR="red"> <B>PatID :<%=ID.toUpperCase()%></B></FONT><br>
<%
	String ty="";
	ty = cookx.getCookieValue("usertype", request.getCookies ());
    String docid=cookx.getCookieValue("userid", request.getCookies ());
	//if (ty.equalsIgnoreCase("doc")) {
			

			out.println("<div class='mainmenu'>");

			out.println("<A HREF='summary.jsp?id="+ID+"&usr="+usr+"'  target=fullform>General Information</A>");
			
			if(local.trim().length() == 0) out.println("<A HREF='smr.jsp?id="+ID+"' target=fullform>Summary</A>");
			else out.println("<A HREF='tsr.jsp?id="+ID+"' target=fullform>Report</A>");
		
			out.println("<A HREF='hl7/hl7message.jsp?id="+ID+"'  target=fullform>HL7</A>");
			out.println("<A HREF='editapp.jsp?id="+ID+"'  target=fullform>Next Appointment</A>");
			
			if (ty.equalsIgnoreCase("doc")) {
				out.println("<A HREF='pre_frame.jsp?docid="+docid+"' target=bot >Prescription</A>");				
			}

			if(local.trim().length() == 0)
			{
			out.println("<A HREF='telemedreq.jsp?id="+ID+"&ccode="+ccode+"' target=fullform>TeleConsultation</A>");
			}else{
			out.println("<A HREF='telemedreq.jsp?id="+ID+"&ccode="+ccode+"' target=fullform>TeleReference</A>");
			}
			
			//out.println("<A HREF='OnlineCommunicator.jsp?id="+ID+"' target=fullform>Online Communicator</A>");
			//out.println("<A HREF='newfolder/test.html' target=fullform>Online Communicator</A>");

			out.println("</div>");


//}

%>


<!-- <HR Color=PINK></HR> -->

<%   ////////////////////////////// LIST OF FORMS ///////////////////////////////////////
	

	String priority[]={"m","h","p","i","s","d","t","c"};
	int pr=0;
	Object res=null;
	Vector tmp=null;

	try {
		out.println("<FONT SIZE=+1 COLOR=#FF0000><B>Forms</B></FONT>");
		out.println("<TABLE Border=1 BorderColor=#296488><TR>");
		int cnt=1;
		String pcn="",qrpc="",idata="",rcnt="";

		while(pr<7)
		{
			res=rcaili.getListOfForms(ID,priority[pr]);
			tmp = (Vector)res;

			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				pcn=temp.getValue("par_chl");
				pid = temp.getValue("pat_id");
				pdt = temp.getValue("date");
				dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
				pty = temp.getValue("type").toLowerCase();
				psl = temp.getValue("serno");
				dsl=psl;
				if (psl.length()<2) dsl = "0" + psl;
				pdt=pdt.replace('-','/');
				if(!pty.equalsIgnoreCase("PRS") && !pty.equalsIgnoreCase("TSR"))
				{
					if(pcn.trim().equalsIgnoreCase("P") || pcn.trim().equalsIgnoreCase("N"))
					{
						if(pcn.trim().equalsIgnoreCase("N"))
						{
							if(pty.equalsIgnoreCase("MED"))
								wprn = "<A HREF='displaymed.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+dsl+"</A>";
							else
								wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+dsl+"</A>";

						}else{
								wprn = "<A HREF='writeval2.jsp?id="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty.toUpperCase()+dsl+"</A>";
						}

						out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
						cnt=cnt+1;
					} // if p 

				} // if PRS 
			
				if (cnt>5) {
					out.println( "</TR><TR>");
					cnt=1;
					}
				} // for 
			pr=pr+1;
			} // while

	// for prs

	//////////////////  this may be change
	
		res=rcaili.getListOfPrs(ID);
		tmp = (Vector)res;

		for(int i=0;i<tmp.size();i++){
			if(cnt>5){
				out.println( "</TR><TR>");
				cnt=1;
			}
			dataobj temp = (dataobj) tmp.get(i);
			pid = temp.getValue("pat_id");
			pdt = temp.getValue("entrydate");
			dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			psl = temp.getValue("serno");
			dsl=psl;
			if (psl.length()<2) dsl = "0" + psl;
			pdt=pdt.replace('-','/');
			rcnt=temp.getValue("name_hos");
			wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty=prs&remc="+rcnt+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>PRS"+dsl+"</A>";
			out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
			cnt=cnt+1;
		}


		// for tsr 
		
		res=rcaili.getListOfTsr(ID);
		tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			if(cnt>5){
				out.println( "</TR><TR>");
				cnt=1;
			}
			dataobj temp = (dataobj) tmp.get(i);
			pid = temp.getValue("pat_id");
			pdt = temp.getValue("entrydate");
			dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			psl = temp.getValue("serno");
			dsl=psl;
			if (psl.length()<2) dsl = "0" + psl;
			pdt=pdt.replace('-','/');
			rcnt=temp.getValue("name_hos");
			wprn = "<A HREF='writevaltext.jsp?id="+pid+"&ty=tsr&remc="+rcnt+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>TSR"+dsl+"</A>";
			out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
			cnt=cnt+1;
		}
		out.println( "</TR></TABLE>");
	}catch(Exception e){
		out.println(e.toString());} 
%>


<%  
	////////////////////////////// LIST OF Images ///////////////////////////////////////

	try {
		
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		//String Srv = "https://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		//String Srv = "";
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 

		res=rcaili.getListOfImages(ID);

		tmp = (Vector)res;
		if(tmp.size()>0) {
		out.println("<FONT SIZE=+1 COLOR=#FF0000><B>Images </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#296488><TR>");
		}
		int cnt=1;
		//String dt;
		//while (RSet.next()) {   //begin of while

		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);

			maxendt = temp.getValue("b");
			dd = maxendt.substring(8,10);
			mm=maxendt.substring(5,7);
			yy=maxendt.substring(0,4);
			Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
			c1.setTime(date);
			maxendt=sdf.format(c1.getTime());
			c1.add(Calendar.DATE,-4);
			maxendt1=sdf.format(c1.getTime());

			Object res1=rcaili.getListOfImagesDtl(ID,temp.getValue("type"),maxendt1,maxendt);
			Vector tmp1 = (Vector)res1;
			
				for(int j=0;j<tmp1.size();j++){
					dataobj temp1 = (dataobj) tmp1.get(j);
					pid = temp1.getValue("pat_id");
					pdt = temp1.getValue("entrydate");
					//out.println(" entrydate "+pdt);
					//content=temp1.getValue("con_type");
					dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					pty = temp1.getValue("type").toUpperCase().trim();
					psl = temp1.getValue("serno").trim();
					dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;
					//pdt=pdt.replace('-','/');
					//patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl;
					
					if(pty.equalsIgnoreCase("TEG")){
					wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&id="+pid+"&ty="+pty+"&ser="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' target=fullform>ECG"+dsl+"</A>";
					out.println("<TD BackGround='../images/ecg.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
					}else{
					wprn="<IMG SRC='displayimg.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+dt+" ' Width=30 Height=35 >";
					out.println("<TD Width=30 Height=35 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&dt="+dt+"' Target=fullform>"+wprn+"</A></TD>");
					}
			cnt=cnt+1;
			if (cnt>5) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		} //end of while
			
		} //end of while
		out.println( "</TR></TABLE>");		
	} catch(Exception e) {
		out.println(e);
	}
		
%>



<%  
	////////////////////////////// LIST OF VECTOR ///////////////////////////////////////
	
	

	try {
		String points="";

		res=rcaili.getListOfVectors(ID);

		tmp = (Vector)res;
		if(tmp.size()>0) {
		out.println("<FONT SIZE=+1 COLOR=#FF0000><B>Skin Patch</B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#296488><TR>");
		}
		
		int cnt=1;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			points = temp.getValue("points");
			pid = temp.getValue("pat_id");
			pdt = temp.getValue("entrydate");
			dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			pty = temp.getValue("type").toUpperCase().trim();
			psl = temp.getValue("serno").trim();
			dsl=psl;
			if (psl.length()<2) dsl = "0" + psl;
			pdt=pdt.replace('-','/');
			wprn = "<A HREF='viewpatch.jsp?id="+ID+"&ty=crd&sl="+psl+"&edate="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+dsl+"</A>"; 

			out.println("<TD BackGround='../images/skp.gif' Width=35 Height=40 Valign=Bottom>"
			+wprn+"</TD>");
			cnt=cnt+1;

			if (cnt>5) {
			out.println( "</TR><TR>");
			cnt=1;
			}
		} // end for
		out.println( "</TR></TABLE>");
	}
	catch(Exception e) {
		out.println(e);
	}


%>


<%  ////////////////////////////// LIST OF Dicoms ///////////////////////////////////////

	try {
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		//String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 
		res=rcaili.getListOfDicoms(ID);

		tmp = (Vector)res;
		if(tmp.size()>0) {
		out.println("<FONT SIZE=+1 COLOR=#FF0000><B>DICOM Images </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#296488><TR>");
		}
		int cnt=1;

		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			maxendt = temp.getValue("b");
			dd = maxendt.substring(8,10);
			mm=maxendt.substring(5,7);
			yy=maxendt.substring(0,4);
			Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
			c1.setTime(date);
			maxendt=sdf.format(c1.getTime());
			c1.add(Calendar.DATE,-4);
			maxendt1=sdf.format(c1.getTime());

			Object res1=rcaili.getListOfDicomsDtl(ID,maxendt1,maxendt);
			Vector tmp1 = (Vector)res1;
			for(int j=0;j<tmp1.size();j++){
				dataobj temp1 = (dataobj) tmp1.get(j);
				//patpicurl = temp1.getValue("PATPICURL");
				patpicurl = "";
				pid = temp1.getValue("pat_id");
				pdt = temp1.getValue("entrydate");
				content=temp1.getValue("con_type");
				dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
				pty = temp1.getValue("type").toUpperCase().trim();
				psl = temp1.getValue("serno").trim();
				dsl=psl;
				if (psl.length()<2) dsl = "0" + psl;
				pdt=pdt.replace('-','/');
				//patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+"//"+patpicurl;

				wprn = "<A HREF='showdicom.jsp?mtype=nomark&id="+pid+"&ser="+psl+"&type="+pty+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+dsl+"</A>"; 
				out.println("<TD BackGround='../images/dicom.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
				cnt=cnt+1;
				if (cnt>5) {
				out.println( "</TR><TR>");
				cnt=1;
				}

			} //end of J 
		} //end of i for
		out.println( "</TR></TABLE>");
	} catch(Exception e) {
		out.println(e);
	}
		
		
		
%>


<%  ////////////////////////////// LIST OF DOCUMENTS ///////////////////////////////////////


	try {
		String patpicurl,content="",patdocurl="",maxendt="",maxendt1="",dd="",yy="",mm="";
		//String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance(); 

		res=rcaili.getListOfDocuments(ID);

		tmp = (Vector)res;
		if(tmp.size()>0) {
		out.println("<FONT SIZE=+1 COLOR=#FF0000><B>Documents and Audio </B></FONT><BR>");
		out.println("<TABLE Border=1 BorderColor=#296488><TR>");
		}
		int cnt=1;

		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			maxendt = temp.getValue("b");
			dd = maxendt.substring(8,10);
			mm=maxendt.substring(5,7);
			yy=maxendt.substring(0,4);
			Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
			c1.setTime(date);
			maxendt=sdf.format(c1.getTime());
			c1.add(Calendar.DATE,-4);
			maxendt1=sdf.format(c1.getTime());

			Object res1=rcaili.getListOfDocumentsDtl(ID,temp.getValue("type"),maxendt1,maxendt);
			Vector tmp1 = (Vector)res1;
			for(int j=0;j<tmp1.size();j++){
				dataobj temp1 = (dataobj) tmp1.get(j);
				//patpicurl = temp1.getValue("PATDOCURL");
				patpicurl = "";
				pid = temp1.getValue("pat_id");
				pdt = temp1.getValue("entrydate");
				content=temp1.getValue("con_type");
				dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
				pty = temp1.getValue("type").toUpperCase().trim();
				psl = temp1.getValue("serno").trim();
				dsl=psl;
				if (psl.length()<2) dsl = "0" + psl;
				pdt=pdt.replace('-','/');
			//patdocurl = "//data//"+Node.toLowerCase()+"//"+pid+"//"+patpicurl;	//url to display doc
			//patpicurl =   "//data//"+Node.toLowerCase()+"//"+pid+"//"+patpicurl; // url to display audio
				//patpicurl = patpicurl.toLowerCase();
				if(pty.equalsIgnoreCase("TEG")){
					wprn = "<A Href=\'showecg.jsp?patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+dt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' target=fullform>ECG"+dsl+"</A>";
					out.println("<TD BackGround='../images/ecg.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
				}else if (pty.equalsIgnoreCase("snd")) {
					wprn = "<A HREF='playsound.jsp?id="+pid+"&dt="+dt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+dsl+"</A>"; 
					out.println("<TD BackGround='../images/sound.jpg' Width=35 Height=35 Valign=Bottom>"
					+wprn+"</TD>");
				}else if (pty.equalsIgnoreCase("doc")) {
						wprn = "<A HREF='docframes.jsp?id="+pid+"&dt="+dt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+dsl+"</A>"; 
						out.println("<TD BackGround='../images/doc.jpg' Width=35 Height=35 Valign=Bottom>"+wprn+"</TD>");
					}
				
				//} //end of else

				cnt=cnt+1;
				if (cnt>5) {
				out.println( "</TR><TR>");
				cnt=1;
				}
			} //end of j for
			
				
		} //end of i for
			out.println( "</TR></TABLE>");
	} catch(Exception e) {
		out.println(e);
	}
%>

<%    /////////////////////////////////////////////List Of Movies////////////////////////////////

	
		String typeimg="",serno="",maxendt="",maxendt1="",dd="",yy="",mm="";
		try {
			String patpicurl="",content="";
			//String Srv = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();
			
			res=rcaili.getListOfMovies(ID);

			tmp = (Vector)res;
			if(tmp.size()>0) {
				out.println("<FONT SIZE=+1 COLOR=#FF0000><B>Movies</B></FONT><BR>");
				out.println("<TABLE Border=1 BorderColor=#296488><TR>");
			}

			int cnt=1;

			for(int i=0;i<tmp.size();i++){
				dataobj temp = (dataobj) tmp.get(i);
				maxendt = temp.getValue("b");
				dd = maxendt.substring(8,10);
				mm=maxendt.substring(5,7);
				yy=maxendt.substring(0,4);

				Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
				c1.setTime(date);
				maxendt=sdf.format(c1.getTime());
				c1.add(Calendar.DATE,-4);
				maxendt1=sdf.format(c1.getTime());

				//out.println("maxendt : " + maxendt +"  maxendt1 :"+maxendt1);

				Object res1=rcaili.getListOfMoviesDtl(ID,maxendt1,maxendt);

				Vector tmp1 = (Vector)res1;

				for(int j=0;j<tmp1.size();j++){
					dataobj temp1 = (dataobj) tmp1.get(j);
					//patpicurl = temp1.getValue("Link");
					
					pid = temp1.getValue("pat_id");
					pdt = temp1.getValue("entrydate");
					content=temp1.getValue("con_type");
					dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					pty = temp1.getValue("type").toUpperCase().trim();
					psl = temp1.getValue("serno").trim();
					dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;
					pdt=pdt.replace('-','/');
					//patpicurl =  "//data//"+Node.toLowerCase()+"//"+pid.toLowerCase()+ "//"+patpicurl; // url to display movie
					if (pty.equalsIgnoreCase("mov")) {
						wprn="<A HREF='viewmovie.jsp?id="+pid+"&dt="+dt+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target=fullform>"+pty+dsl+"</A>";
						out.println("<TD BackGround='../images/video.jpg' Width=35 Height=35 Valign=Bottom>" + wprn + "</TD>");
					}
					
					cnt=cnt+1;
					if (cnt>5) {
					out.println( "</TR><TR>");
					cnt=1;
					}
				} //end of while
			
			} //end of while
				
			out.println( "</TR></TABLE>");
	} catch(Exception e) {
		//out.println(e);
	}

%>

</body>
</html>




