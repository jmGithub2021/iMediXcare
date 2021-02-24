<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String connectionURL = "jdbc:mysql://localhost:3306/imedixdb"; 
    Connection connection = null; 
    ResultSet rs = null;
    Statement mysqlconn = null;
%>
<%
    try{
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        connection = DriverManager.getConnection(connectionURL, "root", "1234");
        if(!connection.isClosed()){
            mysqlconn = connection.createStatement();
        }else{

        }
    }catch(Exception e){
    
    }
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

   <!-- <link href="css/style.css" rel="stylesheet" type="text/css"/> -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Year Range Statistics</title>
</head>

<style>
table{    border: 1px solid #aaa;}
.yearrange label{
	min-width: 100px;
    padding: 5px;
    border: 1px solid #ccc;
	}
	.yearrange label:hover{
		background:#f0f8ff;
		border-radius:4px;
		}
	input[type=checkbox], input[type=radio] {
    height: 16px;
    width: 16px;
    margin-right: 4px !important;
    vertical-align:sub;
}
</style>

<body>
<div class="container">

    <a href="#" style="text-decoration:none;"><h1>YEAR RANGE REPORTS</h1></a>
    <%@include file="navbar.html"%>
    <br/><br/>
    <form role="form" action="yearrange.jsp" method="POST">
        <strong style="color:#680000 ">Select Disease Type: </strong>
        <br/>
        <center>
            <div class="table-responsive" id="checkbox">
                <table class="table">
                    <tr>
                        <td><label><input type="checkbox" name="diseases" value="Pediatric" />Pediatric</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Tuberculosis" />Tuberculosis</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Thoracic And Chest" />Thoracic And Chest</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Pathology" />Clinical Pathology</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Eye" />Eye</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Oncology" />Oncology</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Dermatology" />Dermatological</label></td>
                    </tr>
                    <tr>
                        <td><label><input type="checkbox" name="diseases" value="Neurosurgical" />Neurosurgical</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Other" />Other</label></td>
                        <td><label><input type="checkbox" name="diseases" value="OBG" />OBG</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Thoracic & Chest Diseases" />Thoracic and Chest Dis.</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Paediatric Surgery " />Pediatric Surg.</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Dental" />Dental</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Orthopedic" />Orthopedic</label></td>
                    </tr>
                    <tr>
                        <td><label><input type="checkbox" name="diseases" value="Cardiothoracic surgical" />Cardiothoracic Surg.</label></td>
                        <td><label><input type="checkbox" name="diseases" value="ENT" />ENT</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Acupuncture" />Acupuncture</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Pediatric HIV" />Pediatric HIV</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Urosurgery" />Urosurgery</label></td>
                        <td><label><input type="checkbox" name="diseases" value="Psychiatry" />Psychiatry</label></td>
                        <td><label><input type="checkbox" name="diseases" value="General Medicine" />General Medical</label></td>
                    </tr>
                </table>
            </div>
        </center>
        <br/>
        <strong style="color:#680000 ">Select Year Range: </strong>

        <center>
            <div class="table-responsive" id="checkbox">
                <table class="table yearrange">
                    <tr>
                       <!-- <td><label><input type="checkbox" name="yearrange" value="2003-2004" />2003-2004</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2004-2005" />2004-2005</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2005-2006" />2005-2006</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2006-2007" />2006-2007</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2007-2008" />2007-2008</label></td>-->
                        <td><label><input type="checkbox" name="yearrange" value="2008-2009" />2008-2009</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2009-2010" />2009-2010</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2010-2011" />2010-2011</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2011-2012" />2011-2012</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2012-2013" />2012-2013</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2012-2013" />2013-2014</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2012-2013" />2014-2015</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2012-2013" />2015-2016</label></td>
                        <td><label><input type="checkbox" name="yearrange" value="2012-2013" />2016-2017</label></td>
                    </tr>
                </table>
            </div>
        </center>
        <br/>
        <center>
            <input class="form-control btn btn-info" type="submit" value="FETCH DATA" name="submit"/>
        </center>
    </form>
    <br/><br/>
    <center>
        <h2>RESULTS</h2>
        <div class="table-responsive">
        <table class="table table-bordered">
                <%
                String diseases[] = request.getParameterValues("diseases");
                String yearrange[] = request.getParameterValues("yearrange");
                if(diseases!=null && yearrange!=null){
                    out.println("<tr>");
                    out.println("<th>Disease Type</th>");
                    for(int p = 0; p<yearrange.length;p++){
                        out.println("<th>" + yearrange[p] + "</th>");
                    }
                    out.println("</tr>");
                        
                        for(int i = 0; i<diseases.length;i++){
                            out.println("<tr>");
                                out.println("<td>");
                                    out.println(diseases[i]);
                                out.println("</td>");
                                for(int x = 0; x< yearrange.length; x++){
                                    out.println("<td>");
                                            String input = yearrange[x];
                                            int split = input.indexOf("-");
                                            String startdate = input.substring(0,split) + "-01-01";
                                            String enddate = input.substring(split+1) + "-01-01";
                                            String query = "SELECT COUNT(*) FROM lpatq WHERE discategory = '" + diseases[i] + "' AND entrydate > '" + startdate + "' AND entrydate < '" + enddate + "'";
                                            rs = mysqlconn.executeQuery(query);
                                            while(rs.next()){
                                                out.println(rs.getString(1));
                                            }
                                    out.println("</td>");
                                }
                            out.println("</tr>");
                        }
                }
                %>
        </table>
        </div>		<!-- "table-responsive" -->
</center>

</div>		<!-- "container" -->
</body>
</html>
