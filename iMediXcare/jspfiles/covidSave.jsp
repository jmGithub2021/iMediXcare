<%-- 
    Document   : save
    Created on : 3 Apr, 2020, 8:31:43 PM
    Author     : SURAJIT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page contentType="text/html"  import="imedix.dataobj,imedix.myDate,imedix.projinfo,imedix.rcGenOperations,imedix.cook,java.util.*,org.json.simple.*,org.json.simple.parser.*" %>

<%
    String resultJSON = "";
    String patientid = "";
    resultJSON = request.getParameter("result");
	cook cookx = new cook();
	String pat_id = cookx.getCookieValue("patid", request.getCookies ());	
	//out.println(resultJSON+"ds"+pat_id);
	rcGenOperations  data= new rcGenOperations(request.getParameter("/"));
	if (data.uploadCOVIDdata(pat_id, resultJSON)  )
		out.println(getResponse(resultJSON));
	else
		out.println("Try Again");
%>


<%!

public String getResponse(String result){
	String res = "";
	try{
    if(!result.equals("")){
            JSONParser outparser = new JSONParser();
            JSONArray outjsArr = new JSONArray();
            outjsArr = (JSONArray) outparser.parse(result);

                    JSONObject jsObj5 = (JSONObject) outjsArr.get(5);
                    JSONObject jsObj6 = (JSONObject) outjsArr.get(6);
                    JSONObject jsObj7 = (JSONObject) outjsArr.get(7);
                    JSONObject jsObj9 = (JSONObject) outjsArr.get(9);
                    JSONObject jsObj10 = (JSONObject) outjsArr.get(10);
                    JSONObject jsObj11 = (JSONObject) outjsArr.get(11);
                    JSONObject jsObj12 = (JSONObject) outjsArr.get(12);
					JSONObject jsObj13 = (JSONObject) outjsArr.get(13);
					JSONObject jsObj14 = (JSONObject) outjsArr.get(14);
					JSONObject jsObj15 = (JSONObject) outjsArr.get(15);
					JSONObject jsObj16 = (JSONObject) outjsArr.get(16);
					JSONObject jsObj17 = (JSONObject) outjsArr.get(17);
					JSONObject jsObj18 = (JSONObject) outjsArr.get(18);
					JSONObject jsObj19 = (JSONObject) outjsArr.get(19);
					JSONObject jsObj20 = (JSONObject) outjsArr.get(19);					
                    if(jsObj10.get("answer").equals("YES") || jsObj11.get("answer").equals("YES") || jsObj12.get("answer").equals("YES")){
                        JSONArray feverDurationArr = (JSONArray) jsObj9.get("child");
                        JSONObject feverDuration = new JSONObject();
                        if(feverDurationArr.size()>0){
                        feverDuration = (JSONObject) feverDurationArr.get(0);
                                if(jsObj9.get("answer").equals("YES") && Integer.parseInt((String)feverDuration.get("answer"))<7){
                                        res = "Attend Fever Clinic immediately at COVID19 Hospital";
                                }
                        }
                        else{
                            res = "Consult with doctor";
                        }
                    }
                    else if(jsObj10.get("answer").equals("NO") && jsObj11.get("answer").equals("NO") && jsObj12.get("answer").equals("NO")){
                            JSONObject agejs = (JSONObject) outjsArr.get(3);
                            int age = Integer.parseInt((String) agejs.get("answer"));
                        if(jsObj9.get("answer").equals("YES") && age>40){
                            res = "Consult with doctor";
                        }
                        else if(jsObj9.get("answer").equals("YES") && age<=40 && age>=5){
                           res = "Wait for another day or two/take paracetamol-stay at home-drink plenty of fluids.";  
                        }
                        else if(jsObj13.equals("YES") || jsObj14.equals("YES") || jsObj15.equals("YES") || jsObj16.equals("YES") || jsObj17.equals("YES") || jsObj18.equals("YES") || jsObj19.equals("YES") || jsObj20.equals("YES")){
                            res = "Consult with doctor"; 
                        }
					   else if(jsObj5.get("answer").equals("YES") || jsObj6.get("answer").equals("YES") || jsObj7.get("answer").equals("YES")){
							res = "Self Quarantine";
						}
                        else
                            res = "Stay at home";
                    }
                    else if(jsObj6.get("answer").equals("NO")){
                        res = "Consult with doctor";
                    }
                    else
                        res = "You are safe, stay at home"; 
                         
    }	
	}catch(Exception ex){}
	return res;
}

%>
