<%@page contentType="text/html"  %>
<%
String doc_id = request.getParameter("docid");
%>
<HTML>

<HEAD>
<TITLE> New Document </TITLE>
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
</HEAD>

<script>
$(document).ready(function(){
	$.get("pre_test.jsp?docid=<%=doc_id%>",function(data,status){
		$(".pres").html(data);
	});	
	$.get("drug.html",function(data,status){
		$(".add-drug").html(data);
	});		
});
</script>

<%
		
	Cookie [] cookies = request.getCookies(); 
	if (cookies != null)
	{
		for (int i = 0; i < cookies.length; i++)
		{	
			if(cookies[i].getName().equalsIgnoreCase("Drug"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
			
			if(cookies[i].getName().equalsIgnoreCase("Qty"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Dose"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Com"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
			if(cookies[i].getName().equalsIgnoreCase("Dura"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
			
			if(cookies[i].getName().equalsIgnoreCase("Count"))
			{
			cookies[i].setValue(null);
			cookies[i].setMaxAge(0);
			cookies[i].setPath("/iMediX");
			response.addCookie(cookies[i]);
			}
		}
	}
	%>

<div class="pres">

</div>
<div class="add-drug">
</div>

</HTML>
