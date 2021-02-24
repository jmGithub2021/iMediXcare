<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.medinfo,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj,imedix.rcGenOperations,imedix.myDate, imedix.rcDisplayData,imedix.cook, imedix.myDate,java.util.*,java.io.*" %>

<%
	
String allfields="",qr="",str="",dat="",qr1="",dt="";
String present_status="YES", refdoc="";
String ag="",astr="",atyp="";
String mser="",pname="",mcls="",msex="",mreg="",madd1="",madd2="",mpstn="",mphn="",mcity="",mdis="";
String mstate="", mcon="",mpin="",mpper="",mprela="",mpadd="",mrace="",mm_status="",mcaste_category="";
String mpersidtype="", mpersidvalue="";

rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
medinfo minfo = new medinfo(request.getRealPath("/"));
rcCentreInfo rcn = new rcCentreInfo(request.getRealPath("/"));
	rcGenOperations rcGen=new rcGenOperations(request.getRealPath("/"));
cook cookx = new cook();

//String id = request.getParameter("id");
String id = cookx.getCookieValue("patid", request.getCookies());
String ccode =cookx.getCookieValue("center", request.getCookies ());
//String pat_ccode=id.substring(0,4);
String pat_ccode=rcn.getCenterCode(id,"med");
/////////////////////////////////////
try{
	dataobj temp=null;
	Object res=ddinfo.DisplayMed(id,"","");
	if(res instanceof String){
		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			temp = (dataobj) tmp.get(0);
			
			mser=(temp.getValue("serno") == null) ? "":temp.getValue("serno");
			
			pname=(temp.getValue("pre") == null) ? "":minfo.getAppellationValues().getValue(temp.getValue("pre"));
			String fnm=(temp.getValue("pat_name") == null) ? "":temp.getValue("pat_name");
			String mnm=(temp.getValue("m_name") == null) ? "":temp.getValue("m_name");
			String lnm=(temp.getValue("l_name") == null) ? "":temp.getValue("l_name");
			pname = pname + " " + fnm+" "+ mnm+" "+lnm;
			
			mcls=(temp.getValue("class") == null) ? "":temp.getValue("class");
			msex=(temp.getValue("sex") == null) ? "":temp.getValue("sex");
			mcaste_category=(temp.getValue("caste_category") == null) ? "":temp.getValue("caste_category");
			mpersidtype=(temp.getValue("persidtype") == null) ? "":temp.getValue("persidtype");
			mpersidvalue=(temp.getValue("persidvalue") == null) ? "":temp.getValue("persidvalue");

			mreg=(temp.getValue("religion") == null) ? "":minfo.getReligionValues().getValue(temp.getValue("religion"));
			madd1=(temp.getValue("addline1") == null) ? "":temp.getValue("addline1");
			madd2=(temp.getValue("addline2") == null) ? "":temp.getValue("addline2");
			mpstn=(temp.getValue("policestn") == null) ? "":temp.getValue("policestn");
			mphn=(temp.getValue("phone") == null) ? "":temp.getValue("phone");
			mcity=(temp.getValue("city") == null) ? "":temp.getValue("city");
			mdis=(temp.getValue("dist") == null) ? "":minfo.getDistrictValues().getValue(temp.getValue("dist"));
			mstate=(temp.getValue("state") == null) ? "":temp.getValue("state");
			mcon=(temp.getValue("country") == null) ? "":temp.getValue("country");
			mpin=(temp.getValue("pin") == null) ? "":temp.getValue("pin");
			mpper=(temp.getValue("pat_person") == null) ? "":temp.getValue("pat_person");
			mprela=(temp.getValue("pat_relation") == null) ? "":temp.getValue("pat_relation");
			mpadd=(temp.getValue("pat_person_add") == null) ? "":temp.getValue("pat_person_add");
			refdoc=(temp.getValue("referring_doctor") == null) ? "":temp.getValue("referring_doctor");
			ag=temp.getValue("age");
			dat = temp.getValue("entrydate");
			atyp=temp.getValue("type");
			atyp=minfo.getAgeValues().getValue(atyp);

			mrace=temp.getValue("race");
			mm_status=temp.getValue("m_status");
		}
	}
	
	//out.println("yidsgfudsghfuh :"+ag);
	
/*	String ages[]=ag.split(",",3);
	if(!ages[2].equals(""))
	str=ages[2].trim() +" days";

	if(!ages[1].equals(""))
	str=ages[1].trim() +" months "+str;

	if(!ages[0].equals(""))
	str=ages[0].trim()+" years "+str;*/
						
	String cdat = myDate.getCurrentDate("ymd",true);				
	str=rcGen.getPatientAgeYMD(id,cdat);	
	// registration date
	String mm="",dd="";
	int m=0,d=0;
	m=Integer.parseInt(myDate.datePart("m",dat));
	d=Integer.parseInt(myDate.datePart("d",dat));
	if(m<10)
	mm="0"+String.valueOf(m);
	else
	mm=String.valueOf(m);
	if(d<10)
	dd="0"+String.valueOf(d);
	else
	dd=String.valueOf(d);
	dt=dd+"-"+mm+"-"+myDate.datePart("y",dat);


	}catch(Exception e)
	{
		out.println("Error1 in :"+e.toString());
	}


/////////////////////////////////////////

%>


<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<TITLE> New Document </TITLE>

<%if(present_status.equals("YES")){ //whether patient details will be shown or not
%>
<link rel="stylesheet" href="../style/style2.css" type="text/css" media="screen" />

<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.jsp"> </SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script2.jsp"> </SCRIPT>

<SCRIPT LANGUAGE="JavaScript">

function chkblnk(fieldname) {
	var fdval=document.cmed[fieldname].value
	//alert(document.cmed.elements[num].name);
	var temp=fdval.toString()
	if(temp.length==0 ) {
		document.cmed[fieldname].focus();
		alert("The " + fieldname +" is Invalid")
		document.cmed[fieldname].select();
		return false;
	}		
	return true;
}

function checkdigit(fdnam)
{
	var tnum,tmp,fdval;
	fdval = document.cmed[fdnam].value
	for(i=0;i<fdval.length;i++)
	{
	 tmp=fdval.substring (i,i+1); 
	tnum=parseInt(tmp); 
	if (tnum>=0 && tnum<=9) 
		continue; 
	else { 
		alert('Please enter Number in the field'); 
		document.cmed[fdnam].select();
		return false; 
		} 
	} 
	return true;
}

function validate() {
if(!checkdigit("pin")) return false;
//if(!chkblnk("pin")) return false;
if(!checkdigit("phone")) return false;
//if(!chkblnk("phone")) return false;

return true;
}
</SCRIPT>
<%}%>

</HEAD>

<BODY bgcolor="#FFFFF">

<div class="container-fluid">

<FORM METHOD=get ACTION="saveeditmed.jsp" name=cmed onSubmit='return validate();'>

<!-- <INPUT TYPE="hidden" name=entrydate value=<%=dat%>> -->
<CENTER>

<BR><FONT SIZE="+1" COLOR="#333300"><U><B>Edit Patient's Information</B></U></FONT>


<div class="row tableb">

<div class="col-sm-6">
<div class="table-responsive">
		<table class="table table-hover">
	<tr><td><B><FONT  COLOR="#330000">Patient name :</FONT></td>
		<TD><FONT COLOR="RED"><%=pname.trim()%></FONT></TD></tr>
			<INPUT TYPE="hidden" name=serno value="<%=mser.trim()%>">
			<INPUT TYPE="hidden" name=pat_id value="<%=id%>">		

	<tr><td><B><FONT  COLOR="#330000">Referred by <I>Dr.</I></b></FONT></td>
		<td><SELECT class="form-control" name=referring_doctor >
				<%
				try{
				   String cnd="type='doc' AND upper(center)='"+pat_ccode.toUpperCase()+"' and ACTIVE!='N' ORDER BY name ASC";
					
					Object res=uinfo.getValues("name,rg_no",cnd);

					Vector tmp = (Vector)res;
					out.println("<option style='color:RED' value='NULL' >&nbsp;&nbsp;&nbsp;&nbsp;</option>");

					for(int i=0;i<tmp.size();i++){
						dataobj temp = (dataobj) tmp.get(i);	
						if(temp.getValue("rg_no").equals(refdoc) && !refdoc.equals("")){
								out.println("<option style='color:GREEN' value='"+refdoc+"' selected>"+temp.getValue("name")+"</option>");
						}else{
								out.println("<option style='color:RED' value='"+temp.getValue("rg_no")+"' >"+temp.getValue("name")+"</option>");
						}
					}
				}catch(Exception e1){
					out.println("Error2 in :"+e1);
				}					
			%>
		</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-6" -->


<div class="col-sm-6">
<div class="table-responsive">
		<table class="table table-hover">
		<tr><td>&nbsp;</td><td></td></tr>
		<tr><td><B><FONT  COLOR="#330000">Reg. Date :</td><td><FONT COLOR="RED"><%=dt%></font></td></tr>
		</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-6" -->

</div>		<!-- "row" -->



<div class="row tableb">

<div class="col-sm-6">
<div class="table-responsive">	
	<TABLE class="table table-hover">
			<tr><td>Patient ID :</td><TD><FONT COLOR="RED"><%=id.toUpperCase()%></FONT>
			</TD></tr>
			<tr><td>Age group :</td><td><FONT COLOR="RED"><%=atyp.toLowerCase()%></font></td></tr>


			<tr><td>Age :</td><TD><FONT COLOR="RED"><%=str%>&nbsp;</FONT>&nbsp;&nbsp;</TD>
			<!-- <INPUT TYPE="hidden" name=age value="<%=ag.trim()%>"></tr> -->
			
			<tr><td>Sex :</td></td><TD><FONT COLOR="RED"><%=minfo.getSexValues().getValue(msex)%></FONT></TD>
			<tr><td>Caste :</td><td>
			<SELECT class="form-control" name=caste_category> 
			<%  FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/caste.txt");
				int ip;
				String str1="";
				do{
					ip = fin.read();
					if((char) ip != '\n') str1 = str1 + (char) ip;
					else {
						str1 = str1.replaceAll("\n","");
						str1 = str1.replaceAll("\r","");
						str1=str1.trim();
						String[] parts = str1.split(">");
						if(parts[0].equalsIgnoreCase(mcaste_category.trim()))
						{
						out.println("<option style='color:GREEN'value='"  + parts[0] + "' selected >" + parts[1] + "</Option>");
						}
						else
						{
						out.println("<option style='color:RED'value='"  + parts[0] + "'>" + parts[1] + "</Option>");
						}
					str1="";
				  	}
				  }while(ip != -1);

				fin.close();	


				%>
			</SELECT>
			</td></TR>

			<!-- <INPUT TYPE="hidden" name=sex value="<%=msex.trim()%>"></tr> -->
			</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-6" -->
		
		
		
<div class="col-sm-6">
<div class="table-responsive">		
			<table class="table table-hover">
			<tr><td>Religion :</td><td><FONT COLOR="RED"><%=mreg.trim()%></FONT></td>
			<!-- <INPUT TYPE="hidden" name=religion value="<%=mreg.trim()%>"></tr> -->
			
			<!-- <tr><td>Marital Status :</td><td><%=mm_status.trim()%></td>
			<INPUT TYPE="hidden" name=m_status value="<%=mm_status.trim()%>"></tr> -->
			
			<tr><td>Marital Status :</td><td><SELECT class="form-control" name=m_status>
			<%
				dataobj temp = minfo.getMaritalValues();
				for(int i=0 ; i<temp.getLength();i++){
					if(temp.getKey(i).equals(mm_status.trim()) && !mm_status.equals("")){
						out.println("<option style='color:GREEN' value='"+temp.getKey(i)+"' selected>"+temp.getValue(i)+"</option>");
					}else{
					out.println("<option style='color:RED' value='"+temp.getKey(i)+"'>"+temp.getValue(i)+"</option>");
					}

				}
			%>
			</SELECT></TD></TR>

			<!-- <tr><td>Race :</td><td><FONT COLOR="RED"><%=mrace.trim()%></FONT></td> -->
			<!-- <INPUT TYPE="hidden" name=race value="<%=mrace.trim()%>"></tr> -->

			 <!--<tr><td>Race :</td><td><SELECT class="form-control" name=race> 
			<%
				temp = minfo.getRaceValues();
				for(int i=0 ; i<temp.getLength();i++){
					if(temp.getKey(i).equals(mrace.trim()) && !mrace.equals("")){
						out.println("<option style='color:GREEN' value='"+temp.getKey(i)+"' selected>"+temp.getValue(i)+"</option>");
					}else{
					out.println("<option style='color:RED' value='"+temp.getKey(i)+"'>"+temp.getValue(i)+"</option>");
					}

				}
				
			%>

			</SELECT></td></tr>-->

			
			<!--<tr><td>Disease type :</td><TD><SELECT class="form-control" name=class> 
			<%  fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
				int i;
				str1="";
				do{
					i = fin.read();
					if((char) i != '\n') str1 = str1 + (char) i;
					else {
						str1 = str1.replaceAll("\n","");
						str1 = str1.replaceAll("\r","");
						str1=str1.trim();
						if(str1.equalsIgnoreCase(mcls.trim()))
						{
						out.println("<option style='color:GREEN'value='"  + str1 + "' selected >" + str1 + "</Option>");
						}
						else
						{
						out.println("<option style='color:RED'value='"  + str1 + "'>" + str1 + "</Option>");
						}
					str1="";
				  	}
				  }while(i != -1);

				fin.close();	


				%>
			</SELECT></TD></TR>-->
			
<tr><td>Personal-ID Type :</td><TD><SELECT class="form-control" name=persidtype> 
			<%  fin = new FileInputStream(request.getRealPath("/")+"jsystem/persidtype.txt");
				//int i;
				str1="";
				do{
					i = fin.read();
					if((char) i != '\n') str1 = str1 + (char) i;
					else {
						str1 = str1.replaceAll("\n","");
						str1 = str1.replaceAll("\r","");
						str1=str1.trim();
						String[] parts = str1.split(">");
						if(parts[0].equalsIgnoreCase(mpersidtype.trim()))
						{
						out.println("<option style='color:GREEN'value='"  + parts[0] + "' selected >" + parts[1] + "</Option>");
						}
						else
						{
						out.println("<option style='color:RED'value='"  + parts[0] + "'>" + parts[1] + "</Option>");
						}
					str1="";
				  	}
				  }while(i != -1);

				fin.close();	


				%>
			</SELECT></TD></TR>
<tr><td>Personal-ID Details :</td><TD><INPUT class="form-control input-sm" name=persidvalue size=30 maxlength=48 value="<%=mpersidvalue.trim()%>" style='color:GREEN'></TD></TR>			
						
			
			
			
			
			
			</table>
</div>		<!-- "table-responsive" -->
</div>		<!-- "col-sm-6" -->

</div>		<!-- "row" -->





<%if(present_status.equals("YES")) { // whether patient details will be shown or not %>


		
<div class="row tableb">		
		
		<div class="col-sm-6">
		<div class="table-responsive">
			<table class="table table-hover">
			<TR><TD COLSPAN=2><h4><CENTER>Patient's Details</CENTER></h4></TD></TR>

			<tr><td>Address :</td><td><INPUT class="form-control input-sm" name=addline1 size=30 maxlength=48 value="<%=madd1.trim()%>" style='color:GREEN'></td></tr>

			<tr><td></td><td><INPUT class="form-control input-sm" name=addline2 size=30 maxlength=48 value="<%=madd2.trim()%>" style='color:GREEN'></td></tr>

			<tr><td>Police Stn.:</td><td><INPUT class="form-control input-sm" name=policestn size=30 maxlength=50 value="<%=mpstn.trim()%>" style='color:GREEN'></td></TR>

			<TR><td>Phone :</td><td><INPUT class="form-control input-sm" name=phone size=15 maxlength=15 value="<%=mphn.trim()%>" style='color:GREEN'></td></tr>

			<tr><td>City :</td><td><INPUT class="form-control input-sm" name=city size=30 maxlength=30 value="<%=mcity.trim()%>" style='color:GREEN'></td></tr>

			<tr><td>District :</td><td><INPUT class="form-control input-sm" name=dist size=30 maxlength=29 value="<%=mdis.trim()%>" style='color:GREEN'></td></tr>

			<!-- <tr><td>State :</td><td><INPUT class="form-control input-sm" name=state maxlength=29 value="<%=mstate.trim()%>" style='color:GREEN'></td></tr> -->


			<tr><td>State :</td><td><SELECT class="form-control input-sm" name=state>
			<%
				temp = minfo.getStateValues();
				for(i=0 ; i<temp.getLength();i++){
					if(temp.getKey(i).equals(mstate.trim()) && !mstate.equals("")){
						out.println("<option style='color:GREEN' value='"+temp.getKey(i)+"' selected>"+temp.getValue(i)+"</option>");
					}else{
					out.println("<option style='color:RED' value='"+temp.getKey(i)+"'>"+temp.getValue(i)+"</option>");
					}

				}
			%>
			</SELECT></TD></TR>

			<!-- <tr><td>Country :</td><td><INPUT class="form-control" name=country maxlength=29 value="<%=mcon.trim()%>" style='color:GREEN'></td></tr> -->

			<tr><td>Country :</td><td><SELECT class="form-control" name=country>
			<%
				temp = minfo.getCountryValues();
				for(i=0 ; i<temp.getLength();i++){
					if(temp.getKey(i).equals(mcon.trim()) && !mcon.equals("")){
						out.println("<option style='color:GREEN' value='"+temp.getKey(i)+"' selected>"+temp.getValue(i)+"</option>");
					}else{
					out.println("<option style='color:RED' value='"+temp.getKey(i)+"'>"+temp.getValue(i)+"</option>");
					}

				}
			%>
			</SELECT></TD></TR>
			<tr><td>Pin :</td><td><INPUT class="form-control" name=pin maxlength=6 value="<%=mpin.trim()%>" style='color:GREEN'></td></tr>
			</table>
		</div>		<!-- "table-responsive" -->	
		</div>		<!-- "col-sm-6" -->	
			
			
<div class="col-sm-6">			
		<div class="table-responsive">
			<table class="table table-hover">
			<TR><TD COLSPAN=2><h4><CENTER>Contact Person Details</CENTER></h4></TD></TR>
			<TR><TD>Name :</TD><TD><INPUT class="form-control" TYPE="text" NAME="pat_person" size=35 maxlength=45 value="<%=mpper.trim()%>"></TD></TR>
			<TR><TD>Relation :</TD><TD><INPUT class="form-control" TYPE="text" NAME="pat_relation" size=35 maxlength=45 value="<%=mprela.trim()%>"></TD></TR>
			<TR><TD>Address :</TD><TD><TEXTAREA class="form-control" NAME="pat_person_add" ROWS="4" COLS="26" wrap=virtual onkeypress='return txtlength(this,200)' onblur='chkpest(this,200)'><%=mpadd.trim()%></TEXTAREA></TD></TR>



	<TR><TD colspan=2><center><INPUT class="btn btn-default" TYPE="submit" Value="Change" style="background-color:DARKGREEN; color: WHITE; font-weight:BOLD; "></center></TD></TR>

			</table>
		</div>		<!-- "table-responsive" -->
</div>		<!--"col-sm-6" -->

</div>		<!-- "row" -->	
	<%}%>
			

</form>


</div>		<!-- "container-fluid" -->
</BODY>
</HTML>
