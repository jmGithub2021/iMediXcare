
package imedix;

import java.io.*;
import java.sql.*;
import java.util.*;

public class uploadtodb{
	String bkpdir="",discat="";
	projinfo pinfo;
	
	public uploadtodb(String bdir, projinfo prjinf){
		bkpdir=bdir;
		pinfo=prjinf;
	}
		
		
	public void StratUpload(){
		File backupdir = new File(pinfo.tempdatadir+"/backup/"+bkpdir);
		//File pardir = ccodedir; 
		boolean exists = backupdir.exists();
		if(exists==true){
			String[] childlevel1 = backupdir.list();
			if( ! backupdir.isDirectory() || childlevel1.length <= 0 ){
            	System.err.println("Info:: Directory Empty: "+backupdir);
            	 backupdir.delete();
        	}

			for(int ii=0;  ii < childlevel1.length; ii++){
				File pdir=new File(backupdir,childlevel1[ii]);
				if(pdir.isDirectory())
				{	
					String dnf=pdir.getName();
					System.out.println("dnf : "+dnf);
					if(dnf.length()>=12){ 
						updatetodb(pdir);
					
					//	updatetele(df); // will modify 

						try{
							String fileList[] = pdir.list();
							System.out.println(" Length : "+pdir.list().length);	
							for(int i=pdir.list().length-1;i>=0;i--){
								File childFile = new File(pdir,fileList[i]);	

								/*if(childFile.isDirectory() && childFile.list().length<=0){
									boolean sts = childFile.delete();
									System.out.println("ChildfileStatus : "+sts+" : "+childFile+ " :: "+fileList[i]);	
								}
								else{
									System.out.println("Else : "+childFile+ " :: "+fileList[i]);
									}*/
									try{
									if(childFile.isDirectory()){
										if(childFile.list().length<=0){
											boolean sts = childFile.delete();	
											System.out.println("ddd : "+i+" : "+childFile.list().length+" : "+fileList[i]);
										}
									}
									}catch(Exception ex){System.out.println("Er00909: "+ex.toString());}

							}	
							boolean pd=pdir.delete();
							if(pd==true){
								File chkBackupdir = new File(pinfo.tempdatadir+"/backup/"+bkpdir);
							System.out.println(pd +" : gg : "+chkBackupdir.list().length +" : "+childlevel1[ii]);
								if(chkBackupdir.list().length <= 0)
									chkBackupdir.delete();
							}
							System.out.println("Status : "+pd);
								
						}catch(Exception ex){System.out.println("ERROR052213 : "+ex+" : "+pdir );}			
					}
					
				}
				}
		}
	}
	
	/*

	private void updatetele(File dnfile)
	{
		String GblStr="",dnname="",pid="",entrydt="";;
		int GblIndex=0;
		dnname=dnfile.getName();
		System.out.println(dnname);
		//NRSH1912070008
		pid=dnname.substring(0,14);
		entrydt=dnname.substring(4,10);
		entrydt="20"+entrydt.substring(4)+"/"+entrydt.substring(2,4)+"/"+entrydt.substring(0,2);
		try
		{
			FileInputStream dnfin = new FileInputStream(dnfile);

			do{
				GblIndex = dnfin.read();
				GblStr = GblStr + (char) GblIndex;
			}while(GblIndex != -1);
			dnfin.close();
			String dnlines[]=GblStr.split("\n");
			
			String sendTo_doc = dnlines[0].substring(dnlines[0].indexOf("=^")+2);
			
			String sent_by= dnlines[1].substring(dnlines[1].indexOf("=^")+2);
			String referring_doc= dnlines[2].substring(dnlines[2].indexOf("=^")+2);
			String document_list= dnlines[3].substring(dnlines[3].indexOf("=^")+2);
			String Date= dnlines[4].substring(dnlines[4].indexOf("=^")+2);
			String Time= dnlines[5].substring(dnlines[5].indexOf("=^")+2);			
			//1/14/2008
			String teleDt=myDate.getCurrentDate("ymd",true);
					
			String dnsql="insert into tpatq (pat_id,entrydate,teleconsultdt,assigneddoc,refer_doc,refer_center,discategory,checked,delflag)";
			
			dnsql =dnsql+" VALUES('"+pid+"','"+entrydt+"','"+teleDt+"','"+sendTo_doc+"','"+referring_doc+"','"+pid.substring(0,4)+"','"+discat+"','N','N')";
			
			String delqr="delete from tpatq where pat_id="+"'"+pid+"'";
			 ExecuteSql(delqr);
			 ExecuteSql(dnsql);
		 }
		 catch(IOException dnex){ 
		 	System.out.println("Error in reading done file :"+dnex.toString());
		 }
}

*/


	
	private void updatetodb(File dlist1){
									
				if(dlist1.isDirectory())
				{
					String[] clevel1 = dlist1.list();
					for(int jj=0;  jj < clevel1.length; jj++){
					File dlist2=new File(dlist1,clevel1[jj]);
					
					System.out.println("**********clevel1 :="+clevel1);
					System.out.println("clevel1[jj] = " + clevel1[jj]);
					
					  	if(dlist2.isDirectory() && clevel1[jj].equalsIgnoreCase("forms"))
						{
							//String forms[]=dlist2.list();
							//for(int p=0;p<forms.length;p++)
							//System.out.println("=====forms are :"+forms[p]);

							String[] frmlist = dlist2.list();
							if(frmlist.length >0)
							{
								updateforms(dlist2);
							}
						}
						
						if(dlist2.isDirectory() && clevel1[jj].equalsIgnoreCase("images"))
						{
							
							//String rdir[]=dlist2.list();
							//for(int g=0;g<rdir.length;g++)
							//System.out.println("======images are :"+rdir[g]);
							
							
							String[] imglist = dlist2.list();
							if(imglist.length >1)
							{
								System.out.println("******======images Name :"+dlist2.getName());
								updateimages(dlist2);
							}
							
						} // end of if
												
						if(dlist2.isDirectory() && clevel1[jj].equalsIgnoreCase("refimages"))
						{
							//String rdir[]=dlist2.list();
							//for(int g=0;g<rdir.length;g++)
							//System.out.println("========ref images are :"+rdir[g]);
							
							String[] reflist = dlist2.list();
							if(reflist.length >1)
							{
								updateimages(dlist2);
							}
							
						} // end of if
						
						if(dlist2.isDirectory() && clevel1[jj].equalsIgnoreCase("docs"))
						{
							//String doc[]=dlist2.list();
							//for(int p=0;p<doc.length;p++)
							//System.out.println("=======doc are :"+doc[p]);
							
							String[] doclist = dlist2.list();
							if(doclist.length >1)
							{
								updateimages(dlist2);
							}
						} // end of if
						
						if(dlist2.isDirectory() && clevel1[jj].equalsIgnoreCase("movies"))
						{
							//String doc[]=dlist2.list();
							//for(int p=0;p<doc.length;p++)
							//System.out.println("=====mov are :"+doc[p]);
							
							String[] movlist = dlist2.list();
							if(movlist.length >1)
							{
							updateimages(dlist2);
							}
						} // end of if
						

					} // end of for loop
				} //end of idDirectory function
				
				
} // end of function


private void updateforms(File allfile){
	
	BufferedReader br = null;
	String frmdir="";
	int GblIndex1=0;
	int GblCount1=0, c1=0;
	String GblStr1="",fieldname="",val="",v1="",tname="",isql="",rpatid="",edate="",frmserno="",lfrmsql="",telesql="",hosname="",delqr="",delqrfl="";
		
	frmdir=allfile.getName();
	
	if(allfile.isDirectory() && frmdir.equals("forms"))
	{
		File frmfile[]=allfile.listFiles();
		for(int j=0;j<frmfile.length;j++)
		{
			v1=frmfile[j].getName();
			System.out.println("Name V1:"+v1);
			//VHOS0901080002 09012008 i00 00.form
			
			
			rpatid=v1.substring(0,18);
			edate=v1.substring(18,32);
			edate=edate.substring(4,8)+"/"+edate.substring(2,4)+"/"+edate.substring(0,2)+" "+edate.substring(8,10)+":"+edate.substring(10,12)+":"+edate.substring(12,14);

			tname=v1.substring(32,35);
			frmserno=v1.substring(35,37);
			System.out.println(tname+" edate : "+edate);
			
			String qr="select * from "+tname;
			try
			{
				String token = FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				String key="",tval="",fldnm="",fldval="",tmpval="";;
							
				boolean dis=false;
				//FileInputStream frmfin = new FileInputStream(frmfile[j]);
				FileReader fis = new FileReader (frmfile[j]);
				br = new BufferedReader (fis);
				fieldname="";
				val="";
				String line=null; 
								
				if(!tname.equalsIgnoreCase("med"))
				 {
				  key = st.nextToken();
				  tval = st.nextToken();
				  fieldname=fieldname+"pat_id,";
				  val=val+"\'"+rpatid+"',";
				 }
				
				
				while ((line = br.readLine()) != null){
					if (line.trim() == "") continue;  //If a blank line is encountered skip that line
					
					int eqPos = line.indexOf("=");
	                if (eqPos <= 0)
	                {
	                    val=val.substring(0,val.lastIndexOf("'"))+"\n" + line.trim() + "',";
	                }	                
	                else{
	                	line=line.trim();
						key = st.nextToken();
						tval = st.nextToken();
						fldnm=line.substring(0,line.lastIndexOf("="));
						fldval=line.substring(line.lastIndexOf("=")+1);
						
						if(tname.equalsIgnoreCase("med")){
							if (fldnm.equalsIgnoreCase("class")){
								discat= fldval;
							}
						}
						//System.out.println("fldnm :"+fldnm +"="+ key +":"+key +" = fldval:"+fldval);
						
						if(fldnm.equalsIgnoreCase("long")){
							fldnm="longs";
						}
						if(fldnm.equalsIgnoreCase("interval")){
							fldnm="intervals";
						}
						if(fldnm.equalsIgnoreCase("character")){
							fldnm="characters";
						}
						
						////////////
						
						if(fldnm.equalsIgnoreCase(key)){
							fieldname=fieldname+key+",";
							if(fldval.length()>0){
								if(tval.equals("CHAR")||tval.equals("VARCHAR")||tval.equals("DATETIME")||tval.equals("DATE")||tval.equals("TEXT") || tval.equalsIgnoreCase("TIMESTAMP"))
								{
									if(tval.equals("DATE") || tval.equals("DATETIME") || tval.equalsIgnoreCase("TIMESTAMP")){
										System.out.println("etdt : "+fldval);
										if(fldval.length()>1)
										{
											fldval=fldval.substring(4,8)+"-"+fldval.substring(2,4)+"-"+fldval.substring(0,2)+" "+fldval.substring(8,10)+":"+fldval.substring(10,12)+":"+fldval.substring(12,14);
											val=val+"'"+fldval+"',";

										}else{
											val=val+"null,";
										}	
									}else{
										val=val+"'"+fldval+"',";
										if(fldnm.equalsIgnoreCase("NAME_HOS")) hosname=fldval;
									}
									
								}else if(tval.equals("INTEGER") || tval.equals("NUMERIC") ||tval.equals("FLOAT")) {
								
									if(fldval.compareToIgnoreCase("\n")!=0 && fldval.compareToIgnoreCase("\r")!=0)
								       val=val+fldval+",";
									else	val=val+"null,";
								}else val=val+"'"+fldval+"',";
									
							}else{
	  							val=val+"null,";
	 						}	
						}// if key
							
	                } // end else
	                
	                
				} // while
				
				fieldname=fieldname+"serno ";
				val=val+frmserno;
				
				//fieldname=fieldname.substring(0,fieldname.length()-1);
				//System.out.println("^^^^"+val+"^^");
				//val=val.substring(0,val.length()-1);
				
				fieldname="insert into "+tname+"("+fieldname+") ";
				val="values("+val+")";
				isql=fieldname+val;
				
				if(tname.equalsIgnoreCase("prs") || tname.equalsIgnoreCase("tsr"))
					delqr="delete from "+tname+" where pat_id = '" +  rpatid +"' and name_hos = '"+ hosname +"' and serno = '"+ frmserno +"' and entrydate = '"+ edate + "'";
				else
					delqr="delete from "+tname+" where pat_id = '"+ rpatid +"' and serno = '"+ frmserno +"' and entrydate = '"+ edate +"'";
					
				lfrmsql="insert into listofforms (pat_id,type,date,serno,sent) values('"+rpatid+"','"+tname+"','"+edate+"',"+frmserno+",'N')";
				delqrfl="delete from listofforms where pat_id = '"+ rpatid +"' and type = '"+ tname +"' and serno = '"+frmserno +"'";
				
				br.close();
				fis.close();
								
				}catch(IOException e)
				{
						System.out.println("Error in reading");
				}
				
				ExecuteSql(delqr);
				ExecuteSql(isql);
				ExecuteSql(delqrfl);
				ExecuteSql(lfrmsql);

				boolean f1=frmfile[j].delete();       // deleteting the form files
				//System.out.println("isql is :"+isql);
				fieldname="";
				val="";
				
			} //end of for loop
			boolean d1=allfile.delete(); //deleting the forms folder
			System.out.println("DEL : "+d1);
			} // end of isDirectory
			
	} //end of updateforms function
	

private void updateimages(File dirimg) {
	
	String fieldname="",val="",fname="",typ="",imgserno="",ext="",fn="",imgpatid="",imgdir="",etydate="";
	String markserno="",refcode="";
		
	imgdir=dirimg.getName();
	boolean flag=true;
	try{
						
	if(dirimg.isDirectory())
	{
		File imgfile[]=dirimg.listFiles();
				
		for(int j=0;j<imgfile.length;j++)
		{
		String ifnam="";
		fname=imgfile[j].getName();
		System.out.println("** updateimages images Name :"+fname);
		
		flag = true;
		
		String Extension=fname.substring(fname.lastIndexOf("."));
		System.out.println("==images Extension :"+Extension);
		
        if(imgdir.equalsIgnoreCase("docs"))
		{
			if(Extension.equalsIgnoreCase(".txt")){
				
				String endofname = fname.substring(fname.lastIndexOf(".")-3,fname.lastIndexOf("."));
				System.out.println("==images endofname :"+endofname);
				//if(!endofname.equalsIgnoreCase("txt")) flag = false;
				
				}
		}
				
		
		
		if(flag==true)
		{
			if(Extension.equalsIgnoreCase(".txt")){
				
				System.out.println("==images flag=true Extension :"+Extension);
				
				FileReader fis = new FileReader(imgfile[j]);
				BufferedReader br = new BufferedReader (fis);
				imgpatid=fname.substring(0,18);
				etydate=fname.substring(18,32);
				etydate=etydate.substring(4,8)+"/"+etydate.substring(2,4)+"/"+etydate.substring(0,2)+" "+etydate.substring(8,10)+":"+etydate.substring(10,12)+":"+etydate.substring(12,14);
				typ=fname.substring(32,35);
				imgserno=fname.substring(35,37);
				
				System.out.println("imgpatid:"+imgpatid);
				System.out.println("etydate  :"+etydate);
				System.out.println("typ  :"+typ);
				System.out.println("imgserno  :"+imgserno);
				
				if(imgdir.equals("refimages")){
					refcode=fname.substring(37,45);
					markserno=fname.substring(45,47);
					System.out.println("refcode n:"+refcode);
					System.out.println("markserno n :"+markserno);
				}
							
					try{
						//
                        String line = br.readLine();
                        line=line+"xx";
                        String StrSplit[]=line.split("#");
                        String Image_Desc = StrSplit[0].trim();
						String Lab_Name = StrSplit[1].trim();
						String Doc_Name = StrSplit[2].trim();
                        String Form_Key = StrSplit[3].trim();
                        if(Form_Key.equalsIgnoreCase("")) Form_Key="null";                        						
						
						line = br.readLine();
						
						String tstdt=line.substring(line.indexOf(":")+1);
						tstdt=tstdt.substring(4,8)+"-"+tstdt.substring(2,4)+"-"+tstdt.substring(0,2)+" "+tstdt.substring(8,10)+":"+tstdt.substring(10,12)+":"+tstdt.substring(12,14);
						line = br.readLine();
						String Cont_Type =line.substring(line.indexOf(":")+1).trim();
						br.close();
						fis.close();
							
						System.out.println("Image_Desc:"+Image_Desc);
						System.out.println("Lab_Name:"+Lab_Name);
						System.out.println("Doc_Name:"+Doc_Name);
						System.out.println("Form_Key  :"+Form_Key);
						System.out.println("tstdt  :"+tstdt);
						System.out.println("Cont_Type:"+Cont_Type);
						
						//System.out.println(" Org ifnam  :"+ifnam);
									
						ifnam=imgfile[j].getAbsolutePath();
						ifnam = ifnam.substring(0,ifnam.length()-4);
						File f = new File(ifnam);
												
						System.out.println("******** File Exists : "+ifnam+":"+f.exists());
						
						if(f.exists()){
							
							ext=ifnam.substring(ifnam.lastIndexOf(".")+1);
							
							System.out.println("===ext:"+ext);
							
							InputStream is = new FileInputStream(ifnam);
							byte b[] = new byte[ (int) f.length()];
							
							System.out.println(" f.length():"+f.length());

							long fsize=f.length() /1024;
							is.read(b);
							is.close();
							String isql="",delqr="";
							
							if(imgdir.equals("images")){
								
								isql="insert into patimages (pat_id,ext,type,imgdesc,lab_name,doc_name,formkey,testdate,entrydate,serno,size,con_type,sent,patpic) values ( ";
								isql=isql+"'"+imgpatid+"','"+ext+"','"+typ+"','"+Image_Desc+"','"+Lab_Name+"','"+Doc_Name+"',"+Form_Key+",'"+tstdt+"','"+etydate+"',"+imgserno+","+fsize+",'"+Cont_Type+"','N',?)";
								delqr="delete from patimages where pat_id = '"+imgpatid+"' and type = '"+typ+"' and entrydate = '"+ etydate+"' and serno ="+ imgserno ;	
							
							}
							
							if(imgdir.equals("docs")){
							
							isql="insert into patdoc (pat_id,ext,type,docdesc,lab_name,doc_name,testdate,entrydate,serno,size,con_type,sent,patdoc) values ( ";
							isql=isql+"'"+imgpatid+"','"+ext+"','"+typ+"','"+Image_Desc+"','"+Lab_Name+"','"+Doc_Name+"','"+tstdt+"','"+etydate+"',"+imgserno+","+fsize+",'"+Cont_Type+"','N',?)";
							delqr="delete from patdoc where pat_id = '"+imgpatid+"' and type = '"+typ+"' and entrydate = '"+ etydate+"' and serno ="+ imgserno ;	
							
							}
							if(imgdir.equals("movies")){
							isql="insert into patmovies (pat_id,ext,type,movdesc,lab_name,doc_name,formkey,testdate,entrydate,serno,size,con_type,sent,patmov) values ( ";
							isql=isql+"'"+imgpatid+"','"+ext+"','"+typ+"','"+Image_Desc+"','"+Lab_Name+"','"+Doc_Name+"',"+Form_Key+",'"+tstdt+"','"+etydate+"',"+imgserno+","+fsize+",'"+Cont_Type+"','N',?)";
							delqr="delete from patmovies where pat_id = '"+imgpatid+"' and type = '"+typ+"' and entrydate = '"+ etydate+"' and serno ="+ imgserno ;	
							}
							if(imgdir.equals("refimages")){						
							isql="insert into refimages (pat_id,ext,type,imgdesc,ref_code,lab_name,doc_name,testdate,entrydate,serno,img_serno,size,con_type,sent,patpic) values ( ";
							isql=isql+"'"+imgpatid+"','"+ext+"','"+typ+"','"+Image_Desc+"','"+refcode+"','"+Lab_Name+"','"+Doc_Name+"','"+tstdt+"','"+etydate+"',"+imgserno+","+markserno+","+fsize+",'"+Cont_Type+"','N',?)";
							delqr="delete from refimages where pat_id = '"+imgpatid+"' and type = '"+typ+"' and entrydate = '"+ etydate+"' and serno ="+ imgserno + " and ref_code = '"+ refcode + "' and img_serno = "+ markserno;
							}
							
							System.out.println(isql);
							System.out.println("\n"+delqr);
							ExecuteSql(delqr);
							ExecuteImage(isql,b);

							boolean imgf=f.delete();
							boolean desft=imgfile[j].delete();
						}
						
						}catch(Exception e){
						System.out.println("Error in reading :" + e.toString());
					}

			}// if txt
			
			} // flag
			
			}// end for
			
			} // if dirimg
			
			boolean d2=dirimg.delete();
			
			}catch(Exception e){
				System.out.println("updateimages :" + e.toString());
			}	
			
	
 } //end of updateimages function

	

	public String ExecuteImage(String isql,byte[] img) {	
			String ans="Error";
			Connection conn = null;		
			PreparedStatement pstmt = null;				 		 			
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				pstmt = conn.prepareStatement(isql);
				pstmt.setBytes(1,img);		
				pstmt.executeUpdate();				
				conn.close();
				ans="Done";
			}
			catch (Exception e) {
				System.out.println("Error found 1" + e.toString());
				System.out.println("isql " + isql);	
				ans="Error";
			}
			
			return ans;
}
			
	
	
 public String FieldTypesmeta(String isql)
		{
			Connection conn = null;
			Statement stmt = null;
			ResultSet rset = null;
			String str="";
			ResultSetMetaData metadata = null;
			int numcols=0;
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(isql);
				metadata = rset.getMetaData();
  				numcols = metadata.getColumnCount();
			}catch (Exception e) {
				System.out.println("Error found 2.1" + e.toString()+isql);	
				str=e.toString();
			}
  				try{
				for ( int i = 1 ; i <= numcols ; i++ )
				str = str + metadata.getColumnName(i) + "="+metadata.getColumnTypeName(i)+"&";
				rset.close();
				stmt.close();
				conn.close();
				//System.out.println(str);
			}
			catch (Exception e) {
				System.out.println("Error found 2" + e.toString());	
				str=e.toString();		
			}
			return str;
		}
		
	public String ExecuteSql(String isql)
	{			
			String ans="Error";
			Connection conn = null;
			Statement stmt = null;
			try {
				Class.forName(pinfo.gbldbjdbccriver);
				conn = DriverManager.getConnection(pinfo.gbldburl,pinfo.gbldbusername,pinfo.gbldbpasswd);
				stmt = conn.createStatement();
				stmt.executeUpdate(isql);
				stmt.close();
				conn.close();
				ans="Done";
				
			}
			catch (Exception e) {
				System.out.println("Error found 1**:" + e.toString()+isql);	
				ans="Error";	
			}
		return ans;
	}
	
	
	
}
