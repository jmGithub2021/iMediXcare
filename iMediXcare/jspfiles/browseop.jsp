<%@page contentType="text/html" import="imedix.rcPatqueueInfo,imedix.rcUserInfo,imedix.dataobj,imedix.cook, java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>

<%
	String cc="",isnodal="",query="",usr="";
	String  prg="";
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	usr=cookx.getCookieValue("userid", request.getCookies());
	//isnodal = cookx.getCookieValue("node", request.getCookies ());
	
	cookx.addCookie("node","",response);

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));

	//if(isnodal.trim().length() == 0)
	//{
		cc = cookx.getCookieValue("center", request.getCookies ());
		prg="patqueue.jsp";
	//}

	int recs=0,total=0;
	if(cc.trim().length() > 0)
	{		
		try
		{
			if(utyp.equals("usr"))
			{
				String cnt = rcpqi.getTotalLPatAdmin(cc);
				if(cnt.equals("")) recs=0;
				else recs=Integer.parseInt(cnt);
				total = recs;

				if(recs == 0)
				{
				out.println("<br><br><CENTER><FONT SIZE='+2' COLOR='#FF3300'>No Data Available</FONT></CENTER>");
				}
				else
				{
					if(recs>10)	recs=10;
					out.println(prg+"?FirstPat=1&LastPat="+recs+"&tot="+total);	
				response.sendRedirect(response.encodeRedirectURL(prg+"?FirstPat=1&LastPat="+recs+"&tot="+total));
					
				}
			} // end of user type


		} catch (Exception e) {out.println(e.getMessage());}
	}
	else
		response.sendRedirect(response.encodeRedirectURL(prg+"?FirstPat=0&LastPat=0&tot="+total));
%>
</html>
	
