package imedixservlets;

import imedix.dataobj;
import imedix.cook;
import imedix.rcDataEntryFrm;
import imedix.myDate;
import imedix.rcGenOperations;

import java.util.*;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.imageio.*;
import javax.swing.*;

public class dicommarkservlet extends HttpServlet {

  	JFrame f = null;
 	FileOutputStream fout;
	String para="";
		
  	public void init(ServletConfig config) throws ServletException {
    	super.init(config);
   		f = new JFrame();
    	f.addNotify();
   
  }
  
  
 public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
    //res.setContentType("text/html");
    PrintWriter out = res.getWriter();
    out.println("Error: this servlet does not support the GET method!");
    out.close();
    
 	 }

  public void doPost(HttpServletRequest req, HttpServletResponse res)
                               throws ServletException, IOException {


			StringBuffer msgBuf = new StringBuffer();
    		BufferedReader fromApplet = req.getReader();
    		String line;
    		String ans="Saved";
    		Color color;
		
	    
    		while ((line=fromApplet.readLine())!=null) {
      			if (msgBuf.length()>0) msgBuf.append('\n');
      			msgBuf.append(line);
    		}
    		
    		fromApplet.close();
    		para=msgBuf.toString();
    		
    		String pin[]=para.split("&");
			res.setContentType("text/plain");		
			
			    				
			String endt="",pid="",type="",isl="",dt="",ccode="",uid="",lin="",circle="",rect="",fhand="",txt="", ht="", wd="", cname="", lname="", col="";
			
			try{
				
				pid=pin[0].substring(pin[0].indexOf("=")+1);
				
				type=pin[1].substring(pin[1].indexOf("=")+1);
				isl=pin[2].substring(pin[2].indexOf("=")+1);
				dt=pin[3].substring(pin[3].indexOf("=")+1); //dd-mm-yyyyy
				
				ccode=pin[4].substring(pin[4].indexOf("=")+1);
				uid=pin[5].substring(pin[5].indexOf("=")+1);
				ht=pin[6].substring(pin[6].indexOf("=")+1);
				wd=pin[7].substring(pin[7].indexOf("=")+1);
				//lin=pin[6].substring(pin[6].indexOf("=")+1).trim();
				//circle=pin[7].substring(pin[7].indexOf("=")+1).trim();
				//rect=pin[8].substring(pin[8].indexOf("=")+1).trim();
				fhand=pin[8].substring(pin[8].indexOf("=")+1).trim();
				cname=pin[9].substring(pin[9].indexOf("=")+1).trim();
				lname=pin[10].substring(pin[10].indexOf("=")+1).trim();
				col=pin[11].substring(pin[11].indexOf("=")+1).trim();
				
				//txt=pin[10].substring(pin[10].indexOf("=")+1).trim();
				PrintWriter out = res.getWriter();
				
				//out.println(" type : "+pin[1].substring(pin[1].indexOf("=")+1)+"isl : "+pin[2].substring(pin[2].indexOf("=")+1)+"dt : "+pin[3].substring(pin[3].indexOf("=")+1)+"ccode : "+pin[4].substring(pin[4].indexOf("=")+1)+"uid : "+pin[5].substring(pin[5].indexOf("=")+1));
				//out.println("ht : "+pin[6].substring(pin[6].indexOf("=")+1)+"wd : "+pin[7].substring(pin[7].indexOf("=")+1));
				//out.println("fhand : "+pin[8].substring(pin[8].indexOf("=")+1));
				//out.println(pid+" "+type+" "+fhand);
				System.out.println("dt : "+dt);
				endt=dt.substring(8,10)+"/"+dt.substring(5,7)+"/"+dt.substring(0,4);
				
			}catch (Exception e){
				System.out.println("DDPERROR1:" + e.toString());
				e.printStackTrace();
				System.out.println("DDPERROR2:" + e.toString());
				ans="Error";
			}
			
			String imgdirname=req.getRealPath("//")+"/temp/"+uid+"/images/"+pid+"/";
			String fdt =endt.replaceAll("/","");
			String fname=pid+fdt+type+isl+".jpg";
			//fname=fname.toLowerCase();
			String imgpath = imgdirname+fname;
			System.out.println("imgpath"+ imgpath);	
					
		try{

			if (imgpath == null) {
	       	throw new ServletException("Extra path information " +
	                                   "must point to an image");
	        }
  
			boolean jpgimg=false;
			dicomwriter dwriter=new dicomwriter();
			
			//lin,circle,rect,txt,
			color= Color.decode(col);
			jpgimg=dwriter.createjpg(imgpath,"sr",fhand,wd,ht,color);
			
			cook cookx = new cook();
        	dataobj obj = new dataobj();	
        	rcDataEntryFrm rcdef = new rcDataEntryFrm(req.getRealPath("/"));	
        	String edt=myDate.getCurrentDate("dmy",false);
        	rcGenOperations rcgo=new rcGenOperations(req.getRealPath("/"));	
			String cond	= " lower(pat_id) = '" + pid.toLowerCase() + "'";
			String pname=rcgo.getAnySingleValue("med","pat_name",cond);
						
			if(jpgimg==true)
			{
				String telecon="Comments on dicom";
				dwriter.createDicom(imgpath,"sr",pid,pname,telecon);
				        		
				try {
					String difn=imgpath.substring(0,imgpath.lastIndexOf("."))+"sr"+".dcm";
					String ifn=imgpath.substring(0,imgpath.lastIndexOf("."))+"sr"+".jpg";
					
					File imageFile = new File(difn);
					if(imageFile.exists())
					{
					InputStream is = new FileInputStream(imageFile);
					int size=(int) imageFile.length();
					byte b[] = new byte[size];
					is.read(b);
					is.close();
					//imageFile.delete();
					File imgF = new File(ifn);
					//imgF.delete();
					
					obj.add("pat_id",pid);
					obj.add("ext","dcm");
					obj.add("type",type);
					obj.add("imgdesc","Ref Images");
					obj.add("ref_code",ccode);
					obj.add("lab_name",cname);
					obj.add("doc_name",lname);
					obj.add("testdate",edt);
					obj.add("entrydate",myDate.getCurrentDateMySql());
					obj.add("img_serno",isl);	
					obj.add("size",Integer.toString(size));
					obj.add("con_type","application/octet-stream");	
					obj.add("userid",uid);
					obj.add("center",ccode);
						
						    
					ans=rcdef.SaveMarkImg(obj,b);
					
					PrintWriter out = res.getWriter();
					out.println(imgpath.substring(0,imgpath.lastIndexOf("."))+"sr"+".jpg");
					
					}else{
						ans="Error..";
					}
				
				
				} catch(IOException e) {
					System.out.println(e.getMessage());
					ans="Error";
					ans="Error servlet 1" + e.getMessage();
				}
			}else{
				ans="Error createjpg ";	
			}	
   }catch(Exception ee)
    {
    	System.out.println(ee.getMessage());
		ans="Error";
		ans="Error servlet 2" + ee.getMessage();
   }
   finally {

   }
   
   //PrintWriter printwriter = res.getWriter();
  // printwriter.println(ans);
   //printwriter.close();
	    
  }
  
} //end of class
