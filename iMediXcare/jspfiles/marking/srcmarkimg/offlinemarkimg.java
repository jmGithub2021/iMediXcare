
//program for image marking applet
//http://10.5.19.216:5050/iMediX/displayimg.jsp?id=NRSH1912070008&ser=0&type=BLD&dt=24/12/2007/

import java.awt.event.*;
import java.awt.*;
import java.applet.*;
import java.io.*;
import java.util.*;
import java.net.*;
import java.lang.*;
import javax.swing.ImageIcon;
import javax.swing.*;
import java.awt.image.BufferedImage;

/*
<APPLET CODE="offlinemark"  WIDTH="200" HEIGHT="200">
<Param name="uid" value="doc">
<Param name="ccode" value="NRSH">

</APPLET>
*/

public class offlinemarkimg extends Applet implements MouseListener, MouseMotionListener,ActionListener
{	
	String uid="",prms="",ccode="";
		
	Point org  = new Point(0,0);
	Point sp  = new Point(0,0);
	Point ep  = new Point(0,0);
	Point WH  = new Point(0,0);
	Point Ssp  = new Point(0,0);
	
	Color fColor=Color.RED;
		
	String lin=" ",cir=" ",rectan=" ",fhand=" ",option="",txt=" ",file="",got="Processing";
	String SText="";
	boolean tag=false;
	Button line, circle, rec,free,bttxt,color,save;	
	Panel but = new Panel();
	Panel but1 = new Panel();
	Panel but2 = new Panel();
	Panel but3 = new Panel();
	ImageIcon imgicon;	
	BufferedImage buffImg;
	int imgw=0,imgh=0;			
	String fname="",pid="";
	String url="";
	
	public void init()
	{
		setLayout(new BorderLayout());
		addMouseMotionListener(this);
	    addMouseListener(this);
		
		url=getDocumentBase().toString();		
		String spturl[] =url.split("\\?");
		url=spturl[0];
		prms=spturl[1];
		url=url.substring(0,url.lastIndexOf("jspfiles"));
		
		//prms=prms.substring(0,prms.length()-1);
		// img = getImage(getDocumentBase(),getParameter("image"));
		// JOptionPane.showMessageDialog(null,"Imgpath:" + getParameter("image"));
		// file = getParameter("image").substring(getParameter("image").lastIndexOf("//"));	
		// file = getParameter("filepath");
		
		//JOptionPane.showMessageDialog(null,"getDocumentBase :" + getDocumentBase());	
		//JOptionPane.showMessageDialog(null,"url :" +url );
		//JOptionPane.showMessageDialog(null,"prms :" +prms );
		
		uid=getParameter("uid");
		ccode=getParameter("ccode");
		fname=getParameter("fname");
		
		pid=getParameter("pid");
		
		//setForeground(Color.black);
						
		//creating the button
		but1.setLayout(new FlowLayout(FlowLayout.CENTER));
		but2.setLayout(new FlowLayout(FlowLayout.CENTER));
		but3.setLayout(new FlowLayout(FlowLayout.CENTER));
		
		but.setBackground(Color.white);
		but.setForeground(Color.blue);
		
		but1.setBackground(Color.white);
		but1.setForeground(Color.blue);
	
		but2.setBackground(Color.white);
		but2.setForeground(Color.blue);
		
		but3.setBackground(Color.white);
		but3.setForeground(Color.blue);
			
		
		line = new Button("Line");
		but1.add(line);
		circle = new Button("Circle");
		but1.add(circle);
		
		rec = new Button("Rectangle");
		but2.add(rec);
		free = new Button("Free Hand");
		but2.add(free);
		
		bttxt= new Button("Text");
		but3.add(bttxt);
		color = new Button("Color");
		but3.add(color);
		save = new Button("Save");
		but3.add(save);
		
		int wd=this.getWidth();
		if(wd>=390){	
		but.setLayout(new FlowLayout(FlowLayout.CENTER));
		but.add(but1);
		but.add(but2);
		but.add(but3);
		}else if (wd<390 && wd>=270){		
			but.setLayout(new BorderLayout());
			but1.add(but2);
			but.add(but1,BorderLayout.NORTH);
			but.add(but3,BorderLayout.CENTER);

		}else{
			but.setLayout(new BorderLayout());
			but.add(but1,BorderLayout.NORTH);
			but.add(but2,BorderLayout.CENTER);
			but.add(but3,BorderLayout.SOUTH);
		}
		
		add(but, BorderLayout.SOUTH);
		setForeground(Color.red);
		line.addActionListener(this);
		circle.addActionListener(this);
		rec.addActionListener(this);
		save.addActionListener(this);
		free.addActionListener(this);
		color.addActionListener(this);
		bttxt.addActionListener(this);
		
		try {
			
			//String imgdirname=request.getRealPath("//")	
			//String imagePath=url+"/displayimg.jsp?"+prms;
			
			String imagePath=url+"/temp/"+uid+"/images/"+pid+"/"+fname;
			
			//System.out.println(imagePath);
			
			imgicon=new ImageIcon(new URL(imagePath));		
			imgw=imgicon.getIconWidth();
			imgh=imgicon.getIconHeight();
 		
 		}catch (Exception e) {
 			e.printStackTrace();
 			JOptionPane.showMessageDialog(null, e.toString());
 		}
 		
		buffImg  = new BufferedImage(imgw, imgh, BufferedImage.TYPE_USHORT_555_RGB);
		Graphics2D big = buffImg.createGraphics(); 
		big.drawImage(imgicon.getImage(),0,0,imgw,imgh,null);
	    
	}

	public void paint(Graphics g)
	{
		super.paintComponents(g);
		update(g);
	}
	
	public void update(Graphics g){
		Graphics2D g2D = (Graphics2D) g;
		Stroke stroke = new BasicStroke((float)5.0);
		g2D.setStroke(stroke);
		g.drawImage(buffImg,0,0,imgw,imgh, this);
		if(option.equalsIgnoreCase("save"))
		{
				setForeground(Color.black);
				but.setEnabled(false);
				showStatus(got);
		}		
	}
		
	// when mouse button is pressed
	
	public void mousePressed(MouseEvent e)
	{
        e.consume();
        
		Graphics g =  buffImg.createGraphics();
    	g.setColor(fColor);
    	Graphics2D g2D = (Graphics2D) g;  
    	Stroke stroke = new BasicStroke((float)1.5);
      	g2D.setStroke(stroke);
      		    	
    	if(option.equalsIgnoreCase("freehand"))
    	{
			org.x=e.getX();
			org.y=e.getY();
			
			fhand+=Integer.toString(fColor.getRGB())+","+Integer.toString(org.x) + "," + Integer.toString(org.y);
			
		}
		
		sp.x=e.getX();
		sp.y=e.getY();
		ep.x=e.getX();
		ep.y=e.getY();
		
		
		if(option.equalsIgnoreCase("Text"))
    	{
    	  g.setColor(fColor);
          g.drawString(SText,e.getX(),e.getY());
   		  txt+=Integer.toString(fColor.getRGB())+","+SText+","+Integer.toString(e.getX()) + "," + Integer.toString(e.getY())+"#";
		 }
		
		showStatus("sx=" + sp.x + ", sy=" +sp.y);
		repaint();
	}

	public void setwh(Point a,Point b)   {  
     	if(a.x>b.x){
     		Ssp.x=(a.x-(a.x-b.x));
			WH.x=(a.x-b.x);     		
     	}
     	else{
     		Ssp.x=a.x;
			WH.x=(b.x-a.x);     	
     	}
     	if(a.y>b.y){
     		Ssp.y=(a.y-(a.y-b.y));
			WH.y=(a.y-b.y);     		
     	}
     	else{
     		Ssp.y=a.y;
			WH.y=(b.y-a.y);     	
     	}	
    }
    
    public void mouseDragged(MouseEvent e)
	{
		e.consume();
		Graphics g =  buffImg.createGraphics();
    	g.setColor(fColor);
    	Graphics2D g2D = (Graphics2D) g;  
    	Stroke stroke = new BasicStroke((float)1.5);
      	g2D.setStroke(stroke);
      	
      	if(option.equals("line"))
		{	
			g.setXORMode(getBackground());
      	  	g.setColor(fColor);    	   
			g.drawLine(sp.x,sp.y,ep.x,ep.y); 		
    		g.drawLine(sp.x,sp.y,e.getX(),e.getY());
    		ep.x=e.getX();
			ep.y=e.getY();
		}			
		
		if(option.equals("circle"))		
		{
			
			g.setXORMode(getBackground());
      	  	g.setColor(fColor);
    	    setwh(sp,ep);
    	   	g.drawOval(Ssp.x,Ssp.y,WH.x,WH.y);
    	   	ep.x=e.getX();
			ep.y=e.getY();
			setwh(sp,ep);
    		g.drawOval(Ssp.x,Ssp.y,WH.x,WH.y);
    		
		}
		
		if(option.equals("rectangle"))		
		{
			g.setXORMode(getBackground());
      	  	g.setColor(fColor);
    	   // g2D.setStroke(stroke);
    	    setwh(sp,ep);
			g.drawRect(Ssp.x,Ssp.y,WH.x,WH.y);
			ep.x=e.getX();
			ep.y=e.getY();
			setwh(sp,ep);
    		g.drawRect(Ssp.x,Ssp.y,WH.x,WH.y);
    		
		}
		
		if(option.equals("freehand"))		
		{	
			g.setColor(fColor);
			g.drawLine(org.x,org.y,e.getX(),e.getY());
			org.x=e.getX();
			org.y=e.getY();					
			fhand+=","+Integer.toString(org.x) + "," + Integer.toString(org.y);
			
			
		}
		
		repaint();

	}

	public void mouseReleased(MouseEvent e) 
	{
		e.consume();
		
		if(option.equals("line"))
		{						
			lin+=Integer.toString(fColor.getRGB())+","+sp.x+","+sp.y+","+ep.x+","+ep.y+"#";
			
		}
		
		if(option.equals("circle"))
		{
			cir+=Integer.toString(fColor.getRGB())+","+Ssp.x+","+Ssp.y+","+WH.x+","+WH.y+"#";
		}

		if(option.equals("rectangle"))
		{
		
			rectan+=Integer.toString(fColor.getRGB())+","+Ssp.x+","+Ssp.y+","+WH.x+","+WH.y+"#";
				
		}
		
		if(option.equals("freehand"))
		{
			fhand+="#";
		}
		
		showStatus(cir);

		repaint();
    }


public void actionPerformed(ActionEvent ae){
		
		String btn=ae.getActionCommand();
				
		if (btn.equalsIgnoreCase("save")) {
				
					tag=true;
					option="save";
					got = callser();	//calling theconnection
					//JOptionPane.showMessageDialog(null,points);
					//System.out.print("Got :"+got);
					JOptionPane.showMessageDialog(null,got);
					showStatus(got);
					
		      		lin=" ";
					cir=" ";
					rectan=" ";
					fhand=" ";
					txt=" ";
			
					repaint();
					
		}
		
		if (btn.equalsIgnoreCase("Free Hand")) {
			
					option = "freehand";
		}
		if (btn.equalsIgnoreCase("Circle")) {
			
					option = "circle";
		}
		if (btn.equalsIgnoreCase("Line")) {
			
					option = "line";
		}
		if (btn.equalsIgnoreCase("Rectangle")) {
			
					option = "rectangle";
		}
		if (btn.equalsIgnoreCase("Free Hand")) {
			
					option = "freehand";
		}
		
		if (btn.equalsIgnoreCase("Color")) {	
					
			Color c = JColorChooser.showDialog(null,"Select Shape Color",fColor);
            if (c == null)	JOptionPane.showMessageDialog(null, "You canceled without selecting a color.");
            else fColor = c;
            
		}
		
		if (btn.equalsIgnoreCase("Text")) {	
				option = "text";
				SText=JOptionPane.showInputDialog(null,"After Input, You Click On Canvas","Type Your Text Here");	
		}
		
		showStatus(option);
	}
	


    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mouseClicked(MouseEvent e) 
		{
    }

	public void mouseMoved(MouseEvent e) {
    }

	private String callser()
	{
		String chr="Save...";
		try {
			
		//int lcn = getCodeBase().toString().indexOf("jspfiles");
		//String location = getCodeBase().toString().substring(0,lcn) + "servlet/imgmarkservlet";
	
		String location = url+ "/servlet/imgmarkservlet";
		
	//	JOptionPane.showMessageDialog(null,"location:" + location);


		String par=prms+"&ccode="+ccode+"&uid="+uid+"&line="+lin+"&circle="+cir+"&rect="+rectan+"&fhand="+fhand+"&txt="+txt;
		//JOptionPane.showMessageDialog(null,"Par :" + par);
	//	System.out.println(par);
		
			URL servletURL = new URL(location);
     		HttpURLConnection servletConnection = (HttpURLConnection)servletURL.openConnection();
      		
      		String cookstr=srcookiehandle.getCookie(this);                 
        	servletConnection.setRequestProperty("cookie",cookstr);
        
     		
     		servletConnection.setDoOutput(true);  // to allow us to write to the URL
      		servletConnection.setUseCaches(false);  // to ensure that we do contact
                                              // the servlet and don't get
                                              // anything from the browser's
                                             // cache
		// Write the message to the servlet
      		PrintStream out = new PrintStream(servletConnection.getOutputStream());
      		out.println(par);
			out.close();
			
		// Now read in the response
      		InputStream in = servletConnection.getInputStream();
      		BufferedReader response = new BufferedReader(new InputStreamReader(in));
      		
      		chr=response.readLine();     		 		
      		
      		in.close();
      		    	 	
		} catch (IOException e) {
     		chr="Error.."+	e.toString();
  		}
  		
       return chr;

   }


}

