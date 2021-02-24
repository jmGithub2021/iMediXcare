<%@page language="java" import="imedix.cook,imedix.myDate,java.util.*,imedix.dataobj,imedix.rcDataEntryFrm" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String pat_id,dat="",cen="",utype="", user="";
	String output="";
	rcDataEntryFrm rcDe = new rcDataEntryFrm(request.getRealPath("/"));
	cook cookx = new cook();

	pat_id = cookx.getCookieValue("patid", request.getCookies());
	cen = cookx.getCookieValue("center",request.getCookies());
	utype =cookx.getCookieValue("usertype",request.getCookies());
	user =cookx.getCookieValue("userid",request.getCookies());
	
	dataobj obj = new dataobj();
	obj.add("userid",user);
	obj.add("usertype",utype);


	//out.print("&nbsp;<B>Patient ID<BR>&nbsp;<FONT SIZE='-1' COLOR='#FF0000'>" + pat_id + "</B></FONT><BR>");
	dat = myDate.getCurrentDate("dmy",false);
%>

<html >
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<script language="javascript" src="../includes/ajaxcall.js"></script>
<script language="javascript">

function Check_n_Submit(url, method, query, formname, position)
{
    if (formname == 'addprob')
    {
        var value = document.getElementById("newprob").value;
        if (value != "")
        {
            query += "&newprob=" + encodeURIComponent(value);
            ExecuteCallContent(url, method, query, '', position);
        }
        else
        {
            alert("Content is blank.");
        }
    }
    else if (formname == 'delprob')
    {
        var selected = false;
		var pids="";
        var elements = document.getElementsByName("pob_id");
        for (var i = 0; i < elements.length; i++) 
        {
            if (elements[i].checked)
            {
                //query += "&pob_id=" + encodeURIComponent(elements[i].value);
				pids+=","+encodeURIComponent(elements[i].value);
                selected = true;
            }

			
        }
		pids=pids.substring(1);
		query += "&pob_id=" + pids;

        if (selected)
            ExecuteCallContent(url, method, query, '', position);
        else
            alert("Select problem(s) before deletion.");
    }
    else
    {}
}
</script>
<style>

BODY
{
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-size: 10pt;
    background-color: #F0F4FE;
    text-decoration: none;
    margin: 0px;
    padding 0px;
}


div#conhead a
{
    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	//font-size: 10pt;
	margin: 0px;
	color: blue;
	font-weight: bold;
	text-align: center;
	//padding: 5 20 5 20; 
	//height: 20px;
	text-decoration: none;
	background-color: #F2FDF3;
	border-color: #669900;
	//border-width: 1px 1px 1px 1px;
	border-style: solid;
}

div#content a
{
    text-decoration:none;
	
}

td{
    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10pt;
	text-decoration: none;
}


</style>
</head>

<style>
a{padding: 5px 2px !important;}
</style>

<body>

<%
	String headstr="",tempstr="";
	String prob_ids = "", prob = "";
	String action = request.getParameter("action");
    if(action==null) action="";

	if (action.equalsIgnoreCase("insert")){

                prob = request.getParameter("newprob");
                rcDe.insertProblem(pat_id, prob, user,cen);
                tempstr = rcDe.problemList(pat_id, "act");
                out.println("<br>" + tempstr);
                return;
    }
	
		if (action.equalsIgnoreCase("delete")){

				prob_ids = request.getParameter("pob_id");

				//out.println("<br>" + prob_ids);

                rcDe.deleteProblem(pat_id,prob_ids,obj);
                tempstr = rcDe.problemList(pat_id, "act");
                out.println("<br>" + tempstr);
                return;
               
            }
            else if (action.equalsIgnoreCase("add"))
            {
                tempstr = rcDe.problemList(pat_id, "act");
                tempstr += "<BR><br>";
        
                tempstr += "<table class='table'>";
                tempstr += "<tr><td>Problem Description</td><td><textarea class='form-control' id='newprob' rows='3' cols='50'></textarea></td></tr>";
                tempstr += "<tr><td colspan='2' align='center'><input class='btn btn-primary' type='button' value='Add Problem' onclick=\"Check_n_Submit('problemlist.jsp', 'get', 'action=insert', 'addprob', 'contentD')\"></td></tr>";
                tempstr += "</table>";
               
				out.println("<br>" + tempstr);
                return;
                
            }else if (action.equalsIgnoreCase("act")){
                tempstr = rcDe.problemList(pat_id, "act");
	                out.println("<br>" + tempstr);
					return;
                
            }
            else if (action.equalsIgnoreCase("all"))
            {
                tempstr = rcDe.problemList(pat_id, "all");
	                out.println("<br>" + tempstr);
					return;
            }
            else if (action.equalsIgnoreCase("del"))
            {
               String plist = rcDe.problemList(pat_id, "del");
               
			   //String plist = rcDe.problemList(pat_id);

               tempstr += "<br>" + plist + "<br>";
               tempstr += "<input class='btn btn-primary' type='button' value='Close Problem' onclick=\"Check_n_Submit('problemlist.jsp', 'get', 'action=delete', 'delprob', 'contentD')\">";
			   out.println("<br>" + tempstr);
			   return;
            }

            else
            {
                headstr += "<ul class='nav nav-pills'>"+"<BR><li><a href=\"javascript:ExecuteCallContent('problemlist.jsp', 'get', 'action=act', '', 'contentD')\">List Active</a></li>";
                headstr += "<li><a href=\"javascript:ExecuteCallContent('problemlist.jsp', 'get', 'action=all', '', 'contentD')\">List All</a></li>";
                headstr += "<li><a href=\"javascript:ExecuteCallContent('problemlist.jsp', 'get', 'action=add', '', 'contentD')\">Add Problem</a></li>";
                headstr += "<li><a href=\"javascript:ExecuteCallContent('problemlist.jsp', 'get', 'action=del', '', 'contentD')\">Close Problem</a></li></ul></center>";

                tempstr = rcDe.problemList(pat_id, "act");
                tempstr = "<br>" + tempstr;
            }

%>
  <div class="container">
  <div class="row">
  <div class="col-sm-3"></div>
  <div class="col-sm-6">
    <div id="conhead" style="width:100%"><%= headstr %></div>
    <div id="contentD" style="width:100%"><%= tempstr %></div>
  </div>		<!-- "col-sm-6" -->  
    
    <div class="col-sm-3"></div>
    </div>		<!-- "row" -->
    </div>		<!-- "container" -->
</body>
</html>
