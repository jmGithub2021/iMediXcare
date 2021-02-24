package imedix;

import imedix.dataobj;
import imedix.myDate;
import java.util.*;
import java.io.*;
import java.awt.image.*;
import java.awt.*;
import javax.imageio.*;
import javax.swing.ImageIcon;
import com.sun.image.codec.jpeg.*;
import java.awt.geom.AffineTransform;
import java.text.DecimalFormat;

public class drawchart{
	
static int iwd=560,iht=200;
static int LM=30,TM=10,RM=10,BM=30;

static Color[] allColor={Color.BLUE,Color.RED,Color.GREEN,
						 Color.MAGENTA,Color.BLACK,Color.PINK};
    	
public static int DrawBar(String title,String x[],int y[],String fName){
	int cWd=iwd-(LM+RM);
	int cHt=iht-(TM+BM);
	         
    BufferedImage buffImg= new BufferedImage(iwd, iht, BufferedImage.TYPE_USHORT_565_RGB);
	Graphics g = buffImg.createGraphics();
	Color clr=new Color(240,250,255);
	g.setColor(clr);
	g.fillRect(0,0,iwd,iht);
	g.setColor(Color.WHITE);
	g.fillRect(LM, TM, cWd, cHt);
	g.setColor(Color.RED);
	g.drawRect(0,0,iwd-1,iht-1);
	g.setColor(Color.BLUE);
	g.drawRect(LM, TM, cWd, cHt);
	
//	g.drawString(title,(iwd/2)-LM-20,TM-5);

	int bwd=0;
	int x0=0;
	if(y.length<=8){
		bwd=cWd/8;
		x0=LM+10;
	}else{
		bwd=cWd/(y.length-1);
		x0=LM+2;
	}
	
	int bht=cHt;
    int y0=TM;
    int mVal= findMaxVal(y);
    
       
    
    int cDiff=cHt/8;
    double yValDiff=(double)mVal/8.0;
    System.out.println("mVal :"+mVal + "> yValDiff: "+yValDiff);
    double j=0;
    
    for (int ty=TM+cHt; ty>=TM ; ty=(ty-cDiff)){
    	g.setColor(Color.LIGHT_GRAY);
    	g.drawLine(LM, ty, LM+cWd, ty);	
    	g.setColor(Color.BLUE);
    	g.drawString(Double.toString(roundOneDecimals(j)), 5,ty+5);
    	j=j+yValDiff;	
    }
           
                                    	
    //for(int i=0;i<=8;i++){
    //	g.drawLine(LM,TM+(i*20),LM+cWd,TM+(i*20));
    //}
    
	 for(int i=0;i<y.length;i++){
	    int red = (int)(255*Math.random());
	    int green = (int)(255*Math.random());  
	    int blue = (int)(255*Math.random());
	    Color px = new Color(red, green, blue);
	    g.setColor(px); 
        
        int yVal=(y[i]*bht)/mVal;
        g.fillRect(x0,y0+(bht-yVal),bwd-5,yVal);
        g.drawString(Integer.toString(i+1),x0+5,y0+bht+15);
        x0=x0+bwd; 
     }    


	try{

	    BufferedOutputStream bosf = new BufferedOutputStream(new FileOutputStream(fName));
	 	JPEGImageEncoder encoderf = JPEGCodec.createJPEGEncoder(bosf);
	 	encoderf.encode(buffImg);
	 	bosf.flush();
	 	bosf.close();
	    buffImg.flush();
    }catch(Exception e){
    	
    }
    
    return 1;

		
		
	}
	
	public static int DrawPie(String title,String x[],int y[],String fName){
	int plm=LM-20;
	int ptm=TM-5;
	int cWd=iwd-(plm+RM);
	int cHt=iht-(2*ptm);

    BufferedImage buffImg= new BufferedImage(iwd, iht, BufferedImage.TYPE_USHORT_555_RGB);
	Graphics g = buffImg.createGraphics();
	Color clr=new Color(240,250,255);
	g.setColor(clr);
	g.fillRect(0,0,iwd,iht);
	
	g.setColor(Color.WHITE);
	g.fillRect(plm, ptm, cWd, cHt);
	
	g.setColor(Color.RED);
	g.drawRect(0,0,iwd-1,iht-1);
	g.setColor(Color.BLUE);
	g.drawRect(plm, ptm, cWd, cHt);
//	g.drawString(title,(iwd/2)-LM-20,TM-5);
	int x1=plm,y1=ptm;
	
	int r=(cHt-50);
	int x0=plm+(cWd/2)-(r/2)+150;
    int y0= ptm+(cHt/2)-(r/2);
   
    int incy = 10,incx=10;
    int sta=0,cnt=0;
    int totVal=findTotal(y);
    int lastVal=y.length-1;
    for(int i=0;i<y.length;i++){
	    int red = (int)(255*Math.random());
	    int green = (int)(255*Math.random());  
	    int blue = (int)(255*Math.random());
	    Color px = new Color(red, green, blue);
	    g.setColor(px); 
        
              
        double dval=(y[i]*360)/totVal;  
        int vl = (int)Math.round(dval);
        double pvl=(double)(y[i]*100)/totVal;
        pvl=roundOneDecimals(pvl);
       	if(lastVal==i) vl=360-sta;
       //System.out.println(i+">>"+sta+","+vl);
       
       	g.fillArc(x0,y0,r,r,sta,vl);
       	//g.setColor(Color.RED); 
       	//g.drawArc(x0,y0,r,r,sta,vl);
       	
       	int xx= (x0+(r/2)) + (int) ((double)((r/2)+10)* Math.cos(((sta+(vl/2)) * 3.143)/180));
        int yy= (y0 +(r/2)) - (int) ((double)((r/2)+10)* Math.sin(((sta+(vl/2)) * 3.143)/180));
        System.out.println("sta:" + sta);
        if((sta+(vl/2)) > 90 && (sta+(vl/2))<270){
        	g.drawString(Double.toString(pvl)+"%",xx-35,yy);
        }else g.drawString(Double.toString(pvl)+"%",xx,yy);
        
        sta=sta+vl;
        g.fillRect(x1+incx,y1+incy,15,15);
        g.drawString( Integer.toString(i+1),x1+(incx+25),y1+incy+12); 
        incy=incy+20;
        cnt++;
        if(cnt >= 9 ) {
          incy=10;
          incx+=60;
          cnt=0;
        }
      }
                 

	try{
	    BufferedOutputStream bosf = new BufferedOutputStream(new FileOutputStream(fName));
	 	JPEGImageEncoder encoderf = JPEGCodec.createJPEGEncoder(bosf);
	 	encoderf.encode(buffImg);
	 	bosf.flush();
	 	bosf.close();
	    buffImg.flush();
    }catch(Exception e){
    	
    }
    
    return 1;
		
		
	}
	
	private static int findMaxVal(int yVal[]){
		
		int max=0;
		for(int i=0;i<yVal.length;i++){
			if(yVal[i]>max) max=yVal[i];
		}
	return max;		
	}
	
	private static int findTotal(int yVal[]){
		
		int tot=0;
		for(int i=0;i<yVal.length;i++){
			tot+=yVal[i];
		}
	return tot;		
	}
	
	private static double roundTwoDecimals(double d) {
        	DecimalFormat twoDForm = new DecimalFormat("#.##");
		return Double.valueOf(twoDForm.format(d));
	}
private static double roundOneDecimals(double d) {
        	DecimalFormat twoDForm = new DecimalFormat("#.#");
		return Double.valueOf(twoDForm.format(d));
	}
}
