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

public class drawgraph extends HttpServlet
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
	rcGenOperations rcGrnOp= new rcGenOperations(req.getRealPath("/"));
	String path=req.getRealPath("/");
	
	String tab_name = "",tab_field = "",x="",y="",z="",jpath="",jtitle="",spath="",stitle="";
	
	cook cookx = new cook();
	id = cookx.getCookieValue("patid", req.getCookies());
	userid = cookx.getCookieValue("userid", req.getCookies());
		 
	String agem = cookx.getCookieValue("patagem", req.getCookies());
	int agemonthx=Integer.parseInt(agem);
	
	//dat = myDate.getCurrentDate("dmy",false);
	
    x = req.getParameter("x");
    y = req.getParameter("y");
    
try{
	String gender = rcGrnOp.getAnySingleValue("med","sex", "pat_id='"+id+"'");
   
    if(y.equalsIgnoreCase("Height")){
    	tab_name = (gender.equalsIgnoreCase("F") ? "ht_girls" : "ht_boys");
        tab_field = "ht";
        z = "Height (cm)";
    }else if(y.equalsIgnoreCase("Weight")){
    	 tab_name = (gender.equalsIgnoreCase("F") ? "wt_girls" : "wt_boys");
         tab_field = "wt";
         z = "Weight (kg)";
    }else if(y.equalsIgnoreCase("BMI")){
    	 tab_name = (gender.equalsIgnoreCase("F") ? "bmi_girls" : "bmi_boys");
         tab_field = "bmi";
         z = "BMI (kg/m2)";
    }else if(y.equalsIgnoreCase("HC")){
    	 tab_name = (gender.equalsIgnoreCase("F") ? "hc_girls" : "hc_boys");
         tab_field = "hc";
         z = "Length (cm)";
    }else if(y.equalsIgnoreCase("CD4Percent")){
    	 tab_name = "s32";
         tab_field = "cd4_percent";
          z = "#CD4 (%)";
   	}else if(y.equalsIgnoreCase("CD4Count")){
    	 tab_name = "s32";
         tab_field = "cd4_count";
         z = "#CD4";
    }
    
    int i;   
    boolean draw = true;
    double[][] coords;
    String[] plotname;
    ArrayList allCoords = new ArrayList();
    Color[] color;
    if (y.equalsIgnoreCase("CD4Count") || y.equalsIgnoreCase("CD4Percent")){
        color = new Color[] { Color.RED };
        plotname = new String[] { id };
        coords = rcGraphs.getAgeCoords(id, tab_field, tab_name);
		System.out.println(tab_name+ " Length:"+coords.length);
		
     	if(coords.length>0 ){
     		for (i = 0; i < coords.length; i++){
     			if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
                if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
                if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
                if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
     		}

     		System.out.println(" doPost iMaxValueX :"+iMaxValueX);
			System.out.println("doPost iMinValueX :"+iMinValueX);
			System.out.println("doPost iMaxValueY :"+iMaxValueY);
			System.out.println("doPost iMinValueY :"+iMinValueY);
	
     		allCoords.add(coords);
     	}else{
            draw = false;
            jpath = "images/nodata.jpg";  		
     	}
     	
     	if (draw==true){
              jtitle = "CD4 Statistics";
              
              if (iMaxValueX >= iMinValueX)
              jpath = DrawLineGraph(y + " Graph", allCoords, "Age in Months", z, color, plotname, "CD4VL_" + id,req);
              else jpath = "images/nodata.jpg";
         }
    
     }else{
     	
     	iMaxValueY = Double.MIN_VALUE;
    	iMaxValueX = Double.MIN_VALUE;
    	iMinValueX = Double.MAX_VALUE;
    	iMinValueY = Double.MAX_VALUE;
    	allCoords.clear();
     	draw=true;
     	color = new Color[] { Color.BLUE, Color.RED, new Color(38,91,47), new Color(61,19,64) };
        plotname = new String[] { "P5", "P50", "P95", id };
        
        coords = rcGraphs.getHIVRefCoords("agemonth", "P5", tab_name,10);
       // if(coords!=null){
	  		for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        
	  		allCoords.add(coords);
  		// }
  		 
        coords = rcGraphs.getHIVRefCoords("agemonth", "P50", tab_name,10);
        //if(coords!=null){
	        for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        allCoords.add(coords);
       // }
        coords = rcGraphs.getHIVRefCoords("agemonth", "P95", tab_name,10);
	   // if(coords!=null){
	        for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        
	        allCoords.add(coords);
       // }
       
       		System.out.println("2 doPost iMaxValueX :"+iMaxValueX);
			System.out.println("2 doPost iMinValueX :"+iMinValueX);
			System.out.println("2 doPost iMaxValueY :"+iMaxValueY);
			System.out.println("2 doPost iMinValueY :"+iMinValueY);
			
        coords = rcGraphs.getAgeCoords(id, tab_field, "h15",10);
        
        if (coords.length > 0)
        {
            for (i = 0; i < coords.length; i++)
	        {
	           if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	           if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	           if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	           if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];

	           System.out.println("coords[i][0] :>>"+coords[i][0]);
	           System.out.println("coords[i][1] :>>"+coords[i][1]);
	           
	        }
	        allCoords.add(coords);
        }
        else
        {
            draw = false;
            jpath = "images/nodata.jpg";  	
            
               	
        }
        
        jtitle = (gender.equalsIgnoreCase("M") ? "Boy's" : "Girl's") + " Graph for " + y + " for Age 0 - 2 years";
        
        if (draw==true){
            jtitle = (gender.equalsIgnoreCase("M") ? "Boy's" : "Girl's") + " Graph for " + y + " for Age 0 - 2 years";
            if (iMaxValueX >= iMinValueX)
            {
                jpath = DrawLineGraph(y + " Graph", allCoords, "Age in Months", z, color, plotname, "Junior_" + id,req);
            }
            else jpath = "images/nodata.jpg";  

      	}
                
        
        /////////////////////////
        
       if (agemonthx > 24 && !y.equalsIgnoreCase("HC")){
           draw = true;
       	   iMaxValueY = Double.MIN_VALUE;
    	   iMaxValueX = Double.MIN_VALUE;
    	   iMinValueX = Double.MAX_VALUE;
    	   iMinValueY = Double.MAX_VALUE;
	       
	       allCoords.clear();
       	   
       	  
			
       	   coords = rcGraphs.getHIVRefCoords("agemonth", "P5", tab_name,40);
       // if(coords!=null){
	  		for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        
	  		allCoords.add(coords);
  		// }
  		 
        coords = rcGraphs.getHIVRefCoords("agemonth", "P50", tab_name,40);
        //if(coords!=null){
	        for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        allCoords.add(coords);
       // }
        coords = rcGraphs.getHIVRefCoords("agemonth", "P95", tab_name,40);
	   // if(coords!=null){
	        for (i = 0; i < coords.length; i++)
	        {
	            if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	            if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	            if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	            if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];
	        }
	        
	        allCoords.add(coords);
       // }
       
        System.out.println(" > 24doPost iMaxValueX :"+iMaxValueX);
	    System.out.println(" > 24 doPost iMinValueX :"+iMinValueX);
		System.out.println("> 24 doPost iMaxValueY :"+iMaxValueY);
		System.out.println("> 24 doPost iMinValueY :"+iMinValueY);
			
        coords = rcGraphs.getAgeCoords(id, tab_field, "h15",40);
       
       
        if (coords.length > 0)
        {
            for (i = 0; i < coords.length; i++)
	        {
	           if (iMaxValueX < coords[i][0]) iMaxValueX = coords[i][0];
	           if (iMinValueX > coords[i][0]) iMinValueX = coords[i][0];
	           if (iMaxValueY < coords[i][1]) iMaxValueY = coords[i][1];
	           if (iMinValueY > coords[i][1]) iMinValueY = coords[i][1];

	           System.out.println("coords[i][0] :>>"+coords[i][0]);
	           System.out.println("coords[i][1] :>>"+coords[i][1]);
	           
	        }
	        allCoords.add(coords);
        }
        else
        {
            draw = false;
            spath = "images/nodata.jpg";  	
        }
        
        stitle = (gender.equalsIgnoreCase("M") ? "Boy's" : "Girl's") + " Graph for " + y + " for Age 2 - 20 years";
        
        if (draw==true){
            stitle = (gender.equalsIgnoreCase("M") ? "Boy's" : "Girl's") + " Graph for " + y + " for Age 2 - 20 years";
            
            if (iMaxValueX >= iMinValueX)
            {
                spath = DrawLineGraph(y + " Graph", allCoords, "Age in Year", z, color, plotname, "Senior_" + id,req);
            }
            else spath = "images/nodata.jpg";  
      	}
         
       } 
       
   }// CD4 Else
     

resp.setContentType("Text/HTML");
PrintWriter out = resp.getWriter();   
out.println("<html> <head> <title>"+jtitle+"</title>");
out.println("</head> <body><center>");
out.println("<h4>"+ jtitle + "</h4>");
out.println("<img src="+ jpath+ " border='0' title='Graph for children upto 2 years'/>");

if ( agemonthx > 24 && (!(y.equalsIgnoreCase("HC") || y.equalsIgnoreCase("CD4Percent") || y.equalsIgnoreCase("CD4Count")))){ 
	out.println("<br/><br/><h4>"+stitle +"</h4> ");
    out.println("<img src="+spath +" border='0' title='Graph for children more than 2 years'>");
}

out.println("</center></body></html>");
out.close();
     
 }catch(Exception e){
	 System.out.println("Exception : " + e);
 }
    
 }
 
 
 private String DrawLineGraph(String strTitle, ArrayList allCoords, String xText, String yText, Color[] color, String[] plotname, String name,HttpServletRequest req){
  
 	System.out.println("iMaxValueX :"+iMaxValueX);
	System.out.println("iMinValueX :"+iMinValueX);
	System.out.println("iMaxValueY :"+iMaxValueY);
	System.out.println("iMinValueY :"+iMinValueY);
	
  	String path="";
  	
  	try{
  	
  		int iMaxWidth = 700; 
        int iMaxHeight = 700;

        int iLeftMargin = 60;
        int iRightMargin = 40;
        int iTopMargin = 50;
        int iBottomMargin = 50;
       
        int iChartWidth = iMaxWidth - iLeftMargin - iRightMargin;
        int iChartHeight = iMaxHeight - iTopMargin - iBottomMargin;


        boolean isFirst = true;
        
        int i=0, j=0, k=0,tempx, tempy, nopoints;
        int x1, y1, x2, y2;
        double[][] coords;
        String lblText="";
	
		double r=0;
	    
	    BufferedImage buff= new BufferedImage(iMaxWidth, iMaxHeight, BufferedImage.TYPE_INT_RGB);
		Graphics g = buff.createGraphics();
			
 			double iRangeX=0, iRangeY=0, iScaleX=0, iScaleY=0, tempval=0;
 			
 			int intervalX = 0, intervalY = 0, frequencyX = 0, frequencyY = 0, count = 0;
 			
 			boolean SR = name.startsWith("Senior") ? true : false;

			intervalX = SR == true ? 12 : 2;
            frequencyX = 2;
            
            while (count < 20)
            {
                iMinValueX = ((int)(iMinValueX - intervalX) / intervalX) * intervalX < 0 ? 0 : ((int)(iMinValueX - intervalX) / intervalX) * intervalX;
                iMaxValueX = ((int)(iMaxValueX + intervalX) / intervalX) * intervalX;
                iRangeX = iMaxValueX - iMinValueX;
                count++;
               if (iRangeX / intervalX < 10 && intervalX >= 2)
                {
                    intervalX /= 2;
                    //frequencyX /= 2;
                }
                else if (iRangeX / intervalX >= 20)
                {
                    intervalX *= 2;
                    //frequencyX *= 2;
                }
                else
                    break;
            }
            
			intervalX = SR == true ? 12 : 2;
			
			
			count = 0;
            intervalY = 10;
            frequencyY = 2;
            
            while (count < 20)
            {
                iMinValueY = ((int)(iMinValueY - intervalY) / intervalY) * intervalY < 0 ? 0 : ((int)(iMinValueY - intervalY) / intervalY) * intervalY;
                iMaxValueY = ((int)(iMaxValueY + intervalY) / intervalY) * intervalY;
                iRangeY = iMaxValueY - iMinValueY;
                count++;
                
                if (iRangeY / intervalY < 10 && intervalY >= 2)
                {
                    intervalY /= 2;
                    //frequencyY /= 2;
                }
                else if (iRangeY / intervalY >= 20)
                {
                    intervalY *= 2;
                    //frequencyY *= 2;
                }
                else
                    break;
            }            

////////////


			Color clr=new Color(240,250,255);
			g.setColor(clr);
			g.fillRect(0,0,iMaxWidth,iMaxHeight);
			g.setColor(Color.WHITE);
			g.fillRect(iLeftMargin, iTopMargin, iChartWidth, iChartHeight);
			g.setColor(Color.BLUE);
			g.drawRect(0, 0, iMaxWidth - 1, iMaxHeight - 1);
		
			
/////////////

			System.out.println("allCoords.size() :"+allCoords.size());

            for (int index = 0; index < allCoords.size(); index++){

            	coords = (double[][]) allCoords.get(index);
                nopoints = coords.length;
                System.out.println("nopoints :"+nopoints);
                if(nopoints == 0) continue;
                
                Color tc =color[index];
               
       			if (isFirst) 
                {
                	
                	//iScaleX = (int)(iChartWidth / iRangeX); 
                    //iChartWidth = (int)(iRangeX * iScaleX);
                    //iRightMargin = iMaxWidth - iChartWidth - iLeftMargin;
                    //iScaleY = (int)(iChartHeight / iRangeY); 
                    //iChartHeight = (int)(iRangeY * iScaleY);
                    //iTopMargin = iMaxHeight - iChartHeight - iBottomMargin;

                    iScaleX = iChartWidth / iRangeX; 
                    iScaleY = iChartHeight / iRangeY; 
                    
                	g.setColor(Color.BLUE);
                	
                	for (r = iMinValueX; r < iMaxValueX; r += intervalX) 
                    {
                        tempx = (int)(iLeftMargin + (r - iMinValueX) * iScaleX);
                        tempval = SR == true ? r / intervalX : r;
                        //lblText = Double.toString(Round(tempval,0));
                        lblText = Integer.toString((int)tempval);
                        g.drawString(lblText,(tempx - 4), (int)(iTopMargin + iChartHeight + 20));
                    }
                                                            
                    g.setColor(Color.RED);
                 	g.drawString(xText,(int)(iMaxWidth / 2 - 10), (int)(iTopMargin + iChartHeight + 37));
                 	g.setColor(Color.BLUE);
					
                    for (r = iMinValueY; r < iMaxValueY; r += intervalY)  //tempy = iMaxHeight - iBottomMargin, k = 0; tempy > iTopMargin; tempy = tempy - 40, k++
                    {
                        tempy = (int)(iMaxHeight - iBottomMargin - (r - iMinValueY) * iScaleY);
                        tempval = r;
                        lblText = Double.toString(Round(tempval,2));
	                    g.drawString(lblText, (int)(iLeftMargin - 35), tempy+3);                        
                    }
                    
					g.setColor(Color.RED);
                    Graphics2D g2d = (Graphics2D)g.create();
                    AffineTransform saved = g2d.getTransform();
			        AffineTransform rotate = AffineTransform.getRotateInstance(-Math.PI/2.0,(iLeftMargin - 45), (iMaxHeight / 2)-5);
			        g2d.transform(rotate);
			        g2d.setColor(Color.RED);
			        g2d.drawString(yText,(int)(iLeftMargin - 45), (int)(iMaxHeight / 2)-5);
                    g2d.setTransform(saved);
                   	g2d.dispose();
                   	g.setColor(Color.LIGHT_GRAY);
                   	
                   	for (r = iMinValueX; r < iMaxValueX; r += (intervalX / frequencyX))  
                    {
                        tempx = (int)(iLeftMargin + (r - iMinValueX) * iScaleX);
                        g.drawLine(tempx, iTopMargin, tempx, iTopMargin + iChartHeight);	
                    }
                    
                    for (r = iMinValueY; r < iMaxValueY; r += intervalY / frequencyY)  
                    {
                        tempy = (int)(iMaxHeight - iBottomMargin - (r - iMinValueY) * iScaleY);
                        g.drawLine(iLeftMargin, tempy, iLeftMargin + iChartWidth, tempy);
                    }
                  	
                    isFirst = false;                    
        		}
       		
        		///////////////////////
                
                for (i = 0; i < nopoints - 1; i++)
                {
                	x1 = (int) Round((iLeftMargin + ((coords[i][0] - iMinValueX) * iScaleX)),0);
                    y1 = (int) Round((iTopMargin + iChartHeight - ((coords[i][1] - iMinValueY) * iScaleY)),0);
                    x2 = (int) Round((iLeftMargin + ((coords[i + 1][0] - iMinValueX) * iScaleX)),0);
                    y2 = (int) Round((iTopMargin + iChartHeight - ((coords[i + 1][1] - iMinValueY) * iScaleY)),0);
                    g.setColor(tc);
                    g.drawLine(x1, y1, x2, y2);
                    
                    if (index == 3 || strTitle.startsWith("CD4Count") || strTitle.startsWith("CD4Percent"))
                    {
                      
                        g.fillRect(x1 - 2, y1 - 2, 4, 4);
                       // String txt= Round(coords[i][0],2) + ", " + Round(coords[i][1],2);
                        String txt = Round((SR == true ? coords[i][0]/intervalX : coords[i][0]),2) + ", " + Round(coords[i][1],2);
                        
                        g.drawString(txt, x1 + 5, y1);	                   
                    }
                }
                
                x1 = (int)(iLeftMargin + ((coords[i][0] - iMinValueX) * iScaleX));
                y1 = (int)(iTopMargin + iChartHeight - ((coords[i][1] - iMinValueY) * iScaleY));
                
                if (index >= 3 || strTitle.startsWith("CD4Count") || strTitle.startsWith("CD4Percent"))
                {
                
                    g.fillRect(x1 - 2, y1 - 2, 4, 4);
                    //String txt= Round(coords[i][0],2) + ", " + Round(coords[i][1],2);
                    String txt = Round((SR == true ? coords[i][0]/intervalX : coords[i][0]),2) + ", " + Round(coords[i][1],2);
                    g.drawString(txt, x1 + 5, y1);
                }
                else
                	g.drawString(plotname[index], x1 + 5, y1);
            }
            
  	     	g.setColor(Color.RED);
  	 		g.drawString(strTitle + " of  " + id, iMaxWidth / 2 - (strTitle.length() + 18) * 4, iTopMargin / 2 +2);
  			
  			g.setColor(Color.BLACK);
			g.drawRect(iLeftMargin, iTopMargin, iChartWidth, iChartHeight);
			
  	  		cook cookx = new cook();
  	  		String userid = cookx.getCookieValue("userid", req.getCookies());
  	  		String imgdirname=req.getRealPath("//")+"/temp/"+userid+"/"+ name + ".gif";
  	  		path = "temp/"+userid+"/"+ name + ".gif";;
  	  		
          	try {
				ImageIO.write( buff, "gif", new File ( imgdirname ) );
				g.dispose();
			} catch (IOException e1) {
				e1.printStackTrace();
				path= "images/nodata.jpg";  
				g.dispose();	
			}
      		
	}catch(Exception e){
	 System.out.println("Exception : " + e);
	 path= "images/nodata.jpg";  	
 	}
 	
	return path;
 }
 
 
 
 /*
  private void DrawLineGraph(String strTitle, ArrayList allCoords, String xText, String yText, Color[] color, String[] plotname, String path, HttpServletResponse resp ){
  	
  	System.out.println("iMaxValueX :"+iMaxValueX);
	System.out.println("iMinValueX :"+iMinValueX);
	System.out.println("iMaxValueY :"+iMaxValueY);
	System.out.println("iMinValueY :"+iMinValueY);
  	
  	try{
  	
  		int iMaxWidth = 710; 
        int iMaxHeight = 700;
        int iLeftMargin = 60;
        int iTopMargin = 50;
        int iBottomMargin = 50;
        int iRightMargin = 50;
        int iChartWidth = iMaxWidth - iLeftMargin - iRightMargin;
        int iChartHeight = iMaxHeight - iTopMargin - iBottomMargin;

        boolean isFirst = true;
        
        int i=0, j=0, k=0, tempx, tempy, nopoints;
        int x1, y1, x2, y2;
        double[][] coords;
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
 			
 			System.out.println("allCoords.size() :"+allCoords.size());

            for (int index = 0; index < allCoords.size(); index++){

            	coords = (double[][]) allCoords.get(index);
                nopoints = coords.length;
                
                System.out.println("nopoints :"+nopoints);
                if(nopoints == 0) continue;
                
                Color tc =color[index];
               
                iRangeX = iMaxValueX - iMinValueX;
                iRangeY = iMaxValueY - iMinValueY;
                
       			if (isFirst) 
                {
                                   
                	g.setColor(Color.LIGHT_GRAY);
                    for (i = 1, tempx = iLeftMargin + 20; tempx < iLeftMargin + iChartWidth; i++, tempx = tempx + 20)                	
                    	g.drawLine(tempx, iTopMargin, tempx, iTopMargin + iChartHeight);	
                    for (j = 1, tempy = iTopMargin + iChartHeight - 20; tempy > iTopMargin; j++, tempy = tempy - 20)
                    	g.drawLine(iLeftMargin, tempy, iLeftMargin + iChartWidth, tempy);	
                    	
                    iScaleX = (iRangeX * 3) / i;
                    iScaleY = (iRangeY * 2) / j;
                 
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
					for (tempy = iMaxHeight - iBottomMargin, k = 0; tempy >= iTopMargin; tempy = tempy - 40, k++)
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
                    isFirst = false;
        		}
        		
        		
        		
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
                    
                    if (index == 3 || strTitle.startsWith("CD4Count") || strTitle.startsWith("CD4Percent"))
                    {
                       
                       //g.setColor(Color.BLUE);
                        g.fillRect(x1 - 2, y1 - 2, 4, 4);
                        String txt= Round(coords[i][0],2) + ", " + Round(coords[i][1],2);
                        g.drawString(txt, x1 + 5, y1);
	                   
                    }
                }
                
                x1 = (int)(iLeftMargin + ((coords[i][0] - iMinValueX) * iScaleX));
                y1 = (int)(iTopMargin + iChartHeight - ((coords[i][1] - iMinValueY) * iScaleY));
                
                if (index >= 3 || strTitle.startsWith("CD4Count") || strTitle.startsWith("CD4Percent"))
                {
                
                    g.fillRect(x1 - 2, y1 - 2, 4, 4);
                    String txt= Round(coords[i][0],2) + ", " + Round(coords[i][1],2);
                    g.drawString(txt, x1 + 5, y1);
                        
                   
                }
                else
                	g.drawString(plotname[index], x1 + 5, y1);
                   
                                       
            }
            
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
  
  */
  
  private double Round(Double Rval, int Rpl) {
	  Double p = (Double)Math.pow(10,Rpl);
	  Rval = Rval * p;
	  long tmp = Math.round(Rval);
	  
	  return (double)(tmp/p);
    }
    
  
 
  
 }
 	