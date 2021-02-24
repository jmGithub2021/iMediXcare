<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj, imedix.myDate,imedix.cook,java.util.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	
	cook cookx = new cook();
	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
	
	String id=request.getParameter("pat_id").trim();
	
	String userid =cookx.getCookieValue("userid", request.getCookies());
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	String usr = cookx.getCookieValue("usertype", request.getCookies());


	String drugs = cookx.getCookieValueSpl("Drug", request.getCookies());
	String quantity = cookx.getCookieValue("Qty", request.getCookies());
	String dose = cookx.getCookieValue("Dose", request.getCookies());
	String duration = cookx.getCookieValue("Dura", request.getCookies());
	String comments = cookx.getCookieValueSpl("Com", request.getCookies());
			
	dataobj obj = new dataobj();	
	obj.add("frmnam",request.getParameter("frmnam").trim().toLowerCase());
	obj.add("pat_id",request.getParameter("pat_id").trim());
	obj.add("entrydate",myDate.getCurrentDate("dmy",false));
	obj.add("apptdate",request.getParameter("apptdate").trim().replaceAll("/",""));
	obj.add("diagnosis",request.getParameter("diagnosis").trim());
	obj.add("diet",request.getParameter("diet").trim());
	obj.add("activity",request.getParameter("activity").trim());
	obj.add("advice",request.getParameter("advice").trim());

	obj.add("drugs",drugs);
	obj.add("quantity",quantity);
	obj.add("dose",dose);
	obj.add("duration",duration);
	obj.add("comments",comments);

	obj.add("name_hos",request.getParameter("cnam"));
	obj.add("docrg_no",request.getParameter("drgno"));
	
	obj.add("userid",userid);
	obj.add("center",ccode);
	obj.add("usertype",usr);
	

	int ans = rcdef.InsertFrmAll(obj);
		if(ans==1){
				
			String currpatqtype = cookx.getCookieValue("currpatqtype", request.getCookies());

			try{

		//	rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
			int status = 0;
			if(currpatqtype.equalsIgnoreCase("local")){
				//rcdef.advicedConsultant(id,userid);
				//status = rcdef.moveLtoTreatedpatq(id);
			}
			else if(currpatqtype.equalsIgnoreCase("tele")){	
				//status = rcdef.moveTtoTreatedpatq(id);
				//rcdef.teleTreated(id, userid);
			}
			else{
				status = 0;
			}
			out.println("Done! ");
			}catch(Exception ex){out.println("ERROR09763 : "+ex.toString());}			
			
			
			//response.sendRedirect("");
			//response.sendRedirect("showlist.jsp");
		}else{
			//response.sendRedirect(".....jsp");
			out.println("Error");
		}
%>


