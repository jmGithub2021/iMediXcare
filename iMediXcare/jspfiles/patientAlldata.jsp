<%@page contentType="text/html" import="java.util.Date,java.text.SimpleDateFormat,imedix.layout,java.io.*,java.text.*,imedix.cook,imedix.rcGenOperations,imedix.rcDisplayData,imedix.rcUserInfo,imedix.rcPatqueueInfo,imedix.dataobj,imedix.myDate,imedix.projinfo, java.util.*,org.json.simple.*,org.json.simple.parser.*,imedix.Crypto,javax.crypto.*" %>
<%@ include file="_patientAlldata.jsp" %>


<%!
public String listOfFomrs(String patid,String ftype,String slno,String dt, rcDisplayData ddinfo) throws Exception{
	String result="";
	int tag=0;
	Vector Vres;
	Vres = (Vector) ddinfo.getAttachmentAndOtherFrm(patid,ftype,slno,dt);

	Object Objtmp = Vres.get(1);
	if(Objtmp instanceof String){ tag=1;}
	else{
	Vector Vtmp = (Vector)Objtmp;
	if(Vtmp.size()>1 ) {
		String sn;
		result = "<SELECT class='form-control input-sm noofforms' NAME=abc >";
		//result += "<option></option>";
		for(int i=0;i<Vtmp.size();i++){
			dataobj datatemp = (dataobj) Vtmp.get(i);
			String pdt = datatemp.getValue("date");
			String dt3 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			sn=datatemp.getValue("serno");
			//out.println("dt3:-"+dt3+"sn:-"+sn);
			//if(sn.length()<2)  sn= "0" + sn;
			//result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' >"+ftype+"-"+sn+"</option>";
			if(i<Vtmp.size()-2)
			result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' >"+dt3+"-"+sn+"</option>";
			else
			result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' selected>"+dt3+"-"+sn+"</option>";
		}
		result += "</SELECT>";
	}
	}
	return result;
}



%>

<%
	cook cookx = new cook();
	String patid = cookx.getCookieValue("patid", request.getCookies());
	String patname=cookx.getCookieValue("patname", request.getCookies());
	String patagem=cookx.getCookieValue("patagem", request.getCookies());
	String PatAgeYMD = cookx.getCookieValue("PatAgeYMD", request.getCookies());
	String sex = cookx.getCookieValue("sex", request.getCookies());
	String patdis = cookx.getCookieValue("patdis", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String c_nam = cookx.getCookieValue("center", request.getCookies ());
	String uid = cookx.getCookieValue("userid", request.getCookies ());
	String currpatqtype = cookx.getCookieValue("currpatqtype",request.getCookies());
	String utype = cookx.getCookieValue("usertype",request.getCookies());
	String dat = myDate.getCurrentDate("dmy",false);
	String ty="";
	String patUpdateapptURL = "";



	if(currpatqtype.equalsIgnoreCase("local")) ty="pre";
	else ty="prs";
	patUpdateapptURL = (currpatqtype.equalsIgnoreCase("local"))?"commdoc2pat.jsp":"commdoc2tpat.jsp";

	String laptqlistObj = (String)session.getAttribute("lpatqlist");
	JSONParser lpatparser = new JSONParser();
	JSONArray lpatqlist = new JSONArray();
	String nextPat = "[]";
	if(laptqlistObj!=null){
		lpatqlist = (JSONArray)lpatparser.parse(laptqlistObj);
		nextPat = String.valueOf(lpatqlist);
	}
	//out.println(lpatqlist);
	//lpatqlist.remove(0);
	//out.println(lpatqlist);
	projinfo pr = new projinfo(request.getRealPath("/"));
	int allowedFileNo = Integer.parseInt(pr.maxFileUploadLimit);

	rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
	rcPatqueueInfo rcpqi = new rcPatqueueInfo(request.getRealPath("/"));
	String pq = rcpqi.getTotalLPatAdmin(uid);

	Object res1 = (Object)ddinfom.getDataTeleRequest(c_nam,patid);
	Vector Vtmp1 = (Vector)res1;
	String doc_rgno = String.valueOf(Vtmp1.get(0));
	String assignDoc = uinfo.getName(doc_rgno);

String cdate=myDate.getCurrentDate("dmy",false);

String currdate=myDate.getCurrentDate("ymd",true);

if(patid != null && !patid.equals("")){

	//rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	//rcUserInfo uinfo = new rcUserInfo(request.getRealPath("/"));
	String r = uinfo.getreg_no(uid);

Date cur_date = new Date();
SimpleDateFormat dde = new SimpleDateFormat("dd/MM/yyyy");
String today = dde.format(cur_date);
//out.println(today);

int totalFile = Integer.parseInt(uinfo.fileUploadLimit(7,uid));
	//out.println("CURrent patq : "+currpatqtype);
%>

<%
String gen_exam_cn="",gen_exam_dt="",gen_exam_dt1="",gen_exam_sl="";
String chief_com_cn="",chief_com_dt="",chief_com_dt1="",chief_com_sl="";
String prc_cn="",prc_dt="",prc_dt1="",prc_sl="";
String advcInvs_cn="",advcInvs_dt="",advcInvs_dt1="",advcInvs_sl="";

int gen_flag=0,chief_flag=0,prc_flag=0;

Vector alldata=null;
Object res=null;
String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
Date date = new Date();
long timeMilli = date.getTime();
//System.out.println("PROFILING: patientAlldata.jsp before RMI call DisplayData:showAllLists started, TIME- "+timeStamp+"  IN Miliseconds:-"+timeMilli);
	alldata= (Vector)ddinfom.showAllLists(patid);
Date date2 = new Date();
long timeMilli2 = date2.getTime();
	String timeStamp2 = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
	//System.out.println("PROFILING: patientAlldata.jsp after RMi call DisplayData:showAllLists ended, TIME- "+timeStamp2+"  IN Miliseconds:-"+timeMilli2);

	res = (Object)alldata.get(0);
		if(res instanceof String){
				out.println("No Form");
		 }
		else{
			Vector Vtmp = (Vector)res;
			//if(Vtmp.size()>0 ) {
			if(Vtmp.size()>1 ) {
				for(int i=0;i<Vtmp.size();i++){
					dataobj datatemp = (dataobj) Vtmp.get(i);
					String pty = datatemp.getValue("type");
					//out.println(pty +" : "+ datatemp.getValue("serno"));
					//out.println("DATE:"+datatemp.getValue("date"));
					if(pty.equalsIgnoreCase("p47") && gen_flag==0){
						gen_exam_cn=datatemp.getValue("par_chl");
						gen_exam_dt = datatemp.getValue("date");
						gen_exam_dt1 = gen_exam_dt.substring(8,10)+"/"+gen_exam_dt.substring(5,7)+"/"+gen_exam_dt.substring(0,4);
						gen_exam_sl = datatemp.getValue("serno");
						gen_flag=1;
						//out.println("gen_exam_dt "+gen_exam_dt);

					}
					else if(pty.equalsIgnoreCase("a14") && chief_flag==0){
						chief_com_cn = datatemp.getValue("par_chl");
						chief_com_dt = datatemp.getValue("date");
						chief_com_dt1 = chief_com_dt.substring(8,10)+"/"+chief_com_dt.substring(5,7)+"/"+chief_com_dt.substring(0,4);
						chief_com_sl = datatemp.getValue("serno");
						chief_flag=1;
						//out.println("chief_com_dt "+chief_com_dt);
						//break;
					}
					else if((pty.equalsIgnoreCase("pre") || pty.equalsIgnoreCase("prs")) && prc_flag==0){
						prc_cn=datatemp.getValue("par_chl");
						prc_dt = datatemp.getValue("date");
						//out.println("Date:"+prc_dt);
						prc_dt1 = prc_dt.substring(8,10)+"/"+prc_dt.substring(5,7)+"/"+prc_dt.substring(0,4);
						prc_sl = datatemp.getValue("serno");
						prc_flag=1;
						//out.println("prc_dt "+prc_dt);
						//break;
					}

				}

			}
		}
//out.println("rrrrrrrrrrrrrr : "+noOfRecords("ai0",patid,request));
%>

<html>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/bootstrap-datetimepicker.pt-BR.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/html2canvas.js" type="text/javascript"></script>
	<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.js"></SCRIPT>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/jquery-ui.css">

<style>
.ui-menu.ui-autocomplete{
	overflow-y:auto;
	max-height:200px;
	}
.ui-menu:hover{overflow-x:hidden;}
.repeat-prescription{
    position: absolute;
    left: 5px;
    top: 4px;
    color: #0b7cde;
    cursor: pointer;
    font-weight: 600;
    padding: 8px 2px;
}

</style>
<script>
$(document).ready(function(){
	var totalFile = <%=totalFile%>;
	var noOFallowdfil = <%=allowedFileNo%>;
	var utype = "<%=utype%>";
console.log("DD"+totalFile);
	if(totalFile>=noOFallowdfil && utype=="PAT")
		$(".upload-report").remove();

	var d = new Date();
	$(function () {
    var startDate = new Date(d.getFullYear()+"-"+Number(d.getMonth()+1)+"-"+Number(d.getDate()+2)),
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

	});
	$(function () {
    var startDate = new Date('1955-10-10'),
        endDate = new Date(d.getFullYear()+"-"+Number(d.getMonth()+1)+"-"+Number(d.getDate()+1));
		$('#dot-datepicker').datetimepicker({
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

	$(".noofforms").change(function(){
		var data = $(this).val();
		var tname = data.split("ty=")[1].split("&")[0];
		var url = "_patientAlldata.jsp?"+$(this).val();
		//console.log("data: - "+data);
		//console.log("url: -"+url);

		switch(tname){
			case "p47" :
				$.get(url,function(data,status){
					$("ul.gen-exam").html(data);
				});
				break;
			case "a14" :
				$.get(url,function(data,status){
					$(".ul-chf-complnt").html(data);
				});
				break;
			case "pre" :
				$.get("dispres1.jsp?"+data,function(data,status){
					$(".prc .prc-menu").html(data);
					//$(".prc .prc-menu").append(data);
				});
				break;
			default:
				console.log("def");
		}
	});
	$(".report-close").hide();
	$(".report-close").click(function(){
			$(this).next("div").html("");
			$(this).hide();
			$(".prc").attr("style","filter:blur(0px)");
	});
	<%if(Integer.parseInt(pq)>0 || !utype.equalsIgnoreCase("PAT")){%>
	<% if(!prc_dt.equals("")) { %>
	$.get("dispres1.jsp?id=<%=patid%>&ty=<%=ty%>&sl=<%=prc_sl%>&dt=<%=prc_dt%>",function(data,status){
		$(".prc .prc-menu").html(data);
		//$(".prc .prc-menu").append(data);
	});
	<% } %>

	$(".view-rpt .pre").parent("td").remove();
	$(".view-rpt .a14").parent("td").remove();
	$(".view-rpt .p47").parent("td").remove();

	$(".new-prc-btn").click(function(){
		$.get("drug.html",function(data,status){
			$(".add-drug").html(data);
		});
	});
	$(".repeat-prescription").click(function(){
		$.post("repeatPrescription.jsp?id=<%=patid%>&ty=<%=ty%>&sl=<%=prc_sl%>&dt=<%=prc_dt%>",function(result,status){
			var output = JSON.parse(result);
			$(".diagnosis").val(output["diagnosis"]);
			$(".advice").val(output["advice"]);
		}).done(function(){
			$.get("showdrug.jsp?code=1",function(data,status){
				$(".add-drug").html(data);
			});				
		});
	
	});

	/* cheif complaint modal+vital sign modal */
	$(".new-comp-btn").click(function(){
		$.get("../forms/a14.jsp",function(data,status){
			$(".add-comp").html(data);
		});
	});
	$('#add_comp').on('hidden.bs.modal', function () {
	  $("#add_comp .modal-body").html("");
	});
	$('#add_vtsign').on('hidden.bs.modal', function () {
	  $("#add_vtsign .modal-body").html("");
	});

	$(".new-vtsign-btn").click(function(){
		$.get("../forms/p47.jsp",function(data,status){
			$(".add-vtsign").html(data);
		});
	});

	/* END cheif complaint modal+vital sign modal */

	$("#newPres").submit(function(e){
		var r = confirm("If you submit this prescription, it cannot be modified. Do you want to proceed?");
		if(r==false)
		{
			return false;
		}
	var url="submitpres.jsp";
	//var formData = new FormData($("#newPres"));
    $.ajax({
           type: "GET",
           url: url,
           data: $("#newPres").serialize(),
           success: function(data)
           {
				alert("done");
				//sessionStorage.setItem("isPrescribed", "yes");
				$('#patPres').modal('toggle');
				$(".modal-backdrop").remove();
				var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
				$(".main-body").html(ajax_load).load("patientAlldata.jsp?id=<%=patid%>");
           },
           error:function(erro)
           {
				alert("Write a new Prescription");
			}
         });
         e.preventDefault();
	});

	//console.log(<%=today%>);

	let patid = "<%=patid%>";
	var patlist = <%=nextPat%>;
	var patqtype = "<%=currpatqtype%>";
	sessionStorage.setItem("patlist",patlist);
	sessionStorage.setItem("currentpat",patid);
	$("#next-pat").click(function(){
		let delSts = false;
		//if(sessionStorage.getItem("isPrescribed")!="yes")
			delSts = confirm("Do you want to followup the patient later?\n If you Cancel, patient will be removed from the queue.");
		//console.log(patid+" Pat List: "+patlist);
			if(delSts==true){
				var patname = "<%=patname%>";
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
						url: "../jspfiles/<%=patUpdateapptURL%>",
						data:{'Dt':Dt, 'Hr':Hr, "Mn":Mn, "Others":Oth, "uid": patid, "uname": patname},
						success: function(data){
							alert( "Data Loaded, Mail will be sent \n\n" + data.trim() );
							dialog.dialog( "close" );
						},
						complete:function(){
							$.ajax({
								type: "post",
								url: "patLTreatmentSts.jsp",
								data:{status:delSts,patid:patid,dateapp:Dt,patqtype:patqtype},
								success: function(data){
									patlist = JSON.parse(data.trim());
									if(patlist.length==0)
										alert("There are no more patient for consultation. Please goto patient queue and set patient appointment.");
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
				console.log("status:"+delSts+",patid:"+patid+",patqtype:"+patqtype);
				$.ajax({
					type: "post",
					url: "patLTreatmentSts.jsp",
					data:{status:delSts,patid:patid,patqtype:patqtype},
					success: function(data){
						console.log(data);
						patlist = JSON.parse(data.trim());
						//alert("Remaining patient: "+patlist.length);
						//console.log("patlist.length:-"+patlist.length);
						if(patlist.length==0)
							alert("There is no patient in the queue. Please goto local patient queue and set patient appointment.");
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



	$(".advc-invs-frm").submit(function(e){
	var url = "adviced_investigation_ajax.jsp";

	$.ajax({
			type:"GET",
			url:url,
			data:$(".advc-invs-frm").serialize(),
			success:function(data)
			{
				$(".advcd-test").html("");
				if(!$(".advc-invs-frm").children().hasClass("advice-disp")){
					$(".advc-invs-frm").append("<div class='advice-disp'>"+data+"</div>");
				}
				if($(".advc-invs-frm").children().hasClass("advice-disp")){
					$(".advice-disp").remove();
					$(".advc-invs-frm").append("<div class='advice-disp'>"+data+"</div>");
				}

			},
			error:function(error){
				alert("Can not update it to the server");
			}
	});
	e.preventDefault();
	});
	<%}%>
	$(".advc-invs select").change(function(){
			$(".invest-desc").show();

			 if($(".radiology").val() !=""){
				 $('.pathology').prop('selectedIndex', 0);
				$(".pathology").attr("disabled",true);
				$(".invst-type").val("Radiology");
			}
			else if($(".pathology").val() !=""){
				$('.radiology').prop('selectedIndex', 0);
				$(".radiology").attr("disabled",true);
				$(".invst-type").val("Pathology");
			}
			else{
				$(".advc-invs select").attr("disabled",false);
				$(".invst-type").val("");
				$(".test_id").val("");
			}
			if($(".radiology").prop("disabled") && $(".pathology").prop("disabled"))
			{
				$(".pathology").attr("disabled",false);
				$(".radiology").attr("disabled",false);
			}

	});
	$(".invest-desc").click(function(){$(".invest-desc").show();});
	$(".advc-invs select").focusout(function(){

			//$(".invest-desc").hide();
	});

	var count = (function(){
		var counter=0;
		return function(c){
			if (c==0){
				counter=0;
				return counter;
			}
			else{
				return counter+=1;
			}
		}
	})();
	var numOfRow=0;
	$(".add-advice-btn").click(function(){
		numOfRow+=1;
		//var radiology = ["X-RAY","MRI","CT SCAN","USG","ECG","EEG"];
		var radiology = ["X-RAY","MRI","CT SCAN"];
		var pathology = ["BILIRUBIN","GLUCOSE","SGPT","SGOT","CREATININE","URIC ACID","TOTAL CHOLESTROL","HDL","LDL","TRIGLYCERIDE","HAEMOGLOBIN","URINE"];
		var counter = 0;
		var noOftest = 0;

		if($("select.radiology").val().length>0 || $("select.pathology").val().length>0){
			if($(".invest-desc textarea").val().length>0 && !($("select.radiology").val().length>0 && $("select.pathology").val().length>0)){
				counter = count(1);
				noOftest = counter;
				//noOftest+=1;
				$(".invest-desc p.vld-msg").remove();
				$(".noOftest").val(noOftest);
				$(".advcd-test").append("<tr class='row"+counter+"'><td>"+noOftest+"</td>"+
				"<td>"+$(".invst-type").val()+"<input type='text' name='type"+counter+"' value='"+$(".invst-type").val()+"' hidden/></td>"+
				"<td>"+eval($(".invst-type").val().toLowerCase())[parseInt($("."+$(".invst-type").val().toLowerCase()+"").val())]+"<input type='text' name='test_name"+counter+"' value='"+$("."+$(".invst-type").val().toLowerCase()+"").val()+"' hidden/></td>"+
				"<td><p>"+$(".invest-desc textarea").val().trim()+"</p><textarea class='description' type='text' name='description"+counter+"' value='"+$(".invest-desc textarea").val().trim()+"' hidden>"+$(".invest-desc textarea").val().trim()+"</textarea></td>"+
				"<td class='mody-test' row='"+counter+"' align='center' ><span class='glyphicon glyphicon-edit invst-edit pull-left'></span><span class='glyphicon glyphicon-remove invst-del pull-right'></span></td></tr>");
			$(".advice-btn").attr("style","display:block !important");
			}
			else{
				if(!$("p").hasClass("vld-msg"))
					$(".invest-desc").append("<p class='vld-msg' style='color:red'>Either Description is empty or test name is ambiguous.</p>");
			}
			//$("select.radiology").val('');
			//$("select.pathology").val('');
			$(".advc-invs select").attr("disabled",false);
			if(numOfRow>0) {
				$(".advice-btn").prop( "disabled",false);
			}
			$('.radiology').prop('selectedIndex', 0);
			$('.pathology').prop('selectedIndex', 0);
		}
		else{
			if(!$("p").hasClass("vld-msg"))
				$(".invest-desc").append("<p class='vld-msg' style='color:red'>Either Description is empty or test name is ambiguous.</p>");
		}

		$(".invest-desc textarea").val('').blur();

		var rowsize = $(".noOftest").val();

		$(".mody-test .invst-del").click(function(){
			$(this).parent().parent("tr").remove();
			//var tab=document.getElementsByClassName("advcd-test");
			//var row=tab.getElementsByTagName("tr");
			//console.log("rowlength:"+$('.advcd-test > * > tr').length);
			//console.log($('.advcd-test tr').length);
			//alert("total "+noOftest+ " i = " +i);
			//noOftest = noOftest-1;
			numOfRow=$('.advcd-test tr').length;
			//numOfRow-=1;
			console.log("TEST NUM-"+numOfRow);
			$(".noOftest").val(noOftest);
			if(numOfRow==0)
			{
				$(".advice-btn").prop( "disabled",true);
			}
			if(numOfRow<0)
			{
				numOfRow=0;
			}

			//alert(noOftest);
			//alert($(this).parent("tr").children().html());
		});

		$(".mody-test .invst-edit").click(function(e){
			e.stopImmediatePropagation();
			//$(this).parent().parent("tr").show();
			$(".row"+$(this).parent("td").attr("row")+" textarea.description").show();
			$(".row"+$(this).parent("td").attr("row")+" textarea.description").css("width","100%");

			if($(this).hasClass("glyphicon-ok")){
				$(".row"+$(this).parent("td").attr("row")+" textarea.description").hide();
				$(this).parent("td").prev("td").children("p").html($(this).parent("td").prev("td").children("textarea").val());
			}
			$(this).toggleClass("glyphicon-ok");
			$(this).toggleClass("glyphicon-edit");

		});
		$(".advice-btn").click(function(){
			counter = count(0);
			//$(".advice-btn").prop( "disabled",true);
		});

	});
	$(".patSearch").remove();


	var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
	$(".uploadedReport").html(ajax_load).load("recordmenu_new.jsp");

	$("body.index").removeClass("modal-open");



});


function showselected()
{
	var val=document.frm.abc.value;
	var tar;

	//alert(tar);
	window.location=tar;

}

</script>

<!-- "Script for report uploading" -->


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

	var modalityList = "<option value='' class='modalityList' selected>SELECT</option>";
	$.getJSON('../includes/investigationList.json', function(jd) {
		for(let i=0;i<jd.length;i++)
			modalityList += "<option value='"+i+"' class='modalityList'>"+jd[i].modality+"</option>";
		$(".modality").html(modalityList);
		$(".modality").on("change", function(){
			let testName = jd[$(this).val()].testname;
			  console.log(testName);
			$( "#testdes" ).autocomplete({
			  source: testName
			});
		});

	});

	var modalityList2 = "<option value='' class='modalityList' selected>SELECT</option>";
	$.getJSON('../includes/pathology_investigationList.json', function(jd) {
		for(let i=0;i<jd.length;i++)
			modalityList2 += "<option value='"+i+"' class='modalityList'>"+jd[i].modality+"</option>";
		$(".pathoModality").html(modalityList2);
		$(".pathoModality").on("change", function(){
			let testName = jd[$(this).val()].testname;
			  console.log(testName);
			$( "#testdes" ).autocomplete({
			  source: testName
			});
		});

	});

$("#reportUpload").submit(function(e){
	e.preventDefault();
	if(testdt($(this).find("#testdate").val(),'<%=dat%>')) return false;
	var data = new FormData(this);
	var uploadedFile = Number(<%=totalFile%>);

	$.ajax({
		type: "get",
		url: "noFileUploaded.jsp",
		success: function(data){
			uploadedFile = Number(data.trim());
		},
		complete:function(){
			let noAllowdFile = Number(<%=allowedFileNo%>);
			console.log(uploadedFile+" TT:TT "+noAllowdFile);
			if(uploadedFile<noAllowdFile){
				$.ajax({
					type:"POST",
					enctype: "multipart/form-data",
				//	url:"../servlet/uploadfilehttp",
					url:"../largefileupload/UploadFile.jsp",
					data:data,
					processData: false,
					contentType: false,
					cache: false,
					timeout: 600000,
					beforeSubmit : filluptextForm(),
					success:function(data){
						console.log(Number(data.trim())+"Uplodstatus"+data.trim());

						var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
						$("#drop_div_html").html("Drop Here/Select File");
						$("#reportUpload")[0].reset();
							$("#reportUpload").append("<div class='uploading-report'>Uploading.....</div>");
						//$.post("../largefileupload/savepatchlfupload.jsp",{ftype:""+$("#Lftype").val()+"",ext:""+fileExtd+"",docName:""+$("#LdocName").val()+"",lname:""+$("#Llname").val()+"",desc:""+$("#Ldes").val()+""},function(data){
							$.post("../servlet/largefileupload",{stream:"<%=patid%>&"+$("#Lftype").val()+"&"+$("#Ldes").val()+"&"+$("#Llname").val()+"&"+$("#LdocName").val()+"&<%=currdate%>&<%=cdate%>&"+fileExtd.substring(1)+""},function(data){
							console.log("<%=patid%>&"+$("#Lftype").val()+"&"+$("#Ldes").val()+"&"+$("#Llname").val()+"&"+$("#LdocName").val()+"&<%=currdate%>&<%=cdate%>&"+fileExtd.substring(1)+"");
							$(".uploadedReport").html(ajax_load).load("recordmenu_new.jsp");
							$(".uploading-report").remove();
							alert("Data is Uploaded !");
							});
						},
					error:function(data){console.log(data);alert("Could not uploaded");}
				});
			}
			else{
				alert("You can upload maximum "+uploadedFile+" files only.");
				$(".upload-report").remove();
			}
		}
	});
});





	$("#smallFile").change(function(){
		$("#drop_div_html").html(document.getElementById("smallFile").files[0].name+"<br><center>"+fileSizeCheck()+"</center>");
	});
	$("select[name=type]").change(function(){
		fileTypeChk(this.value);
		$("#Lftype").val(this.value);
	});

});


function removeFile(){

}
var fileExtd;
function filluptextForm(){
$("#Ldes").val($("input[name=imgdesc]").val());
$("#Llname").val($("input[name=lab_name]").val());
$("#LdocName").val($("input[name=doc_name]").val());
$("#Lftype").val($(".report-type").val());
	var file = document.getElementById('smallFile').files[0].name;
	 fileExtd = file.substring(file.lastIndexOf("."),file.length);
		$("#Lext").val(fileExtd);
}


function fileTypeChk(fTyps){
	var file = document.getElementById('smallFile').files[0].name;
	var fileExt = file.substring(file.lastIndexOf(".")+1,file.length);
	var obj = {
		"BLD":["png","jpeg","jpg","bmp"],
		"CTS":["png","jpeg","jpg","bmp"],
		"DCM":["dcm"],
		"DOC":["doc","docx","pdf","txt"],
		"EEG":["png","jpeg","jpg","bmp"],
		"MRI":["png","jpeg","jpg","bmp"],
		"MOV":["mp4","avi","mov","wmv"],
		"SEG":["png","jpeg","jpg","bmp"],
		"SKP":["png","jpeg","jpg","bmp"],
		"SNG":["png","jpeg","jpg","bmp"],
		"SND":["mp3","wav"],
		"TEG":["txt"],
		"XRA":["png","jpeg","jpg","bmp"],
		"OTH":["png","jpeg","jpg","bmp"]
		}
			if(obj[fTyps].indexOf(fileExt.toLowerCase())>=0){
				return true;
			}
			else{
				var msg = confirm("Supported file is ["+obj[fTyps]+"]" +" Do you want to remove the file ?");
				if(msg==true){
					document.getElementById('smallFile').value="";
					$("#drop_div_html").html("Drop Here/Select File");
					return true;
				}
				else{
					return false;
				}
			}
}

function drop_evt(evt) {
	evt.preventDefault();
	try{
		document.getElementById("smallFile").files = evt.dataTransfer.files;
		document.getElementById("drop_div_html").innerHTML=evt.dataTransfer.files[0].name+"<br><center>"+fileSizeCheck()+"</center>";
	}catch(err){}
}
function dragOver_evt(evt) {
  evt.preventDefault();
}
function setvalues() {
	document.imgld.desc.value = document.imgld.type.value + " File";
}
function datentry(){
	document.imgld.entrydate.value=GetMysqlCurrDateTime();
}

function MM_displayStatusMsg(msgStr) { //v1.0
  status=msgStr;
  document.MM_returnValue = true;
}
//-->

function fileCheck(){
	if(document.getElementById('smallFile').value=="" || document.getElementById('smallFile').value == null){
		alert("Choose a file");
		return false;
	}
	else if($(".report-type").val().length==0){
		alert("SELECT FILE TYPE");
		return false;
	}
	else
		fileTypeChk($(".report-type").val());

	return true;
}
function fileSizeCheck(){

	var sizeinbytes = document.getElementById('smallFile').files[0].size;
	var sizekb=sizeinbytes/1024;
	if(sizekb>=990){
	//alert(sizekb);
		//return (sizekb/1024).toFixed(2)+" MB";
		let mb = Math.floor((sizekb/1024));
		//alert("MB: "+mb);
		if(mb > 9){
			document.getElementById('smallFile').value="";
			return  "Please upload less then 10 mb file";
			}
	}
	else{
		return sizekb.toFixed(2)+" KB";
	}
}


</script>


<!-- "Script for report uploading END" -->





<style>
.input-group-addon{
	min-width:13.2rem;
	}
.drop-div{
    border: 1px dashed #59a7ec;
    height: 80px;
    position: relative;
    text-align: center;
    margin: 4px 0;
	word-wrap: break-word;
    padding: 0 5px;
}
#drop_div_html{color:blue;font-weight:600;}
#smallFile{
	position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
}
.pat-head-title{display:none;}
.uploadedReport a{text-decoration:none;}
</style>

	<body style="font-size:18px;color:#000;">
		<%if(utype.equalsIgnoreCase("DOC")){%>
		<div><button class='btn next' style="color:#fff;font-size: 11px;font-weight: 600;float:right;top:-25px;right:0px;position:absolute;padding:3px;background:#5ba9ec;" id='next-pat'>Next Patient</button></div>
		<%}%>
		<div class="container-fluid patientalldata">

			<div class="row">
				<div class="pat-summ">
					<div class="sec1">
						<div class="col-sm-3 name"><label>NAME : </label><span><%=patname%></span></div>
						<div class="col-sm-3 age"><label>AGE : </label><span><%=PatAgeYMD%></span></div>
						<div class="col-sm-3 sex"><label>SEX : </label><span><%=sex%></span></div>
						<div class="col-sm-3 dept"><label>DEPARTMENT : </label><span> <%=patdis%></span></div>
					</div>
					<div class="sec2">
						<div class="col-sm-6 reff-doc"><label>Under treatment : </label><span id="appDoc"></span><span></span></div>
						<div class="col-sm-3 date"><label>Last Visit DATE : </label><span><%=prc_dt1%></span></div>
						<div class="col-sm-3 date"><label>Communicate : </label>
<% if(!utype.equalsIgnoreCase("PAT")){%>
	<a class="online" href="#" title="Send email to patient" onclick="sendMail('<%=patid%>','<%=patname%>')"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></a>
	<a data-patid="<%=patid%>" class="offline pat-video-link" href="#" title="Invite patient for Video Conference" onclick="invite('<%=patid%>','<%=patname%>')"><span class="glyphicon glyphicon-facetime-video" aria-hidden="true"></span></a>
<%}%>
</div>
<!--<%if(utype.equalsIgnoreCase("DOC")){%>
<div><button class='btn next' id='next-pat'>Next Patient</button></div>
<%}%>-->
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-3 left-div">
					<div class="chf-complnt">
						<fieldset>
							<legend class="title">CHIEF COMPLAINTS
							<%if(!utype.equalsIgnoreCase("PAT")){%>
							<div class="new-comp-btn pull-right" data-toggle="modal" data-target="#add_comp"><span class="glyphicon glyphicon-plus"></span></div>
							<%}%>
							</legend>
							<div class="navigate"><%=listOfFomrs(patid,"a14",chief_com_sl,chief_com_dt,ddinfo)%></div>
							<ul class='list-group ul-chf-complnt'>
								<%=chiefComplaint("a14",patid,chief_com_dt,chief_com_sl,ddinfo,request, crypto)%>
							</ul>
						</fieldset>
					</div>
					<div class="gen-exam" >

						<fieldset>
							<legend class="title">GENERAL EXAMINATIONS
							<%if(!utype.equalsIgnoreCase("PAT")){%>
							<div class="new-vtsign-btn pull-right" data-toggle="modal" data-target="#add_vtsign"><span class="glyphicon glyphicon-plus"></span></div>
							<%}%>
							</legend>
							<div class="navigate"><%=listOfFomrs(patid,"p47",gen_exam_sl,gen_exam_dt,ddinfo)%></div>
							<ul class='list-group gen-exam'>
								<%=genInvestigation("p47",patid,gen_exam_dt,gen_exam_sl,ddinfo)%>
							</ul>
						</fieldset>
					</div>


					<!--<div class="view-rpt">
						<fieldset>
							<legend class="title">VIEW REPORTS</legend>
							<div>
								<%=viewRecords(patid,request)%>
							</div>
						</fieldset>
					</div>-->

					<%if(!utype.equalsIgnoreCase("PAT")){%>
					<div class="upload-report"><!-- "Upload Report Start" -->
						<fieldset>
						<legend class="title">Upload Report</legend>
						<div>
									<div class="row">
									<div class="col-sm-12 tableb">
									<FORM name="imgld" id="reportUpload">
									<INPUT TYPE="hidden" name="pat_id" value="<%=patid%>">
									<div class="drop-div" id="drop_div" ondrop = "drop_evt(event);" ondragover="dragOver_evt(event);" >
									   <span id ="drop_div_html">Drop Here/Select File</span>
									   <input type="file" NAME="userfile" onChange="drop_evt(event)" onMouseOver="MM_displayStatusMsg('click the Browse button to select a file from disk')" onMouseOut="MM_displayStatusMsg(' ')" class="filestyle" id="smallFile" />
									</div>
									<INPUT class="form-control" NAME="imgdesc" Size=53 Maxlength=300 placeholder="Description" onMouseOver="MM_displayStatusMsg('type very short description of the file')" onMouseOut="MM_displayStatusMsg(' ')">
									<INPUT  class="form-control" placeholder="Laboratory Name" TYPE=textbox NAME=lab_name />
									<INPUT class="form-control" placeholder="Doctor Name" TYPE=textbox NAME=doc_name />

									<select class="form-control report-type" name=type title="File type" >
										<option value="">SELECT</option>
										<option value="BLD">Blood Slides </option>
										<option value="CTS">CT Scan </option>
										<option value="DCM">Dicom Files</option>
										<option value="DOC">Documents</option>
										<option value="EEG">EEG </option>
										<option value="MRI">MRI</option>
										<option value="MOV">Movie Files</option>
										<option value="SEG">Scanned ECG </option>
										<option value="SKP">Scanned Skin Patch </option>
										<option value="SNG">Sonograms</option>
										<option value="SND">Sound Files</option>
										<option value="TEG">Text ECG </option>
										<option value="XRA">X-Ray </option>
										<option value="OTH">Others</option>
									</select>

									<input type=hidden name=entrydate>
									<div id="dot-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px;">
										<input data-format="dd/MM/yyyy" id="datepicker-testdate" type="text" value="<%=today%>" class="form-control dot" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
									</div>

									<input class="form-control" id="testdate" placeholder="Date Of Test(DDMMYYYY)" name=testdate size=8 maxlength=8 onblur='return chkdt(this.value)' type="hidden" />
									<center><input class="btn btn-primary" type="submit" value="Upload" onclick="return fileCheck()" style="background-color: '#FFE0C1'; color: '#000000'; font-weight:BOLD; font-style:oblique "></CENTER>
									</FORM>
									<form id="lfuploadform" method="POST" >
										<input type="hidden" id="Lftype" value="BLD" name="ftype" />
										<input type="hidden" id="Ldes" name="desc" />
										<input type="hidden" id="Llname" name="lname" />
										<input type="hidden" id="LdocName" name="docName" />
										<input type="hidden" id="Lext" name="ext" />
									</form>

									</div>		<!-- "col-sm-12" -->
									</div>		<!-- "row" -->


						</div>
						</fieldset>
					</div><!-- "Upload Report END" -->

					<% } %>


				</div>

				<div class="col-sm-9 right-div">
					<form method="get" id="newPres" action="">
						<INPUT type="hidden" name="pat_id" value="<%=patid.trim()%>" />
						<input type="hidden" name="frmnam" value="<%=ty%>" />
					<%if(utype.equals("doc")){%>
					<div class="prc">
						<fieldset>
						<legend class="title">PRESCRIPTION</legend>

							<div class="repeat-prescription" id="repeatPrescription" data-toggle="modal" data-target="#patPres">Repeat Prescription</div>
							<div class="new-prc-btn pull-right" data-toggle="modal" data-target="#patPres">New Prescription</div>

							<div class="prc-menu">

							</div>

						</fieldset>
					</div>
					<%}%>


					<div class="p-report-sheet">
						<div class="report-close close">Close</div>
						<div class="report-sheet">
						</div>
					</div>

					<div class="new-pres">
					</div>








					<!-- Modal -->
					<div id="patPres" class="modal fade" role="dialog">
						<div class="modal-dialog modal-lg">

						<!-- Modal content-->
						<div class="modal-content">
						<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Prescription</h4>
						</div>
						<div class="modal-body add-prescription">

							<div class="text-diagn">
								<fieldset>
								<legend class="title">DIAGNOSIS</legend>
									<div class="diagn-report">
										<textarea name='diagnosis' class='diagnosis col-sm-12' />
									</div>
								</fieldset>
							</div>
							<div class="text-advice">
								<fieldset>
								<legend class="title">ADVICE</legend>
									<div class="advice-field">
										<textarea name='advice' class='advice col-sm-12' />
									</div>
								</fieldset>
							</div>

							<div class="add-drug">
							</div>
					<INPUT TYPE="hidden" NAME="cnam" value ="<%=c_nam%>" />
					<INPUT TYPE="hidden" NAME="drgno" value ="<%=r%>" />
					<INPUT TYPE="hidden" NAME="diet" value="" />
					<INPUT TYPE="hidden" name="activity" value="" />
							<div class="next-vst" style="border: 1px solid; padding: 10px;margin:10px 0;">
								<!--NEXT Appointment Date -->
								<div id="from-datepicker" class="input-append date input-group" style="margin:auto;max-width:320px; display:none;">
									<input data-format="dd/MM/yyyy" type="text" name="apptdate" value="<%=today%>" class="form-control dob" required><span class="add-on glyphicon glyphicon-calendar input-group-addon" style="cursor: pointer;top:0px;padding:6px;left:-4px"></span>
								</div>
									<input type="submit" name="submit" class="btn btn-primary submit-pres" value="Continue" />
							</div>
							</form>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
						</div>

						</div>
					</div>


<%if(utype.equals("doc") || utype.equals("adm")){%>
					<div class="advc-invs">
						<fieldset>
							<legend class="title">ADVICE FOR INVESTIGATIONS</legend>


							<div class="input-group">
								<span class="input-group-addon"><!--<input type="radio" class="in-radiology" >-->Radiology</span>

								<select class="radiology form-control input-sm modality" name="test_name">
								<option value="">SELECT</option>
								</select>

								<!--<select class="radiology form-control input-sm" name="test_name" >
									<option value="">SELECT</option>
									<option value="0">X-RAY</option>
									<option value="1">MRI</option>
									<option value="2">CT SCAN</option>
									<option value="3">USG</option>
									<option value="4">ECG</option>
									<option value="5">EEG</option>
								</select>-->
							</div>
							<div class="input-group">
								<span class="input-group-addon"><!--<input type="radio" class="in-pathology" >-->Pathology</span>
								<select class="pathology form-control input-sm pathoModality" name="test_name" >
									<option value="">SELECT</option>
								</select>
								<!--<select class="pathology form-control input-sm" name="test_name" >
									<option value="">SELECT</option>
									<option value="0">BLOOD</option>
									<option value="1">URINE</option>
								</select>-->
							</div>

							<div class="invest-desc" style="display:none" for="testdes">
								<textarea calss="invst-txt-desc" name="description" placeholder="Test name" id="testdes"></textarea>
							</div>



							<form class="advc-invs-frm" name="invsAdvc" method="GET">
							<input name="pat_id" value="<%=patid%>" hidden>
							<input class='invst-type' name='test_type' value='' hidden>
							<INPUT TYPE="hidden" name="frmnam" value="ai0" />
							<INPUT TYPE="hidden" name="status" value="P" />
							<INPUT TYPE="hidden" name="reffered_by" value="<%=uid%>" />
							<input class='noOftest' type='text' name='noOftest' value='0' hidden/>
							<div class="table-responsive">
							<table class="table table-bordered test-list-table">
								<thead align='center'>
									<tr><td>NO</td><td>TYPE</td><td>NAME</td><td>DESCRIPTION</td><td>ACTION&nbsp;<span class="glyphicon glyphicon-plus pull-right add-advice-btn"></span></td></tr>
								</thead>
								<tbody class="advcd-test">

								</tbody>
							</table>
							</div>
							<input class="btn btn-default advice-btn hide" type="submit" value="Advice" />
							</form>
						</fieldset>
					</div>
					<%}%>


					<div class="allVisits">
						<div class="uploadedReport">

						</div>

					</div>




			</div>







								<!-- Modal cheifComplaint-->

					<div id="add_comp" class="modal fade" role="dialog">
						<div class="modal-dialog modal-lg" >

						<!-- Modal content-->
						<div class="modal-content" style="overflow-x: auto;overflow-y: auto; margin-right:2%;">
							<div class="modal-header" >
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">CHIEF COMPLAINTS</h4>
							</div>
							<div class="modal-body add-comp" style="margin-right:2%;" >
								Body
							</div>
						</div>
						</div>
					</div>

					<!-- Modal Vital sign-->

					<div id="add_vtsign" class="modal fade" role="dialog" >
						<div class="modal-dialog modal-lg" >

						<!-- Modal content-->
						<div class="modal-content" >
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Vital Signs</h4>
							</div>
							<div class="modal-body add-vtsign" style="overflow-x: auto;overflow-y: auto;margin-right:5%;" >
								Body
							</div>
						</div>
						</div>
					</div>




		</div>
<div id="dialog-form" title="Send Email Reminder"></div>
	</body>

</html>
<%}
else{out.println("This patient does not belongs to your center");}
%>
