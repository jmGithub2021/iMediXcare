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
        /*if(cmd.equalsIgnoreCase("update-active")){
            String active = request.getParameter("active");
            int drug_id = Integer.parseInt(request.getParameter("drug_id"));
            boolean res = rcdef.updateDrug(drug_id,"active", active);
            if(res == true){
                result.put("status", "success");
                if(active.equalsIgnoreCase("1"))
                {
                    result.put("message", "The drug is ACTIVATED successfully.");
                }
                else
                {
                  result.put("message", "The drug is DEACTIVATED successfully.");
                }
            }else{
                result.put("status", "error");
                result.put("message", "The active status of the drug is not updated successfully.");
            }
            out.println(result);
        }else*/
        if(cmd.equalsIgnoreCase("add")){
            String drug_name = request.getParameter("drug_name");
            String _ccode = request.getParameter("ccode");
            if(_ccode != null)
                ccode = _ccode;
            boolean res = rcdef.addIMEDIXDrug(drug_name);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The drug is added successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The drug could not be added.");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("delete")){
            int drug_id = Integer.parseInt(request.getParameter("drug_id"));
            boolean res = rcdef.deleteIMEDIXDrug(drug_id);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The drug is deleted successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The drug could not be deleted.");
            }
            out.println(result);
        }else if(cmd.equalsIgnoreCase("edit")){
            int drug_id = Integer.parseInt(request.getParameter("drug_id"));
            String drug_name = request.getParameter("drug_name");
            boolean res = rcdef.updateIMEDIXDrug(drug_id,"drug_name", "'"+drug_name+"'");
            if(res == true){
                result.put("status", "success");
                result.put("message", "The drug has been updated successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The drug was not updated successfully.");
            }
            out.println(result);
        }

    }




%>
