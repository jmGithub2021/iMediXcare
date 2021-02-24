<%@page language="java"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>

<%
//out.print("hello");
	MyWebFunctions thisObj = new MyWebFunctions();
	String qstr="",chk="",nam="",ext;
	String field[] = new String[5];
	String fdrug="",fqty="",fdos="",fdrt="",fcom="";
	int i=0,t;
	field[0]="drg";
	field[1]="qty";
	field[2]="dos";
	field[3]="drt";
	field[4]="com";
	for (i=0;i<5;i++)
	{
		//Integer num = new Integer(i+1); 
		nam = "drg"+Integer.toString(i+1);
		if (request.getParameter(nam) == null) continue;
		else  break; 
		
	}
	
	for (t=i;t<5;t++)
	{
		nam="drg"+Integer.toString(t+1);
		out.print("<BR>nam: "+nam);
		out.print(" Val:"+request.getParameter(nam));
		if (request.getParameter(nam) != null)
		{
			fdrug+=request.getParameter(field[0]+Integer.toString(t+1))+
		}
	}
%>
