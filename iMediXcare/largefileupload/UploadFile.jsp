<%@ page import="java.io.File,java.io.IOException,java.util.List,javax.servlet.ServletException, javax.servlet.http.HttpServlet,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse"%>
<%@ page import="org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.FileItemFactory,org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj, imedix.cook,java.util.*, imedix.myDate" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
         long serialVersionUID = 1L;
		cook cookx=new cook();
		String pid = cookx.getCookieValue("patid", request.getCookies()); 
         String UPLOAD_DIRECTORY = request.getRealPath("/data/"+pid+"/");
         File ProjectDir = new File(UPLOAD_DIRECTORY);
	if(! ProjectDir.exists())
	{
	ProjectDir.mkdir();
	} 
//String mFilePath=req.getRealPath("//")+"/data/"+"/"+pid+"/";
	
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        // process only if its multipart content
        if (isMultipart) {
                // Create a factory for disk-based file items
                FileItemFactory factory = new DiskFileItemFactory();

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                try {
                        // Parse the request
                        List<FileItem> multiparts = upload.parseRequest(request);

                        for (FileItem item : multiparts) {
                          if (!item.isFormField()) {
                             String name = new File(item.getName()).getName();
                             String ext=name.substring(name.lastIndexOf(".")); //1
                             String cdate=myDate.getCurrentDate("dmy",false); //4
                             String mFileName=pid+cdate+"new"+ext; //2
                            
								//System.out.println("ext : "+ext+" cdate : "+cdate);
                             item.write(new File(UPLOAD_DIRECTORY + File.separator + mFileName));
                          }
                        }

                } 
                catch (Exception e) 
                {
                  System.out.println("File upload failed");
                }
              
        }


%>

