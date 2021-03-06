import java.awt.*;
import java.awt.BasicStroke;
import java.awt.Stroke;
import java.awt.event.*;
import java.io.*;
import java.net.*;
import java.lang.*;
import java.util.*;
import java.util.Date;
import javax.swing.JApplet;
import javax.swing.*;
import javax.swing.JOptionPane;
import javax.swing.border.*;
import javax.swing.event.*;
import java.awt.image.*;
import javax.imageio.*;


/*
 *<APPLET CODE=ecgviewer.class WIDTH=740 HEIGHT=400>
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
	JPanel jp1=new JPanel();
	
	jp[] jPanel = new jp[12];
	JScrollPane[] jsPanel=new JScrollPane[12];
	//String [] cmbval={"5","1","2","4","8"};
	String [] cmbval={"5","1","8"};
    JComboBox cmbfactor=new JComboBox(cmbval);

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
     		jPanel[i]=createPane(titles[i], i,ecgdata);
		}
		  
   	 	for (int i=0;i<titles.length;i++) {
     	 	jsPanel[i]=new JScrollPane(jPanel[i]);
			jsPanel[i].setPreferredSize(new Dimension(705,180));
			tabbedPane.addTab(titles[i], jsPanel[i]);
			
         	}	
         	
      	jpoption.setPreferredSize(new Dimension(705,40));	      
      	cmbfactor.setPreferredSize(new Dimension(40,20));    	      	
      	      	
      	jp1.add(new Label("Select Scale Factor :"),BorderLayout.WEST);
      	jp1.add(cmbfactor,BorderLayout.CENTER);
      	jpoption.add(jp1,BorderLayout.WEST);
  		srListener listener =new srListener(this);  
    	tabbedPane.addChangeListener(listener); 
    	cmbfactor.addItemListener(listener);	
		jpall.add(tabbedPane,BorderLayout.NORTH);	
		jpall.add(jpoption,BorderLayout.SOUTH);		
	
	}
	
	jp createPane(String title, int ti,srecgreaddata edata) {
	    return (new jp(title, ti,edata));
    }
	
	JScrollPane createJpane() {
	    return (new JScrollPane());
    }
    
	}
	
class srListener implements ChangeListener,ItemListener{
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
			System.out.println(sFactor);
			switch(Integer.parseInt(sFactor)){
					case 1: mp.jPanel[mp.SelectedTab].setwd(5000,1);
							break;
					case 2:	mp.jPanel[mp.SelectedTab].setwd(5000/2,2);
							break;
					case 4: mp.jPanel[mp.SelectedTab].setwd(5000/4,4);
							break;
					case 5: mp.jPanel[mp.SelectedTab].setwd(5000/5,5);
							break;
					case 8: mp.jPanel[mp.SelectedTab].setwd(5000/8,8);
							break;
			}				
					
	//	mp.jPanel[jtp.getSelectedIndex()].setwd(700);

  	}
  	
  	public void itemStateChanged(ItemEvent e){
  				
		if(e.getSource()==mp.cmbfactor){
			if (e.getStateChange() ==ItemEvent.SELECTED){
				String sFactor=mp.cmbfactor.getSelectedItem().toString();
				System.out.println("sFactor :"+sFactor);
				
				switch(Integer.parseInt(sFactor)){
					case 1: mp.jPanel[mp.SelectedTab].setwd(5000,1);
							break;
					case 2:	mp.jPanel[mp.SelectedTab].setwd(5000/2,2);
							break;
					case 4: mp.jPanel[mp.SelectedTab].setwd(5000/4,4);
							break;
					case 5: mp.jPanel[mp.SelectedTab].setwd(5000/5,5);
							break;
					case 8: mp.jPanel[mp.SelectedTab].setwd(5000/8,8);
							break;
				}				
			}
		} 		
	}
	

}	
		
class jp extends JPanel{
	
	int	xa, ya, wd, ht, x0, y0,max,h;
	Color dc;
	String point;
	srecgreaddata ecgalldata;
	int tab=0;
		
	jp( String str,int tb,srecgreaddata edata) {
		this.setName(str);
		ecgalldata=edata;
		tab=tb;
		xa=0;
		ya=0;
		wd=1000;
		ht=160;
		x0=xa;
		y0=ya+ht/2;
		point=ecgalldata.LeadValue4[tab];	
		setPreferredSize(new Dimension(wd,ht));
	
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

		//	10 mm = 1mv
		// 	1 MM = 4 PIXCEL
	
		g.setColor(Color.white);
		g.fillRect(xa,ya,wd,ht);
		g.setColor(Color.LIGHT_GRAY);
		
		for (int i=0; i<=ht; i+=4) {
			
			g.drawLine(xa, i, wd+xa, i);	
			if(i%20==0){
				g.setColor(Color.GRAY);
				g.drawLine(xa, i, wd+xa, i);	
				g.setColor(Color.LIGHT_GRAY);
			}
		}
		
		for (int i=0; i<=wd; i+=4) {
			g.drawLine(i,ya, i,ht+ya);	
			if(i%20==0){
				g.setColor(Color.GRAY);
				g.drawLine(i,ya, i,ht+ya);	
				g.setColor(Color.LIGHT_GRAY);
			}
		}
		
		g.setColor(Color.RED);
		g.drawLine(x0,y0,wd,y0);	
	}
	
	
	public void setwd(int nwd,int f){

		switch(f){
			case 1: point=ecgalldata.LeadValue1[tab];
					break;
			case 2:	point=ecgalldata.LeadValue2[tab];
					break;
			case 4: point=ecgalldata.LeadValue3[tab];
					break;
			case 5: point=ecgalldata.LeadValue4[tab];
					break;
			case 8: point=ecgalldata.LeadValue5[tab];
					break;
		}				
						
		Graphics g=this.getGraphics();
		g.clearRect(xa,ya,wd,ht);
		wd=nwd;
		//y0=ya+ht/2;	
		this.setPreferredSize(new Dimension(wd,ht));
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
	
	
}
	
	
class srecgreaddata{
	
	String orgLeadName = "LEAD   I#LEAD   II#LEAD   III#LEAD   avR#LEAD   avL#LEAD   avF#LEAD   V1#LEAD   V2#LEAD   V3#LEAD   V4#LEAD   V5#LEAD   V6";
	
	String[] LeadValue1 = new String[12];
	String[] LeadValue2 = new String[12];
	String[] LeadValue3 = new String[12];
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
			//	LeadValue2[i]=ScaleData(LeadValue1[i],2);
			//	LeadValue3[i]=ScaleData(LeadValue1[i],4);
				LeadValue4[i]=ScaleData(LeadValue1[i],5);
				LeadValue5[i]=ScaleData(LeadValue1[i],8);
				LeadValue1[i]=ScaleData(LeadValue1[i],1);
			}
			
		}
		
		public String ScaleData(String leadvalue ,int scale){
			String ScaleLD="";
			
			String [] allvalue=	leadvalue.split(",");
			try{
			
			int i=0,fc=0,avgval=0;
			double y2;
			
			System.out.println("Scalling\n");
			
			while(i<allvalue.length){
				avgval=avgval+Integer.parseInt(allvalue[i].trim());
				fc++;
				
				if(fc==scale){
					y2=avgval/scale;				// AVERAGE
					y2=y2*1.0172526;			//microvolt
					y2=y2/1000;					//millivolt
					y2=y2*40;					// 20 pixcel = .5 mv ie 1BS
					
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
	
	
	