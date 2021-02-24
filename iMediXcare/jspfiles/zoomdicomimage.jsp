<%@ include file="..//includes/chkcook.jsp" %>

<%

// surajit Kundu @ 06/08/2015

out.print("WADOID : "+request.getParameter("wadoid"));
String imgSrc = "<img id='change1' src='http://10.4.1.61:8042/instances/" + request.getParameter("wadoid") + "/preview'></iframe>"; 
%>


<html>
	<style>
		img{width:200;height:200}
		input#myRangeh, #myRangew{width:600px;width:600px}
		div{height:700px;width:900px;overflow:scroll;}
		</style>
<body>

 
<table>
<tr><td>Y :</td>
<td><input type="range" onkeydown="rangesh()" onmousemove="rangesh()" id="myRangeh" max=300 min=10 value="20" /></td><td id ='changeh'></td></tr>

<tr><td>X :</td>
<td><input type="range" onkeydown="rangesw()" onmousemove="rangesw()" id="myRangew" max=300 min=10 value="20" /></td><td id ='changew'></td></tr>
</table>
<div><%out.println(imgSrc);%></div>

</body>
<script>
function rangesw()
{
var r=parseInt(document.getElementById("myRangew").value);
document.getElementById("changew").innerHTML= r
document.getElementById("change1").style.width=r*10;
}
function rangesh()
{
var r=parseInt(document.getElementById("myRangeh").value);
document.getElementById("changeh").innerHTML= r
document.getElementById("change1").style.height=r*10;
}
</script>
</html>


