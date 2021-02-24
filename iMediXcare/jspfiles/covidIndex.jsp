<%-- 
    Document   : covid
    Created on : 1 Apr, 2020, 3:20:09 PM
    Author     : SURAJIT KUNDU
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*,org.json.simple.parser.*" %>
<%@ page import="imedix.rcGenOperations,imedix.cook,imedix.dataobj,imedix.projinfo" %>
<%
	cook cookx = new cook();
	String pat_id = cookx.getCookieValue("patid", request.getCookies ());	
	String patname = cookx.getCookieValue("patname", request.getCookies ());	
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
    /* Custom scroll CSS START */    
    /* Track */
    .question-list::-webkit-scrollbar-track{
	-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	background-color: #F5F5F5;
    }
    /* width */
    .question-list::-webkit-scrollbar{
	width: 6px;
	background-color: #F5F5F5;
    }

    /* Handle */
    .question-list::-webkit-scrollbar-thumb {
	background-color: #ccc;
    }

    /* Handle on hover */
    .question-list::-webkit-scrollbar-thumb:hover {
      background: #337ab7; 
    }
    /* Custom scroll CSS END */
        
    .covid-q, .covid-btn{height:50px;font-size: 18px;}
    .question-index{
        text-align: center;
        overflow-x: auto;
        overflow-y: hidden;
        background: #eef;
        border-bottom: 2px solid #337ab7;      
    }
    .q-no{
        padding: 2px 10px;
        border-right: 1px solid #ccc;
        border-left: 1px solid #ccc;
        margin: 0 2px;
    }
    .q-no.active{
        background: #337ab7;
        color: #fff;
        border: 1px solid #ecffff;        
    }
    .user-status{
        border: 1px solid #337ab7;
        margin-left: 1%;
        margin-top: 10px;
        margin-bottom: 10px;        
    }
    .user-status .title{
        font-size:18px; 
        text-align:center;
        background: #337ab7;
        color: #fff;    
    }
    hr{
        margin-top: 10px;
        margin-bottom: 15px;
        border: 0;
        border-top: 1px solid #eee;        
    }
    .question-list{
        max-height: 420px;
        overflow-y: auto; 
    }
    .question-list-group li{
        box-shadow: 0px 0px 5px 1px #eef;
        margin: 8px;
        background: #eef;   
    }
    .submit-result::before{content: "SUBMIT"}
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {background-color: #f2f2f2;}	
.has-nested ~.nested-question{background:#68c6bd !important;}
.has-nested span{
	position: absolute;
    top: 25px;
    left: 42%;
    font-size: 20px;
}

    </style>
    </head>

    <body>
        <%!
            public String inputField(JSONObject obj, String patname){
                String dataField = "";
                String data = "";
                for(Iterator iterator = obj.keySet().iterator(); iterator.hasNext();) {
                    String key = (String) iterator.next();
                    if(obj.get(key) instanceof JSONObject) ;//inputField((JSONObject)obj.get(key));
                    else{
                        data += key+"='"+obj.get(key)+"'";
                        dataField =(obj.get("condition").equals(false))?
                                "<input class='covid-q covid-input form-control' "+data+" value='"+patname+"' autofocus></input>":
                                "<select class='covid-q covid-select form-control' "+data+"><option></option></select>";              
                        }  
                }
                return dataField;
            }


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
        <%
            JSONParser parser = new JSONParser();
            JSONObject jj = new JSONObject();
            JSONArray jsArr = new JSONArray();
            try{
                Object obj = parser.parse(new FileReader(request.getRealPath("/")+"covidQuestion.json"));
                jsArr = (JSONArray) obj; 
                jj = (JSONObject) jsArr.get(0);
            }catch(Exception ex){out.println("EE"+ex.toString());}
			rcGenOperations  data= new rcGenOperations(request.getParameter("/"));
			String result = data.getCOVIDdata(pat_id);
        %>        
        <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
            <h3>COVID19 Questionnaire</h3>
            <div class="input-group">
            <div class="input-group-btn">
                <button class="btn btn-default covid-btn" id="prev" type="submit" title="Previous Question">
                  <i class="glyphicon glyphicon-chevron-left"></i>
                </button>   
            </div>
            <div class="covid-input-field"><%=inputField(jj, patname)%></div>
             
             <div class="input-group-btn">
               <button class="btn btn-primary covid-btn" id="next" type="submit" title="Next Question">
                 <i class="glyphicon glyphicon-chevron-right"></i>
               </button>
             </div>
           </div>
            <div class="row">
            <div class="col-md-12">    
            <div class="user-status">
                <div class="title">PATIENT RESPONSE</div>
                <div class="question-index"></div><hr>
                <div class="question-list">
                    <ul class="list-group question-list-group">

                    </ul>                    
                    
                </div>
            </div>
            </div>    
            </div>    
        </div>

		<div class='col-md-12'>
		<div class='table-responsive well'>
		<table class="table table-bordered">
			<thead>
			<tr>
				<th colspan="3" style="text-align:center;"><%=getResponse(result)%></th>
			</tr>
			</tr>
			  <tr>
				<th>Serial no</th>
				<th>Question</th>
				<th>Answer</th>
			  </tr>
			</thead>
			<tbody>
<%			
			if(!result.equals("")){
				JSONParser outparser = new JSONParser();
				JSONArray outjsArr = new JSONArray();
				outjsArr = (JSONArray) outparser.parse(result);
				
				for(int i=0;i<outjsArr.size();i++){
					JSONObject outobj = (JSONObject) outjsArr.get(i);
					JSONArray nestedQuestion = (JSONArray) outobj.get("child");
					String mainQus = "";
					String nestQus = "";
					if(nestedQuestion.size()>0){
						JSONObject jsnested = (JSONObject) nestedQuestion.get(0);
						nestQus ="<tr class='nested-question'><td style='text-align:center'>"+jsnested.get("id")+"</td>"
						+"<td>"+jsnested.get("question")+"</td>"
						+"<td>"+jsnested.get("answer")+"</td></tr>";
											
						mainQus ="<tr class='has-nested'><td>"+outobj.get("id")+"</td>"
						+"<td>"+outobj.get("question")+"</td>"
						+"<td>"+outobj.get("answer")+"</td></tr>";
					}
					else{
						mainQus ="<tr><td>"+outobj.get("id")+"</td>"
						+"<td>"+outobj.get("question")+"</td>"
						+"<td>"+outobj.get("answer")+"</td></tr>";					
					}
						out.println(mainQus+nestQus);
				}		
			}
%>	
			</tbody>
		  </table>	
		  </div>
		  </div>
        </div>
    </body>
     <script>
         const responses = {};
         var resultSetObj = [];
         var nestedresultSetObj = [];
        var add = (function() {     //Using closure for question forward and backward navigate
            var offset = 0; 
            var offsetValidator = 0;
            var jsArr = JSON.parse('<%=jsArr%>');   //Parse the JSON Object, containg the quesion set
            return function(option) { // option for our basic counter
            switch (option) {   
              case 0: offset = 0; break;    //Rest the covid19-questionnaire
              case 1:                       // Forward navigate
                    let data = "";
                    let userInput = $(".covid-q").val();
                    let userInputChild = $(".covid-q.child-1").val();
                    (offset>=0 && offset<jsArr.length-1)?$('#prev').show():(offset===(jsArr.length-1))?$('#next').addClass("submit-result"):$('#next').hide();
                    //(offset>0 && offset<jsArr.length-2)?$('#prev').show():(offset===0)?$('#prev').hide():(offset===(jsArr.length-2))?$('#next').addClass("submit-result"):$('#prev').show();  
                    console.log((offset===(jsArr.length-2))+"DE "+offset+ " : "+(jsArr.length-2));
                    (userInput.length===0)?alert('Enter/select value'):(new RegExp(jsArr[offset]["regx"]).test(userInput))?offset++:alert("Input format is not correct");
                    nestedresultSetObj = []; //Empty previous nested questions
                    if($(".covid-q").hasClass("child-1")){
                        let nesjsrsObj = "";
                            nesjsrsObj = (userInputChild.length===0)?alert('Enter/select the value of question '+offset--):(new RegExp(jsArr[offset-1][userInput]["regx"]).test(userInputChild))?JSON.parse('{"tagIndex":"'+offset+'","id":"'+jsArr[offset-1][userInput]["id"]+'","question":"'+jsArr[offset-1][userInput]["placeholder"]+'","answer":"'+userInputChild+'"}'):alert("Input format is not correct for question "+offset--);
                       
                        console.log((nesjsrsObj != null)+":"+(JSON.stringify(nesjsrsObj) === null)+":"+(JSON.stringify(nesjsrsObj) == "undefined")+" GG "+JSON.stringify(nesjsrsObj));
                        if(nesjsrsObj != null){
                            //console.log("GG"+nesjsrsObj);
                            nestedresultSetObj.push(nesjsrsObj);
                        }
                    }
                    if(offset<jsArr.length && offset>0 && offset>offsetValidator){
                        offsetValidator = offset;
                        let jsonObj = JSON.parse('{"id":"'+jsArr[offset -1]["id"]+'","question":"'+jsArr[offset-1]["placeholder"]+'","answer":"'+userInput+'"}');
                        if(nestedresultSetObj.length>0 && nestedresultSetObj!=='undefined'){
                            jsonObj["child"] = nestedresultSetObj;
                            console.log("EE : "+nestedresultSetObj);
                        }
                        else
                            jsonObj["child"]=[];
                        resultSetObj[offset-1]=jsonObj;
                        
                        $(".covid-input-field").html(createDataField(jsArr[offset]));
                        $(".q-no").removeClass("active");$(".q-"+offset).addClass("active");
                        $(".covid-q").addClass("form-control");
                        $(".covid-q").focus();   
                    }
                break;
              case 2:   //Backward navigate
                  $('#next').removeClass("submit-result");
                  (offset<=1)?$('#prev').hide():(offset===jsArr.length)?$('#next').addClass("submit-result"):$('#prev').show();
                  if(offset>0){
                        offset--;
                        offsetValidator = offset;
                        $(".covid-input-field").html(createDataField(jsArr[offset]));
                        $(".q-no").removeClass("active");$(".q-"+offset).addClass("active");
                        $(".covid-q").addClass("form-control");
                        $(".covid-q").focus();
                        $('#next').show();
                    }
                break;
              default: throw 'You are using a not valid option for the counter';
            }
            $(".covid-select").on("change", function(){
                let data = "";
                let options = ""
                let selectedValue = $(this).val();
                let obj = jsArr[offset][selectedValue];                
                if(obj instanceof Object){
                    $(".covid-input-field").delay(1000).append(createDataField(obj));
                    $(this).next().addClass("form-control child-1");
                    $(".covid-q").focus();     
                }    
                else{
                    $(".child-1").remove();
                }
            });
                   
            //$('.covid-btn').text(offset);
          }         
        })();  


function appendQuestion(responseArr){
    var result = "";
    var nestedResult = "";
    for(let i=0;i<responseArr.length;i++){
        let obj = responseArr[i];
            for(let j=0;j<obj["child"].length;j++){
                console.log((obj["child"]=="")+"fFF"+(obj["child"]==null));
                nestedResult = "<li class='list-group-item text-center question-"+obj["child"][j]["id"]+" child'>" 
                    + "<span class='badge badge-primary badge-pill pull-left'>Question "+obj["child"][j]["id"]+"</span>"
                    + "<span class='question'>"+obj["child"][j]["question"]+"</span>"
                    + "<span class='badge badge-info answer'>"+obj["child"][j]["answer"]+"</span></li>"; 
            }
        result += "<li class='list-group-item text-center question-"+obj["id"]+"'>"
                + "<span class='badge badge-primary badge-pill pull-left'>Question "+obj["id"]+"</span>"
                + "<span class='question'>"+obj["question"]+"</span>"
                + "<span class='badge badge-info answer'>"+obj["answer"]+"</span>"+nestedResult+"</li>";
        //nestedResult = "";
    }
        $(".question-list-group").html(result);
}
function createDataField(obj){
    let data = "";
    let options = ""
    options = "<option value=''>"+obj["placeholder"]+"</option>";
    for(let i=0;i<obj["checklist"].length;i++)
        options += "<option value='"+obj["checklist"][i]+"'>"+obj["checklist"][i]+"</option>"; 

    for(let i=0;i<Object.keys(obj).length;i++)
       data = Object.keys(obj)[i]+"='"+obj[Object.keys(obj)[i]]+"'";               
    return (obj["checklist"].length<=0)?
              "<input class='covid-q covid-input' "+data+"></input>":
              "<select class='covid-q covid-select' "+data+">"+options+"</select>";     
}

$(document).ready(function(){          
    $('#next').click(function(){            
        add(1);
        appendQuestion(resultSetObj);
        //appendQuestion(nestedresultSetObj);
        console.log(resultSetObj);
    });
    $('#prev').click(function(){               
        add(2);
    });  
    $('#prev').hide();
    for(let i=0;i<<%=jsArr%>.length;i++)
        $(".question-index").append("<span class='q-no q-"+i+"'>"+(i+1)+"</span>");
        $(".q-0").addClass("active");
    $(".covid-q").keyup(function(){
        if (event.keyCode === 13)
            add(1); 
    });
	 $(document).on("click", ".submit-result", function(){
		$.post( "covidSave.jsp", {result: ""+JSON.stringify(resultSetObj)+""}, function(data){
			alert(data);
			location.reload();
		});
	});     
});        
    </script>       
</html>
