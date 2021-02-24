<%@page contentType="text/html" import="imedix.RemoteCalls,imedix.dataobj,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<% 	
	cook cookx = new cook();

	String ccode ="",centtype="",usr="";

	// variable to show ten record at a time
	int recfrom=0, recto=0,recnavi=0,recnavi1=0,startrec=0,endrec=0;
	String total="";

	total=request.getParameter("tot");
	recfrom=Integer.parseInt(request.getParameter("FirstPat"));
	recnavi = recfrom;	//used to show 10 ecords at a time and their navigation
	startrec = recfrom;    //use startrec to hide/show name
	recto = Integer.parseInt(request.getParameter("LastPat"));
	recnavi1 = recto;    //used to show 10 ecords at a time and their navigation
	endrec = recto;
	//ccode = thisObj.getCookieValue("node", request.getCookies ());

	ccode =cookx.getCookieValue("node", request.getCookies ());
	if (ccode.trim().length() == 0){
			ccode = cookx.getCookieValue("center", request.getCookies ());
			centtype = "local";
	}else{
			centtype = "local";
	}

	String utyp=cookx.getCookieValue("usertype", request.getCookies());

	usr=cookx.getCookieValue("userid", request.getCookies());
	
	RemoteCalls rcall=new RemoteCalls(request.getRealPath("/"));

%>
<HEAD>
<STYLE>
A {text-decoration: none;
   color: BLUE;
   font-weight: BOLD;
   }
</STYLE>
<SCRIPT language="JavaScript" type="text/javascript">
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
	  //alert(x); alert(first); alert(last); alert(all); alert(page);
	  page = "patqueue.jsp?FirstPat="+first+"&LastPat="+last+"&tot="+all;
	  document.location.href = page; 

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

tar="delocalpatq.jsp?"+str;
	window.location=tar;
}
</SCRIPT>

</HEAD>

<% 	

	int firstpat=0,lastpat=0;
	String sqlQuery="",strsql="",sqlQuery1="" ;
	String qsql="";

	//strsql="select count(PAT_ID) from PATQ where left(PAT_ID,3)='"+ccode+"'";

	if(utyp.equals("adm"))
	{	//////////////////  this will be change
		sqlQuery = " select distinct LPATQ.PAT_ID,LPATQ.delflage, "; 
		sqlQuery = sqlQuery + " LPATQ.ENTRYDATE, med.REFERRING_DOCTOR, med.PAT_NAME,med.CLASS ";
		//sqlQuery = sqlQuery + " LPATQ.ENTRYDATE, LPATQ.APPDATE,med.REFERRING_DOCTOR, med.PAT_NAME,med.CLASS ";
		sqlQuery = sqlQuery +  " from LPATQ, med  ";
		sqlQuery = sqlQuery +  " where upper(LPATQ.PAT_ID)=upper(med.PAT_ID)  and ";
		sqlQuery = sqlQuery +  " upper(left(med.PAT_ID,3)) = '"+ccode.toUpperCase()+"'";
		sqlQuery = sqlQuery +  " order by LPATQ.ENTRYDATE DESC, LPATQ.PAT_ID DESC ";
	}

	if(utyp.equals("doc"))
	{
	//////////////////  this will be change
	//String dreg=getDocreg(usr,gbldbjdbcDriver,gbldbURL,gbldbusername,gbldbpasswd);
	qsql = "Select RG_NO from LOGIN Where upper(UID) = '"+usr.toUpperCase()+"'";
	String dreg = rcall.FindSingle(qsql);
	sqlQuery = "select LPATQ.*, med.PAT_NAME,med.CLASS from LPATQ , med where upper(LPATQ.ASSIGNEDDOC)='"+dreg.toUpperCase()+"' AND LPATQ.delflage='no' and upper(LPATQ.PAT_ID)=upper(med.PAT_ID)";
	}
%>

<!-- <HR SIZE=3 align=left Color=BLUE Width=800> -->

<FORM METHOD=GET NAME=frm ACTION="">
<INPUT TYPE="hidden" NAME=centtype Value="<%=centtype%>">

<% 			

//String hosname=getHosName();
qsql = "Select NAME from CENTER Where upper(CODE) = '"+ccode.toUpperCase()+"'";
String hosname=rcall.FindSingle(qsql);

out.println("<Font color=blue ><H3><center>Local Patient Queue(Of "+ hosname +")</center></H3></Font>");
out.println("<CENTER><FONT COLOR='#990033'>Number of Patient(s) in Q </FONT> <FONT size='+1' COLOR='#330000'><B>:</B></FONT> <FONT SIZE='+1' COLOR=#FD5200><B>"+total+"</B></FONT></CENTER>");

 %>
<HR SIZE=3 align=center Color=BLUE Width=800>
<Table hspace=83>
<TR><TD>

<% if(utyp.equals("doc")) { %>

<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff';background-border: '1px groove #146bee'" TYPE=Button name=cmddel onClick='delpatq(this.form.ch)' value="    Delete    "> -->

<% } %>

<% if(utyp.equals("adm")) { %>
&nbsp;&nbsp;&nbsp;&nbsp;<INPUT style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff';background-border: '1px groove #146bee'" TYPE=Button name=cmddel onClick='delpatq(this.form.ch)' value="Delete">
&nbsp;&nbsp;&nbsp;&nbsp;<INPUT style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmdass onClick='abc(this.form.ch)' value="Assign Physician">
<%
	out.println ("<B>Choose Physician </B><SELECT NAME=selphy >");
	out.println("<Option></Option>");
	
	
	try {
		//////////////////  this will be change
		sqlQuery1 = "SELECT RG_NO,NAME FROM LOGIN where TYPE='doc' AND CENTER='"+ccode+"' ORDER BY NAME ASC";
		Object res=rcall.find(sqlQuery1);
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			out.println ("<Option Value='"+temp.getValue("RG_NO").trim()+"'>"+temp.getValue("NAME").trim()+"</OPTION>");
			//out.println ("<Option Value='"+regcode.trim()+"'>"+dname.trim()+"</OPTION>");
		}
	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
	out.println ("</SELECT>");
} 

%>
<TD><TR><Table>
<TABLE Width=800 cellspacing=0 cellpadding=0 Border=0 align=center>

<% if(utyp.equals("adm")) { %>
<TR BGColor="#990066" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Reg. Date &nbsp;&nbsp;</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician &nbsp;&nbsp;</B></FONT></TD>
	
	
</TR>
<% } %>
<% if(utyp.equals("doc")) { %>
<TR BGColor="#990066" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
<!--	<TD><FONT COLOR="#FFFFFF"><B>Select &nbsp;&nbsp; </B></FONT></TD> -->
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>EntryDate &nbsp;&nbsp;</B></FONT></TD>
<!--<TD><FONT COLOR="#FFFFFF"><B>Online &nbsp;&nbsp;</B></FONT></TD> -->
</TR>
<% } %>

<%	String chrSt,data="",del="";
	boolean f=false;
	chrSt = request.getParameter("na");
	//chrSt = chrSt.trim();
	//out.println( "utyp :"+ utyp +" sqlQuery : " +sqlQuery);
	try
	{	
		String chkName, id, idChk, Na, Cl, uNa,dte="",doc="",docname="";
		boolean t=true;
		int count=0;
		Object res=rcall.find(sqlQuery);
		if(res instanceof String){
		out.println( "res :"+ res);
		}else{
			Vector tmp = (Vector)res;
		if(utyp.equals("adm"))
		{
		  //RSet.absolute(recfrom);
		  firstpat=recfrom;
		  lastpat=recto;	
		  //RSet.previous();	
		 
		 for(int i=recfrom;i<=tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i-1);
			doc=temp.getValue("REFERRING_DOCTOR");
			if(doc!=null) {
				qsql = "Select NAME from LOGIN Where upper(RG_NO) = '"+doc.toUpperCase()+"'";
				docname= rcall.FindSingle(qsql);
			}
			else docname="--";		

			id = temp.getValue("PAT_ID");
			Na = temp.getValue("PAT_NAME");
			Cl = temp.getValue("CLASS");

			if (t==true) { out.println("<TR BGColor=#F7DDFF>");	t=false; }
			else { out.println("<TR BGColor=#DDF0FF>"); t=true; }

			f=true;
			count++;
			del=temp.getValue("delflage");

			if(del.equals("yes"))
			{	out.println("<TD><Font color=red><B>"+recfrom+"</B></Font></TD>"); 
				//out.println("<TD><Font color=red><B>"+i+"</B></Font></TD>"); 
			}
			else
			{	out.println("<TD><B>"+recfrom+"</B></TD>"); 
				//out.println("<TD><B>"+i+"</B></TD>"); 
			}

			chkName = "SC" + Integer.toString(count);

			out.println("<TD>");
			out.println("<INPUT TYPE=checkbox NAME=ch Value='"+id+"'>");
			out.println("</TD>");

			if(del.equals("yes"))
				out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"'><Font color=red>"+ id + 	"</Font></A></B></TD>");
			else out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"'>"+ id + "</A></B></TD>");

			if(del.equals("yes"))  out.println("<TD><Font color=red>"+ Cl +"</Font></TD>");
			else out.println("<TD>"+ Cl +"</TD>");
			
			dte=temp.getValue("ENTRYDATE");
			if(del.equals("yes"))
			{
				out.println("<TD><Font color=red>"+dte.substring(8)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4) + "</Font></TD>");
				out.println("<TD><Font color=red>"+docname+"<Font></TD>");
			}
			else
			{
				out.println("<TD>"+dte.substring(8)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4) + "</TD>");
				out.println("<TD>"+docname+"</TD>");
			}
			
			 out.println("</TR>");
			 recfrom=recfrom+1;
			 if(recfrom > recto) break;
		 } // end for
		} // if adm




/////////////////

		if(utyp.equals("doc")){
			 firstpat=recfrom;
			 lastpat=recto;	
		 for(int i=recfrom;i<=tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i-1);
			id = temp.getValue("PAT_ID");
			Na = temp.getValue("PAT_NAME");
			Cl = temp.getValue("CLASS");

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
		del=temp.getValue("delflage");
		if(del.equals("y")) out.println("<TD><Font color=green><B>"+recfrom+"</B></Font></TD>"); 
		else out.println("<TD><B>"+recfrom+"</B></TD>");

		if(del.equals("y")) out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"'><Font color=green>"+ 	id + "</Font></A></TD>");
		else	out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"'>"+ id + "</A></TD>");

		if(del.equals("y")) out.println("<TD><Font color=green>"+Cl+"</Font></TD>"); 
		else	out.println("<TD>"+Cl+"</TD>"); 
		
		dte=temp.getValue("ENTRYDATE");
		
		if(del.equals("y")) out.println("<TD><Font color=green>" +dte.substring(8) +"/"+ dte.substring(5,7)+ "/"+ 		dte.substring(0,4) +"</Font></TD>"); 
		else out.println("<TD>"+dte.substring(8)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4)+"</TD>"); 

		out.println("</TR>");
			recfrom=recfrom+1;
			 if(recfrom > recto)
			  break;

		} // end for
		} // if Doc

		out.println("</TABLE>");
		if (count==0) {
			out.println("<BR><BR><FONT SIZE=+1 COLOR=RED><B>Search Criteria Failed</B></FONT>");		
		}
} //else
} catch(Exception e){ out.println("exception occur "+e); }



 %>

<!--<INPUT TYPE="radio" NAME="unsent" Value="y" > <B>Send Unsent </B>
<INPUT TYPE="radio" NAME="unsent" Value="n" checked > <B>Send All </B> -->

<HR WIDTH=800 COLOR=BLUE ALIGN=center SIZE=3>

<CENTER>
<TABLE Border=0 cellspacing=0 cellpadding=0 width=80%>
<TR>
<!-- <TD BGColor=#330066 Width=150 Align=right><FONT SIZE="-1" COLOR="#CCFFFF"><B>View Records from : </B> </FONT></TD>
 -->
 <td>

 <% if(recnavi != 1)
     {
	 String navigatepre="";
	 navigatepre = "patqueue.jsp?FirstPat="+String.valueOf(recnavi-10)+"&LastPat="+String.valueOf(recnavi1-10)+"&tot="+total;
%>
	 <A HREF="<%=navigatepre%>"><img border=0 src=../images/previous.jpg ></A>&nbsp;&nbsp;
 <%}%>

  <font face='MS sans-serif,Verdana, Arial, Helvetica'>Page 
 <select class='dropdown' name="choosepage" onChange='goToPage(this.frm.choosepage.options[this.frm.choosepage.selectedIndex].value);' >
  <%
  
	int X=0, Y=0, Index=0, Display=0,selectedy=0;
	int counter = 0;
	for(Index = 1; Index<=Integer.parseInt(total) ; Index=Index+10)
	{
		X = Index;
		Y = Index + 9;
		counter = counter +1;

		Display=Index;
			if(recnavi == X)
			{
			selectedy = Y;
			out.println("<option selected value='"+String.valueOf(X)+","+String.valueOf(Y)+"'>"+String.valueOf(counter)+"</option>");
			}
			else
			{
			out.println("<option value='"+String.valueOf(X)+","+String.valueOf(Y)+"'>"+String.valueOf(counter)+"</option>");
				
			}
	}
%>
 </select> of <%=counter%></font>

 <% if(selectedy < Integer.parseInt(total))
    { 
	 String navigatenext="";
	 navigatenext = "patqueue.jsp?FirstPat="+String.valueOf(recnavi+10)+"&LastPat="+String.valueOf(recnavi1+10)+"&tot="+total;
%>
	&nbsp;&nbsp; <A HREF="<%=navigatenext%>"><img border=0 src=../images/next.gif ></A>

 <%}%>

</TR>
</TABLE> 
</CENTER>
</FORM>












