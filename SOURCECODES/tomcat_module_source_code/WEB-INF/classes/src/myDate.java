/**
 * @author Saikat Ray
 **/
 
package imedix;

import java.io.*;
import java.util.Vector;
import java.util.Date;
import java.text.*;

 public class myDate{
	
	 public static void copyfile(String srFile, String dtFile){
    try{
      File f1 = new File(srFile);
      File f2 = new File(dtFile);
      InputStream in = new FileInputStream(f1);
      
      //For Append the file.
//      OutputStream out = new FileOutputStream(f2,true);

      //For Overwrite the file.
      OutputStream out = new FileOutputStream(f2);

      byte[] buf = new byte[1024];
      int len;
      while ((len = in.read(buf)) > 0){
        out.write(buf, 0, len);
      }
      in.close();
      out.close();
      System.out.println("File copied.");
    }
    catch(FileNotFoundException ex){
      System.out.println(ex.getMessage() + " in the specified directory.");
      System.exit(0);
    }
    catch(IOException e){
      System.out.println(e.getMessage());      
    }
  }
  	
	public static String getFomateDate(String fmt, boolean slash, String argDate)
		{
				String dat="", dat1="", tmp="";
				dat = argDate; //ddmmyyyy
				if (fmt.equalsIgnoreCase("dmy")) {
					tmp = dat.substring(0,2)+"/"+dat.substring(2,4)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("mdy")) {
					tmp = dat.substring(2,4)+"/"+dat.substring(0,2)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("ymd")) {
					tmp = dat.substring(4)+"/"+dat.substring(2,4)+"/"+dat.substring(0,2);
				}

				if (slash==false) {
					for (int i=0; i<tmp.length(); i++) {
						if (tmp.charAt(i)!='/')
							dat1 = dat1 + tmp.charAt(i);
					}
				}
				else dat1=tmp;
				return dat1;
		}
		
		public static String getFomateDate1(String fmt, boolean slash, String argDate)
		{
				String dat="", dat1="", tmp="";
				dat = argDate; //mmddyyyy
				if (fmt.equalsIgnoreCase("dmy")) {
					tmp = dat.substring(2,4)+"/"+dat.substring(0,2)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("mdy")) {
					tmp = dat.substring(0,2)+"/"+dat.substring(2,4)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("ymd")) {
					tmp = dat.substring(4)+"/"+dat.substring(0,2)+"/"+dat.substring(2,4);
				}

				if (slash==false) {
					for (int i=0; i<tmp.length(); i++) {
						if (tmp.charAt(i)!='/')
							dat1 = dat1 + tmp.charAt(i);
					}
				}
				else dat1=tmp;
				return dat1;
		}
		
		public static String datePart(String dp, String argDate)
		{
				String dat="", tmp="";
				dat = argDate; //yyyymmdd
				if (dp.equalsIgnoreCase("d")) {
					tmp = dat.substring(8,10);
				}

				if (dp.equalsIgnoreCase("m")) {
					tmp = dat.substring(5,7);
				}

				if (dp.equalsIgnoreCase("y")) {
					tmp = dat.substring(0,4);
				}

				return tmp;
		}
		
		public static String getCurrentDate(String fmt, boolean slash)
		{
				Date dt = new Date();
				int dd,mm,yy;
				String dat="", dat1="", tmp="";
				dd = dt.getDate();
				mm= dt.getMonth()+1;
				yy = dt.getYear() + 1900;
				if (dd <10) { dat = "0" + dd; }
				else { dat = ""+dd; }

				if(mm<10) {dat = dat + "0"+mm; }
				else {dat = dat+mm; }

				dat =dat + yy;

				if (fmt.equalsIgnoreCase("mdy")) {
					tmp = dat.substring(2,4)+"/"+dat.substring(0,2)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("dmy")) {
					tmp = dat.substring(0,2)+"/"+dat.substring(2,4)+"/"+dat.substring(4);
				}

				if (fmt.equalsIgnoreCase("ymd")) {
					tmp = dat.substring(4)+"/"+dat.substring(2,4)+"/"+dat.substring(0,2);
				}

				if (slash==false) {
					for (int i=0; i<tmp.length(); i++) {
						if (tmp.charAt(i)!='/')
							dat1 = dat1 + tmp.charAt(i);
					}
				}
				else dat1 = tmp;
				return dat1;
		}
		
		public static String getDateMySql(String argDate){
			
				String tmp = argDate.substring(4)+argDate.substring(2,4)+argDate.substring(0,2)+"000000";
				return tmp;
	
		}
		
		public static String getCurrentDateMySql(){
			Date dt = new Date();
			String fmt="yyyyMMddHHmmss";
			return dateFormat(fmt,dt);	
		}
		
		public static String getCurrentDateMSSql(){
			Date dt = new Date();
			String fmt="yyyyMMdd HH:mm:ss";
			return dateFormat(fmt,dt);	
		}
		
		public static String getCurrentYear(){
			Date dt = new Date();
			String fmt="yyyy";
			return dateFormat(fmt,dt);	
		}
		
		
		public static String dateFormat(String fmat, Date dt){
	
			String str="";
			try{
				Date date=dt;
				DateFormat df=new SimpleDateFormat(fmat);
				str=df.format(date);
				
			}catch(Exception e){
				System.out.println(e.toString());
				str="";
			}
			
		return str;		
	}
	public static int dateDiff(String date1, String date2,String fmt){
	
			int daysDiff=0;
			try{
				date1=date1.replace("/","-");
				date2=date2.replace("/","-");
				String xx1 [] = date1.split("-");
				String xx2 [] = date2.split("-");
				
			java.util.Date dt1 = new Date(Integer.parseInt(xx1[0]),Integer.parseInt(xx1[1])-1,Integer.parseInt(xx1[2]));
			java.util.Date dt2=new Date(Integer.parseInt(xx2[0]),Integer.parseInt(xx2[1])-1,Integer.parseInt(xx2[2]));
			
			long ldate1=dt1.getTime();
			long ldate2=dt2.getTime();
			int hrdate1   = (int)(ldate1/3600000); 
		    int hrdate2   = (int)(ldate2/3600000);
		    
		    int daysdate1 = (int)hrdate1/24;
		    int daysdate2 = (int)hrdate2/24;
		    
		    daysDiff  = daysdate1 - daysdate2;
		    
		    System.out.println("daysDiff:>>"+daysDiff);
		 	
			}catch(Exception e){
				System.out.println(e.toString());
				daysDiff=0;
			}
			
		return daysDiff;		
		}
		
	public static String mysql2ind(String date) {
	   
	    if(date==null) return "";
	    else{
	    	System.out.println("\n\ndate : "+date +"\n\n");
	    	date.replaceAll("/","-");
	    	date=date.substring(0,10);
	    	System.out.println("\n\ndate : "+date +"\n\n");
	    	String array[]=date.split("-");
	    	
	    	if(array.length<2){
	    		 String array1[] = date.split("/");
	    		 date=array1[2] + "/"+array1[1]+"/"+array1[0];
	    	}else{
	    		date=array[2] + "/"+array[1]+"/"+array[0];
	    	}
	    	
	    	
	    }
		return date;
   }

    // this function convert date from DD-MM-YYYY to YYYY-MM-DD 
   public static String ind2mysql(String date) {
	    date.replaceAll("/","-");
		String array[]=date.split("-");
		if(array.length<2){
			String array1[] = date.split("/");
	    	date=array1[2] + "/"+array1[1]+"/"+array1[0];
		}else{
			date=array[2] + "-"+array[1]+"-"+array[0];	
		}
		
		return date;
   }
		
}