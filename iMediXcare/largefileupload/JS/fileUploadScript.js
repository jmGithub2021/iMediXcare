$(document).ready(function() {
	/* $('#lfuploadform').submit(function(e){
			if(typeof(e)=='object'){
				alert("Data is Uploaded");
				//window.location.assign("../jspfiles/showlist.jsp");
			}
			//e.preventDefault();
	});*/
	
$('#lfuploadform').submit(function(e){
    var form = $(this);
    var url = form.attr('action');

    $.ajax({
           type: "POST",
           url: url,
           data: form.serialize(), // serializes the form's elements.
           success: function(data)
           {
			   if(data.length >0){
					alert("File is uploaded"); // show response from the php script.
					window.location="../jspfiles/showlist.jsp";
				}
           }
         });

    e.preventDefault(); // avoid to execute the actual submit of the form.
});
	
var options = {
        beforeSend : function() {
                $("#progressbox").show();
                // clear everything
                $("#progressbar").width('0%');
                $("#message").empty();
                $("#percent").html("0%");
        },
        uploadProgress : function(event, position, total, percentComplete) {
                $("#progressbar").width(percentComplete + '%');
                $("#percent").html(percentComplete + '%');

                // change message text to red after 50%
                if (percentComplete > 50) {
                $("#message").html("<font color='006600'>File Upload is in progress.....</font>");
                }
        },
        success : function() {
                $("#progressbar").width('100%');
                $("#percent").html('100%');
        },
        complete : function(response) {
        $("#message").html("<font color='blue'>Your file has been uploaded!</font>");
        $('#lfuploadform').submit();
        },
        error : function() {
        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
        }
};
$("#UploadForm").ajaxForm(options);
});
