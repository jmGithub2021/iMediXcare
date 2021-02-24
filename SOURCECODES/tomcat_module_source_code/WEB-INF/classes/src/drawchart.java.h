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
	

//static int iwd=620,iht=200;
static int LM=30,TM=10,RM=10,BM=30;

static Color[] allColor={new Color(29,2,167),new Color(255,0,0),new Color(27,107,130),
				new Color(185,85,85),new Color(93,48,175),
				new Color(173,47,190),new Color(69,27,11),new Color(8,193,149),new Color(148,101,47),
				new Color(251,84,138),new Color(117,112,21),new Color(0,0,100),new Color(245,75,237),
				new Color(99,102,107),new Color(54,71,37),new Color(140,60,7),new Color(138,7,249),
				new Color(144,1,109),new Color(0,130,1),new Color(61,88,239),new Color(74,153,132),
				new Color(115,50,118),new Color(99,100,95),new Color(247,32,110),new Color(69,5,70),
				new Color(21,73,143),new Color(13,77,28),new Color(0,0,0)};
    	
public static String DrawBar(int iwd,int iht,String title,String x[],int y[],String fName){
//	static int iwd=620,iht=380;
	String map="";
	String ttip="";
	if(title.indexOf("Image Vs")>-1) ttip="No of Images:&nbsp;";
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
		bwd=cWd/(y.length);
		x0=LM+5;
	}
	
	int bht=cHt;
    int y0=TM;
    int mVal= findMaxVal(y);
           
    int trow=cHt/20;
    int cDiff=cHt/trow;
    
    double yValDiff=(double)mVal/trow;
    
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
    if(mVal>0){
    	 for(int i=0;i<y.length;i++){
		 	Color px=null;
		    if(i<allColor.length){
		    	px = allColor[i];	
		    }else{
		    	int red = (int)(255*Math.random());
		    	int green = (int)(255*Math.random());  
		    	int blue = (int)(255*Math.random());
		    	px = new Color(red, green, blue);
		    }
		    
		    g.setColor(px); 
	        
	        double DyVal=((double)y[i]* (double) bht)/(double)mVal;
	        int yVal=(int)Math.round(DyVal);
	        g.fillRect(x0,y0+(bht-yVal),bwd-5,yVal);
	        int xm1=x0;
	        int ym1=y0+(bht-yVal);
	        int xm2=x0+bwd-5;
	        int ym2=y0+(bht-yVal)+yVal;
	        
	        
	    	map+="<area shape='rect' coords='"+xm1+","+ym1+","+xm2+","+ym2+"' href='#' Title='"+ttip+""+x[i]+"&nbsp;(Value:&nbsp;"+y[i]+")' />";
	
	        g.drawString(Integer.toString(i+1),x0+3,y0+bht+15);
	        x0=x0+bwd; 
	     }
     }else{
     	 g.drawString("No Data for Statistics ",cWd/2,cHt/2);
     }    


//
		try {
			ImageIO.write( buffImg, "gif", new File ( fName ) );
		} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
		}
//
/*
	try{

	    BufferedOutputStream bosf = new BufferedOutputStream(new FileOutputStream(fName));
	 	JPEGImageEncoder encoderf = JPEGCodec.createJPEGEncoder(bosf);
	 	encoderf.encode(buffImg);
	 	bosf.flush();
	 	bosf.close();
	    buffImg.flush();
    }catch(Exception e){
    	
    }
    */
    
    return map;

		
		
	}
	
	public static String DrawPie(int iwd,int iht,String title,String x[],int y[],String fName){
	
	String ttip="";
	if(title.indexOf("Image Vs")>-1) ttip="No of Images:&nbsp;";
	
	String map="";
	//static int iwd=620,iht=380;
	//int plm=LM-20;
	//int ptm=TM-5;
	int plm=0;
	int ptm=0;
		
	int cWd=iwd;//-(plm+RM);
	int cHt=iht;//-(2*ptm);

    BufferedImage buffImg= new BufferedImage(iwd, iht, BufferedImage.TYPE_USHORT_555_RGB);
	Graphics g = buffImg.createGraphics();
	//Color clr=new Color(240,250,255);
//	g.setColor(clr);
//	g.fillRect(0,0,iwd,iht);
	
	g.setColor(Color.WHITE);
	g.fillRect(plm, ptm, cWd, cHt);
	
	//g.setColor(Color.RED);
//	g.drawRect(0,0,iwd-1,iht-1);
	g.setColor(Color.BLUE);
	g.drawRect(plm, ptm, cWd-1, cHt-1);
//	g.drawString(title,(iwd/2)-LM-20,TM-5);
	int x1=plm,y1=ptm;
	
	int r=(cHt-50);
	int x0=plm+(cWd/2)-(r/2)+100;
    int y0= ptm+(cHt/2)-(r/2);
   
    int incy = 10,incx=10;
    int sta=0,cnt=0;
    int trow=(cHt)/20;
    
	System.out.println("trow: "+trow);
	
    int totVal=findTotal(y);
    int lastVal=y.length-1;
    
   if(totVal>0){
   	
    for(int i=0;i<y.length;i++){
	   Color px=null;
	    if(i<allColor.length){
	    	px = allColor[i];	
	    }else{
	    	int red = (int)(255*Math.random());
	    	int green = (int)(255*Math.random());  
	    	int blue = (int)(255*Math.random());
	    	px = new Color(red, green, blue);
	    }
	    g.setColor(px); 
          
        double dval=((double)y[i]*360.0)/(double)totVal;         
        int vl = (int) Math.round(dval);
             
        double pvl=(double)(y[i]*100)/totVal;
        
        // System.out.printf("pvl :"+y[i] + " >> "+pvl);
        
        pvl=roundOneDecimals(pvl);
       	//if(i==lastVal) vl=360-sta;
       //System.out.println(i+">>"+sta+","+vl);
       
       	g.fillArc(x0,y0,r,r,sta,vl);
       	
       	//g.setColor(Color.RED); 
       	//g.drawArc(x0,y0,r,r,sta,vl);
       	
       	///// map code
       	String points=(x0+(r/2))+","+(y0+(r/2));
       	//Polygon poly=new Polygon();
       	//poly.addPoint(x0+(r/2),y0+(r/2));
       	
       	for(int an=sta;an<(sta+vl); an+=30){
       		int xm1=(x0+(r/2)) + (int) ((double)((r/2))* Math.cos((an * 3.143)/180));
        	int ym1=(y0 +(r/2)) - (int) ((double)((r/2))* Math.sin((an * 3.143)/180));
        	points+=","+xm1+","+ym1;
        	//poly.addPoint(xm1,ym1);
       	}
       	     	
        int xm2=(x0+(r/2)) + (int) ((double)((r/2))* Math.cos(((sta+vl) * 3.143)/180));
        int ym2=(y0 +(r/2)) - (int) ((double)((r/2))* Math.sin(((sta+vl) * 3.143)/180));
        points+=","+xm2+","+ym2;
        //poly.addPoint(xm2,ym2);
                
       //g.setColor(Color.RED); 
       //g.drawPolygon(poly);
       g.setColor(px); 
        
      map+="<area shape='POLY' coords='"+points+"' href='#' Title='"+ttip+x[i]+"&nbsp;(Value:&nbsp;"+pvl+"%)' />";
   	  int xx= (x0+(r/2)) + (int) ((double)((r/2)+10)* Math.cos(((sta+(vl/2)) * 3.143)/180));
      int yy= (y0 +(r/2)) - (int) ((double)((r/2)+10)* Math.sin(((sta+(vl/2)) * 3.143)/180));
        
        System.out.println("sta:" + sta);
        if((sta+(vl/2)) > 80 && (sta+(vl/2))<130)
        	g.drawString(Double.toString(pvl)+"%",xx-10,yy); 	
        else if((sta+(vl/2)) >= 130 && (sta+(vl/2))<220)
        	g.drawString(Double.toString(pvl)+"%",xx-25,yy+5); 	
        else if((sta+(vl/2)) >= 210 && (sta+(vl/2))<330)
        	 g.drawString(Double.toString(pvl)+"%",xx-12,yy+12); 	
        else g.drawString(Double.toString(pvl)+"%",xx,yy);
        
        sta=sta+vl;
        g.fillRect(x1+incx,y1+incy,15,15);
        g.drawString( Integer.toString(i+1),x1+(incx+25),y1+incy+12); 
        incy=incy+20;
        cnt++;
        if(cnt >= trow-1 ) {
          incy=8;
          incx+=50;
          cnt=0;
        }
      }
    }else{
     	 g.drawString("No Data for Statistics ",cWd/2,cHt/2);
    }    
      
                 
	try {
		ImageIO.write( buffImg, "gif", new File ( fName ) );
		} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
		}
/*
	try{
	    BufferedOutputStream bosf = new BufferedOutputStream(new FileOutputStream(fName));
	 	JPEGImageEncoder encoderf = JPEGCodec.createJPEGEncoder(bosf);
	 	encoderf.encode(buffImg);
	 	bosf.flush();
	 	bosf.close();
	    buffImg.flush();
    }catch(Exception e){
    	
    }
    */
    
    return map;
		
		
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
