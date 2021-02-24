<%@page language="java" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",cdat="";
	rcDisplayData rcDd = new rcDisplayData(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	String patdis=cookx.getCookieValue("patdis", request.getCookies());
	String ty = request.getParameter("ty");
	String fsl=request.getParameter("sl");
	String dt1 = request.getParameter("dt");	
	if(ty==null) ty="";
	cdat = myDate.getCurrentDateMySql();
%>

<html >
<head >
<title> Prescription </title>

<SCRIPT LANGUAGE="JavaScript">
	
	function PrintDoc(text){
	text=document
	print(text)
	}

	function showselected()
	{
	var val=document.frm.abc.value;
	var tar;
	tar="medication.jsp?"+val;
	//alert(tar);
	window.location=tar;

}
</script>

<style>
</style>
</head >

<body>
<Form name="frm" >

<%
	try{
		if(ty.equalsIgnoreCase("A02") ){
%>
	<TABLE Width=100%  Border=0 class='tablea'>
	<TR>
	<TD><A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
		<IMG SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >&nbsp;Print this Document&nbsp;</A>
	</TD>
	<TD align='right'>
<%
			String dat = dt1.substring(0,2)+dt1.substring(3,5)+dt1.substring(6,10);
			String dt =myDate.getFomateDate("ymd",true,dat);

			Vector Vres = (Vector) rcDd.getAttachmentAndOtherFrm(id,ty,fsl,dt);
						
			int tag=0;
			String pdt="",iData;

			Object Objtmp = Vres.get(1);
			if(Objtmp instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)Objtmp;
				if(Vtmp.size()>1 ) {
					String sn;
					out.println("<td Align='Right'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT>");
					out.println("<SELECT NAME=abc onChange='showselected();'>"); //showselected(abc.value);
					out.println("<option></option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						pdt = datatemp.getValue("date");
						String dt3= pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						sn=datatemp.getValue("serno");
						//if(sn.length()<2)  sn= "0" + sn; 
						out.println("<option value='id="+id+"&ty="+ty+"&sl="+sn+"&dt="+dt3+"' >"+ty+"-"+sn+"</option>");
					}
					out.println("</SELECT></TD></TR></form></TABLE><HR Size=3  Color=RED>");
				}
				else out.println("</TR></form></TABLE><HR Size=3  Color=RED>");
			}
			if(tag==1) out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
   %>
		</TD></TR></TABLE>
   <%
		}else{
			String output="";
			out.println("<br><br><center><span style='color:red;font-weight:bold' align=center> Medicines</span></center><br>");
			output=rcDd.getGenPrescriptionforMedication(id,"","");
			out.println(output);
		}
	}catch(Exception e){
		out.println(e);
	}
%>
</Form>
</body>
</html >