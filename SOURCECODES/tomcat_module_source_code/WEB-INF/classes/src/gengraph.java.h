package imedixservlets;

import imedix.rcgraphsinfo;
import imedix.rcGenOperations;
import imedix.dataobj;
import imedix.cook;
import imedix.myDate;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import java.awt.image.*;
import java.awt.*;
import javax.imageio.*;
import javax.swing.ImageIcon;
import com.sun.image.codec.jpeg.*;
import java.awt.geom.AffineTransform;

public class gengraph extends HttpServlet
{
	
	
    double iMaxValueY ;
    double iMaxValueX ;
    double iMinValueX ;
    double iMinValueY ;
    String id="";
    
	public void init(ServletConfig config) throws ServletException {
		
    
        super.init(config);
	}
  
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
       	doPost(req,resp);     	
  }
  
  
  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
  	
	 iMaxValueY = Double.MIN_VALUE;
	 iMaxValueX = Double.MIN_VALUE;
	 iMinValueX = Double.MAX_VALUE;
	 iMinValueY = Double.MAX_VALUE;
	 id="";
  	String dat="",userid="";
	rcgraphsinfo rcGraphs = new rcgraphsinfo(req.getRealPath("/"));
	//rcGenOperations rcGrnOp= new rcGenOperations(req.getRealPath("/"));
	String path=req.getRealPath("/");
	String x, y;;
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", req.getCookies());
	
	userid = cookx.getCookieValue("userid", req.getCookies());
	//dat = myDate.getCurrentDate("dmy",false);
    x = req.getParameter("x");
    y = req.getParameter("y");
    
    System.out.println("x:"+x+ " , "+"y:"+y);
    boolean draw=false;
    
    

try{
        
        Color[] color = new Color[] { Color.BLUE, Color.RED, new Color(38,91,47), new Color(61,19,64) };
        System.out.println("######### :");
	    
	    double[][] coords = rcGraphs.getGenGraphCoords(id, x, y);
	   
	    System.out.println("******** coords length :"+coords.length);
	    
        if (coords.length > 0)
        {
            for ( int i = 0; i < coords.length; i++)
	        {
	           if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	           if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	           if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	           if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	           
	           System.out.println("coords[i][0] :>>"+coords[i][0]);
	           System.out.println("coords[i][1] :>>"+coords[i][1]);
	        }
	       draw =true;
        }
        else
        {
            draw = false;
        }
     
     	System.out.println("draw>>:"+draw);
        	
        if (draw==true && (iMaxValueX >= iMinValueX) ){
        	
        	System.out.println("iMaxValueX:"+iMaxValueX+" , iMinValueX:"+iMinValueX);
        	
                    DrawLineGraph(y , coords, "Age in Months", y, color, path,resp);
             
        }else{
        		 ImageIcon ImagIcon = new ImageIcon(path+"/images/nodata.jpg");
                  BufferedImage buff= new BufferedImage(ImagIcon.getIconWidth(), ImagIcon.getIconHeight(), BufferedImage.TYPE_INT_RGB);
                  Graphics g = buff.createGraphics();
                  g.drawImage(ImagIcon.getImage(),0,0,null);
                  resp.setContentType("image/jpg");
				  OutputStream os = resp.getOutputStream();
				  ImageIO.write(buff, "jpg", os);
				  g.dispose();
				  os.close();
        }

  
 }catch(Exception e){
	 System.out.println("Exception : " + e);
 }
    
 }
 
  private void DrawLineGraph(String strTitle, double[][] coords, String xText, String yText, Color[] color, String path, HttpServletResponse resp ){
  	
  	System.out.println("strTitle :>>>>>>>>>>>>>>>>"+strTitle);
	System.out.println("iMinValueX :"+iMinValueX);
	System.out.println("iMaxValueY :"+iMaxValueY);
	System.out.println("iMinValueY :"+iMinValueY);
  	
  	strTitle=strTitle.trim();
  System.out.println("strTitle :>>>>>>>>>>>>>>>>"+strTitle);
  
   	if(strTitle.equalsIgnoreCase("1")) strTitle="Blood Sugar Fasting Graph ";
   	else if(strTitle.equalsIgnoreCase("2"))strTitle="Blood Sugar P.P.Graph ";
   	else if(strTitle.equalsIgnoreCase("3"))strTitle="Blood Sugar Random Graph ";
   	
  	try{
  	
  		int iMaxWidth = 600; 
        int iMaxHeight = 400;
        int iLeftMargin = 50;
        int iTopMargin = 50;
        int iBottomMargin = 50;
        int iRightMargin = 50;
        int iChartWidth = iMaxWidth - iLeftMargin - iRightMargin;
        int iChartHeight = iMaxHeight - iTopMargin - iBottomMargin;
		int nopoints = coords.length;
		
        int i=0, j=0, k=0, tempx, tempy;
        int x1, y1, x2, y2;
        String lblText="";
  	  
            
            BufferedImage buff= new BufferedImage(iMaxWidth, iMaxHeight, BufferedImage.TYPE_INT_RGB);
			Graphics g = buff.createGraphics();
			Color clr=new Color(240,250,255);
			g.setColor(clr);
			g.fillRect(0,0,iMaxWidth,iMaxHeight);
			g.setColor(Color.WHITE);
			g.fillRect(iLeftMargin, iTopMargin, iChartWidth, iChartHeight);
			g.setColor(Color.BLUE);
			g.drawRect(0, 0, iMaxWidth - 1, iMaxHeight - 1);
			g.setColor(Color.BLACK);
			g.drawRect(iLeftMargin, iTopMargin, iChartWidth, iChartHeight);
			
         	double iRangeX, iRangeY, iScaleX=0, iScaleY=0, tempval;
 		    System.out.println("nopoints :"+nopoints);
            Color tc =color[0];
             
                iRangeX = iMaxValueX - iMinValueX;
                iRangeY = iMaxValueY - iMinValueY;
                
            	g.setColor(Color.LIGHT_GRAY);
                for (i = 1, tempx = iLeftMargin + 20; tempx < iLeftMargin + iChartWidth; i++, tempx = tempx + 20)            	
                	g.drawLine(tempx, iTopMargin, tempx, iTopMargin + iChartHeight);	
                for (j = 1, tempy = iTopMargin + iChartHeight - 20; tempy > iTopMargin; j++, tempy = tempy - 20)
                	g.drawLine(iLeftMargin, tempy, iLeftMargin + iChartWidth, tempy);	
                	
                iScaleX = (iRangeX * 3) / i;
                iScaleY = (iRangeY * 3) / j;
                 
                 g.setColor(Color.BLUE);
                 for (tempx = iLeftMargin, k = 0; tempx <= (iLeftMargin + iChartWidth); tempx = tempx + 60, k++)
                    {
                        tempval = iMinValueX + k * iScaleX;
                        //lblText = Convert.ToString(Math.Round(tempval, 2));
                        lblText = Double.toString(Round(tempval,2));
                        g.drawString(lblText,(int)(tempx - 10), (int)(iTopMargin + iChartHeight + 20));
                    }

                    //labelfont, labelbrush,
                    g.setColor(Color.RED);
                 	g.drawString(xText,(int)(iMaxWidth / 2 - 10), (int)(iTopMargin + iChartHeight + 37));
					g.setColor(Color.BLUE);
					
					for (tempy = iMaxHeight - iBottomMargin, k = 0; tempy >= iTopMargin; tempy = tempy - 60, k++)
                    {
                        tempval = iMinValueY + k * iScaleY;
                        lblText = Double.toString(Round(tempval,2));
	                    g.drawString(lblText, (int)(iLeftMargin - 40), (int)(tempy+6));
                        
                    }
                    
                    Graphics2D g2d = (Graphics2D)g.create();
                    AffineTransform saved = g2d.getTransform();
			        AffineTransform rotate = AffineTransform.getRotateInstance(-Math.PI/2.0,(iLeftMargin - 45), (iMaxHeight / 2)-5);
			        g2d.transform(rotate);
			        g2d.setColor(Color.RED);
			        g2d.drawString(yText,(int)(iLeftMargin - 45), (int)(iMaxHeight / 2)-5);
                    g2d.setTransform(saved);
                   	g2d.dispose();
                  
        	
        		iScaleX = iChartWidth / iRangeX;
                iScaleY = iChartHeight / iRangeY;
                
                for (i = 0; i < nopoints - 1; i++)
                {
                	x1 = (int) Round((iLeftMargin + ((coords[i][0] - iMinValueX) * iScaleX)),0);
                    y1 = (int) Round((iTopMargin + iChartHeight - ((coords[i][1] - iMinValueY) * iScaleY)),0);
                    x2 = (int) Round((iLeftMargin + ((coords[i + 1][0] - iMinValueX) * iScaleX)),0);
                    y2 = (int) Round((iTopMargin + iChartHeight - ((coords[i + 1][1] - iMinValueY) * iScaleY)),0);

                     //objGraphics.DrawLine(linepen, x1, y1, x2, y2);
                    g.setColor(tc);
                    g.drawLine(x1, y1, x2, y2);
                    
                    
                }
                
                x1 = (int)(iLeftMargin + ((coords[i][0] - iMinValueX) * iScaleX));
                y1 = (int)(iTopMargin + iChartHeight - ((coords[i][1] - iMinValueY) * iScaleY));
                g.fillRect(x1 - 2, y1 - 2, 4, 4);
                String txt= Round(coords[i][0],2) + ", " + Round(coords[i][1],2);
                g.drawString(txt, x1 + 5, y1);
            
           
  	     		g.setColor(Color.RED);
  	 			g.drawString(strTitle + " of  " + id, iMaxWidth / 2 - (strTitle.length() + 18) * 4, iTopMargin / 2 +2);

	 
	  resp.setContentType("image/jpeg");
	  OutputStream os = resp.getOutputStream();
	  ImageIO.write(buff, "jpg", os);
	  g.dispose();
	  os.close();
	  
	}catch(Exception e){
	 System.out.println("Exception : " + e);
 	}			  
  	
  }
  
  private double Round(Double Rval, int Rpl) {
	  Double p = (Double)Math.pow(10,Rpl);
	  Rval = Rval * p;
	  float tmp = Math.round(Rval);
	  return (double)(tmp/p);
    }
    
 }
 	