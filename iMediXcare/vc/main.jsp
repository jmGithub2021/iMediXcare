<%@page contentType="text/html" import="imedix.dataobj,imedix.layout,java.io.*,imedix.cook,imedix.rcVideoConference, java.util.*,imedix.projinfo" %>
<%
    projinfo pinfo=new projinfo(request.getRealPath("/"));
    String vidServerUrl=(String)(pinfo.vidServerUrl);
   String wsPath=request.getServerName()+ ":" + request.getServerPort()+ "/WSiMediX";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
    <link rel="stylesheet" href="../bootstrap/dataTables.bootstrap.min.css">
    <script src="../bootstrap/jquery-2.2.1.min.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <script src="../bootstrap/jquery.dataTables.min.js"></script>
    <script src="../bootstrap/dataTables.bootstrap.min.js"></script>

    <script type="text/javascript" src="../bootstrap/js/loader.js"></script>
    <link href="../bootstrap/css/jquery-ui.css" rel="stylesheet">
    <script src="../bootstrap/js/jquery-ui.js"></script>
     
    <script src="https://<%=vidServerUrl%>/external_api.js"></script>
    
    <title>iMediX Conference Module</title>

    <style>
        /* html, body { height: 100%;} */
        /* .container-fluid{ 
            border: 1px solid red;           
            height: 100vh;
            overflow: hidden;
        } */
        #inner-container2{
            height: calc(100vh - 100px);
        }
        #inner-container1{
            height: calc(100vh - 25px);
            margin-bottom: 10px;
        }

        #output{
            height:15vh;
            overflow-y: scroll;
        }
        
        #doctors{
            height: 40vh;
            overflow-y: scroll;
            margin-bottom: 20px;
        }
        #buttons{
            /* height: 10vh; */
            margin-bottom: 10px;
        }
        
         /* style="min-height: 590px;" */
    </style>


    
</head>
    <body>
    <%
    /*
        Enumeration e = (Enumeration) (session.getAttributeNames());

        while ( e.hasMoreElements())
        {
            Object tring;
            if((tring = e.nextElement())!=null)
            {
                out.println(session.getValue((String) tring));
                out.println("<br/>");
            }

        }
        return;
*/
        String userid="", username="";
        cook cookx = new cook();
        Vector tmp = null;
        rcVideoConference vidconf = new rcVideoConference(request.getRealPath("/"));
        if(session.getAttribute("uid")==null || session.getAttribute("uid")==""){
            response.sendRedirect("../index.jsp");
            return;
        }else{
            userid = cookx.getCookieValue("userid", request.getCookies());
            username = cookx.getCookieValue("username", request.getCookies());
            Object res = null;
            try{
				res = vidconf.GetDoctors();
			}
			catch(Exception ex){out.println("Errr0345: "+ex.toString());}
            tmp = (Vector)res;
        }

    %>


    <div class="container-fluid">         
        <div class="row" style="margin-top: 10px;">
            <div class="col-md-3">
                <div id="inner-container1">
                    <div class="panel panel-default">
                        <div class="panel-heading">Invited Calls</div>
                        <div class="panel-body">                            
                            <div id="output"></div>
                        </div>
                    </div>      
                    <div id="buttons">
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-6">
                                <button class="btn btn-success" onClick="start()">Start</button>
                                <button class="btn btn-danger" onClick="stop()">Stop</button>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-6 text-right">
                                <button class="btn btn-primary btn-small" onClick="invite()">Invite</button>
                            </div>
                        </div>
                    </div>          
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Doctors                             
                        </div>
                        <div class="panel-body">
                            <div class="input-group" style="margin-bottom:10px;">                                
                                <input id="search-doctor" onkeyup="filterList()" class="form-control" type="text" name="search-doctor" placeholder="Doctor Name/userid"></input>
                                <div class="input-group-btn">
                                    <button class="btn btn-default" onClick="clearSearch()">Clear</button>
                                </div>
                            </div>
                            
                            <div id="doctors">                            
                                <div class="list-group">
                                <%
                                    for(int i=0;i<tmp.size();i++){
                                        dataobj temp = (dataobj) tmp.get(i);
                                        out.println("<a onClick=\"selectItem(this)\" href=\"#\" class=\"list-group-item\">");
                                        out.println("<h4 class=\"list-group-item-heading\">"+temp.getValue("name")+"</h4>");
                                        out.println("<p class=\"list-group-item-text\">"+temp.getValue("uid")+"</p>");
                                        out.println("</a>");
                                    }
                                %>
                                </div>
                            </div>                            
                        </div>
                    </div>
                    
                </div>
                
            </div>
            <div class="col-md-9">
                <%-- Video Conferencing --%>                
                <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-md-6"><% out.println("Name: "+username); %></div>
                        <div class="col-md-6">Video Conference url: <span id="room"></span></div>
                    </div>                        
                </div>
                <div class="panel-body">
                    <div id="inner-container2">
                        <div id="meet"></div>
                    </div>
                </div>
                </div>                        
            </div>
        </div>
    </div>
    
    
    
    </body>
    <script type="text/javascript">
        /* const domain = '10.5.22.11'; */
	const domain = 'meet.jit.si';
        var api = null;
        var g_room = '';
        var docid = '<%= userid %>';
        var docname = '<%= username %>';
        
        var options = {
            roomName: 'iMediX',
            width: 900,
            height: 550,
            parentNode: document.querySelector('#meet')
        };
        
        function start() {
            var time = new Date().getTime();
            var room = 'iMediX' + time;
            options['roomName'] = room;
            $.post( "start-conf.jsp?room="+room, function( data ) {
                let res = JSON.parse(data);
                console.log(res);
                console.log('Result: '+res.result);
                if(res.result === "success"){
                    var con2_height = $('#inner-container2').innerHeight();
                    options['height'] = con2_height;
                    var con2_width = $('#inner-container2').innerWidth();
                    options['width'] = con2_width;
                    api = new JitsiMeetExternalAPI(domain, options);
                    $('#room').html(room);
                    g_room = room;
                }else{
                    alert(res.message);
                }
                
                console.log('Room: '+ room);
            });
            
        }
        function stop(){
            $.post( "stop-conf.jsp?room="+g_room, function( data ) {
                let res = JSON.parse(data);
                console.log(res);
                console.log('Result: '+res.result);
                if(res.result === "success"){
                    api.dispose();
                    $('#room').html('');
                    g_room = '';
                }else{
                    alert(res.message);
                }          
            });


            //api.dispose();
            //$('#room').html('');
            //console.log('dispose: '+api);
        }


        function selectItem(ele){
            var active_a = $('#doctors a.active')
            active_a.removeClass('active');
            ele.classList.add('active');
        }


        function filterList() {
            // Declare variables
            var input, filter, ul, li, a, i, txtValueName, txtValueUid, h4, p;
            input = document.getElementById('search-doctor');
            filter = input.value.toUpperCase();
            ul = document.getElementById("doctors");
            li = ul.getElementsByTagName('a');

            // Loop through all list items, and hide those who don't match the search query
            for (i = 0; i < li.length; i++) {
                h4 = li[i].getElementsByTagName("h4")[0];
                txtValueName = h4.textContent || h4.innerText;
                p = li[i].getElementsByTagName("p")[0];
                txtValueUid = p.textContent || p.innerText;                
                if (txtValueName.toUpperCase().indexOf(filter) > -1 || txtValueUid.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
        }

        function clearSearch(){
            $('#search-doctor').val('');
            
            $('#search-doctor').trigger('onkeyup');
        }

        // websocket start
        var wsUri = "wss://<%= wsPath %>/endpoint";
        var output;

        function init()
        {
            output = document.getElementById("output");
            testWebSocket();
            
        }

        function testWebSocket()
        {
            websocket = new WebSocket(wsUri);
            websocket.onopen = function(evt) { onOpen(evt) };
            websocket.onclose = function(evt) { onClose(evt) };
            websocket.onmessage = function(evt) { onMessage(evt) };
            websocket.onerror = function(evt) { onError(evt) };
        }

        function onOpen(evt)
        {
            console.log("WebSocket connected");
            //writeToScreen("CONNECTED");
            //doSend("WebSocket rocks");
        }

        function onClose(evt)
        {
            console.log("WebSocket disconnected");
            //writeToScreen("DISCONNECTED");
        }

        function onMessage(evt)
        { 
            console.log("WebSocket message received:", evt);
            var data = evt.data;
            if(!data.endsWith('room')){
                var items = data.split('|');
                if(docid === items[0].trim()){
                    console.log('Invitation from '+items[2]+"(Url: "+items[3]+")");
                    var link = '<a href="#" onClick="joinConference(\''+items[3].trim()+'\')">' + items[4] + ' - VC Invitation from '+ items[2]+'</a>';
                    console.log("Link: "+link);
                    writeToScreen(link);
                }
                
                
            }
            
            //websocket.close();
        }

        function onError(evt)
        {
            writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
        }

        function doSend(message)
        {
            //writeToScreen("SENT: " + message);
            console.log("Sending: "+message);
            websocket.send(message);
        }

        function writeToScreen(message)
        {
            var pre = document.createElement("p");
            pre.style.margin = " 1px ";
            pre.style.padding = " 1px ";    
            pre.style.wordWrap = "break-word";
            pre.innerHTML = message;
            output.appendChild(pre);
        }

        window.addEventListener("load", init, false);

        $(document).ready(function() {
            $(document).on("click", "#sendbtn", function(){
                var sendText = $("#inp").val();
                doSend(sendText);
            });
        });

        

        function invite(){
            var time = new Date();
            var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });
            
            if(g_room === ''){
                alert("Conference is not started yet");
            }else{
                var doctor_id = $("#doctors a.active p").text();
                var doctor_name = $("#doctors a.active h4").text();
                if(doctor_id === '' || doctor_name === ''){
                    alert('Please select a doctor');
                    return;
                }else{
                    var msg = doctor_id + "|"+doctor_name+ "|"+docname+"|"+g_room +"|"+ stime;
                    doSend(msg);
                    //alert(msg);
                }  
                
            }
            
        }

        function joinConference(id){
            var room = id;
            options['roomName'] = room;
            console.log("Joining to conference: "+room);
            if(api != null)
                api.dispose();
            api = new JitsiMeetExternalAPI(domain, options);
            $('#room').html(room);
            g_room = room;            
        }
        // websocket end

    </script>    
</html>
