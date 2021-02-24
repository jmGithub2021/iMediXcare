<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*, java.io.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String iSql = "",ID="",mime="",ty="",dt="",dt1="",mtype="",rc="",isl="",msl="";
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	OutputStream os = response.getOutputStream();
	BufferedOutputStream bos = new BufferedOutputStream(os);
	try {
		
		ID=request.getParameter("id");
		isl=request.getParameter("ser");
		ty=request.getParameter("type");
		dt1=request.getParameter("dt");

		//dt=dt1.substring(6)+"/"+dt1.substring(3,5)+"/"+dt1.substring(0,2);

		byte[] fileArray = null;
		byte[] fileArrayBack = null;
		mime=ddinfo.GetImageCon_type(ID,dt1,ty,isl);
		fileArray =ddinfo.GetImage(ID,dt1,ty,isl);
		if(fileArray==null && !mime.equalsIgnoreCase("LRGFILE")){
			fileArrayBack = ddinfo.GetBackupImage(ID,dt1,ty,isl);
			if(fileArrayBack==null){
				out.println(" No image found");
			}
			else{
				response.setContentType("image/jpeg");
				bos.write(fileArrayBack,0,fileArrayBack.length);
			}
		}
		else{	
			//out.println("I am here");
			response.setContentType("image/jpeg");
			bos.write(fileArray,0,fileArray.length);
		}
			bos.flush();
			bos.close();

	}catch(Exception e) {
		os.write(e.toString().getBytes());
	}
%>
