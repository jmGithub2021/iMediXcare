package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;
import java.io.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.DOMException;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;

public class rcGenOperations{
	
	private static dbGenOperationsInterface server=null;
	private Registry registry;
	projinfo proj;
	String home;
	public rcGenOperations(String p){
	   try{
   	   // value will be read from file;
   	   home=p;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   server= (dbGenOperationsInterface)(registry.lookup("GenOperation"));
	   	   	      	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
			
		
	public Object findRecords(String tname, String flds, String cond) throws RemoteException,SQLException{
		 Object res = server.findRecords(tname,flds,cond);
 	     return res;
	}
				
    public String  FindCount(String table,String cond )throws RemoteException,SQLException{
       return server.FindCount(table,cond);
    }
    
    public String  FindCount(String table)throws RemoteException,SQLException{
       return server.FindCount(table);
    }
    
    public String  getAnySingleValue(String tname, String fld, String cond)throws RemoteException,SQLException{
		return server.getAnySingleValue(tname,fld,cond);
	} 
    
    public int  saveAnyInfo(dataobj obj)throws RemoteException,SQLException{
      	return server.saveAnyInfo(obj);
    }
    
     public int  saveAnyInfo(dataobj obj,String prmkey)throws RemoteException,SQLException{
      	return server.saveAnyInfo(obj,prmkey);
    }
    
    public int  updateAppDate(dataobj obj)throws RemoteException,SQLException{
    	return server.updateAppDate(obj);
    }

    public String  compStudy(String pid,String repid)throws RemoteException,SQLException{
		String repeat = "", title = "", tabnam = "", fldnam = "", value="", str1=""; 
    	String output="";
    	String head="";
    	String body="";
        	
    	try{
    	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Document doc = db.parse (new File("data_templates/comparative_pattern.xml"));
		Document doc = db.parse (new File(home+"/displaylayout/data_templates/comparative_pattern.xml"));
		doc.normalize();

	//	System.out.println("**getMainMenu getDocumentURI="+doc.getDocumentURI());
	//	output = doc.getDocumentURI() + "<br>";
	//	output+="Root element of the doc is :" + doc.getDocumentElement().getNodeName()+"<br>";
		NodeList ListOfTable = doc.getElementsByTagName("table");		
//		System.out.println(">>ListOfTable >>:"+ListOfTable.getLength());
		
	    for(int i=0;i<ListOfTable.getLength();i++ ){
	    	
	    	Node Table = ListOfTable.item(i);
	    	NamedNodeMap attmap = Table.getAttributes();
	    	String mapid=attmap.getNamedItem("id").getNodeValue();
	    	
	    	if(repid.equalsIgnoreCase(mapid)){
	   // 		System.out.println(">>mapid :"+mapid + " >> " + attmap.getLength());
	    	
	    		
	    	     title = attmap.getNamedItem("caption") != null ? attmap.getNamedItem("caption").getNodeValue() : "";
                 tabnam = attmap.getNamedItem("table_name") != null ? attmap.getNamedItem("table_name").getNodeValue() : "";

//				 System.out.println("title :"+title + " tabnam :" +tabnam);
	    		
				NodeList AllRow = Table.getChildNodes();
//				System.out.println("AllRow :"+AllRow.getLength());
				
				for(int j=0;j<AllRow.getLength();j++){
					Node row = AllRow.item(j);
	//				System.out.println("row :"+row.getNodeName());

					if(row.hasAttributes()==true){
					
						NamedNodeMap rowAttrList = row.getAttributes();
						
//						System.out.println("row 1:"+row.getNodeName() +">>"+ rowAttrList.getLength() );
					//	if(rowAttrList.getLength()>0){
						
						int[][] range = new int[ row.getChildNodes().getLength()][2];
						
//						System.out.println("row.getChildNodes().getLength() :"+row.getChildNodes().getLength());
						
                        repeat = rowAttrList.getNamedItem("repeat") != null ? rowAttrList.getNamedItem("repeat").getNodeValue() : "";
  //                      System.out.println("repeat :"+repeat);
                        
                        fldnam = "";
                        NodeList AllCol = row.getChildNodes();
  //                      System.out.println("AllCol Ln :"+AllCol.getLength());
                        int x=0;
                        // body+="<tr>";
                        for(int k=0;k<AllCol.getLength();k++){
                        	Node col = AllCol.item(k);
                        	if(col.hasAttributes()==true){
                        	
                        	NamedNodeMap colAttrList = col.getAttributes();
                        	fldnam += "," + (colAttrList.getNamedItem("field_name") != null ? colAttrList.getNamedItem("field_name").getNodeValue().trim() : "");
                            str1 = colAttrList.getNamedItem("normal_range") != null ? colAttrList.getNamedItem("normal_range").getNodeValue().trim() : "";
                            //output+=str1+"<br>";
                            if (!str1.equalsIgnoreCase("")){
                                    String [] str2=str1.split("-");
                                    range[x][0] = Integer.parseInt(str2[0]);
                                    range[x][1] = Integer.parseInt(str2[1]);
                            }else{
                                    range[x][0] = 0;
                                    range[x][1] = 0;
                            }
                            //output+=x+">>>"+range[x][0]+"-"+range[x][1]+"<br>";
                            //if(x==0) body+="<td align = 'center'>Normal Range</td>"; 
                           // else 
                          //  body+="<td align = 'center'>"+range[x][0]+"-"+range[x][1]+"</td>";
                            x++;
                            }//if
                        }// end k
                         //body+="</tr>";   
                         
                            fldnam = fldnam.substring(1);
						    String cond=" pat_id = '"+ pid +"' ORDER BY " + repeat + " desc";
//						    System.out.println("cond :"+cond);
						    
							Table.getAttributes().removeNamedItem("id");
							Table.getAttributes().removeNamedItem("caption");
							Table.getAttributes().removeNamedItem("table_name");
                            Table.removeChild(row);
                            
                            Object res = findRecords(tabnam,fldnam,cond);
                            
                            Vector tmpv = (Vector)res;	
							for(int ii=0;ii<tmpv.size();ii++){
								dataobj tmpdata = (dataobj) tmpv.get(ii);	
								//Element eletr=doc.createElement("tr");
								body+="<tr>";
								
								for(int jj=0;jj<tmpdata.getLength();jj++){
									//Element eletd=doc.createElement("td");
								
									if(tmpdata.getKey(jj).equalsIgnoreCase("testdate")){
										String pdt=tmpdata.getValue(jj);
										value=pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4); 
									}else  value=tmpdata.getValue(jj);
									
								//	body+="<td ";
																				
									if (!value.equals("")){
																				
										if (range[jj][0] > 0 || range[jj][1] > 0){
											body+="<td align = 'center' ";
												
										//	eletd.Attributes.Append(xmldoc.CreateAttribute("style"));
										//	eletd.getAttributes().setNamedItem(doc.createAttribute("style"));
										
											if (Integer.parseInt(value)<range[jj][0]){
												body+=" style='background-color:#CCFFCC'>";
											}

											//	eletd.getAttributes().getNamedItem("style").setNodeValue("background-color:#CCFFCC");
											else if (Integer.parseInt(value)>range[jj][1]){
													body+=" style='background-color:#FF0000'>";
											
											}								
											
											//	eletd.getAttributes().getNamedItem("style").setNodeValue("background-color:#FF0000");
                                            else{
                                            	 body+=" style='background-color:#FFFFFF'>";
                                             	
                                            }
                                           
                                            //	eletd.getAttributes().getNamedItem("style").setNodeValue("background-color:#FFFFFF");
										}else body+="<td align = 'center'>";
										if(jj==0) body+= value+ "</td>";
										else body+="<a Title ='"+range[jj][0]+"-"+range[jj][1]+"' >"+value+ "</a></td>";
								             	  
									//	Table.setTextContent(value);                                    
									
									}else body+="<td align = 'center' >-</td>";

								//	Table.appendChild(eletd);
										
								} // end jj
									body+="</tr>";
							//	Table.appendChild(eletr);
								
							} // end ii                        	                       
					}else{
						
                        NodeList ACol = row.getChildNodes();
                        //System.out.println("row.getNodeName() :>>>>>>>>>"+row.getNodeName());
                       // System.out.println("ACol Ln :"+ACol.getLength());
                        if(ACol.getLength()>0){
                           head+="<tr>";
                           int x=0;
	                        for(int m=0;m<ACol.getLength();m++){
	                        	Node col=ACol.item(m);
	                        	if(col.hasAttributes()==true){
	                        		//head+="<td>"+col.getAttributes().getNamedItem("caption").getNodeValue()+"</td>"
									head+="<td >"+col.getAttributes().getNamedItem("caption").getNodeValue()+"</td>";
	                        		
	                        		//row.getChildNodes().item(m).setTextContent(col.getAttributes().getNamedItem("caption").getNodeValue());
	                        		//row.getChildNodes().item(m).getAttributes().removeNamedItem("caption");
	                        	}
	                        }
                        head+="</tr>";
                        }
				   }
				   
				}// end for j
				
				//System.out.println("Table.getTextContent() :"+Table.getTextContent());
				//System.out.println("Table.getPrefix(); :"+Table.getPrefix());
				System.out.println("BODY='"+body+"'");
	    		output += "<br><center><h3>" + title + "</h3></center>";
	    		
	    		if(body.trim().equals("")){
	    			output += "<br> <font size ='5' color ='red'> <center>Data Not Available</center> </font>";
	    		}else{
		    		output += "<center><table bordercolor='BLUE' border=2 CELLSPACING=0 CELLPADDING=4 >" + head + body+"</table></center>";
	                output += "<br><center><table border='0'>";
	                output += "<tr><td width='20' style='border:1px solid black;background-color:#CCFFCC'>&nbsp;</td><td style='padding-left:10px'>Below Normal</td></tr>";
	                output += "<tr><td width='20' style='border:1px solid black;background-color:#FF0000'>&nbsp;</td><td style='padding-left:10px'>Above Normal</td></tr>";
	                output += "<tr><td width='20' style='border:1px solid black;background-color:#FFFFFF'>&nbsp;</td><td style='padding-left:10px'>Normal</td></tr>";
	                output += "<tr><td colspan='2'>Place the cursor on the value to view the normal range.</td></tr>";
	                output += "</table></center>";
	    		}
	    		
	    	}// endif  	
	    	
	    }// end for i

    	}catch(Exception e){
				System.out.println(e.toString());
			output+=e.toString();
	   }// end try
   
    return output;
    }
    
    
    public String  reviewSystem(String pid)throws RemoteException,SQLException{
		String repeat = "", title = "", tabnam = "", fldsnam = "", value="", str1=""; 
    	String output="";
    	String head="";
    	String body="";
        String bg="";
        		
    	try{
    	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Document doc = db.parse (new File("data_templates/comparative_pattern.xml"));
		Document doc = db.parse (new File(home+"/displaylayout/data_templates/reviewsystem_pattern.xml"));
		doc.normalize();

	//	System.out.println("**getMainMenu getDocumentURI="+doc.getDocumentURI());
	//	output = doc.getDocumentURI() + "<br>";
	//	output+="Root element of the doc is :" + doc.getDocumentElement().getNodeName()+"<br>";
		NodeList ListOfTable = doc.getElementsByTagName("table");		
	//	System.out.println(">>ListOfTable >>:"+ListOfTable.getLength());
		
	    for(int i=0;i<ListOfTable.getLength();i++ ){
	    	
	    	Node Table = ListOfTable.item(i);
	    	NamedNodeMap attmap = Table.getAttributes();
	    	String mapid=attmap.getNamedItem("id").getNodeValue();
	    	
   	     	title = attmap.getNamedItem("caption") != null ? attmap.getNamedItem("caption").getNodeValue() : "";
            tabnam = attmap.getNamedItem("table_name") != null ? attmap.getNamedItem("table_name").getNodeValue() : "";
            fldsnam = attmap.getNamedItem("fld_list") != null ? attmap.getNamedItem("fld_list").getNodeValue() : "";
		
			//System.out.println("title :"+title + " tabnam :" +tabnam);
			
			NodeList AllRow = Table.getChildNodes();
			//System.out.println("AllRow :"+AllRow.getLength());
			head="";
			for(int j=0;j<AllRow.getLength();j++){
				
				Node row = AllRow.item(j);
			//	System.out.println("row :"+row.getNodeName());
				 NodeList ACol = row.getChildNodes();
                        if(ACol.getLength()>0){
                           head+="<tr class='head'>";
                           int x=0;
	                        for(int m=0;m<ACol.getLength();m++){
	                        	Node col=ACol.item(m);
	                        	if(col.hasAttributes()==true){
									head+="<td >"+col.getAttributes().getNamedItem("caption").getNodeValue()+"</td>";
	                        	}
	                        }
                        head+="</tr>";
                 }                
                  String cond=" pat_id = '"+ pid +"' ORDER BY entrydate desc";
				//  System.out.println("cond :"+cond);
                //  System.out.println("tabnam='"+tabnam+"'");
                //  System.out.println("cond='"+cond+"'");
                  Object res = findRecords(tabnam,fldsnam,cond);
                  Vector tmpv = (Vector)res;	
                  for(int ii=0;ii<tmpv.size();ii++){
						dataobj tmpdata = (dataobj) tmpv.get(ii);	
							
								if(bg.equalsIgnoreCase("tab3")) bg= "tab4";
								else bg= "tab3";
								
								body+="<tr class='"+bg+"'>";
								
								for(int jj=0;jj<tmpdata.getLength();jj++){
									
									if(tmpdata.getKey(jj).equalsIgnoreCase("pain") && tabnam.equalsIgnoreCase("a41")){
										String painTxt =tmpdata.getValue("pain");
										String pain=painTxt.toLowerCase().replace(" ","_")+".jpg";
										value="<IMG SRC='./../images/pain/"+pain+"' WIDTH='60' HEIGHT='60' ALT='Pain'>";
										
										value="<a href='#' title='"+ painTxt + "'> <IMG SRC='./../images/pain/"+pain+"' WIDTH='60' HEIGHT='60' ALT='Pain'> </a>";
											
									}else{
										if(tmpdata.getKey(jj).equalsIgnoreCase("testdate")){
											String pdt=tmpdata.getValue(jj);
											value=pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4); 
										}else  value=tmpdata.getValue(jj);
								   }
								   
									if (!value.equals("")) body+="<td align = 'center' >"+value+"</td>";                             
									else body+="<td align = 'center' >-</td>";
								} // end jj
							} // end  for ii                        	                       
				}// end for j
		
				
	    		output += "<br><center><FONT SIZE='5pt' COLOR='#3300CC'><B>" + title + "</B></FONT></center>";
	    	
	    		
	    		if(body.trim().equals("")){
	    			output += "<br> <font size ='5' color ='red'> <center>Data Not Available</center> </font>";
	    		}else{
		    		output += "<center><table border=1 CELLSPACING=0 CELLPADDING=4 class='tabh'>" + head + body+"</table></center>";
	    		}
	    		
	    	head="";
	    	body="";
	    	
	    }// end for i

    	}catch(Exception e){
				System.out.println(e.toString());
			output+=e.toString();
	   }// end try
   
    return output;
    }
    
     public String  getDobOfPatient(String patid )throws RemoteException,SQLException{
     	return server.getDobOfPatient(patid);
     }
     
     public String  getAgeInMonthOfPatient(String patid,String cdt )throws RemoteException,SQLException{
     	return server.getAgeInMonthOfPatient(patid,cdt);
     }
     
     public String  getAgeInDaysOfPatient(String patid,String cdt )throws RemoteException,SQLException{
     	return server.getAgeInDaysOfPatient(patid,cdt);
     }
     public String  getPatientName(String patid)throws RemoteException,SQLException{
     	return server.getPatientName(patid);
     }
     
     public String  getPatientAgeYMD(String patid,String cdt)throws RemoteException,SQLException{
     	return server.getPatientAgeYMD(patid,cdt);
     }
     
     
     // choice =="" for selectbox or "multiple" for listbox;
     public String genSelectBox(String category, String name, String choice ) throws RemoteException,SQLException{
     		String output="";
     		Object res= server.dataforGeneral(category);	
     		
     		if(choice.equalsIgnoreCase("multiple"))
                    output = "<SELECT "+choice+" NAME='" + name + "' SIZE='5' STYLE='width : 150px;'><OPTION VALUE='' selected ></OPTION>";
            else
                    output = "<SELECT NAME='" + name + "' STYLE='width : 150px;'><OPTION VALUE=''>Select</OPTION>";
     		if(res instanceof String){
				output = "<SELECT NAME='" + name + "' STYLE='width : 150px;'><OPTION VALUE=''>No Data Available</OPTION>";
			}else{
     			Vector tmp = (Vector)res;
     			for(int i=0;i<tmp.size();i++){
					dataobj temp = (dataobj) tmp.get(i);
					String tmpval=temp.getValue(1).trim(); // as per imedik coding
					output += "<OPTION VALUE='" + tmpval + "'>"+tmpval+"</OPTION>";
				}
			}
			output += "</SELECT>";
			return output;
     }
     
     public String dataforImmunization(String patid) throws RemoteException,SQLException{
 			return server.dataforImmunization(patid);
 	}
 	
 	public String getVaccineRecAge(String vacc_id) throws RemoteException,SQLException{
 			return server.getVaccineRecAge(vacc_id);
 	}
 	public boolean isTelePat(String patid, String assigneddoc) throws RemoteException,SQLException{
			return server.isTelePat(patid,assigneddoc);
	}
	public boolean uploadCOVIDdata(String patientid, String result) throws RemoteException,SQLException{
			return server.uploadCOVIDdata(patientid, result);
	}	
	public String getCOVIDdata(String patid) throws RemoteException, SQLException{
			return server.getCOVIDdata(patid);
	}	
}
