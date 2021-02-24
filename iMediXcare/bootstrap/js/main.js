(function() {

    $(".dropzone").dropzone({
        url: '../servlet/uploadPathologydata',
      //  url: 'http://10.4.1.61:8080/iMediX/largefileupload/UploadFile.jsp',
        margin: 20,
		allowedFileTypes: 'image.*, pdf',
        params:{
            'action': 'save'
        },
		uploadOnDrop: true,
        uploadOnPreview: false,
        success: function(res, index){
            console.log(res, index);
        }
    });
}());
