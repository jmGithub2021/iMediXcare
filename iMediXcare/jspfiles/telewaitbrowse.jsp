<%@page contentType="text/html" import="imedix.projinfo,imedix.rcCentreInfo,imedix.rcPatqueueInfo,imedix.rcUserInfo, imedix.dataobj,imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<%
	
	String query="",usr="",prg="";
	cook cookx = new cook();
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	int pagerow=Integer.parseInt(pinfo.gblPageRow);

	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	usr=cookx.getCookieValue("userid", request.getCookies());

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

	String lcode = cookx.getCookieValue("center", request.getCookies ());
	String rccode= request.getParameter("rccode");
	String FR= request.getParameter("F"); if (FR==null) FR="0";
	String LR= request.getParameter("L"); if (LR==null) LR=pinfo.gblPageRow;
	
	out.println("rccode="+rccode);	

	//if(rccode==null) rccode="";
	//if(rccode.equals("")) rccode= cookx.getCookieValue("center", request.getCookies ());

	try {
		if(rccode==null) rccode="";
		if(rccode.equals("")){
			if(lcode.equals("XXXX") ) rccode=rcci.getFirstCentreCode();
			else rccode=lcode;
		}
	}catch(Exception e){
	}

	//out.println("<BR>rccode="+rccode);	
	prg="telepatwaitqueue.jsp?rccode="+rccode;

	int total=0;

	if(rccode.trim().length() > 0)
	{		
		try
		{
			if(utyp.equals("adm") || utyp.equals("sup") || utyp.equals("con"))
			{
				String cnt = rcpqi.getTotalRPatwaitAdmin(lcode,rccode); // here
				//int cnt = rcpqi.getTotal("tpatwaitq");
				out.println("cnt="+cnt);	

				if(cnt.equals("")) total=0;
				else total=Integer.parseInt(cnt);
				/*---------------------------------------*/
				cnt = rcpqi.getTotal("tpatwaitq");
				if(cnt.equals("")) total=0;
				else total=Integer.parseInt(cnt);

				if(total == 0)
				{
				 //out.println("<br><br><CENTER><FONT SIZE='+2' COLOR='#FF3300'>No Data Available</FONT></CENTER>");
				response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat=1&LastPat="+pagerow+"&tot="+total));
				}
				else
				{	
					//out.println(prg+"?FirstPat=1&LastPat="+pinfo.gblPageRow+"&tot="+total);	
					response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total));
					
				}
			} // end of user type

		if(utyp.equals("doc"))
		{
			String dreg=rcui.getreg_no(usr);
			String cnt = rcpqi.getTotalRPatwaitDoc4twb(rccode,dreg); //here
				//int cnt = rcpqi.getTotal("tpatwaitq");
			out.println(rccode + " !!test!! "+ dreg +"<br>");
			out.println("cnt :"+cnt);

			if(cnt.equals("")) total=0;
			else total=Integer.parseInt(cnt);
			//out.println("total:"+total);
			if(total == 0) {
				//out.println("<br><br><CENTER><FONT SIZE='+2' COLOR='#FF3300'>No Data Available</FONT></CENTER>");
				/* on it */

				response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat=1&LastPat="+pagerow+"&tot="+total)); //here
				//out.println("<br>url1 :"+prg+"&FirstPat=1&LastPat=0&tot="+total);
			}
			else 
			{ 
			//out.println(prg+"?FirstPat=1&LastPat="+pinfo.gblPageRow+"&tot="+total);
			/* on it */

			response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total)); //here
			//out.println("<br>url2 :"+prg+"&FirstPat=1&LastPat="+pinfo.gblPageRow+"&tot="+total);
			}
		}

		} catch (Exception e) {out.println(e.getMessage());}
	}
	else
	{
		response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat=1&LastPat=0&tot="+total));
		//out.println("<br>url3 :"+prg+"&FirstPat=1&LastPat=0&tot="+total);
	}

%>
</html>
	
