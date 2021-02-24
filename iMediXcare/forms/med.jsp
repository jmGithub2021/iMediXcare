<%@page contentType="text/html" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>

<%
	//MyWebFunctions thisObj = new MyWebFunctions();

	String  referring_doc,ccode="";
	referring_doc = request.getParameter("reg");
	//ccode = thisObj.getCookieValue("center", request.getCookies());
%>
<HTML>
<HEAD>
<TITLE>PATIENTS DATA-MED FORM....
</TITLE>

<link rel="stylesheet" type="text/css" href="ckp.jsp">
<SCRIPT LANGUAGE="JavaScript" SRC="dkp.jsp">
</script>

<SCRIPT LANGUAGE="JavaScript">

//var error=0;

function chkblnk(fieldname,Label){
	var fdval=document.getElementById(fieldname).value;
	//alert(fdval);
	var temp=fdval.toString();
	//if(error==0)
	//{
	if(temp.length==0)
	{
		//error=1;
		document.getElementById(fieldname).focus();
		alert("The "+ Label +" field cannot be left blank");
		document.getElementById(fieldname).select();
		//error=0;
		return false;
	}
	//}
return true;
}


function putentrydate(){

if(!chkblnk("pat_name","Name"))
{ return false; }
if(!checkdigit('phone','phone'))
{ return false; }
if(!checkdigit('pin','pin'))
{ return false; }


if(document.med.type.value=='A'&& document.med.ageyy.value<19 )
	{	
	alert("An adult is above 18 years.");	
	return false;
	}

if(document.med.type.value=='E'&&(document.med.ageyy.value>18 || document.med.ageyy.value<12))
	{
	alert("A teen-ager is between 12 years to below 19 years.");	
	return false;
	}
	
if(document.med.type.value=='C'&&((document.med.ageyy.value>11 || document.med.ageyy.value<5)|| document.med.agemm.value>11))
	{
	alert("A child is between 5 years to below 12 years.");	
	return false;
	}

if(document.med.type.value=='T'&&((document.med.ageyy.value>4 ||document.med.ageyy.value<2)|| document.med.agemm.value>11 ))
	{
	alert("A todler is between 2 years to below 5 years.");	
	return false;
	}

if(document.med.type.value=='I'&&((document.med.agedd.value>29)||(document.med.agemm.value>23)||(document.med.agemm.value<1)))
	{
	alert("An infant is  from 1 month to below 2 years.");	
	return false;
	}

if(document.med.type.value=='N'&&(document.med.agedd.value>29 || document.med.agedd.value<1))
	{
	alert("An neonate is below 1 month.");	
	return false;
	}
//alert(document.med.type.value);
if(document.med.type.value=='A'|| document.med.type.value=='E'|| document.med.type.value=='T'|| document.med.type.value=='C')
{
//alert(document.med.ageyy.value);
	if(!chkblnk("ageyy","Year")) return false;
	if(!checkdigit("ageyy","Year")) return false;
}

if(document.med.type.value=='T'|| document.med.type.value=='C'|| document.med.type.value=='I')
{
//alert(document.med.agemm.value);
	if(!chkblnk("agemm","Month")) return false;
	if(!checkdigit("agemm","Month")) return false;
}
if(document.med.type.value=='N'|| document.med.type.value=='I')
{
//alert(document.med.agedd.value);
	if(!chkblnk("agedd","Day")) return false;
	if(!checkdigit("agedd","Day")) return false;
}

//merge the agedd,agemm,ageyy to create the age field
document.med.age.value=document.med.ageyy.value +","+document.med.agemm.value +","+ document.med.agedd.value;
//alert(document.med.age.value);


return true;
//return false;
}

function checkdigit(fdnam,label)
{
	var tnum,tmp,fdval;
	fdval = document.getElementById(fdnam).value
	//alert(fdval)
	for(i=0;i<fdval.length;i++)
	{
	 tmp=fdval.substring (i,i+1);
	tnum=parseInt(tmp);
	if (tnum>=0 && tnum<=9)
		continue;
	else {
		alert('Please enter Number in the '+label+' field');
		document.getElementById(fdnam).select();
		return false;
		}
	}
	return true;
}


function checkPositive(fdnam, num)
{
	var fdval;
	fdval = document.med.elements[num].value;
	if (parseInt(fdval) <= 0 ){
		alert(fdnam +" Entered is not a positive number");
		return false;
	}
	else 
	{ return true;}
}
function adjust()
{
	val =document.med.type.value;
	if(val=='A'|| val=='E')
	{
		document.med.ageyy.style.visibility="hidden";document.med.ageyy.value="";
		document.med.agemm.style.visibility="hidden";document.med.agemm.value="";
		document.med.agedd.style.visibility="hidden";document.med.agedd.value="";
		document.med.ageyy.style.visibility="";
	}
	if(val=="T"|| val=="C")
	{
		document.med.ageyy.style.visibility="hidden";document.med.ageyy.value="";
		document.med.agemm.style.visibility="hidden";document.med.agemm.value="";
		document.med.agedd.style.visibility="hidden";document.med.agedd.value="";
		document.med.ageyy.style.visibility="";
		document.med.agemm.style.visibility="";
	}
	if(val=="I")
	{
		document.med.ageyy.style.visibility="hidden";document.med.ageyy.value="";
		document.med.agemm.style.visibility="hidden";document.med.agemm.value="";
		document.med.agedd.style.visibility="hidden";document.med.agedd.value="";
		document.med.agemm.style.visibility="";
		document.med.agedd.style.visibility="";
	}
	if(val=="N")
	{
		document.med.ageyy.style.visibility="hidden";document.med.ageyy.value="";
		document.med.agemm.style.visibility="hidden";document.med.agemm.value="";
		document.med.agedd.style.visibility="hidden";document.med.agedd.value="";
		document.med.agedd.style.visibility="";
	}
}
function doit()
{
		document.med.ageyy.style.visibility="hidden";
		document.med.agemm.style.visibility="hidden";
		document.med.agedd.style.visibility="hidden";
		document.med.ageyy.style.visibility="";

}
function doc()
{
document.med.referring_doctor.value=document.med.comdoctor.options[document.med.comdoctor.selectedIndex].value;
}

</SCRIPT>
</HEAD>
<body onLoad='doit()' >
<%
String action = "..//jspfiles//genid.jsp";
//<%=action
%>
<FORM METHOD=Get ACTION="<%=action%>" name="med" onSubmit='return putentrydate();' >
<center><h3>PATIENT'S INFORMATION 
</h3></center>
<br>
<CENTER>

<TABLE ALIGN=center BORDER=1 CELLSPACING=0 CELLPADDING=0 >
<tr>
<td valign=top>
<table border=0 bordercolor=black>
<tr><td>NAME :</td><td><INPUT ID="pat_name" NAME="pat_name"  SIZE=20 maxlength=48></td></tr>



<tr><td>AGE GROUP :</td><td>
<SELECT name=type onChange="adjust();">
<option value=A> Adult </option>
<option value=E> Teen </option>
<option value=C> Child </option>
<option value=T> Toddler </option>
<option value=I> Infant </option>
<option value=N> Neonate </option>
</select>
</tr>


<tr>
<td>AGE :</td>

<td><INPUT ID="ageyy" NAME="ageyy" SIZE=3 maxlength =3 >Year&nbsp;&nbsp;
<INPUT ID="agemm" NAME="agemm" SIZE=3 maxlength =3 >Month&nbsp;&nbsp;
<INPUT ID="agedd" NAME="agedd" SIZE=3 maxlength = 3>Day</td>
</td>

</tr>
</table>

<INPUT TYPE="hidden" name="age" value="">

<!-- its a hidden field which will contain ageyy,agemm,agedd -->

</td>
<td valign=top>
<table border=0 bordercolor=black>

<tr><td>SEX :</td>
</td><td><Select NAME=sex ><option Value="M">Male</Option><option Value="F">Female</Option><option Value="O">Other</Option></Select></td></tr>


<tr><td>RELIGION :</td><td><INPUT TYPE="text" NAME="religion" size=10 maxlength=25>
<!-- <select NAME=religion>
<option>
<option>Hindu </option>
<option>Muslim </option>
<option>Sikh</option>
<option>Christian</option>
<option>Buddhist</option>
<option>Jain</option>
<option>Others</option>
</select>
 --></td></tr>

<tr>
<td>DISEASE TYPE :</td>
<td>
<SELECT name=class >

<%
try{
	rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
	Object depts = ddinfom.getDepartments(ccode);
	Vector deptsV = (Vector)depts;
	String options = "";
	for(int i=0;i<deptsV.size();i++){
		dataobj obj = (dataobj)deptsV.get(i);
		options += "<option value='"+obj.getValue("department_name")+"'>"+obj.getValue("department_name")+"</option>";
	}
/*FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
int i;
String strn1="";
do{
	i = fin.read();
	if((char) i != '\n')
		strn1 = strn1 + (char) i;
	else {
			strn1 = strn1.replaceAll("\n","");
		strn1 = strn1.replaceAll("\r","");
		out.println("<option value='" + strn1 + "'>" + strn1 + "</Option>");
		strn1="";
	}
}while(i != -1);
fin.close();*/
out.println(options);
}catch(Exception e){
System.out.println(e.toString());
}
/*
FileInputStream fin = new FileInputStream("//dis_category.txt");
int i;
String str="";
do{
	i = fin.read();
	if((char) i != '\n')
		str = str + (char) i;
	else {
		out.println("<option value='" + str + "'>" + str + "</Option>");
		str="";
	}
}while(i != -1);

fin.close();
*/
%>
</SELECT>
 </td> 

</tr>

<tr>
<td>Select Physician :</td>
<td>
<SELECT name="comdoctor" OnChange='doc();'>
<option value=NULL>select</option>
<%

/*
		Connection conn = null;
		Statement stmt = null;
		ResultSet RSet = null;
		String sqlQuery, uid="", dname="",reg="";
		int count=1;
		sqlQuery = "Select UID,NAME,RG_NO from LOGIN where upper(CENTER)='"+ccode.toUpperCase()+"' and TYPE = 'doc' and ACTIVE!='N'";
		try {
			Class.forName(gbldbjdbcDriver);
			conn = DriverManager.getConnection(gbldbURL, gbldbusername, gbldbpasswd);
			stmt = conn.createStatement();
			RSet=stmt.executeQuery(sqlQuery);
			while (RSet.next()) {
				uid = RSet.getString("UID");
				dname = RSet.getString("NAME");
				reg = RSet.getString("RG_NO");
				out.println("<Option value='" + reg + "'>"+dname+"</Option>");
				
			}
			RSet.close();
			conn.close();
			stmt.close();
		}
		catch (Exception e) {
			out.println("Error:<B>"+e+"</B>");
			
		}

*/

%>
</SELECT>
 </td> 

</tr>


<tr><td><INPUT TYPE="hidden" name=consent value=u></td></tr> <!-- y for yes, u for null n for no -->

</table>
</td>
</tr>
</TABLE></CENTER>			

<br></h3></P> 
<CENTER><TABLE ALIGN=center BORDER=1 CELLSPACING=0 CELLPADDING=0 >
<tr>
<td valign=top>
<table width=100%>
<TR><TD COLSPAN=2><h4><CENTER>Patient's Details</CENTER></h4></TD></TR>
<tr><td>ADDRESS :</td><td><input name=addline1 size=35 maxlength=48></td></tr>
<tr><td></td><td><input name=addline2 size=35 maxlength=48></td></tr>
<tr><td>POLICE Stn. :</td><td><input name=policestn size=35 maxlength=50></td></TR>
<TR><td>PHONE :</td><td><input ID="phone" name=phone size=15 maxlength=15></td></tr>
<tr><td>CITY :</td><td><input name=city size=30 maxlength=30></td></tr>
<tr><td>DISTRICT :</td><td><input name=dist size=25 maxlength=29></td></tr>
<tr><td>STATE :</td><td><input name=state  size=25 maxlength=29></td></tr>
<tr><td>COUNTRY :</td><td><input name=country  size=25 maxlength=29></td></tr>
<tr><td>PIN :</td><td><input ID="pin" name=pin size=10 maxlength=6></td></tr>

</table>
</td>
<td valign=top>
<table width=100% BORDER=0 BORDERCOLOR=BLACK>
<TR><TD COLSPAN=2><h4><CENTER>Contact Person Details</CENTER></h4></TD></TR>
<TR><TD>Name :</TD><TD><INPUT TYPE="text" NAME="pat_person" maxlength=45></TD></TR>
<TR><TD>Relation :</TD><TD><INPUT TYPE="text" NAME="pat_relation" maxlength=45></TD></TR>
<TR><TD>Address :</TD><TD><TEXTAREA NAME="pat_person_add" ROWS="4" COLS="25" wrap=virtual onkeypress='return txtlength(this,200)' onblur='chkpest(this,200)'></TEXTAREA></TD></TR>

<INPUT TYPE="hidden" name="referring_doctor" value="">
</td></TR>
<INPUT TYPE="hidden" name="dateofbirth" value="">
<INPUT TYPE="hidden" name="field1" value="">
<INPUT TYPE="hidden" name="field2" value="">
<INPUT TYPE="hidden" name="field3" value="">
<INPUT TYPE="hidden" name="field4" value="">
<INPUT TYPE="hidden" name="field5" value="">
<INPUT TYPE="hidden" name="serno" value="">




<tr><td><BR><BR><BR><BR></td></tr>
<TR><TD COLSPAN=2><CENTER><input type="submit" value="Submit" 
 style="background-color:'#D3CEC9'; color:'#000000'; font-weight:BOLD;">
&nbsp;&nbsp;&nbsp;
 <input type="reset" value="Reset"
 style="background-color:'#D3CEC9'; color:'#000000'; font-weight:BOLD;"></CENTER></TD></TR>


</table>
</td></tr>
</TABLE>
</CENTER>			
</FORM>
</BODY>
</HTML>
