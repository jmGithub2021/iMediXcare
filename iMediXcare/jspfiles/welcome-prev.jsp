<%@page contentType="text/html" import="imedix.cook,imedix.rcdpStats,java.util.*,imedix.dataobj,com.google.gson.Gson, com.google.gson.JsonArray, com.google.gson.JsonPrimitive" %>
<%@page errorPage="error.jsp" %> 
<%@include file="..//includes/chkcook.jsp" %>

<!-- bgcolor=#C8DCE1 --> 

<%	
	cook cookx = new cook();
	String ccode = cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());
	cname = cname.substring(0,cname.lastIndexOf(" "));
	String str= "<I>Online Telemedicine Center </I><br><b>"+cname + "</b>";
	//out.println(str.toUpperCase());
	//String ccode="",cname;
	String path = request.getRealPath("/");
	rcdpStats dpStats = new rcdpStats(request.getRealPath("/"));
	Vector v = (Vector)dpStats.getGenderData("XXXX");
	//out.println( v.size() );
	String jsonGenderStr="", jsonGenderLabel="";
	for (int i = 0; i < v.size(); i++){
		dataobj innerObj = (dataobj)v.elementAt(i);
		jsonGenderStr += "" + innerObj.getValue("nop")+",";	
		jsonGenderLabel += "" + innerObj.getValue("sex")+",";	
			
	} 
	jsonGenderStr = jsonGenderStr.substring(0,jsonGenderStr.length()-1);
	jsonGenderLabel = jsonGenderLabel.substring(0,jsonGenderLabel.length()-1);
	//////////////////////////////////////////////////////////////////////////////////////

	Vector diseasev = (Vector)dpStats.getDiseaseData("XXXX");
	//out.println( diseasev.size() );
	String jsonDiseaseStr="", jsonDiseaseLabel="";
	for (int i = 0; i < diseasev.size(); i++){
		dataobj innerObj = (dataobj)diseasev.elementAt(i);
		if (Integer.parseInt(innerObj.getValue("nop"))>10) {
			jsonDiseaseStr += "" + innerObj.getValue("nop")+",";	
			jsonDiseaseLabel += "" + innerObj.getValue("class")+",";	
		}	
	} 
	jsonDiseaseStr = jsonDiseaseStr.substring(0,jsonDiseaseStr.length()-1);
	jsonDiseaseLabel = jsonDiseaseLabel.substring(0,jsonDiseaseLabel.length()-1);

	///////////////////////////////////////////////////////////////////////////////////////
	dataobj agev = (dataobj)dpStats.getAgeData("XXXX");
	String jsonAgeStr="", jsonAgeLabel="A,E,C,T,I,N";
	jsonAgeStr += "" + agev.getValue("A")+",";
	jsonAgeStr += "" + agev.getValue("E")+",";
	jsonAgeStr += "" + agev.getValue("C")+",";
	jsonAgeStr += "" + agev.getValue("T")+",";
	jsonAgeStr += "" + agev.getValue("I")+",";
	jsonAgeStr += "" + agev.getValue("N")+"";

	////////////////////////////////////////////////////////////////////////////////////////
	Vector centerv = (Vector)dpStats.getCenterData("XXXX");
	//out.println( diseasev.size() );
	String jsonCenterStr="", jsonCenterLabel="";
	for (int i = 0; i < centerv.size(); i++){
		dataobj innerObj = (dataobj)centerv.elementAt(i);
		if (Integer.parseInt(innerObj.getValue("PATIENTS"))>10) {
			jsonCenterStr += "" + innerObj.getValue("PATIENTS")+",";	
			jsonCenterLabel += "" + innerObj.getValue("CODE")+",";	
		}	
	} 
	jsonCenterStr = jsonCenterStr.substring(0,jsonCenterStr.length()-1);
	jsonCenterLabel = jsonCenterLabel.substring(0,jsonCenterLabel.length()-1);
	
	////////////////////////////////////////////////////////////////////////////////////////
	Vector getTpatQRefToDataVC = (Vector)dpStats.getTpatQRefToData("XXXX");
	//out.println( diseasev.size() );
	String jsonPatQRefToStr="", jsonPatQRefToLabel="";
	for (int i = 0; i < getTpatQRefToDataVC.size(); i++){
		dataobj innerObj = (dataobj)getTpatQRefToDataVC.elementAt(i);
		if (Integer.parseInt(innerObj.getValue("PATIENTS"))>1) {
			jsonPatQRefToStr += "" + innerObj.getValue("PATIENTS")+",";	
			jsonPatQRefToLabel += "" + innerObj.getValue("assignedhos")+",";	
		}	
	} 
	jsonPatQRefToStr = jsonPatQRefToStr.substring(0,jsonPatQRefToStr.length()-1);
	jsonPatQRefToLabel = jsonPatQRefToLabel.substring(0,jsonPatQRefToLabel.length()-1);
	
	////////////////////////////////////////////////////////////////////////////////////////
	Vector getTpatQRefByDataVC = (Vector)dpStats.getTpatQRefByData("XXXX");
	//out.println( diseasev.size() );
	String jsonPatQRefByStr="", jsonPatQRefByLabel="";
	for (int i = 0; i < getTpatQRefByDataVC.size(); i++){
		dataobj innerObj = (dataobj)getTpatQRefByDataVC.elementAt(i);
		//String dataObjStr = innerObj.getAllKey();
		//out.println(dataObjStr);
		if (Integer.parseInt(innerObj.getValue("PATIENTS"))>10) {
			jsonPatQRefByStr += "" + innerObj.getValue("PATIENTS")+",";	
			jsonPatQRefByLabel += "" + innerObj.getValue("refer_center")+",";	
		}	
	} 
	jsonPatQRefByStr = jsonPatQRefByStr.substring(0,jsonPatQRefByStr.length()-1);
	jsonPatQRefByLabel = jsonPatQRefByLabel.substring(0,jsonPatQRefByLabel.length()-1);	
	
%>
				
<HTML>
<BODY background="../images/txture.jpg">

<center>
	<BR><BR>
	<TABLE border=0 width=95% class="table table-condensed table-hover" >
	<TR>
		<TD Align="center" colspan=3><br>
		<font color=#2C432D size="3px" ><%=str.toUpperCase()%></font>
<p align = 'justify' style="padding: 15px 15px 15px 15px">
<b>Disclaimer</b>: <font color=MAROON>This is a non-commercial website meant only for research purposes and building awareness about telehealth. The site may be withdrawn for technical and/or administrative reasons without prior notice. Maintaining security of patients identity and sensitive medical data is the users responsibility. The information and advice published or made available through this web site and iMediX System is not intended to replace the services of a physician, nor does it constitute a doctor-patient relationship. Information on this web site is not a substitute for professional medical advice. Physicians should apply their own discretion to use the information on this web site for diagnosing or treating a medical or health condition. IIT Kharagpur is not liable for any direct or indirect claim, loss or damage resulting from use of this web site and/or any web site(s) linked to/from it. 
</p>
		
		</TD>	
	</TR>
	<TR>
		<TD Align="center"><div id="chart1" style="width:100%;"></div></TD>
		<TD Align="center" width=1%><br></TD>
		<TD Align="center"><div id="chart3" style="width:100%;"></div></TD>
	</TR>
	<TR>
		<TD Align="center" colspan=3><div id="chart2" style="width:100%;"></div></TD>	
	</TR>
	<TR>
		<TD Align="center" colspan=3><div id="chart4" style="width:100%; "></div></TD>	
	</TR>
		<TD Align="center"><div id="chart5" style="width:100%;"></div></TD>
		<TD Align="center" width=1%><br></TD>
		<TD Align="center"><div id="chart6" style="width:100%;"></div></TD>
	</TR>	
	</TABLE>
<br>

<script>
	//document.write("Hello World!");
	$(document).ready(function(){
		$.jqplot.config.enablePlugins = true;
		var gen_data = "<%=jsonGenderStr%>";
		var gen_dataLabel = "<%=jsonGenderLabel%>";

		var aryData = gen_data.split(",");
		var aryData1 = [];	
		var aryDataL = gen_dataLabel.split(",");
		var aryDataL1 = [];			
		for(i=0; i<aryData.length; i++) aryData1.push(parseInt(aryData[i]) );
		for(i=0; i<aryDataL.length; i++) aryDataL1.push(aryDataL[i]);
		
		var plot1 = $.jqplot('chart1', [aryData1],{  
			title:'Gender-wise Patient Registration',
			series:[{showMarker:true}],
			highlighter: { show: true },
			seriesDefaults:{
                renderer:$.jqplot.LineRenderer,
                rendererOptions: { smooth: true },
                pointLabels: { show: true }
          },
		  axes:{
			xaxis:{
			  label: "M:Male, F:Female, N:Not Stated O:Others",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: aryDataL1,
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		////////////////////////////////////2nd Plot
		var disease_data = "<%=jsonDiseaseStr%>";
		var disease_dataLabel = "<%=jsonDiseaseLabel%>";

		var diseaseData = disease_data.split(",");
		var diseaseData1 = [];	
		var diseaseDataL = disease_dataLabel.split(",");
		var diseaseDataL1 = [];			
		for(i=0; i<diseaseData.length; i++) diseaseData1.push(parseInt(diseaseData[i]));
		for(i=0; i<diseaseDataL.length; i++) diseaseDataL1.push(diseaseDataL[i]);
		
		var plot2 = $.jqplot('chart2', [diseaseData1],{  
		  title:'Disease-wise Patient Registration',
		  series:[{showMarker:true}],
		  highlighter: { show: true },
		  seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                rendererOptions: { varyBarColor: true },
                pointLabels: { show: true }
          },
           axesDefaults: {
        	tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
        	tickOptions: {
          	angle: -15,
          	fontSize: '10pt'
        	}
    	  },
		  axes:{
			xaxis:{
			  label: "Disease-Group",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: diseaseDataL1,
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		
		////////////////////////////////////3rd Plot
		var age_data = "<%=jsonAgeStr%>";
		var age_dataLabel = "<%=jsonAgeLabel%>";

		var ageData = age_data.split(",");
		var ageData1 = [];	
		var ageDataL = age_dataLabel.split(",");
		var ageDataL1 = [];			
		for(i=0; i<ageData.length; i++) ageData1.push(parseInt(ageData[i]));
		for(i=0; i<ageDataL.length; i++) ageDataL1.push(ageDataL[i]);
		
		var plot3 = $.jqplot('chart3', [ageData1],{  
		  title:'Age-wise Patient Registration',
		  series:[{showMarker:true}],
		  highlighter: { show: true },
		  seriesDefaults:{
                renderer:$.jqplot.LineRenderer,
                rendererOptions: { smooth: true },
                pointLabels: { show: true }
          },
		  axes:{
			xaxis:{
			  label: "A:Adult,E:Teen,C:Child,T:Toddler,I:Infant,N:Neonatal",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: ageDataL1
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		////////////////////////////////////////////////////////////////
		var center_data = "<%=jsonCenterStr%>";
		var center_dataLabel = "<%=jsonCenterLabel%>";

		var centerData = center_data.split(",");
		var centerData1 = [];	
		var centerDataL = center_dataLabel.split(",");
		var centerDataL1 = [];			
		for(i=0; i<centerData.length; i++) centerData1.push(parseInt(centerData[i]));
		for(i=0; i<centerDataL.length; i++) centerDataL1.push(centerDataL[i]);
		//alert(centerDataL1);
		var plot4 = $.jqplot('chart4', [centerData1],{  
		  title:'Center-wise Patient Registration',
		  series:[{showMarker:true}],
		  highlighter: { show: true },
		  seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                rendererOptions: { varyBarColor: true },
                pointLabels: { show: true }
          },
          axesDefaults: {
        	tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
        	tickOptions: {
          	angle: -15,
          	fontSize: '10pt'
        	}
    	  },
		  axes:{
			xaxis:{
			  label: "Center-Group",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: centerDataL1
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		
		////////////////////////////////////////////////////////////////
		var jsonPatQRefTo_data = "<%=jsonPatQRefToStr%>";
		var jsonPatQRefTo_dataLabel = "<%=jsonPatQRefToLabel%>";

		var jsonPatQRefToData = jsonPatQRefTo_data.split(",");
		var jsonPatQRefToData1 = [];	
		var jsonPatQRefToDataL = jsonPatQRefTo_dataLabel.split(",");
		var jsonPatQRefToDataL1 = [];			
		for(i=0; i<jsonPatQRefToData.length; i++) jsonPatQRefToData1.push(parseInt(jsonPatQRefToData[i]));
		for(i=0; i<jsonPatQRefToDataL.length; i++) jsonPatQRefToDataL1.push(jsonPatQRefToDataL[i]);
		//alert(jsonPatQRefTo_dataLabel);
		var plot5 = $.jqplot('chart5', [jsonPatQRefToData1],{  
		  title:'Center-wise Patient RefferedTo',
		  series:[{showMarker:true}],
		  highlighter: { show: true },
		  seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                rendererOptions: { varyBarColor: true },
                pointLabels: { show: true }
          },
          axesDefaults: {
        	tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
        	tickOptions: {
          	angle: -15,
          	fontSize: '10pt'
        	}
    	  },
		  axes:{
			xaxis:{
			  label: "Center",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: jsonPatQRefToDataL1
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		
		////////////////////////////////////////////////////////////////
		var jsonPatQRefBy_data = "<%=jsonPatQRefByStr%>";
		var jsonPatQRefBy_dataLabel = "<%=jsonPatQRefByLabel%>";

		var jsonPatQRefByData = jsonPatQRefBy_data.split(",");
		var jsonPatQRefByData1 = [];	
		var jsonPatQRefByDataL = jsonPatQRefBy_dataLabel.split(",");
		var jsonPatQRefByDataL1 = [];			
		for(i=0; i<jsonPatQRefByData.length; i++) jsonPatQRefByData1.push(parseInt(jsonPatQRefByData[i]));
		for(i=0; i<jsonPatQRefByDataL.length; i++) jsonPatQRefByDataL1.push(jsonPatQRefByDataL[i]);
		//alert(centerDataL1);
		var plot6 = $.jqplot('chart6', [jsonPatQRefByData1],{  
		  title:'Center-wise Patient RefferedBy',
		  series:[{showMarker:true}],
		  highlighter: { show: true },
		  seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                rendererOptions: { varyBarColor: true },
                pointLabels: { show: true }
          },
          axesDefaults: {
        	tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
        	tickOptions: {
          	angle: -15,
          	fontSize: '10pt'
        	}
    	  },
		  axes:{
			xaxis:{
			  label: "Center-Group",
			  renderer: $.jqplot.CategoryAxisRenderer,
			  tickRenderer:$.jqplot.CanvasAxisTickRenderer,
			  ticks: jsonPatQRefByDataL1
			},
			yaxis:{
			  labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			  label: "Patients",
			}
		  }
		});
		
		
		$(window).resize(function() {
			  plot1.replot( { resetAxes: true } );
			  plot2.replot( { resetAxes: true } );
			  plot3.replot( { resetAxes: true } );
			  plot4.replot( { resetAxes: true } );
			  plot5.replot( { resetAxes: true } );
			  plot6.replot( { resetAxes: true } );
			  
		});	
		
	});

</script>
</center>
</BODY>
</HTML>

