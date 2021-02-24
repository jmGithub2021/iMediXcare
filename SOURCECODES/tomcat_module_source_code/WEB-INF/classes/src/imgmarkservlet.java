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
//surajit kundu 03.01.2015
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
						    				
			String ext="", endt="",pid="",type="",isl="",dt="",ccode="",uid="",doc="",cn="",fhand="",col="";
			Color color;
			try{
				
				
				pid=pin[0].substring(pin[0].indexOf("=")+1);
				type=pin[1].substring(pin[1].indexOf("=")+1);
				isl=pin[2].substring(pin[2].indexOf("=")+1);
				dt=pin[3].substring(pin[3].indexOf("=")+1); //dd-mm-yyyyy
				ext=pin[4].substring(pin[4].indexOf("=")+1);
				
				ccode=pin[5].substring(pin[5].indexOf("=")+1);
				uid=pin[6].substring(pin[6].indexOf("=")+1);
				fhand=pin[7].substring(pin[7].indexOf("=")+1).trim();
				col=pin[8].substring(pin[8].indexOf("=")+1).trim();
				cn=pin[9].substring(pin[9].indexOf("=")+1).trim();
				doc=pin[10].substring(pin[10].indexOf("=")+1).trim();
				
				System.out.println("dt : "+dt);
				endt=dt.substring(8,10)+"/"+dt.substring(5,7)+"/"+dt.substring(0,4);
				
				
				
					
			}catch (Exception e){
				System.out.println(e.toString());
				ans="Error";
			}
			
			String imgdirname=req.getRealPath("//")+"/temp/"+uid+"/images/"+pid+"/";
			
			String fdt =endt.replaceAll("/","");
			
			String fname=pid+fdt+type+isl+"."+ext;
			fname=fname.toLowerCase();
			String imgpath = imgdirname+fname;
			
			
      		 
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
	 		color= Color.decode(col);
			BufferedImage bi  = new BufferedImage(imgw, imgh, BufferedImage.TYPE_USHORT_555_RGB);
			Graphics2D g = bi.createGraphics(); 
			g.drawImage(imgicon.getImage(),0,0,imgw,imgh,null);
			Stroke stroke = new BasicStroke((float)1.5);
	      	g.setStroke(stroke);
      		g.setColor(color);      		
      	
			
			try{
				StringTokenizer li = new StringTokenizer(fhand, "-");
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
			obj.add("lab_name",cn);
			obj.add("doc_name",doc);
			obj.add("testdate",edt);
			obj.add("entrydate",myDate.getCurrentDateMySql());
			obj.add("img_serno",isl);	
			obj.add("size",Integer.toString(size));
			obj.add("con_type","image/pjpeg");	
			obj.add("userid",uid);
			obj.add("center",ccode);
					
			System.out.println("ccode : "+ccode);
				
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
