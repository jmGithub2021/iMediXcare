<%@page contentType="text/html" import="imedix.layout,java.io.*,imedix.cook,imedix.projinfo,imedix.rcDisplayData,imedix.rcItemlistInfo,imedix.dataobj,imedix.myDate, java.util.*,imedix.Crypto,javax.crypto.*, java.net.URLEncoder, java.nio.charset.StandardCharsets" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
    SecretKey key = getSecretKey(session);
    Crypto crypto = new Crypto(key);
%>

<%!
public String genInvestigation(String tnam,String pat_id,String dt,String slno, rcDisplayData ddinfo) throws Exception{
	String result="";
	try{
	Object res=ddinfo.DisplayFrm(tnam,pat_id,dt,slno);
			Vector tmp = (Vector)res;
			//out.println("ffffff "+tmp.size());
			for(int i=0;i<tmp.size();i++){
		dataobj temp = (dataobj) tmp.get(i);
		String temperature = temp.getValue("temperature");
		String resprate = temp.getValue("resprate");
		String pulse = temp.getValue("pulse");
		String bldpres = temp.getValue("bldpres");
		String pulox = temp.getValue("pulox");
		result = "<li class='list-group-item'><label>Temperature : </label><span class='pull-right'>"+temperature+" &#8457;</span></li>"+
				"<li class='list-group-item'><label>Respiratory Rate : </label><span class='pull-right'>"+resprate+"/minute</span></li>"+
				"<li class='list-group-item'><label>Pulse : </label><span class='pull-right'>"+pulse+"/minute</span></li>"+
				"<li class='list-group-item'><label>Blood Pressure : </label><span class='pull-right'>"+bldpres+"</span></li>"+
				"<li class='list-group-item'><label>Pulse Oximeter : </label><span class='pull-right'>"+pulox+"%</span></li>";
	}
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
	return result;

}

public String chiefComplaint(String tnam,String pat_id,String dt,String slno, rcDisplayData ddinfo,HttpServletRequest request, Crypto crypto) throws Exception{
	String result="";
	try{
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	String filePath = pinfo.gbldata;
	Object res=ddinfo.DisplayFrm(tnam,pat_id,dt,slno);
			Vector tmp = (Vector)res;
			//out.println("ffffff "+tmp.size());
			for(int i=0;i<tmp.size();i++){
		dataobj temp = (dataobj) tmp.get(i);
		String comp1 = temp.getValue("comp1");
		String dur1 = temp.getValue("dur1");
		String hdmy1 = temp.getValue("hdmy1");
		String comp2 = temp.getValue("comp2");
		String dur2 = temp.getValue("dur2");
		String hdmy2 = temp.getValue("hdmy2");
		String comp3 = temp.getValue("comp3");
		String dur3 = temp.getValue("dur3");
		String hdmy3 = temp.getValue("hdmy3");
		String rh = temp.getValue("rh");
		String fileLink = temp.getValue("report_link");
		if(!comp1.equals(""))
			result += "<li class='list-group-item'><label>"+comp1 +"</label><span class='pull-right'>"+dur1 +" "+hdmy1+"</span></li>";
		if(!comp2.equals(""))
			result += "<li class='list-group-item'><label>"+comp2 +"</label><span class='pull-right'>"+dur2 +" "+hdmy2+"</span></li>";
		if(!comp3.equals(""))
			result += "<li class='list-group-item'><label>"+comp3 +"</label><span class='pull-right'>"+dur3 +" "+hdmy3+"</span></li>";
		if(!rh.equals(""))
			result += "<li class='list-group-item'><label>Records </label><span class='pull-right'>"+rh+"</span></li>";
		if(!fileLink.equals(""))
			result += "<li class='list-group-item'><label>File : </label><a href='getFile.jsp?file="+URLEncoder.encode(crypto.encrypt(filePath+"/"+pat_id+"/"+fileLink), StandardCharsets.UTF_8)+"' target='_blank' ><span class='glyphicon glyphicon-file'></span></a></li>";
	}
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
	return result;
}

public String viewRecords(String id,ServletRequest request) throws Exception{
	String dat;
	rcItemlistInfo rcIlist = new rcItemlistInfo(request.getRealPath("/"));
/*

	dat = myDate.getCurrentDate("dmy",false);
	String tempstr=rcIlist.getVisitWiseInfo(id);


	String tempstr1=tempstr.replaceAll("Target=content2","onclick=viewReport(encodeURI(this.getAttribute('value')))");
	tempstr1=tempstr1.replaceAll("target=content2","onclick=viewReport(encodeURI(this.getAttribute('value')))");
	//tempstr1=tempstr1.replaceAll("target=content2","onclick=clearPanelRight(encodeURI(this.getAttribute('value')))");
	String tempstr2 = tempstr1.replaceAll("HREF","href='#' value");
	tempstr2 = tempstr2.replaceAll("Href","href='#' value");
	return tempstr2;
*/
	return "";
}


%>
<%
String tname="",pat_id="",dt="",slno="";
try{
	pat_id = request.getParameter("id");
	tname = request.getParameter("ty");
	dt = request.getParameter("dt");
	slno = request.getParameter("sl");
}catch(Exception ex){}
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	try{
	if(tname.equals("p47"))
		out.println(genInvestigation(tname,pat_id,dt,slno,ddinfo));
	else if(tname.equals("a14"))
		out.println(chiefComplaint(tname,pat_id,dt,slno,ddinfo,request,crypto));
	else
		out.println("");

	}catch(Exception ex){}
%>
