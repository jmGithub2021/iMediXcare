<%@page language="java"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>

<%
	MyWebFunctions thisObj = new MyWebFunctions();
	String ctr,edit_drg,org_edtdrg;
	String deldrg="",tmp1="",org_deldrg="",val="",temp="",cod="";
	StringTokenizer drg,qty,dos,drt,com;
	int st=0,pos,t,tag=0,pos2=-1,deldrgno=0,i=0;
	String field[] = new String[5];
	
	field[0]="drug";
	field[1]="qty";
	field[2]="dose";
	field[3]="dura";
	field[4]="com";

	cod = request.getParameter("code");
	//out.print("<br>cod:"+cod+" , int equ"+Integer.parseInt(cod));
	//to delete a drug
	if  (Integer.parseInt(cod) == 2 )			 //drug deletion cod =2  
	{
		deldrg =  request.getParameter("del");	 // drug no. to be deleted
		deldrgno =  Integer.parseInt(deldrg);
		org_deldrg = deldrg;

		if (deldrgno > 1) { 
			deldrgno = deldrgno - 1;
			tag = deldrgno;
		}
		for (i=1;i<=5;i++)							//5 times bcoz 5 types of Medicine cookie
		{
			pos =-1;
			temp = thisObj.getCookieValue(field[i-1],request.getCookies());	
			//out.print("<BR>Cook val:"+temp);
			for(t=1;t<=tag;t++)	
			{
				pos = temp.indexOf("!",pos+1);
			}
				pos2 = temp.indexOf("!",pos+1);		// the difference of pos and pos2 contains the string to delete

			if ( pos2 == -1 && pos == -1)              //only possible if the temp is blank
				tmp1="";
			else
			{	
				if (pos2 == -1 && pos != -1) tmp1=temp.substring(0,pos-1);	// the last value of temp to be deleted
				else  tmp1 =temp.substring(0,pos)+temp.substring(pos2+1);
			}
			if (deldrgno == 1)		//the first value of the temp to be deleted	
				tmp1 = temp.substring(pos+1);
		
		//out.print("<br>"+field[i-1]+" : "+tmp1);
		thisObj.setValues(field[i-1],tmp1,request.getCookies(),response);

		
		} // end of: for (i=1;i<=5;i++)


	} // end of if  (cod == 2 )	


		/*	Cookie cookies [] = request.getCookies ();
		if (cookies != null)
		{	
			for (int i = 0; i < cookies.length; i++)
			{
				out.println("<BR>" + cookies[i].getName() + "=" + cookies[i].getValue());
			}
		}*/

	val = thisObj.getCookieValue("drug",request.getCookies());
	drg = new StringTokenizer(val,"!");
	
	val = thisObj.getCookieValue("qty",request.getCookies());
	qty = new StringTokenizer(val,"!");

	val = thisObj.getCookieValue("dose",request.getCookies());
	dos = new StringTokenizer(val,"!");

	val = thisObj.getCookieValue("dura",request.getCookies());
	drt = new StringTokenizer(val,"!");

	val = thisObj.getCookieValue("com",request.getCookies());
	com = new StringTokenizer(val,"!");

%>

 <HTML>
<HEAD>
<TITLE>Prescribe Medicine </TITLE></Head>
<body>

<form name="drug"><CENTER>

 <CENTER><H2><U><font color=#FF9966>Course Of Medicine</font></U></H2></CENTER>
<TABLE border=1 cellpadding=1 cellspacing=2 width="90%" bordercolor=BLACK bgcolor="PEACH" style="text-align:center;font-weight:bold;color=WHITE" >
 <TR>
	<TD colspan=1>Sl No.</TD>
 	<TD>Drug(s)</TD>
 	<TD>Quantity</TD>
 	<TD>Dose</TD>
 	<TD>Duration</TD>
 	<TD>Comments</TD>
	<TD>Delete</TD>
	<Td>Edit</Td>
 </TR>


 <%
 i=1;
	while(drg.hasMoreTokens())
	{
		out.print("<TR><TD>"+ (i+1) + "</TD>");
 		out.print("<TD><INPUT NAME='drg1' size=10 disabled=true value='"+drg.nextElement()+"' ></TD>");
 		out.print("<TD><INPUT NAME='qty1' size=8 disabled=true value='"+qty.nextElement()+"' ></TD>");
 		out.print("<TD><INPUT NAME='dos1' size=10 disabled=true value='"+dos.nextElement()+"'></TD>");
 		out.print("<TD><INPUT NAME='drt1' size=10 disabled=true value='"+drt.nextElement()+"'></TD>");
 		out.print("<TD><INPUT NAME='com1' size=10 disabled=true value='"+com.nextElement()+"'></TD>");
		out.print("<TD><a href=showdrug.jsp?code=2&del="+i+"> <IMG SRC=../images/1Cross.gif  BORDER=0 alt='delete drug'> </a></TD>");
		out.print("<TD><a href=editdrug.jsp?edit="+i+"> <IMG SRC=../images/pen.jpg  width=25 height=25 BORDER=0 alt='edit drug'> </a></TD></TR>");
	i++;
	}

%>
  </TABLE> </form>
<BR>
<A HREF="drug.html">Add More</A>&nbsp;&nbsp;&nbsp;
<!-- <A HREF="../submitpres.asp" >Complete</A> --></CENTER>

<BR>
</BODY>
</HTML>
