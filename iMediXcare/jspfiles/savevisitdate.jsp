<%@page language="java"  import= "imedix.rcGenOperations,imedix.myDate,imedix.rcDataEntryFrm,imedix.dataobj,imedix.cook, java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	cook cookx = new cook();
	rcGenOperations rcgop=new rcGenOperations(request.getRealPath("/"));

	String uid =cookx.getCookieValue("userid", request.getCookies ());
	String id=request.getParameter("pat_id");
	String assign_doc=request.getParameter("selphy");
	String opd_id = request.getParameter("opd_id");
	String usr = cookx.getCookieValue("usertype", request.getCookies());
	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String pidCcode="";

	if(id==null) id="";
	id=id.replaceAll("'","''");

	if(id.equals("")) {
		out.println("<font size=+1><Br><Br><center>Patient ID is Blank<br>Patient Visit Can Not be Saved<br> ");
		out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Back' ></A>");
		return;
	}

	if(id.length()>=4)
		pidCcode=id.substring(0,4).toUpperCase();
	else{
		out.println("<font size=+1><Br><Br><center>Invalid Patient ID <br>Patient Visit Can Not be Saved<br> ");
		out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Back' ></A>");
		return;
	}

	dataobj obj = new dataobj();
	try{
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	obj.add("pat_id",id);
	obj.add("assigndoc",assign_doc);
	obj.add("visitdate",myDate.getCurrentDate("ymd",true));
	obj.add("userid",uid);
	obj.add("opdno",opd_id);
	
	int ans = rcdef.setVisitDate(obj);

	if(ans==1){
		cookx.addCookie("patid",id,response);

		String patdis="General Medical";
		String pname="";

		String cnd= "lower(pat_id) = '" + id.toLowerCase() +"'";
		pname=rcgop.getAnySingleValue("med","pat_name",cnd);
		//out.print("<br>"+pname+"<br>"+cnd);
		if(!pname.equals("")){
			cookx.addCookie("patname",pname,response);
		}
		
		cnd= "lower(pat_id) = '" + id.toLowerCase() +"'";
		patdis=rcgop.getAnySingleValue("med","class",cnd);
		
		out.println("<font size=+1><Br><Br><center>Sucessfully Done!<br>");
		//out.println("Start <a href='frames.html'> Data Entry </a>");
		//out.println("<BR>Click Here To Start <a href='showpatdata.jsp?id="+id+"&usr="+usr+"&nam="+pname+"&patdis="+patdis+"' target='_blank'> Data Entry </a>");
		//out.println("<Br><Br><a href='/iMediX'> HOME </a></center></font>");

	 }else{
			//response.sendRedirect(".....jsp");
			out.println("<font size=+1><Br><Br><center>Invalid Patient ID <br> Or <br> Patient ID Not Found <br>Patient Visit Can Not be Saved<br> ");
			
			out.println("<BR><A HREF='javascript:history.go(-1)'><IMG SRC='../images/back.jpg' WIDTH='40' HEIGHT='30' BORDER=1 title='Trye Again'></A>");


	 }

	//out.println("<br>"+ ans);

	}catch(Exception e){
		out.println("ERROR09974 : "+ e.toString());
	}
%>
