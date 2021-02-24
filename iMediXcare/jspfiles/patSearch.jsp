<%@page language="java"  import="org.json.*,imedix.rcUserInfo,imedix.dataobj,java.util.*,java.io.*,org.json.simple.*,org.json.simple.parser.*"%>


<%

	String patname = request.getParameter("patname");

    try
    {
        rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
        Object res=uinfo.getPatientsWithoutLogin(patname);
        JSONObject result = new JSONObject();
        if(res instanceof String){
            result.put("count", 0);
            out.println(result);
        }
        else{
            Vector tmp = (Vector)res;
            result.put("count", tmp.size());
            JSONArray data = new JSONArray();
            for(int j=0;j<tmp.size();j++){
                JSONObject obj = new JSONObject();
                dataobj dobj = (dataobj)tmp.get(j);
                obj.put("pat_id", dobj.getValue("pat_id"));
                obj.put("pat_name", dobj.getValue("pat_name"));
								obj.put("m_name", dobj.getValue("m_name"));
								obj.put("l_name", dobj.getValue("l_name"));
                data.add(obj);
            } // end for
            result.put("data", data);
            out.println(result);
        }
    }catch(Exception e)
    {
        out.println("error.."+e.getMessage());
    }


%>
