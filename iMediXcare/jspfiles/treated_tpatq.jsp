<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcPatqueueInfo,imedix.rcGenOperations,imedix.rcUserInfo, imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<% 	
	cook cookx = new cook();
	projinfo pinfo=new projinfo(request.getRealPath("/"));
    Decryptcenter imc = new Decryptcenter();
	String ccode ="",centtype="",usr="";
	// variable to show ten record at a time
	int recfrom=0, recto=0,recnavi=0,recnavi1=0,startrec=0,endrec=0;
	int pagerow=Integer.parseInt(pinfo.gblPageRow);

	String total="", cb="";
	//total=request.getParameter("tot");

	recfrom=Integer.parseInt(request.getParameter("FirstPat"));

	recnavi = recfrom;	//used to show pagerow records at a time and their navigation
	startrec = recfrom;    //use startrec to hide/show name
	recto = Integer.parseInt(request.getParameter("LastPat"));

	recnavi1 = recto;    //used to show pagerow ecords at a time and their navigation
	endrec = recto;
		
	ccode= cookx.getCookieValue("center", request.getCookies ());

	String curCCode= request.getParameter("curCCode");

	cookx.addCookie("currpatqcenter",curCCode,response);
	cookx.addCookie("currpatqtype","tele",response);

	//if(curCCode==null) curCCode="";
	//if(curCCode.equals("")) curCCode=ccode;

	centtype = "tele";
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	usr=cookx.getCookieValue("userid", request.getCookies());

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
	rcGenOperations rcGen = new rcGenOperations(request.getRealPath("/"));
	
	
	String dreg=rcui.getreg_no(usr);
	
	if(utyp.equals("adm")||utyp.equals("sup"))
		total = rcpqi.getTotalRPatTreatedAdmin(""+ccode+"",""+curCCode+"");
	else if(utyp.equals("doc"))
		total = rcpqi.getTotalRPatTreatedDoc(""+curCCode+"",""+dreg+"");
	else
		total = "0";
	//out.println("<br><br>"+ccode+" : "+dreg+" : " +curCCode+" :: "+total);

%>


<HEAD>


	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/jquery.dataTables.min.js"></script>
	<script src="../bootstrap/dataTables.bootstrap.min.js"></script>
	<LINK REL="SHORTCUT ICON" HREF="../images/icon1.ico"> 

	<style>
	thead tr{background:#349198;color:#fff;font-weight:600;}
	tbody tr:nth-child(odd){background:rgb(221, 240, 249);}
	tbody tr:nth-child(even){background:#f0f6f9;}
	.mtolpatq{cursor:pointer;color:#f95d01;}
	</style>






<SCRIPT language="JavaScript" type="text/javascript">
$(document).ready(function() {
		$("#patbl").dataTable({
			 "lengthMenu": [[5,10,-1], [5,10,"All"]],
			 "info":     false
		});
		
/* Patient move treated patient queue to tpatq function is written in jquery.dataTables.min.js file */
	
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

function goToPage(a,currCnt) {

	  x=a;
	  comma = x.indexOf(",");
	  first = x.substring(0,comma);
	  last = x.substring(comma+1,x.length);
	  all = <%=total%>;	  
	  var page = "treatedbrowse.jsp?FirstPat="+first+"&LastPat="+last+"&tot="+all+"&curCCode="+currCnt;
	  //alert(page); 
	  //document.location.href = page; 
	  var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(page);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
  }


</script>

<% if (centtype.equalsIgnoreCase("local")) {%>
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
/*
function abc(chobj)
{

var str="",tar,phy,ln
phy=document.frm.selphy.value

ln=chobj.length
	for(var i=0;i<ln;i++)
	{
		if(chobj[i].checked)
		{
			str=str+chobj[i].name+i+"="+chobj[i].value+"&"
		}
	}
tar="updatephysician.jsp?regcode="+phy+"&"+str
window.location=tar
}
*/


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
	tar="treatedbrowse.jsp?"+val+"&"+range;
	//alert(tar);
	//window.location=tar;
	var ajax_load = "<img class='loading' src='../images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(tar);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
}



</SCRIPT>
<script>
$(document).ready(function(){

});
</script>
</HEAD>

<HTML>

<BODY background="../images/txture.jpg" onLoad="document.getElementById('siteLoader').style.display = 'none';">

<div id='siteLoader' hidden>
	 <H3><CENTER><BR>
	 	 <FONT COLOR="#00CCCC">......Please Wait......</FONT><BR><BR>
		 <IMG class="img-responsive" SRC="../images/loading.gif" WIDTH="100" HEIGHT="20" BORDER="0" ALT="" bordercolor=RED><BR>
	 </CENTER>
	 </H3>
</div>

<div class="container-fluid">
<div class="row">

<div class="col-sm-12">
<FORM class="form-inline" role="form" METHOD=GET name=frm ACTION="">
<INPUT type="hidden" name=centtype Value="<%=centtype%>">
<% 			
int firstpat=0,lastpat=0;
String sqlQuery="",strsql="",sqlQuery1="" ;
String qsql="";
String hosname=rcci.getHosName(curCCode);
out.println("<Font color=blue ><H3><center>Treated Tele Patient Queue(Of "+ hosname +")</center></H3></Font>");
out.println("<center><FONT COLOR='#990033'>Number of Patient(s) in Q </FONT> <FONT size='+1' COLOR='#330000'><B>:</B></FONT> <FONT SIZE='+1' COLOR=#FD5200><B>"+total+"</B></FONT></center>");
%>
<div class="table-responsive">
<table class="table">
<tr>
<td>

<%/* if(utyp.equals("adm") || utyp.equals("sup")) { */%>
<!-- &nbsp;<INPUT class="form-control" style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmdass onClick='assph(this.form.ch)' value="Assign Physician" />-->

<%/*
	out.println ("<B>&nbsp;Choose Physician </B><SELECT class='form-control' name='selphy' WIDTH='150' STYLE='width: 150' >");
	out.println("<Option value=''>-Select-</Option>");
	try {
		String cnd="";
		Object res="";
		if(ccode.equals("XXXX")){
			res=rcui.getAllUsers(curCCode,"doc","A");
		}else{
			//cnd="type='doc' AND center='"+lcode+"' ORDER BY name ASC";
			//res=rcui.getValues("rg_no,name,center",cnd);
			res=rcui.getAllUsers(ccode,"doc","A");
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
*/

	if(utyp.equals("doc")){
		out.println ("<B>Choose Center </B><SELECT class='form-control ch-center' NAME=cent onChange='showselected(cent.value);'  WIDTH='450' STYLE='width: 450' >");
	}else{
	out.println ("&nbsp;<B>Choose Center </B><SELECT class='form-control ch-center' NAME=cent onChange='showselected(cent.value);'  WIDTH='330' STYLE='width: 330' >");
	}
	//out.println("<Option></Option>");
	try {

		String refed_all=rcGen.getAnySingleValue("referhospitals","referring","code='"+ccode+"'");
		String validity="";

		Object res=rcci.getAllCentreInfo();
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String ccode1 = temp.getValue("code").trim();
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
				if(ccode.equals("XXXX")){
					if(ccode1.equals(curCCode))
						out.println ("<Option Value='curCCode="+ccode1.trim()+"' selected>("+ccode1.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
					else
						out.println ("<Option Value='curCCode="+ccode1.trim()+"'>("+ccode1.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
			   }else{
					if(refed_all.indexOf(ccode1)>-1){
						if(ccode.equals(curCCode))
							out.println ("<Option Value='curCCode="+ccode1.trim()+"' selected>("+ccode1.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
						else
							out.println ("<Option Value='curCCode="+ccode1.trim()+"'>("+ccode1.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
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
<table  class="table" id="patbl" name="patbl">

<% if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Entry Date &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician &nbsp;&nbsp;</B></FONT>
	<INPUT type='checkbox' name='ch' Value='' style="visibility:hidden">

	</TD>
	<td><FONT COLOR="#FFFFFF">Last checked</FONT></td>
	<td>Status</td>
</TR>
</THEAD>
<TBODY>
<% } %>
<% if(utyp.equals("doc")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>EntryDate &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician &nbsp;&nbsp;</B></FONT></TD>
	<td><FONT COLOR="#FFFFFF">Last checked</FONT></td>
	<td>Status</td>
</TR>
</THEAD>
<TBODY>
<% } %>


<%	String data="",del="";
	boolean f=false;

	try
	{	
		String chkName, id, idChk, Na, Cl, uNa,dte="",doc="",docname="",last_check="",adoc="",adocname="";
		boolean t=true;
		int count=0;
		if(utyp.equals("adm") || utyp.equals("usr") || utyp.equals("sup") || utyp.equals("con"))
		{
		  Object res=rcpqi.getRPatqueueTreatedAdmin(ccode,curCCode,recfrom,recto);
		  if(res instanceof String){
			out.println( "res :"+ res);
			}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;	
			 for(int i=1;i<=tmp.size();i++){ //recfrom
				dataobj temp = (dataobj) tmp.get(i-1);
				doc=temp.getValue("referring_doctor");
				adoc=temp.getValue("assigneddoc").trim();
				if(doc!=null) {
					docname= rcui.getName(doc);
				}
				else docname="--";		
				
				if(adoc!=null && !adoc.equals("") ) adocname= rcui.getName(adoc);
				else adocname="--";
				
				id = temp.getValue("pat_id");
				last_check = temp.getValue("data_moved");
				//Na = temp.getValue("pat_name");
				Na = "*";
				Cl = temp.getValue("class");
				Cl = Cl.replaceAll("<br>","");
				if (t==true) { out.println("<TR >");	t=false; }
				else { out.println("<TR >"); t=true; }

				f=true;
				count++;

				
				if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")){

						out.println("<TD><B><A class='btn btn-default' HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></B></TD>");
						

				
				}else if(utyp.equals("usr")){

					out.println("<TD><B><A HREF='oldpatid.jsp?id="+id+"&usr=adm&nam="+Na+"'>"+ id + "</A></B></TD>");
				
				}


				out.println("<TD>"+ Cl +"</TD>");
			
				dte=temp.getValue("entrydate");

					out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</TD>");
					out.println("<TD>"+docname+"</TD>");
					out.println("<TD>"+adocname+"</TD>");
					out.println("<TD>"+last_check.substring(0,4)+"/"+last_check.substring(5,7)+"/"+last_check.substring(8,10) + "</TD>");
					out.println("<td class='pat_move "+id+"'  pat-id='"+id+"'><span class='glyphicon glyphicon-export mtolpatq'></span></td>");
				

				out.println("</TR>");
				//recfrom=recfrom+1;
				//if(recfrom > recto) break;
			} // end for
		   } // end if obj
		} // if adm


/////////////////

	if(utyp.equals("doc")){
		
		Object res=rcpqi.getRPatqueueTreatedDoc(curCCode,dreg, recfrom,recto);

		if(res instanceof String){
			out.println( "res :"+ res);
		}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;	
			for(int i=1;i<=tmp.size();i++){ //recfrom
			dataobj temp = (dataobj) tmp.get(i-1);
			id = temp.getValue("pat_id");
			last_check = temp.getValue("data_moved");			
			//Na = temp.getValue("pat_name");
			Na = "*";
			Cl = temp.getValue("class");
			
			if (t==true) { 
				out.println("<TR>");
				t=false;
			}
			else { 
				out.println("<TR>");
				t=true;
			}		
			count++;
			// for checked patient details should be displayed in different color



				out.println("<TD><A class='btn btn-default' HREF='showpatdata.jsp?id="+id+"&usr=doc&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></TD>");

			out.println("<TD>"+Cl+"</TD>"); 
		
			dte=temp.getValue("entrydate");
			out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10)+"</TD>"); 
			out.println("<TD>"+docname+"</TD>");
			out.println("<TD>"+last_check.substring(0,4)+"/"+last_check.substring(5,7)+"/"+last_check.substring(8,10) + "</TD>");
			out.println("<td class='pat_move "+id+"' pat-id='"+id+"'><span class='glyphicon glyphicon-export mtolpatq'></span></td>");
				
			out.println("</TR>");
				//recfrom=recfrom+1;
				// if(recfrom > recto)
				 //break;
			} // end for
		} // if obj
	} // if doc

		out.println("</TBODY></TABLE>");
		/*
		if (count==0) {
			out.println("<BR><BR><FONT SIZE=+1 COLOR=RED><B><CENTER>No Data Available</CENTER></B></FONT>");		
		}*/
} catch(Exception e){ 
	StringWriter sw = new StringWriter();
	PrintWriter pw = new PrintWriter(sw);
	e.printStackTrace(pw);
	out.println("exception occur doc "+sw.toString()); 
	//out.println("exception occur "+e); 
}

 %>
 </table>
</div>		<!-- "table-responsive" -->

<br>
<center>
<TABLE class="table" Border=0 cellspacing=0 cellpadding=0 WIDTH='930'>
<TR> <td valign='top' >

 <% /*if(recnavi != 1) 
   {
	 String navigatepre="";
	 navigatepre = "patqueue.jsp?FirstPat="+String.valueOf(recnavi-pagerow)+"&LastPat="+String.valueOf(recnavi1-pagerow)+"&tot="+total+"&curCCode="+curCCode;
	 //navigatepre = "browse.jsp?curCCode="+curCCode;
  %>
	<A HREF="<%=navigatepre%>"><img border=0 src=../images/previous.jpg ></A>&nbsp;&nbsp;
  <% }*/%>

  <font face='MS sans-serif,Verdana, Arial, Helvetica'>Page 
<!--<select class='dropdown ' name="choosepage" onChange='goToPage(this.frm.choosepage.options[this.frm.choosepage.selectedIndex].value);' > 
-->
<select class='dropdown form-control' name="choosepage" onChange='showselected("curCCode=<%=curCCode%>",this.value);' >

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
	 navigatenext = "patqueue.jsp?FirstPat="+String.valueOf(recnavi+pagerow)+"&LastPat="+String.valueOf(recnavi1+pagerow)+"&tot="+total+"&curCCode="+curCCode;
	 //navigatenext = "browse.jsp?curCCode="+curCCode;
%> 
	&nbsp;&nbsp; <A HREF="<%=navigatenext%>"><img class="img-responsive" border=0 src=../images/next.gif ></A>

 <%}*/%><br>
<i><b>Please Note:</b> This drop down fetches <%=pagerow %> records per navigation </i>
</td><!--
<td width=100>  <td width=150>
<a class="btn btn-info btn-xs" href="localpatientsearch.jsp"><h4>Local Patient</h4></a>
</td>

	<div> <form id="dummy"></form></div>
	<form class="role" method="POST" action="searchresult.jsp" NAME=serpat>
	<table>
	<tr>
	<td><input name='name' id='name' class='form-control' size='15' ></td>
	<td>
	<input name='R1' id='R1' type='hidden' value='name'>
	<INPUT class="form-control" TYPE="hidden" NAME="que" ID="que" value="Local"> 
	<INPUT class="form-control" TYPE="hidden" NAME="cb" ID="cb" value="<%=cb%>">	
	<input name='idsub' id='idsub' type=submit class='btn btn-md btn-primary' value='Load Patient'>
	</td>
	</tr>
	</table>
	</form>
</td>
-->
 </TR>
</table>
</form>

</div>		<!-- "col-sm-12" -->

</div>		<!-- "row" -->
</div>		<!-- "fluid-container" -->

</body>
</HTML>
