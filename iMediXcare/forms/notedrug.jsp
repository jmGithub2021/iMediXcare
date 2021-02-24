<%@page language="java"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@ include file="..//gblinfo.jsp" %>

<%
//out.print("hello");
	MyWebFunctions thisObj = new MyWebFunctions();

	//response.write request.queryString&"<br>"
	String qstr="",chk="",nam="",ext="",c="1";
	String field[] = new String[6];
	String tmp="";
	
	int i=0,t=0;
	field[0]="null";
	field[1]="drg";
	field[2]="qty";
	field[3]="dos";
	field[4]="drt";
	field[5]="com";

	//qstr = request.queryString
	//find out if any drug row is empty
	for (i=1;i<=5;i++)
	{
		//Integer num = new Integer(i+1); 
		nam = "drg"+i;
		if(request.getParameter(nam).length() != 0)
		{
		break;
		}
		/*
		if (request.getParameter(nam) == null) continue;
		else  break; */
		
	}
	//check whether cookie contains previous value
	chk = thisObj.getCookieValue("count", request.getCookies()); 
	out.print("<BR>Chk : "+chk);
	//response.write "chk = "&chk&" ,len= "& len(chk)&"<br>"
	if(chk.length()==0 && i <= 5)   //create the cookie for the first time
	{
		
		thisObj.addCookie("drug",request.getParameter(field[1]+i),response);
		thisObj.addCookie("qty",request.getParameter(field[2]+i),response);
		thisObj.addCookie("dose",request.getParameter(field[3]+i),response);
		thisObj.addCookie("dura",request.getParameter(field[4]+i),response);
		thisObj.addCookie("com",request.getParameter(field[5]+i),response);
		thisObj.addCookie("count","1",response);
		/*
		tmp = request.getParameter(field[1]+i);
		thisObj.setValues("drug",tmp,request.getCookies(),response);

		tmp = request.getParameter(field[2]+i);
		thisObj.setValues("qty",tmp,request.getCookies(),response);

		tmp = request.getParameter(field[3]+i);
		thisObj.setValues("dose",tmp,request.getCookies(),response);
			
		tmp = request.getParameter(field[4]+i);
		thisObj.setValues("dura",tmp,request.getCookies(),response);
			
		tmp = request.getParameter(field[5]+i);
		thisObj.setValues("com",tmp,request.getCookies(),response);
	
		thisObj.setValues("count","1",request.getCookies(),response); 
		*/
		i=i+1;
	}
	
	int count=0;
for (t=i;t<=5;t++)
{
	nam="drg"+t;
	out.print("<BR>nam: "+nam);
	out.print(" Val:"+request.getParameter(nam));
	if (request.getParameter(nam) != null)
	{
	out.println("working");
	tmp = thisObj.getCookieValue("drug",request.getCookies())+"!"+request.getParameter(field[1]+t);

	thisObj.setValues("drug",tmp,request.getCookies(),response);
		
	tmp = thisObj.getCookieValue("qty",request.getCookies())+"!"+request.getParameter(field[2]+t);
			
	thisObj.setValues("qty",tmp,request.getCookies(),response);
			
	tmp = thisObj.getCookieValue("dose",request.getCookies())+"!"+request.getParameter(field[3]+t);
			
	thisObj.setValues("dose",tmp,request.getCookies(),response);
			
	tmp = thisObj.getCookieValue("dura",request.getCookies())+"!"+request.getParameter(field[4]+t);
	
	thisObj.setValues("dura",tmp,request.getCookies(),response);
			
	tmp = thisObj.getCookieValue("com",request.getCookies())+"!"+request.getParameter(field[5]+t);

	thisObj.setValues("com",tmp,request.getCookies(),response);
	tmp = thisObj.getCookieValue("count",request.getCookies());
	//c=c.trim();
	count=Integer.parseInt(c);
	count++;
	c=String.valueOf(count);
	thisObj.setValues("count",c,request.getCookies(),response);
	
	/*		
	count = Integer.parseInt(thisObj.getCookieValue("count",request.getCookies()))+1;
	
	thisObj.setValues("count",Integer.toString(count),request.getCookies(),response);
	}
	catch(NumberFormatException e)
	{
		out.println("Error in convert from string to int :"+e.toString());
	} */
		
		} //end of if
		out.print("<BR>Inside For[t]"+t);
	}
//response.sendRedirect(response.encodeRedirectURL("../forms/showdrug.jsp?code=1"));

%>
