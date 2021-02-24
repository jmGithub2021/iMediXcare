<%@page language="java"  import="imedix.cook,imedix.rcUserInfo,imedix.rcDataEntryFrm, org.json.simple.*,org.json.simple.parser.*,java.text.SimpleDateFormat,org.json.*,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>


<%
    cook cookx = new cook();
	String cmd = request.getParameter("cmd");
    String ccode= cookx.getCookieValue("center", request.getCookies ());

    JSONObject result = new JSONObject();
    rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
    rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
    rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));

    if(cmd != null){
        if(cmd.equalsIgnoreCase("update-active")){
            String active = request.getParameter("active");
            int dept_id = Integer.parseInt(request.getParameter("dept_id"));
            boolean res = rcdef.updateDepartment(dept_id,"active", active);
            if(res == true){
                result.put("status", "success");
                result.put("message", "The department has been updated successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The department was not updated successfully.");
            }
            out.println(result);
        }else if(cmd.equalsIgnoreCase("add")){
            String dept_name = request.getParameter("dept_name");
            String _ccode = request.getParameter("ccode");
            if(_ccode != null)
                ccode = _ccode;
            boolean res = rcdef.addDepartment(dept_name, ccode);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The department is added successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The department could not be added.");
            }
            out.println(result);
        }else if(cmd.equalsIgnoreCase("delete")){
            int dept_id = Integer.parseInt(request.getParameter("dept_id"));
            boolean res = rcdef.deleteDepartment(dept_id);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The department is deleted successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The department could not be adddeleteded.");
            }
            out.println(result);
        }else if(cmd.equalsIgnoreCase("edit")){
            int dept_id = Integer.parseInt(request.getParameter("dept_id"));
            String dept_name = request.getParameter("dept_name");
            boolean res = rcdef.updateDepartment(dept_id,"department_name", "'"+dept_name+"'");
            if(res == true){
                result.put("status", "success");
                result.put("message", "The department has been updated successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The department was not updated successfully.");
            }
            out.println(result);
        }

    }




%>
