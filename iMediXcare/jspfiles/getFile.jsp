<%@page language="java"  import= "imedix.projinfo,java.io.*,imedix.myDate,imedix.rcDataEntryFrm,imedix.dataobj, imedix.cook,java.util.*, imedix.Crypto,javax.crypto.*,javax.crypto.spec.SecretKeySpec"%>
<%@ include file="..//includes/chkcook.jsp" %>
<%
    //projinfo pinfo=new projinfo(request.getRealPath("/"));
	//tring dataPath = pinfo.gbldata;
    
    SecretKey key = getSecretKey(session);
    Crypto encrypt = new Crypto(key);
    String filepath = encrypt.decrypt(request.getParameter("file"));
    //out.println("PAth: "+filepath);





    String filename = filepath.substring(filepath.lastIndexOf("/"));
    int i = filepath.lastIndexOf('.');
    String ext = "";
    if(i > 0){
        ext = filepath.substring(i);
    }

    String contentType = "";
    if(ext.equalsIgnoreCase("pdf")){
        contentType = "application/pdf";
    }else if(ext.equalsIgnoreCase("jpg") || ext.equalsIgnoreCase("jpeg") || ext.equalsIgnoreCase("png") || ext.equalsIgnoreCase("gif") || ext.equalsIgnoreCase("svg")){
        contentType = "image/"+ext;
    }

    response.setContentType(contentType);
    response.setHeader("Content-disposition","inline;filename="+ filename);
    try {
        String realFilePath = application.getRealPath(filepath);
        File f = new File(realFilePath);
        FileInputStream fis = new FileInputStream(f);
        DataOutputStream os = new DataOutputStream(response.getOutputStream());
        response.setHeader("Content-Length",String.valueOf(f.length()));
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = fis.read(buffer)) >= 0) {
            os.write(buffer, 0, len);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }


%>
