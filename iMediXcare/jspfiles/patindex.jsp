<%@page contentType="text/html" import="imedix.rcCentreInfo,imedix.Decryptcenter,java.text.SimpleDateFormat, imedix.rcDisplayData,imedix.rcUserInfo,imedix.layout,java.io.*,imedix.cook,imedix.rcPatqueueInfo,imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.dataobj,imedix.rcVideoConference, java.util.*, imedix.projinfo" %>
<html>
<title>iMediX</title>
<script>
		var d = new Date();
		var n = d.getMilliseconds();
</script>

<%
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	String vidServerUrl=(String)(pinfo.vidServerUrl);
   	//String wsPath=request.getServerName()+ ":" + request.getServerPort()+ "/WSiMediX";
 	String wsPath=request.getServerName()+ "" + "/WSiMediX";

	cook cookx = new cook();
	String userid = cookx.getCookieValue("userid", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
    String distype= cookx.getCookieValue("distype", request.getCookies());
    String relationcook = cookx.getCookieValue("relationship",request.getCookies());
    String primarypatidcook = cookx.getCookieValue("primarypatid",request.getCookies());
	//if(relationcook.equals("") || relationcook==null)
	//	cookx.addCookie("relationship","Self",response);

	//out.println(patlist);
    distype="General";

	//String tmpid = request.getParameter("templateid");
	String tmpid = "1";
	//String menuid = request.getParameter("menuid");
    String menuid = "head1";


	// check local pat queue

	String ccode = cookx.getCookieValue("center", request.getCookies ());
	//String curCCode= request.getParameter("curCCode");
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	//out.println(usertype+"<br>1:"+tmpid+"<br>"+menuid);
	String str,str1;
    //out.println(usertype+"<br>5:"+ccode+" : "+userid);
    //out.println(usertype+"<br>6:"+curCCode);
   // out.println(usertype+"<br>7:"+cname);

	str1="<FONT COLOR=#003300 size='5' face='Times'><B>"+cname.toUpperCase()+"</B></FONT>";
	str = "&nbsp;&nbsp;&nbsp;(<b><FONT COLOR=#330099 size='2' face='Verdana'>"+ username.toUpperCase() +"&nbsp;</FONT><FONT COLOR=#330099> Logged on )</FONT>";

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));
	rcDataEntryFrm rdata = new rcDataEntryFrm(request.getRealPath("/"));

	String strat=rdata.findConsultStrategy(ccode);
	int strategy=0;

	if(strat.equalsIgnoreCase("admin"))
	{
			strategy=1;
	}
	else if(strat.equalsIgnoreCase("random"))
	{
			strategy=0;
	}


	// get doctor id and name assigned to patient for Flash Information through WebSocket
	rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
	String patid = cookx.getCookieValue("patid", request.getCookies());
	Object res1 = (Object)ddinfom.getDataTeleRequest(ccode,userid);
	Vector Vtmp1 = (Vector)res1;
	String doc_id = String.valueOf(Vtmp1.get(0));
	//out.println("doc_id: "+doc_id);
	String doc_name = rcui.getName(doc_id);
	//out.println("doc_name: "+doc_name);


	String pq = rcpqi.getTotalLPatAdmin(userid);
	//String tpq = rcpqi.getTotalRPatAdmin(userid);
	String redPage="",id="";
	try{
		redPage = request.getParameter("dest");
		id = request.getParameter("id");
		if(!id.equalsIgnoreCase(userid))
			response.sendRedirect("logout.jsp");
	}catch(Exception ex){
		redPage="";
		id="";
    }

	// get patqueue entry of the patient
	//out.println("patid: "+patid);
	Object patq = rcpqi.getLPatEntry(patid);
	Vector patqV = (Vector)patq;
	//out.println("Patq size: "+patqV.size());
	String appDate = "";
	if(patqV.size() != 0){
		dataobj obj = (dataobj)patqV.get(0);
		appDate = (String)obj.getValue("appdate");
	}

	Object tpatq = rcpqi.getTPatEntry(patid);
	Vector tpatqV = (Vector)tpatq;
	int tpat_size=tpatqV.size();

	String tpatwq1 = (String)rcpqi.isAvaliableInTwaitQ(patid);
	int tpatwq=Integer.parseInt(tpatwq1);


	//out.println("AppDate: "+appDate);
	Date cDate = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curDate = sdf.format(cDate);
	//out.println("Current Date: "+curDate);
	rcDataEntryFrm rcdef=new rcDataEntryFrm(request.getRealPath("/"));
	Object out2=rcdef.findLoginConsent(userid);

	// String loginconsent=out2.toString();
	// String defaultConsent="",typeConsent="",defconid="",conid="";
	// String signedConsentTime="",signedConsentPath="";
	// if(loginconsent.equalsIgnoreCase("N"))
	// {
	// 	Object out1=rcdef.findConsentByCenter(ccode);
	// 	Vector vec1=(Vector)out1;
	// 	for(int i=0;i<vec1.size();i++)
	// 	{
	// 		dataobj ddobj = (dataobj)vec1.get(i);
	// 		if(usertype.equalsIgnoreCase(ddobj.getValue("type")))
	// 		{
	// 			typeConsent=ddobj.getValue("path");
	// 			conid=ddobj.getValue("conid");
	// 		}
	// 		else if((ddobj.getValue("type")).equalsIgnoreCase("default"))
	// 		{
	// 			defaultConsent=ddobj.getValue("path");
	// 			defconid=ddobj.getValue("conid");
	// 		}
	// 	}
	// 	if(typeConsent.equals("") && defaultConsent.equals(""))
	// 	{
	// 		Object out12=rcdef.findConsentByCenter("XXXX");
	// 		Vector vec12=(Vector)out12;
	// 		for(int i=0;i<vec12.size();i++)
	// 		{
	// 			dataobj ddobj1 = (dataobj)vec12.get(i);
	// 			if(usertype.equalsIgnoreCase(ddobj1.getValue("type")))
	// 			{
	// 				typeConsent=ddobj1.getValue("path");
	// 				conid=ddobj1.getValue("conid");
	// 			}
	// 			else if((ddobj1.getValue("type")).equalsIgnoreCase("default"))
	// 			{
	// 				defaultConsent=ddobj1.getValue("path");
	// 				defconid=ddobj1.getValue("conid");
	// 			}
	// 		}
	// 	}
	// 	else if(typeConsent.equals(""))
	// 	{
	// 		typeConsent=defaultConsent;
	// 		conid=defconid;
	// 	}
	// }
	// else
	// {
	// 	Object out1=rcdef.getSignedConsent(userid);
	// 	Vector vec1=(Vector)out1;
	// 	for(int i=0;i<vec1.size();i++)
	// 	{
	// 		dataobj ddobj1 = (dataobj)vec1.get(i);
	// 		signedConsentTime=ddobj1.getValue("time");
	// 		signedConsentPath=ddobj1.getValue("path");
	// 	}
	// }



%>



<%

	 HashMap<String, String[]> familymemberlist = new HashMap<String,String[]>(); 
	String familylist="", primarypatid="";
	int noofmember=0;
	  rcDisplayData display = new rcDisplayData(request.getRealPath("/"));
	    Object fres=display.getFamilyMembers(userid); 
	    Vector tmp = (Vector)fres;
	    noofmember = tmp.size();
	    for(int i=0;i<tmp.size();i++){
	      dataobj temp = (dataobj) tmp.get(i);  
	      String memberpatid = temp.getValue("pat_id").trim();
	      String name = temp.getValue("pat_name").trim();
	      String relationship = temp.getValue("relationship").trim();
	     primarypatid = temp.getValue("primarypatid").trim();
	     	String s[] = new String[2];
	     	s[0] = relationship;
	     	s[1] = name;
			familymemberlist.put(memberpatid,s);	     
	      familylist +=relationship+"\n"; 
	    }	


%>


<%
		layout LayoutMenu = new layout(request.getRealPath("/"));
		String menu=LayoutMenu.getMainMenu(usertype,tmpid,menuid,"new_sk","1"); // authorization point
		// adm,1,head1,top,1
		//out.println(menuid+" "+menu);
		String[] parts = menu.split(":");
		String lpatq_link="",tpatq_link="",tpatwaitq_link="",reff_status_link="",admjobs_link="",edtProfile_link="",logout_link="",pat_reg="";
		int par_len=parts.length;
		//out.println(Arrays.asList(parts));

		edtProfile_link = parts[0];
		logout_link = parts[1];


		String menul=LayoutMenu.getMainMenu(usertype,tmpid,"left","new_sk","1"); // authorization point
	//	out.println("<div>"+menul+"</div>");
%>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/toastr.css">
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/index.css">

	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/vc/vc.css?"+n>

	<script src="<%=request.getContextPath()%>/includes/script1.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/toastr.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js?"+n></script>
	<script src="<%=request.getContextPath()%>/vc/moment.min.js"></script>
	<script src="https://<%=vidServerUrl%>/external_api.js"></script>




</head>
<style>
/* If the screen size is 601px wide or more, set the font-size of <div> to 40px */
	@media screen and (min-width: 601px) {
  .center-name {
    font-size: 40px;
  }
  

}

/* If the screen size is 600px wide or less, set the font-size of <div> to 24px */
@media screen and (max-width: 600px) {
  .center-name {
    font-size: 24px;
  }
  .account{
	top:4%;
  }
  .img2-responsive.logo2{
	  border-radius: 50%;	  
  }
}
.img1-responsive.logo1{
	left:-10px;
	top :20px;
	width: 130px;
	height: 80px;
	padding: 0px 6px;
position: relative;

}
.img2-responsive.logo2{
	top: 4px;
	left: 12px;
	height: 90px;
	padding: 4px 4px;
	z-index: 9;
position: absolute;
border: 1px solid #ddd;
box-shadow: 0px 0px 8px 3px #ccc;

}

.center-name {

	font-weight:500;
	color:#fff;
	text-shadow: 2px 2px 4px #000000;
	font-family: serif;
	text-align: center;
	font-variant: small-caps;
  height: 100px;

  background-color: steelblue;
}

	div.alert{
		margin-bottom: 0 !important;
	}
	.chk-lg{
	    width: 20px;
		height: 16px;
	}
	#wsUri{
	line-break: anywhere;
    display: none !important;
    }
	.left>div.active{border:2px solid #607D8B;background: #eef;color: #333;}
	.pat-home .main-body, .pat-home .main-body>div{padding: 15px !important;}
	.header-block {text-align:center;}
	.header-block .req-const {margin: 20px 0;}
	.default-pat-home{
		border: 1px solid #337ab7;
		margin: 20px;
		padding: 20px;
		color: #ffffff;
		background: #337ab7;
	}
	#modalrelationsgiplist .modal-header, #modalrelationsgiplist .modal-footer{
		background: #1e83d9;
		color: #fff;
		border: 2px solid;	
	}
	#modalrelationsgiplist .modal-title{
		font-weight:600;	
	}
	#modalrelationsgiplist .modal-body{
		background: #f9f2f2;
		font-weight:600;
	}
	#add-family{
	    height: 50px;
	    display: block;
	    margin: 8px;
	    font-size: 18px;		
	}

</style>

<script language="javascript">

	$.ajaxSetup ({
			cache: false
		});
		function clearPanel(fileName) {
			$(".left div.getId").removeClass("active");
			$(".pat-prof-sum").remove();
			var patque=fileName.match("browse.jsp");
			var oldpat=fileName.match("oldpat.jsp");
			if(patque=="browse.jsp" || oldpat=="oldpat.jsp" || patque=="totalsummary.jsp"){
				var loadUrl = "<%=request.getContextPath()%>/jspfiles/" + fileName;
			var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
			$("#main_frame").html(ajax_load).load(loadUrl);
			$("#main_frame").css("min-height","100%");
			$("#main_frame").css("max-height","100%");
				}
			else{
			document.getElementById("main_frame").innerHTML= "<object class='responsive obj' type='text/html' data=<%=request.getContextPath()%>/jspfiles/"+fileName+" style='width:100%; height:100%;'>> </object>";
			}
		}
		function ajaxRedirect(fileName){
			var loadUrl = "./" + fileName;
			var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
			$(".main-body").html(ajax_load).load(loadUrl);
		}

	function viewReport(fileName){
						var loadUrl = "./" + fileName;
			var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
			$(".report-sheet").html(ajax_load).load(loadUrl);
			$(".report-sheet").css("min-height","100%");
			$(".report-sheet").css("max-height","100%");
			$(".report-close").show();
			$(".prc").attr("style","filter:blur(5px)");
	}
	function clearPanelRight(fileName) {
			$(".left div.getId").removeClass("active");
			$(".pat-prof-sum").remove();

			$(".right-div.report-sheet").html("<object class='responsive obj' type='text/html' data=<%=request.getContextPath()%>/jspfiles/"+fileName+" style='width:100%; height:100%;'>> </object>");

	}

</script>

<script>

	function home(fileName){
		var loadUrl = "";
		$(loadUrl).click();
	}
function selectFamilyMember(){
	
	$('#modalrelationsgiplist').modal({
            backdrop: 'static',
            keyboard: false
        });
}




	$(document).ready(function(){
		<% if(usertype.equalsIgnoreCase("pat") && (relationcook==null || relationcook.equals(""))) { %>
			selectFamilyMember();
		<%}%>
		var pq = '<%=pq%>';
		var tpat_size='<%=tpat_size%>';
		var tpatwq='<%=tpatwq%>';

		console.log("pq:"+pq);
		console.log("tpat_size:"+tpat_size);
		console.log("tpatwq:"+tpatwq);

		var redPage = "<%=redPage%>";
		<% if(redPage =="" || redPage == null ){ %>

		<%} else{%>
			pageRedirection("<%=redPage%>"+".jsp?id=<%=id%>","<%=id%>");
		<%}%>
		/*
		$("body").click(function(){$("input.id").focus();});
		*/
		var left_menu = eval(<%=menul%>);
		//console.log(left_menu);
		var len = Object.keys(left_menu).length;
		for(var i=0;i<len;i++){
		$(".index .left").append("<div class='"+left_menu[i][1].substring(0,3).toLowerCase()+'_'+left_menu[i][1].substring(left_menu[i][1].indexOf(' ')+1,left_menu[i][1].indexOf(' ')+4).toLowerCase()+" getId' trackId='"+i+"'>"+left_menu[i][1]+"<span class='glyphicon glyphicon-circle-arrow-right pull-right sn'></span></div>");
		}
		//console.log(left_menu);


		$(".collapse.in").each(function(){
			$(this).siblings(".panel-heading").find(".glyphicon").addClass("glyphicon-minus").removeClass("glyphicon-plus");
		});

		// Toggle plus minus icon on show hide of collapse element
		$(".collapse").on('show.bs.collapse', function(){
			$(this).parent().find(".glyphicon").removeClass("glyphicon-plus").addClass("glyphicon-minus");
		}).on('hide.bs.collapse', function(){
			$(this).parent().find(".glyphicon").removeClass("glyphicon-minus").addClass("glyphicon-plus");
		});

	home('<%=usertype%>');
	if($(window).width()<768){
		$(".rect").click(function(){
			$("#main_frame").attr("tabindex","1");
			$("#main_frame").focus();
		});
	}



	$("#add-family").click(function(){
		$(".patientalldata").load("../forms/addfamilymumber.jsp");
	});

	});

	function pageRedirection(page,id){
		var head_url = "patSortinfo.jsp?id="+id+"&usr=<%=usertype%>&nam=*&patdis=<%=distype%>&currpatqtype=local";
			$.get(head_url,function(data,status){
				$(".pat-head-title").html(data );
				if(status=="success"){
					$(".main-body").html("<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>");
					$.get(page,function(data,status){
						$(".main-body").html(data);
					});
				}
			});
	}



//https://imedix.iitkgp.ac.in/iMediX/jspfiles/updatephysician.jsp?regcode=docVWXYZ0190002&ch1=VWXYZ0190502200000

</script>



<body  class="index">



<!-- Modal -->
<div id="modalrelationsgiplist" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
       <!-- <button type="button" class="close" data-dismiss="modal">&times;</button>-->
        <h4 class="modal-title">Relationship With Primary Account Holder</h4>
      </div>
      <div class="modal-body">
        <div class="list-group">
        	<%
        		out.println("<a class='list-group-item' href='setFamilyMemberVisit.jsp?patid="+userid+"&primarypatid="+userid+"&name="+username+"&relation=Self'>"+username+"<span class='badge'>Self</span></a>");
        		for (Map.Entry<String, String[]> e : familymemberlist.entrySet())
        			out.println("<a class='list-group-item' href='setFamilyMemberVisit.jsp?patid="+e.getKey()+"&primarypatid="+primarypatid+"&name="+e.getValue()[1]+"&relation="+e.getValue()[0]+"'>"+e.getValue()[1]+"<span class='badge'>"+e.getValue()[0]+"</span></a>");
        		
        	%>
    	</div>
      </div>
    </div>

  </div>
</div>




    <div class="container-fluid">
		<div style="display: none;" id="wsUri" name="wsUri"><%=wsPath%></div>


        <div class="row header">
			<div class="col-md-2">
			</div>          	
			<div class="col-md-8">
					<% if(usertype.equalsIgnoreCase("pat") && (relationcook.equalsIgnoreCase("self")||relationcook.equals(""))){ %>
						<div class='btn btn-primary' id='add-family'>
							Add Family Member <span class="badge" title="<%=familylist%>"><%=noofmember%></span>
						</div>
					<%}%>				
			</div>    
			<div class="col-md-1">
			</div> 			  	
			<div class="col-md-1 account" >
				<div class="profile" onclick='clearPanel("<%=edtProfile_link.split(",")[0]%>")'><span class="glyphicon glyphicon-user glph-lg" title='<%=edtProfile_link.split(",")[1]%>'></span></div>
				<div class="logout" onclick='clearPanel("<%=logout_link.split(",")[0]%>")'><span class="glyphicon glyphicon-off glph-lg" title='<%=logout_link.split(",")[1]%>'></span></div>
			</div>
		</div>

			<div class="row body">
				<div class="col-sm-2 username-title">Welcome, <%=username%>

				</div>


				<div class="col-sm-10" id="pat-info" ></div>

				<div class="col-sm-12 pat-home">
					<div class="row pat-head-title">

					</div>

					<div class="row">


						<div class="col-sm-2 vc-panel" id="vc-panel">

							<div class='row' style=" margin: auto !important; padding: 5px; border: 2px solid #146d30; margin-bottom: 10px; padding-bottom: 10px;  margin-top: 10px; padding-top: 10px;">
							<%
								String verifEmail="X", verifMobile="X", emIndicate, phIndicate;
								Object resu=rcui.getValues("*"," uid = '"+userid+"'" );
								Vector vtmp = (Vector)resu;
								int vsz = vtmp.size();
								if(vtmp.size()>0) {
								dataobj datatemp = (dataobj) vtmp.get(0);
								verifEmail=datatemp.getValue("verifemail");
								verifMobile = datatemp.getValue("verifphone");
								}
								if ( verifMobile.equalsIgnoreCase("Y") ) phIndicate = "<span class='label label-success'><span class='glyphicon glyphicon-phone-alt'></span>&nbsp; <span class='glyphicon glyphicon-ok'></span></span>";
								else  phIndicate = "<span class='label label-warning'><span class='glyphicon glyphicon-phone-alt'></span>&nbsp;<span class='glyphicon glyphicon-remove'></span></span>";
								if ( verifEmail.equalsIgnoreCase("Y") ) emIndicate = "<span class='label label-success'><span class='glyphicon glyphicon-envelope'></span> &nbsp;<span class='glyphicon glyphicon-ok'></span></span>";
								else  emIndicate = "<span class='label label-warning'><span class='glyphicon glyphicon-envelope'></span>&nbsp;<span class='glyphicon glyphicon-remove'></span></span>";
								out.println ( "<div class='col-sm-6'><h3 style='font-weight:normal; font-size: 20px; font-weight:normal;margin: 2px;padding: 3px;float: left;'>" + emIndicate + "</h3></div>");
								out.println ( "<div class='col-sm-6'><h3 style='font-weight:normal; font-size: 20px; font-weight:normal;margin: 2px;padding: 3px;float: right;'>" + phIndicate + "</h3></div>");


							%>
							<br>
							</div>

							<div class="panel panel-primary" style="margin-top:30px;">
								<div class="panel-heading">Chat Module</div>
								<div class="panel-body">
									<div class ="left-chat">
										<span id=wsUri name=wsUri ><%=wsPath %></span>
										<div id="output"  style="height: 150px; overflow-y: auto"></div>
										<div class="input-group" style="margin-top:5px;">
											<input id="mesg-txt" class="form-control" type="text" name="mesg-txt" placeholder="Type Message"></input>
											<div class="input-group-btn">
												<a class="btn btn-default" id="send-msgbtn" name="send-msgbtn">Send</a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="panel panel-primary">
								<div class="panel-heading">Video Conference</div>
								<div class="panel-body">
									<p>
										<button class="btn btn-sm btn-primary btnShow" >Show</button>
										<button class="btn btn-sm btn-danger btnStop" disabled="disabled" onClick="stop()">Stop</button>
									</p>
								</div>



							</div>
						</div>
						<div class="col-sm-10 main-body" id="main_frame">

						</div>

					</div>

				</div>
			</div>


		</div>
		<div style="display:none" id="dialog" title="iMediX-Video Conferencing">
			<div class="row-fluid">
				<div class="col-md-12">
					<div id="inner-container2">
						<div id="meet" style="background-color: grey"></div>
					</div>
					<div class="" style='text-align:center; margin: auto'>

					</div>
				</div>
			</div>
		</div>

		<div id="add_comp_req" class="modal fade" role="dialog" >
			<div class="modal-dialog modal-lg" >

			<!-- Modal content-->
			<div class="modal-content" style="overflow-x: auto;overflow-y: auto;height:90%;" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">CHIEF COMPLAINTS</h4>
				</div>
				<div class="modal-body add-comp-req" >
					Body
				</div>
			</div>
			</div>
		</div>
		<div id="modal-status" style="display:none;">not submit</div>
	</body>


	<script src="<%=request.getContextPath()%>/vc/vc.js?ver=1.3"></script>
	<script>
	  $(document).on("click", ".btnShow",function() {
        	ShowVC();
	})

	</script>
	<style>
	.ui-accordion .ui-accordion-content {
    	padding: 0.5em 0.5em;
	}
	.left-chat {
		// background-color: #EEEEEE;
	}
	.left-doclist {
	}

	ul.doctors{
		list-style: none;
		margin: 0;
		padding: 0;
	}
	ul.doctors li a{
		display: block;
		padding: 3px 5px;
		width: 98%;
		color: #727475;
		text-decoration: none;
	}
	ul.doctors li a.active{
		background-color: #5b7ba8;
		color: white;
	}
	</style>
	<script type="text/javascript">


		$(document).on("click", ".btnShow",function() {
        	ShowVC();
		})


	$( function() {
		$( "#accordion" ).accordion({active: 0, collapsible: true, heightStyle: "content"});
		//$.fn.bootstrapBtn = $.fn.button.noConflict();
		//var bootstrapButton = $.fn.button.noConflict(); // return $.fn.button to previously assigned value
		//$.fn.bootstrapBtn = bootstrapButton;            // give $().bootstrapBtn the Bootstrap functionality
		$(document).on('keypress', '#mesg-txt',function(e){
			if(e.which == 13){
				$('#send-msgbtn').click();
			}

		});
		var pq = '<%=pq%>';

		//console.log('pq: '+pq);
		//console.log('tpq: '+ tpq);
		// if(pq !== '0'){
		// 	$('button.req-const-btn').prop('disabled',true);
		// 	updatePatientInfo(true);
		// }else{
		// 	$('button.req-const-btn').prop('disabled',false);
		// 	updatePatientInfo(true);
		// }

		loadPatientQueueInformation('<%=userid%>');


	});

	// patient queue information and doctor status

	usertype = '<%=usertype%>';

	userid = '<%=userid %>';
	username = '<%=username %>';

	lpat_appdate = '<%=appDate%>';
	cur_date = '<%=curDate%>'
	//console.log("Appointment Date: "+lpat_appdate);
	//console.log("Current Date: "+cur_date);
	//console.log("calling updatePatientInfo");

	setInterval(function(){
		beacon(userid);
	}, 5000);


	</script>

</html>
