<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="imedix.Decryptcenter" %>

<%

Decryptcenter dC=new Decryptcenter();
   File file ;
   String path="";
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = request.getRealPath("/jspfiles/centerlic/")+"/";
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
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                file = new File(filePath+fileName) ;
                fi.write( file ) ;
               // out.println("Uploaded Filename: " + filePath + fileName + "<br>"+request.getRealPath("/"));
                
                
                String content = null;
            //file = new File("/home/surajit/iMediX/encryptedfile/Data.lic");
            FileReader reader = null;
            try {
                reader = new FileReader(file);
                char[] chars = new char[(int) file.length()];
                 reader.read(chars,0,chars.length);
                content = new String(chars);
                reader.close();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if(reader !=null){reader.close();}
            }
            //out.println(content);
            path=request.getRealPath("/");
            //out.println("D-string : "+dC.decryptLicString(content,path));
            out.println("<script>alert(\""+dC.decryptLicString(content,path)+"\")</script>");
            out.println("<script>history.go(-1)</script>");
            file.delete();
           // response.sendRedirect("showcenter.jsp");	
            }
         }
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("<html>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>

<form action="">
