<%@page language="java" import="imedix.rcItemlistInfo,imedix.dataobj,imedix.cook,imedix.myDate,java.util.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="",dat="";
	rcItemlistInfo rcIlist = new rcItemlistInfo(request.getRealPath("/"));
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
%>
<HTML>
<head>


</head>
<body>

<%
try{
	
	String radiotype =request.getParameter("radiotype");
	String divid =request.getParameter("divid");

    if(radiotype==null) radiotype="";
	radiotype=radiotype.trim();

	//out.println("radiotype :"+radiotype);

	String xray = "", sng = "", cts = "", mri = "";
	String tempstr="";

	Object res=rcIlist.getRadiologyCount(id);
	if(res instanceof String){
		out.println(res);
	}else{
		Vector tmp = (Vector)res;

		

		for(int i=0;i<tmp.size();i++){
			dataobj tmpdata = (dataobj) tmp.get(i);
			String type = tmpdata.getValue(0);
			if(type.equalsIgnoreCase("XRA")){
				xray=tmpdata.getValue(1);
			}else if(type.equalsIgnoreCase("SNG")){
				sng=tmpdata.getValue(1);
			}else if(type.equalsIgnoreCase("CTS")){
				cts=tmpdata.getValue(1);
			}else if(type.equalsIgnoreCase("MRI")){
				mri=tmpdata.getValue(1);
			}
		}

	}// end else

	res=rcIlist.getRadiologyInfo(id,radiotype);
	
	if(radiotype.equalsIgnoreCase("XRA")){
		
			//tempstr = "<a href='radiomenu.jsp?radiotype=XRA' target='rightpanel' >X-Ray (" + xray + ")</a>";
			tempstr = "<a class='radio' href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=XRA&divid="+divid+"','get','','','"+divid+"')\" >X-Ray (" + xray + ")</a>";
			
			
			//
			if(res instanceof String){
				out.println(res);
			}else{
				Vector tmp = (Vector)res;
				//out.println("tmp.size()"+tmp.size());

				for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String pdt = temp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String tdt = temp.getValue("testdate");
					String dt1 = tdt.substring(8,10)+"/"+tdt.substring(5,7)+"/"+tdt.substring(0,4);

					String code = temp.getValue(2);
					String psl = temp.getValue("serno").trim();
					String dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;

					String qrstr2 = "<A href='#' value='../jspfiles/writevaltext.jsp?id="+id+"&ty="+code+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' onclick=clearPanel(encodeURI(this.getAttribute('value')))>";

		            String tempstr12 = "<table border='0' width='100%' cellspecing='2' cellpadding='0' title='" +dt + "'><tr><td>"+qrstr2+" <img src='../images/xra.jpg' width=30 height=30 border=1></a></td><td align='left'>" + temp.getValue(5) + "</td></tr></table>";
              				 
					 tempstr += "<span style='font-family:verdana;font-size:8pt;text-decoration:none;padding:2 0 2 10;display:block;width:100%;color:#0000FF'>" + dt1 + "</span>";
				     tempstr += "<div style='padding-left:10;border-bottom: 1px  solid blue;display:'>" + tempstr12 + "</div>";
				}
			}

			///

			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=SNG&divid="+divid+"','get','','','"+divid+"')\" >Ultrasound (" + sng + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=CTS&divid="+divid+"','get','','','"+divid+"')\" >CT-Scan (" + cts + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=MRI&divid="+divid+"','get','','','"+divid+"')\" >MRI (" + mri + ")</a></li>";
			

		}else if(radiotype.equalsIgnoreCase("SNG")){
		
			
			tempstr = "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=XRA&divid="+divid+"','get','','','"+divid+"')\" >X-Ray (" + xray + ")</a></li>";
			tempstr += "<a class='radio' href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=SNG&divid="+divid+"','get','','','"+divid+"')\" >Ultrasound (" + sng + ")</a>";
			//
			if(res instanceof String){
				out.println(res);
			}else{
				Vector tmp = (Vector)res;

				//out.println("tmp.size():"+tmp.size());

				for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String pdt = temp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String tdt = temp.getValue("testdate");
					String dt1 = tdt.substring(8,10)+"/"+tdt.substring(5,7)+"/"+tdt.substring(0,4);

					String code = temp.getValue(2);
					String psl = temp.getValue("serno").trim();
					String dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;

					String qrstr2 = "<A href='#' value='../jspfiles/writevaltext.jsp?id="+id+"&ty="+code+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' onclick=clearPanel(encodeURI(this.getAttribute('value')))>";

		            String tempstr12 = "<table border='0' width='100%' cellspecing='2' cellpadding='0' title='" +dt + "'><tr><td>"+qrstr2+" <img src='../images/sng.jpg' width=30 height=30 border=1></a></td><td align='left'>" + temp.getValue(5) + "</td></tr></table>";
              				 
					 tempstr += "<span style='font-family:verdana;font-size:8pt;text-decoration:none;padding:2 0 2 10;display:block;width:100%;color:#0000FF'>" + dt1 + "</span>";
				     tempstr += "<div style='padding-left:10;border-bottom: 1px  solid blue;display:'>" + tempstr12 + "</div>";
				}
			}

			///

			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=CTS&divid="+divid+"','get','','','"+divid+"')\" >CT-Scan (" + cts + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=MRI&divid="+divid+"','get','','','"+divid+"')\" >MRI (" + mri + ")</a></li>";
			
		}else if(radiotype.equalsIgnoreCase("CTS")){
			
			
			tempstr = "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=XRA&divid="+divid+"','get','','','"+divid+"')\" >X-Ray (" + xray + ")</a></li>";

			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=SNG&divid="+divid+"','get','','','"+divid+"')\" >Ultrasound (" + sng + ")</a></li>";
			tempstr += "<a class='radio' href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=CTS&divid="+divid+"','get','','','"+divid+"')\" >CT-Scan (" + cts + ")</a>";
			//
			if(res instanceof String){
				out.println(res);
			}else{
				Vector tmp = (Vector)res;

				//out.println("tmp.size()"+tmp.size());

				for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String pdt = temp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String tdt = temp.getValue("testdate");
					String dt1 = tdt.substring(8,10)+"/"+tdt.substring(5,7)+"/"+tdt.substring(0,4);

					String code = temp.getValue(2);
					String psl = temp.getValue("serno").trim();
					String dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;

					String qrstr2 = "<A href='#' value='../jspfiles/writevaltext.jsp?id="+id+"&ty="+code+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' onclick=clearPanel(encodeURI(this.getAttribute('value')))>";

		            String tempstr12 = "<table border='0' width='100%' cellspecing='2' cellpadding='0' title='" +dt + "'><tr><td>"+qrstr2+" <img src='../images/cts.jpg' width=30 height=30 border=1></a></td><td align='left'>" + temp.getValue(5) + "</td></tr></table>";
              				 
					 tempstr += "<span style='font-family:verdana;font-size:8pt;text-decoration:none;padding:2 0 2 10;display:block;width:100%;color:#0000FF'>" + dt1 + "</span>";
				     tempstr += "<div style='padding-left:10;border-bottom: 1px  solid blue;display:'>" + tempstr12 + "</div>";
				}
			}
				

			//


			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=MRI&divid="+divid+"','get','','','"+divid+"')\" >MRI (" + mri + ")</a></li>";

		}else if(radiotype.equalsIgnoreCase("MRI")){
			
			
			tempstr = "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=XRA&divid="+divid+"','get','','','"+divid+"')\" >X-Ray (" + xray + ")</a></li>";

			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=SNG&divid="+divid+"','get','','','"+divid+"')\" >Ultrasound (" + sng + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=CTS&divid="+divid+"','get','','','"+divid+"')\" >CT-Scan (" + cts + ")</a></li>";
			tempstr += "<a class='radio' href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=MRI&divid="+divid+"','get','','','"+divid+"')\" >MRI (" + mri + ")</a>";	
			//
			if(res instanceof String){
				out.println(res);
			}else{
				Vector tmp = (Vector)res;
				//out.println("tmp.size()"+tmp.size());
				for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String pdt = temp.getValue("entrydate");
					String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String tdt = temp.getValue("testdate");
					String dt1 = tdt.substring(8,10)+"/"+tdt.substring(5,7)+"/"+tdt.substring(0,4);

					String code = temp.getValue(2);
					String psl = temp.getValue("serno").trim();
					String dsl=psl;
					if (psl.length()<2) dsl = "0" + psl;

					String qrstr2 = "<A href='#' value='../jspfiles/writevaltext.jsp?id="+id+"&ty="+code+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' onclick=clearPanel(encodeURI(this.getAttribute('value')))>";

		            String tempstr12 = "<table border='0' width='100%' cellspecing='2' cellpadding='0' title='" +dt + "'><tr><td>"+qrstr2+" <img src='../images/mri.jpg' width=30 height=30 border=1></a></td><td align='left'>" + temp.getValue(5) + "</td></tr></table>";
              				 
					 tempstr += "<span style='font-family:verdana;font-size:8pt;text-decoration:none;padding:2 0 2 10;display:block;width:100%;color:#0000FF'>" + dt1 + "</span>";
				     tempstr += "<div style='padding-left:10;border-bottom: 1px  solid blue;display:'>" + tempstr12 + "</div>";
				}
			}

			//

		}else{
		
			tempstr = "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=XRA&divid="+divid+"','get','','','"+divid+"')\" >X-Ray (" + xray + ")</a></li>";

			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=SNG&divid="+divid+"','get','','','"+divid+"')\" >Ultrasound (" + sng + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=CTS&divid="+divid+"','get','','','"+divid+"')\" >CT-Scan (" + cts + ")</a></li>";
			tempstr += "<li><a href='#' onclick=\" javascript:ExecuteCallContent('radiomenu.jsp?radiotype=MRI&divid="+divid+"','get','','','"+divid+"')\" >MRI (" + mri + ")</a></li>";
		}
tempstr="<ul>"+tempstr+"</ul>";
out.println(tempstr);

}catch(Exception e){
	out.println(e);
}

%>
</body>
</HTML>
