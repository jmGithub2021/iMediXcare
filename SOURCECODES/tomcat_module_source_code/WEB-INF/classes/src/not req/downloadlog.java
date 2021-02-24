package imedixservlets;

import javax.servlet.*;
import imedix.cook;
import imedix.myDate;
import imedix.dataobj;
import imedix.rciMediXSQLLog;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;


public class downloadlog extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		res.setContentType("text/plain");
		//String ccode=req.getParameter("ccode");
		String ccode=req.getParameter("pid");
			
		try{
         	
         	rciMediXSQLLog  SQLLog = new rciMediXSQLLog(req.getRealPath("//"));     
            PrintWriter printwriter = res.getWriter();
			printwriter.println("NoData");
			String SQL=SQLLog.getAllSQLsData("");
	    	printwriter.close();

 		}catch (Exception e){ 
 			System.out.print("uploadlog Exception :"+ e.toString());
 		}	
	}

}