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
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.json.simple.*;
import org.json.simple.parser.*;
import com.oreilly.servlet.MultipartRequest;

public class uploadPathologydata extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
		
		System.out.println("POST request");
		PrintWriter out = response.getWriter();
		out.println("POST request done");

		
		File file ;
		try{
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 6000 * 1024;
		String filePath = request.getRealPath("/data/pathology")+"/";
		File ProjectDir = new File(filePath);
		long fileid = System.currentTimeMillis();
		if(! ProjectDir.exists())
		{
			ProjectDir.mkdir();
		}
		String contentType = request.getContentType();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax( maxFileSize ); 
			List fileItems = upload.parseRequest(request);
			Iterator i = fileItems.iterator();
			String pat_id="",test_id="",extension="";			
			
			int c=1;
				while ( i.hasNext () ) 
				{				
					c++;
					fileid += c;
				FileItem fi = (FileItem)i.next();
					if (fi.isFormField()) {
						out.println("KEY : "+fi.getFieldName());
						if(fi.getFieldName().equals("patid")){
							pat_id = fi.getString();
						}
						if(fi.getFieldName().equals("testid")){
							test_id = fi.getString();	
							if(!rcdef.isValidTestId(test_id))
								test_id = null;
						}							
						out.println(pat_id+" : "+test_id);
					} 	
					if ( !fi.isFormField () )  {
						String fieldName = fi.getFieldName();
						String fileName = fi.getName();
						int extc = fileName.lastIndexOf('.');
						if (extc > 0) {
							extension = fileName.substring(extc+1);
						}						
						out.println("ME : "+fieldName+" : "+fileName);
						boolean isInMemory = fi.isInMemory();
						long sizeInBytes = fi.getSize();
						file = new File(filePath+fileid+"."+extension) ;
						fi.write( file ) ;
						

						dataobj obj = new dataobj();
						obj.add("pat_id",pat_id);
						obj.add("test_id",test_id);
						obj.add("fileId",String.valueOf(fileid));
						obj.add("fileSize",Long.toString(sizeInBytes));
						obj.add("extension",extension);
						if(rcdef.uploadPathologydata(file,obj))
							out.println("Uploaded !");
						//file.delete();
				
					}
				}


				ProgressListener progressListener = new ProgressListener(){
   public void update(long pBytesRead, long pContentLength, int pItems) {
       System.out.println("We are currently reading item " + pItems);
       if (pContentLength == -1) {
           out.println("So far, " + pBytesRead + " bytes have been read.");
       } else {
          out.println("So far, " + pBytesRead + " of " + pContentLength
                              + " bytes have been read.");
       }
   }
};
upload.setProgressListener(progressListener);	

				
		}catch(Exception ex){out.println("ERROR folder creation : "+ex.toString());}
				
		
		
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		PrintWriter out = response.getWriter();
		out.println("GET method does not allow this servlet");
	}
	
	//public int uploadFile(){}
} 
