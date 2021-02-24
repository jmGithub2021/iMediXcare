<%@page language="java"  import="imedix.cook,imedix.rcDisplayData, java.text.SimpleDateFormat,org.json.simple.*,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>


<%
    cook cookx = new cook();


    JSONArray result = new JSONArray();


    String ccode = request.getParameter("ccode");
    String active = request.getParameter("active");
    String cmd = request.getParameter("cmd");

    rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));
    Object drugs;
    Vector doctors;
    try{

/*
    if(cmd != null){
        if(cmd.equals("doctors")){
            String drug = request.getParameter("drug_name");
            doctors = (Vector)ddinfom.getDoctorsOfdrug(ccode, drug);
            for(int i=0; i<doctors.size();i++){
                dataobj obj = (dataobj)doctors.get(i);
                JSONObject res = new JSONObject();
                res.put("rg_no", obj.getValue("rg_no"));
                res.put("name", obj.getValue("name"));
                result.add(res);
            }
        }
    }else{*/
        if(active != null){
            if(active.equals("true")){
                drugs = ddinfom.getdrugs(ccode);
            }else{
                drugs = ddinfom.getAlldrugs(ccode);
            }
        }else{
            drugs = ddinfom.getAlldrugs(ccode);
        }


        Vector drugsV = (Vector)drugs;
        //String options = "";
        for(int i=0;i<drugsV.size();i++){
            dataobj obj = (dataobj)drugsV.get(i);
            JSONObject res = new JSONObject();
            res.put("drug_id", (String)obj.getValue("sl_no"));
            res.put("drug_name", (String)obj.getValue("drug_name"));
            res.put("active", String.valueOf(obj.getValue("active")));
            result.add(res);
        }

    //}
    }catch(Exception e){
        out.println(e.getMessage());
    }

    out.println(result);
%>
