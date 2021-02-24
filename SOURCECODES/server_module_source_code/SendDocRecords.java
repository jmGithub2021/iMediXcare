package imedix;

import java.sql.*;
import java.io.*;
import java.net.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import ftp.*;

class SendDocRecords{
	String a_doc="",rcenter="";
	projinfo pinfo;
	FtpBean ftp;
		
	Connection connd = null;
	Statement stmtd = null;
	ResultSet RSetd = null;
		
	public SendDocRecords(String id,String rc,projinfo p){
		a_doc=id;
		rcenter=rc;
		pinfo=p;
		ftp=new FtpBean();
		
	}
	
	public boolean CollectDocData(){
			
			boolean ans=true;
						
			String sql="Select * from login Where upper(rg_no)='"+a_doc+ "' ";
			Blob blob=null;
			String fldname="";
			try
			{
			Class.forName(pinfo.gbldbjdbccriver);
			connd = DriverManager.getConnection(pinfo.gbldburl, pinfo.gbldbusername, pinfo.gbldbpasswd);
			stmtd = connd.createStatement();
			RSetd=stmtd.executeQuery(sql);
			String frmfil="";
			while (RSetd.next()){
				frmfil="uid=^N/A"+"\n";
				frmfil+="pwd=^N/A"+"\n";
				frmfil+="name=^" + RSetd.getString("name").trim()+"\n";
				frmfil+="type=^doc"+"\n";  
				frmfil+="address=^"+RSetd.getString("address").trim()+"\n";
				frmfil+="phone=^"+RSetd.getString("phone").trim()+"\n";
				frmfil+="emailid=^"+RSetd.getString("emailid").trim()+"\n";
				frmfil+="dis=^"+RSetd.getString("dis").trim()+"\n";
				frmfil+="rg_no=^"+RSetd.getString("rg_no").trim()+"\n";
				frmfil+="qualification=^"+RSetd.getString("qualification").trim()+"\n";
				frmfil+="designation=^"+RSetd.getString("designation").trim()+"\n";
				frmfil+="center=^"+RSetd.getString("center").trim()+"\n";
				frmfil+="active=^"+RSetd.getString("active").trim()+"\n";
				blob = RSetd.getBlob("sign");
				fldname="DOC"+RSetd.getString("center").trim()+a_doc;
			}
			
			RSetd.close();
			stmtd.close();
			connd.close();
			
			byte [] _blob=null;
						
			if (blob==null){
				_blob = getBlankSign();
				System.out.println("Blob null"+_blob);
				
			}else{
				int length = (int)blob.length();
				_blob = blob.getBytes(1, length);
				System.out.println("Blob Not null"+_blob);
			}
			
						
			String docdir=pinfo.tempdatadir +"/senddata/doc/"+rcenter+"/"+fldname;
			String inffn=docdir+"/"+fldname+".info";
			String dnfn=docdir+"/"+fldname+".done";
			String ingfn=docdir+"/"+fldname+".sign.jpg";
			
			Date dt=new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss aaa");
			String donedata=sdf.format(dt)+"\n";
					
			System.out.println("==========DocDir:" + docdir);
			File dfld= new File(docdir);
			if(!dfld.exists()){
				System.out.println("********DocDir:" + docdir);
				dfld.mkdirs();
			}
			
			FileOutputStream fout = new FileOutputStream(inffn);
			byte b[] = new byte[frmfil.length()];
			frmfil.getBytes(0,b.length,b,0);
			fout.write(b);
			fout.close();
			
			System.out.println("inffn "+inffn);
			
			fout = new FileOutputStream(dnfn);
			byte bb[] = new byte[donedata.length()];
			donedata.getBytes(0,bb.length,bb,0);
			fout.write(bb);
			fout.close();
			System.out.println("dnfn "+dnfn);
			
			RandomAccessFile raf = new RandomAccessFile(ingfn,"rw");
			raf.write(_blob);
			raf.close();
			System.out.println("ingfn "+ingfn);	
							
			}
			catch(Exception ee)
			{
				System.out.println("Error in CollectDocData Connection:"+ee.toString());
				ans=false;
			}
			
			return ans;
		}
		
	private byte[] getBlankSign(){
		
			String bsign=pinfo.ps_home+"/images/blank.jpg";
			try{
			URL	url = new URL(bsign);
    		URLConnection urlConn = url.openConnection(); 
			byte [] xx = new byte [urlConn.getContentLength()] ;
			urlConn.getInputStream().read(xx);
			return xx;
			}catch(Exception e){
				System.out.println("Error in getBlankSign "+e.toString()+" : "+bsign);
				return null;
			}
		
		}
	
	
public boolean ftpSendDoc(){
	boolean ans=true;
	try{
	
		File directory = new File(pinfo.tempdatadir +"/senddata/doc/"+rcenter+"/");
		boolean exists = directory.exists();
		if (exists) {
			System.out.println(pinfo.ftphost+" : " + pinfo.ftpuser+" : " +pinfo.ftppasswd);						
			connect(pinfo.ftphost,pinfo.ftpuser,pinfo.ftppasswd);  // making ftp connection		
			gethome();
			String docpath[] =  pinfo.ftpdocsendpath.split("/"); //doc/Send
			System.out.println(pinfo.ftpdocsendpath);
			
			if(docpath.length>=2){
				mkdir(docpath[0]);
				cd(docpath[0]);	
				mkdir(docpath[1]);
				cd(docpath[1]);	
				
			}else{
				mkdir("doc");
				cd("doc");
				mkdir("Send");
				cd("Send");	
			}
			mkdir(rcenter);
			cd(rcenter);
			
			ans=visitAllDirsAndFilesDoc(directory);
			if (ans==true) deleteAllDirsAndFiles(directory);
				
			close();
				
    		} else {
        		System.out.println("Patient Data not Found, Transfer Fail");
    		}
					
	}catch(Exception e){
		ans=false;	
	}
	
	return ans;
}

private boolean visitAllDirsAndFilesDoc(File dir){
		boolean ans = true;
		int cnt=0;
		String dfile="",dpath="",sendfiles="",fns="",ex="";
		
		System.out.println("visitAllDirsAndFilesDoc :"+dir.getAbsolutePath());
			
		try{
		if (dir.isDirectory()) {
        String[] children = dir.list();
		for(int j=0;j<children.length;j++){
		File fff=new File(dir,children[j]);
		if(fff.isDirectory()){
			mkdir(children[j]);
			cd(children[j]);
			String[] children1 = fff.list();
			for (int i=0; i<children1.length; i++) {
				File ff=new File(fff,children1[i]);
				if(!ff.isDirectory())
				{
				String path=ff.getPath();
				fns=ff.getName();
				fns=fns.toUpperCase();
				
				if(fns.startsWith("DOC")){
					putFile(path,children1[i]);
					cnt++;
				}	
			}
			
		}// end i
		ctp();
		}
	  }	// end j
	}
	}catch(Exception fx1)
	{		
		System.out.println("File not found :"+fx1.toString());
		ans=false;
	}
	System.out.println("Total files Transfered ="+cnt);
	
	return ans;		
	
}


private  void deleteAllDirsAndFiles(File deldir) {

        	if (deldir.isDirectory()) {
           	String[] children = deldir.list();
            for (int k=0; k<children.length; k++) {
			File subdir=new File(deldir,children[k]);
			if(subdir.isDirectory())
			{
			String[] delfiles = subdir.list();
			for (int j=0; j<delfiles.length; j++) {

				File delfile=new File(subdir,delfiles[j]);
				if(delfile.isDirectory())
				{
					String[] delref = delfile.list();
					for (int i=0; i<delref.length; i++) {
						File delrefdir=new File(delfile,delref[i]);
						if(delrefdir.isFile())
						{
						boolean df=delrefdir.delete();
						}
					}
    				boolean delrefdir=delfile.delete();
				}
				else
				{
				boolean delf=delfile.delete();
				}
		     }
		     
		  }
			boolean delsubdir=subdir.delete();
	      }// end for
	}
	boolean delpatdir=deldir.delete();

    } // end of function
    

public void ctp()
		{
			try
        		{
	   		ftp.toParentDirectory();
			
			}
			catch(Exception e)
        		{
            		System.out.println("could not create directory"+e);
        		}
		}
		
		public void gethome()
		{
			try
        		{
	   		ftp.getDirectory();
			}
			catch(Exception e)
        		{
            		System.out.println("could not create directory"+e);
        		}
		}
		
		public void cd(String dd)
		{
			try
        		{
	   		ftp.setDirectory(dd);
			}
			catch(Exception e)
        		{
            		System.out.println("could not change directory"+e+" :"+ dd);
        		}
		}
		
		public void mkdir(String d)
		{
			try
        		{
	   		ftp.makeDirectory(d);
	
			}
			catch(Exception e)
        		{
            		System.out.println("could not create directory"+e +" :"+ d);
        		}
		}
		
		public void putFile(String sr,String ds){
       			try
        		{
           			ftp.putBinaryFile(sr,ds);
        		} 
			catch(Exception e)
        		{
            			System.out.println("could not upload, check user name"+e);
        		}
    	} 
	
		 public void connect(String host,String us,String pw){
        		try
       		 	{
            		ftp.ftpConnect(host,us,pw);
        		}
	 		catch(Exception e)
        		{
            		System.out.println("Login fail Enter correct user name");
        		}
    	}
    		
    	public void close(){
        	try{
            		ftp.close();
        	}catch(Exception e)
        	{
            			System.out.println(e);
        	}
    	}
    	
		
		
}