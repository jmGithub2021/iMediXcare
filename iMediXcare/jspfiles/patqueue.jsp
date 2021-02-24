<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcGenOperations,imedix.medinfo,imedix.rcPatqueueInfo,imedix.rcUserInfo, imedix.dataobj, imedix.cook,java.util.*,imedix.Decryptcenter,java.io.*, org.json.simple.*,java.net.*" %>
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
	total=request.getParameter("tot");

	recfrom=Integer.parseInt(request.getParameter("FirstPat"));

	recnavi = recfrom;	//used to show pagerow records at a time and their navigation
	startrec = recfrom;    //use startrec to hide/show name
	recto = Integer.parseInt(request.getParameter("LastPat"));

	recnavi1 = recto;    //used to show pagerow ecords at a time and their navigation
	endrec = recto;

	ccode= cookx.getCookieValue("center", request.getCookies ());

	String curCCode= request.getParameter("curCCode");

	cookx.addCookie("currpatqcenter",curCCode,response);
	cookx.addCookie("currpatqtype","local",response);

	//if(curCCode==null) curCCode="";
	//if(curCCode.equals("")) curCCode=ccode;

	centtype = "local";
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	usr=cookx.getCookieValue("userid", request.getCookies());

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

	rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));
	medinfo minfo = new medinfo(request.getRealPath("/"));


	String dreg = rcui.getreg_no(usr);
%>

<%

	String patNameStr = "",patIdStr = "", fromDateStr="",toDateStr = "";
	if(request.getParameter("patNameStr") !=null) patNameStr = request.getParameter("patNameStr").trim();
	if(request.getParameter("patIdStr") != null) patIdStr = request.getParameter("patIdStr").trim();
	if(request.getParameter("fromDateStr") != null) fromDateStr = request.getParameter("fromDateStr").trim();
	if(request.getParameter("toDateStr") != null) toDateStr = request.getParameter("toDateStr").trim();

	dataobj searchObj = new dataobj();
	searchObj.add("srchPatName",patNameStr);
	searchObj.add("srchPatId",patIdStr);
	searchObj.add("srchFrom",fromDateStr);
	searchObj.add("srchTo",toDateStr);

	String searchLen = patNameStr+patIdStr+fromDateStr+toDateStr;

	//out.println(patNameStr+" : "+patIdStr+" : "+fromDateStr+" : "+toDateStr);

%>





<HEAD>


	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/vc/vc.js"></script>	

	<!--<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">-->
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<!--<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>-->

<!--<link rel="stylesheet" type="text/css" href="../style/tabmenu.css" />-->
	<LINK REL="SHORTCUT ICON" HREF="../images/icon1.ico">


<style>
input[type=checkbox]{
    margin:0;
    height: 22px;
    width: 33px;
}
.lpatq-table tbody tr:nth-child(even) {background: #EEE;}
.lpatq-table tbody tr:nth-child(odd) {background: rgba(113, 160, 158, 0.28);}
.treated-lpatq a{
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
.treated-lpatq a:hover{background:#fff;}
.main-body .lpatq-title{position:absolute;top:0px;left:35%}
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
</style>

<SCRIPT language="JavaScript" type="text/javascript">
$(document).ready(function() {
		$("#patbl").dataTable({
			 "lengthMenu": [[5,10,-1], [5,10,"All"]],
			 "info":     false
		});

$(".searchlpatFrm").submit(function(e) {

    var url = "browse.jsp";

    $.ajax({
           type: "GET",
           url: url,
           data: $(this).serialize(),
           success: function(data)
           {
              $("#main_frame").html(data);
           }
         });

    e.preventDefault();
});

		var d = new Date();
	$(function () {
    var startDate = new Date('2009-12-12'),
        endDate = new Date('2050-12-30');
		$('#from-datepicker').datetimepicker({
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 4,
			keyboardNavigation: 1,
			minView: 2,
			forceParse: 0,
			startDate: startDate,
			endDate: endDate,
			setDate: startDate
		});
		$('#to-datepicker').datetimepicker({
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 4,
			keyboardNavigation: 1,
			minView: 2,
			forceParse: 0,
			startDate: startDate,
			endDate: endDate,
			setDate: startDate
		});

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

function goToPage(a,currCnt) {

	  x=a;
	  comma = x.indexOf(",");
	  first = x.substring(0,comma);
	  last = x.substring(comma+1,x.length);
	  all = <%=total%>;
	  var page = "browse.jsp?FirstPat="+first+"&LastPat="+last+"&tot="+all+"&curCCode="+currCnt;
	  //alert(page);
	  //document.location.href = page;
	  var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
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
if(str.length>0){
	$.get(tar,function(data,status){alert("Assigned Successfully");});
	showselected("curCCode="+phy.substring(3,(phy.length-4))+"&F=0&L=25");
}
else{alert("Choose Physician and select patient");}
//window.location=tar
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

tar="dellocalpatq.jsp?"+str;
	window.location=tar;
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
	tar="browse.jsp?"+val+"&"+range;
	//alert(tar);
	//window.location=tar;
	var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
		$("#main_frame").html(ajax_load).load(tar);
		$("#main_frame").css("min-height","100%");
		$("#main_frame").css("max-height","100%");
}



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
				, userDate = new Date(Date.UTC(sysDate.getFullYear(), sysDate.getMonth(), sysDate.getDate(),  sysDate.getHours(), sysDate.getMinutes()+30, 0));
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
		setAppoinment(patid,patname,appdateymd,apptime);
	});


});

</script>


</HEAD>

<HTML>

<BODY onLoad="document.getElementById('siteLoader').style.display = 'none';">


<%
	String pendAppList = "";
	try {
		Object notappontObj = rcpqi.appoinmentNotSetList(dreg);
		Vector nApptmp = (Vector)notappontObj;
		for(int i=0;i<nApptmp.size();i++){
			dataobj nApptemp = (dataobj) nApptmp.get(i);
				String ppatName = nApptemp.getValue("patname");
				String pref1 = ppatName.substring(0,ppatName.indexOf(" "));
				String pref = minfo.getAppellationValues().getValue(pref1);
				ppatName = pref+ppatName.substring(ppatName.indexOf(" "),ppatName.length());
				String sppatName = nApptemp.getValue("patname").split(" ")[1];
				String ppatid = nApptemp.getValue("pat_id");
			pendAppList += "<tr><td><input class='form-control' name='appSet' type='checkbox' id='"+ppatid+"' patname='"+sppatName+"' /></td><td>"+ppatid+"</td><td>"+ppatName+"</td><td>"+nApptemp.getValue("entrydate")+"</td><td><button class='btn btn-default' onclick=sendMail('"+ppatid+"','"+sppatName+"')>Set Appoinment</button></td></tr>";
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


<div id='siteLoader' hidden>
	 <H3><CENTER><BR>
	 	 <FONT COLOR="#00CCCC">......Please Wait......</FONT><BR><BR>
		 <IMG class="img-responsive" SRC="<%=request.getContextPath()%>/images/loading.gif" WIDTH="100" HEIGHT="20" BORDER="0" ALT="" bordercolor=RED><BR>
	 </CENTER>
	 </H3>
</div>

<div class="container-fluid">
<%
	int firstpat=0,lastpat=0;
	String sqlQuery="",strsql="",sqlQuery1="" ;
	String qsql="";
	String hosname=rcci.getHosName(curCCode);
	//out.println("<div class='lpatq-title'><Font color=blue ><center>Local Patient Queue(Of "+ hosname +")</center></Font></div>");
//out.println("<center><FONT COLOR='#990033'>Number of Patient(s) in Q </FONT> <FONT size='+1' COLOR='#330000'><B>:</B></FONT> <FONT SIZE='+1' COLOR=#FD5200><B class='ttop'>"+total+"</B></FONT></center>");
%>


<div class="row search-div">
<div class="col-sm-12">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Search Patient</h3>
			<%
				out.println("<div class='lpatq-title'><Font color=blue ><center>Local Patient Queue(Of "+ hosname +")</center></Font>");
				out.println("<center><FONT COLOR='#990033'>Number of Patient(s) in Q </FONT> <FONT COLOR='#330000'><B>:</B></FONT> <FONT COLOR=#FD5200><B class='ttop'>"+total+"</B></FONT></center></div>");
			%>
		</div>
		<div class="panel-body">
			<form method="GET" class="searchlpatFrm">
			<div class="row">
				<div class="col-sm-3">
					<label>Patient ID</label>
					<input class="form-control" type="text" name="patIdStr" placeholder="Patient Id" value="<%=patIdStr%>"/>
				</div>
			<div class="col-sm-2">
				<label>Patient Name</label>
				<input class="form-control" type="text" name="patNameStr" placeholder="Patient Name" value="<%=patNameStr%>"/>
			</div>
			<div class="col-sm-4">
				<label>By Date</label>
				<div class="input-group">
						<div id="from-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="fromDateStr" value="FROM" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:0px"></span>
						</div>
					<span class="input-group-addon">To</span>
						<div id="to-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
							<input data-format="yyyy-MM-dd" type="text" name="toDateStr" value="To" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:0px"></span>
						</div>

				</div>
			</div>
			<div class="col-sm-1">
			</div>
			<div class="col-sm-2">
			<label>Search</label>
				<input class="form-control btn-primary" type="submit" name="getlpatqSrchRslt" class="getlpatqSrchRslt" value="Search" />
			</div>
			</div>
			</form>
		</div>
	</div>
</div>
</div>


<div class="row lpatq-table">

<div class="col-sm-12">
<FORM class="form-inline" role="form" METHOD=GET name=frm ACTION="">
<INPUT type="hidden" name=centtype Value="<%=centtype%>">

<div class="table-responsive">
<table class="table">
<tr>
<td>

<%

	if(utyp.equals("adm") || utyp.equals("sup")) { %>
<!--<INPUT class='form-control' style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff';background-border: '1px groove #146bee'" type=Button name=cmddel onClick='delpatq(this.form.ch)' value="Delete">-->

&nbsp;<INPUT class='form-control' style="BACKGROUND-COLOR: #C0C0C0; CURSOR: hand; FONT-SIZE: 7pt; FONT-WEIGHT: bold; font-color: '#ffffff'; background-border: '1px groove #146bee'" type=Button name=cmdass onClick='abc(this.form.ch)' value="Assign Physician">

<%
	out.println ("<B>&nbsp;Choose Physician </B><SELECT class='form-control' name=selphy WIDTH='140' STYLE='width: 140' >");
	out.println("<Option value=''>-Select-</Option>");

	try {
		//String cnd="type='doc' AND center='"+curCCode+"' ORDER BY name ASC";
		//Object res=rcui.getValues("rg_no,name",cnd);

		Object res=rcui.getAllUsers(curCCode,"doc","A");

		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			//out.println (temp.getValue("rg_no").trim()+"="+temp.getValue("name").trim());

			out.println ("<Option Value='"+temp.getValue("rg_no").trim()+"'>"+temp.getValue("name").trim()+"</OPTION>");
			//out.println ("<Option Value='"+regcode.trim()+"'>"+dname.trim()+"</OPTION>");
		}
	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");
	}
	out.println ("</SELECT>");
}

%>

<%
	if(ccode.equals("XXXX") && (utyp.equals("sup") || utyp.equals("adm")) ){
	out.println ("&nbsp;<B>Choose Center </B><SELECT class='form-control' NAME=cent onChange='showselected(cent.value);'  WIDTH='330' STYLE='width: 330' >");

	//out.println("<Option></Option>");
	try {
		Object res=rcci.getAllCentreInfo();
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String occode = temp.getValue("code").trim();
			String cname = temp.getValue("name").trim() ;
			String visibility = temp.getValue("visibility").trim();

			String expdate = imc.decryptLicString(  temp.getValue("expdate") );
			java.util.Date expDate = new java.text.SimpleDateFormat("ddMMyyyy").parse(expdate);
			java.util.Date today = new java.util.Date();
			long timeDiff = expDate.getTime() - today.getTime();
			long daysDiff = timeDiff / 1000L / 60L / 60L / 24L;
			String validity = "";
			if (daysDiff<15) validity = " [ only " + daysDiff + " day(s) left ] " ;
			else validity = "";

//			if(curCCode.equals("XXXX")) curCCode=occode;
			if (visibility.equalsIgnoreCase("Y")) {
				if(occode.equals(curCCode))
					out.println ("<Option Value='curCCode="+occode.trim()+"&F=0&L="+pagerow+"' selected>("+occode.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
				else
					out.println ("<Option Value='curCCode="+occode.trim()+"&F=0&L="+pagerow+"'>("+occode.trim() +")&nbsp;"+cname.trim()+validity+"</OPTION>");
			}
		}// end for

	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");
	}
	out.println ("</SELECT>");
}
%>
</td>
</tr>
</table>
</div>		<!-- "table-responsive" -->

<div class="table-responsive">
<!--<div class="treated-lpatq">
<a href="Javascript:void(0)" value="treatedbrowse.jsp" onclick="clearPanel(this.getAttribute('value'))" data-target="#navbarCollapse" data-toggle="collapse" class="" aria-expanded="true">Treated Patient</a>
</div>-->
<table  class="table" id="patbl" name="patbl">
<% if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")) { %>
<THEAD><TR BGColor="#349198" Height="25" >
	<TD><FONT COLOR="#FFFFFF"><B>SNo </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientName</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Reg. Date</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician</B></FONT>
	<INPUT type='checkbox' name='ch' Value='' style="visibility:hidden">
	</TD>
	<!--<td><FONT COLOR="#FFFFFF"><B>status</B></td>-->


</TR>
</THEAD>
<TBODY>
<% } %>

<% if( utyp.equals("usr") ) { %>
	<THEAD>
<TR BGColor="#349198" Height="25" >
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Select</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientName</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Reg. Date</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Assigned Physician</B></FONT></TD>
	<!--<td><FONT COLOR="#FFFFFF"><B>status</B></td>-->

</TR>
</THEAD>
<TBODY>
<% } %>

<% if(utyp.equals("doc")) { %>
	<THEAD>
<TR BGColor="#990066" Height="25">
	<TD><FONT COLOR="#FFFFFF"><B>SNo &nbsp;&nbsp; </B></FONT></TD>
<!--	<TD><FONT COLOR="#FFFFFF"><B>Select</B></FONT></TD> -->
	<TD><FONT COLOR="#FFFFFF"><B>PatientName</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>PatientID</B></FONT></TD>
	<!--<TD><FONT COLOR="#FFFFFF"><B>Summary</B></FONT></TD>-->
	<!--<TD><FONT COLOR="#FFFFFF"><B>Category</B></FONT></TD>-->
	<TD><FONT COLOR="#FFFFFF"><B>Appoinment Date</B></FONT></TD>
	<TD><FONT COLOR="#FFFFFF"><B>Reg.Date </B></FONT></TD>
<!--<TD><FONT COLOR="#FFFFFF"><B>Online </B></FONT></TD> -->
</TR>
</THEAD>
<TBODY>
<% } %>


<%	String data="",del="";
	boolean f=false;

	try
	{
		String chkName, id, idChk, Na, Cl, uNa,dte="",doc="",docname="",patName="",appdate="";
		boolean t=true;
		int count=0;

		if(utyp.equals("adm") || utyp.equals("usr") || utyp.equals("sup") || utyp.equals("con"))
		{

			Object res = null;
			if(searchLen.length()>2){
				res=rcpqi.getLPatqueueAdminSearch(curCCode,recfrom,recto,searchObj);
			}
			else{
				res=res=rcpqi.getLPatqueueAdmin(curCCode,recfrom,recto);
			}

		  if(res instanceof String){
			out.println( "res :"+ res);
			}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;
			 for(int i=1;i<=tmp.size();i++){ //recfrom
				dataobj temp = (dataobj) tmp.get(i-1);
				doc=temp.getValue("referring_doctor");
				if(doc!=null) {
					docname= rcui.getName(doc);
				}
				else docname="--";

				id = temp.getValue("pat_id");
				//patName = temp.getValue("pat_name");
				patName=rcGen.getPatientName(id);
				String d = patName.substring(0,patName.indexOf(" "));
				String dd = minfo.getAppellationValues().getValue(d);
				patName = dd+" "+patName.substring(patName.indexOf(" "),patName.length());
				//Na = temp.getValue("pat_name");
				Na = "*";
				Cl = temp.getValue("class");
				Cl = Cl.replaceAll("<br>","");
				if (t==true) { out.println("<TR >");	t=false; }
				else { out.println("<TR >"); t=true; }

				f=true;
				count++;
				del=temp.getValue("checked");

				if(del.equals("Y"))
				{	out.println("<TD><Font color=red><B>"+(i+recfrom)+"</B></Font></TD>");
					//out.println("<TD><Font color=red><B>"+i+"</B></Font></TD>");
				}
				else
				{	out.println("<TD><Font color=blue><B>"+(i+recfrom)+"</B></Font></TD>");
					//out.println("<TD><B>"+i+"</B></TD>");
				}

				//chkName = "SC" + Integer.toString(count);

				out.println("<TD>");
				out.println("<INPUT type='checkbox' name='ch' Value='"+id+"'>");
				out.println("</TD>");
				out.println("<td>"+patName+"</td>");
				if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con")){
					if(del.equals("Y")){
						out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=red>"+ id + 	"</Font></A></B></TD>");
						//out.println("<TD><B><A value='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'  onclick=\"clearPanel(this.getAttribute('value'))\"><Font color=red>Summary</Font></A></B></TD>");

					}else{
						out.println("<TD><B><A HREF='showpatdata.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A></B></TD>");
					//	out.println("<TD><B><A value='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'  onclick=\"clearPanel(this.getAttribute('value'))\">Summary</A></B></TD>");

					}

				}else if(utyp.equals("usr")){
					if(del.equals("Y"))
					out.println("<TD><B><A HREF='oldpatid.jsp?id="+id+"&usr=usr&nam="+Na+"'><Font color=red>"+ id + 	"</Font></A></B></TD>");
					else out.println("<TD><B><A HREF='oldpatid.jsp?id="+id+"&usr=adm&nam="+Na+"'>"+ id + "</A></B></TD>");

				}

				if(del.equals("Y"))  out.println("<TD><Font color=red>"+ Cl +"</Font></TD>");
				else out.println("<TD><Font color=blue>"+ Cl +"</Font></TD>");

				dte=temp.getValue("entrydate");

				if(del.equals("Y"))
				{
					//out.println("<TD><Font color=red>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "</Font></TD>");
					out.println("<TD><Font color=red>"+docname+"<Font></TD><!--<td class='status checked' pat-id = '"+id+"'><span class='glyphicon glyphicon-ok-circle'></span></td>-->");
				}
				else
				{
					//out.println("<TD><Font color=blue>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10) + "<Font></TD>");
					out.println("<TD><Font color=blue>"+docname+"<Font></TD><!--<td class='status' pat-id = '"+id+"'><span class='glyphicon glyphicon-ban-circle'></span></td>-->");
				}
				out.println("</TR>");
				//recfrom=recfrom+1;
				//if(recfrom > recto) break;
			} // end for
		   } // end if obj
		} // if adm


/////////////////

	if(utyp.equals("doc")){
		JSONArray lpatqMap = new JSONArray();
		Object res = null;
		if(searchLen.length()>2){
			res=rcpqi.getLPatqueueDocSearch(dreg, recfrom,recto,searchObj);
		}
		else{
			res=rcpqi.getLPatqueueDoc(dreg, recfrom,recto);
		}

		if(res instanceof String){
			out.println( "res :"+ res);
		}else{
			Vector tmp = (Vector)res;
			firstpat=recfrom;
			lastpat=recto;
			for(int i=1;i<=tmp.size();i++){ //recfrom
			dataobj temp = (dataobj) tmp.get(i-1);
			id = temp.getValue("pat_id");
			//lpatqMap.add(Integer.parseInt(temp.getValue("rowno"))-1,id);
			lpatqMap.add(i-1,id);
			//patName = temp.getValue("pat_name");
			patName=rcGen.getPatientName(id);
			String d = patName.substring(0,patName.indexOf(" "));
			String dd = minfo.getAppellationValues().getValue(d);
			patName = dd+" "+patName.substring(patName.indexOf(" "),patName.length());
			//Na = temp.getValue("pat_name");
			Na = "*";
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
			out.println("<td>"+patName+"</td>");
			if(del.equals("Y")) {
				out.println("<TD><A HREF='showpatdata.jsp?id="+id+"&usr=doc&nam="+Na+"&patdis="+Cl+"'><Font color=green>"+ 	id + "</Font></A></TD>");
			//	out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'><Font color=green>Summary</Font></A></B></TD>");

			}else{
String td = "<TD><A HREF='showpatdata.jsp?id="+id+"&usr=doc&nam="+Na+"&patdis="+Cl+"'>"+ id + "</A>";
				td += "&nbsp;&nbsp;&nbsp;<a class='online' href='#' title='Send email to patient' onClick=\"sendMail('"+id+"','"+patName+"')\"><span class='glyphicon glyphicon-envelope' aria-hidden='true'></span></a>";
				td += "&nbsp;&nbsp;&nbsp;<a data-patid='"+id+"' class='offline pat-video-link' href='#' title='Invite patient for Video Conference' onClick=\"invite('"+id+"','"+patName+"')\"><span class='glyphicon glyphicon-facetime-video' aria-hidden='true'></span></a>";
				td += "</TD>";
				out.println(td);
			//	out.println("<TD><B><A HREF='totalsummary.jsp?id="+id+"&usr=adm&nam="+Na+"&patdis="+Cl+"'>Summary</A></B></TD>");


			}
			appdate = temp.getValue("appdate");
			if(del.equals("Y")) out.println("<TD><Font color=green>"+appdate+"</Font></TD>");
			else	out.println("<TD>"+appdate+"</TD>");

			dte=temp.getValue("entrydate");

			if(del.equals("Y")) out.println("<TD><Font color=green>" +dte.substring(0,4) +"/"+ dte.substring(5,7)+ "/"+ dte.substring(8,10) +"</Font></TD>");
			else out.println("<TD>"+dte.substring(0,4)+"/"+dte.substring(5,7)+"/"+dte.substring(8,10)+"</TD>");

			out.println("</TR>");
				//recfrom=recfrom+1;
				// if(recfrom > recto)
				 //break;
			} // end for
		} // if obj
		session.setAttribute("lpatqlist",String.valueOf(lpatqMap));

		//cookx.addCookie("lpatqlist",URLEncoder.encode(String.valueOf(lpatqMap), "UTF-8"),response);
	} // if doc

		out.println("<TBODY></TABLE>");
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
<div id="dialog-form" title="Send Email Reminder"></div>
</div>		<!-- "col-sm-12" -->

</div>		<!-- "row" -->
</div>		<!-- "fluid-container" -->
<script>
$(document).ready(function(){
	var patlist = "<%=pendAppList%>";
	var patlistSize = patlist.length;
	if(patlistSize>0)
		$('#set-appoinment-modal').modal('show');
});
</script>
</body>
</HTML>
