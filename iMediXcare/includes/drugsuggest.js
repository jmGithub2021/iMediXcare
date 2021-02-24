var xmlHttp
var idx
function SuggestFormula(val,formulafldid,dosefldid)
{
idx=formulafldid
//alert ("Test");	
if (val=='')
 { 
 document.getElementById(id).innerHTML="";
 //alert("I got the value");
  
 }
 else
 {
	 //alert("I did not got the value");

xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")	

 } 
 else
 {
var url="drugformulation.jsp"
url=url+"?value="+val
url=url+"&fldid1="+formulafldid
url=url+"&fldid2="+dosefldid

//alert(url)
//url=url+"&sid="+Math.random()
xmlHttp.onreadystatechange=stateChanged;


//alert(url)
xmlHttp.open("GET",url,true)
xmlHttp.send(null)
   }
  }
} 

function stateChanged() 
{ 
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	 { 
	 //alert(xmlHttp.responseText);
	 document.getElementById(idx).innerHTML='';
	 document.getElementById(idx).innerHTML=xmlHttp.responseText;
	  } 
}

function stateChanged1() 
{ 
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	 { 
	 //alert(xmlHttp.responseText);
	 //parent.rightpanel.document.body.innerHTML ="";
	 //parent.rightpanel.document.body.innerHTML =xmlHttp.responseText;
	 
	 var ob = document.getElementById('msg');
	 ob.innerHTML = "";
	 ob.innerHTML = xmlHttp.responseText;
	  } 
}


function GetXmlHttpObject()
{
var xmlHttp=null;
try
 {
 // Firefox, Opera 8.0+, Safaris
 xmlHttp=new XMLHttpRequest();
 }
catch (e)
 {
 // Internet Explorer
 try
  {
  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttp;
}


function SuggestDose(value,id)
{
idx=id	
if (value=='')
 { 
 document.getElementById(id).innerHTML="";
  }
  
  else
 {
 xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 } 
 else
 {
var url="drugdose.jsp"
url=url+"?value="+value
url=url+"&fldid="+id
//alert(url)
//url=url+"&sid="+Math.random()
xmlHttp.onreadystatechange=stateChanged;
xmlHttp.open("GET",url,true)
xmlHttp.send(null)
  }
 }
} 



function DrugBrief(id)
{
 var value=document.getElementById(id).value;

 //alert(value);

 if(value==''){
	 // parent.rightpanel.document.body.innerHTML ="";
	  var ob = document.getElementById('msg');
	  ob.innerHTML = "";
	 //return;
 }
 else
  {
	 
xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 //return
 }
 else
 { 
var url="druginfo.jsp"
url=url+"?value="+value

xmlHttp.onreadystatechange=stateChanged1;

/*
alert (xmlHttp.readyState);
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	 alert(xmlHttp.responseText);
	 //document.getElementById(idx).innerHTML='';
	 parent.rightpanel.document.body.innerHTML ="";
	 parent.rightpanel.document.body.innerHTML =xmlHttp.responseText;
	 //document.getElementById(idx).innerHTML=xmlHttp.responseText;

  } 
*/

xmlHttp.open("GET",url,true)
xmlHttp.send(null)
  }
 }
}



/*function SuggestOldFormula(val,set,id)
{
	
if (val=='')
 { 
 document.getElementById(id).
 innerHTML="";
  return;
 }

xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 return
 } 
var url="drugFormula.aspx"
url=url+"?value="+val
url=url+"&sid="+Math.random()
xmlHttp.onreadystatechange=stateChanged;
function stateChanged() 
{ 
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
document.getElementById(id).innerHTML='';
document.getElementById(id).innerHTML=xmlHttp.responseText;
 } 
}


xmlHttp.open("GET",url,true)
xmlHttp.send(null)
} 
*/