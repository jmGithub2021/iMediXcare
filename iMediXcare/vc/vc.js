var domain = '';
 $.post("getVidUrl.jsp", function (data) {
	 domain = data;
	 if (domain.length<=0 || typeof domain === 'undefined')
	 {
		 alert ("Video Url is incorrect. Meeting may not work!!");
	 }
 });

var api = null;
var g_room = '';

var pat_array = [];
var doc_live = 0;
var doc_id = "";
var doc_name = "";
var doc_regno = "";
var appointment_date = "";
var usertype = "";
var doc_status_update = 0;  // 0 = offline, 1 =  online
var lpat_appdate = null;
var lpat_size = 0;
var lpat_assigneddoc = null;
var lpat_doc_name = "";
var lpat_doc_id = "";
var cur_date = null;
var tpat_appdate = null;
var tpat_size = 0;
var tpat_assigneddoc = null;
var tpat_doc_name = "";
var tpat_doc_id = "";
var queue_no = 0;
var queue_no_updated = 0;
var dr_online_prev_msg = "";
var userid = "";
var username = "";
var imedix_mode="";
var requestedConsultation="";
var tpatwq = 0;
var queue = 0;  // ** 0=LPatQ, 1=TPatQ, 2=TPatWQ
var loading = true;

var options = {
    roomName: 'iMediX',
    width: 600,
    height: 350,
    parentNode: document.querySelector('#meet')
};

function ShowVC() {
    $(".left-doclist").show();
    $("#dialog").dialog({
        height: 350,
        width: 600
    });
}

function start() {
    var time = new Date().getTime();
    var room = 'iMediX' + time;
    options['roomName'] = room;

    $.post("../vc/start-conf.jsp?room=" + room, function (data) {
        let res = JSON.parse(data);
        console.log(res);
        console.log('Result: ' + res.result);
        if (res.result === "success") {
            // check dialog open or not
            if ($("#dialog").dialog("instance") === undefined) {
                ShowVC();
            } else if ($("#dialog").dialog("isOpen") == false) {
                ShowVC();
            }

            var con2_height = $('#inner-container2').innerHeight();
            options['height'] = con2_height;
            var con2_width = $('#inner-container2').innerWidth();
            options['width'] = con2_width;
            api = new JitsiMeetExternalAPI(domain, options);
            $('#room').html(room);
            g_room = room;
            //$(".btnStart").addClass("btnStarted");
            if ($(".btnStart").length) {
                $(".btnStart").attr('disabled', true);
            }
            $(".btnStop").attr('disabled', false);
        } else {
            alert(res.message);
        }

        console.log('Room: ' + room);
    });
}
function stop() {
    $.post("../vc/stop-conf.jsp?room=" + g_room, function (data) {
        let res = JSON.parse(data);
        console.log(res);
        console.log('Result: ' + res.result);
        if (res.result === "success") {
            api.dispose();
            $('#room').html('');
            g_room = '';
            if ($("#dialog").dialog("instance") !== undefined) {
                //if($("#dialog").dialog("isOpen") == true){
                $("#dialog").dialog("close");
                //}
            }
            if ($(".btnStart").length) {
                $(".btnStart").attr('disabled', false);
            }
            $(".btnStop").attr('disabled', true);
        } else {
            alert(res.message);
        }
    });
}

function selectItem(ele) {
    var active_a = $('#doctors a.active')
    active_a.removeClass('active');
    ele.classList.add('active');
}


// Declare variables
//function filterList() {}
$("#search-doctor").on("keyup", function () {
    var value = $(this).val().toLowerCase();
    $("#doctors li").filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
});

// function clearSearch(){}
$("#clear-docbtn").on("click", function () {
    $('#search-doctor').val('');
    $('#search-doctor').trigger('keyup');
});

function encodeMessage(msgType, senderName, senderId, receiverName, receiverId, msgText) {
    var time = new Date();
    var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });

    var msgJson = {
        msgType: msgType,   // chat,inv,live
        time: stime,
        senderName: senderName, // Name of the sender
        senderId: senderId,     // login id of the sender
        receiverName: receiverName, // Name of the receiver
        receiverId: receiverId,     // login id of the receiver
        msgText: msgText            // message
    };
    return JSON.stringify(msgJson);

}

function decodeMessage(message) {
    try {
        var msgJson = JSON.parse(message);
        return msgJson;
    } catch (error) {
        console.log("Error parsing message: " + error);
        return null;
    }

}

$("#send-msgbtn").on("click", function () {
    var time = new Date();
    var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });

    msg = $('#mesg-txt').val();
    $('#mesg-txt').val('');
    //result = "chat|"+docname+"|"+msg;
    result = encodeMessage('chat', doc_name, doc_id, null, null, msg);
    //writeToScreen("me>> " + msg);
    writeToScreen(stime + " me >> " + msg);

    doSend(result);
    // $('#search-doctor').trigger('keyup');
});

// Time Functions
function time_format(ts) {
    var d = new Date(ts);
    hours = format_two_digits(d.getHours());
    minutes = format_two_digits(d.getMinutes());
    seconds = format_two_digits(d.getSeconds());
    return "<font color=darkgreen>" + hours + ":" + minutes + ":" + seconds + "</font> : <br>";
}

function format_two_digits(n) {
    return n < 10 ? '0' + n : n;
}

// websocket start
// var wsUri = "wss://<%= wsPath %>/endpoint";
var wsUri = "ws://" + $("#wsUri").html() + "/endpoint";
console.log("wsUri = " + wsUri);
var output;

function init() {
    output = document.getElementById("output");
    testWebSocket();
}

function testWebSocket() {
    websocket = new WebSocket(wsUri);
    websocket.onopen = function (evt) { onOpen(evt) };
    websocket.onclose = function (evt) { onClose(evt) };
    websocket.onmessage = function (evt) { onMessage(evt) };
    websocket.onerror = function (evt) { onError(evt) };
}

function onOpen(evt) {
    console.log("WebSocket connected");
    writeToScreen("<b><font color=blue>Connected!!</font></b>");
    //doSend("WebSocket rocks");
}

function onClose(evt) {
    console.log("WebSocket disconnected");
    //writeToScreen("DISCONNECTED");
}

function onMessage(evt) {
    var time = new Date();
    var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });

    //console.log("WebSocket message received:", evt.data);
    var data = evt.data;
    if (!data.endsWith('room')) {
        //var items = data.split('|');
        var dataJson = decodeMessage(evt.data);
        // if(items[0] === 'inv'){
        if (dataJson['msgType'] === 'inv') {
            if (userid === dataJson['receiverId'].trim()) {
                console.log('Invitation from ' + dataJson['senderName'] + "(Url: " + dataJson['msgText'] + ")");
                var link = '<a href="#" onClick="joinConference(\'' + dataJson['msgText'].trim() + '\')">' + dataJson['time'] + ' - VC Invitation from ' + dataJson['senderName'] + '</a>';
                console.log("Link: " + link);
                writeToScreen(link); //time_format(evt.timeStamp) + " " +
                let msg11 = 'You have an invitation from ' + dataJson['senderName'] + ' for Video Conference.' +
                    ' You can click on OK button to join the conference right now or you can join the' +
                    ' conference by clicking on the invitation link in the chat window.';
                if (confirm(msg11)) {
                    joinConference(dataJson['msgText']);
                }
            }
        } else if (dataJson['msgType'] === 'chat') {
            writeToScreen(dataJson['time'] + " <em><strong>" + dataJson['senderName'] + "</strong></em> >> " + dataJson['msgText']); //"@" + time_format(evt.timeStamp) +
        } else if (dataJson['msgType'] === 'live') {
            //console.log('Beacon: '+dataJson['senderId']);
            $('a.pat-video-link').each(function () {
                if ($(this).data('patid') == dataJson['senderId']) {
                    $(this).removeClass('offline').addClass('online');
                    var pat_index = pat_array.findIndex(x => x.id == dataJson['senderId']);
                    if (pat_index == -1) {
                        pat_array.push({
                            id: dataJson['senderId'],
                            live: true
                        });
                    } else {
                        pat_array[pat_index].live = true;
                    }
                }
            });
           // console.log('Pat array: ' + JSON.stringify(pat_array));
        } else if (dataJson['msgType'] === 'live-doc') {
            if (usertype.toUpperCase() == 'PAT') {
                //console.log('doc_id: '+doc_id);
                //console.log('doc_regno: '+doc_regno);
                //console.log('userid: '+userid);
                if (doc_id == dataJson['senderId']) {
                    doc_status_update = 1;
                    doc_live = 1;
                   // console.log('Dr. '+doc_name + ' is online');
                    //var pat_info = '<div class="alert alert-success" role="alert">Dr. '+doc_name+' is <strong>online</strong></div>';
                    //$('#pat-info').html(pat_info);
                }
            }
        }
        /*else if(dataJson['msgType'] === 'patlist'){
            if (usertype.toUpperCase() == 'PAT') {
                var patl = JSON.parse(dataJson['msgText']);
                if (doc_id == dataJson['senderId']) {
                    var patl = JSON.parse(dataJson['msgText']);
                    //console.log('PatList received: '+patl['patlist']);
                    var patlarray = patl['patlist'];
                    //console.log('userid: '+userid);

                    var qno = patlarray.indexOf(userid);
                    if( qno != -1){
                        queue_no = qno+1;
                    }else{
                        queue_no = 0;
                    }
                    queue_no_updated = 1;
                    console.log('qno: '+qno);
                }
            }
        }*/
        else if(dataJson['msgType'] === 'queue-info'){
            if(usertype.toUpperCase() == 'DOC'){
                var patlist = sessionStorage.getItem('patlist');

                var currentpat = sessionStorage.getItem('currentpat');
                // console.log('patlist: '+patlist);
                // console.log('currentpat: '+currentpat);
                if(patlist != null ){

                    var patlistarray = patlist.split(',');
                    // console.log('patlistarray: "+patlistarray);
                    // console.log('receiverId: ')
                    var index = patlistarray.indexOf(dataJson['senderId']);
                    if(index == -1){
                        index = 0;
                    }else{
                        index = index+1;
                    }
                    result = encodeMessage('queue-info-update', doc_name, doc_id, null, dataJson['senderId'], index.toString());

                    doSend(result);
                }else{
                    result = encodeMessage('queue-info-update', doc_name, doc_id, null, dataJson['senderId'], "0");
                    doSend(result);
                }
            }
        }
        else if(dataJson['msgType'] === 'queue-info-update'){
            if (usertype.toUpperCase() == 'PAT'){
                if(userid == dataJson['receiverId']){
                    queue_no = parseInt(dataJson['msgText']);
                    queue_no_updated = true;
                }
            }
        }
    }

    //websocket.close();
}

function onError(evt) {
    writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
}

function doSend(message) {
    //writeToScreen("SENT: " + message);
    //console.log(websocket);
    //console.log("Sending: "+message);
    websocket.send(message);
}

function writeToScreen(message) {
    var pre = document.createElement("p");
    pre.style.margin = " 1px ";
    pre.style.padding = " 1px ";
    pre.style.wordWrap = "break-word";
    pre.innerHTML = message;
    output.appendChild(pre);
}

window.addEventListener("load", init, false);

$(document).ready(function () {
    $(document).on("click", "#sendbtn", function () {
        var sendText = $("#inp").val();
        doSend(sendText);
    });
});


function sendMailNow(objMail) {


}


function sendMail(recId = null, recName = null) {


    if (confirm('Do you really want to set an appointment for ' + recName + ' ?')) {
        var time = new Date();
        var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });
        $("#dialog-form").html("\
		<form>\
		<fieldset>\
		<ol>\
		<li><label for='meeting'>Appointment Date & Time </label>\
		<br><br>Date: <input type='date' name='Dt' id='Dt' class='text'> <br><br>\
		 Time: <select name='Hr' id='Hr'></select> Hrs <select name='Mn' id='Mn'></select> Minutes <br><br>\
		</li>\
		<li>\
		<label for='Others'>Extra comments</label> </br>\
		<input name='Others' id='Others' size=25 maxlength=200> </br>\
		</li>\
		</ol>\
		<input type='submit' tabindex='-1' style='position:absolute; top:-1000px'>\
		</fieldset>\
		</form>\
           ");
        $("#hr").html();
        $("#Mr").html();
        for (let i = 8; i < 23; i++) $("#Hr").append('<option value="' + i + '">' + i + '</option>');
        for (let i = 0; i < 59; i += 5) $("#Mn").append('<option value="' + i + '">' + i + '</option>');

        dialog = $("#dialog-form").dialog({
            autoOpen: false,
            height: 350,
            width: 400,
            modal: true,
            buttons: {
                Cancel: function () {
                    dialog.dialog("close");
                },
                "Set Appointment": function (evt) {
                    buttonDomElement = evt.target;
                    $(buttonDomElement).attr('disabled', true);
                    var Dt = $("#Dt").val();
                    var Hr = $("#Hr").val();
                    var Mn = $("#Mn").val();
                    var Oth = $("#Others").val();
                    /*alert ( "meetingMail : " + meetingMail + "\n" +
                                         "Meeting Time : " + Hr + ":" + Mn + "\n"+
                         "Others : " + Oth); */
                    $.post("../jspfiles/commdoc2pat.jsp", { 'Dt': Dt, 'Hr': Hr, "Mn": Mn, "Others": Oth, "uid": recId, "uname": recName }, function (data) {
                        alert("Data Loaded, Mail will be sent \n\n" + data.trim());
                        dialog.dialog("close");
                    });

                }

            },
            close: function () {
                //form[ 0 ].reset();
                //allFields.removeClass( "ui-state-error" );
            }
        });

        dialog.dialog("open");
        $("#meeting").focus();

    }
}

function sendMailTpat(recId = null, recName = null) {


    if (confirm('Do you really want to set an appointment for ' + recName + ' ?')) {
        var time = new Date();
        var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });
        $("#dialog-form").html("\
		<form>\
		<fieldset>\
		<ol>\
		<li><label for='meeting'>Appointment Date & Time </label>\
		<br><br>Date: <input type='date' name='Dt' id='Dt' class='text'> <br><br>\
		 Time: <select name='Hr' id='Hr'></select> Hrs <select name='Mn' id='Mn'></select> Minutes <br><br>\
		</li>\
		<li>\
		<label for='Others'>Extra comments</label> </br>\
		<input name='Others' id='Others' size=25 maxlength=200> </br>\
		</li>\
		</ol>\
		<input type='submit' tabindex='-1' style='position:absolute; top:-1000px'>\
		</fieldset>\
		</form>\
           ");
        $("#hr").html();
        $("#Mr").html();
        for (let i = 8; i < 23; i++) $("#Hr").append('<option value="' + i + '">' + i + '</option>');
        for (let i = 0; i < 59; i += 5) $("#Mn").append('<option value="' + i + '">' + i + '</option>');

        dialog = $("#dialog-form").dialog({
            autoOpen: false,
            height: 350,
            width: 400,
            modal: true,
            buttons: {
                Cancel: function () {
                    dialog.dialog("close");
                },
                "Set Appointment": function (evt) {
                    buttonDomElement = evt.target;
                    $(buttonDomElement).attr('disabled', true);
                    var Dt = $("#Dt").val();
                    var Hr = $("#Hr").val();
                    var Mn = $("#Mn").val();
                    var Oth = $("#Others").val();
                    /*alert ( "meetingMail : " + meetingMail + "\n" +
                                         "Meeting Time : " + Hr + ":" + Mn + "\n"+
                         "Others : " + Oth); */
                    $.post("../jspfiles/commdoc2tpat.jsp", { 'Dt': Dt, 'Hr': Hr, "Mn": Mn, "Others": Oth, "uid": recId, "uname": recName }, function (data) {
                        alert("Data Loaded, Mail will be sent \n\n" + data.trim());
                        dialog.dialog("close");
                    });

                }

            },
            close: function () {
                //form[ 0 ].reset();
                //allFields.removeClass( "ui-state-error" );
            }
        });

        dialog.dialog("open");
        $("#meeting").focus();

    }
}


function setAppoinment(recId = null, recName = null, appdate = null, apptime=null){
	let dataSize = recId.length;
	let date = new Date();
	let Hr = apptime.split(":")[0];
	let Mn = apptime.split(":")[1];
	let Oth = "";
	let counter = 0;
	for(let i=0;i<dataSize;i++){
		$.post("../jspfiles/commdoc2pat.jsp", { 'Dt': appdate, 'Hr': Hr, "Mn": Mn, "Others": Oth, "uid": recId[i], "uname": recName[i] }, function (data) {
			counter++;
		}).complete(function(){
			if(i==(dataSize-1)){
				if(counter==dataSize)
					alert("Appointment is set for all selected patient, patient will be notified through mail.\n\n");
				else if(counter==0)
					alert("Appointment is not set, please try again");
				else
					alert("Appointment is set.");
			}
		});
	}

}

function setAppoinmentTpat(recId = null, recName = null, appdate = null, apptime=null){
	let dataSize = recId.length;
	let date = new Date();
	let Hr = apptime.split(":")[0];
	let Mn = apptime.split(":")[1];
	let Oth = "";
	let counter = 0;
	for(let i=0;i<dataSize;i++){
		$.post("../jspfiles/commdoc2tpat.jsp", { 'Dt': appdate, 'Hr': Hr, "Mn": Mn, "Others": Oth, "uid": recId[i], "uname": recName[i] }, function (data) {
			counter++;
		}).complete(function(){
			if(i==(dataSize-1)){
				if(counter==dataSize)
					alert("Appointment is set for all selected patient, patient will be notified through mail.\n\n");
				else if(counter==0)
					alert("Appointment is not set, please try again");
				else
					alert("Appointment is set.");
			}
		});
	}

}

function invite(recId = null, recName = null) {
    if (confirm('Do you really want to invite ' + recName + ' for Video Conference?')) {
        var time = new Date();
        var stime = time.toLocaleString('en-IN', { hour: '2-digit', minute: '2-digit', hour12: true });

        if (g_room === '') {
            alert("Conference is not started yet");
        } else {
            var spancont = $("#doctors a.active span").text();
            //var doctor_id = $("#doctors a.active p").text();
            //var doctor_name = $("#doctors a.active h4").text();
            if (recId == null && recName == null) {   // if calling doctor
                var spanary = spancont.split('|');
                var recId = spanary[1];
                var recName = spanary[0];
            }

            if (recId === '' || recName === '') {
                alert('Please select a doctor');
                return;
            } else {
                //var docname ="dummy";
                result = encodeMessage('inv', doc_name, doc_id, recName, recId, g_room);
                //var msg = "inv|"+doctor_id + "|"+doctor_name+ "|"+docname+"|"+g_room +"|"+ stime;
                doSend(result);
                console.log('sending inv: ' + result);
                //alert(msg);
            }
        }
    }
}

function joinConference(id) {
    var room = id;
    options['roomName'] = room;
    console.log("Joining to conference: " + room);
    if (api != null)
        api.dispose();
    api = new JitsiMeetExternalAPI(domain, options);
    $('#room').html(room);
    g_room = room;
    if ($("#dialog").dialog("instance") === undefined) {
        ShowVC();
    } else if ($("#dialog").dialog("isOpen") == false) {
        ShowVC();
    }
    if ($(".btnStart").length) {
        $(".btnStart").attr('disabled', true);
    }
    $(".btnStop").attr('disabled', false);
}

function beacon(userid) {
    result = encodeMessage('live', null, userid, null, null, null);
    //console.log('Beaconing: '+userid);
    //console.log('Doctor Id: '+doc_id);
    doSend(result);
}
function beaconDoctor(userid) {
    result = encodeMessage('live-doc', null, userid, null, null, null);
    doSend(result);
}
// websocket end

setInterval(function () {
    pat_array.forEach(function (item) {
        if (item.live == true) {
            item.live = false;
        } else {
            $('a.pat-video-link').each(function () {
                if ($(this).data('patid') == item.id) {
                    $(this).removeClass('online').addClass('offline');
                }
            });
        }
    })

    // patient queue information update and doctor status
    if (usertype == 'PAT') {
        // load patient queue information
        loadPatientQueueInformation(userid);
        if (doc_status_update == 0) {
            // no live-doc message received since last 10 sec
            doc_live = 0;
        } else {
            // live-doc message received
            doc_status_update = 0;
        }
        if(queue_no_updated == 0){
            queue_no = 0;
        }else{
            queue_no_updated = 0;
        }
    }

}, 10000);

function updatePatientInfo(firstTime = false){
    var btninfo = $('button.req-const-btn');
    //console.log('updatePatientInfo with firstTime = '+firstTime+', btninfo = '+btninfo.prop('disabled'));
    //console.log('first time:'+firstTime);
    //$('#DocId').html(lpat_doc_id+"-"+lpat_doc_name);
    if(queue == 0){
        doc_name = lpat_doc_name;
        appointment_date = lpat_appdate;
        doc_id = lpat_doc_id;
        $('#appDoc').html(doc_name);
    }else if(queue == 1){
        doc_name = tpat_doc_name;
        appointment_date = tpat_appdate;
        doc_id = tpat_doc_id;
        $('#appDoc').html(doc_name);
    }else if(queue == 2){
        $('#appDoc').html('');
    }
	console.log("Queue: "+queue);


    //console.log('doc name: '+doc_name);


    if(btninfo.prop('disabled')){
        //  console.log('button is disabled');
        if((requestedConsultation.localeCompare("true"))==0 && (imedix_mode.localeCompare("admin"))==0)
        {
          var pat_info = '<div class="alert alert-info" role="alert"><h4>Please wait for your consultation request to be approved.</h4></div>';
          $('#pat-info').html(pat_info);

        }else if(queue == 2){
            var pat_info = '<div class="alert alert-info" role="alert"><h4>You have heen referred to a doctor, please wait.</h4></div>';
            $('#pat-info').html(pat_info);
        }else{
            if(firstTime == true){
                var pat_info = '<div class="alert alert-info" role="alert"><h4>You are provisionally assigned to Dr. ' + doc_name + ' for consultation.</h4></div>';
                dr_online_prev_msg = '';
                $('#pat-info').html(pat_info);
            }else{
                if(appointment_date == ''){
                    var pat_info = '<div class="alert alert-info" role="alert"><h4>You are provisionally assigned to Dr. ' + doc_name +' for consultation. The appointment date of your visit not yet set.</h4></div>';
                    $('#pat-info').html(pat_info);
                    dr_online_prev_msg = '';
                }else{
                    var apDate = moment(appointment_date);
                    var cDate = moment(cur_date);


                    //console.log('apDate: '+apDate.format('DD-MM-YYYY, hh:mm A'));
                    //console.log('cDate: '+cDate.format('DD-MM-YYYY, hh:mm A'));
                    if(apDate.isAfter(cDate, 'day')){
                        var pat_info = '<div class="alert alert-info" role="alert"><h4>Your appointment date and time: '+
                            apDate.format('DD-MM-YYYY, hh:mm A')+'. '+
                            'Please log into the system at least 30 minutes before the appointment time on that day.'+
                            '</h4></div>';
                        $('#pat-info').html(pat_info);
                        dr_online_prev_msg = '';
                    }else if(apDate.isBefore(cDate, 'day')){
                        if(doc_live == 1){
                            var pat_info = '<div class="alert alert-success" role="alert"><marquee><h4>Dr. ' + doc_name + ' is available. ';

                            if(queue_no == 0){
                                pat_info += 'You are in the queue, please wait.';
                            }else{
                                pat_info += 'Your number in the queue is '+ queue_no;
                            }
                            pat_info += '</h4></marquee></div>';
                            if(dr_online_prev_msg != pat_info){
                                dr_online_prev_msg = pat_info;
                                $('#pat-info').html(pat_info);
                            }

                        }else{
                            var pat_info = '<div class="alert alert-danger" role="alert"><h4>Sorry! You missed your appointment. Request for a new appointment date ?</h4>'+
                            '&nbsp;&nbsp;<button class="btn btn-primary" id="btn-reset-app" onClick="resetAppointment()">YES</button>&nbsp;&nbsp;'+
                            '<button class="btn btn-warning" onClick="removeAppointment()" id="btn-remove-app">NO</button></h4></div>';
                            $('#pat-info').html(pat_info);
                            dr_online_prev_msg = '';
                        }
                    }else if(apDate.isSame(cDate, 'day')){
                        if(doc_live == 1){
                            var pat_info = '<div class="alert alert-success" role="alert"><marquee><h4>Dr. ' + doc_name + ' is available. ';

                            if(queue_no == 0){
                                pat_info += 'You are in the queue, please wait.';
                            }else{
                                pat_info += 'Your number in the queue is '+ queue_no;
                            }
                            pat_info += '</h4></marquee></div>';
                            if(dr_online_prev_msg != pat_info){
                                dr_online_prev_msg = pat_info;
                                $('#pat-info').html(pat_info);
                            }
                        }else{

                            var pat_info = '<div class="alert alert-info" role="alert"><h4>Dr. ' + doc_name + ' is not yet available. Please wait.</h4></div>';
                            $('#pat-info').html(pat_info);
                            dr_online_prev_msg = '';
                        }
                    }
                    //console.log('Date: '+apDate.toDateString()+', Time: '+apDate.toTimeString());
                    //console.log('Date: '+cDate.toDateString()+', Time: '+cDate.toTimeString());
                }
            }
        }
    }else{
        var pat_info = "";
       // $('#pat-info').html(pat_info);
        dr_online_prev_msg = '';
    }
}

function resetAppointment(){
    var pat_info = '<div class="alert alert-info" role="alert"><h4>Wait...</h4></div>';
    $('#pat-info').html(pat_info);
    dr_online_prev_msg = '';
    var _cmd = "";
    if(queue == 0){
        _cmd = 'reset-lpat';
    }else{
        _cmd = 'reset-tpat';
    }
    $.ajax({
        url: 'patAppointmentInfo.jsp',
        data: {cmd: _cmd},
        success: function(data){
            var patinfo = JSON.parse(data);
            console.log('patinfo: '+patinfo);
            alert(patinfo['message']);
        }
    });
}

function removeAppointment(){
    var pat_info = '<div class="alert alert-info" role="alert">Wait...</div>';
    $('#pat-info').html(pat_info);
    dr_online_prev_msg = '';
    var _cmd = "";
    if(queue == 0){
        _cmd = 'remove-lpat';
    }else{
        _cmd = 'remove-tpat';
    }
    $.ajax({
        url: 'patAppointmentInfo.jsp',
        data: {cmd: _cmd},
        success: function(data){
            var patinfo = JSON.parse(data);
            console.log('patinfo: '+patinfo);
            //alert(patinfo['message']);
            location.reload();
        }
    });
}

function loadPatientQueueInformation(patid = ""){
    //console.log('patient id: '+patid);
    $.ajax({
        url: 'patAppointmentInfo.jsp',
        data: {patid: patid},
        success: function(data){
            var patinfo = JSON.parse(data);
            //console.log('patinfo: '+patinfo);
            lpat_appdate = patinfo['lpatq_apdate'];
            lpat_assigneddoc = patinfo['lpatq_assigneddoc'];
            lpat_size = parseInt(patinfo['lpat_size']);
            lpat_doc_name = patinfo['lpatq_doc_name'];
            lpat_doc_id = patinfo['lpatq_doc_id'];
            cur_date = patinfo['cur_date'];
            tpat_appdate = patinfo['tpatq_apdate'];
            tpat_assigneddoc = patinfo['tpatq_assigneddoc'];
            tpat_size = parseInt(patinfo['tpat_size']);
            tpat_doc_name = patinfo['tpatq_doc_name'];
            tpat_doc_id = patinfo['tpatq_doc_id'];
            tpatwq = parseInt(patinfo['tpatwq']);
            var btninfo = $('button.req-const-btn');
            imedix_mode=patinfo['imedix_mode'];
            requestedConsultation=patinfo['requestedConsultation'];
            console.log(imedix_mode+" : "+requestedConsultation);
            //console.log(imedix_mode.localeCompare("admin")+":"+requestedConsultation.localeCompare("true"));
            //alert(imedix_mode);
            if((requestedConsultation.localeCompare("true"))==0 && (imedix_mode.localeCompare("admin"))==0)
            {
              btninfo.prop('disabled', true);
            }
            else if(lpat_size != 0 || tpat_size != 0 || tpatwq != 0 ){
                btninfo.prop('disabled', true);
            }else{
                btninfo.prop('disabled', false);
            }

            // queue selection
            if(lpat_size ==1 && tpat_size == 1){
                if(lpat_appdate != '' && tpat_appdate != ''){
                    var lapDate = moment(lpat_appdate);
                    var tapDate = moment(tpat_appdate);
                    if(lapDate.isBefore(tapDate)){
                        queue = 0;
                    }else{
                        queue = 1;
                    }
                }else{
                    // only one queue app date is set
                    if(lpat_appdate != ''){
                        queue = 0;
                    }else if(tpat_appdate != ''){
                        queue = 1;
                    }else if(tpatwq == 1){
                        queue = 2;
                    }
                }
            }else{
                if(lpat_size == 1){
                    queue = 0;
                }else if(tpat_size == 1){
                    queue = 1;
                }else if(tpatwq == 1){
                    queue = 2;
                }
            }
        },
        complete: function(){
            updatePatientInfo();
            getQueueInfo(patid);
        }
    });
}

function getQueueInfo(userid){
    result = encodeMessage('queue-info', null, userid, null, doc_id, null);
    doSend(result);
}
