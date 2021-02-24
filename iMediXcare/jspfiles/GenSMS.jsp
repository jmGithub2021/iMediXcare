<%@ page import="java.io.File,java.io.IOException,java.util.List,javax.servlet.ServletException, javax.servlet.http.HttpServlet,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse"%>
<%@ page import="org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.FileItemFactory,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page language="java"  import= "imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*,imedix.myDate"%>
<%@page import="imedix.SMS,imedix.Email"%> 
<% 
	String fileGenErrors = "", attachName="", mobile="", mesg="", subject="", hasAttachment="N" ;
	String pid ="admin";
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		// Create a factory for disk-based file items
		FileItemFactory factory = new DiskFileItemFactory();
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			// Parse the request
			List<FileItem> multiparts = upload.parseRequest(request);

			for (FileItem item : multiparts) {
			  if (item.isFormField()) {
				   if ( item.getFieldName().equalsIgnoreCase("mobile")) mobile = item.getString();
				   else if ( item.getFieldName().equalsIgnoreCase("mesg")) mesg = item.getString();
				   else if ( item.getFieldName().equalsIgnoreCase("subj")) subject = item.getString();
			  }
			}
			mesg = subject + "\n" + mesg;
			//out.println("Mobile: " + mobile);
			//out.println("Subjec: " + subject);
			//out.println("Mesged: " + mesg);
			///// Tested OKAY
			//mobile = "01713161130";
			SMS smsSent = new SMS(request.getRealPath("/"));
			if (!mobile.isEmpty()) fileGenErrors = smsSent.Send(mobile,mesg);
			else fileGenErrors = "Empty mobile: ["+mobile+"]";
				
			out.println (fileGenErrors);
		} 
		catch (Exception e) 
		{
		  e.printStackTrace(new java.io.PrintWriter(out));
		  out.println("SMS Sending failed");
		}
              
    }		
%>