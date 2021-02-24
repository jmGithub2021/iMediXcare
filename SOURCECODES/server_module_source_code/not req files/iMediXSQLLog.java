
package imedix;

import java.rmi.*;
import java.io.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;

public class iMediXSQLLog extends UnicastRemoteObject implements iMediXSQLLogInterface {
		
	projinfo pinfo;
	dball mydb;
	
	public iMediXSQLLog(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public boolean saveAllSQLsData(String patid)throws RemoteException,SQLException{
	
		String filepath = pinfo.OffLineLocalLogDirPath+ "/" + patid + ".sql";            	
		String qsql= "SELECT DISTINCT type FROM listofforms WHERE pat_id ='"+patid+"'";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		boolean ans=true;;
		
		try {
			
			File logdir = new File(pinfo.OffLineLocalLogDirPath);
           	if(!logdir.exists()) logdir.mkdirs();
           	FileWriter fWrite =  new FileWriter(filepath ,true);
           	           	
			Class.forName(pinfo.gbldbjdbccriver);
			conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(qsql);
				
			while (rset.next()) {
				String tname=rset.getString("type");
				fWrite.write(getPatientDataFromTable(patid,tname));	
			}
			
			rset.close();
			stmt.close();
			conn.close();
		
			String tables[] = pinfo.PatientRecordTables.split(",");
			for(int i=0;i<tables.length;i++)
				fWrite.write(getPatientDataFromTable(patid,tables[i]));	
				
			fWrite.close();	
			}catch (Exception e) {
				System.out.println("Error found " + e.toString() + " : "  +qsql );	
				ans= false ;
			}			
		return ans;
	}
			
	public String  getAllSQLsData(String patid)throws RemoteException,SQLException{
		String filepath = pinfo.OffLineLocalLogDirPath+ "/" + patid + ".sql";        
		String qsql= "SELECT DISTINCT type FROM listofforms WHERE pat_id ='"+patid+"'";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		String output="";
		try {
		           	
			Class.forName(pinfo.gbldbjdbccriver);
			conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(qsql);
				
			while (rset.next()) {
				String tname=rset.getString("type");
					
				output=output+getPatientDataFromTable(patid,tname);
			}
			
			rset.close();
			stmt.close();
			conn.close();
			
			
			String tables[] = pinfo.PatientRecordTables.split(",");
			
			for(int i=0;i<tables.length;i++)
				output=output+getPatientDataFromTable(patid,tables[i]);
						
			}catch (Exception e) {
				System.out.println("Error found " + e.toString() + " : "  +qsql );	
	
			}
			
		return output;
		
	}

	private String getPatientDataFromTable(String patid,String tname){
	
		String sqlData="" , fld="",vals="";
		String output="";	
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		ResultSetMetaData rsmd=null;
		String qsql="";
		
		if(tname.equalsIgnoreCase("login")) qsql= "SELECT * FROM "+ tname;
		else qsql= "SELECT * FROM "+ tname+" WHERE pat_id ='"+patid+"'";
		
		try {        
				
			Class.forName(pinfo.gbldbjdbccriver);
			conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(qsql);
			rsmd= rset.getMetaData();
			int nofc = rsmd.getColumnCount();
			
			while (rset.next()){
				fld="";
				vals="";
				sqlData="";
			
				for(int i=1;i<=nofc;i++) {
					String cn=rsmd.getColumnName(i);
					fld=fld+","+cn;
					Object cv=rset.getObject(i);						
					if(cv==null) vals=vals +","+ "null";					
					else if(cv instanceof Date ){
						String fmt="yyyyMMdd HH:mm:ss";
						Date dt=(Date)cv;			
						vals=vals +","+"'"+myDate.dateFormat(fmt,dt)+"'";	
					}else if(cv instanceof byte[]) {
						byte[] b = (byte[])cv;
						String imgHex="0x" + StringUtils.getHexString(b);
						vals=vals+","+imgHex;
					}else {
						vals=vals+","+"'"+cv.toString().replaceAll("'","''")+"'";
						}
				}
				
				fld=fld.substring(1);
				vals=vals.substring(1);
				
				sqlData = "INSERT INTO " + tname + " (" + fld +") VALUES (" + vals + ") ;"; 
				
				sqlData=sqlData.replaceAll("\r\n","\\\\r\\\\n");
				
				output=output+sqlData+"\r\n";
				
			
			}
			
		rset.close();
		stmt.close();
		conn.close();
									
	}catch (Exception e) {
		System.out.println("Error found " + e.toString()+"\n" + qsql);	
		
	}
	
	return output;
					
 }
	
    public boolean setAllDataToDb(String SqlFile)throws RemoteException,SQLException{
	    boolean ans=true;
	    try{
	   		FileInputStream fstream = new FileInputStream(SqlFile);
    	    DataInputStream in = new DataInputStream(fstream);
        	BufferedReader br = new BufferedReader(new InputStreamReader(in));
    		String strLine;
    	    while ((strLine = br.readLine()) != null)   {
            	System.out.println (strLine);
            	mydb.ExecuteSql(strLine);
    		}
    		
    		in.close();
	   		ans=true; 
	    }catch(Exception e){
	    
	    ans=false;	
	    }
    	return ans; 	
    }
}
	