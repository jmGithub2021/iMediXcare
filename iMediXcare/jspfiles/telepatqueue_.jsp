<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcGenOperations,imedix.rcPatqueueInfo, imedix.rcUserInfo,imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<% 	
	cook cookx = new cook();
	Decryptcenter imc = new Decryptcenter();

	projinfo pinfo=new projinfo(request.getRealPath("/"));
	int recfrom=0, recto=0,recnavi=0,recnavi1=0,startrec=0,endrec=0;
	int pagerow=Integer.parseInt(pinfo.gblPageRow);

	String total=request.getParameter("tot");
	//out.println("request.getParameter(FirstPat) :"+request.getParameter("FirstPat"));
	recfrom=Integer.parseInt(request.getParameter("FirstPat"));
	recnavi = recfrom;	//used to show pagerow records at a time and their navigation
	startrec = recfrom;    //use startrec to hide/show name
	recto = Integer.parseInt(request.getParameter("LastPat"));
	recnavi1 = recto;    //used to show pagerow records at a time and their navigation
	endrec = recto;

	String CentType = "remote";
	//out.println("CentType"+CentType);

	String lcode = cookx.getCookieValue("center", request.getCookies ());
	String rccode=request.getParameter("rccode");

	cookx.addCookie("currpatqcenter",rccode,response);

	cookx.addCookie("currpatqtype","tele",response);

	//if(rccode==null) rccode="";
	//if(rccode.equals("")) rccode= lcode;
	//cookx.addCookie("rccode",rccode,response);
	
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());
	
	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));


%>
<HTML>
<HEAD>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
<script src="../bootstrap/jquery-2.2.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script src="../bootstrap/dataTables.bootstrap.min.js"></script>


<STYLE>

A {text-decoration: none;
   color: BLUE;
   font-weight: BOLD;
   }
tbody tr:nth-child(odd) {
    background: rgba(205, 211, 245, 0.66);
}
tbody tr:nth-child(even) {
    background: #EEE;
}
input[type=checkbox] {
    margin: 0;
    height: 22px;
    width: 33px;
}
</STYLE>
<SCRIPT language="JavaScript" type="text/javascript">

	$(document).ready(function() {
		$("#tpatbl").dataTable({
			 "lengthMenu": [[5,10,-1], [5,10,"All"]],
			 "info":     false
		});
	});

function writetoLyr(id, message) {
	if (document.getElementById(id).style.visibility=="visible") {
		document.getElementById(id).style.visibility="hidden";
	}
	else {
		document.getElementById(id).style.visibility="visible";
	}

	document.getElementById(id).innerHTML = message;
}
function HideLyr() {
	document.contentLYR.style.visibility="hidden";
}
function show(msg) {
	document.getElementById(msg).style.visibility="visible";
}

function goToPage(a) {

	  x=a;
	  comma = x.indexOf(",");
	  first = x.substring(0,comma);
	  last = x.substring(comma+1,x.length);
	  all = <%=total%>;
	  ccode=<%=rccode%>;
	  var page = "telepatqueue.jsp?rccode="+ccode+"&FirstPat="+first+"&LastPat="+last+"&tot="+all;
	  alert(x); alert(first); alert(last); alert(all); alert(page);
	  document.location.href = page; 

  }

function delpatq(chobj)
{
	var str="",tar;

	for(var i=0;i<chobj.length;i++)
	{
		if(chobj[i].checked)
		{
			str=str+chobj[i].name+i+"="+chobj[i].value+"&"
		}
	
	}

tar="deltelepatq.jsp?"+str;
	window.location=tar;
}

</script>
<% if (CentType.equalsIgnoreCase("local")) {%>
<SCRIPT language="JavaScript" type="text/javascript">
	function CheckAll(chk)
	{
	for (var i=0;i < document.forms[0].elements.length;i++)
	{
	var e = document.forms[0].elements[i];
	if (e.type == "checkbox")
		{
		 e.checked = chk.checked;
		}
	}
	}
</SCRIPT>
<% } 
   else  { %>
<SCRIPT language="JavaScript" type="text/javascript">
	function CheckAll(chk)
	{
	for (var i=0;i < document.forms[0].elements.length;i++)
	{
	var e = document.forms[0].elements[i];
	if (e.type == "checkbox")
		{
		 e.checked = true;
		}
	}
	}
</SCRIPT>


<% } %>
<SCRIPT language="JavaScript" type="text/javascript">
<!--

function assph(chobj)
{

var str="",tar,phy;
phy=document.frm.selphy.value
	for(var i=0;i<chobj.length;i++)
	{
		if(chobj[i].checked)
		{
			str=str+chobj[i].name+i+"="+chobj[i].value+"&"
		}
	
	}

	tar="teleupdatephysician.jsp?regcode="+phy+"&"+str;
	window.location=tar;
}

function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }



function cookupdate(val1)
{	
	var preval,cncode;
	cncode=val1.substring(val1.indexOf("=")+1);
	document.cookie="currem="+cncode;
}
	
function showselected(val,range)
{
	cookupdate(val);
	var tar;
	tar="telebrowse.jsp?"+val+"&"+range;
	//alert(tar);
	//window.location=tar;
	var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(tar);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
}


function cc(val2)
{
var tar1;
tar1="telebrowse.jsp?"+val2;
window.location=tar1;
//parent.bot.location=tar1;

}

function sndfn(vv)
{
var sndtar;
sndtar="sendtolocaltest.jsp?"+vv;
window.location=sndtar;
//alert(sndtar);
}
-->
</SCRIPT> 
</HEAD>


<BODY bgcolor="#FAF5F5" Color="#0000FF" background="../images/txture.jpg">
<div class="container-fluid">
<FORM class="form-inline" role="form" METHOD="GET" NAME="frm" ACTION="">
<INPUT TYPE="hidden" NAME=CentType Value="<%=CentType%>">

<% 			
int firstpat=0,lastpat=0;
String sqlQuery="",strsql="",sqlQuery1="" ;
String qsql="";
String hosname="",lhosname="";

if(rccode.equals("XXXX")) hosname="ALL Hospital ";
else hosname=rcci.getHosName(rccode);

if(lcode.equals("XXXX")) lhosname="ALL Hospital ";
else lhosname=rcci.getHosName(lcode);


//String hosname=rcci.getHosName(rccode);
if(lcode.equals("XXXX")){
	out.println("<Font color=blue ><H3><center>Tele Patient Queue(of "+ hosname +")</center></H3></Font>");
}else{
	out.println("<Font color=blue ><H3><center>Tele Patient Queue(of "+ lhosname + " from "+ hosname + ") </center></H3></Font>");
}
out.println("<CENTER><FONT COLOR='#990033'>Number of Patient(s) in Q </FONT> <FONT size='+1' COLOR='#330000'><B>:</B></FONT> <FONT SIZE='+1' COLOR=#FD5200><B>"+total+"</B></FONT></CENTER>");
 %>

<div class="table-responsive">
<table class="table" >
<tr>
<td>

<% if(utyp.equals("adm") || utyp.equals("sup")) { %>
<INPUT class="form-control" style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmddel onClick='delpatq(this.form.ch)' value="Delete" />
&nbsp;<INPUT class="form-control" style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmdass onClick='assph(this.form.ch)' value="Assign Physician" />

<%
	out.println ("<B>&nbsp;Choose Physician </B><SELECT class='form-control' name='selphy' WIDTH='150' STYLE='width: 150' >");
	out.println("<Option value=''>-Select-</Option>");
	try {
		String cnd="";
		Object res="";
		if(lcode.equals("XXXX")){
			res=rcui.getAllUsers(rccode,"doc","A");
		}else{
			//cnd="type='doc' AND center='"+lcode+"' ORDER BY name ASC";
			//res=rcui.getValues("rg_no,name,center",cnd);
			res=rcui.getAllUsers(lcode,"doc","A");
		}
		
	
		

		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			out.println ("<Option Value='"+temp.getValue("rg_no").trim()+"'>"+temp.getValue("name").trim()+ "("+temp.getValue("center")+")</OPTION>");
			//out.println ("<Option Value='"+regcode.trim()+"'>"+dname.trim()+"</OPTION>");
		}
	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
	out.println ("</SELECT>");
} 


	if(utyp.equals("doc")){
		out.println ("<B>Choose Center </B><SELECT class='form-control' NAME=cent onChange='showselected(cent.value);'  WIDTH='450' STYLE='width: 450' >");
	}else{
	out.println ("&nbsp;<B>Choose Center </B><SELECT class='form-control' NAME=cent onChange='showselected(cent.value);'  WIDTH='330' STYLE='width: 330' >");
	}
	//out.println("<Option></Option>");
	try {

		String refed_all=rcGen.getAnySingleValue("referhospitals","referring","code='"+lcode+"'");
		String validity="";

		Object res=rcci.getAllCentreInfo();
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String ccode = temp.getValue("code").trim();
			String cname = temp.getValue("name").trim();
			String visibility = temp.getValue("visibility").trim();

			String expdate = imc.decryptLicString(  temp.getValue("expdate") );
			java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
			
			java.util.Date today = new java.util.Date();
			long timeDiff = expDate.getTime() - today.getTime();
			long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
			if (daysDiff<15) validity = " [ only " + daysDiff + " day(s) left ] " ;
			else validity = "";
		
			if (visibility.equalsIgnoreCase("Y")) {
				if(lcode.equals("XXXX")){
					if(ccode.equals(rccode))
						out.println ("<Option Value='rccode="+ccode.trim()+"' selected>("+ccode.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
					else
						out.println ("<Option Value='rccode="+ccode.trim()+"'>("+ccode.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
			   }else{
					if(refed_all.indexOf(ccode)>-1){
						if(ccode.equals(rccode))
							out.println ("<Option Value='rccode="+ccode.trim()+"' selected>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
						else
							out.println ("<Option Value='rccode="+ccode.trim()+"'>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
					}
			   }
			}
		}// end for

	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
	out.println ("</SELECT>"); 
	
%>

</td>
</tr>
</table>
</div>		<!-- "table-responsive" -->

<div class="table-responsive">
<TABLE class="table dataTable" id="tpatbl" name="tpatbl">

<% if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Entry Date &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician &nbsp;&nbsp;</B></FONT>
	<INPUT type='checkbox' name='ch' Value='' style="visibility:hidden">

	</TD>
</TR>
</THEAD>
<TBODY>
<% } %>
<% if(utyp.equals("doc")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>EntryDate &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician &nbsp;&nbsp;</B></FONT></TD>
</TR>
</THEAD>
<TBODY>	
<% } %>


<%	String data="",del="";
	boolean f=false;

	try
	{
		String chkName, id, idChk, Na="", Cl, uNa,dte="",doc="",docname="",adoc="",adocname="";
		boolean t=true;
		int count=0;


		if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con"))
		{
		  Object res=rcpqi.getRPatqueueAdmin(lcode,rccode,recfrom,recto);

		  if(res instanceof String){
			out.println( "res :"+ res);
			}else{
			Vector tmp = (Vector)res;
			//RSet.absolute(recfrom);
			//out.println("tmp.size() :"+tmp.size());

			firstpat=recfrom;
			 lastpat=recto;	
			 //RSet.previous();	//////
			//out.println(recfrom+":"+tmp.size());
			 for(int i=1;i<=tmp.size();i++){ //recfrom
				dataobj temp = (dataobj) tmp.get(i-1);
				doc=temp.getValue("refer_doc").trim();
				//out.println(recfrom+":'"+doc+"'");
				adoc=temp.getValue("assigneddoc").trim();
				
				if(doc!=null) docname= rcui.getName(doc);
				else docname="--";

				if(adoc!=null && !adoc.equals("") ) adocname= rcui.getName(adoc);
				else adocname="--";

				id = temp.getValue("pat_id");
				Na = temp.getValue("pat_name");
				Cl = temp.getValue("class");

				if (t==true) { out.println("<TR>");	t=false; }
				else { out.println("<TR>"); t=true; }

				f=true;
				count++;
				del=temp.getValue("checked");

				if(del.equals("Y"))
				{	out.println("<TD><Font color=red><B>"+(i+recfrom)+"</B></Font></TD>"); 
					//out.println("<TD><Font color=red><B>"+i+"</B></Font></TD>"); 
				}
				else
				{	out.println("<TD><B>"+(i+recfrom)+"</B></TD>"); 
					//out.println("<TD><B>"+i+"</B></TD>"); 
				}

				chkName = "SC" + Integer.toString(count);

				out.println("<TD>");
				out.println("<INPUT type='checkbox' name='ch' Value='"+id+"'>");
				out.println("</TD>");

				if(del.equals("Y")){
					out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=red>"+ id + 	"</Font></A></B></TD>");
					
					out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=red>Summary</Font></A></B></TD>");

				}else {
					out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></B></TD>");

					out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");
				}

				if(del.equals("Y"))  out.println("<TD><Font color=red>"+ Cl +"</Font></TD>");
				else out.println("<TD>"+ Cl +"</TD>");
			
				dte=temp.getValue("entrydate");

				if(del.equals("Y"))
				{
					out.println("<TD><Font color=red>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</Font></TD>");
					out.println("<TD><Font color=red>"+docname+"<Font></TD>");
					out.println("<TD><Font color=red>"+adocname+"<Font></TD>");
				}
				else
				{
					out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</TD>");
					out.println("<TD>"+docname+"</TD>");
					out.println("<TD>"+adocname+"</TD>");
				}
				

				out.println("</TR>");
				//recfrom=recfrom+1;
				//if(recfrom > recto) break;
			} // end for
		   } // end if obj
		} // if adm

///////////////


if(utyp.equals("doc")){
		String dreg = rcui.getreg_no(usr);
		
		Object res=rcpqi.getRPatqueueDoc(rccode,dreg,recfrom,recto);

		if(res instanceof String){
			out.println( "res :"+ res);
		}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;	
			//out.println("tmp.size() :"+tmp.size());

			for(int i=1;i<=tmp.size();i++){ //recfrom
			dataobj temp = (dataobj) tmp.get(i-1);
			doc=temp.getValue("refer_doc").trim();
			if(doc!=null) docname= rcui.getName(doc);
			else docname="--";	

			id = temp.getValue("pat_id");
			Na = temp.getValue("pat_name");
			Cl = temp.getValue("class");

			if (t==true) { 
				out.println("<TR BGColor=#F7DDFF>");
				t=false;
			}
			else { 
				out.println("<TR BGColor=#DDF0FF>");
				t=true;
			}		
			count++;
			// for checked patient details should be displayed in different color
			del=temp.getValue("checked");
			
			if(del.equals("Y")) out.println("<TD><Font color=green><B>"+(i+recfrom)+"</B></Font></TD>"); 
			else out.println("<TD><B>"+(i+recfrom)+"</B></TD>");

			if(del.equals("Y")) {
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"&patdis="+Cl+"'> <Font color=green>"+ 	id + "</Font></A></TD>");

				out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=green>Summary</Font></A></B></TD>");


			}else{
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></TD>");

				out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");

			}

			if(del.equals("Y")) out.println("<TD><Font color=green>"+Cl+"</Font></TD>"); 
			else	out.println("<TD>"+Cl+"</TD>"); 
		
			dte=temp.getValue("entrydate");
		
			if(del.equals("Y")) out.println("<TD><Font color=green>" +dte.substring(0,4) +"/"+ dte.substring(5,7)+ "/"+dte.substring(8,10) +"</Font></TD>"); 
			else out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10)+"</TD>"); 
			
			if(del.equals("Y")) out.println("<TD><Font color=green>" +docname +"</Font></TD>"); 
			else out.println("<TD>"+docname+"</TD>"); 

			out.println("</TR>");
				//recfrom=recfrom+1;
				// if(recfrom > recto)
				// break;
			} // end for
		} // if obj
	} // if doc

		out.println("</TBODY></TABLE>");
		out.println("</div>");		//<!-- "table-responsive" -->
		/*
		if (count==0) {
			out.println("<BR><BR><FONT SIZE=+1 COLOR=RED><B><center>No Data Available</center></B></FONT>");		
		}
		*/
} catch(Exception e){ 
	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	e.printStackTrace(pw);
	out.println("exception occur doc "+sw.toString()); 
}

 %>

<!--<INPUT type="radio" name="unsent" Value="y" > <B>Send Unsent </B>
<INPUT type="radio" name="unsent" Value="n" checked > <B>Send All </B> -->
<br>

<center>
<TABLE class="table">
<TR>
 <td valign='top' width=200>

 <%/* if(recnavi != 1)
     {
	 String navigatepre="";
	 navigatepre = "patqueue.jsp?FirstPat="+String.valueOf(recnavi-pagerow)+"&LastPat="+String.valueOf(recnavi1-pagerow)+"&tot="+total;
%>
	 <A HREF="<%=navigatepre%>"><img class="img-responsive" border=0 src=../images/previous.jpg ></A>&nbsp;&nbsp;
 <%} */%>

  <font face='MS sans-serif,Verdana, Arial, Helvetica'>Page 
 <!-- <select class='dropdown ' name="choosepage" onChange='goToPage(this.frm.choosepage.options[this.frm.choosepage.selectedIndex].value);' > -->
<select class='dropdown form-control' name="choosepage" onChange='showselected("rccode=<%=rccode%>",this.value);' >

  <%
  
	int X=0, Y=0, Index=0, Display=0,selectedy=0;
	int counter = 0;
	for(Index = 1; Index<=Integer.parseInt(total) ; Index=Index+pagerow)
	{
		X = Index;
		//Y = Index + (pagerow-1);
		Y = pagerow;
		counter = counter +1;

		Display=Index;
		if(recnavi == X)
		{
			selectedy = Y;
			out.println("<option selected value='F="+String.valueOf(X)+"&L="+String.valueOf(Y)+"'>"+String.valueOf(counter)+"</option>");
		}
		else
		{
			out.println("<option value='F="+String.valueOf(X)+"&L="+String.valueOf(Y)+"'>"+String.valueOf(counter)+"</option>");	
		}
	}
%>
 </select> of <%=counter%></font>

 <% /*if(selectedy < Integer.parseInt(total))
    { 
	 String navigatenext="";
	navigatenext = "telepatqueue.jsp?rccode="+rccode+"&FirstPat="+String.valueOf(recnavi+pagerow)+"&LastPat="+String.valueOf(recnavi1+pagerow)+"&tot="+total;
%>
	&nbsp;&nbsp; <A HREF="<%=navigatenext%>"><img class="img-responsive" border=0 src=../images/next.gif ></A>

 <%}*/%>
 <br>
<i><b>Please Note:</b> This drop down fetches <%=pagerow %> records per navigation </i>
<!-- </td><td width=50><A HREF="javascript:location.reload()">Reload<br>List</td> 
<A HREF="javascript:location.reload()"><IMG class="img-responsive" SRC="../images/refresh.jpg" WIDTH="22" HEIGHT="22" BORDER=1 ></A>
-->
 </TR>
 </TABLE> 
</center>
</FORM>

</div>		<!-- "container-fluid" -->
</body>
</html>
