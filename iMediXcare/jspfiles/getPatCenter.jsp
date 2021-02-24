<%@page language="java"  import="imedix.cook,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.rcDataEntryFrm, java.text.SimpleDateFormat,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>
<%@page contentType="text/html" import= "javax.servlet.*,imedix.rcUserInfo,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*,java.io.FileReader,java.io.IOException"%>


<%
    cook cookx = new cook();
//	String cmd = request.getParameter("cmd");
//  String ccode = cookx.getCookieValue("center", request.getCookies ());
    String patid = request.getParameter("patid");

    JSONObject result = new JSONObject();
    rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
    rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
    rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));
    rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));


        try
        {
            String centerCode="";
            if(patid != ""){
                // get lpatq
                Object patq = rcpqi.getLPatEntry(patid);
                Vector patqV = (Vector)patq;
                //out.println("Patq size: "+patqV.size());
                String appDate = "";
                if(patqV.size() != 0){
                    dataobj obj = (dataobj)patqV.get(0);
                    // get uid of doctor
                    Object dlres = rcui.getValues("center", "rg_no = \'"+(String)obj.getValue("assigneddoc")+"\'");
                    Vector dlV = (Vector)dlres;
                    if(dlV.size() != 0){
                        dataobj dlobj = (dataobj)dlV.get(0);
                        String dluid = (String)dlobj.getValue("center");
                        centerCode+=dluid;
                    }
                }

                if(centerCode.equals(""))
                {
                // get tpatq
                Object tpatq = rcpqi.getTPatEntry(patid);
                Vector tpatqV = (Vector)tpatq;
                //out.println("Patq size: "+patqV.size());
                String tappDate = "";
                result.put("tpat_size", tpatqV.size());
                if(tpatqV.size() != 0){
                    dataobj obj = (dataobj)tpatqV.get(0);

                    Object dtres = rcui.getValues("center", "rg_no = \'"+(String)obj.getValue("assigneddoc")+"\'");
                    Vector dtV = (Vector)dtres;
                    if(dtV.size() != 0){
                        dataobj dtobj = (dataobj)dtV.get(0);
                        String dtuid = (String)dtobj.getValue("center");
                        centerCode+=dtuid;
                    }
                }
              }

            }
            if(!centerCode.equals(""))
            {
              result.put("ccode", centerCode);
              String centerNAME=cinfo.getHosName(centerCode);
              result.put("cname", centerNAME);
            }
        out.println(result);
        }catch(Exception e){
            out.println("error.."+e.getMessage());
        }





%>
