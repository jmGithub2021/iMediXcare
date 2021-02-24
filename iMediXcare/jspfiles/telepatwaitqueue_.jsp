<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcGenOperations,imedix.rcPatqueueInfo, imedix.rcUserInfo,imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<% 	
	cook cookx = new cook();
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

	cookx.addCookie("currpatqtype","telewait",response);

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
<html>
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
	  ccode=<%=rccode%>;
	  var page = "telepatwaitqueue.jsp?rccode="+ccode+"&FirstPat="+first+"&LastPat="+last+"&tot="+all;
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

//redirect to decider with cheacked info
function telePatwaitDecide(chobj)
{
//alert(chobj.length);

var count = 0;
var str="",tar;

/*if (chobj.length == undefined) 
{
	if (document.List.CheckBox.checked){
	count= 1;
	alert("yo yo!!");
	}
	else {alert("no no!");}
}
else
{*/
	for(var i=0;i<chobj.length ;i++)
	{
		
		if(chobj[i].checked)
		{
			str=str+chobj[i].name+i+"="+chobj[i].value+"&";
			count = count + 1;
			
		}
	
	}
//}

	var r = confirm("accept "+count+" patient(s) request, reject the rest ?");
	if (r == true)
	{
		tar="telepatwaitdecide.jsp?"+str;

		//alert(tar);
		window.location=tar;
	}
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
	tar="telewaitbrowse.jsp?"+val+"&"+range;
	//alert(tar);
	window.location=tar;
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

</SCRIPT> 
</HEAD>

<BODY bgcolor="#FAF5F5" Color="#0000FF" background="../images/txture.jpg">

<div class="container-fluid">

<FORM role="form" METHOD="GET" NAME="frm" ACTION="">
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
	out.println("<Font color=blue ><H3><center>Tele Patient wait Queue(of "+ hosname +")</center></H3></Font>");
}else{
	out.println("<Font color=blue ><H3><center>Tele Patient wait Queue(of "+ lhosname+") </center></H3></Font>");
}
//out.println("<CENTER><FONT COLOR='#990033'>Number of Patient(s) waiting for teleconsultation </FONT> <FONT size='+1' COLOR='#330000'><B>:</B></FONT> <FONT SIZE='+1' COLOR=#FD5200><B>"+total+"</B></FONT></CENTER>");
 %>

<Table class="table dataTable" align=center >
<TR><TD>


<INPUT class="btn btn-default" style="BACKGROUND-COLOR: #C0C0C0;FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmddel onClick='telePatwaitDecide(this.form.ch)' value="Decide">
&nbsp;<!-- <INPUT style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" TYPE=Button name=cmdass onClick='assph(this.form.ch)' value="Reject"> -->
<input type="hidden" name="ch" value=""/>
<% if(utyp.equals("adm") || utyp.equals("sup")) { %>

<%
	
} 


	/*if(utyp.equals("doc")){
		out.println ("<B>Choose Center </B><SELECT NAME=cent onChange='showselected(cent.value);'  WIDTH='450' STYLE='width: 450' >");
	}else{
	out.println ("&nbsp;<B>Choose Center </B><SELECT NAME=cent onChange='showselected(cent.value);'  WIDTH='330' STYLE='width: 330' >");
	}*/
	//out.println("<Option></Option>");
	try {

		String refed_all=rcGen.getAnySingleValue("referhospitals","referring","code='"+lcode+"'"); 

		Object res=rcci.getAllCentreInfo(); 
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String ccode = temp.getValue("code").trim();
			String cname = temp.getValue("name").trim();
			/*if(lcode.equals("XXXX")){
				if(ccode.equals(rccode))
					out.println ("<Option Value='rccode="+ccode.trim()+"' selected>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
				else
					out.println ("<Option Value='rccode="+ccode.trim()+"'>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
		   }else{
				if(refed_all.indexOf(ccode)>-1){
					if(ccode.equals(rccode))
						out.println ("<Option Value='rccode="+ccode.trim()+"' selected>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
					else
						out.println ("<Option Value='rccode="+ccode.trim()+"'>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
				}
		   }*/
		
		}// end for

	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
//	out.println ("</SELECT>"); 
	
%>

</TD></TR></table>

<div class="table-responsive">
<TABLE class="table dataTable" align=center>

<% if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")) { %>
<THEAD>
<TR BGColor="#349198" >
	<TD><FONT COLOR="#FFFFFF"><B>SNo</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Entry Date</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician</B></FONT>
	<INPUT type='checkbox' name='ch' Value='' style="visibility:hidden">

	</TD>
</TR>
</THEAD>
<TBODY>
<% } %>
<% if(utyp.equals("doc")) { %>
<THEAD>
<TR BGColor="#349198" >
	<TD><FONT COLOR="#FFFFFF"><B>SNo </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>EntryDate</B></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Status</B></FONT></TD>
</TR>	
</THEAD>
<TBODY>
<% } %>


<%	String data="",del="";
	boolean f=false;

	try
	{
		String chkName, stat, id, idChk, Na="", Cl, uNa,dte="",doc="",docname="",adoc="",adocname="";
		boolean t=true;
		int count=0;

//pat_id, entrydate, attending_doc, referred_doc, referred_hospital, local_hospital, sent_by, send_records, userid, usertype


		if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con"))
		{
		  //Object res=rcpqi.getRPatqueueAdmin(lcode,rccode);// do something
		  Object res=rcpqi.getRPatwaitqueueAdmin(lcode,rccode,recfrom,recto);
		  //out.println("lcode  "+lcode+" rccode "+rccode+" test123 = "+rcpqi.test123("!!321test!!"));
	
		  if(res instanceof String){
			out.println( "res1 :"+ res);
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
				doc=temp.getValue("attending_doc").trim();
				//out.println("attending_doc:: "+doc);
				//out.println(recfrom+":'"+doc+"'");
				adoc=temp.getValue("referred_doc").trim();
				//out.println("referred_doc:: "+adoc);
				if(doc!=null) docname= rcui.getName(doc);
				else docname="--";

				if(adoc!=null && !adoc.equals("") ) adocname= rcui.getName(adoc);
				else adocname="--";

				id = temp.getValue("pat_id");
				Na = temp.getValue("pat_name");
				Cl = temp.getValue("class");
				stat = temp.getValue("status");

				if (t==true) { out.println("<TR BGColor=#F7DDFF>");	t=false; }
				else { out.println("<TR BGColor=#DDF0FF>"); t=true; }

				f=true;
				count++;
				del=temp.getValue("checked");

				//if(del.equals("Y"))
				//{	out.println("<TD><Font color=red><B>"+recfrom+"</B></Font></TD>"); 
					
				//}
				//else
				//{	
					out.println("<TD><B>"+recfrom+"</B></TD>"); 
					 
				//}

				chkName = "SC" + Integer.toString(count);

				out.println("<TD>");
				out.println("<INPUT type='checkbox' name='ch' Value='"+id+"'>");
				out.println("</TD>");

				out.println("<TD>"+ id + "</TD>");

				out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");
			

				//if(del.equals("Y"))  out.println("<TD><Font color=red>"+ Cl +"</Font></TD>");
					
				//else 
				out.println("<TD>"+ Cl +"</TD>");
			
				dte=temp.getValue("entrydate");

				/*if(del.equals("Y"))
				{
					out.println("<TD><Font color=red>"+dte.substring(8,10)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4) + "</Font></TD>");
					out.println("<TD><Font color=red>"+docname+"<Font></TD>");
					out.println("<TD><Font color=red>"+adocname+"<Font></TD>");
				}*/
				//else
				//{
					out.println("<TD>"+dte.substring(8,10)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4) + "</TD>");
					out.println("<TD>"+docname+"</TD>");
					out.println("<TD>"+adocname+"</TD>");
					out.println("<TD>"+stat+"</TD>");
				//}
				

				out.println("</TR>");
				recfrom=recfrom+1;
				if(recfrom > recto) break;
			} // end for
		   } // end if obj
		} // if adm

///////////////


if(utyp.equals("doc")){
		String dreg = rcui.getreg_no(usr);
		
		Object res=rcpqi.getRPatwaitqueueDoc(rccode,dreg,recfrom,recto); //do something in patInfo

		if(res instanceof String){
			out.println( "res2 :"+ res);
		}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;	
			//out.println("tmp.size() :"+tmp.size());

			for(int i=1;i<=tmp.size();i++){ //recfrom
			dataobj temp = (dataobj) tmp.get(i-1);
			doc=temp.getValue("attending_doc").trim();
			if(doc!=null) docname= rcui.getName(doc);
			else docname="--";	

			id = temp.getValue("pat_id");
			Na = temp.getValue("pat_name");
			Cl = temp.getValue("class");
			stat = temp.getValue("status");
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
			
			//if(del.equals("Y")) out.println("<TD><Font color=green><B>"+recfrom+"</B></Font></TD>"); 
			//else 
				out.println("<TD><B>"+recfrom+"</B></TD>");

			/*if(del.equals("Y")) {
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"&patdis="+Cl+"'> <Font color=green>"+ 	id + "</Font></A></TD>");

				out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=green>Summary</Font></A></B></TD>");


			}*/
			//else{
				out.println("<TD>");
				out.println("<INPUT type='checkbox' name='ch' Value='"+id+"'>");
				out.println("</TD>");

				//out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></TD>");
				out.println("<TD>"+ id + "</TD>");

				out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");

			//}

			//if(del.equals("Y")) out.println("<TD><Font color=green>"+Cl+"</Font></TD>"); 
			//else	
				out.println("<TD>"+Cl+"</TD>"); 
		
			dte=temp.getValue("entrydate");
		
			//if(del.equals("Y")) out.println("<TD><Font color=green>" +dte.substring(8,10) +"/"+ dte.substring(5,7)+ "/"+ 		dte.substring(0,4) +"</Font></TD>"); 
			//else 
				out.println("<TD>"+dte.substring(8,10)+"/"+dte.substring(5,7)+"/"+dte.substring(0,4)+"</TD>"); 
			
			//if(del.equals("Y")) out.println("<TD><Font color=green>" +docname +"</Font></TD>"); 
			//else 
				out.println("<TD>"+docname+"</TD>"); 
				out.println("<TD>"+stat+"</TD>");

			out.println("</TR>");
				//recfrom=recfrom+1;
				// if(recfrom > recto)
				// break;
			} // end for
		} // if obj
	} // if doc

		out.println("</TBODY></TABLE></div>");
		if (count==0) {
			out.println("<BR><BR><FONT SIZE=+1 COLOR=RED><B><center>No Data Available</center></B></FONT>");		
		}

} catch(Exception e){ out.println("exception occur doc "+e); }

 %>

<!--<INPUT type="radio" name="unsent" Value="y" > <B>Send Unsent </B>
<INPUT type="radio" name="unsent" Value="n" checked > <B>Send All </B> -->


<center>
<TABLE class="table">
<TR>
 <td valign='top'>

 <% /*if(recnavi != 1)
     {
	 String navigatepre="";
	 navigatepre = "patqueue.jsp?FirstPat="+String.valueOf(recnavi-pagerow)+"&LastPat="+String.valueOf(recnavi1-pagerow)+"&tot="+total;
%>
	 <A HREF="<%=navigatepre%>"><img class="img-responsive" border=0 src=../images/previous.jpg ></A>&nbsp;&nbsp;
 <%} */ %>

  <font face='MS sans-serif,Verdana, Arial, Helvetica'>Page 
 <!-- <select class='dropdown' name="choosepage" onChange='goToPage(this.frm.choosepage.options[this.frm.choosepage.selectedIndex].value);' > -->
  <select class='btn btn-default' class='dropdown' name="choosepage" onChange='showselected("rccode=<%=rccode%>",this.value);'>
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
	navigatenext = "telepatwaitqueue.jsp?rccode="+rccode+"&FirstPat="+String.valueOf(recnavi+pagerow)+"&LastPat="+String.valueOf(recnavi1+pagerow)+"&tot="+total;
%>
	&nbsp;&nbsp; <A HREF="<%=navigatenext%>"><img class="img-responsive" border=0 src=../images/next.gif ></A>

 <%} */%>
 </td><td> <A HREF="javascript:location.reload()"><IMG class="img-responsive" SRC="../images/refresh.jpg" WIDTH="22" HEIGHT="22" BORDER=1 ></A></td>
</TR>
</TABLE> 
</center>
</FORM>

</div>		<!-- "container-fluid" -->
</body>
</html>
