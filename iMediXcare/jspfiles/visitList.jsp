<%@page language="java" import="java.util.HashMap,imedix.rcItemlistInfo,imedix.cook,imedix.myDate,java.rmi.*,java.sql.*,imedix.dataobj,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray" %>
<%@ include file="..//includes/chkcook.jsp" %>
<!--	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>-->
<%
//output5="<script>$.get('visitList.jsp?all="+all+"&dt1="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
String dt1=request.getParameter("dt1");
String all=request.getParameter("all");
//out.println(all);
String urlList[]=all.split("###");
%>
<script>
$(document).ready(function() {

var All="<%=all%>";
var dt1="<%=dt1%>";
//console.log(All);
var ar=All.split("###");
//console.log(ar);
//console.log(ar.length);
//console.log(dt1);
var getData="";

for(var i=0;i<ar.length-1;i++)
{
  //console.log(i+":"+ar[i]);
//$.get(ar[i],function(data){$("."+dt1.replace(/\//g,"")+"").append(data)});
    function getCall(a){
      var res=null;
      //$.get(a,function(data){res=data;});
      $.ajax({
        url: a,
        type: 'get',
        dataType: 'html',
        async: false,
        success: function(data) {
            //res = data;
            res=$("."+dt1.replace(/\//g,"")+"").append(data);
        }
     });
        return res;
      }
      //console.log("data:"+getCall(ar[i]));
      getData+=getCall(ar[i]);

      //
}
//document.writeln(getData);
//$('body').append(getData);
});
</script>
<html>
  <body>
  </body>
</html>
