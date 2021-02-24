package imedixservlets;

import java.awt.*;
import java.util.*;
import java.io.*;
import java.nio.*;
import java.math.BigInteger;
import javax.imageio.*;
import java.awt.image.*;
import java.nio.channels.*;
import javax.imageio.*;

public class dicomwriter {

static final byte preamble[] = new byte[128];
static final byte DICM[] = "DICM".getBytes();
static final byte emp1 [] = new byte [1];
static final byte emp [] = new byte [2];

public dicomwriter()
{

}
//String lin,String circle,String rect,String txt,
public boolean createjpg(String fpath,String sn,String fhand, String dwd, String dht, Color col)
{ 
	
	
	 
	Frame f = null;
	f = new Frame();
	f.addNotify();
	Graphics g = null;
	Image i = Toolkit.getDefaultToolkit().getImage(fpath);
	Frame frame = new Frame();
	MediaTracker mt = new MediaTracker(frame);
	mt.addImage(i,0);
	try
	{
		mt.waitForAll();
		System.out.println("Successfull in loading image:"+i.toString());
	}
	catch(InterruptedException e1) 
	{
		System.out.println("Error in loading image:"+e1.toString());
	}

	 BufferedImage bi = (BufferedImage)f.createImage(Integer.parseInt(dwd),Integer.parseInt(dht));

	g = bi.createGraphics();    // Get a Graphics object
	g.drawImage(i, 0, 0,Integer.parseInt(dwd),Integer.parseInt(dht),null); 
	Graphics2D g2D = (Graphics2D) g;
        	Stroke stroke = new BasicStroke((float)1.5);
      		g2D.setStroke(stroke);
	g.setColor(col);

			/// draw freehand
			
			/*try{
				if(fhand!=""){
				
				StringTokenizer li = new StringTokenizer(fhand,"#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
					System.out.println("Points: " + pts);
				
					String[] strpts = pts.split(",");
					
					g.setColor(Color.decode(strpts[0]));
					int x =Integer.parseInt(strpts[1]);
 		    		int y =Integer.parseInt(strpts[2]);
					System.out.println("Num:Points: " + strpts.length);
 		    		for(int ii=1;ii<strpts.length-1;){ //int ii=3;ii<strpts.length-1;
						System.out.println("PointsForlOoP: " + pts);
		 			    int x1=Integer.parseInt(strpts[ii++]);
						int y1=Integer.parseInt(strpts[ii++]);
		 		    	g.drawLine(x,y,x1,y1);
		 		    	x=x1;
		 		    	y=y1;
					}
				}
				} 
			}
			*/


		try{
			if(fhand!=""){
				StringTokenizer li = new StringTokenizer(fhand,"#");
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
					}
		}
				catch (Exception e){
				
				e.printStackTrace();
				
			}
		
	try{
	//ImageIO.write(bi,"jpg",new File(fpath.substring(0,fpath.lastIndexOf("."))+sn+".1jpg"));
	ImageIO.write(bi,"jpg",new File(fpath.substring(0,fpath.lastIndexOf("."))+sn+".jpg"));
	g.dispose();
	f.removeNotify();	 
	return true;
	
	}
	catch(IOException ioe)
	{
		System.out.println("error in writing file:"+ioe.toString());
		return false;
	}

}//end of fun


public byte [] intToWord (int parValue) {
     byte retValue [] = new byte [2];
     retValue [0] = (byte) (parValue & 0x00FF);
     retValue [1] = (byte) ((parValue >>  8) & 0x00FF);
     return (retValue);
  }

public byte [] intToDWord (int parValue) {
     byte retValue [] = new byte [4];
     retValue [0] = (byte) (parValue & 0x00FF);
     retValue [1] = (byte) ((parValue >>  8) & 0x000000FF);
     retValue [2] = (byte) ((parValue >>  16) & 0x000000FF);
     retValue [3] = (byte) ((parValue >>  24) & 0x000000FF);
     return (retValue);
  }


public void createDicom(String fjpg,String sn,String patid,String pname,String telecon)
{
//dicomw obj1=new dicomw();

String jpgfnam=fjpg.substring(0,fjpg.lastIndexOf("."))+sn+".jpg";

File jfile=new File(jpgfnam);
if(jfile.exists())
{
String dcmfnam=fjpg.substring(0,fjpg.lastIndexOf("."))+sn+".dcm";
FileInputStream fin;
RandomAccessFile fout;
FileChannel fchan,fichan;
ByteBuffer bbuf;
ByteBuffer mbuf;
long fsize;
StringBuffer sg =new StringBuffer();
StringBuffer sl =new StringBuffer();
try{
	fin=new FileInputStream(jpgfnam);
	fichan=fin.getChannel();
	fsize=fichan.size();
	bbuf=ByteBuffer.allocate((int)fsize);
	fout=new RandomAccessFile(dcmfnam,"rw");
	fchan=fout.getChannel();
	mbuf=fchan.map(FileChannel.MapMode.READ_WRITE,0,712+fsize);
	mbuf.put(preamble,0,128);
	mbuf.put(DICM,0,4);

	//sg.append("0x0002");
	//String sgroup = "0x0002";
	//String sgroup=sg.toString();
	//String hex =  "000002";
	//byte[] bts = new byte[hex.length() / 2];
	//for (int i = 0; i < bts.length; i++) {
   	//bts[i] = (byte) Integer.parseInt(hex.substring(i, i+2), 16);
	//}
	
	//BigInteger bi = new BigInteger(sgroup); 
	System.out.println("Working.............");
	//byte[] lgroup = bi.toByteArray();
	//byte[] lgroup=sgroup.getBytes();
	byte[] lgroup=intToWord(0x0002);
	
	mbuf.put(lgroup,0,lgroup.length);
	//sl.append("0x0000");
	//String selement = "0x0000";
	//String selement=sl.toString();
	//BigInteger bl = new BigInteger(selement); 
	//byte[] lelement = bl.toByteArray();
	//byte[] lelement=selement.getBytes();



	byte[] lelement=intToWord(0x0000);
	mbuf.put(lelement,0,lelement.length);
	byte UL[] = "UL".getBytes();
	mbuf.put(UL,0,UL.length);
	byte[] elelen=intToWord(4);
	mbuf.put(elelen,0,elelen.length);
	byte[] eleval=intToWord(0x00c2);
	mbuf.put(eleval,0,eleval.length);


	mbuf.put(emp,0,emp.length);

	lgroup=intToWord(0x0002);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0001);
	mbuf.put(lelement,0,lelement.length);
	byte OB[] = "OB".getBytes();
	mbuf.put(OB,0,OB.length);
	mbuf.put(emp,0,emp.length);

	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	
	byte[] eleval1=intToWord(0x00);
	mbuf.put(eleval1,0,eleval1.length);
	byte[] eleval2=intToWord(0x01);
	mbuf.put(eleval2,0,eleval2.length);
	
	
	lgroup=intToWord(0x0002);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0010);
	mbuf.put(lelement,0,lelement.length);
	byte UI[] = "UI".getBytes();
	mbuf.put(UI,0,UI.length);
	

	elelen=intToWord(20);
	mbuf.put(elelen,0,elelen.length);
	
	byte transfer_syntax[]={'1','.','2','.','8','4','0','.','1','0','0','0','8','.','1','.','2','.','4'};
	mbuf.put(transfer_syntax,0,transfer_syntax.length);
	
	// patient name
	 mbuf.put(emp1,0,emp1.length);
	lgroup=intToWord(0x0010);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0010);
	mbuf.put(lelement,0,lelement.length);
	byte PN[] = "PN".getBytes();
	mbuf.put(PN,0,PN.length);
	elelen=intToWord(30);
	mbuf.put(elelen,0,elelen.length);
	//String patname="parthiabdcasdfghjklpoiuytrewqa";
	int pnlen=pname.length();
	byte pat_name[]=pname.getBytes();
	mbuf.put(pat_name,0,pat_name.length); 
		
	int patn=30-pat_name.length;
	byte pemptybyte[] = new byte[patn];
	mbuf.put(pemptybyte,0,pemptybyte.length);

	

	// patient Id
	lgroup=intToWord(0x0010);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0020);
	mbuf.put(lelement,0,lelement.length);
	byte LO[] = "LO".getBytes();
	mbuf.put(LO,0,LO.length);
	elelen=intToWord(14);
	mbuf.put(elelen,0,elelen.length);
	//String patid="nod01012006001";
	int pidlen=patid.length();
	byte pat_id[]=patid.getBytes();
	mbuf.put(pat_id,0,pat_id.length); 



	
	// telemedicine issuer of pat ID

	 lgroup=intToWord(0x0010);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0021);
	mbuf.put(lelement,0,lelement.length);
	byte TI[] = "LO".getBytes();
	mbuf.put(TI,0,TI.length);
	elelen=intToWord(20);
	mbuf.put(elelen,0,elelen.length);
	String teleis="TELEMEDICINE--IITKGP";
	int telelen=teleis.length();
	byte tele_is[]=teleis.getBytes();
	mbuf.put(tele_is,0,tele_is.length); 
	
	lgroup=intToWord(0x0010);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x4000);
	mbuf.put(lelement,0,lelement.length);
	byte LT[] = "LT".getBytes();
	mbuf.put(LT,0,LT.length);
	elelen=intToWord(300);
	mbuf.put(elelen,0,elelen.length);
	//String telecon="patients comments";
	int patcon=telecon.length();
	byte tele_con[]=telecon.getBytes();
	mbuf.put(tele_con,0,tele_con.length); 
	int telec=300-tele_con.length;
	byte emptybyte[] = new byte[telec];
	mbuf.put(emptybyte,0,emptybyte.length);


	// write the photometric info of the file
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x004);
	mbuf.put(lelement,0,lelement.length);
	byte CS[] = "CS".getBytes();
	mbuf.put(CS,0,CS.length);
	elelen=intToWord(12);
	mbuf.put(elelen,0,elelen.length);
	String photometric="MONOCHROME2";
	//int patcon=telecon.length();
	byte photo_metric[]=photometric.getBytes();
	mbuf.put(photo_metric,0,photo_metric.length);
	mbuf.put(emp1,0,emp1.length);
	
	// writing the width and the height of the image
	
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0010);
	mbuf.put(lelement,0,lelement.length);
	byte US[] = "US".getBytes();
	mbuf.put(US,0,US.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte[] lwidth=intToWord(0x0200);
	mbuf.put(lwidth,0,lwidth.length);
	
	// writing value of width
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0011);
	mbuf.put(lelement,0,lelement.length);
	byte WUS[] = "US".getBytes();
	mbuf.put(WUS,0,WUS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte[] plen=intToWord(0x0200);
	mbuf.put(plen,0,plen.length);


	// writing bits allocated
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0100);
	mbuf.put(lelement,0,lelement.length);
	byte BUS[] = "US".getBytes();
	mbuf.put(BUS,0,BUS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	elelen=intToWord(24);
	mbuf.put(elelen,0,elelen.length);

	// writing bits stored
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0101);
	mbuf.put(lelement,0,lelement.length);
	byte AUS[] = "US".getBytes();
	mbuf.put(AUS,0,AUS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	elelen=intToWord(24);
	mbuf.put(elelen,0,elelen.length);

	// writing high bit
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0103);
	mbuf.put(lelement,0,lelement.length);
	byte HUS[] = "US".getBytes();
	mbuf.put(HUS,0,HUS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	elelen=intToWord(23);
	mbuf.put(elelen,0,elelen.length);

	// writeing window center

	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x1050);
	mbuf.put(lelement,0,lelement.length);
	byte DS[] = "DS".getBytes();
	mbuf.put(DS,0,DS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte wincen[] = "50".getBytes();
	mbuf.put(wincen,0,wincen.length);

	// writing window width

	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x1051);
	mbuf.put(lelement,0,lelement.length);
	byte WDS[] = "DS".getBytes();
	mbuf.put(WDS,0,WDS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte winval[] = "75".getBytes();
	mbuf.put(winval,0,winval.length);
	
	// writing rescale intercept
	
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x1052);
	mbuf.put(lelement,0,lelement.length);
	byte RDS[] = "DS".getBytes();
	mbuf.put(RDS,0,RDS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte winres[] = "0".getBytes();
	mbuf.put(winres,0,winres.length);
	mbuf.put(emp1,0,emp1.length);

	// writing rescale slope
	lgroup=intToWord(0x0028);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x1053);
	mbuf.put(lelement,0,lelement.length);
	byte SDS[] = "DS".getBytes();
	mbuf.put(SDS,0,SDS.length);
	elelen=intToWord(2);
	mbuf.put(elelen,0,elelen.length);
	byte winslope[] = "1".getBytes();
	mbuf.put(winslope,0,winslope.length);
	mbuf.put(emp1,0,emp1.length);
	
	//writing pixel data group length
	lgroup=intToWord(0x7fe0);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0000);
	mbuf.put(lelement,0,lelement.length);
	byte PUL[] = "UL".getBytes();
	mbuf.put(PUL,0,PUL.length);
	elelen=intToWord(4);
	mbuf.put(elelen,0,elelen.length);
	byte[] lpixel_info=intToDWord(0x008000c);
	mbuf.put(lpixel_info,0,lpixel_info.length);

	//writing total pixel 
	lgroup=intToWord(0x7fe0);
	mbuf.put(lgroup,0,lgroup.length);
	lelement=intToWord(0x0010);
	mbuf.put(lelement,0,lelement.length);
	byte POW[] = "OW".getBytes();
	mbuf.put(POW,0,POW.length);
	mbuf.put(emp,0,emp.length);
	
	fichan.read(bbuf);
	bbuf.rewind();
	mbuf.put(bbuf);
	
	fichan.close();
	fchan.close();
	fout.close();
	
   }	catch(IOException exc)
	{ System.out.println(exc);
	}
}//end of if
} // end of fun
} //end of class

 
/*
	/// draw Line
      		
	   		try{
	   			if(lin!=""){
	   			StringTokenizer li = new StringTokenizer(lin, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int x1=Integer.parseInt(minili.nextToken());
					int y1=Integer.parseInt(minili.nextToken());
					g.drawLine(x,y,x1,y1);
				}
				}
				}catch (Exception e){
				System.out.println(e.toString());
			
				}
			
						
		
			/// draw rec
			
			try{
				if(rect!=""){
					
				StringTokenizer li = new StringTokenizer(rect, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int w=Integer.parseInt(minili.nextToken());
					int h=Integer.parseInt(minili.nextToken());
					g.drawRect(x,y,w,h);
				}
				}
			}catch (Exception e){
				System.out.println(e.toString());
			
			}
			
			
			/// draw circle
			
			try{
				if(circle!=""){
				
				StringTokenizer li = new StringTokenizer(circle, "#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					int w=Integer.parseInt(minili.nextToken());
					int h=Integer.parseInt(minili.nextToken());
					g.drawOval(x,y,w,h);
				  }	
				}
			}catch (Exception e){
				System.out.println(e.toString());
				
			}
			
			
			/// draw TXT
			
			try{
				if(txt!=""){
					
				
				StringTokenizer li = new StringTokenizer(txt,"#");
				while (li.hasMoreTokens())
				{
					String pts = li.nextToken();
				//	System.out.println(pts);
					StringTokenizer minili = new StringTokenizer(pts, ",");
					g.setColor(Color.decode(minili.nextToken()));
					
					String  txtval=minili.nextToken();
					int x=Integer.parseInt(minili.nextToken());
					int y=Integer.parseInt(minili.nextToken());
					g.drawString(txtval,x,y);	
				}
				}
			}catch (Exception e){
				System.out.println(e.toString());
			
			}
			*/
 
