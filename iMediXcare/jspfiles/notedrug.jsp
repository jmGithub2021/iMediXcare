<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	
	String  qstr="",chk="",nam="",cnt1="";
	String drg="",qty="",dos="",drt="",com="";
	int i=1,t=0,c=0;
	String field[]={"sl","drg","qty","dos","drt","com"};
	
	//qstr = request.queryString
	// find out if any drug row is empty
	cook cookx = new cook();
	chk = cookx.getCookieValue("Count", request.getCookies());
	if(chk.length()==0)   //create the cookie for the first time
	{
		for(i=1;i<=5;i++)
		{
			nam = "drg"+i;
			if(request.getParameter(nam).length() == 0)
			{
			break;
			}

			drg+=request.getParameter(field[1]+i)+"!";
			
			out.println("drg = "+request.getParameter(field[1]+i)+"!");

			qty+=request.getParameter(field[2]+i)+"!";
			out.println("qty = "+request.getParameter(field[2]+i)+"!");
			dos+=request.getParameter(field[3]+i)+"!";
			out.println("dos = "+request.getParameter(field[3]+i)+"!");
			drt+=request.getParameter(field[4]+i)+"!";
			out.println("drt = "+request.getParameter(field[4]+i)+"!");
			com+=request.getParameter(field[5]+i)+"!";
			out.println("com = "+request.getParameter(field[5]+i)+"!");

			
			cnt1=String.valueOf(i);
		}
			cookx.addCookieSpl("Drug",drg,response);
			cookx.addCookie("Qty",qty,response);
			cookx.addCookie("Dose",dos,response);
			cookx.addCookie("Dura",drt,response);
			cookx.addCookieSpl("Com",com,response);
			cookx.addCookie("Count",cnt1,response); 

			out.println("*Drug=" + cookx.getCookieValueSpl("Drug", request.getCookies()) + "<br>");
			out.println("*Qty="+cookx.getCookieValue("Qty", request.getCookies())+"<br>");
			out.println("*Dose="+cookx.getCookieValue("Dose", request.getCookies())+"<br>");
			out.println("*Dure="+cookx.getCookieValue("Dura", request.getCookies())+"<br>");
			out.println("*Com="+cookx.getCookieValueSpl("Com", request.getCookies())+"<br>");
			out.println("*Count="+cookx.getCookieValue("Count", request.getCookies())); 
		
	}
	else
	{
	
	c=Integer.valueOf(chk);
	out.println("c is "+c);
	//collect the drug info

	try{
	  int count=0;
	  String dr="",qt="",ds="",du="",cm="",cnt="";
	  for(t=1;t<=5;t++){
		nam = "drg"+t;
		out.println("nam is "+nam);
		String str=request.getParameter(nam);
		out.println("str="+str);
		 if(str.length() != 0){ 
		
			if(t==1){	
				dr=cookx.getCookieValueSpl("Drug", request.getCookies());
				qt=cookx.getCookieValue("Qty", request.getCookies());
				ds=cookx.getCookieValue("Dose", request.getCookies());
				du=cookx.getCookieValue("Dura", request.getCookies());
				cm=cookx.getCookieValueSpl("Com", request.getCookies());
				cnt=cookx.getCookieValue("Count", request.getCookies());
			}

			out.println(" dr="+dr);
			out.println(" qt="+qt);
			out.println(" ds="+ds);
			out.println(" du="+du);
			out.println(" cm="+cm);
			out.println(" count="+cnt+"<br>");
			
			count=Integer.parseInt(cnt);
			count=count+1;
			cnt=String.valueOf(count);
	
			dr+=request.getParameter(field[1]+t)+"!";
			qt+=request.getParameter(field[2]+t)+"!";
			ds+=request.getParameter(field[3]+t)+"!";
			du+=request.getParameter(field[4]+t)+"!";
			cm+=request.getParameter(field[5]+t)+"!";	

			/* out.println("Drug="+thisObj.getCookieValue("Drug", request.getCookies())+request.getParameter(field[1]+t)+"!"+"<br>");
			out.println("Qty="+thisObj.getCookieValue("Qty", request.getCookies())+request.getParameter(field[2]+t)+"!"+"<br>");
			out.println("Dose="+thisObj.getCookieValue("Dose", request.getCookies())+request.getParameter(field[3]+t)+"!"+"<br>");
			out.println("Dure="+thisObj.getCookieValue("Dure", request.getCookies())+request.getParameter(field[4]+t)+"!"+"<br>");
			out.println("Com="+thisObj.getCookieValue("Com", request.getCookies())+request.getParameter(field[5]+t)+"!"+"<br>");
			out.println("Count="+thisObj.getCookieValue("Count", request.getCookies())+1+"<br>"); */
			//response.cookies("Medicine")("Drug") = request.cookies("Medicine")("Drug")&"!"&request.querystring(field(1)&t)
			//response.cookies("Medicine")("Qty") = request.cookies("Medicine")("Qty")&"!"&request.querystring(field(2)&t)
			//response.cookies("Medicine")("Dose") = request.cookies("Medicine")("Dose")&"!"&request.querystring(field(3)&t)
			//response.cookies("Medicine")("Dura") = request.cookies("Medicine")("Dura")&"!"&request.querystring(field(4)&t)
			//response.cookies("Medicine")("Com") = request.cookies("Medicine")("Com")&"!"&request.querystring(field(5)&t)
			//response.cookies("Medicine")("Count") = request.cookies("Medicine")("Count") + 1
	
		}else{
			break;
		}

	} // end for
		out.println("<br><br> dr="+dr);
		out.println(" qt="+qt);
		out.println(" ds="+ds);
		out.println(" du="+du);
		out.println(" cm="+cm+"<br>");
	
		cookx.addCookieSpl("Drug",dr,response);
		cookx.addCookie("Qty",qt,response);
		cookx.addCookie("Dose",ds,response);
		cookx.addCookie("Dura",du,response);
		cookx.addCookieSpl("Com",cm,response);
		cookx.addCookie("Count",cnt,response); 
		 
	} catch(NullPointerException e)
	{

	} 
	}

		out.println( "<br><br> *Drug=" + cookx.getCookieValueSpl("Drug", request.getCookies()) + "<br>");
		out.println("*Qty="+cookx.getCookieValue("Qty", request.getCookies())+"<br>");
		out.println("*Dose="+cookx.getCookieValue("Dose", request.getCookies())+"<br>");
		out.println("*Dure="+cookx.getCookieValue("Dura", request.getCookies())+"<br>");
		out.println("*Com="+cookx.getCookieValueSpl("Com", request.getCookies())+"<br>");
		out.println("*Count="+cookx.getCookieValue("Count", request.getCookies())); 


		response.sendRedirect(response.encodeRedirectURL("showdrug.jsp?code=1"));
%>
