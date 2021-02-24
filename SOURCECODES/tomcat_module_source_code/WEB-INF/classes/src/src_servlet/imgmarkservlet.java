package imedixservlets;

import imedix.dataobj;
import imedix.cook;
import imedix.rcDataEntryFrm;
import imedix.myDate;
import java.util.*;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.imageio.*;
import javax.swing.*;
public class imgmarkservlet extends HttpServlet { 

  	JFrame f = null;
 	FileOutputStream fout;
	String para="";
		
  	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
   		f = new JFrame();
    	f.addNotify();
   
  }

 public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
    //res.setContentType("text/html");
    PrintWriter out = res.getWriter();
    out.println("Error: this servlet does not support the GET method!");
    out.close();
    
 	 }

 public void doPost(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {
		
			
   			StringBuffer msgBuf = new StringBuffer();
    		BufferedReader fromApplet = req.getReader();
    		String line;
    		String ans="Saved";
    		
	
    		while ((line=fromApplet.readLine())!=null) {
      			if (msgBuf.length()>0) msgBuf.append('\n');
      			msgBuf.append(line);
    		}
    		
    		fromApplet.close();
    		para=msgBuf.toString();
    		
    		String pin[]=para.split("&");
			res.setContentType("text/plain");		
						    				
			String pid="",type="",isl="",dt="",ccode="",uid="",lin="",circle="",rect="",fhand="",txt="";
			try{
				
				
				pid=pin[0].substring(pin[0].indexOf("=")+1);
				type=pin[1].substring(pin[1].indexOf("=")+1);
				isl=pin[2].substring(pin[2].indexOf("=")+1);
				dt=pin[3].substring(pin[3].indexOf("=")+1); //dd-mm-yyyyy
				
				ccode=pin[4].substring(pin[4].indexOf("=")+1);
				uid=pin[5].substring(pin[5].indexOf("=")+1);
				
				lin=pin[6].substring(pin[6].indexOf("=")+1).trim();
				circle=pin[7].substring(pin[7].indexOf("=")+1).trim();
				rect=pin[8].substring(pin[8].indexOf("=")+1).trim();
				fhand=pin[9].substring(pin[9].indexOf("=")+1).trim();
				txt=pin[10].substring(pin[10].indexOf("=")+1).trim();
				
			}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			String imgdirname=req.getRealPath("//")+"/temp/"+uid+"/images/"+pid+"/";
			String fdt =dt.replaceAll("/","");
			String fname=pid+fdt+type+isl+".jpg";
			fname=fname.toLowerCase();
			String imgpath = imgdirname+fname;
			
			//id=NRSH1811070000&type=BLD&ser=1&dt=11/12/2007&ccode=NRSH&uid=doc&line= &circle= &rect= &fhand= -65536,180,217,179,217,178,217,176,216,174,213,168,207,160,199,154,190,146,179,140,166,135,155,134,147,133,139,133,132,135,124,139,117,145,112,153,107,163,104,175,104,192,106,211,111,234,120,261,130,286,136,307,141,326,141,343,135,358,126,366,116,373,103,376,94,377,88,377,85,375,83,373,81,371,81,368,80,366,80,363,82,361,84,359,86,358,87,356,89,355,91,354,95,353,97,353,99,352,100,351,101,351,102,350,103,350,105,350,108,350,111,350,114,350,117,350,120,350,124,350,128,350,132,350,136,350,143,351,147,351,150,351,153,351,157,351,159,351,163,351,167,351,171,352,176,352,180,352,184,352,188,352,192,352,196,351,202,350,206,349,209,348,214,347,216,347,219,345,221,344,223,342,226,340,229,336,231,334,234,330,236,327,238,323,240,319,241,315,242,311,242,307,242,304,242,300,242,296,242,292,242,287,242,283,242,281,242,280,242,279,242#&txt= 
		
	    /*	
	    	Image img = imgicon.getImage();
	        BufferedImage bi = (BufferedImage)f.createImage(img.getWidth(f),img.getHeight(f));
			Graphics g = bi.createGraphics();    // Get a Graphics object
			g.drawImage(img,0,0,img.getWidth(f),img.getHeight(f),null);
		
			Graphics2D g2D = (Graphics2D) g;
        	Stroke stroke = new BasicStroke((float)1.5);
      		g2D.setStroke(stroke);
      		*/
      		 
      		ImageIcon imgicon=null;
      		int imgw=0;
			int imgh=0;
      		try {
				imgicon =new ImageIcon(imgpath);		
				imgw=imgicon.getIconWidth();
				imgh=imgicon.getIconHeight();
 		
	 		}catch (Exception e) {
	 			e.printStackTrace();
	 			JOptionPane.showMessageDialog(null, e.toString());
	 		}
	 		
			BufferedImage bi  = new BufferedImage(imgw, imgh, BufferedImage.TYPE_USHORT_555_RGB);
			Graphics2D g = bi.createGraphics(); 
			g.drawImage(imgicon.getImage(),0,0,imgw,imgh,null);
			Stroke stroke = new BasicStroke((float)1.5);
	      	g.setStroke(stroke);
      		      		
      		/// draw Line
      		
	   		try{
	   			if(lin!=""){
	   			StringTokenizer li = new StringTokenizer(lin, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int x1=Integer.parseInt(minili.nextToken());
					int y1=Integer.parseInt(minili.nextToken());
					g.drawLine(x,y,x1,y1);
				}
				}
				}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
				}
			
						
		
			/// draw rec
			
			try{
				if(rect!=""){
					
				StringTokenizer li = new StringTokenizer(rect, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int w=Integer.parseInt(minili.nextToken());
					int h=Integer.parseInt(minili.nextToken());
					g.drawRect(x,y,w,h);
				}
				}
			}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			
			/// draw circle
			
			try{
				if(circle!=""){
				
				StringTokenizer li = new StringTokenizer(circle, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int w=Integer.parseInt(minili.nextToken());
					int h=Integer.parseInt(minili.nextToken());
					g.drawOval(x,y,w,h);
				  }	
				}
			}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			
			/// draw TXT
			
			try{
				if(txt!=""){
					
				
				StringTokenizer li = new StringTokenizer(txt,"#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					
					String  txtval=minili.nextToken();
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					g.drawString(txtval,x,y);	
				}
				}
			}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			/// draw freehand
			
			try{
				if(fhand!=""){
				
				StringTokenizer li = new StringTokenizer(fhand,"#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
				
					String[] strpts = pts.split(",");
					
					g.setColor(Color.decode(strpts[0]));
					int x =Integer.parseInt(strpts[1]);
 		    		int y =Integer.parseInt(strpts[2]);
 		    		
 		    		for(int i=3;i<strpts.length-1;){
		 			    int x1=Integer.parseInt(strpts[i++]);
						int y1=Integer.parseInt(strpts[i++]);
		 		    	g.drawLine(x,y,x1,y1);
		 		    	x=x1;
		 		    	y=y1;
					}
				}
				}
			}catch (Exception e){
				System.out.println(e.toString());
			
			}
				
									
			
			try{
					
			ByteArrayOutputStream baos	= new ByteArrayOutputStream();
			
			BufferedOutputStream bos = new BufferedOutputStream(baos);
			ImageIO.write(bi,"jpg",bos);
			
			byte[] _byte = baos.toByteArray();
			int size = baos.size();
			
			if (g != null) g.dispose();
			
			cook cookx = new cook();
        	dataobj obj = new dataobj();	
        	rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));	
        	String edt=myDate.getCurrentDate("dmy",false);
        	
			obj.add("pat_id",pid);
			obj.add("ext","jpg");
			obj.add("type",type);
			obj.add("imgdesc","Ref Images");
			obj.add("ref_code",ccode);
			obj.add("lab_name",cookx.getCookieValue("centername", req.getCookies ()));
			obj.add("doc_name",cookx.getCookieValue("username", req.getCookies ()));
			obj.add("testdate",edt);
			obj.add("entrydate",edt);
			obj.add("img_serno",isl);	
			obj.add("size",Integer.toString(size));
			obj.add("con_type","image/pjpeg");	
			
			ans=rcdef.SaveMarkImg(obj,_byte);
						
	   		}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			PrintWriter printwriter = res.getWriter();
			printwriter.println(ans);
			
	    	printwriter.close();
			
  }

  public void destroy() {
    
    if (f != null) f.removeNotify();
  }
}
