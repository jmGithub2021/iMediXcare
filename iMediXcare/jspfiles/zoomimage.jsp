<%@ include file="..//includes/chkcook.jsp" %>

<%

// surajit Kundu @ 02/12/2016

String src = request.getParameter("src");
String id = request.getParameter("id");
String ser = request.getParameter("ser");
String type = request.getParameter("type");
String mser = request.getParameter("mser");
String dt = request.getParameter("dt");
String rcode = request.getParameter("rcode");
//displayimg.jsp?id=EXTR2211160000&ser=1&type=BLD&dt=2016-12-01%2015:14:17.0
String img_src = src+"&ser="+ser+"&type="+type+"&dt="+dt;
String imgSrc = "<img id='image' src='"+img_src+"' style='display: none' />"; 
%>


<html>
	<link rel="stylesheet" href="../bootstrap/css/ap-image-zoom.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/ap-image-zoom.min.js"></script>
	<script src="../bootstrap/js/jquery.mousewheel.min.js"></script>

<style>
body {
	background-color: #222;
	}

.custom-wrapper-class {
	width: 90% !important;
	height: 80% !important;
	margin: 10px auto;
	background-color: #eee;
	/*transition: background-color 0.3s;*/
	}
</style>
<body>

 
<%out.println(imgSrc);%>
<script>
function initImage() {
				$('#image').apImageZoom({
					  cssWrapperClass: 'custom-wrapper-class'
					, minZoom: 'contain'
					// , maxZoom: false
					 , maxZoom: 3.0
					
				});
			};
			$(document).ready(function() {
				initImage();
			});

</script>
</body>

</html>


