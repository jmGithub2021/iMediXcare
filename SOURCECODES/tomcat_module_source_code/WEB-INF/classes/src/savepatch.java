
package imedixservlets;

import imedix.dataobj;
import imedix.cook;
import imedix.myDate;

import imedix.rcDataEntryFrm;
import java.io.*;
import java.util.Date;
import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import javax.servlet.*;
import javax.servlet.http.*;
import java.awt.image.*;
import javax.imageio.*;
import java.awt.*;
import javax.swing.*;
import java.util.StringTokenizer;
import java.lang.reflect.Field;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;

//surajit kundu 25.08.2015
public class savepatch extends HttpServlet
{
	String id,fn,lines,edt,ptype="",cname="", docname="", uid="", cencode="",isl="",dt1="",src="",ht="",wd="",dataURL="",col="";
	BufferedImage bi;
	Graphics g;
	JFrame f = null;
	File file;
	FileOutputStream osf;
	Color color;
	public void init(ServletConfig config) throws ServletException {
    super.init(config);
  
    id="";
    fn="";
    lines="";
    edt="";
    ptype="";
    cname="";
    docname="";
    uid="";
    cencode="";
    isl="";
    dt1="";
    ht="";
    wd="";
    src="";
    dataURL="";
    
    f = new JFrame();
    f.addNotify();
  }
  
    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws IOException
    {
		
		
        httpservletresponse.setContentType("text/plain");
        PrintWriter printwriter = httpservletresponse.getWriter();
        FileWriter filewriter = new FileWriter((new StringBuilder()).append(httpservletrequest.getRealPath("//")).append("//testing.txt").toString());
        filewriter.write("I am from servlet\n");
        filewriter.close();
        printwriter.println("Error: this servlet does not support the GET method!");
        printwriter.close();
    }
    

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
		httpservletresponse.setHeader( "Pragma", "no-cache" );
		httpservletresponse.setHeader( "Cache-Control", "no-cache" );
		httpservletresponse.setDateHeader( "Expires", 0 );
		  
	    String para,s;
        cook cookx = new cook();
        dataobj obj = new dataobj();	
        rcDataEntryFrm rcdef = new rcDataEntryFrm(httpservletrequest.getRealPath("/"));	
        
	    String usr = cookx.getCookieValue("userid", httpservletrequest.getCookies ());
	   
	    	    
       PrintWriter printwriter = httpservletresponse.getWriter();
       try {
       
	        StringBuffer stringbuffer = new StringBuffer();
	        BufferedReader bufferedreader = httpservletrequest.getReader();

	        while((s = bufferedreader.readLine()) != null) 
	        {
	            if(stringbuffer.length() > 0) stringbuffer.append('\n');
	            	stringbuffer.append(s);
	        }
	        
	        bufferedreader.close();
	        para = stringbuffer.toString();
	        String as[] = para.split("&");
	        lines = as[0];
	        id = as[1];
	        fn = as[2];
	        edt= as[3];
	        ptype = as[4];
	        String imgdesc="";
	        if(as.length>=6) imgdesc=as[5];
	        cname=as[6];
	        docname=as[7];
	        uid=as[8];
	        cencode=as[9];
	        isl=as[10];
	        dt1=as[11];
	        ht=as[12];
	        wd=as[13];
	        dataURL=as[14];
	        col=as[15];
	    	if(imgdesc.equalsIgnoreCase("")) imgdesc="Skin Patch";
	    	if(col==null || col=="") color=Color.PINK;
	    	 try {
      // get color by hex or octal value
      color= Color.decode(col);
    } catch (NumberFormatException nfe) {
      // if we can't decode lets try to get it by name
      try {
        // try to get a color by name using reflection
        final Field f = Color.class.getField(col);

        color= (Color) f.get(null);
      } catch (Exception ce) {
        // if we can't get any color return black
        color= Color.BLUE;
      }
    }
	    	
	    	if(Integer.parseInt(wd)==1 ||Integer.parseInt(ht)==1)
	    	{
	       src = httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/"+fn+".jpg";
	       ImageIcon imgicon =new ImageIcon(src);
	        Image img = imgicon.getImage();
	        
	        
	        bi = (BufferedImage)f.createImage(img.getWidth(f),img.getHeight(f));
			g = bi.createGraphics();    // Get a Graphics object
			g.drawImage(img,0,0,img.getWidth(f),img.getHeight(f),null);
			Graphics2D g2D = (Graphics2D) g;
        	Stroke stroke = new BasicStroke((float)1.5);
      		g2D.setStroke(stroke);
      		g.setColor(color);
		}
	      else
	      {
			  /*
			//src = httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/lun.jpg";  
		   // String Srv = "http://" + httpservletrequest.getServerName() + ":" + httpservletrequest.getServerPort();
			//Srv =Srv+"/iMediX/";
			//src = Srv+"jspfiles/displayimg.jsp?id="+URLEncoder.encode(id, "UTF-8")+"&ser="+URLEncoder.encode(isl, "UTF-8")+"&type="+URLEncoder.encode(fn, "UTF-8")+"&dt="+URLEncoder.encode(dt1, "UTF-8");
			//src = Srv+"jspfiles/displayimg.jsp?id="+id+"&ser="+isl+"&type="+fn+"&dt="+dt1;
			//src=("<img src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAGz0lEQVR4Xu3VMcpe5xVF4WgqKVx6DIGMR2W6gBCkS5lxZAgGjyGNQUXG4satnL2vkDnZ91G978d51/oX+vAn/xBA4KsEPmCDAAJfJyAQfx0I/A4BgfjzQEAg/gYQeEbA/yDPuPnqJQQE8hLRnvmMgECecfPVSwgI5CWiPfMZAYE84+arlxAQyEtEe+YzAgJ5xs1XLyEgkJeI9sxnBATyjJuvXkJAIC8R7ZnPCAjkGTdfvYSAQF4i2jOfERDIM26+egkBgbxEtGc+IyCQZ9x89RICAnmJaM98RkAgz7j56iUEBPIS0Z75jIBAnnHz1UsICOQloj3zGYE/JJC///jPT8/O89X3IPCP//zt8/f43cXfFMii1f/xJoHk0gWSs5pZCiRXKZCc1cxSILlKgeSsZpYCyVUKJGc1sxRIrlIgOauZpUBylQLJWc0sBZKrFEjOamYpkFylQHJWM0uB5CoFkrOaWQokVymQnNXMUiC5SoHkrGaWAslVCiRnNbMUSK5SIDmrmaVAcpUCyVnNLAWSqxRIzmpmKZBcpUByVjNLgeQqBZKzmlkKJFcpkJzVzFIguUqB5KxmlgLJVQokZzWzFEiuUiA5q5mlQHKVAslZzSwFkqsUSM5qZimQXKVAclYzS4HkKgWSs5pZCiRXKZCc1cxSILlKgeSsZpYCyVUKJGc1sxRIrlIgOauZpUBylQLJWc0sBZKrFEjOamYpkFylQHJWM0uB5CoFkrOaWQokVymQnNXMUiC5SoHkrGaWAslVCiRnNbMUSK5SIDmrmaVAcpUCyVnNLAWSqxRIzmpmKZBcpUByVjNLgeQqBZKzmlkKJFcpkJzVzFIguUqB5KxmlgLJVQokZzWzFEiuUiA5q5mlQHKVAslZzSwFkqsUSM5qZimQXOVrAvn3X3/6S45le/nLn//78/YLf3vdxy+fv/WdAvlWgv+H3wsklyaQnNXMUiC5SoHkrGaWAslVCiRnNbMUSK5SIDmrmaVAcpUCyVnNLAWSqxRIzmpmKZBcpUByVjNLgeQqBZKzmlkKJFcpkJzVzFIguUqB5KxmlgLJVQokZzWzFEiuUiA5q5mlQHKVAslZzSwFkqsUSM5qZimQXKVAclYzS4HkKgWSs5pZCiRXKZCc1cxSILlKgeSsZpYCyVUKJGc1sxRIrlIgOauZpUBylQLJWc0sBZKrFEjOamYpkFylQHJWM0uB5CoFkrOaWQokVymQnNXMUiC5SoHkrGaWAslVCiRnNbMUSK5SIDmrmaVAcpUCyVnNLAWSqxRIzmpmKZBcpUByVjNLgeQqBZKzmlkKJFcpkJzVzFIguUqB5KxmlgLJVQokZzWzFEiuUiA5q5mlQHKVAslZzSwFkqsUSM5qZimQXKVAclYzS4HkKgWSs5pZCiRXKZCc1cxSILlKgeSsZpYCyVUKJGc1sxRIrlIgOauZpUBylQLJWc0sBZKrFEjOamYpkFylQHJWM0uB5CoFkrOaWQokVymQnNXMUiC5yj8kkPyc77j81w+fvuOv++mLBD5++fytZwnkWwn6/i4BgRRu/A9SwBqZCqQQKZAC1shUIIVIgRSwRqYCKUQKpIA1MhVIIVIgBayRqUAKkQIpYI1MBVKIFEgBa2QqkEKkQApYI1OBFCIFUsAamQqkECmQAtbIVCCFSIEUsEamAilECqSANTIVSCFSIAWskalACpECKWCNTAVSiBRIAWtkKpBCpEAKWCNTgRQiBVLAGpkKpBApkALWyFQghUiBFLBGpgIpRAqkgDUyFUghUiAFrJGpQAqRAilgjUwFUogUSAFrZCqQQqRAClgjU4EUIgVSwBqZCqQQKZAC1shUIIVIgRSwRqYCKUQKpIA1MhVIIVIgBayRqUAKkQIpYI1MBVKIFEgBa2QqkEKkQApYI1OBFCIFUsAamQqkECmQAtbIVCCFSIEUsEamAilECqSANTIVSCFSIAWskalACpECKWCNTAVSiBRIAWtkKpBCpEAKWCNTgRQiBVLAGpkKpBApkALWyFQghUiBFLBGpgIpRAqkgDUyFUghUiAFrJGpQAqRAilgjUwFUogUSAFrZCqQEZGecZbAh7OXOQyBAwQEckCCE+4SEMhdNy47QEAgByQ44S4Bgdx147IDBARyQIIT7hIQyF03LjtAQCAHJDjhLgGB3HXjsgMEBHJAghPuEhDIXTcuO0BAIAckOOEuAYHcdeOyAwQEckCCE+4SEMhdNy47QEAgByQ44S4Bgdx147IDBARyQIIT7hIQyF03LjtAQCAHJDjhLgGB3HXjsgMEBHJAghPuEhDIXTcuO0BAIAckOOEuAYHcdeOyAwR+BeBx7+deOHClAAAAAElFTkSuQmCC' />");
			//src=("data:image/png;base64,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");
			// printwriter.println("{"+src+"}");
	        
	             
	           // ImageIcon imgicon =new ImageIcon(src);
	           // Image img = imgicon.getImage();
			//	URL url = new URL(src.trim());
			//	HttpURLConnection uc = (HttpURLConnection) url.openConnection();
			//	Thread.sleep(1000);
			//	InputStream is = new BufferedInputStream(uc.getInputStream());
			//	Thread.sleep(1000);
			//	Image img = ImageIO.read(is);	
			//	Thread.sleep(1000);
			
			
			 //Image img = Toolkit.getDefaultToolkit().getImage(src.trim());
			// Thread.sleep(3000);
				
				
				bi = (BufferedImage)f.createImage(Integer.parseInt(wd),Integer.parseInt(ht));
				//bi=new BufferedImage(Integer.parseInt(wd),Integer.parseInt(ht), BufferedImage.TYPE_INT_ARGB);
				g = bi.createGraphics();    // Get a Graphics object
				g.drawImage(img,0,0,Integer.parseInt(wd),Integer.parseInt(ht),null);
				Graphics2D g2D = (Graphics2D) g;
				Stroke stroke = new BasicStroke((float)1.5);
				g2D.setStroke(stroke);
				g.setColor(Color.RED);
				 */
				 
				 
				 
				 //dataURL= "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";         
		
try{
Base64 decoder = new Base64(); 
byte[] imgBytes = decoder.decode(dataURL);
file=new File(httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/temp_img/"+id+dt1+isl+".jpg");
osf = new FileOutputStream(file);
osf.write(imgBytes);
osf.flush();

}
catch(Exception e)
{
Thread.sleep(2000);
Base64 decoder = new Base64(); 
byte[] imgBytes = decoder.decode(dataURL);
file=new File(httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/temp_img/"+id+dt1+isl+".jpg");
osf = new FileOutputStream(file);
osf.write(imgBytes);
osf.flush();
}
finally{System.out.println("All server are busy. Try after sometimes");}

 src = httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/temp_img/"+id+dt1+isl+".jpg";
	       ImageIcon imgicon =new ImageIcon(src);
	        Image img = imgicon.getImage();
	        
	        
	        bi = (BufferedImage)f.createImage(Integer.parseInt(wd),Integer.parseInt(ht));
			g = bi.createGraphics();    // Get a Graphics object
			g.drawImage(img,0,0,Integer.parseInt(wd),Integer.parseInt(ht),null);
			Graphics2D g2D = (Graphics2D) g;
        	Stroke stroke = new BasicStroke((float)1.5);
      		g2D.setStroke(stroke);
      		g.setColor(color);
				
		}
			try{
				StringTokenizer li = new StringTokenizer(lines, "-");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					StringTokenizer minili = new StringTokenizer(pts, ",");
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int x1=Integer.parseInt(minili.nextToken());
					int y1=Integer.parseInt(minili.nextToken());
					g.drawLine(x,y,x1,y1);
				}
			}catch (Exception e){
				System.out.println(e.toString());
			}
			
			//String fname=id+".jpg";
			//String fpath=httpservletrequest.getRealPath("/")+"/tmp/"+usr+"/images/"+fname;
			//ImageIO.write(bi,"jpg",new File(fpath));
			
			ByteArrayOutputStream baos	= new ByteArrayOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(baos);
			ImageIO.write(bi,"jpg",bos);
			byte[] _byte = baos.toByteArray();
			int size = baos.size();		
			if (g != null) g.dispose();
			obj.add("pat_id",id);
			obj.add("ext","jpg");
			obj.add("type",ptype);
			obj.add("imgdesc",imgdesc);
			
			obj.add("lab_name",cname);
			obj.add("doc_name",docname);
			if(!ptype.equalsIgnoreCase("SKP")) obj.add("formkey","-1");
			
			obj.add("testdate",edt);
			//obj.add("testdate",myDate.getCurrentDateMySql());
			obj.add("entrydate",myDate.getCurrentDateMySql());
			obj.add("size",Integer.toString(size));
			obj.add("con_type","image/pjpeg");
			obj.add("imgtyp","X");
			obj.add("userid",uid);
			obj.add("center",cencode);
			int ans=rcdef.UploadHttp(obj,_byte);
			baos.close();
			bos.close();
			
			
			 
			//httpservletresponse.sendRedirect("../jspfiles/showlist.jsp");
			Thread.sleep(1000);
			file.delete();
			osf.close();
					
        }
        catch(Exception exception)
        {
            printwriter.println("Error in doGet : ");
            printwriter.println(exception.toString());
        }
        
        
        
    }
}
