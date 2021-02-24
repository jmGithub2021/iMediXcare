<%@page language="java"  import="imedix.cook,imedix.rcUserInfo,imedix.rcDataEntryFrm, org.json.simple.*,org.json.simple.parser.*,java.text.SimpleDateFormat,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>


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
            int drug_id = Integer.parseInt(request.getParameter("drug_id"));
            System.out.println("HERE-"+cmd+"-"+request.getParameter("drug_id")+"-"+request.getParameter("active"));
            boolean res = rcdef.updateDrug(drug_id,"active", active);
            System.out.println("res:-"+res);
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
        }else if(cmd.equalsIgnoreCase("add")){
            String drug_name = request.getParameter("drug_name");
            String _ccode = request.getParameter("ccode");
            if(_ccode != null)
                ccode = _ccode;
            boolean res = rcdef.addDrug(drug_name, ccode);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The drug is added successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The drug could not be added.");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("csv-multiple")){
          String drug_name[] = request.getParameter("drug_name").split(",");
          String _ccode = request.getParameter("ccode");
          if(_ccode != null)
              ccode = _ccode;

          boolean res = rcdef.addMultipleDrugCSV(drug_name, ccode);
          if(res == true){
              result.put("status", "success");
              result.put("message", "The drug(s) is/are added successfully.");
          }else{
              result.put("status", "error");
              result.put("message", "An error occured while adding drugs!!!");
          }

          out.println(result);
        }
        else if(cmd.equalsIgnoreCase("add-multiple")){
            //String drug_name[] = request.getParameter("drug_name").split(",");
            String drug_id[] = request.getParameter("drug_id").split(",");
            String _ccode = request.getParameter("ccode");
            if(_ccode != null)
                ccode = _ccode;
            boolean res = rcdef.addMultipleDrug(drug_id, ccode);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The drug(s) is/are added successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "An error occured while adding drugs!!!");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("delete")){
            int drug_id = Integer.parseInt(request.getParameter("drug_id"));
            boolean res = rcdef.deleteDrug(drug_id);

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
            boolean res = rcdef.updateDrug(drug_id,"drug_name", "'"+drug_name+"'");
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
