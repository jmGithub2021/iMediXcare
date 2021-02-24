<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.rcPatqueueInfo,imedix.Email,imedix.rcUserInfo,imedix.dataobj,imedix.rcCentreInfo,imedix.cook,java.util.*, java.text.DateFormat, java.text.SimpleDateFormat,imedix.SMS,imedix.rcSmsApi"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();

	cook cookx = new cook();
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	rcCentreInfo cnfo = new rcCentreInfo(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcPatqueueInfo rpqinfo = new rcPatqueueInfo(request.getRealPath("/"));

	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String userid =cookx.getCookieValue("userid", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());
	String patname = cookx.getCookieValue("patname", request.getCookies());

	dataobj obj = new dataobj();

	String hosnam="",records="",srec="";
	String patid=request.getParameter("pat_id");
	records=request.getParameter("records");
	//pat_id, entrydate, teleconsultdt, assigneddoc, refer_doc, refer_center, discategory, checked, delflag, assignedhos, issent, lastsenddate
	/*obj.add("pat_id",request.getParameter("pat_id"));
	obj.add("attending_doc",request.getParameter("att_doc"));
	obj.add("referred_doc",request.getParameter("rdocnam"));
	obj.add("referred_hospital",request.getParameter("rhoscod"));
	obj.add("local_hospital",cookx.getCookieValue("currpatqcenter", request.getCookies()));
	obj.add("sent_by",cookx.getCookieValue("userid", request.getCookies()));

	String hosnam="",records="",srec="";
	String patid=request.getParameter("pat_id");

	records=request.getParameter("records");



	if(records.equals("all"))
	{
		obj.add("send_records","all");
	}

	obj.add("userid",userid);
	obj.add("usertype",usr);
	hosnam=rcdef.SaveTeleMedRequest(obj);*/
	//String entrydate =
	//"11-11-11 11:11:11"
	obj.add("attending_doc",request.getParameter("att_doc"));

	String department = request.getParameter("department");
	String rdocnam = request.getParameter("rdocnam");
	String teleDocname="";
	String phy="";
	if(rdocnam.equals("NIL")){
		// need to select doctor based on department
		Object res1 = rcui.docOfMinPat(ccode, department);
		Vector vtemp = (Vector)res1;
		if(vtemp.size()>0){
			dataobj ddobj = (dataobj)vtemp.get(0);
			phy = String.valueOf(ddobj.getValue("rg_no"));			
		}
		if(!phy.equals("")){
			obj.add("referred_doc",phy);
			rdocnam = phy;
		}
	}else{
		obj.add("referred_doc",request.getParameter("rdocnam"));
	}



	
	obj.add("referred_hospital",request.getParameter("rhoscod"));
	obj.add("local_hospital",request.getParameter("curr_ccode"));
	obj.add("sent_by",cookx.getCookieValue("userid", request.getCookies()));
	obj.add("pat_id",request.getParameter("pat_id"));
	obj.add("send_records",request.getParameter("records"));
	obj.add("entrydate",dateFormat.format(cal.getTime()));
	obj.add("usertype",usr);
	obj.add("userid",userid);

		String attending_docname = rcui.getName(request.getParameter("att_doc"));
	/*	String referred_doc = obj.getValue("referred_doc");
		String referred_hospital = obj.getValue("referred_hospital");
		String local_hospital = obj.getValue("local_hospital");
		String sent_by = obj.getValue(("sent_by");
		String pat_id = obj.getValue(("pat_id");
		String send_records = obj.getValue(("send_records");
		String usertype = obj.getValue(("usertype");
	*/
	//pat_id, entrydate, attending_doc, referred_doc, referred_hospital, local_hospital, sent_by, send_records, userid, usertype
	//String sql = "insert into tpatwaitq (pat_id, entrydate, attending_doc, referred_doc, referred_hospital, local_hospital, sent_by, send_records, userid, usertype, status, req_id) values ("+"'"+pat_id+"',"+"'"+dateFormat.format(cal.getTime())+"',"+"'"+attending_doc+"',"+"'"+referred_doc+"',"+"'"+referred_hospital+"',"+"'"+local_hospital+"',"+"'"+sent_by+"',"+"'"+send_records+"',"+"'"+userid+"',"+"'"+usertype+"',"+"'W',"+"'todo'"+")";

	//out.println("The query to be executed :: "+sql);

	//String result = dbc.ExecuteUpdateQuery(sql);

	//out.println("\nrow fgrf binserted!!!   "+result);
	String result = "";
	boolean result1 = false;
	if(cnfo.isValidCenter(request.getParameter("rhoscod"))){
		result = rcdef.add2TpatWaitQ(obj);
		result1 = rpqinfo.resetAppoinmentLpatq(patid); //appdate is null in lpatq
		Email email = new Email(request.getRealPath("/"));

		//Object teleDocres=rcui.getuserinfoByrgNo(request.getParameter("rdocnam"));
		Object teleDocres=rcui.getuserinfoByrgNo(rdocnam);
		Vector teleDoctmp = (Vector)teleDocres;
		
		if(teleDoctmp.size()>0){
			dataobj teleDoctemp = (dataobj) teleDoctmp.get(0);

			String teleDocemailid = (String) teleDoctemp.getValue("emailid");
			String teleDocmobileno = (String) teleDoctemp.getValue("phone");
			String teleDocverifemail = (String) teleDoctemp.getValue("verifemail");
			String teleDocverifphone = (String) teleDoctemp.getValue("verifphone");
			teleDocname = (String) teleDoctemp.getValue("name");

			if (teleDocverifemail.equalsIgnoreCase("Y")) {
				String messgtele = "Dear Dr."+teleDocname.replaceAll("(?i)Dr.","")+",\n\n"+
									"Dr. "+attending_docname.replaceAll("(?i)Dr.","")+" has assigned a patient to you."+
									"\nPatient ID: "+patid;
				email.Send(teleDocemailid,"Patient Referral",messgtele);
			}
			if (teleDocverifphone.equalsIgnoreCase("Y")) {
				String dataAry[] = new String[3];
				dataAry[0] = teleDocname.replaceAll("(?i)Dr.","");
				dataAry[1] = attending_docname.replaceAll("(?i)Dr.","");
				dataAry[2] = patid;
				rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
				String message = (String) rcsmsapi.makeMessage("M008", dataAry);
				SMS sms = new SMS(request.getRealPath("/"));
				String retmsg = sms.Send(teleDocmobileno, message);
			}
		}
		Object patres=rcui.getuserinfo(patid);
		Vector pattmp = (Vector)patres;
		if(pattmp.size()>0){
			dataobj pattemp = (dataobj) pattmp.get(0);
			String patemailid = (String) pattemp.getValue("emailid");
			patname = (String) pattemp.getValue("name");
			email.Send(patemailid,"Referral Status", "Dear "+patname+",\n\n"+"You are referred to Dr. "+teleDocname.replaceAll("(?i)Dr.","")+". You will receive the consultation date and time shortly.");
		}
		//out.println(request.getParameter("rdocnam"));


%>
<html>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.css">


	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js?"+n></script>
	<script src="<%=request.getContextPath()%>/vc/vc.js?ver=1.3"></script>
<head>
	<script>
function today(){
    var date = new Date();
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    if (month < 10) month = "0" + month;
    if (day < 10) day = "0" + day;
    var today = year + "-" + month + "-" + day;
return today;
}
		$(document).ready(function(){
		let delSts = false;
		//if(sessionStorage.getItem("isPrescribed")!="yes")
			delSts = confirm("Do you want to followup the patient later?");
		//console.log(patid+" Pat List: "+patlist);
		let patid = "<%=patid%>";
		var patname = "<%=patname%>";
			if(delSts==true){
				alert('Please set an appointment date to '+patname+'.');
				var time = new Date();
					var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });
				var htmlbody = "<form>"+
							"<fieldset>"+
							"<ol>"+
							"<li><label for='meeting'>Appointment Date & Time </label>"+
							"<br><br>Date: <input type='date' name='Dt' id='Dt' class='text'> <br><br>"+
							"Time: <select name='Hr' id='Hr'></select> Hrs <select name='Mn' id='Mn'></select> Minutes <br><br>"+
							"</li>"+
							"<li>"+
							"<label for='Others'>Extra comments</label> </br>"+
							"<input name='Others' id='Others' size=25 maxlength=200> </br>"+
							"</li>"+
							"</ol>"+
							"<input type='submit' tabindex='-1' style='position:absolute; top:-1000px'>"+
							"</fieldset>"+
							"</form>";

				$("#dialog-form").html(htmlbody);
				$("#Dt").attr("value", today());
				$( "#hr" ).html();
				$( "#Mr" ).html();
				for (let i=8; i<23; i++) $( "#Hr" ).append('<option value="'+i+'">'+i+'</option>');
				for (let i=0; i<59; i+=5) $( "#Mn" ).append('<option value="'+i+'">'+i+'</option>');

				dialog = $( "#dialog-form" ).dialog({
				  autoOpen: false,
				  height: 350,
				  width: 400,
				  modal: true,
					buttons: {
				Cancel: function() {
						dialog.dialog( "close" );
					},
					"Set Appointment": function(evt) {
						buttonDomElement = evt.target;
						$(buttonDomElement).attr('disabled', true);
					var Dt = $("#Dt" ).val();
					var Hr = $("#Hr" ).val();
					var Mn = $("#Mn" ).val();
					var Oth = $("#Others").val();
					/*alert ( "meetingMail : " + meetingMail + "\n" +
										 "Meeting Time : " + Hr + ":" + Mn + "\n"+
						 "Others : " + Oth); */

					$.ajax({
						type: "post",
						url: "../jspfiles/commdoc2pat.jsp",
						data:{'Dt':Dt, 'Hr':Hr, "Mn":Mn, "Others":Oth, "uid": patid, "uname": patname},
						success: function(data){
							alert( "Data Loaded, Mail will be sent \n\n" + data.trim() );
							dialog.dialog( "close" );
						},
						complete:function(){
							$.ajax({
								type: "get",
								url: "patLTreatmentSts.jsp",
								data:{status:delSts,patid:patid,dateapp:Dt},
								success: function(data){
									patlist = JSON.parse(data.trim());
									if(patlist.length==0)
										alert("There is no patient in the queue. Please goto local pateint queue and set pateint appointment.");
								},
								complete:function(){
									if(patlist.length<1)
										$(this).prop("disabled",true);
									if(patlist.length>=1){
										let next = (patlist[0]==patid)?patlist[1]:patlist[0];
										let searchP= location.search.replace("?","");
										searchP = searchP.replace(patid,next)
										window.location.href = "index1.jsp?"+searchP;
									}
								}
							});
						}
					});
					/*$.post( "../jspfiles/commdoc2pat.jsp", {'Dt':Dt, 'Hr':Hr, "Mn":Mn, "Others":Oth, "uid": patid, "uname": patname}, function( data ) {
						alert( "Data Loaded, Mail will be sent \n\n" + data.trim() );
						dialog.dialog( "close" );
					});*/

				}

				   },
			   close: function() {
				//form[ 0 ].reset();
				//allFields.removeClass( "ui-state-error" );
				  }
				});

				dialog.dialog( "open" );
					 $("#meeting").focus();


			}
			else{
				$.ajax({
					type: "get",
					url: "patLTreatmentSts.jsp",
					data:{status:delSts,patid:patid,patqtype:"local"},
					success: function(data){
						patlist = JSON.parse(data.trim());
						//alert("Remaining patient: "+patlist.length);
						if(patlist.length==0)
							alert("There is no patient in the queue. Please goto local pateint queue and set pateint appointment.");
						//sessionStorage.removeItem("isPrescribed");
					},
					complete:function(){
						if(patlist.length<1)
							$(this).prop("disabled",true);
						if(patlist.length>=1){
							let next = (patlist[0]==patid)?patlist[1]:patlist[0];
							let searchP= location.search.replace("?","");
							searchP = searchP.replace(patid,next)
							window.location.href = "index1.jsp?"+searchP;
						}
					}
				});
			}
		});
	</script>
</head>

<body><BR><BR><BR><BR><BR><BR><BR>
<CENTER><TABLE border=0>
<TR>
	<TD align=center>

	<%
	if(result.indexOf("Error")>1){
		out.println(result.toUpperCase()+"<br>");
		out.println("You may be already referred.\n");
		out.println("Try Again");
	}else{
	%>
	<input type="button" value="BACK" onclick="history.back()">
	<h3 style="COLOR:green">Patient has been referred for tele-consultation</h3>
	<table class="table table-bordered">
	<tbody>
	<tr><td>Patient Id</td><td><%=patid%></td></tr>
	<tr><td>Centre Name</td><td><%=cnfo.getHosName(request.getParameter("rhoscod"))%></td></tr>
	<tr><td>Doctor Name</td><td><%=teleDocname%></td></tr>
	
	</tbody>
	</table>
	<!--<FONT SIZE=+2 COLOR=green><B>Data of the Patient ('<%=patid%>') will be sent to Tele Pat Wait Q</B></FONT>-->
	<%}%>
</TD>
</TR>
</TABLE>
<div id="dialog-form" title="Send Email Reminder"></div>
</CENTER></body>
</html>
<% }
	else{
		out.println("Reffered center does not exist in iMediX");
}%>
