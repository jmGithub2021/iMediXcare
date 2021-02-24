<%@page language="java"  import= "imedix.dataobj,imedix.rcUserInfo,imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>
<%
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());
	String ccode =cookx.getCookieValue("center", request.getCookies ());
	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

    String docid=request.getParameter("uid");
	String docname=uinfo.getName(docid);
	String othspl=uinfo.getSpecialization(docid);
%>
<html>

<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</head>

<body>
<div class="container-fluid"><br>
<div class="row">
<div class="col-sm-2"></div>
<div class="col-sm-8">
<div class="well" style="background-color:#">
<FORM role="form" METHOD="GET" ACTION="saveotherdis.jsp" Name='othdis' ">
<div class="input-group">
<span class="input-group-addon" style="color:#3300FF"><strong>Doctor Name : </strong></span>
<span class="input-group-addon" style="color:#FF6600"><strong><%=docname%></strong></span>
<INPUT TYPE="hidden" NAME='docid' value='<%=docid%>'>
</div>		<!-- "input-group" -->
<h4 style="color:#339900">Register other Specialization :</h4>

<div class="input-group">
<SELECT class="form-control" name='othdis' >
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
						        str = str.replaceAll("\n","");
							str = str.replaceAll("\r","");
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
				</SELECT>
<span class="input-group-btn">
<INPUT class="form-control btn btn-primary" TYPE="submit" Value="Save">
</span>
</div>		<!-- "input-group" -->

<fieldset>
<h4 style="color:#339900">Specialization Registered Following : </h4>

<%
			String spl[]=othspl.split(",");
			out.println("<b><ol type='1' style='color:#0033FF'>");
			for(int i=0;i<spl.length;i++){
				out.println("<li>"+spl[i]+"</li>");
			}
			out.println("</b></ol>");
		%>

</fieldset>
</div>		<!-- "well" -->
</div>		<!-- "col-sm-8" -->
<div class="col-sm-2"></div>
</div>		<!-- "row" -->
</div>		<!-- "container-fluid" -->
</body>
</html>
