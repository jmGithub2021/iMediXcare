<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook,imedix.rcGenOperations,imedix.myDate,imedix.medinfo" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%	String targA="", targB="", Qr="";
	Qr =  request.getQueryString();
	String patdis=request.getParameter("patdis");
	String ID  = request.getParameter("id");
	String cdat = myDate.getCurrentDate("ymd",true);
	String dob="",agem="",patname="",PatAgeYMD="";
	rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));
	medinfo minfo = new medinfo(request.getRealPath("/"));
	try{
		dob=rcGen.getDobOfPatient(ID);
		agem=rcGen.getAgeInMonthOfPatient(ID,cdat);
		patname=rcGen.getPatientName(ID);
		String d = patname.substring(0,patname.indexOf(" "));
		String dd = minfo.getAppellationValues().getValue(d);
		patname = dd+" "+patname.substring(patname.indexOf(" "),patname.length());
		PatAgeYMD=rcGen.getPatientAgeYMD(ID,cdat);
	}catch(Exception e){
		//out.println(e);
	}
	cook cookx = new cook();
	
	

	cookx.addCookie("patid",ID,response);
	cookx.addCookie("patname",patname,response);
	cookx.addCookie("PatAgeYMD",PatAgeYMD,response);
	
	cookx.addCookie("patdob",dob,response);
	cookx.addCookie("patagem",agem,response);
	cookx.addCookie("patdis",patdis,response);

	targA = "itemlist.jsp?" + Qr;
		//targA = "itemdataset.jsp?" + Qr;
	targB = "summary.jsp?"+Qr;

layout LayoutMenu = new layout(request.getRealPath("/"));
int menuid=3;
/*
if(patdis.equalsIgnoreCase("Pediatric HIV")) menuid=LayoutMenu.checkMainMenuForBrowse(2);
else if(patdis.equalsIgnoreCase("Oncological")) menuid=LayoutMenu.checkMainMenuForBrowse(4);
else if(patdis.equalsIgnoreCase("Tuberculosis")) menuid=LayoutMenu.checkMainMenuForBrowse(5);
else menuid=3;
out.println(LayoutMenu.getMainMenuForBrowse(menuid));
*/

if(patdis.equalsIgnoreCase("Pediatric HIV")) menuid=LayoutMenu.checkMainMenuForBrowse(2);
else if(patdis.equalsIgnoreCase("Oncological")) menuid=LayoutMenu.checkMainMenuForBrowse(4);
else if(patdis.equalsIgnoreCase("Tuberculosis")) menuid=LayoutMenu.checkMainMenuForBrowse(5);
else menuid=3;
//response.sendRedirect("/iMediX/jspfiles/header2menu.jsp?templateid="+menuid+"&menuid=head2");
response.sendRedirect("index1.jsp?templateid=1&menuid=head1&dest=patientAlldata&id="+ID+"");



%>

