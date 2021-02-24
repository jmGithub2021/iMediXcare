
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


public class familyhistory extends HttpServlet
{
	
	public void init(ServletConfig config) throws ServletException {
        super.init(config);
	}
  
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
       	doPost(req,resp);     	
  }
  
  
  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 	
	resp.setContentType("text/html");
 	PrintWriter out = resp.getWriter();

 	String id="",dat="",userid="";
	rcgraphsinfo rcGraphs = new rcgraphsinfo(req.getRealPath("/"));
	rcGenOperations rcGrnOp= new rcGenOperations(req.getRealPath("/"));
	String path=req.getRealPath("/");

	cook cookx = new cook();
	id = cookx.getCookieValue("patid", req.getCookies());
	userid = cookx.getCookieValue("userid", req.getCookies());
	dat = myDate.getCurrentDate("dmy",false);
	
	dataobj coords = new dataobj();
		
	String filename="",familymap="";
	
	int mainwt=0, mainht=0, ewt=0, eht=0;
	int top = 0, right = 0, bottom = 0, left = 0;
	boolean hasparent = false, vulve = true;
		
	try{
		
	String pat_gender = rcGrnOp.getAnySingleValue("med","sex", "pat_id='"+id+"'");
	
	//out.println("pat_gender : "+pat_gender);
	
	BufferedImage bufSibling=null;
	BufferedImage bufParent=null;
	BufferedImage bufFamhis=null;
	int nosib =0;
	String cnt=rcGraphs.getNoSibling(id);
	if(!cnt.equals("")) nosib = Integer.parseInt(cnt);
	
//	out.println("nosib : "+nosib);
	
		if (nosib > 0){
			mainwt = (nosib - 1) * 80 + 40;
			mainht = 80;
			ewt = mainwt;
			eht = mainht;
			
			bufSibling= new BufferedImage(ewt, eht, BufferedImage.TYPE_INT_RGB);
			Graphics g = bufSibling.createGraphics();
			g.setColor(Color.WHITE);
			g.fillRect(0,0,ewt,eht);
			g.setColor(Color.BLACK);
			
			Object res = rcGraphs.getSiblingHistory(id);
			if(res instanceof String){
				out.println(res);
				
			}else{
				int i=0;
				Vector tmp = (Vector)res;
			//	out.println("xtmp.size()"+tmp.size());
				for(i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String pdt = temp.getValue("entrydate");
					String imgcode = "";
                    String desc = "";
                    String title = "";
                    String alive = temp.getValue(1).toLowerCase();
                    String gender = temp.getValue(0).toLowerCase();
                    String step = temp.getValue(2).toLowerCase();
                    String hiv = temp.getValue(3).toLowerCase();
                    
                    if (alive.equalsIgnoreCase("yes")) imgcode += "1";
                    else imgcode += "0";

                    if (gender.indexOf("sister") != -1) imgcode += "00";
                    else if (gender.indexOf("brother") != -1) imgcode += "01";
                    else if (gender.indexOf("self") != -1)
                    {
                        if (vulve == true)
                        {
                            vulve = false;
                            if (pat_gender.equalsIgnoreCase("F"))
                                imgcode += "10";
                            else
                                imgcode += "11";
                        }
                        else
                            continue;
                    }
                    
                    if (step.equalsIgnoreCase("father")) imgcode += "11";
                    else if (step.equalsIgnoreCase("mother")) imgcode += "10";
                    else imgcode += "00";

                    if (hiv.equalsIgnoreCase("positive")) imgcode += "11";
                    else if (hiv.equalsIgnoreCase("negative")) imgcode += "10";
                    else if (hiv.equalsIgnoreCase("unknown")) imgcode += "00";

                    imgcode += ".gif";
                                   
                    ImageIcon ImagIcon = new ImageIcon(path+"/phivimages/"+imgcode);
                    g.drawImage(ImagIcon.getImage(), i * 80, 40, 40, 40,null);
                                         
			        if (!step.equalsIgnoreCase("father") || step.equalsIgnoreCase("mother"))
                   		g.drawLine(i * 80 + 20, 0, i * 80 + 20, 40);
                                      

                    title = "Age: " + temp.getValue(4) + "year " + temp.getValue(5) + "month " + temp.getValue(6) + "days" + "\n";
                    title += "HIV: " + temp.getValue(3);
                    desc += "<b>Age:</b> " +temp.getValue(4) + "year " + temp.getValue(5) + "month " +temp.getValue(6) + "days<br>";
                    desc += "<b>Alive:</b> " +temp.getValue(1) + "<br>";
                    desc += "<b>HIV:</b> " + temp.getValue(3) + "<br>";
                    desc += "<b>HAART:</b> " + temp.getValue(7) + "<br>";
                    desc += "<b>OI:</b> " + temp.getValue(8) + "<br>";
                    desc += "<b>Comment:</b> " + temp.getValue(9) + "<br>";
                    
                    //coords.Add(Convert.ToString(i * 80) + ",40," + Convert.ToString(i * 80 + 40) + ",80", desc + ":-:" + title);      
           			String poin= Integer.toString(i * 80) + ",40," + Integer.toString(i * 80 + 40) + ",80";
           			coords.add(poin , desc + ":-:" + title);
           		
				}// for
				g.drawLine( 20, 1, (i-1) * 80 + 20, 1);
				
			}
		}// if sibling
		
		
		
			Object res = rcGraphs.getParentHistory(id);
			if(res instanceof String){
//				out.println(res);
				
			}else{
				Vector tmp = (Vector)res;
				//out.println("tmp.size()"+tmp.size());
				for(int i=0;i<tmp.size();i++){
					hasparent = true;
                	ewt = 120;
                	eht = 80;
                    bufParent= new BufferedImage(ewt, eht, BufferedImage.TYPE_INT_RGB);
					Graphics g2 = bufParent.createGraphics();
					g2.setColor(Color.WHITE);
					g2.fillRect(0,0,ewt,eht);
			 		
			 		/**********     Mother    **************/

					dataobj temp = (dataobj) tmp.get(i);
										
					String imgcode = "";
                    String desc = "";
                    String title = "";
                    String alive = temp.getValue(1).toLowerCase();
                    String hiv = temp.getValue(3).toLowerCase();
                    if (alive.equalsIgnoreCase("yes")) imgcode += "1";
                    else imgcode += "0";
                    //gender
                    imgcode += "00";
                    //step
                    imgcode += "00";
                    
                    if (hiv.equalsIgnoreCase("positive")) imgcode += "11";
                    else if (hiv.equalsIgnoreCase("negative")) imgcode += "10";
                    else if (hiv.equalsIgnoreCase("unknown")) imgcode += "00";
                    imgcode += ".gif";
                    
					ImageIcon ImagIcon = new ImageIcon(path+"/phivimages/"+imgcode);
                    g2.drawImage(ImagIcon.getImage(), 0, 0, 40, 40,null);
                    g2.setColor(Color.BLACK);
                    
                    g2.drawLine(20, 40, 20, 80);

                   // out.println("<br>"+path+"phivimages/"+imgcode);
                    
                    
                    title = "";
                    desc = "";
                    title = "Age: " + temp.getValue(2) + "year" + "\n";
                    title += "HIV: " + temp.getValue(3);
                    desc += "<b>Age:</b> " + temp.getValue(2) + "year<br>";
                    desc += "<b>Alive:</b> " + temp.getValue(1) + "<br>";
                    desc += "<b>HIV:</b> " + temp.getValue(3) + "<br>";
                    String dt=temp.getValue(5);
                    
                   // if(!dt.equals("")) dt = myDate.getFomateDate("dmy",true,temp.getValue(5));
                                       
                    desc += "<b>HAART:</b> " + dt + "<br>";
                    desc += "<b>OI:</b> " + temp.getValue(4) + "<br>";
                    desc += "<b>Comment:</b> " + temp.getValue(6) + "<br>";
                    //coords.Add("0,0,40,40", desc + ":-:" + title);
                    coords.add("0,0,40,40" ,  desc + ":-:" + title);
           			
                    
                    
                    /**********     Father    **************/
                    imgcode = "";
                    alive = temp.getValue(7).toLowerCase();
                    if (alive.equalsIgnoreCase("yes")) imgcode += "1";
                    else imgcode += "0";

                    //gender
                    imgcode += "01";
                    //step
                    imgcode += "00";

                    hiv = temp.getValue(9).toLowerCase();
                    if (hiv.equalsIgnoreCase("positive")) imgcode += "11";
                    else if (hiv.equalsIgnoreCase("negative")) imgcode += "10";
                    else if (hiv.equalsIgnoreCase("unknown")) imgcode += "00";
                    imgcode += ".gif";
                    
					ImagIcon = new ImageIcon(path+"/phivimages/"+imgcode);
                    g2.drawImage(ImagIcon.getImage(), 80, 0, 40, 40,null);
                    g2.drawLine(100, 40, 100, 80);
                    
                   
                    title = "";
                    desc = "";
                    title = "Age: " + temp.getValue(8) + "year" + "\n";
                    title += "HIV: " + temp.getValue(9);
                    desc += "<b>Age:</b> " + temp.getValue(8) + "year<br>";
                    desc += "<b>Alive:</b> " + temp.getValue(7) + "<br>";
                    desc += "<b>HIV:</b> " + temp.getValue(9) + "<br>";
                   
                    dt=temp.getValue(11);
                    //if(!dt.equals("")) dt = myDate.getFomateDate("dmy",true,dt);
                    
                    desc += "<b>HAART:</b> " + dt + "<br>";
                    desc += "<b>OI:</b> " +temp.getValue(10) + "<br>";
                    desc += "<b>Comment:</b> " + temp.getValue(12) + "<br>"; ;
                    coords.add("80,0,120,40", desc + ":-:" + title);                   
                    g2.drawLine(20, 79, 100, 79);
                	g2.dispose();
				}
				 				
				//	 BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(path+"/phivimages/parent_" + id + ".jpg"));
				//	 JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(bos);
				//	 encoder.encode(bufParent);
				//	 System.out.println("gets here");
				//	 bos.flush();
				//	 System.out.println("flushed");
				//	 bos.close();
				//	 System.out.println("closed");
				//	 bufParent.flush();
			}
			
			ewt = (mainwt > 120 ? mainwt : 120) + left + right;
            eht = 200 +top + bottom;
            int midX = ewt / 2;
            int offsetX1 = 0, offsetY1 = 0, offsetX2 = 0, offsetY2 = 0;
            bufFamhis= new BufferedImage(ewt, eht, BufferedImage.TYPE_INT_RGB);
            Graphics g3 = bufFamhis.createGraphics();
            g3.setColor(Color.WHITE);
			g3.fillRect(0,0,ewt,eht);
			g3.setColor(Color.BLACK);
			
			if (hasparent)
            {
               	//ImageIcon ImagIcon = new ImageIcon(path+"/phivimages/parent_" + id + ".jpg");
               	Image img = Toolkit.getDefaultToolkit().createImage(bufParent.getSource()); 
            	//g3.drawImage(ImagIcon.getImage(), midX - 60, 0,null);
            	g3.drawImage(img, midX - 60, 0,null);
               	offsetX1 = (ewt - 120) / 2;
                offsetY1 = top;
                
            }

            if (hasparent && nosib > 0) 
                g3.drawLine(midX, 79, midX, 121);

            if (nosib > 0)
            {
                Image img = Toolkit.getDefaultToolkit().createImage(bufSibling.getSource()); 
            	g3.drawImage(img, midX - (mainwt / 2), 120,null);
                offsetX2 = (ewt - mainwt) / 2;
                offsetY2 = top + 120;
            }
            
            g3.dispose();
            
            
            //
            //out.println("hasparent :"+hasparent);
            
            if (hasparent==false && nosib <= 0)
            {
                filename = "phivimages/no_record.gif";
            }else
            {
                //uniquet = Convert.ToString(DateTime.Today.ToFileTime());
                filename = "phivimages/famhis_" + id + ".jpg";
           
                BufferedOutputStream bosf = new BufferedOutputStream(new FileOutputStream(path+"/phivimages/famhis_" + id + ".jpg"));
			 	JPEGImageEncoder encoderf = JPEGCodec.createJPEGEncoder(bosf);
			 	encoderf.encode(bufFamhis);
			 	bosf.flush();
			 	bosf.close();
			    bufFamhis.flush();


                String desc = "";
                int x1, y1, x2, y2;
                String singlecoord="";
               	
                
                for (int j = 0; j < coords.getLength() ; j++)
                {
                    //coordarr = coords.GetKey(j).Split(new string[] { "," }, StringSplitOptions.None);
                    String coordarr [] = coords.getKey(j).split(",");
                    String detailarr [] =coords.getValue(j).split(":-:");
                    
                   // detailarr = coords.Get(j).Split(new string[] { ":-:" }, StringSplitOptions.None);
                   
                    x1 =Integer.parseInt(coordarr[0]);
                    y1 = Integer.parseInt(coordarr[1]);
                    x2 = Integer.parseInt(coordarr[2]);
                    y2 = Integer.parseInt(coordarr[3]);
                    if (j < nosib)
                    {
                        x1 += offsetX2;
                        y1 += offsetY2;
                        x2 += offsetX2;
                        y2 += offsetY2;
                        singlecoord = x1 + "," + y1 + "," + x2 + "," + y2;
                        desc = "<area shape=\"rect\" coords=\"" + singlecoord + "\" href=\"#\" onclick=\"document.getElementById('detail').innerHTML='" + detailarr[0] + "'\" title=\"" + detailarr[1] + "\" />";
                    }
                    else
                    {
                        x1 += offsetX1;
                        y1 += offsetY1;
                        x2 += offsetX1;
                        y2 += offsetY1;
                        singlecoord = x1 + "," + y1 + "," + x2 + "," + y2;
                        desc = "<area shape=\"rect\" coords=\"" + singlecoord + "\" href=\"#\" onclick=\"document.getElementById('detail').innerHTML='" + detailarr[0] + "'\" title=\"" + detailarr[1] + "\" />";
                    }
                    familymap += desc + "\n";
                }
                
                
            }

            //
           
 			//out.println(path+"/phivimages/famhis_" + id + ".jpg");
		    out.println("<html><body><center>");
		    out.println("<h2>Family History</h2>");
		    
		    out.println("<img src='" + filename + "' usemap='#familymap' border='0' />");
		    out.println("<map id='familymap' name='familymap'>" );
		    out.println(familymap);
		    out.println("</map>");
		    
		    
		    out.println("<br><br>");
		    out.println("<TABLE><TR><TD align = 'left'>");
		    out.println("<span id='detail' style='align:center'></span>");
    		out.println("</TD></TR></TABLE>");    
		    out.println("</center></body></html>");
			out.close();
		   
	
	//	resp.setContentType("image/jpg");
	//	OutputStream os = resp.getOutputStream();
	//	ImageIO.write(bufFamhis, "jpg", os);
	//	os.close();

			
	}catch(Exception e){
	  out.println("Exception : " + e);
	}
	
 }
}