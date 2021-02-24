<%@page contentType="text/html" import= "java.io.*,imedix.projinfo,imedix.rcUserInfo,imedix.medinfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*"%>

<%@ include file="..//includes/chkcook.jsp" %>
<%
		cook cookx = new cook();
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));

		rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

		String patName = "", patAge = "", patSex = "",localCenter = "", patId="";
		medinfo minfo = new medinfo(request.getRealPath("/"));
		patName = cookx.getCookieValue("patname",request.getCookies());
		patAge = cookx.getCookieValue("PatAgeYMD",request.getCookies());
		patSex = cookx.getCookieValue("sex",request.getCookies());
		patId = cookx.getCookieValue("patid",request.getCookies());
		localCenter = cookx.getCookieValue("currpatqcenter",request.getCookies());
		String uid = cookx.getCookieValue("userid", request.getCookies ());
		String c_nam = cookx.getCookieValue("center", request.getCookies ());


	String ty="",id="",dt="",sl="", doc_rgno="";

	//String dat = dt.substring(0,2)+dt.substring(3,5)+dt.substring(6,10);
	//dt = myDate.getFomateDate("ymd",true,dat);



	try{
		ty = request.getParameter("ty").toLowerCase();
		id = request.getParameter("id");
		dt = request.getParameter("dt");
		sl = request.getParameter("sl");
		doc_rgno = uinfo.getreg_no(uid);


		dataobj objpre=null;
		Object res=ddinfo.DisplayFrm(ty,id,dt,sl);


		if(res instanceof String){
			out.println("</br>center><h1> Data Not Available </h1></center>");
			out.println("</br><center><h1> " +  res+ "</h1></center>");
		}
		else{
			Vector tmp = (Vector)res;
			if(tmp.size()>0)
				objpre = (dataobj) tmp.get(0);
		}	




	JSONObject jsObj = new JSONObject();
	jsObj.put("diagnosis",objpre.getValue("diagnosis"));
	jsObj.put("advice",objpre.getValue("advice"));

	String A, B, C, D, E;

	A = objpre.getValue("drugs");
	B = objpre.getValue("quantity");
	C = objpre.getValue("dose");
	D = objpre.getValue("duration");
	E = objpre.getValue("comments");

	String aa[]=A.split("!");
	String bb[]=B.split("!");
	String cc[]=C.split("!");
	String dd[]=D.split("!");
	String ee[]=E.split("!");

	int xx=aa.length;


	StringTokenizer stA = new StringTokenizer(A, "!");
	StringTokenizer stB = new StringTokenizer(B, "!");
	StringTokenizer stC = new StringTokenizer(C, "!");
	StringTokenizer stD = new StringTokenizer(D, "!");
	StringTokenizer stE = new StringTokenizer(E, "!");

int ii=0;
String comee="";
String drug="",quantity="", dose="",duration="",comments="";

	JSONArray medicineList = new JSONArray();
	 while (stA.hasMoreTokens()) {
	 JSONObject medicineObj = new JSONObject();
		//out.println("Drugs 1: "+ stA.nextToken() + " || ");
		String drgelm = stA.nextToken();
		medicineObj.put("drug",drgelm);
		drug += drgelm+"!";

	if(ii<bb.length)
	comee=bb[ii];
 	else comee="-";

		//out.println("Quantity: "+ comee + " ||");
		medicineObj.put("quantity",comee);
		quantity += comee+"!";

	if(ii<cc.length)
	comee=cc[ii];
 	else comee="-";

		//out.println("Dose: "+ comee + " || ");
		medicineObj.put("dose",comee);
		dose += comee+"!";

 if(ii<dd.length)
	comee=dd[ii];
 else comee="-";

		//out.println("Duration: "+ comee + " || ");
		medicineObj.put("duration",comee);
		duration += comee +"!";

 if(ii<ee.length)
 	comee=ee[ii];
 else comee="-";

	//out.println("Comments: "+comee + " || ");
	medicineObj.put("comment",comee);
	comments += comee +"!";

	medicineList.add(medicineObj);

	ii++;
	}

	String cnt1=String.valueOf(ii);


	jsObj.put("medicine",medicineList);

			cookx.addCookieSpl("Drug",drug,response);
			cookx.addCookie("Qty",quantity,response);
			cookx.addCookie("Dose",dose,response);
			cookx.addCookie("Dura",duration,response);
			cookx.addCookieSpl("Com",comments,response);
			cookx.addCookie("Count",cnt1,response); 

out.println(jsObj);
		//out.println(ty+" : "+id+" : "+dt+" : "+sl );
	}catch(Exception ex){out.println(ex.toString());}







%>