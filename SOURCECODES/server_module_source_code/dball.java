package imedix;

import java.sql.*;
import java.io.*;
import java.util.Vector;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This Class used for Manage Database Operations. 
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see AdminJobs
 */
 
public class dball{
	projinfo pinfo;
	
	/**
     * Constructor used to create a object.
     * @param info server Configuration class object.
     */
     
	public dball( projinfo info){
		pinfo=info;
	}
	/**
 	* Method used to Execute Insert, Update & Delete Sql.  
 	*
 	* @param  isql	SQL String
  	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	* @see        	Connection
 	* @see        	Statement
 	*/
    public String ExecuteSql(String isql)
	{			
			String ans="Error";
			
			Connection conn = null;
			Statement stmt = null;
			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				int rc=stmt.executeUpdate(isql);
				
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")) createSqlLog(isql);	
											
				
				if(rc==0) ans="Error";
				else ans="Done";
				
			}
			catch (Exception e) {
				System.out.println("Error ExecuteSql >> ::  " + e.toString()+"\n"+isql);	
				ans="Error";	
			}finally{
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
		return ans;
	}
	
	/**
 	* Method used to Execute Insert, Update & Delete Sql Using PreparedStatement.   
 	*
 	* @param  isql	SQL String
 	* @param  prms	String Array with param values
 	* @param  nop	No of param in  Array
  	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
	public String ExecuteSql(String isql,String prms[],int nop){			
			String ans="Error";
			
			Connection conn = null;
			PreparedStatement stmt = null;
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.prepareStatement(isql);
				for(int i=1;i<=nop;i++) stmt.setString(i, prms[i-1]);
				int rc=stmt.executeUpdate(isql);
				//System.out.println(" ExecuteSql >>>>  : "+isql);
				
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")) createSqlLog(isql);				
										
				stmt.close();
				conn.close();
				
				if(rc==0) ans="Error";
				else ans="Done";
				
			}
			catch (Exception e) {
				System.out.println("Error ExecuteSql >> ::  " + e.toString()+"\n"+isql);	
				ans="Error";
				
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
		return ans;
	}
	
	
	/**
 	* Method used to Execute Transactions.   
 	*
 	* @param  isql	SQL String. Each SQL String are Separate with #IMX# Separator.
  	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
	public String ExecuteTrans(String isql)
	{			
			String ans="Error";
			
			Connection conn = null;
			Statement stmt = null;
			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				conn.setAutoCommit(false);
				stmt = conn.createStatement();	
				String iSql[]=isql.split("#IMX#");
				int rc=0;
				for(int i=0;i<iSql.length;i++){
					if(iSql[i].length()>4){
						//System.out.println(" ExecuteSql >>>>  : "+iSql[i]);
						rc=stmt.executeUpdate(iSql[i]);						
						}
				}
				
				conn.commit(); 					
				
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")) createSqlLog(isql);	
				
				stmt.close();
				conn.setAutoCommit(true);
				conn.close();
				ans="Done";
			
			}catch (Exception e) {
				ans="Error";
				try{
					conn.rollback();
					conn.setAutoCommit(true);
					conn.close();
				}catch (Exception ex) {
					System.out.println("ExecuteSql >> ::  " + ex.toString());	
				}
				System.out.println("Error ExecuteSql >> ::  " + e.toString()+"\n"+isql);	
				
			}
			
		return ans;
	}
	
	/**
 	* Method used to Execute Selact SQL.   
 	*
 	* @param  qsql	Select SQL String
  	* @return    	Vector with dataobj Objects. dataobj holds data of each records. 
 	*				Value of each fields are stored as data object.
  	* @see        	dataobj
 	* @see        	data
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
	public Object ExecuteQuary(String qsql)
	{
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;
			Vector alldata=new Vector();
			
			
		    ResultSetMetaData rsmd=null;
		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(qsql);
				rsmd= rset.getMetaData();
				int nofc = rsmd.getColumnCount();
				while (rset.next()) {
					dataobj tmp = new dataobj();
					for(int i=1;i<=nofc;i++) {
						String cn=rsmd.getColumnName(i);
						String cv=rset.getString(i);
						if(cv==null) cv="";
					//	System.out.println(cn+ "-> "+cv);
						cv=cv.replaceAll("\r\n","<br>");
						tmp.add(new data(cn,cv));
					}
					//System.out.println("rs->"+tmp.getAllValue());
					alldata.add(tmp);
				}
				rset.close();
				rsmd=null;
				stmt.close();
				conn.close();
			
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")) createSqlLog(qsql);	
						
				return (alldata);
			
			}catch (Exception e) {
				
				try{
					stmt.close();
					conn.close();	
				}catch(Exception ex){
					
				}
				System.out.println("Error found " + e.toString() + " : \n"  +qsql );	
				return(e.toString()+" : "+qsql);
				
			}
	}
	
	/**
 	* Method used to Execute Stored Procedure.   
 	*
 	* @param  qsql	SQL Command to Execute Stored Procedure.
  	* @return    	Vector with dataobj Objects. dataobj holds data of each records. 
 	*				Value of each fields are stored as data object.
  	* @see        	dataobj
 	* @see        	data
 	* @see        	Connection
 	* @see        	prepareCall
 	* @see        	Statement
 	*/
 	
	public Object ExecuteProcQuary(String qsql)
	{
			Connection conn = null;
			CallableStatement stmt = null;
			ResultSet rset = null;
			Vector alldata=new Vector();
			
		    ResultSetMetaData rsmd=null;;
		 			
			try {
				
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.prepareCall(qsql);// createStatement();
				//rset = stmt.executeQuery();
				boolean ans= stmt.execute();
				
				
				while(ans==true){
					rset = stmt.getResultSet();
					rsmd= rset.getMetaData();
					int nofc = rsmd.getColumnCount();
					//System.out.println("nofc : "+nofc);

					Vector ResData=new Vector();
					
					while (rset.next()){
						dataobj tmp = new dataobj();
						for(int i=1;i<=nofc;i++) {
							String cn=rsmd.getColumnName(i);
							String cv=rset.getString(i);
							if(cv==null) cv="";
							
						//	System.out.println(cn+ "-> "+cv);
							
							tmp.add(new data(cn,cv));
						}
						
					//	System.out.println("rs->"+tmp.getAllValue());
						
						ResData.add(tmp);
					}

					alldata.add(ResData);
					ans = stmt.getMoreResults();
				//	System.out.println("ans : "+ans);
										
				}
				
				System.out.println("alldata : "+alldata.size());
				
				rset.close();
				rsmd=null;
				stmt.close();
				conn.close();
				return (alldata);
							
			}catch (Exception e) {
				try{
					stmt.close();
					conn.close();
				}catch(Exception ex){
					
				}
				
				System.out.println("Error found " + e.toString() + " : "  +qsql );	
				return(e.toString()+" : "+qsql);
			}
	}
	
	

 	
 	/**
 	* Method used to Execute SELECT Sql Using PreparedStatement.   
 	*
 	* @param  isql	SQL String
 	* @param  prms	String Array with param values
 	* @param  nop	No of param in  Array
    * @return    	Vector with dataobj Objects. dataobj holds data of each records. 
 	*				Value of each fields are stored as data object.
 	* @see        	dataobj
 	* @see        	data
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
	public Object ExecutePQuary(String qsql,String prms[],int nop)
	{
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rset = null;
			Vector alldata=new Vector();
			
		    ResultSetMetaData rsmd=null;;
		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.prepareStatement(qsql);
				
				for(int i=1;i<=nop;i++) stmt.setString(i, prms[i-1]);
				
				rset = stmt.executeQuery();
				rsmd= rset.getMetaData();
				
				int nofc = rsmd.getColumnCount();
				
				while (rset.next()) {
					dataobj tmp = new dataobj();
					for(int i=1;i<=nofc;i++) {
						String cn=rsmd.getColumnName(i);
						String cv=rset.getString(i);
						if(cv==null) cv="";
					//	System.out.println(cn+ "-> "+cv);
						tmp.add(new data(cn,cv));
					}
					//System.out.println("rs->"+tmp.getAllValue());
					
					alldata.add(tmp);
				}
				rset.close();
				rsmd=null;
				stmt.close();
				conn.close();
				return (alldata);
			
			}
			catch (Exception e) {
				
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
				
				System.out.println("Error found " + e.toString() + " : "  +qsql );	
				return(e.toString()+" : "+qsql);
			}
	}
	
	
	/**
 	* Method used to Execute Stored Procedure that return single value.   
 	*
 	* @param  qsql	SQL Command to Execute Stored Procedure.
  	* @return    	Result of the Sql.
 	* @see        	Connection
 	* @see        	prepareCall
 	* @see        	Statement
 	*/
 		
	public String ExecuteProcSingle(String qsql)
	{	
			Connection conn = null;
			CallableStatement stmt = null;
			ResultSet rset = null;
			String str="";
		 		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.prepareCall(qsql); //.createStatement();
				rset = stmt.executeQuery();	
				rset.next();
				
				//while (rset.next()) {
					str=rset.getString(1);
				//	}

				rset.close();
				stmt.close();
				conn.close();
				
				
			}
			catch (Exception e) {
				System.out.println("Error found " + e.toString());
				System.out.println("qsql " + qsql);
				str="";		
				
			}finally{
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
			
			return str;
		}
	
	/**
 	* Method used to Execute Select SQL that return single value.   
 	*
 	* @param  qsql	SQL Command to Execute Stored Procedure.
  	* @return    	Result of the Sql.
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
	public String ExecuteSingle(String qsql)
	{	
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;
			String str="";
		 		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(qsql);
				rset.next();
					
				//while (rset.next()) {
					str=rset.getString(1);
			//	}
				rset.close();
				stmt.close();
				conn.close();
				
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")) createSqlLog(qsql);	
					
				
			}
			catch (Exception e) {
				System.out.println("Error found " + e.toString());
				System.out.println("qsql " + qsql);
				str="";		
			}finally{
				try{
					stmt.close();
					conn.close();	
				}catch(Exception ex){
				}
			}
			
			return str;
		}
			
	//////////////
	
	/**
 	* Method used to Execute Insert Sql With a Image or Document etc.(byte[]) value.   
 	*
 	* @param  isql	SQL String
 	* @param  img	byte[] Array of Image, Document etc.
  	* @return    	"Done" for successfully Execute or "Error" for Exception.
 	* @see        	Connection
 	* @see        	Statement
 	*/
 	
    public String ExecuteImage(String isql,byte[] img)
	{	
			String ans="Error";

			Connection conn = null;		
			PreparedStatement pstmt = null;		 		 			
			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				pstmt = conn.prepareStatement(isql);
				pstmt.setBytes(1,img);	
				pstmt.executeUpdate();
				
			/////
			
			
				if(pinfo.GeneralSqlLog.equalsIgnoreCase("yes")){
					String imgHex="0x" + StringUtils.getHexString(img);
					isql=isql.replaceAll("\\?",imgHex);
					createSqlLog(isql);	
					 
				}
					
		////		
				pstmt.close();	
				conn.close();
				ans="Done";
				
			}
			catch (Exception e) {
				System.out.println("Error found " + e.toString());
				System.out.println("isql " + isql);	
				ans="Error";
			}finally{
				try{
					pstmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
			
			return ans;
		}		
				
	
	/**
 	* Method used to Execute Select Sql to read Image, Document etc.(byte[]) value.   
 	*
 	* @param  isql	SQL String
 	* @return    	byte[] Array. NULL for not found the record.
 	* @see        	Connection
 	* @see        	Statement
 	*/
 		
	public byte[] ExecuteImage(String qsql)
	{	
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;
			byte[] img = null;
				 		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(qsql);	
				while (rset.next()) {
					img = rset.getBytes(1);
				}
				rset.close();
				stmt.close();
				conn.close();
			}
			catch (Exception e) {
				System.out.println("Error found " + e.toString());
				System.out.println("qsql " + qsql);	
			}finally{
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
			
			return img;
		}
	
	
	/**
 	* Method used to get MetaData of a Table.   
 	*
 	* @param  isql	SELECT SQL MetaData of a Table.
 	* @return    	A formatted String with Details of MetaData. 
 	*				Used '&' Separator to separate value of each field.
 	*				Used '=' Separator to separate field name and field type of each field value.
 	* @see        	Connection
 	* @see        	Statement
 	*/
	public String FieldTypesmeta(String isql)
		{
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;
			String str="";
			ResultSetMetaData metadata = null;
		
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(isql);
				metadata = rset.getMetaData();
  				int numcols = metadata.getColumnCount();
  				
				for ( int i = 1 ; i <= numcols ; i++ )
					str = str + metadata.getColumnName(i) + "="+metadata.getColumnTypeName(i)+"&";
				rset.close();
				stmt.close();
				conn.close();
				//System.out.println(str);
			}
			catch (Exception e) {
				System.out.println("Error found " + e.toString());	
				str=e.toString();		
			}finally{
				try{
					stmt.close();
					conn.close();
					
				}catch(Exception ex){
					
				}
			}
			
			return str;
		}
	
	/**
 	* Method used Create a General Sql Log.   
 	*
 	* @param  allsql SQL STRING.
 	*/
 		
		
	public void createSqlLog(String allsql)	{
		
		try {
		   	String activepath =  pinfo.GeneralSqlLogPath;
           	File logdir = new File(activepath);
           	//System.out.println("createSqlLog 1" +activepath );
           	if(!logdir.exists()) logdir.mkdirs();
           	
            allsql=allsql.replaceAll("\r\n","\\\\r\\\\n");
            
           //System.out.println("createSqlLog 2");
            		
			FileWriter fWrite =  new FileWriter(activepath + "/LocalLogAfterSend.sql" ,true);
			//System.out.println("createSqlLog 3");
			
			fWrite.write(SQLSanitize.Sanitize(allsql));
			fWrite.write(" ;\r\n");

			fWrite.close();			
        }catch (Exception e) {
			System.out.println("Error In createSqlLog " + e.toString());					
		}  
		}
    }
    
        
   

