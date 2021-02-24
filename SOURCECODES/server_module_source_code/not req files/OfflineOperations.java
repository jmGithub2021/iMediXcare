package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Date;
import java.io.*;

public class OfflineOperations extends UnicastRemoteObject implements offlineInterface {
		
	projinfo pinfo;
	dball mydb;
	public OfflineOperations(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public byte[] downloadLog(String ccode)throws RemoteException,SQLException{
	
		try{
			File LogDir=new File(pinfo.OffLineLocalLogDirPath);
			String[] childlevel0 = LogDir.list();
			if( childlevel0.length <= 0 ){
        			System.err.println("Info:: Directory Empty: "+LogDir);
        			return null;
    		}
    		
    		for(int ii=0;  ii < childlevel0.length; ii++){
				File cdir=new File(LogDir,childlevel0[ii]);
				if(cdir.isDirectory()){
					String[] childlevel1 = cdir.list();
					for(int jj=0;  jj < childlevel1.length; jj++){
						File SqlFile=new File(cdir,childlevel1[jj]);	
						if(SqlFile.isFile()){
						
							if(SqlFile.getName().equalsIgnoreCase("sqllog.txt")){
								InputStream is = new FileInputStream(SqlFile);
								byte arr[] = new byte[ (int) SqlFile.length()];
								is.read(arr);
								is.close();
								//SqlFile.delete();
								//cdir.delete();
								return arr;
							}		
							
						}
					} //jj
				} // cdir
			} //ii
					
        		
		}catch(Exception e)	{
			System.out.println(e.toString());
			return null;	
		}
		
		return null;			
	}
	
    public String uploadLog(byte[] sqlData)throws RemoteException,SQLException{
     	
    	return "";
    }
    
}
