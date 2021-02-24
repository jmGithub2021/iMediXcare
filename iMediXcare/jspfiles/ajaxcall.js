var http;
var isWorking = false;
var displayLocation;

function getHTTPObject() 
{
    var xmlhttp;

    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') 
    {
        try 
        {
            xmlhttp = new XMLHttpRequest();
        } 
        catch (e) 
        {
            xmlhttp = false;
        }
    }
    return xmlhttp;
}

function createQuery(form)
{
    var elements = form.elements;
    var pairs = new Array();

    for (var i = 0; i < elements.length; i++) {
        if ((name = elements[i].name) && (value = elements[i].value))
            pairs.push(name + "=" + encodeURIComponent(value));
    }

    return pairs.join("&");
}

function CallbackMethodContent() 
{
    if (http.readyState == 4) 
    {
        var result = http.responseText;
        //alert(result);
        document.getElementById(displayLocation).innerHTML = "";
        document.getElementById(displayLocation).innerHTML = result;
        isWorking = false;
    }
    else if(http.readyState < 4)
    {
  	    document.getElementById(displayLocation).innerHTML = '<center><h3>Loading...</h3><br><img src="./../images/loading.gif" border="0">&nbsp;&nbsp;<img src="./../images/loading.gif" border="0">&nbsp;&nbsp;<img src="./../images/loading.gif" border="0"></center>';
    }
    else
    {
    }
}

function ExecuteCallContent(url, method, query, formname, position)
{
    //alert(url + " " + method + " " + query + " " + formname + " " + position);
    
	http = getHTTPObject(); // We create the HTTP Object	
	displayLocation = position;

    if (formname != "") 
	{
		query = query + "&" + createQuery(document.forms[formname]);
		if (method == "") method = "post";
	}

	if (!isWorking && http) 
	{
        var contentType = "application/x-www-form-urlencoded; charset=UTF-8";

        if (method == "post") 
        {
            http.open("POST", url, true);
		    http.onreadystatechange = CallbackMethodContent;
		    isWorking = true;
            http.setRequestHeader("Content-Type", contentType);
            http.send(query);
        }
        else 
        {
			if (query != "") 	
					http.open("GET", url + "?" + query, true); 
			 else 
				 http.open("GET", url , true); 

		    http.onreadystatechange = CallbackMethodContent;
		    isWorking = true;
            http.send(null); 
        }	
		
	}
}

