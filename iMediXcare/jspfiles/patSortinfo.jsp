<%@page contentType="text/html" import="imedix.layout,java.io.*,java.util.*,imedix.dataobj,imedix.projinfo,imedix.cook,imedix.rcGenOperations,imedix.rcUserInfo,imedix.myDate" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%	String targA="", targB="", Qr="",center="",uid="",rg_no="";
	boolean isTele=false;
	Qr =  request.getQueryString();
	String ID  = request.getParameter("id");
	String currpatqtype  = "local";
	String cdat = myDate.getCurrentDate("ymd",true);
	String dob="",agem="",patname="",PatAgeYMD="",patdis="",sex="";
	rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	rcUserInfo uif = new rcUserInfo(request.getRealPath("/"));


	String globalCenter = pinfo.gblcentercode;
	cook cookx = new cook();
	center = cookx.getCookieValue("center", request.getCookies());
	uid = cookx.getCookieValue("userid", request.getCookies());
	rg_no = uif.getreg_no(uid);
	//out.println(center);
	int center_length = center.length();

	if(rcGen.isTelePat(ID,rg_no)){
		currpatqtype = "tele";
		isTele = true;
	}

	//if(center.equals(ID.substring(0,center_length)) || center.equals(globalCenter) || isTele){
		try{
			//String pat_name_query="trim(CONCAT(IFNULL(pre,'') , ' ' , IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) as pat_name";
			String pat_name_query="trim(CONCAT(IFNULL(pat_name,'') , ' ' , IFNULL(m_name,''), ' ' , IFNULL(l_name,''))) as pat_name";
			Object res=rcGen.findRecords("med",pat_name_query+",class,sex","pat_id='"+ID+"'");
			Vector tmp = (Vector)res;
			dataobj temp = (dataobj) tmp.get(0);

			dob=rcGen.getDobOfPatient(ID);
			agem=rcGen.getAgeInMonthOfPatient(ID,cdat);
			patname=temp.getValue("pat_name");
			patdis=temp.getValue("class");
			sex=temp.getValue("sex");

			PatAgeYMD=rcGen.getPatientAgeYMD(ID,cdat);
		}catch(Exception e){
			//out.println(e);
		}




	cookx.addCookie("patid",ID,response);
	cookx.addCookie("patname",patname,response);
	cookx.addCookie("PatAgeYMD",PatAgeYMD,response);
	cookx.addCookie("sex",sex,response);

	cookx.addCookie("patdob",dob,response);
	cookx.addCookie("patagem",agem,response);
	cookx.addCookie("patdis",patdis,response);
	cookx.addCookie("currpatqtype",currpatqtype,response);

%>
<div class="col-sm-12 pat-prof-sum">
	<div class="col-sm-4 pat-name">Name : <span><%=patname%></span></div>
	<div class="col-sm-4 pat-age">Age : <span><%=PatAgeYMD%></span></div>
	<div class="col-sm-4 pat-cat">Catagory : <span><%=patdis%></span></div>
	<div class="row continue pull-right" style="display:none">
		<div class="col-sm-12"><button class="btn btn-primary">Continue</button></div>
	</div>
</div>
<%
	/*}
	else{
		cookx.addCookie("patid","",response);
		cookx.addCookie("patname","",response);
		cookx.addCookie("PatAgeYMD","",response);
		cookx.addCookie("sex","",response);

		cookx.addCookie("patdob","",response);
		cookx.addCookie("patagem","",response);
		cookx.addCookie("patdis","",response);
		cookx.addCookie("currpatqtype","",response);
		out.println("This patient does not belongs to your center");
	}*/
%>
