<%@page contentType="text/html" import="imedix.rcPatqueueInfo,imedix.rcUserInfo,imedix.rcCentreInfo, imedix.dataobj,imedix.cook,imedix.myDate,imedix.projinfo,java.util.*" %>

<%@ include file="..//includes/chkcook.jsp" %>

<%
	String sqlQuery="",dat="";

	int c_dd=0,c_mm=0,c_yy=0;	
	int dd=0,mm=0,yy=0,x=0,styy=0;
	String islocal="",regcode="";

	//Date dt = new Date();
	//c_dd = dt.getDate();
	//c_mm= dt.getMonth()+1;
	//c_yy = dt.getYear() + 1900;
	//dat=String.valueOf(c_dd)+"/"+String.valueOf(c_mm)+"/"+String.valueOf(c_dd);

	dat=myDate.getCurrentDate("ymd",true);

	rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	rcUserInfo rcui=new rcUserInfo(request.getRealPath("/"));
	rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
	cook cookx = new cook();
	String center= cookx.getCookieValue("center", request.getCookies());

	//islocal=thisObj.getCookieValue("node", request.getCookies());
%>

<HTML>
<HEAD>
<TITLE>online communicator</TITLE>
<SCRIPT LANGUAGE="JavaScript">

function validate()
{
	var vv=document.onl.sttime.value;
	//alert(vv);
	//alert(vv.length)
	if(!chkblnk('sttime','Start Time'))
	{return false;}

	if(!checkint(vv))
	{
	document.onl.sttime.focus()
	document.onl.sttime.select()
	return false;
	}
	
return true;
}
function chkblnk(fieldname,label)
{
	var fdval=document.getElementById(fieldname).value;
	//alert(fdval);
	var temp=fdval.toString();
	if(temp.length==0) 
	{
		document.getElementById(fieldname).focus();
		alert("The " + label +" field cannot be left blank");
		document.getElementById(fieldname).select();
		return false;
	}
	//alert(temp.length);
	if(temp.length != 8)
	{
		document.getElementById(fieldname).focus();
		alert("Time Format HH:MM:SS");
		document.getElementById(fieldname).select();
		return false;
	}
return true;
}

function checkint(fdval) 
{ 
var tmp; var tnum;
var he,min,sec
for(i=0;i<fdval.length;i++) 
 { 
 tmp=fdval.substring (i,i+1); 
 if( (tmp == ':') && (i==0||i==1||i==3||i==4||i==6||i==7) ) 
	{alert("Please enter time in proper format"); return false;}
 tnum=parseInt(tmp); 
 if (tnum>=0 && tnum<=9) 
 {
	if(i==0) hr=tnum;
	if(i==1) hr=(hr*10)+tnum;
	if(i==3) min=tnum;
	if(i==4) min=(min*10)+tnum;
	if(i==6) sec=tnum;
	if(i==7) sec=(sec*10)+tnum;
	continue;
 } 
 else 
	{ 
		if((tmp == ':')) continue;
		alert('Please enter Time in proper format'); 
		return false; 
	} 
 
 } 
if(hr > 12) {alert("Invalid time"); return false;}
if(min > 59) {alert("Invalid time"); return false;}
if(sec > 59) {alert("Invalid time"); return false;}
return true;
}

var arSelected = new Array(); 
function getMultiple(ob) { 
	for (var i = 0;i < ob.length;i++) {
		if (ob.selectedIndex != 0) arSelected.push(ob.options[ob.selectedIndex].value); 
			document.onl.allids.value=document.onl.allids.value+","+ob.options[ob.selectedIndex].value;
			//ob.options[ob.selectedIndex].selected = false;
		} 	
}


</SCRIPT>
</HEAD>
<link rel="stylesheet" type="text/css" href="../style/style2.css">

<BODY >
<FORM METHOD=get ACTION="savevcr.jsp" name="onl" onSubmit="return validate();">
<A HREF="jobadmin.jsp">Back</A>
<CENTER><font size=+2>Video Conferencing Session Record On <%=dat%></font>
<INPUT TYPE="hidden" name="allids">



<TABLE  border=1 cellpadding=10 class='tableb'>
<TR><TD>
<TABLE  border=0 >
	<TR>
		<TD><B>Patient's ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></TD>
		<TD><Select Name="ids" MULTIPLE SIZE=8 onblur='getMultiple(document.onl.ids);'>

<% 
	try{
		Object res=rcpqi.getLPatqueueAdmin();
		  if(res instanceof String){
				out.println( "res :"+ res);
			}else{
				Vector tmp1 = (Vector)res;	 
				for(int ii=0;ii<tmp1.size();ii++){
					dataobj obj = (dataobj) tmp1.get(ii);
					
					out.println ("<Option Value='"+obj.getValue("pat_id")+"'>"+obj.getValue("pat_id")+"</OPTION>");
				}//for
			}//else
	}catch(Exception e){}
%>

	</Select>
		
		</TD>
	</TR>
	<TR>
		<TD><B>Start time</B></TD>
		<TD><INPUT TYPE="text" NAME="sttime" size=8 maxlength=8>
		<SELECT NAME="ampm">
			<option value=am selected>AM</option>
			<option value=pm>PM</option>
		</SELECT>
		<BR>(HH:MM:SS) 
		</TD>
	</TR>
	<TR>
		<TD><B>Duration &nbsp;</B></TD>
		<!-- <TD><INPUT name="dur" > </TD> -->
		<TD>
		<Select name=durhr>

		<%
			int i=0;
			
			while(i<=10)
			{
				if(i <= 9)
					out.println("<br><option value=0"+String.valueOf(i)+">0"+String.valueOf(i)+"</option>");
				else
					out.println("<br><option value="+String.valueOf(i)+">"+String.valueOf(i)+"</option>");
				
				i=i+1;
			}
		%>		

		</select> hr.
		<Select name=durmin>

		<%
			i=0;
			while(i<=59)
			{
				if(i <= 9)
					out.println("<br><option value=0"+String.valueOf(i)+">0"+String.valueOf(i)+"</option>");
				else
					out.println("<br><option value="+String.valueOf(i)+">"+String.valueOf(i)+"</option>");
				
				i=i+1;
			}
		%>		

		</select> min.
		
		</TD>
	</TR>
	<INPUT TYPE="hidden" name=type_used value="Video Conferencing">
		<TD><B>Date of Communication</B></TD>

		<INPUT TYPE="hidden" NAME="dated" value="<%=dat%>">
	<TR>
		<TD><B>Remote Center</B></TD>
		<TD>
			<SELECT NAME="rcenter">

	<%	
		try{
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
					Vector Vtmp = (Vector)res;
						for(int ii=0;ii<Vtmp.size();ii++){
							dataobj datatemp = (dataobj) Vtmp.get(ii);
								if(!center.equalsIgnoreCase(datatemp.getValue("code"))){
								out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option>");
								
								}
						} // end for
				}// end else
		}catch(Exception e){}
%>
		</SELECT>
		</TD>
	</TR>

	<TR>
		<TD>
			<B>Local Doctor's Name</B>
		</TD>
		<TD>
			<SELECT NAME="ldoc">
			<%	

		

		try{
				   String cnd="type='doc' AND upper(center)='"+center.toUpperCase()+"' and ACTIVE!='N' ORDER BY name ASC";
					
					Object res=rcui.getValues("name,rg_no",cnd);

					Vector tmp = (Vector)res;
					
					for(int ii=0;ii<tmp.size();ii++){
						dataobj temp = (dataobj) tmp.get(ii);	
						out.println ("<Option Value='"+temp.getValue("rg_no")+"'>"+temp.getValue("name")+"</OPTION>");
					}
				}catch(Exception e1){
					out.println("Error2 in :"+e1);
				}			

					
%>
		</SELECT>
		</TD>
	</TR>
	<TR>
		<TD><B>Remote Doctor's Name</B></TD>
		<TD><INPUT name="rdoc" size=21 maxlength=18 ><BR></TD>
	</TR>
	<TR>
		<TD><B>Comments</B></TD>
		<TD><CENTER><TEXTAREA cols=40 name="comments" rows=4></TEXTAREA></CENTER></TD>
	</TR>
	</TABLE>
</TD></TR>

</TABLE><BR>
<CENTER><INPUT type=submit value=Submit>&nbsp;&nbsp; <INPUT TYPE="Reset" value=Reset></CENTER>
</CENTER>
</FORM>
</BODY>
</HTML>
