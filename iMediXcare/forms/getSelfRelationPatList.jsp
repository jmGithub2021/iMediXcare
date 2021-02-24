<%@page contentType="text/html" import= "javax.servlet.*,imedix.rcDisplayData,imedix.cook,imedix.dataobj,imedix.myDate ,java.util.*,java.io.*,java.text.*,org.json.simple.*,org.json.simple.parser.*"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
  String list = "";
  rcDisplayData display = new rcDisplayData(request.getRealPath("/"));
    Object res=display.getSelfRelationPatList(); 
    Vector tmp = (Vector)res;
    JSONArray jsarray = new JSONArray();
    for(int i=0;i<tmp.size();i++){
      dataobj temp = (dataobj) tmp.get(i);
      JSONObject jsobj=new JSONObject();    
      String patid = temp.getValue("uid").trim();
      String name = temp.getValue("name").trim();
      String phone = (temp.getValue("phone").trim().equals(""))?"-":temp.getValue("phone").trim();
      String emailid = (temp.getValue("emailid").trim().equals(""))?"-":temp.getValue("emailid").trim();
      //jsobj.put("id",patid);
      jsobj.put("value",patid);
      jsobj.put("label",name+" | "+phone+" | "+emailid+" ("+patid+")");
      jsarray.add(jsobj);
    }
    list = jsarray.toString();
   // out.println(list);
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Autocomplete - Remote JSONP datasource</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script
        src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
        integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
        crossorigin="anonymous"></script>
<script>        

   var availableTags2 = <%=list%>;  

    $(document).ready(function(){
    	 //console.log("<%=list%>");
    $( "#b" ).autocomplete({
      source: availableTags2
    });
    });
</script>

<body>
<input type="text" name="tosend" id="tosend"><br><br>
type below<br>
<input id="a"><br>
<br>
<br>
using value instead of id<br>
<input id="b">
</body>
</html>