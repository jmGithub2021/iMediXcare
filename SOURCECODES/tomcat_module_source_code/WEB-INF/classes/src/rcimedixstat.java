package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.io.*;
import imedix.drawchart;



public class rcimedixstat{
	private static imedixstatinterface statServer=null;
	private Registry registry;
	projinfo proj;
	String path;
	public rcimedixstat(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   path=p;
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   statServer= (imedixstatinterface)(registry.lookup("iMediXStat"));
	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	 public String getGenderData(String ccode,String uid)throws RemoteException,SQLException {
	 	String dataTable="",tRow="";
	  	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
	 	String fBName=fDirpath+"genderbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	
	 	String fPName=fDirpath+"genderpie.gif";		
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
		
		boolean found=false;
		
	 	Object obj = statServer.getGenderData(ccode);
	 	if(obj instanceof String){
			tRow="<TR><TD> 1 </TD><TD> Record Not Found </TD><TD> NA </TD></TR>";
			dataTable+=tRow;
		}else{
			Vector Vtmp = (Vector)obj;
			int tsize=Vtmp.size();
			String x[]=new String[tsize];
	 		int y[]=new int[tsize];
	 	
			for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 x[i]=getAllDesc(data.getValue(0));
			 y[i]=Integer.parseInt(data.getValue(1));
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 found=true;
			 }
		
				String map = drawchart.DrawBar(620,380,"Bar Chart of Gender Type",x,y,fBName);
		 	    String map1 = drawchart.DrawPie(620,380,"Pie Chart of Gender Type",x,y,fPName);
		 	    dataTable+="<map id='genderbar' name='genderbar'>";
		 		dataTable+=map+"</map>";
		 		dataTable+="<map id='genderpie' name='genderpie'>";
		 		dataTable+=map1+"</map>";
		 		
		 		if(found==false){
		 			tRow="<TR><TD> 1 </TD><TD> Record Not Found </TD><TD> NA </TD></TR>";
		 			dataTable+=tRow;
		 		}
		}
		
	 	return dataTable;
	 }
     
     public String getDiseaseData(String ccode,String uid)throws RemoteException,SQLException {
     	String dataTable="";
	 	String tRow="<TR><TD> 1 </TD><TD> xxxxx </TD><TD> 20 </TD></TR>";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"disbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	
	 	String fPName=fDirpath+"dispie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}	
	 	
	 	Object obj = statServer.getDiseaseData(ccode);
	 	if(obj instanceof String){
			tRow="<TR><TD> 1 </TD><TD> Record Not Found </TD><TD> NA </TD></TR>";
			dataTable+=tRow;
		}else{
			Vector Vtmp = (Vector)obj;
			int tsize=Vtmp.size();
			String x[]=new String[tsize];
	 		int y[]=new int[tsize];
	 	    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 x[i]=data.getValue(0);
			 y[i]=Integer.parseInt(data.getValue(1));
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 }
			
			String map = drawchart.DrawBar(620,380,"Bar Chart of Disease Type",x,y,fBName);
 			String map1 = drawchart.DrawPie(620,380,"Pie Chart of Disease Type",x,y,fPName);
 			dataTable+="<map id='disbar' name='disbar'>";
	 		dataTable+=map+"</map>";
	 		dataTable+="<map id='dispie' name='dispie'>";
	 		dataTable+=map1+"</map>";
		}
	 
   		return dataTable;
     }
     
     public String getAgeData(String ccode,String uid)throws RemoteException,SQLException {
     	String dataTable="";
	 	String tRow="";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"agebar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	String fPName=fDirpath+"agepie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}

	  	  Object obj = statServer.getAgeData(ccode);
	 	  dataobj data = (dataobj) obj;
		  int tsize=data.getLength();
		  String x[]=new String[tsize];
	 	  int y[]=new int[tsize];
	 	  for(int i=0;i<tsize;i++){
			 x[i]=getAgeDesc(data.getKey(i));
			 
			 System.out.print("data.getValue(i): "+data.getValue(i));
			 
			 	y[i]=Integer.parseInt(data.getValue(i));
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 }
			
			String map = drawchart.DrawBar(620,380,"Bar Chart of Age Type",x,y,fBName);
	 		String map1 = drawchart.DrawPie(620,380,"Pie Chart of Age Type",x,y,fPName);
	 		
	 		dataTable+="<map id='agebar' name='agebar'>";
	 		dataTable+=map+"</map>";
	 		dataTable+="<map id='agepie' name='agepie'>";
	 		dataTable+=map1+"</map>";
	 				
   		return dataTable;
   		
     }
     
     public String getFormData(String ccode,String uid)throws RemoteException,SQLException{
     	String dataTable="";
	 	String tRow="<TR><TD> 1 </TD><TD> FFFFFFFF </TD><TD> 20 </TD></TR>";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"frmbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
		
	 	String fPName=fDirpath+"frmpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}	
	 		 	 	
	 	
	 	Object obj = statServer.getFormData(ccode);
	 	if(obj instanceof String){
			tRow="<TR><TD> 1 </TD><TD> Record Not Found </TD><TD> NA </TD></TR>";
			dataTable+=tRow;
		}else{
			Vector Vtmp = (Vector)obj;
			int tsize=Vtmp.size();
			String x[]=new String[tsize];
	 		int y[]=new int[tsize];
	 	    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
			 x[i]=data.getValue(0);
			 y[i]=Integer.parseInt(data.getValue(1));
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD align='center'>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 }
			
			String map = drawchart.DrawBar(620,380,"Bar Chart of Form Type",x,y,fBName);
	 		String map1 = drawchart.DrawPie(620,380,"Pie Chart of Form Type",x,y,fPName);
	 		
	 		dataTable+="<map id='frmbar' name='frmbar'>";
	 		dataTable+=map+"</map>";
	 		dataTable+="<map id='frmpie' name='frmpie'>";
	 		dataTable+=map1+"</map>";
		}
		
	 	
	 	
   		return dataTable;
   		
     }
     
     public String getImageData(String ccode,String uid)throws RemoteException,SQLException {
     	String dataTable="";
	 	String tRow="<TR><TD> 1 </TD><TD> IIIIIIIIII </TD><TD> 20 </TD></TR>";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"imgbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	String fPName=fDirpath+"imgpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}		
	 
	 	Object obj = statServer.getImageData(ccode);
	 	if(obj instanceof String){
			tRow="<TR><TD> 1 </TD><TD> Record Not Found </TD><TD> NA </TD></TR>";
			dataTable+=tRow;
		}else{
			Vector Vtmp = (Vector)obj;
			int tsize=Vtmp.size();
			String x[]=new String[tsize];
	 		int y[]=new int[tsize];
	 	    for(int i=0;i<Vtmp.size();i++){
			 dataobj data = (dataobj) Vtmp.get(i);
		
			 x[i]=data.getValue(1);

			 if(x[i].equals("")) x[i]=getAllDesc(data.getValue(0));
			 y[i]=Integer.parseInt(data.getValue(2));
			 
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 }
			
			String map = drawchart.DrawBar(620,380,"Bar Chart of Image Type",x,y,fBName);
	 		String map1 = drawchart.DrawPie(620,380,"Pie Chart of Image Type",x,y,fPName);
	 		dataTable+="<map id='imgbar' name='imgbar'>";
	 		dataTable+=map+"</map>";
	 		dataTable+="<map id='imgpie' name='imgpie'>";
	 		dataTable+=map1+"</map>";
		}
	 	
   		return dataTable;
   		
     }
     
     public String getImageVsPatData(String ccode,String uid)throws RemoteException,SQLException{
     	String dataTable="";
	 	String tRow="<TR><TD> 1 </TD><TD> I VS P </TD><TD> 20 </TD></TR>";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"imgvspatbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
		
	 	String fPName=fDirpath+"imgvspatpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
			
	 
	 
	 Object obj = statServer.getImageVsPatData(ccode);
	 	  dataobj data = (dataobj) obj;
		  int tsize=data.getLength();
		  System.out.println("tsize :"+tsize);
		  
		  String x[]=new String[tsize];
	 	  int y[]=new int[tsize];
	 	  for(int i=0;i<tsize;i++){
			 //x[i]=getAllDesc(data.getKey(i));
			 x[i]=data.getKey(i);
			 System.out.println("data.getValue(i) :"+data.getValue(i));
			 
			 y[i]=Integer.parseInt(data.getValue(i));
			 
			 	tRow="<TR><TD>"+(i+1)+"</TD><TD>"+x[i]+ "</TD><TD>"+y[i]+"</TD></TR>";
			 	dataTable+=tRow;
			 }
			
			String map = drawchart.DrawBar(620,380,"Bar Chart of Image Vs No of Patient ",x,y,fBName);
	 		String map1 = drawchart.DrawPie(620,380,"Pie Chart of Image Vs No of Patient",x,y,fPName);
	 		dataTable+="<map id='imgvspatbar' name='imgvspatbar'>";
	 		dataTable+=map+"</map>";
	 		dataTable+="<map id='imgvspatpie' name='imgvspatpie'>";
	 		dataTable+=map1+"</map>";
	 		
   		return dataTable;
   	
     }
     
     public String getTimeCountData(String ccode,String uid)throws RemoteException,SQLException {
     	
     	String dataTable="";
	 	String tRow="<TR><TD> 1 </TD><TD> TimeCount </TD><TD> 20 </TD></TR>";
	 	String fDirpath=path+"temp/"+uid+"/statimg/";
	 	File fdir = new File(fDirpath);
		if(!fdir.exists()){
			boolean yes1 = fdir.mkdirs();
		}
					
	 	String fBName=fDirpath+"timecountbar.gif";
	 	String fPName=fDirpath+"timecountpie.gif";	
	 	String x[]=null;
	 	int y[]=null;	 
	 	Object res=statServer.getTimeCountData(ccode);
	 	///////
	 	dataTable+=tRow;
	 	//////
	 	String map = drawchart.DrawBar(620,380,"Bar Chart of Image Vs No of Patient ",x,y,fBName);
	 	String map1 = drawchart.DrawPie(620,380,"Pie Chart of Image Vs No of Patient",x,y,fPName);
	 	dataTable+="<br>"+map+"<br>"+map1;
	 	return dataTable;
	 	
     }
     
     public String getAllDesc(String typ){
    	String imgDesc="";
    	if(typ.equalsIgnoreCase("BLD")) imgDesc="Blood Slide";
    	else if(typ.equalsIgnoreCase("CTS")) imgDesc="CT Scan";
    	else if(typ.equalsIgnoreCase("DCM")) imgDesc="Dicom Files";
    	else if(typ.equalsIgnoreCase("EEG")) imgDesc="EEG Files ";
    	else if(typ.equalsIgnoreCase("MRI")) imgDesc="MRI Files ";
    	else if(typ.equalsIgnoreCase("SEG")) imgDesc="Scanned ECG";
    	else if(typ.equalsIgnoreCase("SKP")) imgDesc="Scanned Skin Patch";
    	else if(typ.equalsIgnoreCase("SNG")) imgDesc="Sonograms";
    	else if(typ.equalsIgnoreCase("XRA")) imgDesc="X-Ray";
    	else if(typ.equalsIgnoreCase("OTH")) imgDesc="Others";
    	else if(typ.equalsIgnoreCase("DOC")) imgDesc="Documents";
    	else if(typ.equalsIgnoreCase("SND")) imgDesc="Sound Files";
    	else if(typ.equalsIgnoreCase("TEG")) imgDesc= "Text ECG";
    	else if(typ.equalsIgnoreCase("MOV")) imgDesc= "Movie Files";
		else if(typ.equalsIgnoreCase("M")) imgDesc= "Male";
		else if(typ.equalsIgnoreCase("F")) imgDesc= "Female";
		else if(typ.equalsIgnoreCase("O")) imgDesc= "Other";
		else if(typ.equalsIgnoreCase("N")) imgDesc= "Not Stated";
    	else  imgDesc=typ;
                              
    	return imgDesc;                   
    }
  public String getAgeDesc(String typ){
  		
  		String imgDesc="";
  			
  		if(typ.equalsIgnoreCase("A")) imgDesc= "Adult";
		else if(typ.equalsIgnoreCase("E")) imgDesc= "Teen";
		else if(typ.equalsIgnoreCase("C")) imgDesc= "Child";
		else if(typ.equalsIgnoreCase("T")) imgDesc= "Toddler";
		else if(typ.equalsIgnoreCase("I")) imgDesc= "Infant";
		else if(typ.equalsIgnoreCase("N")) imgDesc= "Neonate";
		else  imgDesc="Unknown"; 
		
		return imgDesc;
		
  }
    
      


 public void delAllGraphImg(String uid){
     	String fDirpath=path+"temp/"+uid+"/statimg/";
     	
     	String fBName=fDirpath+"genderbar.gif";
	 	File fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	String fPName=fDirpath+"genderpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	//////////////////	
		fBName=fDirpath+"disbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	fPName=fDirpath+"dispie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
////////
		fBName=fDirpath+"agebar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	fPName=fDirpath+"agepie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
////////
		fBName=fDirpath+"frmbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	fPName=fDirpath+"frmpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
////
		
     	fBName=fDirpath+"imgbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	fPName=fDirpath+"imgpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	//
		fBName=fDirpath+"imgvspatbar.gif";
	 	fdir = new File(fBName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
	 	fPName=fDirpath+"imgvspatpie.gif";
	 	fdir = new File(fPName);
	 	if(fdir.exists()){
			boolean yes1 = fdir.delete();
		}
////
			
	 	
	 }
	 

	 public Object getDocPatQueueInfo(String doc_id) throws RemoteException, SQLException{
		 return statServer.getDocPatQueueInfo(doc_id);
	 }

}