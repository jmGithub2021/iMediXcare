<%@page contentType="text/html" import="imedix.projinfo,imedix.rcPatqueueInfo,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>


<%
//String searchQueryString = "&method="+request.getMethod()+"&ev="+request.getParameter("getlpatqSrchRslt");
String searchQueryString = "";

if(request.getMethod().equalsIgnoreCase("GET")){
	Enumeration paramNames = request.getParameterNames();
	while(paramNames.hasMoreElements()){
		String paramName = (String)paramNames.nextElement();
		String paramValue = request.getParameter(paramName);
		if(paramValue != null)
			searchQueryString += "&"+paramName+"="+paramValue;
	}
	//out.println(searchQueryString);
}

%>


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


	try {
		if(curCCode==null) curCCode="";
		if(curCCode.equals("")){
			if(ccode.equals("XXXX") ) curCCode=rcci.getFirstCentreCode();
			else curCCode=ccode;
		}
	}catch(Exception e){
	}

	//cc = cookx.getCookieValue("center", request.getCookies ());

	prg="patqueue.jsp?curCCode="+curCCode+searchQueryString;

	int total=0;

	if(ccode.trim().length() > 0)
	{
		try
		{
			if(utyp.equals("adm") || utyp.equals("usr") || utyp.equals("sup") || utyp.equals("con"))
			{
				String cnt = rcpqi.getTotalLPatAdmin2(curCCode);

				if(cnt.equals("")) total=0;
				else total=Integer.parseInt(cnt);

				if(total == 0)
				{
					if(ccode.equals("XXXX")) response.sendRedirect  (response.encodeRedirectURL(prg+"&FirstPat=0&LastPat="+pagerow+"&tot="+total));
					else out.println("<br><br><CENTER><FONT SIZE='+2' COLOR='#FF3300'>No Data Available</FONT></CENTER>");

				}
				else
				{
					//out.println(prg+"&FirstPat=1&LastPat="+pinfo.gblPageRow+"&tot="+total);
				   response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total));

				}
			} // end of user type

		if(utyp.equals("doc"))
		{
			String dreg=rcui.getreg_no(usr);
			String cnt = rcpqi.getTotalLPatDoc(curCCode,dreg);
			//out.println(ccode + "  "+ dreg +"<br>");
			//out.println(cnt;

			if(cnt.equals("")) total=0;
			else total=Integer.parseInt(cnt);
			if(total == 0)
				out.println("<br><br><CENTER><FONT SIZE='+2' COLOR='#FF3300'>No Data Available</FONT></CENTER>");
			else{
				//out.println(prg+"?FirstPat=1&LastPat="+recs+"&tot="+total);
				response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat="+FR+"&LastPat="+LR+"&tot="+total));
			}
		}

	  } catch (Exception e) {out.println(e.getMessage());}

	}else
		response.sendRedirect(response.encodeRedirectURL(prg+"&FirstPat=0&LastPat=0&tot="+total));
%>
</body>
</html>
