package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.*;
import org.json.simple.*;
import java.util.HashMap;
public class ItemlistInfo extends UnicastRemoteObject implements ItemlistInfoInterface {
		
	projinfo pinfo;
	dball mydb;
	
	public ItemlistInfo(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
    
    public Object getListOfForms(String id,String p)throws RemoteException,SQLException {
    	
	    String sqlQuery ="select distinct type,pat_id, max(date) as date,MAX(serno) as serno,"+ 
	    "forms.par_chl as par_chl  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+
	    "' AND left(type,1)='"+p+"' AND upper(par_chl) <> 'C' AND forms.name=listofforms.type group by type"; 
	   // System.out.println("getListOfForms >>* "+ sqlQuery);
	    
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
    
    public Object getListOfPrs(String id)throws RemoteException,SQLException {
     	String sqlQuery ="select pat_id,name_hos,max(entrydate) as entrydate, max(serno) as serno "+
     	"from prs where upper(pat_id)='"+id.toUpperCase()+"' group by pat_id"; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
	    
    }
    public Object getListOfTsr(String id)throws RemoteException,SQLException {
     	String sqlQuery ="select pat_id,name_hos,max(entrydate) as entrydate, max(serno) as serno "+
     	"from tsr where upper(pat_id)='"+id.toUpperCase()+"' group by pat_id"; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }


    public Object getListOfImages(String id) throws RemoteException,SQLException{
     	
     	String sqlQuery ="select distinct type,max(entrydate)as b from patimages "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+
     	" AND (formkey is NULL ) and type<>'dcm'  group by type"; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
    
    public Object getListOfImagesDtl(String id,String type, String dt1,String dt2) throws 
    RemoteException,SQLException{
    	String sqlQuery ="select pat_id,entrydate,con_type,serno,type,ext,imgdesc,doc_name,lab_name from patimages "+
    	"where Upper(pat_id)= '" + id.toUpperCase() + 
    	"' AND formkey is NULL AND type = '"+type+
    	"' AND (entrydate >='"+dt1+"' AND entrydate < '"+dt2+"') Order By type, serno"; 
    	// dball mydb= new dball(pinfo);    
	    return mydb.ExecuteQuary(sqlQuery);
    }
     
     
    public Object getListOfVectors(String id) throws RemoteException,SQLException{
    	
    	String sqlQuery ="select points,pat_id, entrydate, type, serno from coord "+
    	"where lower(pat_id)= '"+id.toLowerCase()+"' and type = 'crd' Order By type, serno"; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    
    }
    
    public Object getListOfVectorsDtl(String id) throws RemoteException,SQLException{
    	return new Object();
    }
     
     
    public Object getListOfDicoms(String id) throws RemoteException,SQLException{
    	String sqlQuery ="select distinct type,max(entrydate)as b from patimages "+
    	"where Upper(pat_id)='"+id.toUpperCase()+"' and type='dcm' group by type" ; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
    
    public Object getListOfDicomsDtl(String id, String dt1,String dt2) throws RemoteException,
    SQLException{	
    	String sqlQuery ="select pat_id,entrydate,con_type,serno,type,imgdesc,lab_name,doc_name from patimages "+
    	"where pat_id= '" + id.toUpperCase() + 
    	"' AND formkey is NULL AND type = 'dcm' AND (entrydate >='"+
    	dt1+"' AND entrydate < '"+dt2+"') Order By type, serno "; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
     
    public Object getListOfDocuments(String id) throws RemoteException,SQLException{
    	String sqlQuery = "select distinct type, max(entrydate)as b from patdoc "+
    	"where pat_id='"+id.toUpperCase()+"' group by type" ; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
    
    public Object getListOfDocumentsDtl(String id,String type, String dt1,String dt2) throws 
    RemoteException,SQLException{
    	String sqlQuery = "select pat_id,entrydate,con_type,serno,type,docdesc,doc_name,lab_name from patdoc "+
    	"where pat_id= '" + id.toUpperCase() + "' AND type = '"+type+
    	"' AND (entrydate >='"+dt1+"' AND entrydate < '"+dt2+"') Order By type, serno" ; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
     
     
    public Object getListOfMovies(String id) throws RemoteException,SQLException{
    	String sqlQuery = "select distinct max(entrydate) as b, entrydate from patmovies "+
    	"where Upper(pat_id)='"+id.toUpperCase()+"' and formkey is NULL group by type" ; 
	   // dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
    }
    
    public Object getListOfMoviesDtl(String id, String dt1,String dt2) throws RemoteException,
    SQLException{
    	String sqlQuery = "select pat_id,entrydate,con_type,serno,type,movdesc,lab_name,doc_name from patmovies where Upper(pat_id)= '" + id.toUpperCase() + 
    	"' AND formkey is NULL AND upper(type) = 'MOV' AND (entrydate >='"+dt1+"' AND entrydate < '"+dt2+"') Order By type, serno" ; 
    	//System.out.println(sqlQuery);
    	// dball mydb= new dball(pinfo);
	    return mydb.ExecuteQuary(sqlQuery);
	}
	    
     public Object getVisitWiseInfo(String id) throws RemoteException,SQLException{
     
     	dataobj output = new dataobj();
     	int count = 0;
                
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
				
		 //String qSql="select distinct date(visitdate) as visitdate from patientvisit where pat_id='"+ id +"' order by visitdate desc";
		 String qSql="select visitdate from patientvisit where upper(pat_id)= '"+id.toUpperCase()+ "' order by visitdate desc";
     	Object res = mydb.ExecuteQuary(qSql);	
     	
	//	System.out.println("qSql ::::: "+qSql);
		
		
       	if(res instanceof String){
        	System.out.println("res ::::: "+res);
        }else{
	       	Vector tmpv = (Vector)res;
	       //	System.out.println("tmpv.size  ::::: " + tmpv.size());
	       	
			if(tmpv.size()>0){
				String dt2=myDate.getCurrentDate("ymd",true);
				try{
					//java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dt2);
					java.util.Date dat = new java.util.Date();
					c1.setTime(dat);
					c1.add(Calendar.DATE,1);
					dt2=sdf.format(c1.getTime());
				//	System.out.println("\nNew dt2 :::"+dt2);
					
				}catch(Exception e){
						System.out.println("\n Error ::: "+e.toString());
				}
				
				String pvyear="";
				
				for(int i=0;i<tmpv.size();i++){
					dataobj tmpdata = (dataobj) tmpv.get(i);
					String pdt = tmpdata.getValue("visitdate");
					
					System.out.println("visitdate>>"+pdt);
					
					String dt1 = pdt.substring(0,4)+"/"+pdt.substring(5,7)+"/"+pdt.substring(8);
					String dtdmy = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String year = pdt.substring(0,4);
					
					if(!pvyear.equalsIgnoreCase(year)){
						output.add("year", year);
						pvyear=year;
					}
					System.out.println("visitdate>>"+pdt);
						
					String tempstr = getFormsList(id, dt1, dt2);
					tempstr += getImagesList(id, dt1, dt2);
					tempstr += getDicomList(id, dt1, dt2);
					tempstr += getDocList(id, dt1, dt2);
					tempstr += getMoviesList(id, dt1, dt2);
					dt2=dt1;
					output.add("Visit On "+dtdmy, tempstr);
				}		
			}
		} //else
		 
     return output;	
     }
     
     public String getFormsList(String id,String dt1, String dt2) throws RemoteException,SQLException{
		
 		String output = "", wprn;
		String code,frmView,altTag="",date1="",date2="";
		int cnt=1;
		
		String [] priority = new String [10];
		priority[0]="m";
		priority[1]="h";
		priority[2]="p";
		priority[3]="k";
		priority[4]="i";
		priority[5]="s";
		priority[6]="d";
		priority[7]="t";
	    priority[8]="a";
		priority[9]="c";

	    output += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";
        for(int pr=0;pr<=9;pr++){
        	
        //System.out.println("\n priority >>: "+ pr+">>" + priority[pr]+"\n");
        	
		String  qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority[pr].toUpperCase()+"' group by type) and serno in (select max(serno) from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority[pr]+"' and date >= '"+dt1+"' and date < '"+dt2+"' group by type) and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"'"; 
	
		System.out.println("\ngetFormsList >>:" + qSql);
        
       Object res = mydb.ExecuteQuary(qSql);	
        
       if(res instanceof String){
       	
       }else{
	       	Vector tmpv = (Vector)res;
	       	//System.out.println("getFormsList tmpv size >>:" + tmpv.size());
			if(tmpv.size()>0){
								
				for(int i=0;i<tmpv.size();i++){
				dataobj tmpdata = (dataobj) tmpv.get(i);
							
				String pcn=tmpdata.getValue("par_chl");
				String pdt = tmpdata.getValue("date");
				String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
				String pty = tmpdata.getValue("type").toLowerCase();
				String psl = tmpdata.getValue("serno");
				String dsl=psl;
				if (psl.length()<2) dsl = "0" + psl;
				pdt=pdt.replace('-','/');
				
				altTag =tmpdata.getValue(10)+ ", Entry Date : (" + dt + ")";
                  
					if(pcn.trim().equalsIgnoreCase("P") || pcn.trim().equalsIgnoreCase("N"))
					{
						if(pcn.trim().equalsIgnoreCase("N"))
						{
							if(pty.equalsIgnoreCase("MED"))
								wprn = "<A class='"+pty+"' HREF='displaymed.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target='_blank' Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";
							//else if(pty.equalsIgnoreCase("A02"))
							//	wprn = "<A HREF='../phivjsp/medication.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target=content2 Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";
							else
								wprn = "<A class='"+pty+"' HREF='writevaltext.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target='_blank' Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";

						}else{
								wprn = "<A class='"+pty+"' HREF='writeval2.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target='_blank' Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";
						}
					
						output +="<TD BackGround='../images/formicon.jpg' Width=30 Height=35 Valign=Bottom>"+wprn+"</TD>";
						
						//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
						cnt=cnt+1;
					} // if p 
			
				if (cnt>4) {
					//out.println( "</TR><TR>");
					output +="</TR><TR>";
					cnt=1;
					}
				} // for 
		
			
			} // if
				
		} // else
			     
  	 } // while
  	 output +="</Table>";
     	return output;	
     }

     public String getImagesList(String id,String dt1, String dt2) throws RemoteException,SQLException{
    	
    	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
		
    	String qSql ="select distinct type,max(entrydate)as b from patimages "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') AND (formkey is NULL ) and type<>'dcm'  group by type"; 
	   Object res = mydb.ExecuteQuary(qSql);	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
	
	
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			
			Object res1=getListOfImagesDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String fdt=dt.replaceAll("/","");
						
						//String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String pty = tmpdata1.getValue("type").trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						
						String cnttype = tmpdata1.getValue("con_type").trim();
						String ext = tmpdata1.getValue("ext").trim();
							
						if (psl.length()<2) dsl = "0" + psl;
						
						if(pty.equalsIgnoreCase("TEG")){
							wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&id="+pid+"&ty="+pty+"&ser="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' Target='_blank'>ECG"+dsl+"</A>";
							output+="<TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}else{
							if(cnttype.equalsIgnoreCase("LRGFILE")){
								String fname=pid+fdt+pty+psl+"."+ext;
								String fpath="../data/"+id+"/"+fname;
		
								wprn="<IMG SRC='"+fpath+"' Width=25 Height=30 >";
								output+="<TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD>";
							}else{
								wprn="<IMG SRC='displayimg.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Width=25 Height=30 >";
								output+="<TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&sn="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD>";	
							}
							
						}

					cnt=cnt+1;
					if (cnt>4) {
						output += "</TR><TR>";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</Table>";
       	}//if
       }
	}catch(Exception e){}
	 return output;
	
     }
     
     public String getDicomList(String id,String dt1, String dt2) throws RemoteException,SQLException{
     
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
			   
    	String qSql ="select distinct type,max(entrydate)as b from patimages "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') AND (formkey is NULL ) and Upper(type)='DCM'  group by type"; 
	   
	   Object res = mydb.ExecuteQuary(qSql);	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
			
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfDicomsDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
						
						wprn = "<A HREF='showdicom.jsp?mtype=nomark&id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>"; 
						output+="<TD BackGround='../images/dicom.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
				
					cnt=cnt+1;
					if (cnt>4) {
						output += "</TR><TR>";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</Table>";
       	}//if
       }
	}catch(Exception e){}
	
     return output;
     	
     }
     
     public String getDocList(String id,String dt1, String dt2) throws RemoteException,SQLException{
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
	    			   
    	String qSql ="select distinct type,max(entrydate)as b from patdoc "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') group by type"; 
	   
	   Object res = mydb.ExecuteQuary(qSql);	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfDocumentsDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
											
						if(pty.equalsIgnoreCase("TEG")){
							wprn = "<A Href=\'showecg.jsp?patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' target='_blank'>ECG"+dsl+"</A>";
							output+="<TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}else if (pty.equalsIgnoreCase("snd")) {
							wprn = "<A HREF='playsound.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>"; 
							output+="<TD BackGround='../images/sound.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}else if (pty.equalsIgnoreCase("doc")) {
							wprn = "<A HREF='docframes.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>"; 
							output+="<TD BackGround='../images/doc.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}
					
					cnt=cnt+1;
					if (cnt>4) {
						output += "</TR><TR>";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</Table>";
       	}//if
       }
	}catch(Exception e){}
	
     return output;
     }
     
     public String getMoviesList(String id,String dt1, String dt2) throws RemoteException,SQLException{
     
     
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
	    
	    String qSql ="select distinct type,max(entrydate)as b from patmovies "+
     	"where Upper(pat_id)='"+id.toUpperCase()+
     	"' AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') and formkey is NULL group by type" ; 
	   
	   Object res = mydb.ExecuteQuary(qSql);	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfMoviesDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
											
						if (pty.equalsIgnoreCase("mov")) {
							wprn="<A HREF='viewmovie.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>";
							output+="<TD BackGround='../images/video.jpg' Width=35 Height=35 Valign=Bottom>" + wprn + "</TD>";
						}
					
					cnt=cnt+1;
					if (cnt>4) {
						output += "</TR><TR>";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</Table>";
       	}//if
       }
	}catch(Exception e){}
	
     return output;
     
     }
     
      public Object getRadiologyCount(String id) throws RemoteException,SQLException{
      	String qSql="SELECT modality, count(*) FROM i30 WHERE pat_id ='"+id+"' AND modality IN ('XRA', 'MRI', 'CTS', 'SNG') GROUP BY modality";
      	return mydb.ExecuteQuary(qSql);	
      }
     
      public Object getRadiologyInfo(String id,String radiotype) throws RemoteException,SQLException{
	  	String qSql= "SELECT pat_id, entrydate, 'i30', serno, testdate, study_purpose, modality FROM i30 WHERE modality ='"+radiotype+"' AND pat_id ='"+id+"'";  
    	//System.out.println("getRadiologyInfo\n"+qSql);
    	return mydb.ExecuteQuary(qSql);	
    	
      	
      }




/* new Edition for New GUI 15/07/2018*/

    public String getImageDesc(String typ){
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
    	else  imgDesc="Unknown";    
    	                             
    	return imgDesc;                   
    }



    public Object getVisitList(String id) throws RemoteException,SQLException{
		HashMap<String, Object> array = new HashMap<String, Object>();
     	dataobj output = new dataobj();
     	int count = 0;
                
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		Calendar c1 = Calendar.getInstance();
				
		String qSql="select distinct date(visitdate) as visitdate from patientvisit where pat_id='"+ id +"' order by visitdate desc";
		 //String qSql="select date(visitdate) from patientvisit where upper(pat_id)= '"+id.toUpperCase()+ "' order by visitdate desc";
     	Object res = mydb.ExecuteQuary(qSql);	
     	/*
		System.out.println("qSql ::::: "+qSql);
		
		
       	if(res instanceof String){
        	System.out.println("res ::::: "+res);
        }else{
	       	Vector tmpv = (Vector)res;
	       //	System.out.println("tmpv.size  ::::: " + tmpv.size());
	       	
			if(tmpv.size()>0){
				String dt2=myDate.getCurrentDate("ymd",true);
				try{
					//java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dt2);
					java.util.Date dat = new java.util.Date();
					c1.setTime(dat);
					c1.add(Calendar.DATE,1);
					dt2=sdf.format(c1.getTime());
				//	System.out.println("\nNew dt2 :::"+dt2);
					
				}catch(Exception e){
						System.out.println("\n Error ::: "+e.toString());
				}
				
				String pvyear="";
				
				for(int i=0;i<tmpv.size();i++){
					dataobj tmpdata = (dataobj) tmpv.get(i);
					String pdt = tmpdata.getValue("visitdate");
					String prevdt="";
					System.out.println("visitdate>>"+pdt);
					
					String dt1 = pdt.substring(0,4)+"/"+pdt.substring(5,7)+"/"+pdt.substring(8);
					String dtdmy = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String year = pdt.substring(0,4);
					if(i>0)
					{
						dataobj tmpdata2 = (dataobj) tmpv.get(i-1);
						String pdt2 = tmpdata.getValue("visitdate");
						prevdt = pdt2.substring(0,4)+"/"+pdt2.substring(5,7)+"/"+pdt2.substring(8);
					}
					
					if(!pvyear.equalsIgnoreCase(year)){
						//output.add("year", year);
						array.put("year",year);
						pvyear=year;
					}
					System.out.println("visitdate>>"+pdt);
					
					//ArrayList<Object> array=new ArrayList<Object>();
					array.put("ImageList",getImagesListTable(id, dt1, dt2));
					array.put("DicomList",getDicomListTable(id, dt1, dt2));
					array.put("DocList",getDocListTable(id, dt1, dt2));
					array.put("MovieList",getMoviesListTable(id, dt1, dt2));
					array.put("AdviceList_a",getAdvicedListTable(id,dt1,dt2,"a"));
					array.put("AdviceList_p",getAdvicedListTable(id,dt1,dt2,"p"));
					array.put("dt1",dt1);
					array.put("dt2",dt2);				
					



					JSONObject obj = new JSONObject();
					obj.put("ImageList",getImagesListTable(id, dt1, dt2));
					obj.put("DicomList",getDicomListTable(id, dt1, dt2));
					obj.put("DocList",getDocListTable(id, dt1, dt2));
					obj.put("MovieList",getMoviesListTable(id, dt1, dt2));
					obj.put("AdviceList_a",getAdvicedListTable(id,dt1,dt2,"a"));
					obj.put("AdviceList_p",getAdvicedListTable(id,dt1,dt2,"p"));
					System.out.println("-------------------\n"+obj.toString()+"-------------------\n");
					
					//String tempstr = getFormsList(id, dt1, dt2);
					String tempstr = "<div class='advisedTest "+dt1.replaceAll("/","")+"'></div>";
					tempstr += getImagesListTable(id, dt1, dt2);
					tempstr += getDicomListTable(id, dt1, dt2);
					tempstr += getDocListTable(id, dt1, dt2);
					tempstr += getMoviesListTable(id, dt1, dt2);
					tempstr += getAdvicedListTable(id,dt1,dt2,"a");
					tempstr += getAdvicedListTable(id,dt1,dt2,"p");
					array.put("visiton",dtdmy);	
					dt2=dt1;
					//output.add("Visit On "+dtdmy, obj.toString());
					System.out.println("-----------------------------------------------------");
					System.out.println("Visit On "+dtdmy);
				}		
			}
		} //else
		 */
     return res;	
     }

     public Object getImagesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
    	
    	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	//try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
		
    	String qSql ="select distinct type,max(entrydate)as b from patimages "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') AND (formkey is NULL ) and type<>'dcm'  group by type"; 
	   Object res = mydb.ExecuteQuary(qSql);
	   /*	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<div class='table-responsive'><table class='visitRecList images table table-bordered'><thead><tr><td colspan='5' align='center'>Images</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
	
	
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			
			Object res1=getListOfImagesDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String fdt=dt.replaceAll("/","");
						
						//String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String pty = tmpdata1.getValue("type").trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						
						String reportName = getImageDesc(pty);
						
						String cnttype = tmpdata1.getValue("con_type").trim();
						String ext = tmpdata1.getValue("ext").trim();
					
						String imgdesc = tmpdata1.getValue("imgdesc").trim();		
						String doc_name = tmpdata1.getValue("doc_name").trim();		
						String lab_name = tmpdata1.getValue("lab_name").trim();		
							
						if (psl.length()<2) dsl = "0" + psl;
						
						if(pty.equalsIgnoreCase("TEG")){
							wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&id="+pid+"&ty="+pty+"&ser="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' Target='_blank'>ECG"+dsl+"</A>";
							output+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD></tr>";
						}else{
							if(cnttype.equalsIgnoreCase("LRGFILE")){
								String fname=pid+fdt+pty+psl+"."+ext;
								String fpath="../data/"+id+"/"+fname;
		
								wprn="<IMG SRC='"+fpath+"' Width=25 Height=30 >";
								output+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD></tr>";
							}else{
								wprn="<IMG SRC='displayimg.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Width=25 Height=30 >";
								output+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&sn="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD></tr>";	
							}
							
						}

					cnt=cnt+1;
					if (cnt>4) {
						output += "";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</tbody></table></div>";
       	}//if
	   }*/
	   return res;/*
	}catch(Exception e){}
	 return output;*/
	
     }

    public Object getDocListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	//try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
	    			   
    	String qSql ="select distinct type,max(entrydate)as b from patdoc "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') group by type"; 
	   
	   Object res = mydb.ExecuteQuary(qSql);
	   /*	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<div class='table-responsive'><table class='visitRecList documents table table-bordered'><thead><tr><td colspan='5' align='center'>Documents</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfDocumentsDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						
						String reportName = getImageDesc(pty);
						String docdesc = tmpdata1.getValue("docdesc").trim();		
						String doc_name = tmpdata1.getValue("doc_name").trim();		
						String lab_name = tmpdata1.getValue("lab_name").trim();	
						
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
											
						if(pty.equalsIgnoreCase("TEG")){
							wprn = "<A Href=\'showecg.jsp?patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold;' target='_blank'>ECG"+dsl+"</A>";
							output+="<tr><td>"+reportName+"</td><td>"+docdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}else if (pty.equalsIgnoreCase("snd")) {
							wprn = "<A HREF='playsound.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold;' target='_blank'>"+pty+dsl+"</A>"; 
							output+="<tr><td>"+reportName+"</td><td>"+docdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/sound.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}else if (pty.equalsIgnoreCase("doc")) {
							wprn = "<A HREF='docframes.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold;' target='_blank'>"+pty+dsl+"</A>"; 
							output+="<tr><td>"+reportName+"</td><td>"+docdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/doc.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
						}
					
					cnt=cnt+1;
					if (cnt>4) {
						output += "";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</tbody></table></div>";
       	}//if
	   }
	   */
	  return res;/*
	}catch(Exception e){}
	
     return output;*/
     }
     
     public Object getMoviesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
     
     
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    	//try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
	    
	    String qSql ="select distinct type,max(entrydate)as b from patmovies "+
     	"where Upper(pat_id)='"+id.toUpperCase()+
     	"' AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') and formkey is NULL group by type" ; 
	   
	   Object res = mydb.ExecuteQuary(qSql);
	   /*	
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<div class='table-responsive'><table class='visitRecList videos table table-bordered'><thead><tr><td colspan='5' align='center'>videos</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfMoviesDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						
						String reportName = getImageDesc(pty);
						String movdesc = tmpdata1.getValue("movdesc").trim();		
						String doc_name = tmpdata1.getValue("doc_name").trim();		
						String lab_name = tmpdata1.getValue("lab_name").trim();	
						
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
											
						if (pty.equalsIgnoreCase("mov")) {
							wprn="<A HREF='viewmovie.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none; font:Tahoma; font-weight:bold;' target='_blank'>"+pty+dsl+"</A>";
							output+="<tr><td>"+reportName+"</td><td>"+movdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/video.jpg' Width=35 Height=35 Valign=Bottom>" + wprn + "</TD>";
						}
					
					cnt=cnt+1;
					if (cnt>4) {
						output += "";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</tbody></table></div>";
       	}//if
	   }*/
	   return res;/*
	}catch(Exception e){}
	
     return output;*/
     
     }

     public Object getDicomListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
     
     	String maxendt="",maxendt1="",wprn="";
    	String output="";
    	int cnt=1;
    	
    //	try{
    	
    //	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	//	Calendar c1 = Calendar.getInstance(); 
			   
    	String qSql ="select distinct type,max(entrydate)as b from patimages "+
     	"where Upper(pat_id)='"+id.toUpperCase()+"'"+ 
     	" AND (entrydate >='"+dt1+"' AND entrydate <= '"+dt2+"') AND (formkey is NULL ) and Upper(type)='DCM'  group by type"; 
	   
	   Object res = mydb.ExecuteQuary(qSql);
		/*
       if(res instanceof String){
       	       
       }else{
       	Vector tmpv = (Vector)res;
		if(tmpv.size()>0){
		output += "<div class='table-responsive'><table class='visitRecList dicoms table table-bordered'><thead><tr><td colspan='5' align='center'>DICOM</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";
				
       	for(int i=0;i<tmpv.size();i++){
       		
			dataobj tmpdata = (dataobj) tmpv.get(i);
			
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());
			
			Object res1=getListOfDicomsDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						
						String reportName = getImageDesc(pty);
						String imgdesc = tmpdata1.getValue("imgdesc").trim();		
						String doc_name = tmpdata1.getValue("doc_name").trim();		
						String lab_name = tmpdata1.getValue("lab_name").trim();	
												
						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;
						
						wprn = "<A HREF='showdicom.jsp?mtype=nomark&id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; ' target='_blank'>"+pty+dsl+"</A>"; 
						output+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/dicom.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD>";
				
					cnt=cnt+1;
					if (cnt>4) {
						output += "";
						cnt=1;
					}
			} //end of for1
       
       	  }// for
       	output +="</tbody></table></div>";
       	}//if
	   }
	   */
	  return res;/*
	}catch(Exception e){}
	
     return output;*/
     	
     }

     public Object getAdvicedListTable(String id,String dt1, String dt2,String priority) throws RemoteException,SQLException{
		
 		String output = "", wprn;
		String code,frmView,altTag="",date1="",date2="";
		int cnt=1;
		/*
		String [] priority = new String [2];
	    priority[0]="a";
		priority[1]="p";
		
		int pr=0;
        */	
        //System.out.println("\n priority >>: "+ pr+">>" + priority[pr]+"\n");
       //for(pr=0;pr<=1;pr++){	
		//String  qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority[pr].toUpperCase()+"' group by type) and serno in (select max(serno) from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority[pr]+"' and date >= '"+dt1+"' and date < '"+dt2+"' group by type) and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"'"; 
		String  qSql="";
		
		if(priority.equalsIgnoreCase("p"))
		{
			//qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority.toUpperCase()+"' group by type) and serno in (select serno from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority+"' and date >= '"+dt1+"' and date < '"+dt2+"' group by type) and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"' order by serno desc"; 
			qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority.toUpperCase()+"' group by type) and serno in (select serno from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority+"' and date >= '"+dt1+"' and date < '"+dt2+"') and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"' order by serno desc"; 
		}
		else 
		{
			//qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority.toUpperCase()+"' group by type) and serno in (select max(serno) from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority+"' and date >= '"+dt1+"' and date < '"+dt2+"' group by type) and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"'"; 
			qSql= "select distinct listofforms.*,forms.par_chl,forms.description  from listofforms,forms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(par_chl) <>'C' and type in(select distinct type from listofforms where upper(pat_id)= '"+id.toUpperCase()+ "' and upper(left(type,1))='"+priority.toUpperCase()+"' group by type) and serno in (select max(serno) from listofforms where upper(pat_id)= '"+id.toUpperCase()+"' and left(type,1)='"+priority+"' and date >= '"+dt1+"' and date < '"+dt2+"') and forms.name=listofforms.type and date >= '"+dt1+"' and date < '"+dt2+"'"; 
		}
		System.out.println("\ngetFormsList >>:" + qSql);
        
       Object res = mydb.ExecuteQuary(qSql);	
        /*
       if(res instanceof String){
       	
       }else{


			   System.out.println(dt1+"------"+dt2);
			   Vector tmpv = (Vector)res;
			   //Vector Dt=(Vector)vis;
			   //int count=0;
	       	//System.out.println("getFormsList tmpv size >>:" + tmpv.size());
			if(tmpv.size()>0){
								
				for(int i=0;i<tmpv.size();i++){
				dataobj tmpdata = (dataobj) tmpv.get(i);
							
				String pcn=tmpdata.getValue("par_chl");
				String pdt = tmpdata.getValue("date");
				String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
				String pty = tmpdata.getValue("type").toLowerCase();
				String psl = tmpdata.getValue("serno");
				String dsl=psl;
				if (psl.length()<2) dsl = "0" + psl;
				pdt=pdt.replace('-','/');
				
				altTag =tmpdata.getValue(10)+ ", Entry Date : (" + dt + ")";
                  
					if(pcn.trim().equalsIgnoreCase("P") || pcn.trim().equalsIgnoreCase("N"))
					{
						
						if(pty.equalsIgnoreCase("pre")){
							wprn = "<script>$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
						
							output +=wprn;
							
							//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
							cnt=cnt+1;
						}
						if(pty.equalsIgnoreCase("prs")){
							wprn = "<script>$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
						
							output +=wprn;
							
							//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
							cnt=cnt+1;
						}						
						
						//wprn = "<A class='"+pty+"' HREF='writevaltext.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target=content2 Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";
						if(pty.equalsIgnoreCase("ai0")){
							

							//wprn = "<script>$.get('ai0.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
							wprn = "<script>$.get('ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
							
							output +=wprn;
							
							//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
							cnt=cnt+1;
						}
					} // if p 
			
				if (cnt>4) {
					//out.println( "</TR><TR>");
					output +="";
					cnt=1;
					}
				} // for 
		
			
			} // if
				
		} // else
		
	//}     
		 return output;*/
		 return res;	
     }


/* New edition for new GUI END */    
    
}
