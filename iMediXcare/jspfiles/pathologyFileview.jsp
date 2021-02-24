<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook,java.util.*, java.io.OutputStream,org.json.simple.*,org.json.simple.parser.*" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String fileId="",test_id="",extension="",selectedImg="",fileListHTML="";
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	try{
		fileId = request.getParameter("fileId");
		test_id = request.getParameter("testId");
		extension = request.getParameter("ext");
		selectedImg = request.getParameter("selectedImg");
	}
	catch(Exception ex){fileId="";}
	//out.println(fileId+test_id);
	if(test_id!= null && test_id.length()>18){
		
		if(fileId!=null && !fileId.equals("")){ 	
			OutputStream os = response.getOutputStream();
			try {

				byte[] fileArray = null;
				fileArray =ddinfo.getPathoData(test_id,fileId);
				if(extension.equalsIgnoreCase("pdf"))
					response.setContentType("application/pdf");
				else if(extension.equalsIgnoreCase("doc") || extension.equalsIgnoreCase("docx"))
					response.setContentType("application/msword");
				else
					response.setContentType("image/jpeg");

				os.write(fileArray,0,fileArray.length);
				os.flush();
				os.close();

			}catch(Exception e) {
				os.write(e.toString().getBytes());
			}		
		}
		else{
			try{
				String thumbnailLink="",dataLink="";
				String fileList = ddinfo.getPathoData(test_id);
				//out.println("result : "+fileList);
				try{
					Object jsobj=new JSONParser().parse(fileList); 
					JSONObject jsonObject = (JSONObject)jsobj;
					int size = jsonObject.size()-1;
					for(int i=0;i<size;i++){
						String key = String.valueOf(i);
						JSONObject nestedObject = (JSONObject)jsonObject.get(key);	
						String file_id = (String)nestedObject.get("fileId");		 			
						String entrydate = (String)nestedObject.get("entrydate");
						String ext = (String)nestedObject.get("ext");
							if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx")){
								dataLink = "?testId="+test_id+"&fileId="+file_id+"&ext="+ext+"";
								thumbnailLink = request.getContextPath()+"/includes/pdf-icon.jpg";
							}
							else{
								dataLink = "?testId="+test_id+"&selectedImg="+file_id+"&ext="+ext+"";
								thumbnailLink = "?testId="+test_id+"&fileId="+file_id+"&ext="+ext+"";
							}
								
							fileListHTML += "<div class='pathoPreview' title='"+entrydate+"'><div class='thumbnail'><a href='"+dataLink+"'><img src='"+thumbnailLink+"' ></a></div></div>";	
					}		
				}catch(Exception ex){out.println("error : \""+ex.toString()+"\"");}
				
				
			}catch(Exception ex){out.println(ex.toString());}	
		}
		
	}
	

%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/index.css">	
	<!--<link rel="stylesheet" href="../bootstrap/jquery.dataTables.min.css">-->
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-2.2.1.min.js"></script>	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/jquery-ui.min.js"></script>
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/ap-image-zoom.min.css">
	<script src="<%=request.getContextPath()%>/bootstrap/js/ap-image-zoom.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.mousewheel.min.js"></script>
	<style>
	    .pathoPreview-body{
			margin: auto;
			display: table;
		}
		.pathoPreview {
			width: 120;
			height: 120px;
			display: inline-block;
			margin: 7px;
		}
		.pathoPreview img{width:100%;height:100% !important;}
		.zoomimage{
			margin: 10px;
			padding: 10px;
			border: 1px solid #ccc;
			box-shadow: 0px 0px 1px 1px #dcd7ff;
		}
	</style>
	
	<script>
	$(document).ready(function(){
		
	});
	</script>
</head>
<body>
<div class="container-fluid">
	<div class="row pathoPreview-body">
	<%=fileListHTML%>
	</div>
	<div class="zoomimage">
	<img id='image' src='<%="?testId="+test_id+"&fileId="+selectedImg+"&ext="+extension+""%>' style='display: none' />
	</div>
</div>
<script>
function initImage() {
				$('#image').apImageZoom({
					  cssWrapperClass: 'custom-wrapper-class'
					, minZoom: 'contain'
					// , maxZoom: false
					 , maxZoom: 6.0
					
				});
			};
			$(document).ready(function() {
				initImage();
			});

</script>
</body>
</html>



