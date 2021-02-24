<%@page contentType="text/html" import="imedix.projinfo,imedix.dataobj,imedix.myDate,org.json.simple.*,org.json.simple.parser.*,imedix.rcCentreInfo,imedix.cook,java.util.*,java.io.*,imedix.rcGenOperations,imedix.rcDataEntryFrm" %>
<%@ include file="..//includes/chkcook.jsp" %>

<%!
public int noOfRecords(String tableName, String pat_id, HttpServletRequest request) throws Exception{
	String condition = " pat_id='"+pat_id+"'";
	rcGenOperations rg = new rcGenOperations(request.getRealPath("/"));
	String result = rg.FindCount(tableName,condition);
	if(result.equals(""))
		result="0";
	return Integer.parseInt(result);
}
%>

<%
String pat_id="",status="P",reffered_by="",type_str="",test_name_str="",description_str="",data="";
int noOftest=0;
String radiology[] = {"X-RAY","MRI","CT SCAN"};
String pathology[] = {"BILIRUBIN","GLUCOSE","SGPT","SGOT","CREATININE","URIC ACID","TOTAL CHOLESTROL","HDL","LDL","TRIGLYCERIDE","HAEMOGLOBIN","URINE"};

	rcDataEntryFrm rd = new rcDataEntryFrm(request.getRealPath("/"));
	rcCentreInfo cnfo = new rcCentreInfo(request.getRealPath("/"));
	cook cookx = new cook();
	String uid = cookx.getCookieValue("userid", request.getCookies ());
	try{
	noOftest = Integer.parseInt(request.getParameter("noOftest"));
	}catch(Exception ex){out.println(request.getParameter("noOftest"));}
	String type[] = new String[noOftest];
	String test_name[] = new String[noOftest];
	String description[] = new String[noOftest];
	pat_id = request.getParameter("pat_id");
	reffered_by = uid;

	Enumeration paramNames = request.getParameterNames();
	int type_c=0,desc_c=0,tn_c=0;
	while(paramNames.hasMoreElements()) {
		String paramName = (String)paramNames.nextElement();
		if(paramName.matches("type(.*)")){
			type[type_c] = request.getParameter(paramName);
			type_c++;

		}
		if(paramName.matches("test_name(.*)")){
			test_name[tn_c] = request.getParameter(paramName);
			tn_c++;
		}
		if(paramName.matches("description(.*)")){
			description[desc_c] = request.getParameter(paramName);
			desc_c++;
		}
   }

if(type_c==0)
{
	out.println("<p style='color:red;'>No advice was selected!</p>");
}
else{

	data = "{\"pat_id\":\""+pat_id+"\",\"reffered_by\":\""+reffered_by+"\",\"center\":\""+cnfo.getCenterCode(pat_id,"med")+"\",";
	String tst_name[]=new String[type.length];
	String serialNo = "";

	try{
		int noOfTest = noOfRecords("ai0",pat_id,request);
		out.println("noOfTest : "+noOfRecords("ai0",pat_id,request));
		for(int j=0;j<type_c;j++){
			noOfTest += j;
			if(noOfTest < 10)
				serialNo = "0"+String.valueOf(noOfTest);
			else
				serialNo = ""+String.valueOf(noOfTest);

			if(type[j].equalsIgnoreCase("Radiology"))
				tst_name[j] = radiology[Integer.parseInt(test_name[j])];
			if(type[j].equalsIgnoreCase("Pathology"))
				tst_name[j] = pathology[Integer.parseInt(test_name[j])];
			//type_str = type_str+"##"+type[j];
			//test_name_str = test_name_str+"##"+test_name[j];
			//description_str = description_str+"##"+description[j];
			if(j!=type.length-1)
				data += "\""+j+"\":{\"test_id\":\""+pat_id+serialNo+"\",\"test_name\":\""+tst_name[j]+"\",\"description\":\""+description[j]+"\",\"type\":\""+type[j]+"\",\"status\":\""+status+"\"},";
			else
				data += "\""+j+"\":{\"test_id\":\""+pat_id+serialNo+"\",\"test_name\":\""+tst_name[j]+"\",\"description\":\""+description[j]+"\",\"type\":\""+type[j]+"\",\"status\":\""+status+"\"}";
		}
	}catch(Exception ex){out.println("Enexpected Err(check testname) : "+ex.toString());}
	data +="}";


out.println("<table><tbody>");

out.println("</tbody></table>");



out.println(data);
try{
	JSONParser parser =new JSONParser();
	JSONObject jsobject = (JSONObject)parser.parse(data);
	JSONObject nestedjsonObj = (JSONObject)jsobject.get("0");
	String typea = (String)nestedjsonObj.get("type") ;
	if(typea != null){

		dataobj obj = new dataobj();
		obj.add("jsonAdvice",data);
		//out.println(obj);
		String result="";
		result= rd.advicedInvestigationAdd(obj);
		out.println("ffff : "+result);
		if(result.equals("1")){
			String dt=myDate.getCurrentDateMySql();
			String yr=""+(Integer.parseInt(dt.substring(0,4))+1);
			String ndt=yr+dt.substring(4);
			String redirectto1 = "ai0.jsp?id="+pat_id+"&ty=ai0&dt="+myDate.getCurrentDateMySql()+"&ndt="+ndt;
			response.sendRedirect(response.encodeRedirectURL(redirectto1));
		}
		else{
			out.println("Can not update"+result);
		}
	}
	else{out.println("WRONG DATA STRING !");}

}catch(Exception ex){out.println("Invalid Data String "+ex);}
}

%>
