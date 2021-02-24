
package imedixservlets;

import imedix.dataobj;
import imedix.cook;
import imedix.myDate;

import imedix.rcDataEntryFrm;
import java.io.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import java.awt.image.*;
import javax.imageio.*;
import java.awt.*;
import javax.swing.*;
import java.util.StringTokenizer;


public class savepatch extends HttpServlet
{
	String id,fn,lines,edt,ptype="";
	JFrame f = null;
	public void init(ServletConfig config) throws ServletException {
    super.init(config);
    id="";
    fn="";
    lines="";
    edt="";
    ptype="";
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
	    	String imgdesc=as[5];
	    	if(imgdesc.equalsIgnoreCase("")) imgdesc="Skin Patch";
	        String src = httpservletrequest.getRealPath("/")+"/jspfiles/anatomyimages/"+fn+".jpg";
	        ImageIcon imgicon =new ImageIcon(src);
	        
	        Image img = imgicon.getImage();
	        
	        BufferedImage bi = (BufferedImage)f.createImage(img.getWidth(f),img.getHeight(f));
			Graphics g = bi.createGraphics();    // Get a Graphics object
			g.drawImage(img,0,0,img.getWidth(f),img.getHeight(f),null);
			Graphics2D g2D = (Graphics2D) g;
        	Stroke stroke = new BasicStroke((float)1.5);
      		g2D.setStroke(stroke);
      		g.setColor(Color.RED);
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
			obj.add("lab_name",cookx.getCookieValue("centername", httpservletrequest.getCookies ()));
			obj.add("doc_name",cookx.getCookieValue("username", httpservletrequest.getCookies ()));
			if(!ptype.equalsIgnoreCase("SKP")) obj.add("formkey","-1");
			
			obj.add("testdate",edt);
			//obj.add("testdate",myDate.getCurrentDateMySql());
			obj.add("entrydate",myDate.getCurrentDateMySql());
			obj.add("size",Integer.toString(size));
			obj.add("con_type","image/pjpeg");
			obj.add("imgtyp","X");
			obj.add("userid",cookx.getCookieValue("userid", httpservletrequest.getCookies ()));
			obj.add("center",cookx.getCookieValue("center", httpservletrequest.getCookies ()));
			int ans=rcdef.UploadHttp(obj,_byte);
			
			//httpservletresponse.sendRedirect(".."+"/jspfiles/showlist.jsp");
					
        }
        catch(Exception exception)
        {
            printwriter.println("Error in doGet : ");
            printwriter.println(exception.toString());
        }
        
        
        
    }
}