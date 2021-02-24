<%@page contentType="text/html" import="imedix.rcDisplayData,imedix.dataobj,imedix.cook, java.util.*,java.io.*, javax.crypto.*, imedix.Crypto, java.net.URLEncoder,  java.nio.charset.StandardCharsets" %>
<%@ include file="..//includes/chkcook.jsp" %>

<html>
<head>
<head>
<script>
function autoOpenDoc(){
document.getElementsByTagName("a")[0].click();
	}
</script>
<body onload="autoOpenDoc()">
<% 	
	String ccode="",usr="";
	String imgdirname="",imgnam="",fname="";
	cook cookx = new cook();
	rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
	
	ccode = cookx.getCookieValue("center", request.getCookies ());
	usr = cookx.getCookieValue("userid", request.getCookies());

	String id = request.getParameter("id");
	String ty = request.getParameter("ty");
	String sl = request.getParameter("sl");
	String dt = request.getParameter("dt");
	
	String endt=dt;

	//String endt=dt.substring(6)+"/"+dt.substring(3,5)+"/"+dt.substring(0,2);
	//String ext =ddinfo.getDocumentExt(id,endt,ty,sl);
	String fdt = dt.substring(8,10)+dt.substring(5,7)+dt.substring(0,4);

	String fpath="",con_type="",ext="";

//

try
   {
	 Vector alldata=(Vector)ddinfo.getDocumentdetailsOthers(id,endt,ty,sl);
	 Object res =(Object)alldata.get(0);
	 if(res instanceof String){ out.println(res.toString());}
     else{
		Vector Vtmp = (Vector)res;
		dataobj datatemp = (dataobj) Vtmp.get(0);
		con_type =datatemp.getValue("con_type");	
		ext=datatemp.getValue("ext");
		
      }
	} catch(Exception e) {
		//out.println(" <BR>ext :"+ext);
		out.println("error.."+e);
	}
	//out.println(" <BR>ext :"+ext);
	//out.println(" <BR>con_type :"+con_type);

//
	if(!con_type.equalsIgnoreCase("LRGFILE")){

		try{
				byte [] _blob =ddinfo.getDocument(id,endt,ty,sl);
				imgdirname=request.getRealPath("//")+"/temp/"+usr+"/docs/";
				fname=id+fdt+ty.toUpperCase()+sl+"."+ext;
				//fname=fname.toLowerCase();
				imgnam = imgdirname+fname;
				
				File fdir = new File(imgdirname);
				if(!fdir.exists())
				{
					boolean yes1 = fdir.mkdirs();
				}

				File fimg = new File(imgnam);
				if(!fimg.exists())
				{
					RandomAccessFile raf = new RandomAccessFile(imgnam,"rw");
					raf.write(_blob);
					raf.close();
				}

			}catch(Exception e)
			{
				out.println("Error in getbinary data : "+e.toString());
			}

		fpath="/temp/"+usr+"/docs/"+fname;
		//String fullPath = "http://" + request.getServerName() + ":" + request.getServerPort() + "/iMediX/" +fpath;

	}else{
		SecretKey key = getSecretKey(session);
	    Crypto crypto = new Crypto(key);
		fname=id+fdt+ty.toUpperCase()+sl+"."+ext;
		String datapath = "/data/"+id+"/"+fname;
		fpath="getFile.jsp?file="+URLEncoder.encode(crypto.encrypt(datapath), StandardCharsets.UTF_8);
	
	}

%>
<Font size=+1><B><center><A href=<%=fpath%>>--</A></center></B></Font>
</body>
</html>
