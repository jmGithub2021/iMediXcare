<%@page contentType="text/html" import= "imedix.rcUserInfo,imedix.medinfo,imedix.rcCentreInfo,imedix.rcDisplayData,imedix.cook, imedix.dataobj,imedix.myDate,imedix.Email,java.util.*,java.io.*,java.text.*"%>
<%@page import="com.itextpdf.html2pdf.ConverterProperties"%>
<%@page import="com.itextpdf.html2pdf.HtmlConverter"%>
<%@page import="com.itextpdf.kernel.pdf.PdfDocument"%>
<%@page import="com.itextpdf.kernel.pdf.PdfWriter"%>
<%@page import="com.itextpdf.layout.Document"%>
<%@page import="com.itextpdf.layout.element.Table"%>
<%@page import="com.itextpdf.layout.property.UnitValue"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%
	String presBody = "", patId = "", fileGenErrors="";
	try {
		cook cookx = new cook();
		patId = cookx.getCookieValue("patid",request.getCookies());
		
		rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));
		Object res=uinfo.getuserinfo(patId);
		Vector tmp = (Vector)res;
		if(tmp.size()<=0) {
			out.println("ID Not Found !!");
			out.flush(); // Send out whatever hasn't been sent out yet.
			out.close(); // Close the stream. Future calls will fail.
			return; // Return from the JSP servelet handler.
		}
		dataobj temp = (dataobj) tmp.get(0);
		String emailid = (String) temp.getValue("emailid");
		String patname = (String) temp.getValue("name");
		out.println ( "emailid : " + emailid );
		out.println ( "patname : " + patname );
		if (emailid.length()<=0) {
			out.println("Email-ID Not Found !!");
			out.flush(); // Send out whatever hasn't been sent out yet.
			out.close(); // Close the stream. Future calls will fail.
			return; // Return from the JSP servelet handler.
		}
		
		
		presBody = request.getParameter("data");
		byte[] decodedData = Base64.decodeBase64(presBody.getBytes());
		presBody = new String(decodedData);

		String fileName = request.getRealPath("/")+"bootstrap/css/prcsPrnt.css";

		FileInputStream fis = new FileInputStream(fileName);
		byte[] buffer = new byte[10];
		StringBuilder sb = new StringBuilder();
		while (fis.read(buffer) != -1) {
		sb.append(new String(buffer));
		buffer = new byte[10];
		}
		fis.close();

		String cssContent = sb.toString();


		String htmlString = "<html><head>"+
		"<style>"+cssContent+"</style></head><body>"+presBody+"</body></html>";

		String tempFileName = patId + "_" + String.valueOf(System.currentTimeMillis()) + ".pdf";
		String tempFullFileName = request.getRealPath("/")+"temp/"+tempFileName;
		
		out.println ( "tempFileName : " + tempFileName );
		out.println ( "tempFullFileName : " + tempFullFileName );
		
		File pdfDest = new File(tempFullFileName);
		fileGenErrors += tempFullFileName + "<br>";
		// pdfHTML specific code
		ConverterProperties converterProperties = new ConverterProperties();
		HtmlConverter.convertToPdf(htmlString,new FileOutputStream(pdfDest), converterProperties);
		String mesg = "Dear " +patname + ",\nPlease find attached prescription filled in by the assigned doctor. For more details login into the system.";
		Email email = new Email(request.getRealPath("/"));
		fileGenErrors += email.SendWA(emailid,"iMediX Prescription",mesg,tempFullFileName);
		//pdfDest.delete();
		System.out.println("pdf creation done. Emailed");
		fileGenErrors = " Prescription created and Emailed : ";
	} catch (Exception e) {
		e.printStackTrace();
		System.out.println("pdf generation has some errors");
		fileGenErrors = " Prescription generated some errors : " + e;
	}
%>
<%=fileGenErrors%>
