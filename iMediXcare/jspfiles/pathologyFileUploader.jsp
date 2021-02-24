<html>
<script>
$(document).ready(function() {
	
	var data = new FormData();
  if (window.File && window.FileList && window.FileReader) {
	var other_data = $("#uploadData").serializeArray();
    $.each(other_data,function(key,input){
        data.append(input.name,input.value);
    });
    $("#files").on("change", function(e) {
		jQuery.each(jQuery('#files')[0].files, function(i, file) {
		data.append('file-'+i, file);
		});
	
      var files = e.target.files,
        filesLength = files.length;
      for (var i = 0; i < filesLength; i++) {
        var f = files[i]
        var fileReader = new FileReader();
        fileReader.onload = (function(e) {
          var file = e.target;
          $(".preview").append("<span class=\"pView\">" +
            "<img class=\"imageThumb\" src=\"" + e.target.result + "\" title=\"" + file.name + "\"/>" +
            "<br/><span class=\"glyphicon glyphicon-removet remove\"></span>" +
            "</span>");
          $(".removet").click(function(){
            $(this).parent(".pView").remove();
           // data.delete("file-0");
          });
          
          // Old code here
          /*$("<img></img>", {
            class: "imageThumb",
            src: e.target.result,
            title: file.name + " | Click to remove"
          }).insertAfter("#files").click(function(){$(this).remove();});*/
          
        });
        fileReader.readAsDataURL(f);
      }
    });
  } else {
    alert("Your browser doesn't support to File API")
  }
 
$("#uploadData").submit(function(e){

var counter = 0;	
for (var value of data.keys()) {
   console.log("sk : "+value); 
  // if(cou
   //data.delete("file_1");
   counter++;
}
console.log("cou : "+counter);
console.log(data.get("patid"));
if(counter >2){
		$.ajax({
			type:"POST",
			enctype: "multipart/form-data",
			url:"../servlet/uploadPathologydata",
			data:data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,			
			success:function(data){
				console.log(data); 
				alert("Data is uploaded !");
				$('#pathoUploadModal').modal('toggle');	
				$(".modal-backdrop").remove();
				},
			error:function(data){console.log(data);}
		});
		e.preventDefault();
	}
else{alert("Choose file"); return false;}
});


});
</script>
<style>
input[type="file"] {
  display: block;
}
.imageThumb {
    max-height: 75px;
    border: 2px dashed #c8dbf7;
    cursor: pointer;
}
.pView {
    position: relative;
    display: inline-block;
    margin: 10px 10px 0 0;
}
.remove {
	display: block;
    color: #ff1616;
    text-align: center;
    cursor: pointer;
    position: absolute;
}
.remove:hover {
  background: white;
  color: black;
}
.pathodata-dropDown{
	position:relative;
	border:1px solid #ccc;  
	width:480px;
	height:80px;	
	}
.fileupload{
	position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
	opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}
.preview{z-index:9999;position:relative;}
</style>
<body>
	<form action="" method="POST" enctype="multipart/form-data" id="uploadData" name = "uploadData">
		<input type="text" name="patid" value="<%=request.getParameter("patid")%>"  hidden/>	
		<input type="text" name="testid" value="<%=request.getParameter("testid")%>" hidden/>
	<span class="pathodata-dropDown btn glyphicon glyphicon-upload">
		<input class="fileupload" id="files" type="file" name="files" multiple required/>
	</span>
		<input class="btn btn-primary" type="submit" value="Upload" />
	</form>
	<div class="preview">
	</div>
</body>
</html>
