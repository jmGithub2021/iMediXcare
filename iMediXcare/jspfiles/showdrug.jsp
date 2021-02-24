<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%

//MyWebFunctions thisObj = new MyWebFunctions();

 String temp="";
 int t,st,i,ctr=0,deldrg,edit_drg,cod,pos,pos2,org_edtdrg,dpos=1;
 String tmp1="",org_deldrg,tag,ctr1;
 String field[]={"","Drug","Qty","Dose","Dura","Com"};
 cook cookx = new cook();
 ctr1 = cookx.getCookieValue( "Count", request.getCookies ());
 if(ctr1.length() == 0) ctr = 0;
 else ctr= Integer.parseInt(ctr1);

int[] posval = new int[ctr+2];

cod = Integer.parseInt(request.getParameter("code"));

if(cod == 2 )
{	//drug deletion cod =2

deldrg =  Integer.parseInt(request.getParameter("del"));	 //drug no. to be deleted
org_deldrg = String.valueOf(deldrg);

out.println("deldrg :"+deldrg);
out.println("org_deldrg :"+org_deldrg);

tag = String.valueOf(deldrg);

for(i = 1;i<=5;i++)					//5 times bcoz 5 elements in Medicine cookie
{
		pos =0;
		posval[0]=-1;
		temp = (field[i].equalsIgnoreCase("Drug") || field[i].equalsIgnoreCase("Com"))?cookx.getCookieValueSpl(field[i], request.getCookies ()):cookx.getCookieValue(field[i], request.getCookies ());
		
		out.println("temp >> "+field[i]+" : "+temp+"<br>");

			for(t=1;t<ctr;t++)
			{
				pos =temp.indexOf("!",pos+1);
			//	out.println("pos :"+pos);
				posval[t]=pos;
			}

			pos2 = temp.indexOf("!",pos+1);
			//out.println("pos 2 :"+pos2);
			//out.println("ctr :"+ctr);
			if(cod == 2){
				if(deldrg==1 && ctr==1){
					tmp1 = "";
				}else{
					 if(deldrg==ctr){
						   tmp1 = temp.substring(0,posval[deldrg-1]+1);
					 }else tmp1 = temp.substring(0,posval[deldrg-1]+1)+ temp.substring(posval[deldrg]+1);
				}
				if(field[i].equalsIgnoreCase("Drug") || field[i].equalsIgnoreCase("Com"))
					cookx.addCookieSpl(field[i],tmp1,response);
				else
					cookx.addCookie(field[i],tmp1,response);
			//response.cookies("Medicine")(field[i]) = tmp1
			out.println("tmp1 >> "+field[i]+" : "+tmp1+"<br>");
			} 

	} // for

	cookx.addCookie("Count",String.valueOf(Integer.parseInt(cookx.getCookieValue("Count", request.getCookies ()))-1),response);
	ctr=ctr-1;
	response.sendRedirect(response.encodeRedirectURL("showdrug.jsp?code=1"));

}// if

 st = 0;
 temp = cookx.getCookieValueSpl("Drug", request.getCookies ());

 if(temp.length() == 0)
 {
	temp="!";
 }
 else
 {
 temp=temp.substring(0,temp.length()-1);
 }
 //out.println("Drug : "+temp);
 String drg[] = temp.split("!");

///////////////////////////////////
 temp = cookx.getCookieValue("Qty", request.getCookies ());
 if(temp.length() == 0)
 {
	temp="!!!!!!!";
 }
 
 temp=temp+"x";


// out.println("Qty : "+temp);
 String qty[] = temp.split("!");
/////////////////////////////////////////

 temp = cookx.getCookieValue("Dose", request.getCookies ());
 if(temp.length() == 0)
 {
	temp="!!!!!!!";
 }
 temp=temp+"x";
 
 //out.println(" >> Dose : "+temp);

 String dos[] = temp.split("!");

 temp = cookx.getCookieValue("Dura", request.getCookies ());
 if(temp.length() == 0)
 {
	temp="!!!!!!!";
 }

 temp=temp+"x";
 //out.println("  >> Dura : "+temp);
 String drt[] = temp.split("!");

 temp = cookx.getCookieValueSpl("Com", request.getCookies ());

 if(temp.length() == 0)
 {
	temp="!!!!!!!";
 }
 temp=temp+"x";
 
//out.println(" >> Com : "+temp);

String com[] = temp.split("!");


 %>
<HTML>
<HEAD>
<TITLE>Prescribe Medicine </TITLE>
<script>
$('a').click(function(e){
    e.preventDefault();
    $.ajax({
        url:''+$(this).attr("value")+'',
        type:'get',
        data:$(this).serialize(),
        success:function(ss){
           $(".add-drug").html(ss);
        }
    });
});
</script>

</Head>
<body>

<form name="drug"><CENTER>
<BR><BR><BR><BR>
 <CENTER><H2><U><font color=#FF9966>Course Of Medicine</font></U></H2></CENTER>
<TABLE class="table table-bordered table-striped" >
 <TR>
	<TD colspan=1>Sl No.</TD>
 	<TD>Drug(s)</TD>
 	<TD>Quantity</TD>
 	<TD>Dose</TD>
 	<TD>Duration</TD>
 	<TD>Comments</TD>
	<TD>Delete</TD>

 </TR>
 <%
//	<Td>Edit</Td>


	int xx=0;
	if(ctr != 0)
	{

		for(i = st;i<=ctr-1;i++)
		{

		out.println("<TR><TD>"+ (i+1) + "</TD>");
		try
		{

 		out.println("<TD><INPUT class='form-control' NAME='drg1' size=10 disabled=true value='"+drg[i]+"' ></TD>");
 		out.println("<TD><INPUT class='form-control' NAME='qty1' size=8 disabled=true value='"+qty[i]+"' ></TD>");
		//out.println("abc"+com[i]);
 		out.println("<TD><INPUT class='form-control' NAME='dos1' size=10 disabled=true value='"+dos[i]+"'></TD>");
 		out.println("<TD><INPUT class='form-control' NAME='drt1' size=10 disabled=true value='"+drt[i]+"'></TD>");
 		out.println("<TD><INPUT class='form-control' NAME='com1' size=10 disabled=true value='"+com[i]+"'></TD>");

		}
		catch(ArrayIndexOutOfBoundsException e)
		{ 
		
		System.out.println("Ex" + e);
		}
		xx=i+1;

		out.println("<TD><a value='showdrug.jsp?code=2&del="+xx+"'> <IMG SRC='../images/1cross.gif'  BORDER=0 alt='delete drug'> </a></TD>");
		//out.println("<TD><a href=editdrug.jsp?edit="+xx+"> <IMG SRC=../images/pen.jpg  width=25 height=25 BORDER=0 alt='edit drug'> </a></TD></TR>");		

		}
	}
%>
 </TABLE> </form>
<BR>
<A value="drug.html">Add More</A>&nbsp;&nbsp;&nbsp;
<!-- <A HREF="/submitpres.asp" >Complete</A> --></CENTER>

<BR>
</BODY>
</HTML>


 

