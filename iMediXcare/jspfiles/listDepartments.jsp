<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%@page contentType="text/html" import="imedix.rcDisplayData" %>

<%
try
{
rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
String ccode=request.getParameter("ccode");
Object depts = ddinfom.getDepartments(ccode);
Vector deptsV = (Vector)depts;
String options = "";
options += "<option value='NIL'>Select Department</option>";
for(int i=0;i<deptsV.size();i++){
  dataobj obj = (dataobj)deptsV.get(i);
  options += "<option value='"+obj.getValue("department_name")+"'>"+obj.getValue("department_name")+"</option>";
}
out.println(options);
}catch(Exception e){
	System.out.println(e.toString());
}

%>
