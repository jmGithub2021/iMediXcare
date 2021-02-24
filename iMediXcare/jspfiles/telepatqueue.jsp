<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcGenOperations,imedix.medinfo,imedix.rcPatqueueInfo, imedix.rcUserInfo,imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*,org.json.simple.*" %>
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
	medinfo minfo = new medinfo(request.getRealPath("/"));

	String dreg = rcui.getreg_no(usr);

%>
<HTML>
<HEAD>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
.treated-tpatq a{
    position: absolute;
    right: 45%;
    text-decoration: none;
    z-index: 999;
    border: 1px solid #349098;
    padding: 5px 30px;
    color: #2b405f;
    background: #d8e5e4;
    font-weight: 600;
}
.treated-tpatq a:hover{background:#fff;}

.modal-header-c{
	position:relative;
	position: relative;
    background: #5ba9ec;
    box-shadow: 0px 2px 4px -1px #e5e5e5;
    color: #fff;
}
.modal-header-c .close{
	color: #d62508;
    font-size: 25px;
    font-weight: 800;
}
.app-select-all{
	float: right;
    position: absolute;
    right: 50px;
    top: 25%;
    width: 270px;
}
.app-select-all select{height:36px;}
.app-select-all .input-group-addon{padding: 0px 0px;}
.modal-backdrop{z-index:98;}
.modal{z-index:99;}
#set-appoinment-modal thead{
	background: #31708f;
    color: #fff;
}
.app-set-datetime{display:flex;}
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

<script>
$(document).ready(function(){
	$('#set-appoinment-modal').modal('hide');
	$(".app-select-btn").prop("checked",true);
	let sysDate  = new Date()
		, userDate = new Date(Date.UTC(sysDate.getFullYear(), sysDate.getMonth(), sysDate.getDate(),  sysDate.getHours(), sysDate.getMinutes()+30, 0));
	$('#appttime-all')[0].valueAsDate = userDate;
	$("input:checkbox[name=appSet]").prop("checked", true);
	$(".status.checked").click(function(){
		var tag = $(this).parent().get( 0 );
		$.post(
			"moveTreated_pat.jsp",
			{ patid: ""+$(this).attr("pat-id")+""},
			function(data) {
				//$(".main-body").html(data);
				var status = Boolean(data);
				if(status == true){
				    tag.remove();
					toastr.success("Moved to treated PatQ");
				}
				else{
					alert("Can not move");
					}
			}
       );
       //console.log($(this).attr("pat-id"));
	});

	$(".app-select-btn").on("click",function(){
		if($(this).prop("checked") == true){
			$("input:checkbox[name=appSet]").prop("checked", true);
			let sysDate  = new Date()
				, userDate = new Date(Date.UTC(sysDate.getFullYear(), sysDate.getMonth(), sysDate.getDate(),  sysDate.getHours(), sysDate.getMinutes(), 0));
			$('#appttime-all')[0].valueAsDate = userDate;
		}
		else if($(this).prop("checked") == false)
			$("input:checkbox[name=appSet]").prop("checked", false);
	});
	$(".setappall").on("click",function(){
		var patid = [];
		var patname = [];
		var apptime = $(".apptime-all").val();
		var appdate = new Date();
		appdate = new Date(appdate.setDate(appdate.getDate() + Number($(".appdate-all").val())));

        month = '' + (appdate.getMonth() + 1),
        day = '' + appdate.getDate(),
        year = appdate.getFullYear();
		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;
		let appdateymd = [year, month, day].join('-');

		$("input:checkbox[name=appSet]:checked").each(function () {
			patid.push($(this).attr("id"));
			patname.push($(this).attr("patname"));
			//alert("Id: " + $(this).attr("id") + " Value: " + $(this).attr("patname"));
		});
		setAppoinmentTpat(patid,patname,appdateymd,apptime);
	});

});
</script>

</HEAD>


<BODY bgcolor="#FAF5F5" Color="#0000FF" background="../images/txture.jpg">



<%
	String pendAppList = "";
	try {
		Object notappontObj = rcpqi.appoinmentNotSetListTpatq(dreg);
		Vector nApptmp = (Vector)notappontObj;
		for(int i=0;i<nApptmp.size();i++){
			dataobj nApptemp = (dataobj) nApptmp.get(i);
				String ppatName = nApptemp.getValue("patname");
				String pref1 = ppatName.substring(0,ppatName.indexOf(" "));
				String pref = minfo.getAppellationValues().getValue(pref1);
				ppatName = pref+ppatName.substring(ppatName.indexOf(" "),ppatName.length());
				String sppatName = nApptemp.getValue("patname").split(" ")[1];
				String ppatid = nApptemp.getValue("pat_id");
			pendAppList += "<tr><td><input class='form-control' name='appSet' type='checkbox' id='"+ppatid+"' patname='"+sppatName+"' /></td><td>"+ppatid+"</td><td>"+ppatName+"</td><td>"+nApptemp.getValue("entrydate")+"</td><td><button class='btn btn-default' onclick=sendMailTpat('"+ppatid+"','"+sppatName+"')>Set Appoinment</button></td></tr>";
		}
	}catch(Exception ex){}

%>
  <div class="modal fade" id="set-appoinment-modal" role="dialog">
    <div class="modal-dialog modal-lg">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header modal-header-c">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Pending Patient For Appoinment
		    <div class="input-group app-select-all">
				<span class="input-group-addon"><input class='app-select-btn' type='checkbox' /></span>
				<span class='app-set-datetime'>
				<input type='time' plceholder="Time" name="apptime" class='form-control apptime-all' id='appttime-all' />
				<select class="form-control appdate-all">
					<option value="0">Today</option>
					<option value="1">Tomorrow</option>
					<option value="7">A week</option>
					<option value="30">A month</option>
					<option value="2">After 2 Days</option>
					<option value="3">After 3 Days</option>
					<option value="4">After 4 Days</option>
					<option value="5">After 5 Days</option>
					<option value="6">After 6 Days</option>
				</select>
				</span>
				<div class="input-group-btn">
				  <button class="btn btn-default setappall" type="button">
					SET
				  </button>
				</div>
			</div>
			</h4>
        </div>
        <div class="modal-body">
          <table class='table table-bordered'>
			<thead>
				<tr>
					<th>Select</th>
					<th>Patient ID</th>
					<th>Patient Name</th>
					<th>Reg. Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%=pendAppList%>
			</tbody>
		  </table>
        </div>

      </div>

    </div>
  </div>


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
		out.println ("<B>Choose Center </B><SELECT class='form-control' NAME=cent onChange='showselected(cent.value);'  WIDTH='450' STYLE='width: 450' ><option value='rccode=XXXXX000'>Choose Center</option>");
	}else{
	out.println ("&nbsp;<B>Choose Center </B><SELECT class='form-control' NAME=cent onChange='showselected(cent.value);'  WIDTH='330' STYLE='width: 330' ><option value='rccode=XXXXX000'>Choose Center</option>");
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
<!--<div class="treated-tpatq">
<a href="Javascript:void(0)" value="treatedbrowse.jsp" onclick="clearPanel(this.getAttribute('value'))" data-target="#navbarCollapse" data-toggle="collapse" class="" aria-expanded="true">Treated Patient</a>
</div>-->
<TABLE class="table" id="tpatbl" name="tpatbl">

<% if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<!--<TD><FONT COLOR="#FFFFFF"><B>SNo</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Select</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientName</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Entry Date</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician </B></FONT>
	<INPUT type='checkbox' name='ch' Value='' style="visibility:hidden">

	</TD>
	<!--<td>Status</td>-->
</TR>
</THEAD>
<TBODY>
<% } %>
<% if(utyp.equals("doc")) { %>
<THEAD>
<TR BGColor="#6495ed" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientName</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>-->
	<!--<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Appoinment Date</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>EntryDate </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Referring Physician </B></FONT></TD>
	<!--<td>Status</td>-->
</TR>
</THEAD>
<% } %>


<%	String data="",del="";
	boolean f=false;

	try
	{
		String chkName, id, idChk, Na="", Cl, uNa,dte="",doc="",docname="",adoc="",adocname="",patName="",appdate="";
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
				patName=rcGen.getPatientName(id);
				String d = patName.substring(0,patName.indexOf(" "));
				String dd = minfo.getAppellationValues().getValue(d);
				patName = dd+" "+patName.substring(patName.indexOf(" "),patName.length());

				if (t==true) { out.println("<TR>");	t=false; }
				else { out.println("<TR>"); t=true; }

				f=true;
				count++;
				del=temp.getValue("checked");

			/*	if(del.equals("Y"))
				{	out.println("<TD><Font color=red><B>"+(i+recfrom)+"</B></Font></TD>");
					//out.println("<TD><Font color=red><B>"+i+"</B></Font></TD>");
				}
				else
				{	out.println("<TD><B>"+(i+recfrom)+"</B></TD>");
					//out.println("<TD><B>"+i+"</B></TD>");
				}*/

				chkName = "SC" + Integer.toString(count);

				out.println("<TD>");
				out.println("<INPUT type='checkbox' name='ch' Value='"+id+"'>");
				out.println("</TD>");
				out.println("<td>"+patName+"</td>");
				if(del.equals("Y")){
					out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=red>"+ id + 	"</Font></A></B></TD>");

					//out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=red>Summary</Font></A></B></TD>");

				}else {
					out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></B></TD>");

					//out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");
				}

				if(del.equals("Y"))  out.println("<TD><Font color=red>"+ Cl +"</Font></TD>");
				else out.println("<TD>"+ Cl +"</TD>");

				dte=temp.getValue("entrydate");

				if(del.equals("Y"))
				{
					//out.println("<TD><Font color=red>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</Font></TD>");
					out.println("<TD><Font color=red>"+docname+"<Font></TD>");
					out.println("<TD><Font color=red>"+adocname+"<Font></TD>");
					//out.println("<TD class='status checked' pat-id = '"+id+"'><span class='glyphicon glyphicon-ok-circle'></span></TD>");
				}
				else
				{
					//out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</TD>");
					out.println("<TD>"+docname+"</TD>");
					out.println("<TD>"+adocname+"</TD>");
					//out.println("<TD class='status' pat-id = '"+id+"'><span class='glyphicon glyphicon-ban-circle'></span></TD>");
				}


				out.println("</TR>");
				//recfrom=recfrom+1;
				//if(recfrom > recto) break;
			} // end for
		   } // end if obj
		} // if adm

///////////////


if(utyp.equals("doc")){
		JSONArray tpatqMap = new JSONArray();
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
			tpatqMap.add(i-1,id);
			patName=rcGen.getPatientName(id);
			String d = patName.substring(0,patName.indexOf(" "));
			String dd = minfo.getAppellationValues().getValue(d);
			patName = dd+" "+patName.substring(patName.indexOf(" "),patName.length());

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
				out.println("<td>"+patName+"</td>");
			if(del.equals("Y")) {
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"&patdis="+Cl+"'> <Font color=green>"+ 	id + "</Font></A></TD>");

				//out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=green>Summary</Font></A></B></TD>");


			}else{
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></TD>");

				//out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");

			}
			appdate = temp.getValue("teleconsultdt");
			if(del.equals("Y")) out.println("<TD><Font color=green>"+appdate+"</Font></TD>");
			else	out.println("<TD>"+appdate+"</TD>");

			dte=temp.getValue("entrydate");

			if(del.equals("Y")) out.println("<TD><Font color=green>" +dte.substring(0,4) +"/"+ dte.substring(5,7)+ "/"+dte.substring(8,10) +"</Font></TD>");
			else out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10)+"</TD>");

			if(del.equals("Y")) out.println("<TD><Font color=green>" +docname +"</Font></TD><!--<TD class='status checked' pat-id = '"+id+"'><span class='glyphicon glyphicon-ok-circle'></span></TD>-->");
			else out.println("<TD>"+docname+"</TD><!--<TD class='status' pat-id = '"+id+"'><span class='glyphicon glyphicon-ban-circle'></span></TD>-->");

			out.println("</TR>");
				//recfrom=recfrom+1;
				// if(recfrom > recto)
				// break;
			} // end for
		} // if obj
		session.setAttribute("lpatqlist",String.valueOf(tpatqMap));
	} // if doc

		out.println("</TABLE>");
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
<div id="dialog-form" title="Send Email Reminder"></div>
</div>		<!-- "container-fluid" -->
<script>
$(document).ready(function(){
	var patlist = "<%=pendAppList%>";
	var patlistSize = patlist.length;
	if(patlistSize>0)
		$('#set-appoinment-modal').modal('show');
});
</script>
</body>
</html>
