<%@page language="java"  import="imedix.cook,imedix.rcUserInfo,imedix.rcDataEntryFrm, java.text.SimpleDateFormat,org.json.*,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>
<%@page contentType="text/html" import= "javax.servlet.*,imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*,java.io.FileReader,java.io.IOException"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
    cook cookx = new cook();
	String cmd = request.getParameter("cmd");
  String ccode = cookx.getCookieValue("center", request.getCookies ());
    String pat_id = request.getParameter("patid");
    String patid = "";
    if(pat_id == null || pat_id.equalsIgnoreCase("")){
        patid = cookx.getCookieValue("patid", request.getCookies());
    }else{
        patid = pat_id;
    }

    JSONObject result = new JSONObject();
    rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
    rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
    rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));

    if(cmd != null){
        if(cmd.equalsIgnoreCase("reset-lpat")){
            boolean res = rcpqi.resetAppoinmentLpatq(patid);
            if(res == true){
                result.put("status", "success");
                result.put("message", "The appointment has been reset successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The appointment was not reset successfully.");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("reset-tpat")){
            boolean res = rcpqi.resetAppoinmentTpatq(patid);
            if(res == true){
                result.put("status", "success");
                result.put("message", "The appointment has been reset successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The appointment was not reset successfully.");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("remove-lpat")){
            int status = rcdef.moveLtoTreatedpatq(patid);
            result.put("status", "success");
            result.put("message", "Patient removed from local patient queue");
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("remove-tpat")){
            int status = rcdef.moveTtoTreatedpatq(patid);
            result.put("status", "success");
            result.put("message", "Patient removed from local patient queue");
            out.println(result);
        }
    }else{
        try
        {
            String requestedConsultation=Boolean.toString(rcdef.isRequested(patid));
            String strategy=rcdef.findConsultStrategy(ccode);
            Date cDate = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String curDate = sdf.format(cDate);

            result.put("cur_date", curDate);

            if(patid != ""){
                // get lpatq
                Object patq = rcpqi.getLPatEntry(patid);
                Vector patqV = (Vector)patq;
                //out.println("Patq size: "+patqV.size());
                String appDate = "";
                result.put("requestedConsultation",requestedConsultation);
                result.put("imedix_mode",strategy);
                result.put("lpat_size", patqV.size());
                if(patqV.size() != 0){
                    dataobj obj = (dataobj)patqV.get(0);
                    appDate = (String)obj.getValue("appdate");
                    result.put("lpatq_apdate",appDate);
                    result.put("lpatq_assigneddoc", (String)obj.getValue("assigneddoc"));
                    result.put("lpatq_doc_name",rcui.getName((String)obj.getValue("assigneddoc")));
                    // get uid of doctor
                    Object dlres = rcui.getValues("uid", "rg_no = \'"+(String)obj.getValue("assigneddoc")+"\'");
                    Vector dlV = (Vector)dlres;
                    if(dlV.size() != 0){
                        dataobj dlobj = (dataobj)dlV.get(0);
                        String dluid = (String)dlobj.getValue("uid");
                        result.put("lpatq_doc_id", dluid);
                    }else{
                        result.put("lpatq_doc_id", "");
                    }
                }else{
                    result.put("lpatq_apdate", "");
                    result.put("lpatq_assigneddoc", "");
                    result.put("lpatq_doc_name","");
                    result.put("lpatq_doc_id", "");
                }

                // get tpatq
                Object tpatq = rcpqi.getTPatEntry(patid);
                Vector tpatqV = (Vector)tpatq;
                //out.println("Patq size: "+patqV.size());
                String tappDate = "";
                result.put("tpat_size", tpatqV.size());
                if(tpatqV.size() != 0){
                    dataobj obj = (dataobj)tpatqV.get(0);
                    tappDate = (String)obj.getValue("teleconsultdt");
                    result.put("tpatq_apdate",tappDate);
                    result.put("tpatq_assigneddoc", (String)obj.getValue("assigneddoc"));
                    result.put("tpatq_doc_name",rcui.getName((String)obj.getValue("assigneddoc")));

                    // get uid of doctor
                    Object dtres = rcui.getValues("uid", "rg_no = \'"+(String)obj.getValue("assigneddoc")+"\'");
                    Vector dtV = (Vector)dtres;
                    if(dtV.size() != 0){
                        dataobj dtobj = (dataobj)dtV.get(0);
                        String dtuid = (String)dtobj.getValue("uid");
                        result.put("tpatq_doc_id", dtuid);
                    }else{
                        result.put("tpatq_doc_id", "");
                    }
                }else{
                    result.put("tpatq_apdate", "");
                    result.put("tpatq_assigneddoc", "");
                    result.put("tpatq_doc_name","");
                    result.put("tpatq_doc_id", "");
                }

                // get tpatq wailt queue
                String tpatwq = (String)rcpqi.isAvaliableInTwaitQ(patid);
                result.put("tpatwq", tpatwq);
            }else{
                result.put("lpatq_apdate", "");
                result.put("lpat_size", 0);
                result.put("tpatq_apdate", "");
                result.put("tpat_size", 0);
                 result.put("tpatwq", 0);
            }

            out.println(result);
        }catch(Exception e){
            out.println("error.."+e.getMessage());
        }
    }




%>
