<%@page language="java" import="imedix.cook,imedix.rcCentreInfo,java.util.Vector,java.lang.String"%>

<%@ include file="../../includes/chkcook.jsp" %>
<%@ include file="hlseven.jsp" %>


<html>
<head>

<title>HL7 Message</title>
</head>

<body >

<FORM METHOD = post ACTION="../../servlet/sendhl7msg" Name="HL7send" >

<BR><CENTER>
  <table border=2 cellpadding=10>
  <tr><td><center>
  <h2>HL7 Message </h2></center>
  <div align="center"><center><p>
  </p>
  </center>
  </div>
<%
cook cookx = new cook();
rcCentreInfo rcci=new rcCentreInfo(request.getRealPath("/"));

islocal=cookx.getCookieValue("node", request.getCookies ());

String ccode=cookx.getCookieValue("center", request.getCookies ());

hlseven hl7=new hlseven(ccode,cookx.getCookieValue("centername", request.getCookies ()));
	
	Date cdt = new Date();
	String tempHl7="", tempstr="" ;

	String patid=request.getParameter("id");

        tempHl7 = hl7.getMSH().trim();

        tempHl7 = tempHl7 + (char)(13) + "EVN|R01|" + hl7.dateformat("yyyyMMdd",cdt) + hl7.dateformat("HHmm",cdt) +  "|";

	//tempHl7 = tempHl7 + "\n" + "EVN|R01|" + hl7.dateformat("yyyyMMdd",cdt) + hl7.dateformat("HHmm",cdt) +  "|";

	tempHl7 = tempHl7 + (char)(13) + hl7.getPID(patid).trim();

	//tempHl7 = tempHl7 + "\n"+ hl7.getPID(patid).trim();

	tempstr = hl7.getNK1(patid).trim();
	if(!tempstr.equals("") ) tempHl7 = tempHl7 + (char)(13) + tempstr;

	tempHl7=tempHl7.trim();
	tempstr = hl7.getOBROBX(patid).trim();
	if(!tempstr.equals("") ) tempHl7 = tempHl7 + (char)(13) + tempstr;
        tempstr = hl7.getUnmapped(patid).trim();
	if(!tempstr.equals("") ) tempHl7 = tempHl7 + (char)(13) + tempstr;
	tempHl7=tempHl7.trim();

	//tempstr = hl7.getATTACHMENT(patid).trim();
	//if(!tempstr.equals("") ) tempHl7 = tempHl7 + (char)(13) + tempstr;
	//tempHl7=tempHl7.trim();
	ccode=ccode.toUpperCase();
	patid=patid;
	String fileD = gblDataDir +"/"+ccode+"/"+patid;
	String fileP = gblDataDir +"/"+ccode+"/"+patid+"/"+patid.toUpperCase()+".HL7";
	String fileN = patid+".HL7";

	try {
	    File f = new File(fileD);
	    if(!f.exists()){
		boolean yes = f.mkdirs();
	    }

	    FileWriter fs = new FileWriter(fileP,false);
	    BufferedWriter fout = new BufferedWriter(fs);
	    fout.write(tempHl7);
	    fout.close();
      	}catch(Exception e){
	out.println("error : "+e.toString());
	}

	hl7.getCdaAttachment(patid,fileP);
%>


  <INPUT TYPE="hidden" name="patid" value=<%=patid%>>
  <INPUT TYPE="hidden" NAME="fileD" Value="<%=fileD%>">
  <INPUT TYPE="hidden" NAME="fileP" Value="<%=fileP%>">
  <INPUT TYPE="hidden" NAME="fileN" Value="<%=fileN%>">
  <INPUT TYPE="hidden" NAME="center" Value="<%=ccode%>">
  <INPUT TYPE="hidden" NAME="gbldbjdbcDriver" Value="<%=gbldbjdbcDriver%>">
  <INPUT TYPE="hidden" NAME="gbldbURL" Value="<%=gbldbURL%>">
  <INPUT TYPE="hidden" NAME="gbldbusername" Value="<%=gbldbusername%>">
  <INPUT TYPE="hidden" NAME="gbldbpasswd" Value="<%=gbldbpasswd%>">
  <INPUT TYPE="hidden" NAME="gblDataDir" Value="<%=gblDataDir%>">

  <div align="center"><center>
   <table cellspacing="3">
     <tr>
    	<td colspan="3">
    	<textarea rows="20" name="hl7msg" cols="70" wrap="off" >
	<%
	out.println(tempHl7);
	%>
	</textarea>
     </td>
  </tr>
  <tr>
  <td></td>
  </tr>
    <tr>
      <td>&nbsp;&nbsp;&nbsp;<b>Hospital Name </b></td>
      <td><b>:</b></td>
	   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<SELECT NAME="rhoscod">
	  <%

	  try {

		Object res=rcci.getAllCentreInfo();
		Vector tmp = (Vector)res;
		for(int i=0;i<tmp.size();i++){
			dataobj temp = (dataobj) tmp.get(i);
			String ccode = temp.getValue("code").trim();
			String cname = temp.getValue("name").trim();

			if(ccode.equals(rccode))
				out.println ("<Option Value='rccode="+ccode.trim()+"' selected>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
			else
				out.println ("<Option Value='rccode="+ccode.trim()+"'>("+ccode.trim() +")&nbsp;"+cname.trim()+"</OPTION>");
		}// end for

	}
	catch (Exception e) {
			out.println("Error : <B>"+e+"</B>");		
	}
	  %>
	  </SELECT></td>
      <td></td>
    </tr>

   <td colspan=3><CENTER><INPUT TYPE="submit" value="Send"></CENTER></td>
   </tr>
   </table>
  </center>
  </div>
  </td></tr></table>
  </CENTER>

</form>
</body>

</html>


