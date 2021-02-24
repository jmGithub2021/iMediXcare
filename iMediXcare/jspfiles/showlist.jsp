<%@page contentType="text/html"  import="imedix.rcDisplayData,imedix.dataobj,imedix.myDate,imedix.cook,java.util.*" %>

<%
String pname="abc";
cook cookx = new cook();
String patid="";
patid = cookx.getCookieValue("patid", request.getCookies());
String uType=cookx.getCookieValue("usertype", request.getCookies ());

rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
Vector alldata=null;
Object res=null;
String tempdt="",nowcolor="",tmpColor="";
String todydt=myDate.getCurrentDate("dmy",true);
%>

<html>

<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>


</head>

<body bgcolor='#FFFFFF' background="../images/txture5.jpg" ><form><center>
<div class="container-fluid">
<font size=+2 color=BLACK> Patient ID : </font> 
<b><font size=+2 color=RED> <%=patid%></b>
<br>

<div class="table-responsive">
<TABLE class="table table-hover" bgcolor='#CECEFF'>

<%	
	try
	{
		alldata= (Vector)ddinfo.showAllLists(patid);  

		res = (Object)alldata.get(0);
			if(res instanceof String){ 
					out.println("No Form");
			 }
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
					%>
						
						<TR >
						<TD Width=10%><B><font color='BLUE'><CENTER>S/No</CENTER></font></B></td>
						<TD Width=75%><B><font color='BLUE'><CENTER>Forms</CENTER></font></B></td>
						<TD Width=15%><B><font color='BLUE'><CENTER>Date & Total</CENTER></font></B></td>
						</TR>
					<%
					
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String pcn=datatemp.getValue("par_chl");
						String pdt = datatemp.getValue("date");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = datatemp.getValue("type");
						String psl = datatemp.getValue("serno");
						String wprn ="";

						if (!dt.equalsIgnoreCase(tempdt)){
								if (nowcolor == "#FEFEF2") nowcolor = "#FCF6CF";
								else nowcolor = "#FEFEF2";
								tempdt=dt;
						}
						tmpColor=nowcolor;

						if(todydt.equalsIgnoreCase(dt)){
							nowcolor = "#A9F3A9";
						}
				
						if(uType.equalsIgnoreCase("USR")){
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</font></center></B></TD>");
							out.println("<TD><B><center>"+datatemp.getValue(3)+"&nbsp;&nbsp;("+pty+")</font></center></B></TD>");
							out.println("<TD><B><center>"+dt+"&nbsp;&nbsp;("+datatemp.getValue("total")+")&nbsp;</font></center></B></TD>");
							
							out.println("</TR>");	

						}else{
						
							if(pcn.trim().equalsIgnoreCase("P") || pcn.trim().equalsIgnoreCase("N")){
								if(pcn.trim().equalsIgnoreCase("N"))
								{
									if(pty.equalsIgnoreCase("MED"))
										wprn = "<A HREF='displaymed.jsp?id="+patid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none;'  >";
									else if(pty.equalsIgnoreCase("z00"))
										wprn = "<A HREF='problemlist.jsp' Style='text-decoration:none;'  >";
									else
										wprn = "<A HREF='writevaltext.jsp?id="+patid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none;'  >";
								}else{
										wprn = "<A HREF='writeval2.jsp?id="+patid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none;' >";
								}
							} // if p 
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</center></B></TD>");
							out.println("<TD><B><center>"+wprn+datatemp.getValue(3)+"&nbsp;&nbsp;("+pty+")</A></center></B></TD>");
							out.println("<TD><B><center>"+dt+"&nbsp;&nbsp;("+datatemp.getValue("total")+")&nbsp;</center></B></TD>");
							out.println("</TR>");	
						}
						nowcolor=tmpColor;
					}
				 } //if
			  } // else
	}
	catch(Exception e)
	{
		out.println(" Error Form "+e.toString());
	}	
%>
</TABLE>
</div>		<!-- "table-responsive" -->

<div class="table-responsive">
<TABLE class="table table-hover" bgcolor='#CECEFF'>
<%
	try
	{
			res = (Object)alldata.get(1);
			if(res instanceof String){ 
					out.println("No Pat Images");
				}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
				%>
					<TR>
						<TD  Width=10%><B><font color='blue'><CENTER>S/No</CENTER></font></B></td>
						<TD  Width=75%><B><font color='blue'> <CENTER>Images</CENTER></font></B></td>
						<TD  Width=15%><B><font color='blue'><CENTER>Date & Total</CENTER></font></B></td>
					</TR> 
				<%
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String pdt = datatemp.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = datatemp.getValue("type");
						String psl = datatemp.getValue(3);
						if (!dt.equalsIgnoreCase(tempdt)){
								if (nowcolor == "#FEFEF2") nowcolor = "#FCF6CF";
								else nowcolor = "#FEFEF2";
								tempdt=dt;
						}					
						tmpColor=nowcolor;
						if(todydt.equalsIgnoreCase(dt)){
							nowcolor = "#A9F3A9";
						}
						if(uType.equalsIgnoreCase("USR")){
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</font></center></B></TD>");
							out.println("<TD><B><center>"+ddinfo.getImageDesc(pty)+"("+pty+")</font></center></B></TD>");
							out.println("<TD><B><center>"+dt+"("+datatemp.getValue("total")+")</font></center></B></TD>");	
							out.println("</TR>");	
						}else{
							String wprn="";
							if(pty.equalsIgnoreCase("TEG")){
								wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&patid="+patid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none;' >";
							}else if(pty.equalsIgnoreCase("DCM")){						
								wprn = "<A Href='showdicom.jsp?mtype=nomark&id="+patid+"&type="+pty+"&ser="+psl+"&dt="+pdt+"'  Style='text-decoration:none;' >";

							}else{
								wprn = "<A Href='showimage.jsp?mtype=nomark&id="+patid+"&type="+pty+"&ser="+psl+"&sn="+psl+"&dt="+pdt+"'  Style='text-decoration:none;' >";
							}
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</center></B></TD>");
							out.println("<TD><B><center>"+wprn+ddinfo.getImageDesc(pty)+"("+pty+")</A></center></B></TD>");
							out.println("<TD><B><center>"+dt+"("+datatemp.getValue("total")+")</center></B></TD>");
							out.println("</TR>");	
						}
						nowcolor=tmpColor;
					}

				 }
				
			  } // else

	}
	catch(Exception e)
	{
		out.println(" Error Form "+e.toString());
	}

%>

</TABLE> 
</div>		<!-- "table-responsive" -->


<div class="table-responsive">
<TABLE class="table table-hover" bgcolor='#CECEFF'>

<%
	try
	{
	
		res = (Object)alldata.get(2);
			if(res instanceof String){ 
					out.println("No Pat Images");
				}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
					%>
					<TR>
						<TD Width=10%><B><font color='blue'><CENTER>S/No</CENTER></font></B></td>
						<TD Width=75%><B><font color='blue'> <CENTER>Documents</CENTER></font></B></td>
						<TD Width=12%><B><font color='blue'><CENTER>Date & Total</CENTER></font></B></td>
					</TR>
<%

					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String pdt = datatemp.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = datatemp.getValue("type");
						String psl = datatemp.getValue(3);
						
						if (!dt.equalsIgnoreCase(tempdt)){
								if (nowcolor == "#FEFEF2") nowcolor = "#FCF6CF";
								else nowcolor = "#FEFEF2";
								tempdt=dt;
						}
						
						tmpColor=nowcolor;

						if(todydt.equalsIgnoreCase(dt)){
							nowcolor = "#A9F3A9";
						}
				
						if(uType.equalsIgnoreCase("USR")){
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</font></center></B></TD>");
							out.println("<TD><B><center>"+ddinfo.getImageDesc(pty)+"("+pty+")</font></center></B></TD>");
							out.println("<TD><B><center>"+dt+"("+datatemp.getValue("total")+")</font></center></B></TD>");
							
							out.println("</TR>");	

						}else{


							String wprn="";
							if(pty.equalsIgnoreCase("TEG")){
								wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&patid="+patid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none;' >";


							}else if (pty.equalsIgnoreCase("snd")) {
								wprn = "<A HREF='playsound.jsp?id="+patid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none;' >"; 
							}else if (pty.equalsIgnoreCase("doc")) {
								wprn = "<A HREF='docframes.jsp?id="+patid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none;' >";
							}
						
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</center></B></TD>");
							out.println("<TD><B><center>"+wprn+ddinfo.getImageDesc(pty)+"("+pty+")</A></center></B></TD>");
							out.println("<TD><B><center>"+dt+"&nbsp;&nbsp;("+datatemp.getValue("total")+")</center></B></TD>");
							out.println("</TR>");	

						}

						nowcolor=tmpColor;
	
					}

				 }
				
			  } // else

	}
	catch(Exception e)
	{
		out.println(" Error Form "+e.toString());
	}

%>
	
</TABLE>
 </div>		<!-- "table-responsive" -->
 
<div class="table-responsive">
<TABLE class="table table-hover" bgcolor='#CECEFF'>


<%
	try
	{
	
		res = (Object)alldata.get(3);
			if(res instanceof String){ 
					out.println("No Pat Images");
				}
			else{
				Vector Vtmp = (Vector)res;
				if(Vtmp.size()>0 ) {
		%>
					<TR>
					<TD Width=10%><B><font color='blue'><CENTER>S/No</CENTER></font></B></td>
					<TD Width=75%><B><font color='blue'> <CENTER>Movie File(s)</CENTER></font></B></td>
					<TD Width=15%><B><font color='blue'><CENTER>Date & Total</CENTER></font></B></td>
					</TR>
<%
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						String pdt = datatemp.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = datatemp.getValue("type");
						String psl = datatemp.getValue(3);
						
						if (!dt.equalsIgnoreCase(tempdt)){
								if (nowcolor == "#FEFEF2") nowcolor = "#FCF6CF";
								else nowcolor = "#FEFEF2";
								tempdt=dt;
						}
						
						tmpColor=nowcolor;

						if(todydt.equalsIgnoreCase(dt)){
							nowcolor = "#A9F3A9";
						}
				
						if(uType.equalsIgnoreCase("USR")){
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</font></center></B></TD>");
							out.println("<TD><B><center>"+ddinfo.getImageDesc(pty)+"("+pty+")</font></center></B></TD>");
							out.println("<TD><B><center>"+dt+"&nbsp;&nbsp;("+datatemp.getValue("total")+")</font></center></B></TD>");
							
							out.println("</TR>");	

						}else{
							String wprn="";
						 if (pty.equalsIgnoreCase("mov")) {
							wprn="<A HREF='viewmovie.jsp?id="+patid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none;' >";
						}
							out.println("<TR bgcolor='"+nowcolor+"' >");
							out.println("<TD><B><center>"+(i+1)+"</center></B></TD>");
							out.println("<TD><B><center>"+wprn+ddinfo.getImageDesc(pty)+"("+pty+")</A></center></B></TD>");
							out.println("<TD><B><center>"+dt+"("+datatemp.getValue("total")+")</center></B></TD>");
							out.println("</TR>");	

						}

						nowcolor=tmpColor;
					}

				 }
				
			  } // else

	}
	catch(Exception e)
	{
		out.println(" Error Form "+e.toString());
	}

	
%>
</table>
</div>		<!-- "table-rsponsive" -->
</center></form>
</div>		<!-- "container-fluid" -->
</body></html>

