//program for skinpatch marking applet


import java.awt.event.*;
import java.awt.*;
import java.applet.*;
import java.io.*;
import java.util.*;
import java.net.*;
import java.lang.*;
import javax.swing.JOptionPane;
import javax.imageio.*;
import java.awt.image.*;
import javax.swing.ImageIcon;
import javax.swing.*;

/*
<APPLET CODE="offlineskinpatch.class"  WIDTH=420 HEIGHT=510>
	<Param name="skptyp" value="lun">
	<Param name="usr" value="skp">
	<Param name="patid" value="NRSH1912070008">
	<Param name="edate" value="2008/01/09">
	
</APPLET>
*/

public class offlineskinpatch extends Applet implements MouseListener, MouseMotionListener ,ActionListener
{	
	String us="",pid="",skptyp="",frmtyp="",imgpath="",tdt="";
	String fhand="",option="SRay",got="Processing";
	//URL url;
	Point org = new Point(0,0);
	String points="";
	String home="";
	String location = "";
	String imagePath="";
	boolean tag=false;
	JButton  free,save;
	int imgw, imgh;
	ImageIcon imgicon;	
	Image img;
	BufferedImage buffImg;
	JPanel jpbut = new JPanel();
	JPanel jpdesc = new JPanel();
	JPanel jfooter = new JPanel();
	JTextField desc= new JTextField();
	JLabel lbdesc = new JLabel("Description: ");
	
	public void init()
	{
		setLayout(new BorderLayout());
		addMouseMotionListener(this);
	    addMouseListener(this);
		//home = getParameter("home"); getCodeBase
		home = this.getDocumentBase().toString();
		int lcn=0;
		System.out.println(home);
		
		us=getParameter("usr");
		pid=getParameter("patid");
		skptyp=getParameter("skptyp");
		frmtyp=getParameter("frmtyp");	
		
		if(home.indexOf(".jsp")>0) {
			home = home.substring(0,home.indexOf("jspfiles"));
			imagePath = home+"/jspfiles/anatomyimages/"+skptyp+".jpg";
			location = home + "/servlet/savepatch";
		}else{
			 home = home.substring(0,home.indexOf("ImageMarking"));
			 imagePath=home+"/ImageMarking/AnatomyImages/"+skptyp+".jpg";
			 location = home + "/ImageMarking/SaveSkp.aspx";
		}

		System.out.println(home + "\n" + imagePath);
		

		tdt=getParameter("tdate");	
					
		setForeground(Color.black);
		jfooter.setLayout(new BorderLayout());
		jfooter.setBackground(Color.white);
		
		jpbut.setLayout(new FlowLayout(FlowLayout.CENTER));
		jpbut.setBackground(Color.white);
		
		jpdesc.setLayout(new FlowLayout(FlowLayout.CENTER));
		jpdesc.setBackground(Color.white);
		jpdesc.add(lbdesc);
		jpdesc.add(desc);
		
		jfooter.add(jpdesc,BorderLayout.NORTH);
		
		free = new JButton("Free Hand");
		jpbut.add(free);
		save = new JButton("Save");
		jpbut.add(save);
		
		jfooter.add(jpbut,BorderLayout.SOUTH);
		try {
						
			imgicon=new ImageIcon(new URL(imagePath));		
			imgw=imgicon.getIconWidth();
			imgh=imgicon.getIconHeight();
 		
 		}catch (Exception e) {
 			e.printStackTrace();
 			JOptionPane.showMessageDialog(null, e.toString());
 		}
 	
 		Dimension dim = desc.getPreferredSize();
 		if(dim.width<(imgw-lbdesc.getWidth()-100)) dim.width=imgw-lbdesc.getWidth()-100;
 		
 		//desc.setPreferredSize(new Dimension(imgw-lbdesc.getWidth()-100,0));
 		desc.setPreferredSize(dim);
 		

 		add(jfooter, BorderLayout.SOUTH);
		setForeground(Color.BLUE);
		save.addActionListener(this);
		free.addActionListener(this);
		
 		
		buffImg  = new BufferedImage(imgw, imgh, BufferedImage.TYPE_INT_RGB);
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
	}
	
	/*
	public BufferedImage  getImgIcon(String hm,String fn) {
		  String imagePath=hm+"/jspfiles/anatomyimages/"+fn+".jpg";
		  try {
		  	ImageIcon imgicon =new ImageIcon(new URL(imagePath));
	        
	        Image img = imgicon.getImage();
	        
		  	buffImage = new BufferedImage(img);
		  	
		  }
		  catch (Exception e) {
		  	JOptionPane.showMessageDialog(null, e.toString() + ">>>" +imagePath );
		  	System.out.println(imagePath+"\n" +e.toString());
		  	buffImage=null;
		  }
		  return buffImage;
	}
	
	*/
	
	public void mousePressed(MouseEvent e)
	{     
		e.consume();
		if(option.equalsIgnoreCase("freehand")){
		Graphics g =  buffImg.createGraphics();
    	g.setColor(Color.BLUE);
    	Graphics2D g2D = (Graphics2D) g;  
    	Stroke stroke = new BasicStroke((float)1.5);
      	g2D.setStroke(stroke);
		org.x=e.getX();
		org.y=e.getY();
		repaint();
		}
	}


    public void mouseDragged(MouseEvent e)
	{
		e.consume();
		if(option.equalsIgnoreCase("freehand")){
				
			Graphics g =  buffImg.createGraphics();
	        Graphics2D g2D = (Graphics2D) g;
	        Stroke stroke = new BasicStroke((float)1.5);
	      	g2D.setStroke(stroke);
	        g.setColor(Color.BLUE);
	       	g.drawLine(org.x,org.y,e.getX(),e.getY());
	       	points=points + Integer.toString(org.x) + "," + Integer.toString(org.y)+ ","+Integer.toString(e.getX()) + "," + Integer.toString(e.getY())+ "-";
	       	org.x=e.getX();
			org.y=e.getY();
			
		}
		repaint();
	}

	public void mouseReleased(MouseEvent e) 
	{
		e.consume();
		//	showStatus(cir);
		//repaint();
    }

	public void actionPerformed(ActionEvent ae)
	{
		
		String btn=ae.getActionCommand();
				
		if (btn.equalsIgnoreCase("save")) {
				
					tag=true;
					option="save";
					got = callser();	//calling theconnection
					JOptionPane.showMessageDialog(null,"Points Saved");
					//JOptionPane.showMessageDialog(null,points);
					showStatus(got);
					points="";
					repaint();
					
					
		}
		if (btn.equalsIgnoreCase("Free Hand")) {
			
					option = "freehand";
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
	try {
			
		System.out.println(location);
		String descval=desc.getText();
		if(descval==null) descval="";
		
		String par=points+"&"+pid+"&"+skptyp +"&"+ tdt+"&"+frmtyp+"&"+descval; 
		URL servletURL = new URL(location);
      	HttpURLConnection servletConnection = (HttpURLConnection)servletURL.openConnection();
      		
      	String cookstr=srcookiehandle.getCookie(this);            
      	
      	System.out.println("cookstr >>:"+cookstr);     
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
      
	    StringBuffer response = new StringBuffer();
	    int chr;
	   	while ((chr=in.read())!=-1) {
        response.append((char) chr);
      	} 
      
      	in.close();
      
     	String msg= response.toString();
     	System.out.println(msg);
     	
		//responseField.setText("servlet response is"+msg);

		return "Points Saved..";
		
	}catch (IOException e) {
	     return  e.toString();
    }

}
	

}

