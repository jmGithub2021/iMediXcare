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
 *  <param name="patid" value="ttm08022007001">
 *  <param name="ecgdata" value="..NoData">
 *</APPLET>
*/

public class ecgviewer extends JApplet { 
    mainpanel mpanel;
    srecgreaddata edata;
    
    public void  init(){
    
    //System.out.println("Start");
	edata =new srecgreaddata(getParameter("ecgdata"));
	
	mpanel = new mainpanel(edata,getParameter("patid"));
	mpanel.init();	
	mpanel.cmbfactor.enable(false);
	
	srscaledate sd = new srscaledate(mpanel);
	
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
	
	String patid;
	//String[] titles={"LEAD I", "LEAD II", "LEAD III","LEAD avR","LEAD avL","LEAD avF","LEAD V1","LEAD V2","LEAD V3","LEAD V4","LEAD V5","LEAD V6"};
		String[] titles={" I ", " II ", " III "," avR "," avL "," avF "," V1 "," V2 "," V3 "," V4 "," V5 "," V6 "};	
	JTabbedPane tabbedPane; 
			
	JPanel jpall=new JPanel();
	JPanel jpoption=new JPanel(new BorderLayout());
	JPanel jp1 = new JPanel(new GridBagLayout());
	 
	JPanel jp2=new JPanel(new BorderLayout());
	JPanel jp3=new JPanel(new BorderLayout());
	JPanel jp4=new JPanel(new BorderLayout());
	JPanel jp5=new JPanel(new BorderLayout());
	
	GridBagConstraints c = new GridBagConstraints();
	
	jp[] jPanel = new jp[12];
	
	jpamptime jlamp ;
	jpamptime jltime ;
	
	JScrollPane[] jsPanel=new JScrollPane[12];
	
	//String [] cmbval={"5","1","2","4","8"};
	String [] cmbval={"4","2","1"};
	
	DefaultComboBoxModel model = new DefaultComboBoxModel(cmbval);	
	//DefaultComboBoxModel model = new DefaultComboBoxModel();	
    JComboBox cmbfactor=new JComboBox(model);
    
	JButton jbamp=new JButton("Amplitude");
	JButton jbtime=new JButton("Time");
	
	JLabel jlbamp=new JLabel();
	JLabel jlbtime=new JLabel();
	
	mainpanel(srecgreaddata ed, String pid) { 
		ecgdata=ed;
		patid=pid;	
	}
	
	public void init(){
		
//		ecgdata.readData(urlp);
		ecgdata.GetLeadData();
		
		jlamp= new jpamptime(); 
      	jltime= new jpamptime();
      			
		tabbedPane = new JTabbedPane();
		tabbedPane.setTabLayoutPolicy(1);
				    	
    	for (int i=0; i<titles.length; i++) {
     		jPanel[i]=createPane(titles[i], i,ecgdata.LeadValue4[i],ecgdata,jlamp,jltime);
		}
		  
   	 	for (int i=0;i<titles.length;i++) {
     	 	jsPanel[i]=new JScrollPane(jPanel[i]);
			jsPanel[i].setPreferredSize(new Dimension(705,400));
			tabbedPane.addTab(titles[i], jsPanel[i]);
         	}	
        
        jp5.add(new Label("Scale Factor:      "),BorderLayout.WEST);
      	jp5.add(cmbfactor,BorderLayout.CENTER);
      	  	
      	//jp1.add(new Label("Unit   : 1 SS (Small Squre) = 1 mm"),BorderLayout.NORTH);
      	//jp1.add(new Label("Y Axes : 1 SS = 01 milliVolt, 2 BS = 1 milliVolt"),BorderLayout.NORTH);
      	//jp1.add(new Label("X Axes : 1 SS = 0.04 Second"),BorderLayout.CENTER);
      	//jp1.add(jp5,BorderLayout.SOUTH);
      	
      	c.fill = GridBagConstraints.HORIZONTAL;
      	
      	c.weighty = 0;
      	c.gridx = 0;
		c.gridy = 0;		
		jp1.add(jp5, c);
		c.weighty = 1;
		c.gridx = 0;
		c.gridy = 1;		
		jp1.add(new Label("X Axes : 1 SS = 0.04 Second"), c);
		c.gridx = 0;
		c.gridy = 2;
		jp1.add(new Label("Y Axes : 1 SS = 0.1 milliVolt, 2 BS = 1 milliVolt"), c);
				
      	jpoption.setPreferredSize(new Dimension(705,60));		      
      	cmbfactor.setPreferredSize(new Dimension(40,20));    	      	      	
      	
      	//jlbamp.setPreferredSize(new Dimension(200,20));
      	//jlbtime.setPreferredSize(new Dimension(200,20));
      	
      	jbamp.setPreferredSize(new Dimension(200,20));
      	jbtime.setPreferredSize(new Dimension(200,20));
      	     	       	      	
      	jp3.add(jbamp,BorderLayout.NORTH);
      	//jp3.add(jlbamp,BorderLayout.EAST);
      	jp3.add(jlamp,BorderLayout.CENTER);
      	
      	jp4.add(jbtime,BorderLayout.NORTH);
      	//jp4.add(jlbtime,BorderLayout.EAST);
      	jp4.add(jltime,BorderLayout.CENTER);
 		
      	jp2.add(jp3,BorderLayout.WEST);
		jp2.add(new Label(" "),BorderLayout.CENTER);
      	jp2.add(jp4,BorderLayout.EAST);
      	
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
	
	jp createPane(String title, int ti,String pt,srecgreaddata ecgd,jpamptime jla,jpamptime jlt) {
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
		//System.out.println(str);
		String sFactor=mp.cmbfactor.getSelectedItem().toString();
		//System.out.println("sFactor :"+sFactor);
		mp.jlamp.clearText();
		mp.jltime.clearText();
				
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
			if(mp.jPanel[mp.SelectedTab].amp==false){
			mp.jPanel[mp.SelectedTab].setCursor(mCursor);
			mp.jPanel[mp.SelectedTab].amp=true;
			mp.jPanel[mp.SelectedTab].time=false;
			mp.jPanel[mp.SelectedTab].setmarkColorA();
			}
		}
		
  		if (btn.equalsIgnoreCase("Time")){
  			if(mp.jPanel[mp.SelectedTab].time==false){
  			mp.jPanel[mp.SelectedTab].setCursor(mCursor);
			mp.jPanel[mp.SelectedTab].amp=false;
			mp.jPanel[mp.SelectedTab].time=true;
			mp.jPanel[mp.SelectedTab].setmarkColorT();
			}
		}
  	}
  	
  		public void itemStateChanged(ItemEvent e){	
		if(e.getSource()==mp.cmbfactor){
			if (e.getStateChange() ==ItemEvent.SELECTED){
				String sFactor=mp.cmbfactor.getSelectedItem().toString();
				//System.out.println("sFactor :"+sFactor);
							
				mp.jlamp.clearText();
				mp.jltime.clearText();
				
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
  
  
class jpamptime extends JPanel{
	private int	wd=200, ht=60;
	String [] value=new String[3];
	Color c = new Color(89, 157, 87); 
	Color [] clr={Color.RED,c,Color.MAGENTA};
	
	jpamptime(){
		for(int i=0;i<3;i++){
			value[i]="";
		}
		
		setPreferredSize(new Dimension(wd,ht));
	}
	
	public void paintComponent(Graphics g) {
	    super.paintComponent(g);
	    g.setColor(Color.WHITE);
	    g.fillRect(0,0,wd,ht);	    
	    DrawLagent(g);
     }
     
     public void DrawLagent(Graphics g){
     	int y=2;
     	int sx=40;
		for (int i=0; i<3; i++) {
			if(value[i]!=""){
				g.setColor(clr[i]);
				g.fillRect(sx,y,10,10);
				g.drawString(value[i],sx+20,y+10);
				y=y+12;
			}
						
		}
	}
	
	public void clearText(){
		for(int i=0;i<3;i++){
			value[i]="";
		}
		repaint();
	}
	
	public void setText(String txt){
		int tag=0;
		
		for(int i=0;i<3;i++){
			if(value[i]==""){	
				value[i]=txt;
				tag=1;
				break;
			}
		}
		
		if(tag==0){
			clearText();
			value[0]=txt;
		}	
		repaint();
	}
}


class jp extends JPanel implements MouseListener,MouseMotionListener{
	
	int	xa, ya, wd, ht, x0, y0,max,h;
	int srate=100;	
		
	Point sp  = new Point(0,0);
	Point ep  = new Point(0,0);
	Point org = new Point(0,0);
	Point end = new Point(0,0);
	
	Color c = new Color(89, 157, 87); 
	
	//Color mcolor=Color.RED;
	Color [] clr={Color.RED,c,Color.MAGENTA};
	int ampc=-1,timec=-1;
	
	String point;
	srecgreaddata ecgalldata;
	int ss=0, bs=0;
	int tab=0;
	boolean amp=false;
	boolean time=false;
	jpamptime jamp;
	jpamptime jtime;
	
	jp(String str,int tb, String pt,srecgreaddata ecgd,jpamptime ja,jpamptime jt){
		
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
	
	public void DrawPoint(){
		DrawPoint(this.getGraphics());
		}
		
	public void DrawGraph(Graphics g){
		
		//
		
    	Graphics2D g2D = (Graphics2D) g;
        Stroke stroke = new BasicStroke((float)1.0);
      	g2D.setStroke(stroke);
      																	
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
		//System.out.println("Tab :"+tab);
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
		ampc=-1;
		timec=-1;
		jamp.clearText();
		jtime.clearText();
		repaint();		
		//DrawGraph();
		//DrawPoint();
		
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
		//System.out.println("Pressed "+sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());			
    }
    public void mouseReleased(MouseEvent e)
    {
    		Cursor mCursor = new Cursor(Cursor.DEFAULT_CURSOR);
			setCursor(mCursor);
			
    	if(time==true){
    		int t=ep.x-sp.x;
    		Double tm=(double)t/srate;
    		jtime.setText(Double.toString(tm)+" Second");    		
    		time=false;
    	}
    	if(amp==true){
    		int t=ep.y-sp.y;
    		Double tm=(double) t/(10*ss);
    		jamp.setText(Double.toString(tm)+" milliVolt");    			
    		amp=false;
    	}      	
    	
    }
    
    public void mouseEntered(MouseEvent e){}
    public void mouseExited(MouseEvent e) {}
    public void mouseDragged(MouseEvent e)
    {
    	Graphics g = this.getGraphics();
    	Graphics2D g2D = (Graphics2D) g;
        Stroke stroke = new BasicStroke((float)2.0);
      	g2D.setStroke(stroke);
      	        
    	if(time==true){
    	g.setXORMode(getBackground());
      	g.setColor(clr[timec]);    	   
		g.drawLine(sp.x,sp.y,ep.x,sp.y); 		
    	g.drawLine(sp.x,sp.y,e.getX(),sp.y);
    	ep.x=e.getX();
		//ep.y=e.getY();
		//System.out.println(sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());
		}
			
		if(amp==true){
    		g.setXORMode(getBackground());
      		g.setColor(clr[ampc]);    	   
			g.drawLine(sp.x,sp.y,sp.x,ep.y); 		
    		g.drawLine(sp.x,sp.y,sp.x,e.getY());
    	//ep.x=e.getX();
		ep.y=e.getY();
		//System.out.println(sp.x+":"+sp.y+":"+e.getX()+":"+e.getY());
		}	
    }
    public void mouseMoved(MouseEvent e)
    {	
    
    }
    
    public void setmarkColorA()
    {	
    	if(ampc>=2){
    		ampc=-1;
    		timec=-1;
    		repaint();
    		jamp.clearText();
    		jtime.clearText();
    	}
    	ampc++;
    }

    public void setmarkColorT()
    {	
    if(timec>=2){
    		timec=-1;
    		ampc=-1;
    		repaint();
    		jtime.clearText();
    		jamp.clearText();
    	}
    	timec++;	
    }
}
	
	
class srecgreaddata{
	
	String orgLeadName = "LEAD   I#LEAD   II#LEAD   III#LEAD   avR#LEAD   avL#LEAD   avF#LEAD   V1#LEAD   V2#LEAD   V3#LEAD   V4#LEAD   V5#LEAD   V6";
	
	String[] LeadValue1 = new String[12];
	String[] LeadValue2 = new String[12];
	String[] LeadValue4 = new String[12];
	String[] LeadValue5 = new String[12];
	String strdata="";
	
	srecgreaddata(String str){
		strdata=str;		
	}
	
	/*
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
           		strdata=strdata+"..NoData";
        	}
        	              	    
	    }catch ( Exception e) {
	    	JOptionPane.showMessageDialog(null, "Bad URL :" + urlpath + "\n" + e);
	    	System.out.println("could not read "+e.getMessage()+":"+urlpath);
	    	strdata="..NoData";
	    }    
	   
	}
	*/
		
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
			
			//System.out.println("LeadTags : " + LeadTags.length );
			
			String lead = LeadTags[i];				
			int pos = strdata.indexOf(lead,0);
			index = pos+ lead.length();	
			
			//System.out.println(index+"|"+pos+"|"+i);
			
			i=1;
				
			while(i<LeadTags.length)
			{
				lead = LeadTags[i];				
				pos = strdata.indexOf(lead,index);	
				LeadValue1[arrIndex]=strdata.substring(index,pos);
				arrIndex++;
				
				//System.out.println(index+"|"+pos+"|"+i);
				
				index = pos+ lead.length();	
				
				if(i==11)LeadValue1[arrIndex]=strdata.substring(index);
				i++;
			}
			
			for(i=0;i<12;i++){
				LeadValue1[i]=LeadValue1[i].replace("\n","");
				LeadValue1[i]=LeadValue1[i].replace("\r","");
				LeadValue1[i]=LeadValue1[i].replace(" ","");						
						
				//System.out.println(LeadTags[i]+"|"+LeadValue1[i]+"|");			
				//LeadValue2[i]=ScaleData(LeadValue1[i],2);		
				
				LeadValue4[i]=ScaleData(LeadValue1[i],4);
				
			//	LeadValue5[i]=ScaleData(LeadValue1[i],5);	
			//	LeadValue1[i]=ScaleData(LeadValue1[i],1);
			
			}
			
		}
		
		public String ScaleData(String leadvalue ,int scale){
			String ScaleLD="";
			
			String [] allvalue=	leadvalue.split(",");
			try{
			
			int i=0,fc=0,avgval=0;
			double y2;
			int yscale=1;
			//System.out.println("Scalling\n");
			//yscale=5/scale;
			
			while(i<allvalue.length){
				avgval=avgval+Integer.parseInt(allvalue[i].trim());
				fc++;
				
				if(fc==scale){
					y2=avgval/scale;			// 	AVERAGE
					y2=y2*1.0172526;			//	microvolt ' 
					y2=y2/1000;					//	millivolt 

					y2=y2*200/scale;			// 	NORMAL 500 MHz 1 sec 500; or 25 mm 1 sec , 1mm = 500/25 = 20 pixcel
												// 	( 10 mm 1 miliV , 1 mm = 20 pixel ie , 1 miliV=20*10)
												
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


class srscaledate extends Thread{
	//srecgreaddata ECGdata;
	mainpanel mpnl;
	
	srscaledate(mainpanel mp){
		mpnl=mp;
		start();
	}
	
	public void run () {
		int i;
		
		try{
			for(i=0;i<12;i++){
				mpnl.ecgdata.LeadValue2[i]=mpnl.ecgdata.ScaleData(mpnl.ecgdata.LeadValue1[i],2);		
				mpnl.ecgdata.LeadValue1[i]=mpnl.ecgdata.ScaleData(mpnl.ecgdata.LeadValue1[i],1);
				System.out.println(i);
			}
		
			
	     }	 
		 catch (Exception e) {
		 	System.out.println(e.toString());
		 }
		
		mpnl.cmbfactor.enable(true); 
		JOptionPane.showMessageDialog(null,"All Process Done.. Now you can change the Scaling Factor");
		stop();
		
	}
}
	
	
	