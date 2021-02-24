<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@page import="imedix.cook,imedix.projinfo" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	cook cookx = new cook();
	String patid = cookx.getCookieValue("patid", request.getCookies());
	
	long timestampMilis = new Date().getTime();
	
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 6000 * 1024;
   	projinfo pinfo=new projinfo(request.getRealPath("/"));
   String filePath = request.getRealPath(""+pinfo.gbldata+"/"+patid+"")+"/";
	File ProjectDir = new File(filePath);
	if(! ProjectDir.exists())
	{
	ProjectDir.mkdir();
	} 
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);

      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  {
                String fieldName = fi.getFieldName();
                String fileName = fi.getName();
				String ext = fileName.substring(fileName.lastIndexOf("."),fileName.length());
				
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                file = new File(filePath+patid+"a14"+timestampMilis+ext) ;
                fi.write( file ) ;
                out.println(patid+"a14"+timestampMilis+ext);
}
}

}catch(Exception ex){out.println("");}
}
else{out.println("");}
%>
