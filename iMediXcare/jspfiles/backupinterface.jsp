<%@page contentType="text/html" import="imedix.rcUserInfo,imedix.rcCentreInfo, imedix.dataobj, imedix.cook,java.util.*, java.net.*,java.text.*,java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<HTML>
<%     
		
	int c_dd=0,c_mm=0,c_yy=0;	
	Date dt = new Date();
	int dd=0,mm=0,yy=0,x=0,styy=0;
	String val="",dname="",regcode="";
	c_dd = dt.getDate();
	c_mm= dt.getMonth()+1;
	c_yy = dt.getYear() + 1900;
	String mon[]={"January","February","March","April","May","June","July","August","September","October","November","December"};
	rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
	
	cook cookx = new cook();
	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());


	%>


<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
   
<TITLE>Data Archival</TITLE>
<SCRIPT LANGUAGE="JavaScript">

$(document).ready(function(){
	$("div#a").show();
    $("div#b").hide();
 $("div#a").show();
    $("div#b").hide();
    $("#bydate").click(function(){
        $("div#a").show();
        $("div#b").hide();
    });
    $("#bypat").click(function(){
        $("div#a").hide();
        $("div#b").show();
    });
});

var selayer;
selayer="bydate";
function settings()
{
	$(document).ready(function(){
	$("div#a").show();
    $("div#b").hide();
	});
}
/*
function display(lay)
{
	document.getElementById(lay).style.visibility="visible";
	document.getElementById(selayer).style.visibility="hidden";
	selayer = lay;
}
*/
function chkdate(m,d,y)
{
	var ret,ud,um,uy;
	//alert(today);
	if( m  < 10) m = '0' + m;
	if( d  < 10) d = '0' + d;
	//alert(m);
	//alert(document.daterange.stmm.value);
	
	if ((document.daterange.stdd.value == d) && (document.daterange.stmm.value == m) &&(document.daterange.styy.value == y) )
	{	alert("Today's date not allowed in 'Start From'"); return false; }
	
	if ((document.daterange.updd.value == d) && (document.daterange.upmm.value == m) &&(document.daterange.upyy.value == y) )
	{	alert("Today's date not allowed in 'Up To'"); return false; }

	// if the date entered is more than current date
	
	ud = document.daterange.stdd.value;
	um = document.daterange.stmm.value;
	uy = document.daterange.styy.value;
	ret = validdate(ud,um,uy);
	if (ret == true)
		ret = morethantoday(m,d,y,um,ud,uy,'Start From');
	else
		return false;
	
	if( ret == true)
	{
			ud = document.daterange.updd.value;
			um = document.daterange.upmm.value;
			uy = document.daterange.upyy.value;
			ret = validdate(ud,um,uy)
			if (ret == true)
				return (morethantoday(m,d,y,um,ud,uy,'Up To'));
			else
				return false;
	}
	else
		return false;
	
	return true;
}
function validdate(ud,um,uy)
{
	var yr;
	switch (um)
	{
	case "02":
		yr=uy%4;
		if(ud==29&&yr!=0){window.alert('This Year is not a leap year'); return false;}
		if(ud>29) {window.alert('February have not more than 29 days except leap year'); return false;}
	case "04":
		if(ud==31){window.alert('In April Date 31 is not present'); return false;}
	case "06":
		if(ud==31){window.alert('In June Date 31 is not present'); return false;}
	case "09":
		if(ud==31){window.alert('In September Date 31 is not present'); return false;}
	case "11":
		if(ud==31){window.alert('In November Date 31 is not present'); return false;}
	}

	return true;
}

 function morethantoday(cm,cd,cy,um,ud,uy,v)
{
if( uy > cy)
	{ alert("Future date not allowed in '"+v+"' "); return false; }
else 
{	if (uy == cy && um > cm) 
	{alert("Future date not allowed '"+v+"' "); return false;}
	else
	{
		if (uy == cy && um == cm && ud > cd)
		{alert("Future date not allowed '"+v+"'"); return false;}
	}
}
	return true;
}

function chkpatid(m,d,y)
{
	var patid,num,i,um,ud,uy;
	patid = document.selectpat.patid.value

	// id len should be 14
	if(patid.length <= 14 && patid.length>18)
		{ alert("Improper ID"); document.selectpat.patid.select(); return false; }
	// first three char should be character
	if(!(patid.substring(0,1).toUpperCase() >='A' && patid.substring(0,1).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	//alert(patid.substring(1,2).toUpperCase());
	if(!(patid.substring(1,2).toUpperCase() >='A' && patid.substring(1,2).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	if(!(patid.substring(2,3).toUpperCase() >='A' && patid.substring(2,3).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	if(!(patid.substring(3,4).toUpperCase() >='A' && patid.substring(2,3).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	
	for(i=5;i<patid.length;i++) 
	{
		//alert(patid.substring(i,i+1));
		if(patid.substring(i,i+1)>='0' && patid.substring(i,i+1)<='9') continue;
		else {alert("Improper ID"); return false;}
	}

return true;
}
</SCRIPT>

</HEAD>

<!--<body bgcolor="#FAF5F5" onload='settings();'>-->
	<BODY background="../images/txture.jpg" >
		<div class="container-fluid">
		
		<TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>BACKUP UTILITY</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
		</TABLE>

<br><div class="container">
<center><span style="color:#0000FF">Specify the filtering criteria :</span></center>
<div class="row">
<div class="col-sm-2"></div>

<div class="col-sm-8">

<div class="input-group">
<span class="input-group-addon"><INPUT class="form-control input-sm" TYPE="radio" NAME="choption" value='pat' id="bypat" style="width:25%"/>&nbsp;<strong>A Patient</strong></span>
<span class="input-group-addon"><INPUT class="form-control input-sm" TYPE="radio" NAME="choption" value='date' id="bydate"  style="width:25%" checked/>&nbsp;<strong>Date Range</strong></span>
</div>		<!-- "input-group" -->
	

<div class="row">	
<div class="col-sm-12" id="a">


<FORM role="form" METHOD="get" ACTION="filefromdb_bakup.jsp" name="daterange" >
		<U><FONT COLOR="#DD6F00"><B>Date Range</B></FONT></U>
		<BR><BR><TABLE class="table" bordercolor=GREEN>
		<TR>
			<TD><B>Start From:</B> </TD>
			<TD>
			<SELECT class="form-control" NAME="stdd" color=GREEN>
			<%
				 for(dd = 1;dd<=31;dd++)
				{  
					val=String.valueOf(dd);
					if(dd < 10)
					{
						val = "0"+String.valueOf(dd);
					}
					
					if(c_dd==dd)
					{
						out.println("<option selected value="+val+">"+val+"</option>");
					}
					else
					{
						out.println("<option value="+val+">"+val+"</option>");
					}
					
				}
				
			%>
			</SELECT>
			</TD>
			<TD>
			<SELECT class="form-control" NAME="stmm">
			<%
				   for(x = 0;x<= 11;x++)
				{  
				val = String.valueOf(x+1);
					if(x < 9)
					{
						val = String.valueOf(x + 1);
						val = "0"+val;
					}
					
					if((c_mm - 1) == x) {
						out.println("<option selected value="+val+">"+mon[x]+"</option>");
					}
					else
					{
						out.println("<option value="+val+">"+mon[x]+"</option>");
					}
				} 

					
			%>
			</SELECT>
			</TD>
			<TD>
			<SELECT class="form-control" NAME="styy" >
			<%
				  for(yy = 1995; yy<=c_yy;yy++)  
				   {	
					if (c_yy == yy)
						out.println("<option selected value="+yy+">"+yy+"</option>");
					else
						out.println("<option value="+yy+">"+yy+"</option>");
						
					} 
				
			%>
			</SELECT>
			</TD>

			</TR>
			<TR>
			<TD><B>Up To:</B></TD>
			<TD>
			<SELECT class="form-control" NAME="updd" >
			<%
				 for(dd = 1;dd<=31;dd++)
				{  
					val=String.valueOf(dd);
					if(dd < 10)
						val = "0"+String.valueOf(dd);
					if(c_dd == dd)
						out.println("<option selected value="+val+">"+val+"</option>");
					else
						out.println("<option value="+val+">"+val+"</option>");
					
				} 
				
			%>
			</SELECT>
			</TD>
			<TD>
			<SELECT class="form-control" NAME="upmm">
			<%
				 for(x = 0;x<=11;x++)
				{  
				val =String.valueOf(x+1);
					if(x < 9) 
					{
						val = String.valueOf(x + 1);
						val = "0"+val;
					}
					if((c_mm - 1) == x)
						out.println("<option selected value="+val+">"+mon[x]+"</option>");
					else
						out.println("<option value="+val+">"+mon[x]+"</option>");
					
				} 
				 
			%>
			</SELECT>
			</TD>
			<TD>
			<SELECT class="form-control" NAME="upyy" >
			<%
				  for(yy = 1995;yy<=c_yy;yy++)
				{				
					if (c_yy == yy) 
					
						out.println("<option selected value="+yy+">"+yy+"</option>");
					else
						out.println("<option value="+yy+">"+yy+"</option>");
					
				} 
				
			%>
			</SELECT>
			</td>
			</tr>
			
			<tr>
				<td>
					<B>Center Code : </B>
				</td>
				<td colspan=3>
				
					<SELECT class="form-control" NAME="ccode">
					<%	
					
					if(ccode.equals("XXXX")){
						try
							{
								Object res=cinfo.getAllCentreInfo();
								if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
								else{
									Vector Vtmp = (Vector)res;
										for(int i=0;i<Vtmp.size();i++){
										dataobj datatemp = (dataobj) Vtmp.get(i);
										

										out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
									
									//out.println ("<Option Value='"+RSet.getString("CODE")+"'>"+RSet.getString("CODE")+"</OPTION>");
									
										} // end for
								}// end else
							}
							catch(Exception e)
							{
								out.println("error.."+e.getMessage());
							}
					 }else{
						out.println("<option value="+ccode+">"+cname+"</option><br>");
									
					 }
					%>
					</SELECT>
				</td>
			</tr>
		<tr>
		<td colspan=4>
		<INPUT TYPE="hidden" name=bkptype value="bydate">
		<CENTER><INPUT class="form-control btn-info" TYPE="submit" value="Submit" onclick="return chkdate('<%=c_mm%>','<%=c_dd%>','<%=c_yy%>')" style="background-color: '#844242'; color: blue; font-weight:BOLD; font-style:oblique " width=5></CENTER>
		</td>
		</tr>
		</table>
		</FORM>


</div>		<!-- "col-sm-12" -->
<div class="col-sm-12" id="b">


<FORM role="form" METHOD="get" ACTION="filefromdb_bakup.jsp" name="selectpat">
		<U><FONT COLOR="#DD6F00"><B>A Patient</B></FONT><A class="btn btn-warning pull-right" HREF="jobadmin.jsp">Back</A></U>
		
					<br><br><INPUT class="form-control" TYPE="text" NAME="patid" maxlength=18 placeholder="Patient ID" /><br>
				
					<SELECT class="form-control" NAME="ccode">
					<%	
					
					
					try
						{
							Object res=cinfo.getAllCentreInfo();
							if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
							else{
								Vector Vtmp = (Vector)res;
									for(int i=0;i<Vtmp.size();i++){
									dataobj datatemp = (dataobj) Vtmp.get(i);
									out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
								
								//out.println ("<Option Value='"+RSet.getString("CODE")+"'>"+RSet.getString("CODE")+"</OPTION>");
								
									} // end for
							}// end else
						}
						catch(Exception e)
						{
							out.println("error.."+e.getMessage());
						}
						
					%>
					</SELECT><br>
		
			<INPUT TYPE="hidden" name=bkptype value="bypat">
			<CENTER><INPUT class="form-control btn-info" TYPE="submit" value="Submit" onclick="return chkpatid('<%=c_mm%>','<%=c_dd%>','<%=c_yy%>')" style="background-color: '#844242'; color: blue; font-weight:BOLD; font-style:oblique "></CENTER>

		</FORM>


</div>		<!-- "col-sm-12" -->
</div>		<!-- "row(inner)" -->		

	
</div>		<!-- "col-sm-8" -->
<div class="col-sm-2"> </div>		<!-- "col-sm-2">
</div>		<1-- "row" -->

</div>		<!-- "container" -->
</body>
</html>
