<%@page language="java"  import="imedix.cook,imedix.rcDisplayData, java.text.SimpleDateFormat,org.json.simple.*,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
    cook cookx = new cook();
    
    JSONArray result = new JSONArray();
    
    
    String ccode = request.getParameter("ccode");
    String active = request.getParameter("active");
    String cmd = request.getParameter("cmd");

    rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
    Object depts;
    Vector doctors;
    try{

    
    if(cmd != null){
        if(cmd.equals("doctors")){
            String department = request.getParameter("dept_name");
            doctors = (Vector)ddinfom.getDoctorsOfDepartment(ccode, department);
            for(int i=0; i<doctors.size();i++){
                dataobj obj = (dataobj)doctors.get(i);
                JSONObject res = new JSONObject();
                res.put("rg_no", obj.getValue("rg_no"));
                res.put("name", obj.getValue("name"));
                result.add(res);
            }
        }
    }else{
        if(active != null){
            if(active.equals("true")){
                depts = ddinfom.getDepartments(ccode);
            }else{
                depts = ddinfom.getAllDepartments(ccode);
            }
        }else{
            depts = ddinfom.getAllDepartments(ccode);
        }


        Vector deptsV = (Vector)depts;
        //String options = "";
        for(int i=0;i<deptsV.size();i++){
            dataobj obj = (dataobj)deptsV.get(i);
            JSONObject res = new JSONObject();
            res.put("dept_id", (String)obj.getValue("iddepartment"));
            res.put("dept_name", (String)obj.getValue("department_name"));
            res.put("active", String.valueOf(obj.getValue("active")));
            result.add(res);
        }

    }
    }catch(Exception e){
        out.println(e.getMessage());
    }
    
    out.println(result);
%>
