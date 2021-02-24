package imedixservlets;

import imedix.dataobj;
import imedix.*;
import imedix.rcDataEntryFrm;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.sql.*;
import org.json.simple.*;
import org.json.simple.parser.*;
import com.oreilly.servlet.MultipartRequest;


public class uploadfilehttp extends HttpServlet {	
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   res.setContentType("text/html");
		try{
		dataobj obj = new dataobj();	
		/*
		String usr="";
		Cookie[] cook = req.getCookies();
		
			for(int i = 0; i < cook.length; i++) 
			{	
				if( cook[i].getName().equals("userid") )
				{
				  usr=cook[i].getValue();
				}
			}
		*/
		
		String headername = "";
			for(Enumeration e = req.getHeaderNames(); e.hasMoreElements();){
				headername = (String)e.nextElement();
				System.out.println(req.getHeader(headername));
			}
			
		
		cook cookx = new cook();
	    String usr =cookx.getCookieValue("userid", req.getCookies ());
	    String ccode =cookx.getCookieValue("center", req.getCookies());
	    
		rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));	
		String UploadPath=req.getRealPath("//")+"/temp/"+usr+"/";

		MultipartRequest multi = new MultipartRequest(req,UploadPath,52428800);	//6291456
						
		Enumeration files = multi.getFileNames();		//Returns the names of all the uploaded files as an Enumeration of Strings
		Enumeration param = multi.getParameterNames();	//Returns the names of all the parameters as an Enumeration of Strings.
		String nam="";

		String id,newfile="",ftype,tabnam="",qr,sl="",namf="";
		String desfile="",sqlQuery="";
		int nu=0;
		//id = multi.getParameter("id").toLowerCase().trim();
		obj.add("pat_id",multi.getParameter("pat_id"));
		//ccode = id.substring(0,3).toLowerCase();
		//ftype = multi.getParameter("type");

		obj.add("type",multi.getParameter("type"));
		//obj.add("imgdesc",multi.getParameter("imgdesc"));
		obj.add("lab_name",multi.getParameter("lab_name"));
		obj.add("doc_name",multi.getParameter("doc_name"));
		obj.add("testdate",multi.getParameter("testdate"));
		obj.add("entrydate",myDate.getCurrentDateMySql());
		obj.add("userid",cookx.getCookieValue("userid", req.getCookies ()));
		obj.add("center",cookx.getCookieValue("center", req.getCookies ()));
		
		
		String type = multi.getParameter("type");
		if(type.equalsIgnoreCase("DOC") || type.equalsIgnoreCase("SND") || type.equalsIgnoreCase("TEG")){
			obj.add("docdesc",multi.getParameter("imgdesc"));
		}if(type.equalsIgnoreCase("MOV")){
			obj.add("movdesc",multi.getParameter("imgdesc"));
		}
		
		while (files.hasMoreElements()) {
			String name = (String)files.nextElement();	//read the 1st value of files (Enumeration variable)		
			String filename = multi.getFilesystemName(name);			
			String ctype = multi.getContentType(name);			
			String ext = filename.substring(filename.lastIndexOf(".")+1);

			ext=ext.toLowerCase();
			obj.add("con_type",ctype);
			obj.add("ext",ext);

			File f = multi.getFile(name);
			
			//System.out.println("name: " + name+"<BR>");			
			//System.out.println("filename: " + filename+"<BR>");			
			//System.out.println("type: " + ctype+"<BR>Ext : " + ext+"<BR>");	
			
			
			if(f.exists())
			{
				obj.add("size",Integer.toString((int)f.length()));		
				InputStream is = new FileInputStream(f);
				byte b[] = new byte[ (int) f.length()];
				is.read(b);
				is.close();
				//Durga Addition Begins here for OrthanC @04-August-2015
				String cmdfile = "x";
				String cmdOut = "x";
				
			/*	try{
				if (ext.equalsIgnoreCase("dcm")==true) {
					// 	curl -X POST http://localhost:8042/instances --data-binary @CT.X.1.2.276.0.7230010.dcm
					cmdfile = " curl -X POST http://localhost:8042/instances --data-binary @" + UploadPath+filename+" ";
					cmdOut = Upload2Orthanc(cmdfile);
	
				cmdOut=cmdOut.replace("\n", "");
					cmdOut=cmdOut.replace("\r", "");
					cmdOut=cmdOut.replace("{", "");
					cmdOut=cmdOut.replace("}", "");
					cmdOut=cmdOut.replace("\"", "");
					cmdOut=cmdOut.trim();
					String JOBJs[] = cmdOut.split(",");
					String IDs[] = JOBJs[0].split(":");
					//cmdOut = "[ <a class='btn btn-info' href='pullOrthanc.jsp?id=" + IDs[1].trim() + "'>getFrom WADO</a> ]"; 
					cmdOut = "[ <a class='btn btn-info' href='pullOrthanc.jsp?id=" + cmdfile + "'>getFrom WADO</a> ]"; 
					System.out.println("DCM is being uploaded : " + cmdfile);
					System.out.println("Received from Server  : " + cmdOut);
					//{ "ID" : "99f95317-37393a11-285e0502-457c5165-ea3eb6e6", "Path" : "/instances/99f95317-37393a11-285e0502-457c5165-ea3eb6e6", "Status" : "Success"}
					
					//JSONObject json = (JSONObject)new JSONParser().parse(cmdOut);
				}
				}catch(Exception ex){System.out.println("DICOM EXCEPTION Orthanc"+ex.toString()+" : "+cmdfile);}*/
				if (cmdOut.equalsIgnoreCase("x")==true) obj.add("imgdesc",multi.getParameter("imgdesc"));	
				else obj.add("imgdesc",multi.getParameter("imgdesc") + " $ " + cmdOut);			
				//System.out.println(f.length());
				//Durga Addition Ends here for OrthanC @04-August-2015
			
			
				int ans=rcdef.UploadHttp(obj,b);
				boolean r=f.delete();
			}			
     }
 		
 }catch (Exception e){ 
 	System.out.print("uploadfilehttp Exception :"+ e.toString());
 }	

		res.sendRedirect(".."+"/jspfiles/showlist.jsp");
}


	private String Upload2Orthanc(String cmd) {
 
        String s = null, cmdOut=null;
 System.out.println(":::::::::: "+cmd+" :::::::::\n");
        try {
             
            Process p = Runtime.getRuntime().exec(cmd);
            BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
 
            BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
 
            // read the output from the command
            System.out.println("Here is the standard output of the command:\n");
            cmdOut="";
            while ((s = stdInput.readLine()) != null) {
                System.out.println(s);
                cmdOut+=s;
            }
             
            // read any errors from the attempted command
            System.out.println("Here is the standard error of the command (if any):\n");
            while ((s = stdError.readLine()) != null) {
                System.out.println(s);
            }
            return cmdOut;
            //System.exit(0);
        }
        catch (IOException e) {
            System.out.println("exception happened - here's what I know: ");
            e.printStackTrace();
            return "";
        }
    }
}
