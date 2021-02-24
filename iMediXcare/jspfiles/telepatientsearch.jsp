<%@page contentType="text/html" import= "imedix.rcCentreInfo,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*"%>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<HTML>
<% 
  String cb=request.getParameter("cb");
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

%>
<HTML>

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
	if(patid.length != 14)
		{ alert("Improper ID"); document.selectpat.patid.select(); return false; }
	// first three char should be character
	if(!(patid.substring(0,1).toUpperCase() >='A' && patid.substring(0,1).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	//alert(patid.substring(1,2).toUpperCase());
	if(!(patid.substring(1,2).toUpperCase() >='A' && patid.substring(1,2).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	if(!(patid.substring(2,3).toUpperCase() >='A' && patid.substring(2,3).toUpperCase()<='Z') )
		{ alert("Improper ID"); return false; }
	// chk the date part it should be less than 31
	num= parseInt(patid.substring(3,4)) * 10 ;
	num=num + parseInt(patid.substring(4,5));
	ud=num;
	//alert(ud);
	if(num > 31) { alert("Improper ID"); return false; }
	
	// chk the month part it should be more than 12
	num= parseInt(patid.substring(5,6)) * 10 ;
	num=num + parseInt(patid.substring(6,7));
	um=num;
	//alert(um);
	if(num > 12) { alert("Improper ID"); return false; }
	//else alert("I am here");
	uy= ( parseInt(patid.substring(7,8))*1000)+( parseInt(patid.substring(8,9))*100)+( parseInt(patid.substring(9,10))*10)+( parseInt(patid.substring(10,11)))
	//alert(uy);
	//if the patient entry is made today then backup cannot be taken
	
	if ( (ud == d) && (um == m) && (uy == y) )
	{	alert("Today's Patient not allowed"); return false; }
	

	for(i=7;i<patid.length;i++) 
	{
		//alert(patid.substring(i,i+1));
		if(patid.substring(i,i+1)>='0' && patid.substring(i,i+1)<='9') continue;
		else {alert("Improper ID"); return false;}
	}

return true;
}

function validate()
{
	var rad;
	var dd,mm,yy,res;
	if (document.serpat.R1[0].checked == true) {
		rad = document.serpat.R1[0].value ;
		if (document.serpat.id.value.length ==0 ) {
			alert ("Field [" + rad + "] is blank!");
			document.serpat.id.focus();
			return false;
		}
	}
	if (document.serpat.R1[1].checked == true) {
		rad = document.serpat.R1[1].value ;
		if (document.serpat.name.value.length ==0 ) {
			alert ("Field [" + rad + "] is blank!");
			document.serpat.name.focus();
			return false;
		}
	}
	if (document.serpat.R1[3].checked == true) {
		rad = document.serpat.R1[3].value ;
		dd=document.serpat.day.value;
		mm=document.serpat.month.value;
		yy=document.serpat.year.value;
		res=validdate(dd,mm,yy);
		if(res==false)
		{
			document.serpat.day.focus();
			return false;
		}
	}
	return true;
}

function Tvalidate()
{
	var rad;
	var dd,mm,yy,res;
	if (document.teleserpat.TR1[0].checked == true) {
		rad = document.teleserpat.TR1[0].value ;
		if (document.teleserpat.Tid.value.length ==0 ) {
			alert ("Field [" + rad + "] is blank!");
			document.teleserpat.Tid.focus();
			return false;
		}
	}
	if (document.teleserpat.TR1[1].checked == true) {
		rad = document.teleserpat.TR1[1].value ;
		if (document.teleserpat.Tname.value.length ==0 ) {
			alert ("Field [" + rad + "] is blank!");
			document.teleserpat.Tname.focus();
			return false;
		}
	}

	if (document.teleserpat.TR1[3].checked == true) {
		rad = document.teleserpat.TR1[3].value ;
		dd=document.teleserpat.Tday.value;
		mm=document.teleserpat.Tmonth.value;
		yy=document.teleserpat.Tyear.value;
		res=validdate(dd,mm,yy);
		if(res==false)
		{
			document.teleserpat.Tday.focus();
			return false;
		}
	}
	return true;
}

function setdistype() 
{
	document.serpat.distype[1].selected = true;
}

function Tsetdistype() 
{
	document.teleserpat.Tdistype[1].selected = true;
}
</SCRIPT>
</HEAD>
<body background="../images/txture5.jpg">
<div class="container">
<div class="row">
<div class="col-sm-1"></div>
<div class="col-sm-10"><br>
 <center><h4 style="color:#0000FF"><b>Tele  Patient Search</b></h4></center>
<div class="well">

<form role="form" method="POST" action="searchresult.jsp" NAME=serpat OnSubmit="return validate();">
<INPUT TYPE="hidden" NAME="que" value="Tele"> 

<div class="input-group">
<span class="input-group-addon" style="face:arial, helvetica; color:#FF0000"><b>Select Centre:</b></span>
<select class="form-control" name="center" >
	 
	  <%
		try
		{
		// if(ccode.equals("XXXX")){
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
					} // end for
			}// end else
		 // }else{
		//	out.println("<option value="+ccode+">"+cname+"</option><br>");
		 // }
		}catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

	  %>

	  </select>
</div>		<!-- "input-group" -->

<br><div class="row">
<div class="col-sm-2"><b>Search Patient by:</b></div>
<div class="col-sm-10">
<div class = "input-group">
               
               <span class = "input-group-addon">
                  <input type = "radio" value="id" checked name="R1" data-toggle="tooltip" title="Search by Patient Id" >
               </span>  
              <input type="text" class="form-control" name="id" maxlength=14 placeholder="Patient Id"/>
              
</div><!-- "input-group" -->

<div class = "input-group">
               
               <span class = "input-group-addon">
                  <input type="radio" name="R1" value="name" data-toggle="tooltip" title="Search by Patient Name" >
               </span>  
              <input class="form-control" type="text" name="name" maxlength=45 placeholder="Patient Name"/>
              
</div><!-- "input-group" -->

<div class = "input-group">
               
               <span class = "input-group-addon">
                  <input type="radio" name="R1" value="class" OnClick="setdistype();" data-toggle="tooltip" title="Search by Disease Type" />
               </span>  
             <select class="form-control" name="distype" size="1">
	   <option Selected>Disease Type</Option> 
      	
	  <%
	  /*
			try{
			FileInputStream fin = new FileInputStream(request.getRealPath("/")+"jsystem/dis_category.txt");
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
		}catch(Exception e){
			System.out.println(e.toString());
		}*/
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
		%>
	
    </select>
              
</div><!-- "input-group" -->

<div class = "input-group">
               
               <span class = "input-group-addon">
                  <input type="radio" name="R1" value="date" data-toggle="tooltip" title="Search by Date of Registration" >
               </span>  
             <div class="input-group" style="width:100%">
             <span class="input-group-addon">
             <select class="form-control" name="day" size="1">
        <% String x="";
	   Date dt=new Date();
			for(int d=1;d<=31;d++)
			{				//for I = 1 to 31
				if(d <10)
					x = "0" +String.valueOf(d);
				else
					x = String.valueOf(d);
				
				if(dt.getDate()==d)
					out.println("<option value='" +x+ "' Selected>" +d+ "</Option>");
				else
					out.println("<option value='" +x+ "'>" +d+ "</Option>");
				
			}
		%>
		</select> 
             </span>
             
            <span class="input-group-addon">
            <select class="form-control" name="month" size="1">
        <%	
	   String mon1[]={"January","February","March","April","May","June","July","August","September","October","November","December"};
			//mon = split(mon1,",")
			for(int m=0;m<=11;m++)
			{				//For i=0 to 11
				if(m < 9)
					x = "0" +String.valueOf(m+1);
				else
					x=String.valueOf(m+1);
				
				if(dt.getMonth()+1==m+1) 
					out.println("<option value='" + x + "' Selected>" + mon1[m] + "</Option>");
				else
					out.println("<option value='" + x + "'>" + mon1[m] + "</Option>");
				
			}
		%>
      </select> 
            </span> 
        <span class="input-group-addon">    
             <% 
	     out.println("<Select class='form-control' name='year' Size=1>");
		 for(int y=1995;y<=2030;y++)
		 {				//For I = 1995 to 2030
			if(dt.getYear()+1900 == y)
				out.println("<option value='" + y + "' Selected>" + y + "</Option>");
			else
				out.println("<option value='" + y + "'>" + y + "</Option>");
			
		 }
		 out.println("</Select>");
	  %>
           </span> 
             </div>		<!-- "input-group" -->
              
</div><!-- "input-group" -->

</div>		<!-- "col-sm-10" -->
</div>		<!-- "row-inner" -->
<br><center>
<input class="form-control btn btn-info" type="submit" value="Submit" name="Submit">
  </center>
</form>
</div>		<!-- "well" -->
</div>		<!-- "col-sm-10" -->
<div class="col-sm-1"></div>
</div>		<!-- "row" -->
</div>		<!-- "container" -->
</body>
</html>
