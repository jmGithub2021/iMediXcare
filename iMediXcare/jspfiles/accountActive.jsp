<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<%
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());

	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
	String us, ps;
	boolean found=false;;

	//rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
	//rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	String sccode=request.getParameter("sccode");


	if(sccode==null) sccode=ccode;
	if(sccode.equals("")) sccode=ccode;
	String cond="active='Y' ";
	if(sccode.equals("XXXX")){
		cond+=" and center <> 'XXXX'  order by center,type,name";
	}else{
		cond+=" and center = '"+sccode+"'"+ " order by center,type,name";
	}
%>


<HTML>
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>

<SCRIPT LANGUAGE="JavaScript">
	$(document).ready(function(){
		$('#accountList').DataTable();
	});

	function showselected(val){
		var tar;
		tar="accountActive.jsp?sccode="+val;
		//alert(tar);
		window.location=tar;
	}
	function status(reg)
	{
		var chk=document.getElementById(reg);
		console.log(reg);

		if($(chk).prop('checked'))
		{
			//alert("Do you want to activate this account?");
			var param = {cmd: "activate",uid:reg};
			$.ajax({
					type: 'POST',
					url: "account_manage.jsp",
					data: param,
					dataType: "text",
					success: function(data) {
		          var res = JSON.parse(data);
							alert(res.message);
							location.reload(true);
					}
			});
		}
		else {
			//alert("Do you want to deactivate this account?");
			var param = {cmd: "deactivate",uid:reg};
			$.ajax({
					type: 'POST',
					url: "account_manage.jsp",
					data: param,
					dataType: "text",
					success: function(data) {
		          var res = JSON.parse(data);
							alert(res.message);
							location.reload(true);
					}
			});
		}
	}


</SCRIPT>

<style>
input[type=checkbox]{
    margin:0;
    height: 22px;
    width: 33px;
}
table tr:nth-child(odd) td {

}
table tr:nth-child(even) td {

}
</style>


</HEAD>
<body background="../images/txture.jpg">
	<TABLE class="table" width=90% border=0 Cellpadding=0 Cellspacing=0 >
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>ACTIVATE/DEACTIVATE USERS</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
	</TABLE>
<div class="container-fluid">
<div class="row">
<div class="col-sm-4">
<div class="input-group">
<span class="input-group-addon" style="color:blue;font-weight:bold">Select Center :</span>
<select class="form-control" name="center" onchange='showselected(this.value);'>
<%
	out.println("<option value="+ccode+" 'selected'>"+cname+"</option><br>");
		try
		{
		 if(ccode.equals("XXXX")){
			rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));
			Object res=rcci.getAllCentreInfo();
			if(res instanceof String){ out.println("<option value='NIL' >No match Found</option>"); }
			else{
				Vector Vtmp = (Vector)res;
					for(int j=0;j<Vtmp.size();j++){
						dataobj datatemp = (dataobj) Vtmp.get(j);
						if(datatemp.getValue("code").equals(sccode)){
							out.println("<option value="+datatemp.getValue("code")+" selected>"+datatemp.getValue("name")+"</option><br>");
						}else{
							out.println("<option value="+datatemp.getValue("code")+">"+datatemp.getValue("name")+"</option><br>");
						}
					} // end for
			}// end else
		  }
		}catch(Exception e)
		{
			out.println("error.."+e.getMessage());
		}

%>
	 </select>
	</div>		<!-- "input-group" -->

</div>		<!-- "col-sm-4" -->
</div>		<!-- "row" -->

<div class="row">
<div class="col-sm-12">


<div class="table-responsive">



<strong><Font> <CENTER><font color='red'>Administrator : Red </font>
<font color='darkgreen'>| Doctor : Green </font>
<font color='blue'>| Data Entry Operator : Blue </font><font color='black'>| Patients : Black</font></CENTER></strong>
<table class="table table-bordered table-hover" id="accountList">
	<thead>
	<TR style='background-color: #E6E6FA;font-variant: small-caps;font-weight: bold;font-size:22px;' >
		<TH> <FONT ><B> Account Status</B></FONT></TH>
		<TH> <FONT ><B> Name (UID)</B></FONT></TH>
		<TH> <FONT ><B> Designation </B></FONT></TH>
		<TH> <FONT ><B>Email</B></FONT></TH>
		<TH> <FONT ><B> Phone </B></FONT></TH>
		<TH> <FONT ><B> Center </B></FONT></TH>

	</TR>
</thead>
<%
	String rgno, suid,typ;
	try {
Object res=uinfo.getValues("name,uid,designation,emailid,phone,dis,rg_no,type,active,center,verified",cond);
		if(res instanceof String){

		out.println("<br><center><h1> No User Available</h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
			dataobj tmpData = (dataobj) tmp.get(0);
			String pvcenter=tmpData.getValue("center");

		for(int ii=0;ii<tmp.size();ii++){
			String color="RED";

			dataobj temp = (dataobj) tmp.get(ii);
			typ=temp.getValue("type");
			rgno = temp.getValue("rg_no");
			suid =temp.getValue("uid");

			if(typ.equals("adm")) color="RED";
			else if(typ.equals("doc")) color="DARKGREEN";
			else if(typ.equals("usr")) color="blue";
			else if(typ.equalsIgnoreCase("pat")) color="black";

			if(!pvcenter.equals(temp.getValue("center"))){
				out.println("<tr><td colspan='6' style='background-color: #E6E6FA;'>      </td></tr>");
			//out.println ("<TR bgcolor='#330099'><td colspan=8>&nbsp;</td></tr>");
			%>

			<%
			pvcenter=temp.getValue("center");
			}
			out.println ("<TR>");

			String avValue= temp.getValue("verified").equals("A") ? "checked" : "" ;

			out.println("<td><input class='avl' type='checkbox' name='avl' onClick='status(id)' id='" +temp.getValue("rg_no") + "' value='" +temp.getValue("rg_no") + "'" + avValue  + "></td>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("name") + "(<B>" + temp.getValue("rg_no") + "</B>)" + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("designation")  + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("emailid")  + "</font></TD>");
			out.println ("<TD><font color='"+color+"'>" + temp.getValue("phone")  + "</font></TD>");

			out.println ("<TD><font color='"+color+"'>"+temp.getValue("center")+"</font></TD>");


			out.println("</TR>");
		}

		}
	}


	}catch (Exception e) {
			out.println("SQL Error found <B>"+e+"</B>");
	}

%>
</TABLE>
</div>		<!-- "table-responsive" -->

</div>		<!-- "col-sm-12" -->
</div>		<!-- "row(inner)" -->

</div>		<!-- "container" -->
</body>
</html>
