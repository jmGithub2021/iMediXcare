<%@page contentType="text/html" import="java.io.*,imedix.cook,imedix.rcDisplayData,imedix.rcItemlistInfo,imedix.dataobj,imedix.myDate, java.util.*" %>
<%!
public String chiefComplaint(String pat_id, String tname,String dt,String slno, rcDisplayData ddinfo) throws Exception{
	String result="";
	Object res;
	if(!dt.isEmpty() && !slno.isEmpty()){
		res=ddinfo.DisplayFrm(tname,pat_id,dt,slno);
		//result="DD"+tname+pat_id+dt+" : "+slno;
	}
	else{	
		res = ddinfo.latestData(pat_id,tname);
	//	result="RR";
	}	
		
			Vector tmp = (Vector)res;
			//out.println("ffffff "+tmp.size());
		for(int i=0;i<tmp.size();i++){
		dataobj temp = (dataobj) tmp.get(i);
		String comp1 = temp.getValue("comp1");
		String dur1 = temp.getValue("dur1");
		String hdmy1 = temp.getValue("hdmy1");
		String comp2 = temp.getValue("comp2");
		String dur2 = temp.getValue("dur2");
		String hdmy2 = temp.getValue("hdmy2");
		String comp3 = temp.getValue("comp3");
		String dur3 = temp.getValue("dur3");
		String hdmy3 = temp.getValue("hdmy3");
		String rh = temp.getValue("rh");
		if(!comp1.equals(""))
			result += "<li class='list-group-item'><label>"+comp1 +"</label><span class='pull-right'>"+dur1 +" "+hdmy1+"</span></li>";
		if(!comp2.equals(""))	
			result +="<li class='list-group-item'><label>"+comp2 +"</label><span class='pull-right'>"+dur2 +" "+hdmy2+"</span></li>";
		if(!comp3.equals(""))	
			result +="<li class='list-group-item'><label>"+comp3 +"</label><span class='pull-right'>"+dur3 +" "+hdmy3+"</span></li>";
		if(!rh.equals(""))			
			result +="<li class='list-group-item'><label>Records </label><span class='pull-right'>"+rh+"</span></li>";
	}
	return result;
}
public String listOfFomrs(String patid,String ftype,rcDisplayData ddinfo) throws Exception{
	String result="",slno="",dt="";
	int tag=0;
	Vector Vres;
	Vres = (Vector) ddinfo.getAttachmentAndOtherFrm(patid,ftype,slno,dt);
	Object Objtmp = Vres.get(1);
	if(Objtmp instanceof String){ tag=1;}
	else{
	Vector Vtmp = (Vector)Objtmp;
	if(Vtmp.size()>1 ) {
		String sn;
		result = "<SELECT class='form-control input-sm noofforms' NAME=abc id='compList'>";
		//result += "<option></option>";
		for(int i=0;i<Vtmp.size();i++){
			dataobj datatemp = (dataobj) Vtmp.get(i);
			String pdt = datatemp.getValue("date");
			String dt3 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			sn=datatemp.getValue("serno");
			//if(sn.length()<2)  sn= "0" + sn; 
			//result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' >"+ftype+"-"+sn+"</option>";
			if(i<Vtmp.size()-2)
			result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' >"+dt3+"-"+sn+"</option>";
			else
			result += "<option value='id="+patid+"&ty="+ftype+"&sl="+sn+"&dt="+pdt+"' selected>"+dt3+"-"+sn+"</option>";
		}
		result += "</SELECT>";
	}
	}
	return result;	
}
	
%>

<script>
$(document).ready(function(){
	$("#compList").change(function(){
		$.get("summary_tpatwaitpat.jsp?"+this.value,function(data){
			$(".ul-chf-complnt").html(data);
		});
	});
});
</script>
<%
String pat_id="",tname="a14",dt="",slno="",output="";
pat_id = request.getParameter("id");
dt = request.getParameter("dt");
slno = request.getParameter("sl");
rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
%>
<div class="chf-complnt">
		<ul class='list-group ul-chf-complnt'>
		<%
		if(slno==null || dt==null){
			dt="";
			slno="";
			output = chiefComplaint(pat_id,tname,dt,slno,ddinfo);
		}
		else{
			output = chiefComplaint(pat_id,tname,dt,slno,ddinfo);	
			}
		if(output.isEmpty())
			output = "No summary";
		out.println(output);	
		%>
			
</div>
