<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.medinfo,imedix.rcUserInfo,imedix.dataobj,imedix.rcGenOperations,imedix.myDate,imedix.rcDisplayData,imedix.cook,java.util.*" %>

<SCRIPT LANGUAGE="JavaScript">

	function PrintDoc(text){
	text=document
	print(text)
}

function showhide(val)
{
	//var val
	//val=document.getElementById("show").value;
	//alert(val);
	//if(val == "Show Details")

	if(val=="YES")
	{
		document.getElementById("patdetail").style.visibility = "visible";
		//document.getElementById("show").value = "Hide Details";
	}

	//if(val == "Hide Details")
	if(val=="NO")
	{
		document.getElementById("patdetail").style.visibility = "hidden";
		//document.getElementById("show").value = "Show Details";
	}
}

</script>
<STYLE>

table.table:hover
{
	background-color:white;
}
.checked{
    position: relative;
    top: 1px;
    display: inline-block;
    font-family: 'Glyphicons Halflings';
    font-style: normal;
    font-weight: 400;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    color: #4CAF50;
    padding: 0 4px;
    float: right;
	}
.checked:before{
	content: "\e013";
}
</STYLE>
	<!-- <A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  ><BR>&nbsp;Print this Document&nbsp;</A>
 -->
<%
   	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	medinfo minfo = new medinfo(request.getRealPath("/"));
	rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));


	String ty="",id="",date="",dt="",sl="",qr="",str="",val="",atyp="",wsex="",state="", qr1="",present_status="YES",ag="",docname="",district="",appellation="",religion="";
	String dat="",pname="*******",referring_doc="",caste_category="",wcc="";
	String idChecked = "", relationship="", primarypatid="";

	//String mcls="",mreg="",madd1="",madd2="",mpstn="",mphn="",mcity="",mdis="", mstate="",mcon="",mpin="",mpper="",mprela="",mpadd="", caste_category="",wcc="";

	dataobj temp=null;

	String m_status="";

	//String present_status="",qr1="";
	//present_status = thisObj.getCookies("telemedcook")("datahide")

	//ty = request.getParameter("ty");
	id = request.getParameter("id");
	String login=request.getParameter("login");
	dt = request.getParameter("dt");
	if(id==null){
		cook cookx = new cook();
		id = cookx.getCookieValue("patid", request.getCookies());
	}

	if(dt==null)dt="";

	//if(!dt.equals("")) dt= dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);

	sl = request.getParameter("sl");
	if(sl==null) sl="";

	try
	{
	Object res=ddinfo.DisplayMed(id,dt,sl);
	//qr="select * from med where PAT_ID='"+id+"' and ENTRYDATE='"+dt+"' and SERNO='"+sl+"'";
	if(res instanceof String){

		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			temp = (dataobj) tmp.get(0);

			int m=0,d=0;
			String dd="",mm="";
			dat = temp.getValue("entrydate");
			referring_doc=temp.getValue("referring_doctor");
			//if(referring_doc==null) referring_doc="";
			//out.println("referring_doc :"+referring_doc);
			m=Integer.parseInt(myDate.datePart("m",dat));
			d=Integer.parseInt(myDate.datePart("d",dat));
			//out.println("m:"+m+" d:"+d);

			caste_category= temp.getValue("caste_category");
			if(m<10)
			mm="0"+String.valueOf(m);
			else
			mm=String.valueOf(m);

			if(d<10)
			dd="0"+String.valueOf(d);
			else
			dd=String.valueOf(d);
			
			date=dd+"-"+mm+"-"+myDate.datePart("y",dat);

			m_status=temp.getValue("m_status");
			m_status=minfo.getMaritalValues().getValue(m_status);

			wsex=temp.getValue("sex").trim();
			wsex=minfo.getSexValues().getValue(wsex);
			wcc=minfo.getCasteValues().getValue(caste_category);


			/*ag=temp.getValue("age");
			if(ag.length()==0) ag=",,,";
			//out.println("ag :"+ag);
			String ages[]=ag.split(",",3);

			if(!ages[2].equals(""))
				str=ages[2].trim() +" days";

			if(!ages[1].equals(""))
				str=ages[1].trim() +" months "+str;

			if(!ages[0].equals(""))
				str=ages[0].trim()+" years "+str;	*/

			String cdat = myDate.getCurrentDate("ymd",true);
			//out.println(id+" : "+cdat);
			str=rcGen.getPatientAgeYMD(id,cdat);

			atyp=temp.getValue("type");
			atyp=minfo.getAgeValues().getValue(atyp);
			state=temp.getValue("state");
			state=minfo.getStateValues().getValue(state);
			district = temp.getValue("dist");
			district = minfo.getDistrictValues().getValue(district);
			appellation = temp.getValue("pre");
			appellation = minfo.getAppellationValues().getValue(appellation);
			religion = temp.getValue("religion");
			religion = minfo.getReligionValues().getValue(religion);
			idChecked = temp.getValue("persidchecked");
			if(idChecked.equals("1")){idChecked="checked";}

			relationship = temp.getValue("relationship");
			primarypatid = temp.getValue("primarypatid");

		}
	 }

	}catch(Exception e){
		out.println("Error in 1 :"+e);
	}

%>

<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/JsBarcode.all.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.css">

<TITLE>PATIENTS DATA-MED FORM....
</TITLE>
<link rel="stylesheet" href="../style/style2.css" type="text/css" media="screen" />

<script>
	$(document).ready(function(){
		var pat_id = "";
		JsBarcode("#barcode", "<%=id.toUpperCase()%>",{
			height:30,
			width:1,
			fontSize:14,
			background:"#eee"
			//text:"iMediX"
		});
	});


	var isPHONE = function validatePhone(phone) {
	    const re = /^\d{10}$/;
	    return re.test(String(phone));
	};

	var isEMAIL = function validateEmail(email) {
	    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(String(email).toLowerCase());
	};

	function sendDetails()
	{
	//	alert("send details");
		$('#modalSend').modal();
	}
	function SEND()
	{
		var pat_name="<%=appellation%>"+" "+"<%=temp.getValue("pat_name")%>"+" "+"<%=temp.getValue("m_name")%>"+" "+"<%=temp.getValue("l_name")%>";
		var id="<%=id.toUpperCase()%>";
		//console.log("patid:"+id);
		//console.log("pat_name:"+pat_name);
		var email=$("#email").val();
		var phone=$("#phone").val();
		//console.log(email+"   "+phone);
		if(email=="" && phone=="")
		{
			alert("No email id and no phone number given");
			return;
		}
		if(email!="" && !isEMAIL(email))
		{
			alert("Please check the format of email id !");
			return;
		}
		if(phone!="" && !isPHONE(phone))
		{
			alert("Please check the format of Phone Number !");
			return;
		}
		//phone="+91"+phone;
		//console.log(phone);
		var url="sendLoginDEO.jsp?id="+id+"&pat_name="+pat_name+"&email="+email+"&phone="+phone;
		$.post(url, function(data,status){
			var st=data;
			var disp=st.substring(st.indexOf("<p>")+3,st.indexOf("</p>"));
			alert(disp);
		});

	}



</script>
</HEAD>
<body onload="showhide('<%=present_status%>');" class="disp-med">

<div class="container-fluid">

<CENTER><BR>
<FONT SIZE="+1" COLOR="#333300"><U><B>Patient's Information</B></U></FONT>

<div class="row well">


	<div class="col-sm-6">

		<table class="table table-bordered">
<%if(present_status.equals("YES")) { //whether patient details will be shown or not%>

		<tr><td><B><FONT SIZE="+1" COLOR="#330000">Patient name :</FONT></td><td><B><FONT SIZE="+1" COLOR="#330000"><%=appellation%>&nbsp;<%=temp.getValue("pat_name")%>&nbsp;<%=temp.getValue("m_name")%>&nbsp;<%=temp.getValue("l_name")%></FONT></td></tr>

		<%} else {%>

		<tr><td><B><FONT SIZE="+1" COLOR="#330000">Patient name :</FONT></b></td>
		<td><B><FONT SIZE="+1" COLOR="#330000">********</FONT></b></td></tr>

		<%}%>
		<%
		try
		{
			docname=uinfo.getName(referring_doc);
		}
		catch(Exception e1)
		{
			out.println("Error2 in :"+e1);
		}
		%>

	<!--	<tr><td><B><FONT SIZE="+1" COLOR="#330000">Referred by <I>Dr.</I></b></FONT></td>-->
		<tr><td><B><FONT SIZE="+1" COLOR="#330000">Doctor Name : </b></FONT></td>
		<td><I><FONT SIZE="+1" COLOR="#336600"><%=docname%></FONT></I></td></tr>
		</table>
		</div>		<!-- "col-sm-6" -->
		<div class="col-sm-6">

		<table class="table table-bordered">
		<tr><td><B><FONT SIZE="+1" COLOR="#330000">Reg. Date : </td><td><Font color=#330000> <%=date%></font></B></td></tr>
		<tr><td colspan="2" align="center"><svg id="barcode"></svg></td></tr>
		</table>

	</div>		<!-- "col-sm-6" -->

</div>		<!-- "row" -->


<div class="row well">
<div class="col-sm-6">
			<table class="table table-bordered">
			<tr><td>Patient ID :</td><td><Font color=BROWN><%=id.toUpperCase()%></font></td></tr>
			<tr><td>Age group :</td><td><Font color=MAROON><%=atyp.toLowerCase()%></font></td></tr>
			<tr><td>Age :</td><td><Font color=MAROON><%=str%></font></td></tr>
			<tr><td>Sex :</td></td><td><Font color=MAROON><%=wsex%></font></td></tr>
			<tr><td>Caste :</td><td><Font color=MAROON><%=wcc%></font></td></tr>

			</table>
			<INPUT TYPE="hidden" name=age>
</div>		<!-- "col-sm-6" -->

<div class="col-sm-6">
			<table class="table table-bordered">
			<tr><td>Marital Status :</td><td><Font color=MAROON><%=m_status%></font></td></tr>
			<tr><td>Religion :</td><td><Font color=MAROON><%=religion%></font></td></tr>
			<!--<tr><td>Race  :</td><td><Font color=MAROON><%=temp.getValue("race")%></font></td></tr>
			<tr><td>Disease type :</td><td><Font color=MAROON><%=temp.getValue("class")%></font></td></tr>-->
			<tr><td>Hospital OPD Identity</td><td><Font color=MAROON><%=temp.getValue("opdno")%></font></td></tr>
			<tr><td>IdentityCard Type:</td><td><Font color=MAROON><%=temp.getValue("persidtype")%></font></td></tr>
			<tr><td>IdentityCard Details :</td><td><Font color=MAROON><%=temp.getValue("persidvalue")%></font><span class="<%=idChecked%>"></span></td></tr>

			<INPUT TYPE="hidden" name=consent value=u>
			 <!-- y for yes, u for null n for no -->
			</table>
</div>		<!-- "col-sm-6" -->
</div>		<!-- "row" -->





<%if(present_status.equals("YES")) { // then 'whether patient details will be shown or not%>

<div class="row well">

<div class="col-sm-6">
			<table class="table table-bordered" width=100%>
			<TR><TD COLSPAN=2><h4><CENTER>Patient's Details</CENTER></h4></TD></TR>
			<tr><td rowspan=2>Address :</td><td><Font color=MAROON><%=temp.getValue("addline1")%></font></td></tr>
			<tr><td><Font color=MAROON><%=temp.getValue("addline2")%></font></td></tr>
			<tr><td>Police Stn.:</td><td><Font color=MAROON><%=temp.getValue("policestn")%></font></td></TR>
			<TR><td>Phone :</td><td><Font color=MAROON><%=temp.getValue("phone")%></font></td></tr>
			<tr><td>City :</td><td><Font color=MAROON><%=temp.getValue("city")%></font></td></tr>
			<tr><td>District :</td><td><Font color=MAROON><%=district%></font></td></tr>
			<tr><td>State :</td><td><Font color=MAROON><%=state%></font></td></tr>
			<tr><td>Country :</td><td><Font color=MAROON><%=temp.getValue("country")%></font></td></tr>
			<tr><td>Pin :</td><td><Font color=MAROON><%=temp.getValue("pin")%></font></td></tr>
			</table>
</div>		<!-- "col-sm-6" -->

<div class="col-sm-6">
			<table class="table table-bordered">
			<TR><TD COLSPAN=2><h4><CENTER>Contact Person Details</CENTER></h4></TD></TR>
			<TR><TD>Name :</TD><TD><Font color=MAROON><%=temp.getValue("pat_person")%></font></TD></TR>
			<TR><TD>Relation :</TD><TD><Font color=MAROON><%=temp.getValue("pat_relation")%></font></TD></TR>
			<TR><TD>Address :</TD><TD><Font color=MAROON><%=temp.getValue("pat_person_add")%></font></TD></TR>
			<INPUT TYPE="hidden" name="doctor" value='<%=referring_doc%>'>

			</table>
	<%}%>

			<table class="table table-bordered">
			<TR><TD COLSPAN=2><h4><CENTER>Relationships</CENTER></h4></TD></TR>
			<TR><TD>Relationship :</TD><TD><Font color=MAROON><%=relationship%></font></TD></TR>
			<TR><TD>Primary Patient ID :</TD><TD><Font color=MAROON><%=primarypatid%></font></TD></TR>

			</table>



<A class="btn btn-default pull-left" href=editmed.jsp?id=<%=id%> ><IMG class="img-responsive" SRC="../images/edittxt.jpg" WIDTH="90" HEIGHT="30" BORDER=0 ALT="Edit This Document"></A>
<A class="btn btn-default pull-right" target="_blank" HREF="displaymed_print.jsp?id=<%=id%>"   Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="../images/print.jpg" WIDTH="90" HEIGHT="30" BORDER=0 ALT="Print This Document"></A>

<!--<A class="btn btn-default pull-right" id="print" HREF="Javascript:void(0)"   Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG class="img-responsive" SRC="../images/print.jpg" WIDTH="90" HEIGHT="30" BORDER=0 ALT="Print This Document"></A>-->
</div>		<!-- "col-sm-6" -->




<% if(login.equalsIgnoreCase("Y")) { %>
<div class="col-sm-6" style="top:20px;left:8px;border: 3px solid #ddd;padding:8px;">
<p style="text-align:left;color:blue;">Do you want to send the login details via email/sms?
<input class="btn btn-primary pull-right" onclick="sendDetails()" value="Send Login Details"></input></p>
</div>
<% } %>
</div>		<!-- "row" -->





<div class="modal fade" id="modalSend" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="location.reload();"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" style="color:blue;">Enter email and phone details</h4>
        </div>

        <div class="modal-body" >

						<div style="padding:4px;float:left;">Email Id:		<input type = "text" name="email" id="email" placeholder = "Email ID"   required /></div>
						<div style="padding:4px;float:left;">Phone Number:  <input type="text" name="phone" id="phone" maxlength=11 placeholder = "Phone Number"  /></div>

        </div>
				<div class="modal-footer">
				<input class="btn btn-primary upload-btn" type="submit" name="submit" value="Submit" onClick="SEND()"  />
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.reload();">Close</button>
				</div>



            <!--<button type="button" class="btn btn-primary" onClick="addLogo()">Save changes</button>-->

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



 <DIV id='patdetail' STYLE="position:relative;top:50;background-color:'#EDDBCB';visibility='hidden'">

</DIV>
  <div class="row"><div class="col-sm-1"></div><div id="previewImage" class="col-sm-10"></div><div class="col-sm-1"></div></div>
</div>		<!-- "container-fluid" -->
</body>
<script>
var element = $(".disp-med");
var getCanvas;

    $("#print").on('click', function () {
         html2canvas(element, {
         onrendered: function (canvas) {
                $("#previewImage").append(canvas);
                getCanvas = canvas;
             }
         });


			setTimeout(function(){
				$("#previewImage canvas").css("width","100%");

				//savePDF();
					//window.print();
			},2000);
    });

   /* function savePDF(){
				 $("canvas").attr("style","display:none");
		 try {
			 var canvas = document.getElementsByTagName('canvas')[0];
			canvas.getContext('2d');
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
		    var pdf = new jsPDF('p', 'mm', [350, 350]);
		    pdf.addImage(imgData, 'JPEG', 5, 5);
		    var namefile = "<%=id%>";
		    pdf.save(namefile + ".pdf");
		 } catch(e) {
			 alert("Error description: " + e.message);
		 }

	}*/

</script>

</html>
<%
//objrs.close
//set objrs=nothing
%>
