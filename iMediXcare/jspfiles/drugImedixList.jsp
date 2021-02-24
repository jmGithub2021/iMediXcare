<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.medinfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate, java.util.*,java.io.*,org.json.simple.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
String ccode=request.getParameter("ccode");
try{
        //Object imedix_drugs = ddinfom.getDrugList();
        Object imedix_drugs = ddinfom.getDrugListIMEDIX(ccode);
        Vector imedix_drugsV = (Vector)imedix_drugs;
        //String options = "";
        for(int i=0;i<imedix_drugsV.size();i++){
            dataobj obj = (dataobj)imedix_drugsV.get(i);
            //int active = Integer.parseInt(obj.getValue("active"));
            out.println("<tr>");
          if(!obj.getValue("drug_name").equalsIgnoreCase("")){
            out.println("<td><input class='form-control' name='appSet' type='checkbox' id='"+i+"' drug_name='"+obj.getValue("drug_name")+"' /></td><td>"+obj.getValue("drug_name")+"</td>");
            out.println("</tr>");
          }
            //options += "<option value='"+obj.getValue("drug_name")+"'>"+obj.getValue("drug_name")+"</option>";
        }

    //out.println(options);
}catch(Exception e){
    System.out.println(e.getMessage());
}
%>
