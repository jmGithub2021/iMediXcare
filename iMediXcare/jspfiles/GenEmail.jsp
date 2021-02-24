<%@ page import="java.io.File,java.io.IOException,java.util.List,javax.servlet.ServletException, javax.servlet.http.HttpServlet,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse"%>
<%@ page import="org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.FileItemFactory,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*,imedix.myDate"%>
<%@page import="imedix.SMS,imedix.Email"%> 
<% 
	String fileGenErrors = "", attachName="", email="", mesg="", subject="", hasAttachment="N" ;
	String pid ="admin";
	
	String UPLOAD_DIRECTORY = request.getRealPath("/");
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		// Create a factory for disk-based file items
		FileItemFactory factory = new DiskFileItemFactory();
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			// Parse the request
			List<FileItem> multiparts = upload.parseRequest(request);
			hasAttachment="N";
			/*
			for (FileItem item : multiparts) {
			  if (!item.isFormField()) {
				 if (item.getName() == null || item.getName().isEmpty()) {
					  hasAttachment="N";
				 }
				 else {
					 String name = new File(item.getName()).getName();
					 String ext=name.substring(name.lastIndexOf(".")); //1
					 String cdate=myDate.getCurrentDate("dmy",false); //4
					 String mFileName=pid+"_"+String.valueOf(System.currentTimeMillis())+ext; //2
					 attachName = UPLOAD_DIRECTORY + "temp/" + mFileName;
					 item.write(new File(attachName));
					 File file = new File(attachName);
					 if (file.exists() && file.length()>0) {
						 hasAttachment="Y";
						 out.println("File.isExists:" + file.exists() + ", File.Size:"+file.length());
					 }
				 }
			  }
			}
			*/
			// Ugly Procedure but this will ensure file is uploaded first.
			for (FileItem item : multiparts) {
			  if (item.isFormField()) {
				   if ( item.getFieldName().equalsIgnoreCase("email")) email = item.getString();
				   else if ( item.getFieldName().equalsIgnoreCase("mesg")) mesg = item.getString();
				   else if ( item.getFieldName().equalsIgnoreCase("subj")) subject = item.getString();
			  }
			}
		
			//out.println("Email: " + email);
			//out.println("Subje: " + subject);
			//out.println("Mesgd: " + mesg);
			//out.println("attNM: " + attachName);
			///// Tested OKAY
			//email = "ddprasad@gmail.com";
			Email emailSent = new Email(request.getRealPath("/"));
			hasAttachment="N";
			if ( hasAttachment.equalsIgnoreCase("Y")) {
				if (!email.isEmpty()) fileGenErrors = emailSent.SendWA(email,subject,mesg,attachName);
				else fileGenErrors = "Empty Email: ["+email+"]";
				fileGenErrors += " (WA)";
			}
			else {
				if (!email.isEmpty()) fileGenErrors = emailSent.Send(email,subject,mesg);
				else fileGenErrors = "Empty Email: ["+email+"]";
				fileGenErrors += " (WoA)";
			}
			out.println (fileGenErrors);
		} 
		catch (Exception e) 
		{
		  e.printStackTrace(new java.io.PrintWriter(out));
		  out.println("File upload failed");
		}
              
    }		
%>