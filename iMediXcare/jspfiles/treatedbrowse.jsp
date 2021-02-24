<%@page contentType="text/html" import="imedix.projinfo,imedix.rcPatqueueInfo,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<body>
<%
	String isnodal="",query="",usr="";
	String  prg="";

	cook cookx = new cook();
	projinfo pinfo=new projinfo(request.getRealPath("/"));
	int pagerow=Integer.parseInt(pinfo.gblPageRow);
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	usr=cookx.getCookieValue("userid", request.getCookies());
	
	cookx.addCookie("node","",response);
	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String curCCode= request.getParameter("curCCode");
	String FR= request.getParameter("F"); if (FR==null) FR="0";
	String LR= request.getParameter("L"); if (LR==null) LR=pinfo.gblPageRow;
	String currpatqtype = cookx.getCookieValue("currpatqtype",request.getCookies());

	try {
		if(curCCode==null) curCCode="";
		if(curCCode.equals("")){
			if(ccode.equals("XXXX") ) curCCode=rcci.getFirstCentreCode();
			else curCCode=ccode;
		}
	}catch(Exception e){
	}

	//cc = cookx.getCookieValue("center", request.getCookies ());
	if(currpatqtype.equals("local"))
		prg = "treated_lpatq.jsp?curCCode="+curCCode;
	else if(currpatqtype.equals("tele"))
		prg = "treated_tpatq.jsp?curCCode="+curCCode;
	else
		prg="";
		
	int total=0;

	if(ccode.trim().length() > 0)
	{		
		try
		{
			if(utyp.equals("adm") || utyp.equals("usr") || utyp.equals("sup") || utyp.equals("con"))
			{

					//out.println(prg+"&FirstPat=1&LastPat="+pinfo.gblPageRow+"&tot="+total);	
				   response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total));
			} // end of user type

		if(utyp.equals("doc"))
		{

				response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total));
		}

	  } catch (Exception e) {out.println(e.getMessage());}

	}else
		response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat=0&LastPat=0&tot="+total));
%>
</body>
</html>
	
