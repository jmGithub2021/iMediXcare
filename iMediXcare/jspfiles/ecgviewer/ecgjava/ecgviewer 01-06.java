import java.awt.*;
import java.awt.BasicStroke;
import java.awt.Stroke;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import java.lang.*;
import java.util.*;
import javax.swing.JApplet;
import javax.swing.*;
import javax.swing.JOptionPane;
import javax.swing.border.*;
import javax.swing.event.*;

/*
 *<APPLET CODE=ecgviewer.class WIDTH=740 HEIGHT=500>
 *  <param name="telemedhome" value="http://10.5.19.70:6080/saikat/LinuxTM">
 *  <param name="patid" value="ttm08022007001">
 *	<param name="urlpath" value="http://10.5.19.70:6080/saikat/LinuxTM/data//ttm//ttm08022007001//images//ttm0802200700124052007ecg00.txt">
 *	<param name="abspath" value="/usr/local/tomcat-5.5/webapps/saikat/LinuxTM//data//ttm//ttm08022007001//images//ttm0802200700124052007ecg00.txt">
 *</APPLET>
*/

public class ecgviewer extends JApplet { 

    mainpanel mpanel;
    srecgreaddata edata;
    
    public void  init(){
    
    System.out.println("Start");
    String urlp=getParameter("urlpath");
	edata =new srecgreaddata(urlp);
	System.out.println(urlp);
	
	mpanel = new mainpanel(edata,urlp,getParameter("patid"));
	
	mpanel.init();	
	
    this.getContentPane().setLayout(new BorderLayout()); 
    this.getContentPane().add(mpanel.jpall);
    String tmpmsg="";	
	
    }	
    
    public void start() {}
    public void stop() {}
    public void paint(Graphics g) {
    super.paint(g);
    
	}
	
    }
    
  
class mainpanel {
	srecgreaddata ecgdata;
	
	int SelectedTab=0;
	
	String urlp,patid;
	String[] titles={"LEAD I", "LEAD II", "LEAD III","LEAD avR","LEAD avL","LEAD avF","LEAD V1","LEAD V2","LEAD V3","LEAD V4","LEAD V5","LEAD V6"};
		
	JTabbedPane tabbedPane; 
			
	JPanel jpall=new JPanel();
	JPanel jpoption=new JPanel(new BorderLayout());
	JPanel jp1=new JPanel(new BorderLayout());
	JPanel jp2=new JPanel(new BorderLayout());
	JPanel jp3=new JPanel(new BorderLayout());
	JPanel jp4=new JPanel(new BorderLayout());
	JPanel jp5=new JPanel(new BorderLayout());
	
	jp[] jPanel = new jp[12];
	JScrollPane[] jsPanel=new JScrollPane[12];
	//String [] cmbval={"5","1","2","4","8"};
	String [] cmbval={"4","2","1"};
	DefaultComboBoxModel model = new DefaultComboBoxModel(cmbval);	
    JComboBox cmbfactor=new JComboBox(model);
	JButton jbamp=new JButton("Amplitude");
	JButton jbtime=new JButton("Time");
	JLabel jlbamp=new JLabel();
	JLabel jlbtime=new JLabel();
	mainpanel(srecgreaddata ed,String up, String pid) { 
		ecgdata=ed;
		urlp=up;
		patid=pid;	
	}
	
	public void init(){
		
		ecgdata.readData(urlp);
		ecgdata.GetLeadData();
				
		tabbedPane = new JTabbedPane();
		tabbedPane.setTabLayoutPolicy(1);
				    	
    	for (int i=0; i<titles.length; i++) {
     		jPanel[i]=createPane(titles[i], i,ecgdata.LeadValue4[i],ecgdata,jlbamp,jlbtime);
		}
		  
   	 	for (int i=0;i<titles.length;i++) {
     	 	jsPanel[i]=new JScrollPane(jPanel[i]);
			jsPanel[i].setPreferredSize(new Dimension(705,400));
			tabbedPane.addTab(titles[i], jsPanel[i]);
         	}	
         		
      	jpoption.setPreferredSize(new Dimension(705,60));		      
      	cmbfactor.setPreferredSize(new Dimension(40,20));    	      	      	
      	
      	jp5.add(new Label("Scale Factor:      "),BorderLayout.WEST);
      	jp5.add(cmbfactor,BorderLayout.CENTER);
      	      	
      	//jp1.add(new Label("Unit   : 1 SS (Small Squre) = 1 mm"),BorderLayout.NORTH);
      	
      	jp1.add(new Label("Y Axes : 1 SS = 01 milliVolt, 2 BS = 1 milliVolt"),BorderLayout.NORTH);
      	jp1.add(new Label("X Axes : 1 SS = 0.04 Second"),BorderLayout.CENTER);
      	jp1.add(jp5,BorderLayout.SOUTH);
      	
      	jlbamp.setPreferredSize(new Dimension(200,20));
      	jlbtime.setPreferredSize(new Dimension(200,20));
      	jbamp.setPreferredSize(new Dimension(100,20));
      	jbtime.setPreferredSize(new Dimension(100,20));
      	
      	
      	jp3.add(jbamp,BorderLayout.WEST);
      	jp3.add(jlbamp,BorderLayout.EAST);
      	jp4.add(jbtime,BorderLayout.WEST);
      	jp4.add(jlbtime,BorderLayout.EAST);
 		
      	jp2.add(jp3,BorderLayout.NORTH);
      	jp2.add(jp4,BorderLayout.CENTER);
      	jp2.add(new Label("  "),BorderLayout.SOUTH);
      	
      	jpoption.add(jp1,BorderLayout.WEST);
      	jpoption.add(jp2,BorderLayout.EAST);
  		srListener listener =new srListener(this);  
    	tabbedPane.addChangeListener(listener); 
    	jbamp.addActionListener(listener);
    	jbtime.addActionListener(listener);
    	cmbfactor.addItemListener(listener);	
		jpall.add(tabbedPane,BorderLayout.NORTH);	
		jpall.add(jpoption,BorderLayout.SOUTH);		
	
	}
	
	jp createPane(String title, int ti,String pt,srecgreaddata ecgd,JLabel jla,JLabel jlt) {
	    return (new jp(title, ti,pt,ecgd,jla,jlt));
    }
	
	JScrollPane createJpane() {
	    return (new JScrollPane());
    }
    
	}
	
class srListener implements ChangeListener,ItemListener,ActionListener {
	mainpanel mp;
	srListener(mainpanel mpnl){
		mp=mpnl;
	}
	
	public void stateChanged(ChangeEvent e) {
		String str="";
		JTabbedPane jtp = (JTabbedPane) e.getSource();
		mp.SelectedTab=jtp.getSelectedIndex();
		str = "Selected : " + jtp.getSelectedIndex();
		System.out.println(str);
		String sFactor=mp.cmbfactor.getSelectedItem().toString();
		System.out.println("sFactor :"+sFactor);
			switch(Integer.parseInt(sFactor)){
				case 1: mp.jPanel[mp.SelectedTab].setwd(5000,800,1,mp.jsPanel[mp.SelectedTab]);
							break;
					case 2: mp.jPanel[mp.SelectedTab].setwd(5000/2,400,2,mp.jsPanel[mp.SelectedTab]);
							break;
					case 4: mp.jPanel[mp.SelectedTab].setwd(5000/4,200,4,mp.jsPanel[mp.SelectedTab]);
							break;
					case 5: mp.jPanel[mp.SelectedTab].setwd(5000/5,160,5,mp.jsPanel[mp.SelectedTab]);
							break;
			}					
  	}
  	
  	public void actionPerformed(ActionEvent ae) {
  		String btn;		
		btn=ae.getActionCommand();		
		Cursor mCursor = new Cursor(Cursor.CROSSHAIR_CURSOR);
		if (btn.equalsIgnoreCase("Amplitude")){
			mp.jPanel[mp.SelectedTab].setCursor(mCursor);
			mp.jPanel[mp.SelectedTab].amp=true;
			mp.jPanel[mp.SelectedTab].time=false;
			
		}
			
  		if (btn.equalsIgnoreCase("Time")){
  			mp.jPanel[mp.SelectedTab].setCursor(mCursor);
			mp.jPanel[mp.SelectedTab].amp=false;
			mp.jPanel[mp.SelectedTab].time=true;
		}
  	}
  	
  		public void itemStateChanged(ItemEvent e){	
		if(e.getSource()==mp.cmbfactor){
			if (e.getStateChange() ==ItemEvent.SELECTED){
				String sFactor=mp.cmbfactor.getSelectedItem().toString();
				System.out.println("sFactor :"+sFactor);
				switch(Integer.parseInt(sFactor)){
					case 1: mp.jPanel[mp.SelectedTab].setwd(5000,800,1,mp.jsPanel[mp.SelectedTab]);
							break;
					case 2: mp.jPanel[mp.SelectedTab].setwd(5000/2,400,2,mp.jsPanel[mp.SelectedTab]);
							break;
					case 4: mp.jPanel[mp.SelectedTab].setwd(5000/4,200,4,mp.jsPanel[mp.SelectedTab]);
							break;
					case 5: mp.jPanel[mp.SelectedTab].setwd(5000/5,160,5,mp.jsPanel[mp.SelectedTab]);
							break;
				}				
			}
		} 		
	}
	
  	
  }	
		
class jp extends JPanel implements MouseListener,MouseMotionListener{
	
	int	xa, ya, wd, ht, x0, y0,max,h;
	
	int srate=100;
	
	Point sp  = new Point(0,0);
	Point ep  = new Point(0,0);
	Point org = new Point(0,0);
	Point end = new Point(0,0);
	
	Color dc;
	String point;
	srecgreaddata ecgalldata;
	int ss=0, bs=0;
	int tab=0;
	boolean amp=false;
	boolean time=false;
	JLabel jamp;
	JLabel jtime;
	
	jp(String str,int tb, String pt,srecgreaddata ecgd,JLabel ja,JLabel jt){
		
		this.setName(str);
		jamp=ja;
		jtime=jt;
		point=pt;
		tab=tb;
		ecgalldata=ecgd;
		xa=0;
		ya=0;
		wd=1250; // 125 MHz
		ht=200;
		x0=xa;
		y0=ya+ht/2;	

		//// 	NORMAL 500 MHz 1 sec 500; or 25mm 1sec , 1mm = 500/25 = 20 pixcel
		ss=5;
		bs=25;
			
		setPreferredSize(new Dimension(wd,ht));
		addMouseListener(this);
       	addMouseMotionListener(this);
       	
		}	
		
	public void paintComponent(Graphics g) {
	    super.paintComponent(g);
	    DrawGraph(g);
    	DrawPoint(g);    	
     }
     
	public void DrawGraph(){
		DrawGraph(this.getGraphics());
		}

	public void DrawGraph(Graphics g){
		
		//
						
																	
		g.setColor(Color.white);
		g.fillRect(xa,ya,wd,ht);
		g.setColor(Color.LIGHT_GRAY);
		
		for (int i=0; i<=ht; i+=ss) {
			
			g.drawLine(xa, i, wd+xa, i);	
			
			if(i%bs==0){
				g.setColor(Color.GRAY);
				g.drawLine(xa, i, wd+xa, i);	
				g.setColor(Color.LIGHT_GRAY);
				
			}
		}
		
		for (int i=0; i<=wd; i+=ss) {
			g.drawLine(i,ya, i,ht+ya);	
			if(i%bs==0){
				g.setColor(Color.GRAY);
				g.drawLine(i,ya, i,ht+ya);	
				g.setColor(Color.LIGHT_GRAY);
			}
		}
		
		g.setColor(Color.RED);
		g.drawLine(x0,y0,wd,y0);	
	}
		public void setwd(int nwd,int nht, int f,JScrollPane jspml){
		System.out.println("Tab :"+tab);
		//// 	NORMAL 500 MHz 1 sec 500; or 25mm 1sec , 1mm = 500/25 = 20 pixcel
		
		switch(f){
			case 1: point=ecgalldata.LeadValue1[tab];
					ss=20;
					bs=ss*5;
					srate=500;
					break;
					
			case 2: point=ecgalldata.LeadValue2[tab];
					ss=20/2;
					bs=ss*5;
					srate=250;
					break;
			case 4: point=ecgalldata.LeadValue4[tab];
					ss=20/4;
					bs=ss*5;
					srate=125;
					break;
			case 5: point=ecgalldata.LeadValue5[tab];
					ss=20/5;
					bs=ss*5;
					srate=100;
					break;
		}				
						
		Graphics g=this.getGraphics();
		g.clearRect(xa,ya,wd,ht);
		wd=nwd;
		ht=nht;
		y0=ya+ht/2;	
		this.setPreferredSize(new Dimension(wd,ht));
		jspml.setViewportView(this);
	//	DrawGraph();
		repaint();
		
	}

	
	
	public void DrawPoint(Graphics g){
			String [] ldval = point.split(",");
			int x1=0,x2=0;
			int y1=0,y2=0;	
			x1=x0;
			x2=x0;
			
			g.setColor(Color.BLUE);
						
			try{
				
				y1=y0-Integer.parseInt(ldval[0]);
				y2=y0-Integer.parseInt(ldval[0]);
				
			}catch(Exception e){
				y2=y1;
			}
			
			//System.out.println("x1"+x1+"|y1"+y1+"|x2"+x2+"|y2"+y2);
				
			for(int i=1;i<ldval.length;i++){
				
			try{
				y2=y0-Integer.parseInt(ldval[i]);
			}catch(Exception e){
				y2=y1;
			}
			
			try{
				g.drawLine(x1,y1,x2,y2);	
					
			//	System.out.println("x1:"+x1+"|y1:"+y1+"|x2:"+x2+"|y2:"+y2);
			}catch(Exception e){
			//	System.out.println("x1:"+x1+"|y1:"+y1+"|x2:"+x2+"|y2:"+y2+" "+e.toString());
			}
			
			x2++;
			
			x1=x2;
			y1=y2;			
			}						
				
	}
	
    public void mouseClicked(MouseEvent e)
    {
    	
    }
    public void mousePressed(MouseEvent e)
    {
    	sp.x=e.getX();
		sp.y=e.getY();
		ep.x=e.getX();
		ep.y=e.getY();
		System.out.println("Pressed "+sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());			
    }
    public void mouseReleased(MouseEvent e)
    {
    		Cursor mCursor = new Cursor(Cursor.CROSSHAIR_CURSOR);
			setCursor(mCursor);
			
    	if(time==true){
    		int t=ep.x-sp.x;
    		Double tm=(double)t/srate;
    		jtime.setText( "    "+Double.toString(tm)+"Sec");    		
    		time=false;
    	}
    	if(amp==true){
    		int t=ep.y-sp.y;
    		Double tm=(double) t/(10*ss);
    		jamp.setText( "    "+Double.toString(tm)+"milliVolt");    			
    		amp=false;
    	}
    	
    }
    
    public void mouseEntered(MouseEvent e){}
    public void mouseExited(MouseEvent e) {}
    public void mouseDragged(MouseEvent e)
    {
    	Graphics g = this.getGraphics();
    	if(time==true){
    	g.setXORMode(getBackground());
      	g.setColor(Color.RED);    	   
		g.drawLine(sp.x,sp.y,ep.x,sp.y); 		
    	g.drawLine(sp.x,sp.y,e.getX(),sp.y);
    	ep.x=e.getX();
		//ep.y=e.getY();
		System.out.println(sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());
		}
			
		if(amp==true){
    		g.setXORMode(getBackground());
      		g.setColor(Color.RED);    	   
			g.drawLine(sp.x,sp.y,sp.x,ep.y); 		
    		g.drawLine(sp.x,sp.y,sp.x,e.getY());
    	//ep.x=e.getX();
		ep.y=e.getY();
		System.out.println(sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());
		}	
    }
    public void mouseMoved(MouseEvent e)
    {	
    
    }
	
}
	
	
class srecgreaddata{
	
	String orgLeadName = "LEAD   I#LEAD   II#LEAD   III#LEAD   avR#LEAD   avL#LEAD   avF#LEAD   V1#LEAD   V2#LEAD   V3#LEAD   V4#LEAD   V5#LEAD   V6";
	
	String[] LeadValue1 = new String[12];
	String[] LeadValue2 = new String[12];
	String[] LeadValue4 = new String[12];
	String[] LeadValue5 = new String[12];
		
	String urlpath;
	String strdata="";
	
	srecgreaddata(String upath){
		urlpath=upath;		
	}
	
	public void readData(String upath) {
		urlpath=upath;		
		
		URL theURL;
	    try {
	    	theURL=new URL(urlpath);	    	
	    	URLConnection conn = null;
	    	DataInputStream data = null;    	
	    	conn = theURL.openConnection();   	
	      	conn.connect();
	        data = new DataInputStream(new BufferedInputStream(conn.getInputStream()));
	        
	        try{
        		byte [] b=new byte[102400];
        		int numread=data.read(b);	
        		while(numread!=-1){
        			String x=new String(b,0,numread);	
        			strdata=strdata+x.substring(0,x.length()-1);
        			numread=data.read(b);
        		}
        		
        	}catch(Exception e){
           		System.out.println("could not read "+e.getMessage());
           		strdata=strdata+" ..NoData";
        	}
        	              	    
	    }catch ( Exception e) {
	    	JOptionPane.showMessageDialog(null, "Bad URL :" + urlpath + "\n" + e);
	    	System.out.println("could not read "+e.getMessage()+":"+urlpath);
	    	strdata="..NoData";
	    }    
	   
	}
	
	
	public void GetLeadData()
		{					
			
			//System.out.println("String Data : " + strdata );
			//System.out.println("index No Data : " + strdata.indexOf("NoData") );
			
			if(strdata.indexOf("NoData")>=0)
			{
				LeadValue1[0]="No_Data";
				return ;
			}
			
			int i = 0,index=0,arrIndex=0;
			String [] LeadTags = orgLeadName.split("#");
			
			System.out.println("LeadTags : " + LeadTags.length );
			
			String lead = LeadTags[i];				
			int pos = strdata.indexOf(lead,0);
			index = pos+ lead.length();	
			System.out.println(index+"|"+pos+"|"+i);
			i=1;
				
			while(i<LeadTags.length)
			{
				lead = LeadTags[i];				
				pos = strdata.indexOf(lead,index);	
				LeadValue1[arrIndex]=strdata.substring(index,pos);
				arrIndex++;
				System.out.println(index+"|"+pos+"|"+i);
				index = pos+ lead.length();	
				
				if(i==11)LeadValue1[arrIndex]=strdata.substring(index);
				
				i++;
			}
			
			for(i=0;i<12;i++){
				LeadValue1[i]=LeadValue1[i].replace("\n","");
				LeadValue1[i]=LeadValue1[i].replace("\r","");
				LeadValue1[i]=LeadValue1[i].replace(" ","");						
						
				//System.out.println(LeadTags[i]+"|"+LeadValue1[i]+"|");			
				
				LeadValue2[i]=ScaleData(LeadValue1[i],2);		
				LeadValue4[i]=ScaleData(LeadValue1[i],4);
			//	LeadValue5[i]=ScaleData(LeadValue1[i],5);	
				LeadValue1[i]=ScaleData(LeadValue1[i],1);
			
			}
			
		}
		
		public String ScaleData(String leadvalue ,int scale){
			String ScaleLD="";
			
			String [] allvalue=	leadvalue.split(",");
			try{
			
			int i=0,fc=0,avgval=0;
			double y2;
			int yscale=1;
			System.out.println("Scalling\n");
			//yscale=5/scale;
			
			while(i<allvalue.length){
				avgval=avgval+Integer.parseInt(allvalue[i].trim());
				fc++;
				
				if(fc==scale){
					y2=avgval/scale;			// 	AVERAGE
					y2=y2*1.0172526;			//	microvolt ' 
					y2=y2/1000;					//	millivolt 
					y2=y2*200/scale;			// 	NORMAL 500 MHz 1 sec 500; or 25mm 1sec , 1mm = 500/25 = 20 pixcel
												// 	( new 10 mm 1 miliV , 1 mm = 20 pixel ie 20*10)
												
					//System.out.println(y2);

					int x= (int) y2;

				//	System.out.println(x);

					ScaleLD=ScaleLD+Integer.toString(x)+",";
					fc=0;
					avgval=0;	
				}
				
				i++;
				
			}
			
			}catch(Exception e){				
				System.out.println( e.toString());
			}
			return ScaleLD;	
		}		
}
	
	
	