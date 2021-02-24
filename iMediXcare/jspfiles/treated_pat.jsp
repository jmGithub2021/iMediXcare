<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>

<html>
<HEAD>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/jquery.dataTables.min.js"></script>
	<script src="../bootstrap/dataTables.bootstrap.min.js"></script>
	<style>
	thead tr{background:#349198;color:#fff;font-weight:600;}
	tbody tr:nth-child(odd){background:rgb(221, 240, 249);}
	tbody tr:nth-child(even){background:#f0f6f9;}
	.mtolpatq{cursor:pointer;color:#f95d01;}
	</style>
</head>

<%!
//Database connection here
public Connection mySqlcon(){
	Connection con=null;
	  try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();;
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/imedixdb_ccode_modf","root","1234");
		return con;
		}
		catch(Exception ex){con=null;}
		return con;
		
  }

public String movePatient(String patid, String tablename){

	Connection con =null;
			String sql = "";
			if(tablename.equals("lpatq"))
				sql = "INSERT IGNORE INTO "+tablename+"_treated(pat_id,entrydate,appdate,assigneddoc,discategory,checked,delflag) SELECT * FROM "+tablename+" where pat_id='"+patid+"'";
			else if(tablename.equals("tpatq"))
				sql = "INSERT IGNORE INTO "+tablename+"_treated(pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag,assignedhos,issent,lastsenddate) SELECT * FROM "+tablename+" where pat_id='"+patid+"'";
			else
				sql = "";
			
	try{
		con = mySqlcon();
		Statement st = con.createStatement();
		int i = st.executeUpdate(sql);
		if(i>0){
			String del_sql = "delete from "+tablename+" where pat_id='"+patid+"'";
			int j=st.executeUpdate(del_sql);
			if(j>0)
			return sql+" : "+del_sql;
			else
			return sql;
		}
		else{
			return "Flse "+sql;}
			
	}catch(SQLException ex){return ex.toString()+sql;}

		
}

%>
<%
String pat_id="",tablename="";

if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("move") != null) {
	
	try{
		pat_id = request.getParameter("patid");
		tablename = request.getParameter("tname");
		if(pat_id.length()>10 && tablename.length()>4)
		out.println(movePatient(pat_id,tablename));
	}catch(Exception ex){out.println("Error40989 : "+ex.toString());}

}

else{
String pat_type="",min="",max="";
try{
	pat_type=request.getParameter("pat_type");
	min=request.getParameter("min");
	max=request.getParameter("max");
}catch(Exception ex){
	out.println("Error708753 : "+ex.toString());
	}	
%>
<%if(pat_type !=null || max!=null || min!=null){%>
<body>
<div class="container-fluid">
<div class="row">
<div class="col-sm-4">Center</div>
<div class="col-sm-4"></div>
<div class="col-sm-4">NOP</div>
</div>

<div class="col-sm-12">
<table class="table">
<thead>
<tr>
<td>PatientID</td>
<td>Category</td>
<td>Reg. Date</td>
<td>Assigned Physician</td>
<%try{if(pat_type.equals("tele")){%>
<td>Referring Physician</td>
<%}}catch(Exception ex){}%>
<td>Last checked</td>
<td>MOVE</td>
</tr>
</thead>
<tbody>
<%
//out.println(getServletContext().getRealPath("/"));

	Connection con = null;
	try{
		String sql = "";
		if(pat_type.equals("tele"))
			sql = "select * from tpatq_treated limit "+min+","+max+"";
		else if(pat_type.equals("loc"))
			sql = "select * from lpatq_treated limit "+min+","+max+"";
		else
			sql = "";
		con = mySqlcon();
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while(rs.next()){
			out.println("<tr><td>"+rs.getString("pat_id")+"</td>");
			out.println("<td>"+rs.getString("discategory")+"</td>");			
			out.println("<td>"+rs.getString("entrydate")+"</td>");
			out.println("<td>"+rs.getString("assigneddoc")+"</td>");
			if(pat_type.equals("tele"))
				out.println("<td>"+rs.getString("refer_doc")+"</td>");
			out.println("<td>"+rs.getString("data_moved")+"</td>");
			out.println("<td class='pat_move "+rs.getString("pat_id")+"'><span class='glyphicon glyphicon-export mtolpatq'></span></td></tr>");
		}
		con.close();
	}catch(Exception ex){out.println("Error098087 : "+ex.toString()+pat_type);}
	out.println("</tbody></table></div></div></body></html>");
}
%>

<%}%>
