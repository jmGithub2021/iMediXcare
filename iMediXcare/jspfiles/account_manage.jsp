<%@page language="java"  import="imedix.cook,imedix.rcUserInfo,imedix.rcDataEntryFrm, org.json.simple.*,org.json.simple.parser.*,java.text.SimpleDateFormat,imedix.rcPatqueueInfo,imedix.dataobj,java.util.*,java.io.*"%>


<%
    cook cookx = new cook();
	String cmd = request.getParameter("cmd");
    //String ccode= cookx.getCookieValue("center", request.getCookies ());

    JSONObject result = new JSONObject();
    rcPatqueueInfo rcpqi=new rcPatqueueInfo(request.getRealPath("/"));
    rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
    rcUserInfo  rcui=new rcUserInfo(request.getRealPath("/"));

    if(cmd != null){
        if(cmd.equalsIgnoreCase("deactivate")){
          String uid = request.getParameter("uid");
          boolean res=rcui.deactivateAccount(uid);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The account with uid = "+uid+" is deactivated successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The account with uid = "+uid+" deactivation is unsuccessful.");
            }
            out.println(result);
        }
        else if(cmd.equalsIgnoreCase("activate")){
          String uid = request.getParameter("uid");
          boolean res=rcui.activateAccount(uid);

            if(res == true){
                result.put("status", "success");
                result.put("message", "The account with uid = "+uid+" is activated successfully.");
            }else{
                result.put("status", "error");
                result.put("message", "The account with uid = "+uid+" activation is unsuccessful.");
            }
            out.println(result);
        }

    }

%>
