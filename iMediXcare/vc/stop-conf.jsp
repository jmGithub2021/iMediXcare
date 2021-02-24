<%@page contentType="text/html" import="imedix.rcVideoConference, org.json.simple.JSONObject,imedix.dataobj, java.util.*" %>
<%
    rcVideoConference vidconf = new rcVideoConference(request.getRealPath("/"));
    String room;

    room = request.getParameter("room");
    JSONObject object = new JSONObject();
    dataobj obj = null;
    if(room != null){        
        Object result = vidconf.StopConference(room);
        obj = (dataobj)result;
        if(obj.getValue("status").equalsIgnoreCase("success")){
            object.put("result", "success");
        }else{
            object.put("result", "error");
            object.put("message", obj.getValue("message"));
        }        
    }else{
        object.put("result", "error");
        object.put("message", obj.getValue("message"));
    }
    out.println(object);
%>
