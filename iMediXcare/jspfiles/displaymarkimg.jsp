<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*, java.io.OutputStream" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String ID="",mime="",ty="",dt="",dt1="",mtype="",rc="",isl="",msl="";
	rcDisplayData rcdd=new rcDisplayData(request.getRealPath("/"));
	OutputStream os1 = response.getOutputStream();

	try {
		ID=request.getParameter("id");
		isl=request.getParameter("ser");
		ty=request.getParameter("type");
		dt1=request.getParameter("dt");
		msl=request.getParameter("mser");
		rc=request.getParameter("rcode");

		//dt=dt1.substring(6)+"/"+dt1.substring(3,5)+"/"+dt1.substring(0,2);

		byte[] fileArray = null;
		mime=rcdd.getRImageCon_type(ID,dt1,ty,msl,isl,rc);
		fileArray =rcdd.getRImage(ID,dt1,ty,msl,isl,rc);
		
		response.setContentType(mime);
		os1.write(fileArray,0,fileArray.length);
		os1.flush();
		os1.close();

	}catch(Exception e) {
		os1.write(e.toString().getBytes());
	}
%>
