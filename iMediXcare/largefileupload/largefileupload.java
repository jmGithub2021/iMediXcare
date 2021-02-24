package imedixservlets;

import javax.servlet.*;
import imedix.cook;
import imedix.myDate;
import imedix.dataobj;
import imedix.rcDataEntryFrm;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;


public class largefileupload extends HttpServlet {
	String pid="", ftype="", desc="", lanme="", doc_name="", cdate="", currdate="", ext="",ext1="";
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
	cook cookx = new cook();
	/*String pid = cookx.getCookieValue("patid", req.getCookies());
	String userid = cookx.getCookieValue("userid", req.getCookies());
	res.setContentType("text/plain");
	
	try{

      String dirName = req.getRealPath("//")+"/temp/"+userid+"/"+pid;

   
      System.out.println("dirName >>>"+dirName);
      
      File fn=new File(dirName);
      if(!fn.exists()){
      	fn.mkdirs();
      }
     
      MultipartRequest multi = new MultipartRequest(req, dirName, 10*1024*1024); // 10MB
      System.out.println("Params:");
      
      Enumeration params = multi.getParameterNames();
      while (params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String value = multi.getParameter(name);
			System.out.println(name + " = " + value);
      }
      System.out.println();

      System.out.println("Files:");
	  boolean ok2Continue = false;
	   String configFile="";
      Enumeration files = multi.getFileNames();
      while (files.hasMoreElements()) {
       
		String name = (String)files.nextElement();
        String filename = multi.getFilesystemName(name);
        String type = multi.getContentType(name);
        File f = multi.getFile(name);
        System.out.println("name: " + name);
        System.out.println("filename: " + filename);
        System.out.println("type: " + type);
        if (f != null) {
          System.out.println("f.toString(): " + f.toString());
          System.out.println("f.getName(): " + f.getName());
          System.out.println("f.exists(): " + f.exists());
          System.out.println("f.length(): " + f.length());
			if (f.getName().endsWith(".config")) {
				configFile =  f.toString();
				ok2Continue=true;
			}
			else ok2Continue=false;

          System.out.println();
        }
      }
	
	
	
	  if (ok2Continue==true) {
	  	
	  	
	  	 String fname="",dpath="", patid="",desc="",labname="",docname="",filetype="",testdate="";
	  	 
		 String cdate=myDate.getCurrentDate("dmy",false);
		 String currdate=myDate.getCurrentDate("ymd",true);
		 
		 int tparts=0;
	 
	  		
	  		boolean mDone=false;
	  		
			System.out.println("OKAY : Trying to Merge Now.....");
			String currLine;
			BufferedReader br = new BufferedReader(new FileReader( configFile));
			while ((currLine = br.readLine()) != null) { // while loop begins here
				System.out.println(currLine);
				String ary[] = currLine.split(" : ");
				if (ary[0].equalsIgnoreCase("File Name")) fname = ary[1];
				if (ary[0].equalsIgnoreCase("Part Size")) tparts = Integer.parseInt(ary[1]);
				if (ary[0].equalsIgnoreCase("PATIENTID")) patid = ary[1];
				if (ary[0].equalsIgnoreCase("DESCRIPTION")) desc = ary[1];
				if (ary[0].equalsIgnoreCase("LAB NAME")) labname = ary[1];
				if (ary[0].equalsIgnoreCase("DOC NAME")) docname = ary[1];
				if (ary[0].equalsIgnoreCase("FILE TYPE")) filetype = ary[1];
				if (ary[0].equalsIgnoreCase("TEST DATE")) testdate = ary[1];
			} // end while
			
			//testdate=myDate.getCurrentDate("dmy",false);
			filetype=filetype.toLowerCase();
			
			String ext=fname.substring(fname.lastIndexOf("."));
			
			System.out.println(dirName);	
			if(!dirName.equalsIgnoreCase("")) dirName=dirName+"/";
			String mFilePath=req.getRealPath("//")+"/data/"+"/"+pid+"/";
			fn=new File(mFilePath);
			if(!fn.exists()) fn.mkdirs();
			
			String mFileName=pid+cdate+filetype+"new"+ext;	
		
			System.out.println("dpath :"+mFilePath);		
			int MaxBS = 1024*20;
			
			try{
				RandomAccessFile ofile = new RandomAccessFile(mFilePath+mFileName, "rw");
				
				for(int i=1; i<tparts; i++)	{	
					String filePart = dirName + fname + ".part" + Integer.toString(i);
					RandomAccessFile pf = new RandomAccessFile(filePart, "r");
					long ln=pf.length();
					while(ln>0){
						byte buffer[];
						if(ln>=MaxBS) buffer = new byte[MaxBS];
						else buffer = new byte[(int) ln];
						int read = pf.read(buffer);
						System.out.println(i+ " : "+read);
						if (read==-1) break;
						ln=ln-read;
						ofile.write(buffer);
					}
					pf.close();

					File  pfd=new File(filePart);
					boolean kk = pfd.delete();
					
					System.out.println("Del tag :"+kk);
				}
				
				long fsize=ofile.length();			
				ofile.close();
				
				System.out.println("Processing Done");
				mDone=true;
				
			} // end try
			catch (IOException e) {
				System.out.println("Error: " + e);
				mDone=false;
			}
			

			
		////////////// ======================= /////////////////////////////////////////////
		
			if(mDone==true){ */
			dataobj obj = new dataobj();	
			rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));
			String para,s;
			try{
				StringBuffer stringbuffer = new StringBuffer();
				BufferedReader bufferedreader = httpservletrequest.getReader();

				while((s = bufferedreader.readLine()) != null) 
				{
					if(stringbuffer.length() > 0) stringbuffer.append('\n');
	            	stringbuffer.append(s);
				}
	        
				bufferedreader.close();
				para = stringbuffer.toString();
				String as[] = para.split("&");
				pid=as[0];
				ftype=as[1];
				desc=as[2];
				lanme=as[3];
				doc_name=as[4];
				currdate=as[5];
				cdate=as[6];
				ext=as[7];
				ext1=as[8];
				
				
				obj.add("pat_id",pid);
				obj.add("type",ftype);
				obj.add("imgdesc",desc);
				obj.add("lab_name",lname);	
				obj.add("doc_name",doc_name);
				obj.add("testdate",currdate);
				obj.add("entrydate",currdate);
				
							
				obj.add("con_type","LRGFILE");

				String ext1=ext.substring(1);
				obj.add("ext",ext1);
				int ans=rcdef.UploadHttp(obj,null);
				
				if(ans>=0){
					String mFilePath = request.getRealPath("/largefileupload/DATA/"+pid+"/");
					String mFileName=pid+cdate+ftype+"new"+ext;
					String mFileName1=pid+cdate+ filetype +Integer.toString(ans)+ext;
					
					System.out.println(mFileName);
					System.out.println(mFileName1);
					File fn1 = new File (mFilePath+mFileName);
					File fn2 = new File (mFilePath+mFileName1);
					
					System.out.println("="+Integer.toString(ans)+"=");
					fn1.renameTo(fn2);	
				}  				
			}


	 ////////////// ===================== ////////////////////////	
	 
			
			
	  
	  	
	  	
 	catch (Exception e){ 
 		System.out.print("largefilepload Exception :"+ e.toString());
 	}	
}

}
