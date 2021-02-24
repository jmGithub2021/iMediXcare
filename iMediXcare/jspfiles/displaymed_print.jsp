<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.medinfo,imedix.rcUserInfo,imedix.dataobj,imedix.rcDisplayData,imedix.rcGenOperations,imedix.myDate,imedix.cook, imedix.myDate,java.util.*" %>

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
body{    
	width: 790px;
   // margin: auto !important;
    }
//.table{margin-bottom:0px !important;}
//h4{margin:0px !important;}
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
	String idChecked = "";
	
	//String mcls="",mreg="",madd1="",madd2="",mpstn="",mphn="",mcity="",mdis="", mstate="",mcon="",mpin="",mpper="",mprela="",mpadd="", caste_category="",wcc="";

	dataobj temp=null;
	
	String m_status="";

	//String present_status="",qr1="";
	//present_status = thisObj.getCookies("telemedcook")("datahide")
	
	//ty = request.getParameter("ty");
	id = request.getParameter("id");
	dt = request.getParameter("dt");
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
				str=ages[0].trim()+" years "+str;*/
				
			String cdat = myDate.getCurrentDate("ymd",true);				
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
		<script src="../bootstrap/JsBarcode.all.min.js" ></script>
				<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/bootstrap/jspdf/jspdf.debug.js" type="text/javascript"></script>

<TITLE>PATIENTS DATA-MED FORM....
</TITLE>


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

</script>
</HEAD>
<body onload="showhide('<%=present_status%>');" class="disp-med">

<div class="container-fluid">

<CENTER><BR>
<FONT SIZE="+1" COLOR="#333300"><U><B>Patient's Information</B></U></FONT>

<div class="row">


	<div class="col-sm-12">
	
		<table class="table table-bordered">
<%if(present_status.equals("YES")) { //whether patient details will be shown or not%>

		<tr><td><label>Patient name :</label></td><td><B><FONT COLOR="#330000"><%=appellation%>&nbsp;<%=temp.getValue("pat_name")%>&nbsp;<%=temp.getValue("m_name")%>&nbsp;<%=temp.getValue("l_name")%></FONT></td></tr>

		<%} else {%>

		<tr><td><B><FONT COLOR="#330000">Patient name :</FONT></b></td>
		<td><B><FONT COLOR="#330000">********</FONT></b></td></tr>

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

	<!--	<tr><td><B><FONT COLOR="#330000">Referred by <I>Dr.</I></b></FONT></td>-->
		<tr><td><B><FONT COLOR="#330000">Doctor Name : </b></FONT></td>
		<td><I><FONT COLOR="#336600"><%=docname%></FONT></I></td></tr>

		<tr><td><B><FONT COLOR="#330000">Reg. Date : </td><td><Font color=#330000> <%=date%></font></B></td></tr>
		<tr><td colspan="2" align="center"><svg id="barcode"></svg></td></tr>
		</table>
	
	</div>		<!-- "col-sm-6" -->

</div>		<!-- "row" -->


<div class="row">
<div class="col-sm-6">
			<table class="table table-bordered">
			<tr><td>Patient ID :</td><td><Font color=BROWN><%=id.toUpperCase()%></font></td></tr>
			<tr><td>Age group :</td><td><Font color=MAROON><%=atyp.toLowerCase()%></font></td></tr>
			<tr><td>Age :</td><td><Font color=MAROON><%=str%></font></td></tr>
			<tr><td>Sex :</td></td><td><Font color=MAROON><%=wsex%></font></td></tr>
			<tr><td>Caste :</td><td><Font color=MAROON><%=wcc%></font></td></tr>

			
			<INPUT TYPE="hidden" name=age>

			<tr><td>Marital Status :</td><td><Font color=MAROON><%=m_status%></font></td></tr>
			<tr><td>Religion :</td><td><Font color=MAROON><%=religion%></font></td></tr>
			<!--<tr><td>Race  :</td><td><Font color=MAROON><%=temp.getValue("race")%></font></td></tr>-->
			<tr><td>Disease type :</td><td><Font color=MAROON><%=temp.getValue("class")%></font></td></tr>
			<tr><td>Hospital OPD Identity</td><td><Font color=MAROON><%=temp.getValue("opdno")%></font></td></tr>
			<tr><td>IdentityCard Type:</td><td><Font color=MAROON><%=temp.getValue("persidtype")%></font></td></tr>
			<tr><td>IdentityCard Details :</td><td><Font color=MAROON><%=temp.getValue("persidvalue")%></font><span class="<%=idChecked%>"></span></td></tr>
			
			<INPUT TYPE="hidden" name=consent value=u>
			 <!-- y for yes, u for null n for no -->
			</table>
</div>		<!-- "col-sm-6" -->


		



<%if(present_status.equals("YES")) { // then 'whether patient details will be shown or not%>



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
	


</div>		<!-- "col-sm-6" -->	
</div>		<!-- "row" -->			


 <DIV id='patdetail' STYLE="position:relative;top:50;background-color:'#EDDBCB';visibility='hidden'">

</DIV>	
  <div class="row"><div class="col-sm-1"></div><div id="previewImage" class="col-sm-10"></div><div class="col-sm-1"></div></div>
</div>		<!-- "container-fluid" -->
</body>
<script>

	$(document).ready(function(){
			
	


         html2canvas(element, {
         onrendered: function (canvas) {
               // $("#previewImage").append(canvas);
              //  getCanvas = canvas;
               // savePDF(canvas);	
             }
         });
	
	});



    function savePDF(canvas){
				// $("canvas").attr("style","display:none");
		 try {
			 //var canvas = document.getElementsByTagName('canvas')[0];
			//canvas.getContext('2d');
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
		    var pdf = new jsPDF();
		    pdf.addImage(imgData, 'JPEG', 1, 0);
		    var namefile = "<%=id%>_med";
		    		        var iframe = document.createElement('iframe');
		        iframe.setAttribute('style', 'position:absolute;top:0;right:0;height:100%; width:100%');
		        document.body.appendChild(iframe);
		        iframe.src = pdf.output('datauristring');
		    //pdf.save(namefile + ".pdf");
		 } catch(e) {
			 alert("Error description: " + e.message);
		 }
		 
	}














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
    
  /*  function savePDF(){
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
