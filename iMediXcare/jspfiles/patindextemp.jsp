<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook,imedix.rcPatqueueInfo,imedix.rcDataEntryFrm,imedix.rcUserInfo,imedix.dataobj,imedix.rcVideoConference, java.util.*" %>
<html>
<title>iMediX</title>
<script>
		var d = new Date();
		var n = d.getMilliseconds();
</script>

<%!
	private boolean requestConsultation(String uid, String center, String path){
		boolean result = false;
		try{
			rcDataEntryFrm rdata = new rcDataEntryFrm(path);
			if(!rdata.isRequested(uid) && !rdata.isAcceptedConsult(uid));
				//result = rdata.requestConsultant(uid,center);
		}catch(Exception ex){}
		return result;
	}
%>

<% 	

   	//String wsPath=request.getServerName()+ ":" + request.getServerPort()+ "/WSiMediX";
 	String wsPath=request.getServerName()+ "" + "/WSiMediX";

	cook cookx = new cook();
	String userid = cookx.getCookieValue("userid", request.getCookies());
	String username = cookx.getCookieValue("username", request.getCookies());
	String usertype = cookx.getCookieValue("usertype", request.getCookies());
    String distype= cookx.getCookieValue("distype", request.getCookies());
	
    distype="General";
   
	//String tmpid = request.getParameter("templateid");
	String tmpid = "1";
	//String menuid = request.getParameter("menuid");
    String menuid = "head1";


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
	
	String redPage="",id="";
	try{
		
		//if(rdata.isAcceptedConsult(userid))
			redPage = request.getParameter("dest");
		id = request.getParameter("id");
		if(!id.equalsIgnoreCase(userid))
			response.sendRedirect("logout.jsp");
	}catch(Exception ex){
		redPage="";
		id="";
    }
    


%>

<%
	String requestConsultant = "";
	requestConsultant = request.getParameter("event");
	requestConsultant = (requestConsultant==null)?"":requestConsultant;
	if(requestConsultant.equals("consultRequest") && "POST".equalsIgnoreCase(request.getMethod())){
		String dis = request.getParameter("discipline");
		requestConsultation(userid, ccode, request.getRealPath("/"));
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
		int utypeInt = utypeI(usertype);
		switch(utypeInt){
			case 0 :
				lpatq_link = parts[0];
				reff_status_link = parts[1];
				tpatwaitq_link = parts[2];		
				tpatq_link = parts[3];
				edtProfile_link = parts[4];
				logout_link = parts[5];
				break;
			case 1 :
				pat_reg = parts[1];
				lpatq_link = parts[3];
				tpatq_link = parts[5];
				admjobs_link = parts[7];
				reff_status_link = parts[4];
				edtProfile_link = parts[8];
				logout_link = parts[9];		
				break;
			case 2 : 	
				lpatq_link = parts[2];				
				edtProfile_link = parts[3];
				logout_link = parts[4];				
				break;
			case 3 :
				edtProfile_link = parts[3];
				logout_link = parts[4];				
				break;
			case 4 :
				edtProfile_link = parts[0];
				logout_link = parts[1];				
				break;
			default :
				lpatq_link = "";
				tpatq_link = "";
				tpatwaitq_link = "";
				reff_status_link = "";
		}
//out.println("<script>console.log("+logout_link+")</script>");
//String part4=part3.insertAll("data-target=\"#navbarCollapse\" data-toggle=\"collapse\"");



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


	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/toastr.js"></script>	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js?"+n></script>
	<script src="https://meet.jit.si/external_api.js"></script>




</head>
<style>
	.chk-lg{
	    width: 20px;
		height: 16px;
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
</style>

<script language="javascript">
	var docid = '<%= userid %>';
    var docname = '<%= username %>';
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
		var obj = {"adm":"dashb.jsp","doc":".vis_pat","user":".pat_reg ","opr":"getStudyUID.jsp"};
		var loadUrl = "";
		/*if(fileName == "adm")
			loadUrl = "<%=request.getContextPath()%>/jspfiles/" + obj.adm;
		else if(fileName == "doc")
			loadUrl = obj.doc;
		else 
			loadUrl = obj.user;*/
			
			for(let i=0;i<Object.keys(obj).length;i++){
				if(Object.keys(obj)[i]==fileName)
					loadUrl = Object.values(obj)[i];
			}
			
		if(fileName == "adm"){	
			var ajax_load = "<img class='loading' src='<%=request.getContextPath()%>/images/loading.gif' alt='loading...'>";
			$("#main_frame").html(ajax_load).load(loadUrl);
			$("#main_frame").css("min-height","100%");
			$("#main_frame").css("max-height","100%");
		}
		if(fileName=="opr")
			clearPanel(loadUrl);
		else{
			$(loadUrl).click();
			}
	//document.getElementById("main_frame").innerHTML= "<object class='responsive obj' type='text/html' data='welcome.jsp' style='width:100%; height:100%;'>> </object>";		
	}

	$(document).ready(function(){
		if(<%=rdata.isRequested(userid)%>==true || <%=rdata.isAcceptedConsult(userid)%>==true)
		$(".req-const-btn").prop( "disabled", true );

	/*	var i=0;
		while(i<1000){		
			var counter=0;
			setTimeout(function(){
			$(".cnt span").html(counter++);
			},500);
			i++;
		}*/
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



$(".req-const-btn").click(function(){
	let conf = confirm("Do you want to request for a doctor consultation?");
	if(conf==true){
		$.ajax({
			type: 'POST',
			//url: "updatephysician.jsp?regcode="+phys+"&ch1=<%=userid%>",
			data:{event:"consultRequest",discipline:""+$("#discipline").val()+""},
			dataType: "text",
			success: function(data) { 
					$(".req-const-btn").prop("disabled",true);
					alert("Request has been sent"); 
					}
		});
	}
});	
    $(".covid19-btn").click(function(){
		$(".main-body").load("covidIndex.jsp");
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


<%!
	public int utypeI(String utype){
		int utypei = -1;
			if(utype.equalsIgnoreCase("doc"))
				utypei = 0;
			else if(utype.equalsIgnoreCase("adm"))
				utypei = 1;
			else if(utype.equalsIgnoreCase("usr"))
				utypei = 2;
			else if(utype.equalsIgnoreCase("opr"))
				utypei = 3;
			else if(utype.equalsIgnoreCase("pat"))
				utypei = 4;
			else
				utypei = -1;
	return utypei;
	}
%>


<body  class="index">
    <div class="container-fluid">
		<div style="display: none;" id="wsUri" name="wsUri"><%=wsPath%></div>
 
        <div class="row header">
            
            <div class="col-sm-3">
                <a href = "javascript:window.location.reload(true)" onclick ><img class="img-responsive logo" src="<%=request.getContextPath()%>/images/imlogo.jpg" /></a>
            </div>
            
            <div class="col-sm-8 header-block">

				<div class="input-group req-const">
<SELECT class="form-control" id="discipline" name='othdis' >
				<%
					try{
					FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
					int i;
					String strn1="";
					do{
						i = fin.read();
						if((char) i != '\n')
							strn1 = strn1 + (char) i;
						else {
						        strn1 = strn1.replaceAll("\n","");
							strn1 = strn1.replaceAll("\r","");
							out.println("<option value='" + strn1 + "'>" + strn1 + "</Option>");
							strn1="";
						}
					}while(i != -1);
					fin.close();
				}catch(Exception e){
					System.out.println(e.toString());
				}
				%>
				</SELECT>
				<div class="input-group-btn">
				<button type="button" class="btn btn-info req-const-btn">Request for Consultation</button>	
				</div>
				</div>	
				<div class="covid-ques">
					<button type="button" class="btn btn-primary covid19-btn">COVID19 Screening Questionnaire</button>
				</div>
			            </div>
                                      
				<div class="col-sm-1 account">
					<div class="profile" onclick='clearPanel("<%=edtProfile_link.split(",")[0]%>")'><span class="glyphicon glyphicon-user glph-lg" title='<%=edtProfile_link.split(",")[1]%>'></span></div>
					<div class="logout" onclick='clearPanel("<%=logout_link.split(",")[0]%>")'><span class="glyphicon glyphicon-off glph-lg" title='<%=logout_link.split(",")[1]%>'></span></div>
				</div>	
                                      
			</div>
                                      
			<div class="row body">
			<div class="col-sm-12 username-title">Welcome, <%=username%></div>
			
				<div class="col-sm-12 pat-home">
					<div class="row pat-head-title">
						
					</div>

					<div class="row">
						<div class="col-sm-2 vc-panel" id="vc-panel">
							<div class="panel panel-primary" style="margin-top:30px;">
								<div class="panel-heading">Chat Module</div>
								<div class="panel-body">
									<div class ="left-chat">
										<span id=wsUri name=wsUri><%=wsPath %></span>
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
							<h2 class="default-pat-home"><ul><li>You are allowed to make request for consultation.</li><li>You will be allowed to insert/update your medical records</br> once your request is granted.</li></ul></h2>
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
	<script>
		
	
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


	});	
	setInterval(function(){
		beacon(docid);
	}, 5000);


	</script>

</html>
